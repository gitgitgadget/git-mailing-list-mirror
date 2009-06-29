From: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
Subject: [PATCH 2/2] Translate the tutorial to Brazillian Portuguese.
Date: Mon, 29 Jun 2009 11:05:58 -0300
Message-ID: <1246284358-26491-1-git-send-email-cascardo@holoscopio.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thadeu Lima de Souza Cascardo <cascardo@holoscopio.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 29 16:14:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLHdK-0004Mx-6q
	for gcvg-git-2@gmane.org; Mon, 29 Jun 2009 16:14:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757010AbZF2OOt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Jun 2009 10:14:49 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754709AbZF2OOq
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jun 2009 10:14:46 -0400
Received: from liberdade.minaslivre.org ([72.232.18.203]:34684 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759570AbZF2OOj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jun 2009 10:14:39 -0400
Received: from vespa.holoscopio.com (unknown [201.80.130.87])
	by liberdade.minaslivre.org (Postfix) with ESMTPSA id 46BD219834A;
	Mon, 29 Jun 2009 11:16:16 -0300 (BRT)
Received: by vespa.holoscopio.com (Postfix, from userid 1000)
	id 42913C580; Mon, 29 Jun 2009 11:06:00 -0300 (BRT)
X-Mailer: git-send-email 1.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122440>

---
 Documentation/pt/gittutorial.txt |  679 ++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 679 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/pt/gittutorial.txt

diff --git a/Documentation/pt/gittutorial.txt b/Documentation/pt/gittut=
orial.txt
new file mode 100644
index 0000000..25bee03
--- /dev/null
+++ b/Documentation/pt/gittutorial.txt
@@ -0,0 +1,679 @@
+gittutorial(7)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+NAME
+----
+gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (para vers=C3=
=A3o 1.5.1 ou mais nova)
+
+SYNOPSIS
+--------
+git *
+
+DESCRIPTION
+-----------
+
+Este tutorial explica como importar um novo projeto para o git,
+adicionar mudan=C3=A7as a ele, e compartilhar mudan=C3=A7as com outros
+desenvolvedores.
+
+If, ao inv=C3=A9s disso, voc=C3=AA est=C3=A1 interessado primariamente=
 em usar git para
+obter um projeto, por exemplo, para testar a =C3=BAltima vers=C3=A3o, =
voc=C3=AA pode
+preferir come=C3=A7ar com os primeiros dois cap=C3=ADtulos de
+link:user-manual.html[O Manual do Usu=C3=A1rio Git].
+
+Primeiro, note que voc=C3=AA pode obter documenta=C3=A7=C3=A3o para um=
 comando como
+`git log --graph` com:
+
+------------------------------------------------
+$ man git-log
+------------------------------------------------
+
+ou:
+
+------------------------------------------------
+$ git help log
+------------------------------------------------
+
+Com a =C3=BAltima forma, voc=C3=AA pode usar o visualizador de manual =
de sua
+escolha; veja linkgit:git-help[1] para maior informa=C3=A7=C3=A3o.
+
+=C3=89 uma boa id=C3=A9ia se introduzir ao git com seu nome e endere=C3=
=A7o p=C3=BAblico de
+email antes de fazer qualquer opera=C3=A7=C3=A3o. A maneira mais f=C3=A1=
cil de faz=C3=AA-lo
+=C3=A9:
+
+------------------------------------------------
+$ git config --global user.name "Seu Nome Vem Aqui"
+$ git config --global user.email voce@seudominio.exemplo.com
+------------------------------------------------
+
+
+Importando um novo projeto
+-----------------------
+
+Assuma que voc=C3=AA tem um tarball project.tar.gz com seu trabalho in=
icial.
+Voc=C3=AA pode coloc=C3=A1-lo sob controle de revis=C3=A3o git como a =
seguir.
+
+------------------------------------------------
+$ tar xzf project.tar.gz
+$ cd project
+$ git init
+------------------------------------------------
+
+Git ir=C3=A1 responder
+
+------------------------------------------------
+Initialized empty Git repository in .git/
+------------------------------------------------
+
+Voc=C3=AA agora iniciou seu diret=C3=B3rio de trabalho--voc=C3=AA deve=
 ter notado um
+novo diret=C3=B3rio criado, com o nome de ".git".
+
+A seguir, diga ao git para gravar um instant=C3=A2neo do conte=C3=BAdo=
 de todos os
+arquivos sob o diret=C3=B3rio corrente (note o '.'), com 'git-add':
+
+------------------------------------------------
+$ git add .
+------------------------------------------------
+
+Este instant=C3=A2neo est=C3=A1 agora armazenado em uma =C3=A1rea temp=
or=C3=A1ria que o git
+chama de "index" ou =C3=ADndice. Voc=C3=AA pode permanetemente armazen=
ar o
+conte=C3=BAdo do =C3=ADndice no reposit=C3=B3rio com 'git-commit':
+
+------------------------------------------------
+$ git commit
+------------------------------------------------
+
+Isto vai te pedir por uma mensagem de commit. Voc=C3=AA agora gravou s=
ua
+primeira vers=C3=A3o de seu projeto no git.
+
+Fazendo mudan=C3=A7as
+--------------
+
+Modifique alguns arquivos, e, ent=C3=A3o, adicione seu conte=C3=BAdo a=
tualizado ao
+=C3=ADndice:
+
+------------------------------------------------
+$ git add file1 file2 file3
+------------------------------------------------
+
+Voc=C3=AA est=C3=A1 agora pronto para fazer o commit. Voc=C3=AA pode v=
er o que est=C3=A1
+para ser gravado usando 'git-diff' com a op=C3=A7=C3=A3o --cached:
+
+------------------------------------------------
+$ git diff --cached
+------------------------------------------------
+
+(Sem --cached, o comando 'git-diff' ir=C3=A1 te mostrar quaisquer muda=
n=C3=A7as
+que voc=C3=AA tenha feito mas ainda n=C3=A3o adicionou ao =C3=ADndice.=
) Voc=C3=AA tamb=C3=A9m
+pode obter um breve sum=C3=A1rio da situa=C3=A7=C3=A3o com 'git-status=
':
+
+------------------------------------------------
+$ git status
+# On branch master
+# Changes to be committed:
+#   (use "git reset HEAD <file>..." to unstage)
+#
+#	modified:   file1
+#	modified:   file2
+#	modified:   file3
+#
+------------------------------------------------
+
+Se voc=C3=AA precisar fazer qualquer outro ajuste, fa=C3=A7a-o agora, =
e, ent=C3=A3o,
+adicione qualquer conte=C3=BAdo modificado ao =C3=ADndice. Finalmente,=
 grave suas
+mudan=C3=A7as com:
+
+------------------------------------------------
+$ git commit
+------------------------------------------------
+
+Isto ir=C3=A1 novamente te pedir por uma mensagem descrevendo a mudan=C3=
=A7a, e,
+ent=C3=A3o, gravar a nova vers=C3=A3o do projeto.
+
+Alternativamente, ao inv=C3=A9s de executar 'git-add' antes, voc=C3=AA=
 pode usar
+
+------------------------------------------------
+$ git commit -a
+------------------------------------------------
+
+o que ir=C3=A1 automaticamente notar quaisquer arquivos modificados (m=
as n=C3=A3o
+novos), adicion=C3=A1-los ao =C3=ADndices, e gravar, tudo em um =C3=BA=
nico passo.
+
+Uma nota em mensagens de commit: Apesar de n=C3=A3o ser exigido, =C3=A9=
 uma boa
+id=C3=A9ia come=C3=A7ar a mensagem com uma simples e curta (menos de 5=
0
+caracteres) linha sumarizando a mudan=C3=A7a, seguida de uma linha em =
branco
+e, ent=C3=A3o, uma descri=C3=A7=C3=A3o mais detalhada.  Ferramentas qu=
e transformam
+commits em email, por exemplo, usam a primeira linha no campo de
+cabe=C3=A7alho Subject: e o resto no corpo.
+
+Git rastreia conte=C3=BAdo, n=C3=A3o arquivos
+----------------------------
+
+Muitos sistemas de controle de revis=C3=A3o prov=C3=AAem um comando `a=
dd` que diz
+ao sistema para come=C3=A7ar a rastrear mudan=C3=A7as em um novo arqui=
vo.  O
+comando `add` do git faz algo mais simples e mais poderoso: 'git-add' =
=C3=A9
+usado tanto para arquivos novos e arquivos recentemente modificados, e
+em ambos os casos, ele tira o instant=C3=A2neo dos arquivos dados e ar=
mazena
+o conte=C3=BAdo no =C3=ADndice, pronto para inclus=C3=A3o do pr=C3=B3x=
imo commit.
+
+Visualizando hist=C3=B3ria do projeto
+-----------------------
+
+Em qualquer ponto voc=C3=AA pode visualizar a hist=C3=B3ria das suas m=
udan=C3=A7as
+usando
+
+------------------------------------------------
+$ git log
+------------------------------------------------
+
+Se voc=C3=AA tamb=C3=A9m quer ver a diferen=C3=A7a completa a cada pas=
so, use
+
+------------------------------------------------
+$ git log -p
+------------------------------------------------
+
+Geralmente, uma vis=C3=A3o geral da mudan=C3=A7a =C3=A9 =C3=BAtil para=
 ter a sensa=C3=A7=C3=A3o de
+cada passo
+
+------------------------------------------------
+$ git log --stat --summary
+------------------------------------------------
+
+Gerenciando "branches"/ramos
+-----------------
+
+Um simples reposit=C3=B3rio git pode manter m=C3=BAltiplos ramos de
+desenvolvimento.  Para criar um novo ramo chamado "experimental", use
+
+------------------------------------------------
+$ git branch experimental
+------------------------------------------------
+
+Se voc=C3=AA executar agora
+
+------------------------------------------------
+$ git branch
+------------------------------------------------
+
+voc=C3=AA vai obter uma lista de todos os ramos existentes:
+
+------------------------------------------------
+  experimental
+* master
+------------------------------------------------
+
+O ramo "experimental" =C3=A9 o que voc=C3=AA acaba de criar, e o ramo =
"master" =C3=A9 o
+ramo padr=C3=A3o que foi criado pra voc=C3=AA automaticamente.  O aste=
risco marca
+o ramo em que voc=C3=AA est=C3=A1 atualmente; digite
+
+------------------------------------------------
+$ git checkout experimental
+------------------------------------------------
+
+para mudar para o ramo experimental.  Agora edite um arquivo, grave a
+mudan=C3=A7a, e mude de volta para o ramo master:
+
+------------------------------------------------
+(edita arquivo)
+$ git commit -a
+$ git checkout master
+------------------------------------------------
+
+Verifique que a mudan=C3=A7a que voc=C3=AA fez n=C3=A3o est=C3=A1 mais=
 vis=C3=ADvel, j=C3=A1 que ela
+foi feita no ramo experimental e voc=C3=AA est=C3=A1 de volta ao ramo =
master.
+
+Voc=C3=AA pode fazer uma mudan=C3=A7a diferente no ramo master:
+
+------------------------------------------------
+(edit file)
+$ git commit -a
+------------------------------------------------
+
+neste ponto, os dois ramos divergiram, com diferentes mudan=C3=A7as fe=
itas em
+cada um.  Para unificar as mudan=C3=A7as feitas no experimental para o
+master, execute
+
+------------------------------------------------
+$ git merge experimental
+------------------------------------------------
+
+Se as mudan=C3=A7as n=C3=A3o conflitam, est=C3=A1 pronto.  Se existire=
m conflitos,
+marcadores ser=C3=A3o deixados nos arquivos problem=C3=A1ticos exibind=
o o
+conflito;
+
+------------------------------------------------
+$ git diff
+------------------------------------------------
+
+vai exibir isto.  Ap=C3=B3s voc=C3=AA editar os arquivos para resolver=
 os
+conflitos,
+
+------------------------------------------------
+$ git commit -a
+------------------------------------------------
+
+ir=C3=A1 gravar o resultado da unifica=C3=A7=C3=A3o. Finalmente,
+
+------------------------------------------------
+$ gitk
+------------------------------------------------
+
+vai mostrar uma bela representa=C3=A7=C3=A3o gr=C3=A1fica da hist=C3=B3=
ria resultante.
+
+Neste ponto voc=C3=AA pode remover seu ramo experimental com
+
+------------------------------------------------
+$ git branch -d experimental
+------------------------------------------------
+
+Este comando garante que as mudan=C3=A7as no ramo experimental j=C3=A1=
 est=C3=A3o no
+ramo atual.
+
+Se voc=C3=AA desenvolve em um ramo ideia-louca, e se arrepende, voc=C3=
=AA pode
+sempre remover o ramo com
+
+-------------------------------------
+$ git branch -D crazy-idea
+-------------------------------------
+
+Ramos s=C3=A3o baratos e f=C3=A1ceis, ent=C3=A3o isto =C3=A9 uma boa m=
aneira de experimentar
+alguma coisa.
+
+Usando git para colabora=C3=A7=C3=A3o
+---------------------------
+
+Suponha que Alice come=C3=A7ou um novo projeto com um reposit=C3=B3rio=
 git em
+/home/alice/project, e que Bob, que tem um diret=C3=B3rio home na mesm=
a
+m=C3=A1quina, quer contribuir.
+
+Bob come=C3=A7a com:
+
+------------------------------------------------
+bob$ git clone /home/alice/project myrepo
+------------------------------------------------
+
+Isso cria um novo diret=C3=B3rio "myrepo" contendo um clone do reposit=
=C3=B3rio de
+Alice.  O clone est=C3=A1 no mesmo p=C3=A9 que o projeto original, pos=
suindo sua
+pr=C3=B3pria c=C3=B3pia da hist=C3=B3ria do projeto original.
+
+Bob ent=C3=A3o faz algumas mudan=C3=A7as e as grava:
+
+------------------------------------------------
+(editar arquivos)
+bob$ git commit -a
+(repetir conforme necess=C3=A1rio)
+------------------------------------------------
+
+Quanto est=C3=A1 pronto, ele diz a Alice para puxar as mudan=C3=A7as d=
o
+reposit=C3=B3rio em /home/bob/myrepo.  Ela o faz com:
+
+------------------------------------------------
+alice$ cd /home/alice/project
+alice$ git pull /home/bob/myrepo master
+------------------------------------------------
+
+Isto unifica as mudan=C3=A7as do ramo "master" do Bob ao ramo atual de=
 Alice.
+Se Alice fez suas pr=C3=B3prias mudan=C3=A7as no intervalo, ela, ent=C3=
=A3o, pode
+precisar corrigir manualmente quaiquer conflitos.  (Note que o argumen=
to
+"master" no comando acima =C3=A9, de fato, desnecess=C3=A1rio, j=C3=A1=
 que =C3=A9 o padr=C3=A3o.)
+
+O comando "pull" executa, ent=C3=A3o, duas opera=C3=A7=C3=B5es: ele ob=
t=C3=A9m mudan=C3=A7as de
+um ramo remoto, e, ent=C3=A3o, as unifica no ramo atual.
+
+Note que, em geral, Alice gostaria que suas mudan=C3=A7as locais fosse=
m
+gravadas antes de iniciar este "pull".  Se o trabalho de Bobo conflita
+com o que Alice fez desde que suas hist=C3=B3rias se ramificaram, Alic=
e ir=C3=A1
+usar seu diret=C3=B3rio de trabalho e o =C3=ADndice para resolver conf=
litos, e
+mudan=C3=A7as locais existentes ir=C3=A3o interferir com o processo de=
 resolu=C3=A7=C3=A3o
+de conflitos (git ainda ir=C3=A1 realizar a obten=C3=A7=C3=A3o mas ir=C3=
=A1 se recusar a
+unificar --- Alice ter=C3=A1 que se livrar de suas mudan=C3=A7as locai=
s de alguma
+forma e puxar de novo quando isso acontecer).
+
+Alice pode espiar o que Bob fez sem unificar primeiro, usando o comand=
o
+"fetch"; isto permite Alice inspecionar o que Bob fez, usando um s=C3=AD=
mbolo
+especial "FETCH_HEAD", com o fim de determinar se ele tem alguma coisa
+que vale puxar, assim:
+
+------------------------------------------------
+alice$ git fetch /home/bob/myrepo master
+alice$ git log -p HEAD..FETCH_HEAD
+------------------------------------------------
+
+Esta opera=C3=A7=C3=A3o =C3=A9 segura mesmo se Alice tem mudan=C3=A7as=
 locais n=C3=A3o gravadas.
+A nota=C3=A7=C3=A3o de intervalo "HEAD..FETCH_HEAD" significa mostrar =
tudo que =C3=A9
+alcan=C3=A7=C3=A1vel de FETCH_HEAD mas exclua tudo que =C3=A9 alcan=C3=
=A7=C3=A1vel de HEAD. Alcie
+j=C3=A1 sabe tudo que leva a seu estado atual (HEAD), e revisa o que B=
ob tem
+em seu estado (FETCH_HEAD) que ela ainda n=C3=A3o viu com esse comando=
=2E
+
+Se Alice quer visualizar o que Bob fez desde que suas hist=C3=B3ria
+ramificaram, ela pode disparar o seguinte comando:
+
+------------------------------------------------
+$ gitk HEAD..FETCH_HEAD
+------------------------------------------------
+
+Isto usar a mesma nota=C3=A7=C3=A3o de intervaldo que vimos antes com =
'git log'.
+
+Alice pode querer ver o que ambos fizeram desde que ramificaram. Ela
+pode usar a forma com tr=C3=AAs pontos ao inv=C3=A9s da forma com dois=
 pontos:
+
+------------------------------------------------
+$ gitk HEAD...FETCH_HEAD
+------------------------------------------------
+
+Isto significa "mostre tudo que =C3=A9 alcan=C3=A7avel de qualquer um,=
 mas exclua
+tudo que =C3=A9 alcan=C3=A7avel a partir de ambos".
+This means "show everything that is reachable from either one, but
+exclude anything that is reachable from both of them".
+
+Por favor, note que essas nota=C3=A7=C3=B5es de intervalo podem ser us=
adas tanto
+com gitk quanto com "git log".
+
+Apo=C3=B3s inspecionar o que Bob fez, se n=C3=A3o h=C3=A1 nada urgente=
, Alice pode
+decidir continuar trabalhando sem puxar de Bob.  Se a hist=C3=B3ria de=
 Bob
+tem alguma coisa que Alice precisa imediatamente, Alice pode optar por
+separar seu trabalho em progresso primeiro, fazer um "pull", e, ent=C3=
=A3o,
+finalmente, retomar seu trabalho em progresso em cima da hist=C3=B3ria
+resultante.
+
+Quanto voc=C3=AA est=C3=A1 trabalhando em um pequeno grupo unido, n=C3=
=A3o =C3=A9 incomum
+interagir com o mesmo reposit=C3=B3rio v=C3=A1rias e v=C3=A1rias vezes=
=2E  Definindo um
+reposit=C3=B3rio remoto antes de tudo, voc=C3=AA pode faz=C3=AA-lo mai=
s facilmente:
+
+------------------------------------------------
+alice$ git remote add bob /home/bob/myrepo
+------------------------------------------------
+
+Com isso, Alice pode executar a primeira parte da opera=C3=A7=C3=A3o "=
pull" usando
+o comando 'git-fetch' sem unificar suas mudan=C3=A7as com seu pr=C3=B3=
prio ramo,
+usando:
+
+-------------------------------------
+alice$ git fetch bob
+-------------------------------------
+
+Diferente da forma longa, quando Alice obteve de Bob usando um
+reposit=C3=B3rio remoto antes definido com 'git-remote', o que foi obt=
ido =C3=A9
+armazenado um ramo remoto, neste caso `bob/master`.  Ent=C3=A3o, ap=C3=
=B3s isso:
+
+-------------------------------------
+alice$ git log -p master..bob/master
+-------------------------------------
+
+mostra uma lista de todas as mudan=C3=A7as que Bob fez desde que ramif=
icou do
+ramo master de Alice.
+
+Ap=C3=B3s examinar essas mudan=C3=A7as, Alice pode unific=C3=A1-las em=
 seu ramo master:
+
+-------------------------------------
+alice$ git merge bob/master
+-------------------------------------
+
+Esse `merge` pode tamb=C3=A9m ser feito puxando de seu pr=C3=B3prio ra=
mo remoto,
+assim:
+
+-------------------------------------
+alice$ git pull . remotes/bob/master
+-------------------------------------
+
+Note que 'git pull' sempre unifica ao ramo atual, independente do que
+mais foi dado na linha de comando.
+
+Depois, Bob pode atualizar seu reposit=C3=B3rio com as =C3=BAltimas mu=
dan=C3=A7as de
+Alice, usando
+
+-------------------------------------
+bob$ git pull
+-------------------------------------
+
+Note que ele n=C3=A3o precisa dar o caminho do reposit=C3=B3rio de Ali=
ce; quando
+Bob clonou seu reposit=C3=B3rio, o git armazenou a localiza=C3=A7=C3=A3=
o de seu
+reposit=C3=B3rio na configura=C3=A7=C3=A3o do reposit=C3=B3rio, e essa=
 localiza=C3=A7=C3=A3o =C3=A9 usada
+para puxar:
+
+-------------------------------------
+bob$ git config --get remote.origin.url
+/home/alice/project
+-------------------------------------
+
+(A configura=C3=A7=C3=A3o completa criada por 'git-clone' =C3=A9 vis=C3=
=ADvel usando `git
+config -l`, e a p=C3=A1gina de manual linkgit:git-config[1] explica o
+significado de cada op=C3=A7=C3=A3o.)
+
+Git tamb=C3=A9m mant=C3=A9m uma c=C3=B3pia limpa do ramo master de Ali=
ce sob o nome
+"origin/master":
+
+-------------------------------------
+bob$ git branch -r
+  origin/master
+-------------------------------------
+
+Se Bob decidir depois em trabalhar em um host diferente, ele ainda pod=
e
+executar clones e puxar usando o protocolo ssh:
+
+-------------------------------------
+bob$ git clone alice.org:/home/alice/project myrepo
+-------------------------------------
+
+Alternativamente, o git tem um protocolo nativo, ou pode usar rsync ou
+http; veja linkgit:git-pull[1] para detalhes.
+
+Git pode tamb=C3=A9m ser usado em um modo parecido com CVS, com um
+reposit=C3=B3rio central para o qual que v=C3=A1rios usu=C3=A1rios emp=
urram
+modifica=C3=A7=C3=B5es; veja linkgit:git-push[1] e linkgit:gitcvs-migr=
ation[7].
+
+Explorando hist=C3=B3ria
+-----------------
+
+A hist=C3=B3ria no git =C3=A9 representada como uma s=C3=A9rie de comm=
its
+interrelacionados.  N=C3=B3s j=C3=A1 vimos que o comando 'git-log' pod=
e listar
+esses commits. Note que a primeira linha de cama entrada no log tamb=C3=
=A9m
+d=C3=A1 o nome para o commit:
+
+-------------------------------------
+$ git log
+commit c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
+Author: Junio C Hamano <junkio@cox.net>
+Date:   Tue May 16 17:18:22 2006 -0700
+
+    merge-base: Clarify the comments on post processing.
+-------------------------------------
+
+N=C3=B3s podemos dar este nome ao 'git-show' para ver os detalhes sobr=
e este
+commit.
+
+-------------------------------------
+$ git show c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
+-------------------------------------
+
+Mas h=C3=A1 outras formas de se referir a commits.  Voc=C3=AA pode usa=
r qualquer
+parte inicial do nome que seja longo o bastante para unicamente
+identificar o commit:
+
+-------------------------------------
+$ git show c82a22c39c	# os primeiros caracteres do nome s=C3=A3o o bas=
tante
+			# usualmente
+$ git show HEAD		# a ponta do ramo atual
+$ git show experimental	# a ponta do ramo "experimental"
+-------------------------------------
+
+Todo commit usualmente tem um commit "pai" que aponta para o estado
+anterior do projeto:
+
+-------------------------------------
+$ git show HEAD^  # para ver o pai de HEAD
+$ git show HEAD^^ # para ver o av=C3=B4 de HEAD
+$ git show HEAD~4 # para ver o trisav=C3=B4 de HEAD
+-------------------------------------
+
+Note que commits de unifica=C3=A7=C3=A3o podem ter mais de um pai:
+
+-------------------------------------
+$ git show HEAD^1 # mostra o primeiro pai de HEAD (o mesmo que HEAD^)
+$ git show HEAD^2 # mostra o segundo pai de HEAD
+-------------------------------------
+
+Voc=C3=AA tamb=C3=A9m pode dar aos commits nomes seus; ap=C3=B3s execu=
tar
+
+-------------------------------------
+$ git tag v2.5 1b2e1d63ff
+-------------------------------------
+
+voc=C3=AA pode se referir a 1b2e1d63ff pelo nome "v2.5".  Se voc=C3=AA=
 pretende
+compartilhar esse nome com outras pessoas (por exemplo, para identific=
ar
+uma vers=C3=A3o de lan=C3=A7amento), voc=C3=AA deve criar um objeto "t=
ag", e talvez
+assin=C3=A1-lo; veja linkgit:git-tag[1] para detalhes.
+
+Qualquer comando git que precise conhecer um commit pode receber
+quaisquer desses nomes.  Por exemplo:
+
+-------------------------------------
+$ git diff v2.5 HEAD	 # compara o HEAD atual com v2.5
+$ git branch stable v2.5 # inicia um novo ramo chamado "stable" basead=
o
+			 # em v2.5
+$ git reset --hard HEAD^ # reseta seu ramo atual e seu diret=C3=B3rio =
de
+			 # trabalho a seu estado em HEAD^
+-------------------------------------
+
+Seja cuidadoso com o =C3=BAltimo comando: al=C3=A9m de perder quaisque=
r mudan=C3=A7as
+em seu diret=C3=B3rio de trabalho, ele tamb=C3=A9m remove todos os com=
mits
+posteriores desse ramo.  Se esse ramo =C3=A9 o =C3=BAnico ramo contend=
o esses
+commits, eles ser=C3=A3o perdidos.  Tamb=C3=A9m, n=C3=A3o use 'git-res=
et' num ramo
+publicamente vis=C3=ADvel de onde outros desenvolvedores puxam, j=C3=A1=
 que vai
+for=C3=A7ar unifica=C3=A7=C3=B5es desnecess=C3=A1rias para que outros =
desenvolvedores limpem
+a hist=C3=B3ria. Se voc=C3=AA precisa desfazer mudan=C3=A7as que voc=C3=
=AA empurrou, use
+'git-revert' no lugar.
+
+O comando 'git-grep' pode buscar strings em qualquer vers=C3=A3o de se=
u
+projeto, ent=C3=A3o
+
+-------------------------------------
+$ git grep "hello" v2.5
+-------------------------------------
+
+procura por todas as ocorre=C3=AAncias de "hello" em v2.5.
+
+Se voc=C3=AA deixar de fora o nome do commit, 'git-grep' ir=C3=A1 proc=
urar
+quaisquer dos arquivos que ele gerencia no diret=C3=B3rio corrente.  E=
nt=C3=A3o
+
+-------------------------------------
+$ git grep "hello"
+-------------------------------------
+
+=C3=A9 uma forma r=C3=A1pida de buscar somente os arquivos que s=C3=A3=
o rastreados pelo
+git.
+
+Muitos comandos git tamb=C3=A9m recebem um conjunto de commits, o que =
pode
+ser especificado de um bom n=C3=BAmero de formas.  Aqui est=C3=A3o alg=
uns exemplos
+com 'git-log':
+
+-------------------------------------
+$ git log v2.5..v2.6            # commits entre v2.5 e v2.6
+$ git log v2.5..                # commits desde v2.5
+$ git log --since=3D"2 weeks ago" # commits das =C3=BAltimas 2 semanas
+$ git log v2.5.. Makefile       # commits desde v2.5 que modificam
+				# Makefile
+-------------------------------------
+
+Voc=C3=AA tamb=C3=A9m pode dar ao 'git-log' um "intervalo" de commits =
onde o
+primeiro n=C3=A3o =C3=A9 necessariamente um ancestral do segundo; por =
exemplo, se
+as pontas dos ramos "stable" e "master" divergiram de um commit
+comum algum tempo atr=C3=A1s, ent=C3=A3o
+
+-------------------------------------
+$ git log stable..experimental
+-------------------------------------
+
+ir=C3=A1 listas os commits feitos no ramo experimental mas n=C3=A3o no=
 ramo
+stable, enquanto
+
+-------------------------------------
+$ git log experimental..stable
+-------------------------------------
+
+ir=C3=A1 listar a lista de commits feitos no ramo stable mas n=C3=A3o =
no ramo
+experimental.
+
+O comando 'git-log' tem uma fraquza: ele precisa mostrar os commits em
+uma lista. Quando a hist=C3=B3ria tem linhas de desenvolvimento que
+divergiram e ent=C3=A3o foram unificadas novamente, a ordem em que 'gi=
t-log'
+apresenta essas mudan=C3=A7as =C3=A9 insignificante.
+
+A maioria dos projetos com m=C3=BAltiplos contribuidores (como o kerne=
l
+linux, ou o git mesmo) tem unifica=C3=A7=C3=B5es frequentes, e 'gitk' =
faz um
+trabalho melhor de visualizar sua hist=C3=B3ria.  Por exemplo,
+
+-------------------------------------
+$ gitk --since=3D"2 weeks ago" drivers/
+-------------------------------------
+
+permite voc=C3=AA navegar em quaisquer commits desde as =C3=BAltimas d=
uas semanas
+de commits que modificaram arquivos sob o diret=C3=B3rio "drivers".  (=
Nota:
+voc=C3=AA pode ajustar as fontes do gitk segurando a tecla control enq=
uanto
+pressiona "-" ou "+".)
+
+Finalmente, a maioria dos comandos que recebem nomes de arquivo
+te permitir=C3=A3o opcionalmente preceder qualquer nome de arquivo por=
 um
+commit, para especificar uma vers=C3=A3o particular do arquivo:
+
+-------------------------------------
+$ git diff v2.5:Makefile HEAD:Makefile.in
+-------------------------------------
+
+Voc=C3=AA pode usar 'git-show' para ver tal arquivo:
+
+-------------------------------------
+$ git show v2.5:Makefile
+-------------------------------------
+
+Pr=C3=B3ximos passos
+----------
+
+Este tutorial deve ser o bastante para operar controle de revis=C3=A3o
+distribu=C3=ADdo b=C3=A1sico para seus projetos.  No entanto, para ent=
ender
+plenamente a profundidade e o poder do git voc=C3=AA precisa entender =
duas
+id=C3=A9ias simples nas quais ele se baseia:
+
+  * A base de objetos =C3=A9 um sistema bem elegante usado para armaze=
nar a
+    hist=C3=B3ria de seu projeto--arquivos, diret=C3=B3rios, e commits=
=2E
+
+  * O arquivo de =C3=ADndica =C3=A9 um cache do estado de uma =C3=A1rv=
ore de diret=C3=B3rio,
+    usado para criar commits, restaurar diret=C3=B3rios de trabalho, e
+    compreender as v=C3=A1rias =C3=A1rvores involvidas em uma unifica=C3=
=A7=C3=A3o.
+
+Parte dois deste tutorial explica a base de objetos, o arquivo de
+=C3=ADndice, e algumas outras coisinhas que voc=C3=AA vai precisar pra=
 usar o
+m=C3=A1ximo do git. Voc=C3=AA pode encontr=C3=A1-la em linkgit:gittuto=
rial-2[7].
+
+Se voc=C3=AA n=C3=A3o quer continuar do jeito certo, algumas outras di=
sgress=C3=B5es
+que podem ser interessantes neste ponto s=C3=A3o:
+
+  * linkgit:git-format-patch[1], linkgit:git-am[1]: Estes convertem
+    s=C3=A9ries de commits em patches em email, e vice-versa, =C3=BAte=
is para
+    projetos como o kernel linux que dependem pesadamente em patches
+    enviados por email.
+
+  * linkgit:git-bisect[1]: Quando h=C3=A1 uma regress=C3=A3o em seu pr=
ojeto, uma
+    forma de rastrear um bug =C3=A9 procurando pela hist=C3=B3ria para=
 encontrar o
+    commit culpado.  Git bisect pode ajudar a executar uma busca bin=C3=
=A1ria
+    por esse commit.  Ele =C3=A9 inteligente o bastante para executar =
uma
+    busca pr=C3=B3xima da =C3=B3tima mesmo no caso de uma hist=C3=B3ri=
a complexa
+    n=C3=A3o-linear com muitos ramos unificados.
+
+  * link:everyday.html[GIT diariamente com 20 e tantos comandos]
+
+  * linkgit:gitcvs-migration[7]: Git para usu=C3=A1rios de CVS.
+
+Veja Tamb=C3=A9m
+--------
+linkgit:gittutorial-2[7],
+linkgit:gitcvs-migration[7],
+linkgit:gitcore-tutorial[7],
+linkgit:gitglossary[7],
+linkgit:git-help[1],
+link:everyday.html[git diariamente],
+link:user-manual.html[O Manual do Usu=C3=A1rio git]
+
+GIT
+---
+Parte da suite linkgit:git[1].
--=20
1.6.3
