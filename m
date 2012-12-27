From: Thomas Ackermann <th.acker@arcor.de>
Subject: [PATCH] Remove Documentation/pt_BR/gittutorial.txt
Date: Thu, 27 Dec 2012 15:15:52 +0100 (CET)
Message-ID: <912689493.1321768.1356617752157.JavaMail.ngmail@webmail17.arcor-online.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: th.acker@arcor.de, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 27 15:16:16 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ToEFr-00051v-2r
	for gcvg-git-2@plane.gmane.org; Thu, 27 Dec 2012 15:16:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752718Ab2L0OP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 27 Dec 2012 09:15:57 -0500
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:42855 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752446Ab2L0OPy convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Dec 2012 09:15:54 -0500
Received: from mail-in-13-z2.arcor-online.net (mail-in-13-z2.arcor-online.net [151.189.8.30])
	by mx.arcor.de (Postfix) with ESMTP id 3D8A63B61A5
	for <git@vger.kernel.org>; Thu, 27 Dec 2012 15:15:52 +0100 (CET)
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net [151.189.21.45])
	by mail-in-13-z2.arcor-online.net (Postfix) with ESMTP id 3FEF514B081;
	Thu, 27 Dec 2012 15:15:52 +0100 (CET)
Received: from webmail17.arcor-online.net (webmail17.arcor-online.net [151.189.8.75])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 3896BE416B;
	Thu, 27 Dec 2012 15:15:52 +0100 (CET)
X-DKIM: Sendmail DKIM Filter v2.8.2 mail-in-05.arcor-online.net 3896BE416B
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arcor.de; s=mail-in;
	t=1356617752; bh=HneMUnTiclbRgr6tF9YOHAvublFtwlcvJCd8YotKXe4=;
	h=Date:From:To:Message-ID:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=FBeIyULbby1mbTDJjpg31nOcw+aEjlzkSI7FufNGOjaO5Kt0D9WTO7zzMfO1dXiDY
	 ZtsN3RUFRNl61ZEZ4SxElTSsX6GfTbVQbIS4Ii80V0sDWBD8ueKEDWSVFLhriS4NBt
	 icv38T11eEhfIb9y+AJhiG75pYhiX0MTCmTqCsgo=
Received: from [178.7.29.153] by webmail17.arcor-online.net (151.189.8.75) with HTTP (Arcor Webmail); Thu, 27 Dec 2012 15:15:52 +0100 (CET)
X-ngMessageSubType: MessageSubType_MAIL
X-WebmailclientIP: 178.7.29.153
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212200>


This file is rather outdated and IMHO shouldn't be there in the first p=
lace.
(If there are translations of the Git documentation they are better be =
kept
separate from the original documentation.)

Signed-off-by: Thomas Ackermann <th.acker@arcor.de>
---
 Documentation/pt_BR/gittutorial.txt | 675 ----------------------------=
--------
 1 file changed, 675 deletions(-)
 delete mode 100644 Documentation/pt_BR/gittutorial.txt

diff --git a/Documentation/pt_BR/gittutorial.txt b/Documentation/pt_BR/=
gittutorial.txt
deleted file mode 100644
index beba065..0000000
--- a/Documentation/pt_BR/gittutorial.txt
+++ /dev/null
@@ -1,675 +0,0 @@
-gittutorial(7)
-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
-
-NOME
-----
-gittutorial - Um tutorial de introdu=E7=E3o ao git (para vers=E3o 1.5.=
1 ou mais nova)
-
-SINOPSE
---------
-git *
-
-DESCRI=C7=C3O
------------
-
-Este tutorial explica como importar um novo projeto para o git,
-adicionar mudan=E7as a ele, e compartilhar mudan=E7as com outros
-desenvolvedores.
-
-Se, ao inv=E9s disso, voc=EA est=E1 interessado primariamente em usar =
git para
-obter um projeto, por exemplo, para testar a =FAltima vers=E3o, voc=EA=
 pode
