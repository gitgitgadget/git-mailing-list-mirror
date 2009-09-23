From: Thiago Farina <tfransosi@gmail.com>
Subject: [PATCH] Documentation - pt-BR.
Date: Wed, 23 Sep 2009 14:25:39 -0400
Message-ID: <1253730339-11146-1-git-send-email-tfransosi@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 23 20:27:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MqWYN-0004Ln-0i
	for gcvg-git-2@lo.gmane.org; Wed, 23 Sep 2009 20:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753210AbZIWS0s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Sep 2009 14:26:48 -0400
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
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752962AbZIWS0r
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Sep 2009 14:26:47 -0400
Received: from qw-out-2122.google.com ([74.125.92.25]:9474 "EHLO
	qw-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbZIWS0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Sep 2009 14:26:43 -0400
Received: by qw-out-2122.google.com with SMTP id 5so346793qwd.37
        for <git@vger.kernel.org>; Wed, 23 Sep 2009 11:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=sYyxsy+ZSW5qgs1DdUWIqExNjjdbJwytv0jZY224irk=;
        b=L67l4bWaybDB/pypd5fKfFM4T+FGPakqSYvRKWqZdkoLpysrG2HRUo8x6bbLwSW6z+
         HAjJ4z/9OJCMuyTAp9NULi6gULJdSYUt6/c0gOCV0+HuYKVDU8A30CviGPlt2DwuytIH
         3HzkIezxm3NCPYV2yTVQokYTBVIh2JCKLYiwI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=MlWKgqIXMl64siGfbwMmVgnkCXfNpBorhQuZ92G/w+gpHPoiM1sSzWmm64wEM0+qxR
         GZGcYYuorHUiHu9rTAYNrkb0o1m2ecII9edqvI8X6YMEO6uLvhxnnkJ52KJws3FCrCYD
         quTbttSNcZx3zzO/IVt4ZHhKEgzqIsrjqCEpM=
Received: by 10.224.12.141 with SMTP id x13mr2259370qax.337.1253730405067;
        Wed, 23 Sep 2009 11:26:45 -0700 (PDT)
Received: from localhost ([189.60.49.26])
        by mx.google.com with ESMTPS id 7sm62170qwb.14.2009.09.23.11.26.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 23 Sep 2009 11:26:44 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc1.44.ga1675
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128988>

Translate some english words to portuguese and fix some typos on transl=
ation.

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Documentation/pt_BR/gittutorial.txt |   22 +++++++++++-----------
 1 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/pt_BR/gittutorial.txt b/Documentation/pt_BR/=
gittutorial.txt
index 81e7ad7..6fb396a 100644
--- a/Documentation/pt_BR/gittutorial.txt
+++ b/Documentation/pt_BR/gittutorial.txt
@@ -1,15 +1,15 @@
 gittutorial(7)
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-NAME
+NOME
 ----
 gittutorial - Um tutorial de introdu=C3=A7=C3=A3o ao git (para vers=C3=
=A3o 1.5.1 ou mais nova)
=20
-SYNOPSIS
+SINOPSE
 --------
 git *
=20
-DESCRIPTION
+DESCRI=C3=87=C3=83O
 -----------
=20
 Este tutorial explica como importar um novo projeto para o git,
@@ -64,11 +64,11 @@ Git ir=C3=A1 responder
 Initialized empty Git repository in .git/
 ------------------------------------------------
=20
-Voc=C3=AA agora iniciou seu diret=C3=B3rio de trabalho--voc=C3=AA deve=
 ter notado um
-novo diret=C3=B3rio criado, com o nome de ".git".
+Agora que voc=C3=AA iniciou seu diret=C3=B3rio de trabalho, voc=C3=AA =
deve ter notado que um
+novo diret=C3=B3rio foi criado com o nome de ".git".
=20
 A seguir, diga ao git para gravar um instant=C3=A2neo do conte=C3=BAdo=
 de todos os
-arquivos sob o diret=C3=B3rio corrente (note o '.'), com 'git-add':
+arquivos sob o diret=C3=B3rio atual (note o '.'), com 'git-add':
=20
 ------------------------------------------------
 $ git add .
@@ -126,8 +126,8 @@ mudan=C3=A7as com:
 $ git commit
 ------------------------------------------------
=20
-Isto ir=C3=A1 novamente te pedir por uma mensagem descrevendo a mudan=C3=
=A7a, e,
-ent=C3=A3o, gravar a nova vers=C3=A3o do projeto.
+Ao executar esse comando, ele ir=C3=A1 te pedir uma mensagem descreven=
do a mudan=C3=A7a,
+e, ent=C3=A3o, ir=C3=A1 gravar a nova vers=C3=A3o do projeto.
=20
 Alternativamente, ao inv=C3=A9s de executar 'git-add' antes, voc=C3=AA=
 pode usar
=20
@@ -143,7 +143,7 @@ id=C3=A9ia come=C3=A7ar a mensagem com uma simples =
e curta (menos de 50
 caracteres) linha sumarizando a mudan=C3=A7a, seguida de uma linha em =
branco
 e, ent=C3=A3o, uma descri=C3=A7=C3=A3o mais detalhada. Ferramentas que=
 transformam
 commits em email, por exemplo, usam a primeira linha no campo de
-cabe=C3=A7alho Subject: e o resto no corpo.
+cabe=C3=A7alho "Assunto:", e o resto no corpo.
=20
 Git rastreia conte=C3=BAdo, n=C3=A3o arquivos
 ----------------------------
@@ -155,7 +155,7 @@ usado tanto para arquivos novos e arquivos recentem=
ente modificados, e
 em ambos os casos, ele tira o instant=C3=A2neo dos arquivos dados e ar=
mazena
 o conte=C3=BAdo no =C3=ADndice, pronto para inclus=C3=A3o do pr=C3=B3x=
imo commit.
=20
-Visualizando hist=C3=B3ria do projeto
+Visualizando a hist=C3=B3ria do projeto
 -----------------------
=20
 Em qualquer ponto voc=C3=AA pode visualizar a hist=C3=B3ria das suas m=
udan=C3=A7as
@@ -165,7 +165,7 @@ usando
 $ git log
 ------------------------------------------------
=20
-Se voc=C3=AA tamb=C3=A9m quer ver a diferen=C3=A7a completa a cada pas=
so, use
+Se voc=C3=AA tamb=C3=A9m quiser ver a diferen=C3=A7a completa a cada p=
asso, use
=20
 ------------------------------------------------
 $ git log -p
--=20
1.6.5.rc1.44.ga1675
