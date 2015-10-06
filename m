From: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] gitk: l10n: Update Catalan translation
Date: Mon,  5 Oct 2015 22:26:12 -0600
Message-ID: <1444105572-20580-1-git-send-email-alexhenrie24@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Henrie <alexhenrie24@gmail.com>
To: paulus@samba.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 06 06:27:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjJq9-0003uu-Ae
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 06:27:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751278AbbJFE0a convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 00:26:30 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36814 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009AbbJFE03 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Oct 2015 00:26:29 -0400
Received: by pablk4 with SMTP id lk4so196421830pab.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 21:26:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=gVpLAnuldcqkqlfZwC68w70B+4V0mzPimZ4M6XOOhxI=;
        b=bqBpdbojfY+ltUvv4S99Iq5fDssXG1tJg6SHjCj1LsIN411L+oitDEDVYhff0gOsff
         qaPpXpyasusewh5RDZaoHBCw15qi8e8pVMWaNiI9Z344KQUl2z435UUytJUuhm2NA3OV
         uYp9LmLz2MmXqacA3nc0kgjmwc74+PTjnCNK2QuzupKmn+iJbV4q9dJ4HL/Fd45QVsMw
         De6cqbdTge0F1UmlIIw5GD+V/jkirq6KwDX2hvFVorTJrt7sIHLJLkRvgAspcT7tVp5M
         FBAzTH2uQxP7+YiCtsVbybX5RQUZlhdUQznBSglwgCnmcJAq6xDGMCErr4tDw+EiOfaj
         OGkQ==
X-Received: by 10.67.5.66 with SMTP id ck2mr44468816pad.137.1444105588492;
        Mon, 05 Oct 2015 21:26:28 -0700 (PDT)
Received: from alex-wolverine.lan ([2601:681:4d04:75d8:e8b:fdff:fecc:2734])
        by smtp.gmail.com with ESMTPSA id y5sm30468519pbt.77.2015.10.05.21.26.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 05 Oct 2015 21:26:27 -0700 (PDT)
X-Mailer: git-send-email 2.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279116>

The gitk included in git 2.6.0 crashes if run from a Catalan locale.
I'm hoping that a translation update will fix this.

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 po/ca.po | 53 +++++++++++++++++++++++++----------------------------
 1 file changed, 25 insertions(+), 28 deletions(-)

diff --git a/po/ca.po b/po/ca.po
index 976037a..1106a30 100644
--- a/po/ca.po
+++ b/po/ca.po
@@ -9,7 +9,7 @@ msgstr ""
 "Project-Id-Version: gitk\n"
 "Report-Msgid-Bugs-To: \n"
 "POT-Creation-Date: 2015-05-17 14:32+1000\n"
-"PO-Revision-Date: 2015-02-01 22:49-0700\n"
+"PO-Revision-Date: 2015-10-05 22:23-0600\n"
 "Last-Translator: Alex Henrie <alexhenrie24@gmail.com>\n"
 "Language-Team: Catalan\n"
 "Language: ca\n"
@@ -17,7 +17,7 @@ msgstr ""
 "Content-Type: text/plain; charset=3DUTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=3D2; plural=3D(n !=3D 1);\n"
-"X-Generator: Poedit 1.7.3\n"
+"X-Generator: Poedit 1.8.5\n"
=20
 #: gitk:140
 msgid "Couldn't get list of unmerged files:"
@@ -136,7 +136,7 @@ msgstr "Edita la vista..."
=20
 #: gitk:2086
 msgid "Delete view"
-msgstr "Suprimeix vista"
+msgstr "Suprimeix la vista"
=20
 #: gitk:2088 gitk:4043
 msgid "All files"
@@ -330,7 +330,7 @@ msgstr "Elimina aquesta branca"
=20
 #: gitk:2649
 msgid "Copy branch name"
-msgstr ""
+msgstr "Copia el nom de branca"
=20
 #: gitk:2656
 msgid "Highlight this too"
@@ -350,7 +350,7 @@ msgstr "Culpabilitat de la comissi=C3=B3 mare"
=20
 #: gitk:2660
 msgid "Copy path"
-msgstr ""
+msgstr "Copia el cam=C3=AD"
=20
 #: gitk:2667
 msgid "Show origin of this line"