-preferir come=E7ar com os primeiros dois cap=EDtulos de
-link:user-manual.html[O Manual do Usu=E1rio Git].
-
-Primeiro, note que voc=EA pode obter documenta=E7=E3o para um comando =
como
-`git log --graph` com:
-
-------------------------------------------------
-$ man git-log
-------------------------------------------------
-
-ou:
-
-------------------------------------------------
-$ git help log
-------------------------------------------------
-
-Com a =FAltima forma, voc=EA pode usar o visualizador de manual de sua
-escolha; veja linkgit:git-help[1] para maior informa=E7=E3o.
-
-=C9 uma boa id=E9ia informar ao git seu nome e endere=E7o p=FAblico de=
 email
-antes de fazer qualquer opera=E7=E3o. A maneira mais f=E1cil de faz=EA=
-lo =E9:
-
-------------------------------------------------
-$ git config --global user.name "Seu Nome Vem Aqui"
-$ git config --global user.email voce@seudominio.exemplo.com
-------------------------------------------------
-
-
-Importando um novo projeto
------------------------
-
-Assuma que voc=EA tem um tarball project.tar.gz com seu trabalho inici=
al.
-Voc=EA pode coloc=E1-lo sob controle de revis=E3o git da seguinte form=
a:
-
-------------------------------------------------
-$ tar xzf project.tar.gz
-$ cd project
-$ git init
-------------------------------------------------
-
-Git ir=E1 responder
-
-------------------------------------------------
-Initialized empty Git repository in .git/
-------------------------------------------------
-
-Agora que voc=EA iniciou seu diret=F3rio de trabalho, voc=EA deve ter =
notado que um
-novo diret=F3rio foi criado com o nome de ".git".
-
-A seguir, diga ao git para gravar um instant=E2neo do conte=FAdo de to=
dos os
-arquivos sob o diret=F3rio atual (note o '.'), com 'git-add':
-
-------------------------------------------------
-$ git add .
-------------------------------------------------
-
-Este instant=E2neo est=E1 agora armazenado em uma =E1rea tempor=E1ria =
que o git
-chama de "index" ou =EDndice. Voc=EA pode armazenar permanentemente o
-conte=FAdo do =EDndice no reposit=F3rio com 'git-commit':
-
-------------------------------------------------
-$ git commit
-------------------------------------------------
-
-Isto vai te pedir por uma mensagem de commit. Voc=EA agora gravou sua
-primeira vers=E3o de seu projeto no git.
-
-Fazendo mudan=E7as
---------------
-
-Modifique alguns arquivos, e, ent=E3o, adicione seu conte=FAdo atualiz=
ado ao
-=EDndice:
-
-------------------------------------------------
-$ git add file1 file2 file3
-------------------------------------------------
-
-Voc=EA est=E1 agora pronto para fazer o commit. Voc=EA pode ver o que =
est=E1
-para ser gravado usando 'git-diff' com a op=E7=E3o --cached:
-
-------------------------------------------------
-$ git diff --cached
-------------------------------------------------
-
-(Sem --cached, o comando 'git-diff' ir=E1 te mostrar quaisquer mudan=E7=
as
-que voc=EA tenha feito mas ainda n=E3o adicionou ao =EDndice.) Voc=EA =
tamb=E9m
-pode obter um breve sum=E1rio da situa=E7=E3o com 'git-status':
-
-------------------------------------------------
-$ git status
-# On branch master
-# Changes to be committed:
-#   (use "git reset HEAD <file>..." to unstage)
-#
-#	modified:   file1
-#	modified:   file2
-#	modified:   file3
-#
-------------------------------------------------
-
-Se voc=EA precisar fazer qualquer outro ajuste, fa=E7a-o agora, e, ent=
=E3o,
-adicione qualquer conte=FAdo modificado ao =EDndice. Finalmente, grave=
 suas
