-- MySQL Script generated by MySQL Workbench
-- Sun Jul 16 11:13:47 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema cinema
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `cinema` DEFAULT CHARACTER SET utf8 ;
USE `cinema` ;

-- -----------------------------------------------------
-- Table `cinema`.`Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Filme` (
  `idFilme` INT NOT NULL AUTO_INCREMENT,
  `nomePTBR` VARCHAR(40) NOT NULL,
  `nomeOriginal` VARCHAR(45) NULL,
  `sinopse` LONGTEXT NOT NULL,
  `anoLancamento` INT NOT NULL,
  PRIMARY KEY (`idFilme`));


-- -----------------------------------------------------
-- Table `cinema`.`Indicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Indicacao` (
  `idIndicacao` INT NOT NULL AUTO_INCREMENT,
  `tituloIndicacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idIndicacao`));


-- -----------------------------------------------------
-- Table `cinema`.`Premiacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Premiacao` (
  `idPremiacao` INT NOT NULL,
  `tituloPremiacao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPremiacao`));


-- -----------------------------------------------------
-- Table `cinema`.`Filme_has_Indicacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Filme_has_Indicacao` (
  `Indicacao_idIndicacao` INT NOT NULL,
  `Filme_idFilme` INT NOT NULL,
  PRIMARY KEY (`Indicacao_idIndicacao`, `Filme_idFilme`),
    FOREIGN KEY (`Indicacao_idIndicacao`)
    REFERENCES `cinema`.`Indicacao` (`idIndicacao`),
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `cinema`.`Filme` (`idFilme`));


-- -----------------------------------------------------
-- Table `cinema`.`Diretor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Diretor` (
  `idDiretor` INT NOT NULL AUTO_INCREMENT,
  `nomeDiretor` VARCHAR(45) NULL,
  PRIMARY KEY (`idDiretor`));


-- -----------------------------------------------------
-- Table `cinema`.`Ator`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Ator` (
  `idAtor` INT NOT NULL AUTO_INCREMENT,
  `nomeAtor` VARCHAR(45) NULL,
  PRIMARY KEY (`idAtor`));


-- -----------------------------------------------------
-- Table `cinema`.`Diretor_has_Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Diretor_has_Filme` (
  `Diretor_idDiretor` INT NOT NULL,
  `Filme_idFilme` INT NOT NULL,
  PRIMARY KEY (`Diretor_idDiretor`, `Filme_idFilme`),
    FOREIGN KEY (`Diretor_idDiretor`)
    REFERENCES `cinema`.`Diretor` (`idDiretor`),
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `cinema`.`Filme` (`idFilme`));


-- -----------------------------------------------------
-- Table `cinema`.`Sala`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Sala` (
  `nomeSala` VARCHAR(45) NOT NULL,
  `capacidade` INT NULL,
  `idSala` INT NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`idSala`));


-- -----------------------------------------------------
-- Table `cinema`.`Sala_has_Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Sala_has_Filme` (
  `Filme_idFilme` INT NOT NULL,
  `horario` TIME NOT NULL,
  `Sala_idSala` INT NOT NULL,
  PRIMARY KEY (`Filme_idFilme`, `horario`, `Sala_idSala`),
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `cinema`.`Filme` (`idFilme`),
    FOREIGN KEY (`Sala_idSala`)
    REFERENCES `cinema`.`Sala` (`idSala`));


-- -----------------------------------------------------
-- Table `cinema`.`Funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Funcao` (
  `idFuncao` INT NOT NULL,
  `nomeFuncao` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idFuncao`));


-- -----------------------------------------------------
-- Table `cinema`.`Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Funcionario` (
  `numeroCarteiraTrabalho` VARCHAR(20) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `dataAdmissao` DATETIME NULL,
  `salario` FLOAT NULL,
  `tempoDeExperiência` INT NULL,
  PRIMARY KEY (`numeroCarteiraTrabalho`));

-- -----------------------------------------------------
-- Table `cinema`.`Funcionario_has_Funcao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Funcionario_has_Funcao` (
  `Funcionario_numeroCarteiraTrabalho` VARCHAR(20) NOT NULL,
  `Funcao_idFuncao` INT NOT NULL,
  PRIMARY KEY (`Funcionario_numeroCarteiraTrabalho`, `Funcao_idFuncao`),
    FOREIGN KEY (`Funcionario_numeroCarteiraTrabalho`)
    REFERENCES `cinema`.`Funcionario` (`numeroCarteiraTrabalho`),
    FOREIGN KEY (`Funcao_idFuncao`)
    REFERENCES `cinema`.`Funcao` (`idFuncao`));


-- -----------------------------------------------------
-- Table `cinema`.`Filme_has_Premiacao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Filme_has_Premiacao` (
  `Filme_idFilme` INT NOT NULL,
  `Premiacao_idPremiacao` INT NOT NULL,
  PRIMARY KEY (`Filme_idFilme`, `Premiacao_idPremiacao`),
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `cinema`.`Filme` (`idFilme`),
    FOREIGN KEY (`Premiacao_idPremiacao`)
    REFERENCES `cinema`.`Premiacao` (`idPremiacao`));


-- -----------------------------------------------------
-- Table `cinema`.`Sala_has_Filme_has_Funcionario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Sala_has_Filme_has_Funcionario` (
  `Funcionario_numeroCarteiraTrabalho` VARCHAR(20) NOT NULL,
  `Sala_has_Filme_Filme_idFilme` INT NOT NULL,
  `Sala_has_Filme_horario` TIME NOT NULL,
  `Sala_has_Filme_Sala_idSala` INT NOT NULL,
  PRIMARY KEY (`Funcionario_numeroCarteiraTrabalho`, `Sala_has_Filme_Filme_idFilme`, `Sala_has_Filme_horario`, `Sala_has_Filme_Sala_idSala`),
    FOREIGN KEY (`Funcionario_numeroCarteiraTrabalho`)
    REFERENCES `cinema`.`Funcionario` (`numeroCarteiraTrabalho`),
    FOREIGN KEY (`Sala_has_Filme_Filme_idFilme` , `Sala_has_Filme_horario` , `Sala_has_Filme_Sala_idSala`)
    REFERENCES `cinema`.`Sala_has_Filme` (`Filme_idFilme` , `horario` , `Sala_idSala`));


-- -----------------------------------------------------
-- Table `cinema`.`Ator_has_Filme`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `cinema`.`Ator_has_Filme` (
  `Ator_idAtor` INT NOT NULL,
  `Filme_idFilme` INT NOT NULL,
  PRIMARY KEY (`Ator_idAtor`, `Filme_idFilme`),
    FOREIGN KEY (`Ator_idAtor`)
    REFERENCES `cinema`.`Ator` (`idAtor`),
    FOREIGN KEY (`Filme_idFilme`)
    REFERENCES `cinema`.`Filme` (`idFilme`));