@@ -408,11 +408,11 @@ msgstr "<Fi>\t\tV=C3=A9s a l'=C3=BAltima comissi=C3=
=B3"
=20
 #: gitk:3052
 msgid "<Up>, p, k\tMove up one commit"
-msgstr "<Amunt>, p, k\tMou-te una comissi=C3=B3 amunt"
+msgstr "<Amunt>, p, k\tMou-te cap amunt per una comissi=C3=B3"
=20
 #: gitk:3053
 msgid "<Down>, n, j\tMove down one commit"
-msgstr "<Avall>, n, j\tMou-te una comissi=C3=B3 avall"
+msgstr "<Avall>, n, j\tMou-te cap avall per una comissi=C3=B3"
=20
 #: gitk:3054
 msgid "<Left>, z, h\tGo back in history list"
@@ -430,11 +430,11 @@ msgstr ""
=20
 #: gitk:3057
 msgid "<PageUp>\tMove up one page in commit list"
-msgstr "<ReP=C3=A0g>\tBaixa una p=C3=A0gina en la llista de comissions=
"
+msgstr "<ReP=C3=A0g>\tMou-te cap amunt per una p=C3=A0gina en la llist=
a de comissions"
=20
 #: gitk:3058
 msgid "<PageDown>\tMove down one page in commit list"
-msgstr "<AvP=C3=A0g>\tBaixa per una p=C3=A0gina en la llista de comiss=
ions"
+msgstr "<AvP=C3=A0g>\tMou-te cap avall per una p=C3=A0gina en la llist=
a de comissions"
=20
 #: gitk:3059
 #, tcl-format
@@ -449,50 +449,50 @@ msgstr "<%s-Fi>\tDespla=C3=A7a't a la part inferi=
or de la llista de comissions"
 #: gitk:3061
 #, tcl-format
 msgid "<%s-Up>\tScroll commit list up one line"
-msgstr "<%s-Amunt>\tDespla=C3=A7a la llista de comissions una l=C3=ADn=
ia cap amunt"
+msgstr "<%s-Amunt>\tDespla=C3=A7a la llista de comissions cap amunt pe=
r una l=C3=ADnia"
=20
 #: gitk:3062
 #, tcl-format
 msgid "<%s-Down>\tScroll commit list down one line"
-msgstr "<%s-Avall>\tDespla=C3=A7a la llista de comissions una l=C3=ADn=
ia cap avall"
+msgstr "<%s-Avall>\tDespla=C3=A7a la llista de comissions cap avall pe=
r una l=C3=ADnia"
=20
 #: gitk:3063
 #, tcl-format
 msgid "<%s-PageUp>\tScroll commit list up one page"
-msgstr "<%s-ReP=C3=A0g>\tDespla=C3=A7a la llista de comissions amunt p=
er una p=C3=A0gina"
+msgstr "<%s-ReP=C3=A0g>\tDespla=C3=A7a la llista de comissions cap amu=
nt per una p=C3=A0gina"
=20
 #: gitk:3064
 #, tcl-format
 msgid "<%s-PageDown>\tScroll commit list down one page"
-msgstr "<%s-AvP=C3=A0g>\tDespla=C3=A7a la llista de comissions una p=C3=
=A0gina cap avall"
+msgstr "<%s-AvP=C3=A0g>\tDespla=C3=A7a la llista de comissions cap ava=
ll per una p=C3=A0gina"
=20
 #: gitk:3065
 msgid "<Shift-Up>\tFind backwards (upwards, later commits)"
-msgstr "<Maj-Amunt>\tCerca cap enrere (amunt, les comissions m=C3=A9s =
noves)"
+msgstr "<Maj-Amunt>\tCerca cap enrere (cap amunt, les comissions m=C3=A9=
s noves)"
=20
 #: gitk:3066
 msgid "<Shift-Down>\tFind forwards (downwards, earlier commits)"
-msgstr "<Maj-Avall>\tCerca cap endavant (avall, les comissions m=C3=A9=
s velles)"
+msgstr "<Maj-Avall>\tCerca cap endavant (cap avall, les comissions m=C3=
=A9s velles)"
=20
 #: gitk:3067
 msgid "<Delete>, b\tScroll diff view up one page"