-mudan=E7as com:
-
-------------------------------------------------
-$ git commit
-------------------------------------------------
-
-Ao executar esse comando, ele ir=E1 te pedir uma mensagem descrevendo =
a mudan=E7a,
-e, ent=E3o, ir=E1 gravar a nova vers=E3o do projeto.
-
-Alternativamente, ao inv=E9s de executar 'git-add' antes, voc=EA pode =
usar
-
-------------------------------------------------
-$ git commit -a
-------------------------------------------------
-
-o que ir=E1 automaticamente notar quaisquer arquivos modificados (mas =
n=E3o
-novos), adicion=E1-los ao =EDndices, e gravar, tudo em um =FAnico pass=
o.
-
-Uma nota em mensagens de commit: Apesar de n=E3o ser exigido, =E9 uma =
boa
-id=E9ia come=E7ar a mensagem com uma simples e curta (menos de 50
-caracteres) linha sumarizando a mudan=E7a, seguida de uma linha em bra=
nco
-e, ent=E3o, uma descri=E7=E3o mais detalhada. Ferramentas que transfor=
mam
-commits em email, por exemplo, usam a primeira linha no campo de
-cabe=E7alho "Subject:" e o resto no corpo.
-
-Git rastreia conte=FAdo, n=E3o arquivos
-----------------------------
-
-Muitos sistemas de controle de revis=E3o prov=EAem um comando `add` qu=
e diz
-ao sistema para come=E7ar a rastrear mudan=E7as em um novo arquivo. O
-comando `add` do git faz algo mais simples e mais poderoso: 'git-add' =
=E9
-usado tanto para arquivos novos e arquivos recentemente modificados, e
-em ambos os casos, ele tira o instant=E2neo dos arquivos dados e armaz=
ena
-o conte=FAdo no =EDndice, pronto para inclus=E3o do pr=F3ximo commit.
-
-Visualizando a hist=F3ria do projeto
------------------------
-
-Em qualquer ponto voc=EA pode visualizar a hist=F3ria das suas mudan=E7=
as
-usando
-
-------------------------------------------------
-$ git log
-------------------------------------------------
-
-Se voc=EA tamb=E9m quiser ver a diferen=E7a completa a cada passo, use
-
-------------------------------------------------
-$ git log -p
-------------------------------------------------
-
-Geralmente, uma vis=E3o geral da mudan=E7a =E9 =FAtil para ter a sensa=
=E7=E3o de
-cada passo
-
-------------------------------------------------
-$ git log --stat --summary
-------------------------------------------------
-
-Gerenciando "branches"/ramos
------------------
-
-Um simples reposit=F3rio git pode manter m=FAltiplos ramos de
-desenvolvimento. Para criar um novo ramo chamado "experimental", use
-
-------------------------------------------------
-$ git branch experimental
-------------------------------------------------
-
-Se voc=EA executar agora
-
-------------------------------------------------
-$ git branch
-------------------------------------------------
-
-voc=EA vai obter uma lista de todos os ramos existentes:
-
-------------------------------------------------
-  experimental
-* master
-------------------------------------------------
-
-O ramo "experimental" =E9 o que voc=EA acaba de criar, e o ramo "maste=
r" =E9 o
-ramo padr=E3o que foi criado pra voc=EA automaticamente. O asterisco m=
arca
-o ramo em que voc=EA est=E1 atualmente; digite
-
-------------------------------------------------
-$ git checkout experimental
-------------------------------------------------
-
-para mudar para o ramo experimental. Agora edite um arquivo, grave a
-mudan=E7a, e mude de volta para o ramo master:
-
-------------------------------------------------
-(edita arquivo)
-$ git commit -a
-$ git checkout master
-------------------------------------------------
-
-Verifique que a mudan=E7a que voc=EA fez n=E3o est=E1 mais vis=EDvel, =
j=E1 que ela
-foi feita no ramo experimental e voc=EA est=E1 de volta ao ramo master=
=2E
-
-Voc=EA pode fazer uma mudan=E7a diferente no ramo master:
-
-------------------------------------------------
-(edit file)
-$ git commit -a
-------------------------------------------------
-
-neste ponto, os dois ramos divergiram, com diferentes mudan=E7as feita=
s em
-cada um. Para unificar as mudan=E7as feitas no experimental para o
-master, execute
-
-------------------------------------------------
-$ git merge experimental
-------------------------------------------------
-
-Se as mudan=E7as n=E3o conflitarem, estar=E1 pronto. Se existirem conf=
litos,
-marcadores ser=E3o deixados nos arquivos problem=E1ticos exibindo o
-conflito;
-
-------------------------------------------------
-$ git diff
-------------------------------------------------
-
-vai exibir isto. Ap=F3s voc=EA editar os arquivos para resolver os
-conflitos,
-
-------------------------------------------------
-$ git commit -a
-------------------------------------------------
-
-ir=E1 gravar o resultado da unifica=E7=E3o. Finalmente,
-
-------------------------------------------------
-$ gitk
-------------------------------------------------
-
-vai mostrar uma bela representa=E7=E3o gr=E1fica da hist=F3ria resulta=
nte.
-
-Neste ponto voc=EA pode remover seu ramo experimental com
-
-------------------------------------------------
-$ git branch -d experimental
-------------------------------------------------
-
-Este comando garante que as mudan=E7as no ramo experimental j=E1 est=E3=
o no
-ramo atual.
-
-Se voc=EA desenvolve em um ramo ideia-louca, e se arrepende, voc=EA po=
de
-sempre remover o ramo com
-
--------------------------------------
-$ git branch -D ideia-louca
--------------------------------------
-
-Ramos s=E3o baratos e f=E1ceis, ent=E3o isto =E9 uma boa maneira de ex=
perimentar
-alguma coisa.
-
-Usando git para colabora=E7=E3o
----------------------------
-
-Suponha que Alice come=E7ou um novo projeto com um reposit=F3rio git e=
m
-/home/alice/project, e que Bob, que tem um diret=F3rio home na mesma
-m=E1quina, quer contribuir.
-
-Bob come=E7a com:
-
-------------------------------------------------
-bob$ git clone /home/alice/project myrepo
-------------------------------------------------
-
-Isso cria um novo diret=F3rio "myrepo" contendo um clone do reposit=F3=
rio de
-Alice. O clone est=E1 no mesmo p=E9 que o projeto original, possuindo =
sua
-pr=F3pria c=F3pia da hist=F3ria do projeto original.
-
-Bob ent=E3o faz algumas mudan=E7as e as grava:
-
-------------------------------------------------
-(editar arquivos)
-bob$ git commit -a
-(repetir conforme necess=E1rio)
-------------------------------------------------
-
-Quanto est=E1 pronto, ele diz a Alice para puxar as mudan=E7as do
-reposit=F3rio em /home/bob/myrepo. Ela o faz com:
-
-------------------------------------------------
-alice$ cd /home/alice/project
-alice$ git pull /home/bob/myrepo master
-------------------------------------------------
-
-Isto unifica as mudan=E7as do ramo "master" do Bob ao ramo atual de Al=
ice.
-Se Alice fez suas pr=F3prias mudan=E7as no intervalo, ela, ent=E3o, po=
de
-precisar corrigir manualmente quaisquer conflitos. (Note que o argumen=
to
-"master" no comando acima =E9, de fato, desnecess=E1rio, j=E1 que =E9 =
o padr=E3o.)
-
-O comando "pull" executa, ent=E3o, duas opera=E7=F5es: ele obt=E9m mud=
an=E7as de
-um ramo remoto, e, ent=E3o, as unifica no ramo atual.
-
-Note que, em geral, Alice gostaria que suas mudan=E7as locais fossem
-gravadas antes de iniciar este "pull". Se o trabalho de Bob conflita
-com o que Alice fez desde que suas hist=F3rias se ramificaram, Alice i=
r=E1
-usar seu diret=F3rio de trabalho e o =EDndice para resolver conflitos,=
 e
