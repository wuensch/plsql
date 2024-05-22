declare

   v_tem number;
   v_sql_create_table varchar2(10000) := 'create table TRADING_BI_MM_CCEE
(
  id_simulacao NUMBER not null,
  id_produto   VARCHAR2(6) not null,
  descricao    VARCHAR2(220) not null,
  vlr          NUMBER(20,3) not null,
  id_periodo   DATE not null,
  ordem        NUMBER not null,
  user_create  VARCHAR2(30),
  date_create  VARCHAR2(20),
  user_update  VARCHAR2(30),
  date_update  VARCHAR2(20)
)';

  v_sql_create_pk varchar2(1000) := 'alter table TRADING_BI_MM_CCEE add constraint TRADING_BI_MM_CCEE_PK primary key (ID_SIMULACAO, ID_PRODUTO, DESCRICAO, ID_PERIODO, ORDEM)';
  
  v_sql_create_fk varchar2(1000) := 'alter table TRADING_BI_MM_CCEE add constraint TRADING_BI_MM_CCEE_FK_SIM foreign key (ID_SIMULACAO) references TRADING_BI_SIMULACAO (ID_SIMULACAO)';
   
begin
  
  --Verifica se a tabela existe
  select count(1)
    into v_tem
  from user_tables
  where table_name = 'TRADING_BI_MM_CCEE';
  
  if v_tem > 0 then
    execute immediate ('drop table TRADING_BI_MM_CCEE purge');
  end if;
  
  -- Create table
  execute immediate v_sql_create_table;
  
 -- Create/Recreate primary, unique and foreign key constraints 
 execute immediate v_sql_create_pk;
 
  execute immediate v_sql_create_fk;  
  
end;
/
-- Add comments to the columns 
comment on column TRADING_BI_MM_CCEE.id_simulacao is 'Identificação da simulação';
comment on column TRADING_BI_MM_CCEE.id_produto is 'Identificação do produto';
comment on column TRADING_BI_MM_CCEE.descricao is 'Descrição perfil CCEE';
comment on column TRADING_BI_MM_CCEE.vlr is 'Valor';
comment on column TRADING_BI_MM_CCEE.id_periodo is 'Período';
comment on column TRADING_BI_MM_CCEE.ordem is 'Ordem de exibição';
comment on column TRADING_BI_MM_CCEE.user_create is 'Usuário da criação do registro';
comment on column TRADING_BI_MM_CCEE.date_create is 'Data da criação do registro';
comment on column TRADING_BI_MM_CCEE.user_update is 'Usuário da atualização do registro';
comment on column TRADING_BI_MM_CCEE.date_update is 'Data da atualização do registro';

-- Grant/Revoke object privileges 
grant select on TRADING_BI_MM_CCEE to APEX_DLINK;