-msgstr "<Supr>, b\tDespla=C3=A7a la vista de difer=C3=A8ncia una p=C3=A0=
gina cap amunt"
+msgstr "<Supr>, b\tDespla=C3=A7a la vista de difer=C3=A8ncia cap amunt=
 per una p=C3=A0gina"
=20
 #: gitk:3068
 msgid "<Backspace>\tScroll diff view up one page"
-msgstr "<Retroc=C3=A9s>\tDespla=C3=A7a la vista de difer=C3=A8ncia una=
 p=C3=A0gina cap amunt"
+msgstr "<Retroc=C3=A9s>\tDespla=C3=A7a la vista de difer=C3=A8ncia cap=
 amunt per una p=C3=A0gina"
=20
 #: gitk:3069
 msgid "<Space>\t\tScroll diff view down one page"
-msgstr "<Espai>\t\tDespla=C3=A7a la vista de difer=C3=A8ncia una p=C3=A0=
gina cap avall"
+msgstr "<Espai>\t\tDespla=C3=A7a la vista de difer=C3=A8ncia cap avall=
 per una p=C3=A0gina"
=20
 #: gitk:3070
 msgid "u\t\tScroll diff view up 18 lines"
-msgstr "u\t\tDespla=C3=A7a la vista de difer=C3=A8ncia 18 l=C3=ADnies =
cap amunt"
+msgstr "u\t\tDespla=C3=A7a la vista de difer=C3=A8ncia cap amunt per 1=
8 l=C3=ADnies"
=20
 #: gitk:3071
 msgid "d\t\tScroll diff view down 18 lines"
-msgstr "d\t\tDespla=C3=A7a la vista de difer=C3=A8ncia 18 l=C3=ADnies =
cap avall "
+msgstr "d\t\tDespla=C3=A7a la vista de difer=C3=A8ncia cap avall per 1=
8 l=C3=ADnies"
=20
 #: gitk:3072
 #, tcl-format
@@ -509,9 +509,8 @@ msgid "<Return>\tMove to next find hit"
 msgstr "<Retorn>\tMou-te a la propera coincid=C3=A8ncia de la cerca"
=20
 #: gitk:3075
-#, fuzzy
 msgid "g\t\tGo to commit"
-msgstr "<Fi>\t\tV=C3=A9s a l'=C3=BAltima comissi=C3=B3"
+msgstr "g\t\tV=C3=A9s a l'=C3=BAltima comissi=C3=B3"
=20
 #: gitk:3076
 msgid "/\t\tFocus the search box"
@@ -668,9 +667,8 @@ msgid "Matches all Commit Info criteria"
 msgstr "Coincideix amb tots els criteris d'informaci=C3=B3 de comissi=C3=
=B3"
=20
 #: gitk:4086
-#, fuzzy
 msgid "Matches no Commit Info criteria"
-msgstr "Coincideix amb tots els criteris d'informaci=C3=B3 de comissi=C3=
=B3"
+msgstr "No coincideix amb cap criteri d'informaci=C3=B3 de comissi=C3=B3=
"
=20
 #: gitk:4087
 msgid "Changes to Files:"
@@ -1310,7 +1308,7 @@ msgstr "fons de la l=C3=ADnia marcada"
=20
 #: gitk:11450
 msgid "Select bg"
-msgstr "fons de la selecci=C3=B3"
+msgstr "Fons de la selecci=C3=B3"
=20
 #: gitk:11459
 msgid "Fonts: press to choose"
@@ -1354,6 +1352,8 @@ msgid ""
 "Sorry, gitk cannot run with this version of Tcl/Tk.\n"
 " Gitk requires at least Tcl/Tk 8.4."
 msgstr ""
+"Perd=C3=B3, el gitk no pot executar-se amb aquesta versi=C3=B3 de Tcl=
/Tk.\n"
+" El Gitk requereix com a m=C3=ADnim el Tcl/Tk 8.4."
=20
 #: gitk:12269
 msgid "Cannot find a git repository here."
@@ -1367,6 +1367,3 @@ msgstr "Par=C3=A0metre ambigu '%s': =C3=A9s tant =
revisi=C3=B3 com nom de fitxer"
 #: gitk:12328
 msgid "Bad arguments to gitk:"
 msgstr "Par=C3=A0metres dolents al gitk:"
-
-#~ msgid "mc"
-#~ msgstr "mc"
--=20
2.6.0