-mudan=E7as locais existentes ir=E3o interferir com o processo de resol=
u=E7=E3o
-de conflitos (git ainda ir=E1 realizar a obten=E7=E3o mas ir=E1 se rec=
usar a
-unificar --- Alice ter=E1 que se livrar de suas mudan=E7as locais de a=
lguma
-forma e puxar de novo quando isso acontecer).
-
-Alice pode espiar o que Bob fez sem unificar primeiro, usando o comand=
o
-"fetch"; isto permite Alice inspecionar o que Bob fez, usando um s=EDm=
bolo
-especial "FETCH_HEAD", com o fim de determinar se ele tem alguma coisa
-que vale puxar, assim:
-
-------------------------------------------------
-alice$ git fetch /home/bob/myrepo master
-alice$ git log -p HEAD..FETCH_HEAD
-------------------------------------------------
-
-Esta opera=E7=E3o =E9 segura mesmo se Alice tem mudan=E7as locais n=E3=
o gravadas.
-A nota=E7=E3o de intervalo "HEAD..FETCH_HEAD" significa mostrar tudo q=
ue =E9
-alcan=E7=E1vel de FETCH_HEAD mas exclua tudo o que =E9 alcan=E7=E1vel =
de HEAD.
-Alice j=E1 sabe tudo que leva a seu estado atual (HEAD), e revisa o qu=
e Bob
-tem em seu estado (FETCH_HEAD) que ela ainda n=E3o viu com esse comand=
o.
-
-Se Alice quer visualizar o que Bob fez desde que suas hist=F3rias se
-ramificaram, ela pode disparar o seguinte comando:
-
-------------------------------------------------
-$ gitk HEAD..FETCH_HEAD
-------------------------------------------------
-
-Isto usa a mesma nota=E7=E3o de intervalo que vimos antes com 'git log=
'.
-
-Alice pode querer ver o que ambos fizeram desde que ramificaram. Ela
-pode usar a forma com tr=EAs pontos ao inv=E9s da forma com dois ponto=
s:
-
-------------------------------------------------
-$ gitk HEAD...FETCH_HEAD
-------------------------------------------------
-
-Isto significa "mostre tudo que =E9 alcan=E7=E1vel de qualquer um dele=
s, mas
-exclua tudo que =E9 alcan=E7=E1vel a partir de ambos".
-
-Por favor, note que essas nota=E7=F5es de intervalo podem ser usadas t=
anto
-com gitk quanto com "git log".
-
-Ap=F3s inspecionar o que Bob fez, se n=E3o h=E1 nada urgente, Alice po=
de
-decidir continuar trabalhando sem puxar de Bob. Se a hist=F3ria de Bob
-tem alguma coisa que Alice precisa imediatamente, Alice pode optar por
-separar seu trabalho em progresso primeiro, fazer um "pull", e, ent=E3=
o,
-finalmente, retomar seu trabalho em progresso em cima da hist=F3ria
-resultante.
-
-Quando voc=EA est=E1 trabalhando em um pequeno grupo unido, n=E3o =E9 =
incomum
-interagir com o mesmo reposit=F3rio v=E1rias e v=E1rias vezes. Definin=
do um
-reposit=F3rio remoto antes de tudo, voc=EA pode faz=EA-lo mais facilme=
nte:
-
-------------------------------------------------
-alice$ git remote add bob /home/bob/myrepo
-------------------------------------------------
-
-Com isso, Alice pode executar a primeira parte da opera=E7=E3o "pull" =
usando
-o comando 'git-fetch' sem unificar suas mudan=E7as com seu pr=F3prio r=
amo,
-usando:
-
--------------------------------------
-alice$ git fetch bob
--------------------------------------
-
-Diferente da forma longa, quando Alice obteve de Bob usando um
-reposit=F3rio remoto antes definido com 'git-remote', o que foi obtido=
 =E9
-armazenado em um ramo remoto, neste caso `bob/master`. Ent=E3o, ap=F3s=
 isso:
-
--------------------------------------
-alice$ git log -p master..bob/master
--------------------------------------
-
-mostra uma lista de todas as mudan=E7as que Bob fez desde que ramifico=
u do
-ramo master de Alice.
-
-Ap=F3s examinar essas mudan=E7as, Alice pode unific=E1-las em seu ramo=
 master:
-
--------------------------------------
-alice$ git merge bob/master
--------------------------------------
-
-Esse `merge` pode tamb=E9m ser feito puxando de seu pr=F3prio ramo rem=
oto,
-assim:
-
--------------------------------------
-alice$ git pull . remotes/bob/master
--------------------------------------
-
-Note que 'git pull' sempre unifica ao ramo atual, independente do que
-mais foi passado na linha de comando.
-
-Depois, Bob pode atualizar seu reposit=F3rio com as =FAltimas mudan=E7=
as de
-Alice, usando
-
--------------------------------------
-bob$ git pull
--------------------------------------
-
-Note que ele n=E3o precisa dar o caminho do reposit=F3rio de Alice; qu=
ando
-Bob clonou seu reposit=F3rio, o git armazenou a localiza=E7=E3o de seu
-reposit=F3rio na configura=E7=E3o do mesmo, e essa localiza=E7=E3o =E9=
 usada
-para puxar:
-
--------------------------------------
-bob$ git config --get remote.origin.url
-/home/alice/project
--------------------------------------
-
-(A configura=E7=E3o completa criada por 'git-clone' =E9 vis=EDvel usan=
do `git
-config -l`, e a p=E1gina de manual linkgit:git-config[1] explica o
-significado de cada op=E7=E3o.)
-
-Git tamb=E9m mant=E9m uma c=F3pia limpa do ramo master de Alice sob o =
nome
-"origin/master":
-
--------------------------------------
-bob$ git branch -r
-  origin/master
--------------------------------------
-
-Se Bob decidir depois em trabalhar em um host diferente, ele ainda pod=
e
-executar clones e puxar usando o protocolo ssh:
-
--------------------------------------
-bob$ git clone alice.org:/home/alice/project myrepo
--------------------------------------
-
-Alternativamente, o git tem um protocolo nativo, ou pode usar rsync ou
-http; veja linkgit:git-pull[1] para detalhes.
-
-Git pode tamb=E9m ser usado em um modo parecido com CVS, com um
-reposit=F3rio central para o qual v=E1rios usu=E1rios empurram modific=
a=E7=F5es;
-veja linkgit:git-push[1] e linkgit:gitcvs-migration[7].
-
-Explorando hist=F3ria
------------------
-
-A hist=F3ria no git =E9 representada como uma s=E9rie de commits
-interrelacionados. N=F3s j=E1 vimos que o comando 'git-log' pode lista=
r
-esses commits. Note que a primeira linha de cada entrada no log tamb=E9=
m
-d=E1 o nome para o commit:
-
--------------------------------------
-$ git log
-commit c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
-Author: Junio C Hamano <junkio@cox.net>
-Date:   Tue May 16 17:18:22 2006 -0700
-
-    merge-base: Clarify the comments on post processing.
--------------------------------------
-
-N=F3s podemos dar este nome ao 'git-show' para ver os detalhes sobre e=
ste
-commit.
-
--------------------------------------
-$ git show c82a22c39cbc32576f64f5c6b3f24b99ea8149c7
--------------------------------------
-
-Mas h=E1 outras formas de se referir aos commits. Voc=EA pode usar qua=
lquer
-parte inicial do nome que seja longo o bastante para identificar
-unicamente o commit:
-
--------------------------------------
-$ git show c82a22c39c	# os primeiros caracteres do nome s=E3o o bastan=
te
-			# usualmente
-$ git show HEAD		# a ponta do ramo atual
-$ git show experimental	# a ponta do ramo "experimental"
--------------------------------------
-
-Todo commit normalmente tem um commit "pai" que aponta para o estado
-anterior do projeto:
-
--------------------------------------
-$ git show HEAD^  # para ver o pai de HEAD
-$ git show HEAD^^ # para ver o av=F4 de HEAD
-$ git show HEAD~4 # para ver o trisav=F4 de HEAD
--------------------------------------
-
-Note que commits de unifica=E7=E3o podem ter mais de um pai:
-
--------------------------------------
-$ git show HEAD^1 # mostra o primeiro pai de HEAD (o mesmo que HEAD^)
-$ git show HEAD^2 # mostra o segundo pai de HEAD
--------------------------------------
-
-Voc=EA tamb=E9m pode dar aos commits nomes =E0 sua escolha; ap=F3s exe=
cutar
-
--------------------------------------
-$ git tag v2.5 1b2e1d63ff
--------------------------------------
-
-voc=EA pode se referir a 1b2e1d63ff pelo nome "v2.5". Se voc=EA preten=
de
-compartilhar esse nome com outras pessoas (por exemplo, para identific=
ar
-uma vers=E3o de lan=E7amento), voc=EA deveria criar um objeto "tag", e=
 talvez
-assin=E1-lo; veja linkgit:git-tag[1] para detalhes.
-
-Qualquer comando git que precise conhecer um commit pode receber
-quaisquer desses nomes. Por exemplo:
-
--------------------------------------
-$ git diff v2.5 HEAD	 # compara o HEAD atual com v2.5
-$ git branch stable v2.5 # inicia um novo ramo chamado "stable" basead=
o
-			 # em v2.5
-$ git reset --hard HEAD^ # reseta seu ramo atual e seu diret=F3rio de
-			 # trabalho a seu estado em HEAD^
--------------------------------------
-
-Seja cuidadoso com o =FAltimo comando: al=E9m de perder quaisquer muda=
n=E7as
-em seu diret=F3rio de trabalho, ele tamb=E9m remove todos os commits
-posteriores desse ramo. Se esse ramo =E9 o =FAnico ramo contendo esses
-commits, eles ser=E3o perdidos. Tamb=E9m, n=E3o use 'git-reset' num ra=
mo
-publicamente vis=EDvel de onde outros desenvolvedores puxam, j=E1 que =
vai
-for=E7ar unifica=E7=F5es desnecess=E1rias para que outros desenvolvedo=
res limpem
-a hist=F3ria. Se voc=EA precisa desfazer mudan=E7as que voc=EA empurro=
u, use
-'git-revert' no lugar.
-
-O comando 'git-grep' pode buscar strings em qualquer vers=E3o de seu
-projeto, ent=E3o
-
--------------------------------------
-$ git grep "hello" v2.5
--------------------------------------
-
-procura por todas as ocorr=EAncias de "hello" em v2.5.
-
-Se voc=EA deixar de fora o nome do commit, 'git-grep' ir=E1 procurar
-quaisquer dos arquivos que ele gerencia no diret=F3rio corrente. Ent=E3=
o
-
--------------------------------------
-$ git grep "hello"
--------------------------------------
-
-=E9 uma forma r=E1pida de buscar somente os arquivos que s=E3o rastrea=
dos pelo
-git.
-
-Muitos comandos git tamb=E9m recebem um conjunto de commits, o que pod=
e
-ser especificado de v=E1rias formas. Aqui est=E3o alguns exemplos com =
'git-log':
-
--------------------------------------
-$ git log v2.5..v2.6            # commits entre v2.5 e v2.6
-$ git log v2.5..                # commits desde v2.5
-$ git log --since=3D"2 weeks ago" # commits das =FAltimas 2 semanas
-$ git log v2.5.. Makefile       # commits desde v2.5 que modificam
-				# Makefile
--------------------------------------
-
-Voc=EA tamb=E9m pode dar ao 'git-log' um "intervalo" de commits onde o
-primeiro n=E3o =E9 necessariamente um ancestral do segundo; por exempl=
o, se
-as pontas dos ramos "stable" e "master" divergiram de um commit
-comum algum tempo atr=E1s, ent=E3o
-
--------------------------------------
-$ git log stable..master
--------------------------------------
-
-ir=E1 listar os commits feitos no ramo "master" mas n=E3o no ramo
-"stable", enquanto
-
--------------------------------------
-$ git log master..stable
--------------------------------------
-
-ir=E1 listar a lista de commits feitos no ramo "stable" mas n=E3o no r=
amo
-"master".
-
-O comando 'git-log' tem uma fraqueza: ele precisa mostrar os commits e=
m
-uma lista. Quando a hist=F3ria tem linhas de desenvolvimento que
-divergiram e ent=E3o foram unificadas novamente, a ordem em que 'git-l=
og'
-apresenta essas mudan=E7as =E9 irrelevante.
-
-A maioria dos projetos com m=FAltiplos contribuidores (como o kernel
-Linux, ou o pr=F3prio git) tem unifica=E7=F5es frequentes, e 'gitk' fa=
z um
-trabalho melhor de visualizar sua hist=F3ria. Por exemplo,
-
--------------------------------------
-$ gitk --since=3D"2 weeks ago" drivers/
--------------------------------------
-
-permite a voc=EA navegar em quaisquer commits desde as =FAltimas duas =
semanas
-de commits que modificaram arquivos sob o diret=F3rio "drivers". (Nota=
:
-voc=EA pode ajustar as fontes do gitk segurando a tecla control enquan=
to
-pressiona "-" ou "+".)
-
-Finalmente, a maioria dos comandos que recebem nomes de arquivo permit=
ir=E3o
-tamb=E9m, opcionalmente, preceder qualquer nome de arquivo por um
-commit, para especificar uma vers=E3o particular do arquivo:
-
--------------------------------------
-$ git diff v2.5:Makefile HEAD:Makefile.in
--------------------------------------
-
-Voc=EA pode usar 'git-show' para ver tal arquivo:
-
--------------------------------------
-$ git show v2.5:Makefile
--------------------------------------
-
-Pr=F3ximos passos
-----------
-
-Este tutorial deve ser o bastante para operar controle de revis=E3o
-distribu=EDdo b=E1sico para seus projetos. No entanto, para entender
-plenamente a profundidade e o poder do git voc=EA precisa entender dua=
s
-id=E9ias simples nas quais ele se baseia:
-
-  * A base de objetos =E9 um sistema bem elegante usado para armazenar=
 a
-    hist=F3ria de seu projeto--arquivos, diret=F3rios, e commits.
-
-  * O arquivo de =EDndice =E9 um cache do estado de uma =E1rvore de di=
ret=F3rio,
-    usado para criar commits, restaurar diret=F3rios de trabalho, e
-    armazenar as v=E1rias =E1rvores envolvidas em uma unifica=E7=E3o.
-
-A parte dois deste tutorial explica a base de objetos, o arquivo de
-=EDndice, e algumas outras coisinhas que voc=EA vai precisar pra usar =
o
-m=E1ximo do git. Voc=EA pode encontr=E1-la em linkgit:gittutorial-2[7]=
=2E
-
-Se voc=EA n=E3o quiser continuar com o tutorial agora nesse momento, a=
lgumas
-outras digress=F5es que podem ser interessantes neste ponto s=E3o:
-
-  * linkgit:git-format-patch[1], linkgit:git-am[1]: Estes convertem
-    s=E9ries de commits em patches para email, e vice-versa, =FAteis p=
ara
-    projetos como o kernel Linux que dependem fortemente de patches
-    enviados por email.
-
-  * linkgit:git-bisect[1]: Quando h=E1 uma regress=E3o em seu projeto,=
 uma
-    forma de rastrear um bug =E9 procurando pela hist=F3ria para encon=
trar o
-    commit culpado. Git bisect pode ajudar a executar uma busca bin=E1=
ria
-    por esse commit. Ele =E9 inteligente o bastante para executar uma
-    busca pr=F3xima da =F3tima mesmo no caso de uma hist=F3ria complex=
a
-    n=E3o-linear com muitos ramos unificados.
-
-  * link:everyday.html[GIT diariamente com 20 e tantos comandos]
-
-  * linkgit:gitcvs-migration[7]: Git para usu=E1rios de CVS.
-
-VEJA TAMB=C9M
---------
-linkgit:gittutorial-2[7],
-linkgit:gitcvs-migration[7],
-linkgit:gitcore-tutorial[7],
-linkgit:gitglossary[7],
-linkgit:git-help[1],
-link:everyday.html[git diariamente],
-link:user-manual.html[O Manual do Usu=E1rio git]
-
-GIT
----
-Parte da suite linkgit:git[1].
--=20
1.8.0.msysgit.0


---
Thomas
