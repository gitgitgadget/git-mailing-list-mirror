From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20l10n=3A=20de=2Epo=3A=20translate=2022=20new=20messages?=
Date: Mon,  3 Dec 2012 05:49:06 +0100
Message-ID: <1354510146-2919-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
To: trast@inf.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Mon Dec 03 05:49:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TfNyK-0007X4-2g
	for gcvg-git-2@plane.gmane.org; Mon, 03 Dec 2012 05:49:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755097Ab2LCEtU convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 2 Dec 2012 23:49:20 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:40996 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754952Ab2LCEtT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Dec 2012 23:49:19 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so838560bkw.19
        for <git@vger.kernel.org>; Sun, 02 Dec 2012 20:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=shMLZiAp+U1fAM4qxLVViZfcTrY5vjaG7ilMJO5DDGo=;
        b=R7Z9ft+DZN6ZCqNwsifCbl5X5yMYQjY64OEUVmiCMoQV79ythcxdqO9q8EceVUk5ms
         uvDCHv3zz36D8o5+0Q8qOjdMpY7ilR1eq51+Xn5vOA73/JvEc5a3n6wGbET5M7zHCAYq
         LmgSwp7I139QtIstu8JSNtqU0ECV+l+3YhD8hUHwhdBHBMF+er4Yt40v+ifhmtwNe8gs
         vTEdNrlTclbJEcKwJ2m0bpmlxM+RN8Ccf+9RevqWfEFGB/ZJM7nMngK33915OzRweAdN
         GqnqkiiTB+L4UtkA5StcB+a82yTxZU3+syazMp6+40rHJ21SHwL+jEhfbetmjrukPUE4
         S5Iw==
Received: by 10.204.148.22 with SMTP id n22mr2520181bkv.6.1354510158358;
        Sun, 02 Dec 2012 20:49:18 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-147-091.pools.arcor-ip.net. [94.222.147.91])
        by mx.google.com with ESMTPS id z5sm6210422bkv.11.2012.12.02.20.49.17
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 02 Dec 2012 20:49:17 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211027>

Translate 22 new messages came from git.pot
updates in 9306b5b (l10n: Update git.pot (3 new,
6 removed messages)), fe52cd6 (l10n: Update git.pot
(14 new, 3 removed messages)) and f9472e3
(l10n: Update git.pot (5 new, 1 removed messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 68 ++++++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/po/de.po b/po/de.po
index a0bf3da..7350818 100644
--- a/po/de.po
+++ b/po/de.po
@@ -5,7 +5,7 @@
 #
 msgid ""
 msgstr ""
-"Project-Id-Version: git 1.8.0\n"
+"Project-Id-Version: git 1.8.1\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
 "POT-Creation-Date: 2012-11-30 12:40+0800\n"
 "PO-Revision-Date: 2012-10-02 19:35+0200\n"
@@ -130,6 +130,8 @@ msgid ""
 "Negative patterns are forbidden in git attributes\n"
 "Use '\\!' for literal leading exclamation."
 msgstr ""
+"Verneinende Muster sind in Git-Attributen verboten.\n"
+"Benutze '\\!' f=C3=BCr f=C3=BChrende Ausrufezeichen."
=20
 #: bundle.c:36
 #, c-format
@@ -305,22 +307,21 @@ msgstr[0] "vor %lu Jahr"
 msgstr[1] "vor %lu Jahren"
=20
 #: diff.c:111
-#, fuzzy, c-format
+#, c-format
 msgid "  Failed to parse dirstat cut-off percentage '%s'\n"
 msgstr ""
-"  Fehler beim Parsen des abgeschnittenen \"dirstat\" Prozentsatzes '%=
=2E*s'\n"
+"  Fehler beim Parsen des abgeschnittenen \"dirstat\" Prozentsatzes '%=
s'\n"
=20
 #: diff.c:116
-#, fuzzy, c-format
+#, c-format
 msgid "  Unknown dirstat parameter '%s'\n"
-msgstr "  Unbekannter \"dirstat\" Parameter '%.*s'\n"
+msgstr "  Unbekannter \"dirstat\" Parameter '%s'\n"
=20
 #: diff.c:194
-#, fuzzy, c-format
+#, c-format
 msgid "Unknown value for 'diff.submodule' config variable: '%s'"
 msgstr ""
-"Fehler in 'diff.dirstat' Konfigurationsvariable gefunden:\n"
-"%s"
+"Unbekannter Wert in Konfigurationsvariable 'diff.dirstat': '%s'"
=20
 #: diff.c:237
 #, c-format
@@ -341,11 +342,10 @@ msgstr ""
 "%s"
=20
 #: diff.c:3508
-#, fuzzy, c-format
+#,  c-format
 msgid "Failed to parse --submodule option parameter: '%s'"
 msgstr ""
-"Fehler beim Parsen des --dirstat/-X Optionsparameters:\n"
-"%s"
+"Fehler beim Parsen des --submodule Optionsparameters: '%s'"
=20
 #: gpg-interface.c:59
 msgid "could not run gpg."
@@ -726,7 +726,7 @@ msgstr[1] "Dein Zweig ist vor '%s' um %d Versionen.=
\n"
=20
 #: remote.c:1637
 msgid "  (use \"git push\" to publish your local commits)\n"
-msgstr ""
+msgstr "  (benutze \"git push\" um deine lokalen Versionen herauszubri=
ngen)\n"
=20
 #: remote.c:1640
 #, c-format
@@ -740,10 +740,9 @@ msgstr[1] ""
 "werden.\n"
=20
 #: remote.c:1647
-#, fuzzy
 msgid "  (use \"git pull\" to update your local branch)\n"
 msgstr ""
-"  (benutze \"git am --abort\" um den urspr=C3=BCnglichen Zweig wieder=
herzustellen)"
+"  (benutze \"git pull\" um deinen lokalen Zweig zu aktualisieren)\n"
=20
 #: remote.c:1650
 #, c-format
@@ -761,10 +760,9 @@ msgstr[1] ""
 "und haben jeweils %d und %d unterschiedliche Versionen.\n"
=20
 #: remote.c:1659
-#, fuzzy
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
 msgstr ""
-"  (benutze \"git am --abort\" um den urspr=C3=BCnglichen Zweig wieder=
herzustellen)"
+"  (benutze \"git pull\" um den externen Zweig mit Deinem zusammenzuf=C3=
=BChren)\n"
=20
 #: sequencer.c:123 builtin/merge.c:761 builtin/merge.c:874 builtin/mer=
ge.c:984
 #: builtin/merge.c:994
@@ -2614,9 +2612,8 @@ msgid "git check-attr [-a | --all | attr...] [--]=
 pathname..."
 msgstr "git check-attr [-a | --all | Attribut...] [--] Pfadname..."
=20
 #: builtin/check-attr.c:12
-#, fuzzy
 msgid "git check-attr --stdin [-z] [-a | --all | attr...] < <list-of-p=
aths>"
-msgstr "git check-attr --stdin [-a | --all | Attribut...] < <Liste-von=
-Pfaden>"
+msgstr "git check-attr --stdin [-z] [-a | --all | Attribut...] < <List=
e-von-Pfaden>"
=20
 #: builtin/check-attr.c:19
 msgid "report all attributes set on file"
@@ -3596,9 +3593,8 @@ msgid "Paths with -a does not make sense."
 msgstr "Pfade mit -a machen keinen Sinn."
=20
 #: builtin/commit.c:1067 builtin/commit.c:1202
-#, fuzzy
 msgid "--long and -z are incompatible"
-msgstr "--column und -n sind inkompatibel"
+msgstr "--long und -z sind inkompatibel"
=20
 #: builtin/commit.c:1162 builtin/commit.c:1398
 msgid "show status concisely"
@@ -3613,9 +3609,8 @@ msgid "machine-readable output"
 msgstr "maschinenlesbare Ausgabe"
=20
 #: builtin/commit.c:1169 builtin/commit.c:1404
-#, fuzzy
 msgid "show status in long format (default)"
-msgstr "zeigt zwischengespeicherten Dateien in der Ausgabe an (Standar=
d)"
+msgstr "zeigt Status im Langformat (Standard)"
=20
 #: builtin/commit.c:1172 builtin/commit.c:1407
 msgid "terminate entries with NUL"
@@ -4789,7 +4784,7 @@ msgstr "zeigt nur =C3=9Cbereinstimmungen von Date=
ien, die allen Mustern entsprechen"
=20
 #: builtin/grep.c:736
 msgid "show parse tree for grep expression"
-msgstr ""
+msgstr "zeigt geparsten Baum f=C3=BCr \"grep\"-Ausdruck"
=20
 #: builtin/grep.c:740
 msgid "pager"
@@ -8029,6 +8024,9 @@ msgid ""
 "submodule '%s' (or one of its nested submodules) uses a .git director=
y\n"
 "(use 'rm -rf' if you really want to remove it including all of its hi=
story)"
 msgstr ""
+"Unterprojekt '%s' (oder ein geschachteltes Unterprojekt dessen) verwe=
ndet \n"
+"ein .git-Verzeichnis (benutze 'rm -rf' wenn du dieses wirklich mit se=
iner\n"
+"Historie l=C3=B6schen m=C3=B6chtest)"
=20
 #: builtin/rm.c:174
 #, c-format
@@ -8254,9 +8252,8 @@ msgid "git symbolic-ref [options] name [ref]"
 msgstr "git symbolic-ref [Optionen] name [ref]"
=20
 #: builtin/symbolic-ref.c:8
-#, fuzzy
 msgid "git symbolic-ref -d [-q] name"
-msgstr "git symbolic-ref [Optionen] name [ref]"
+msgstr "git symbolic-ref -d [-q] name"
=20
 #: builtin/symbolic-ref.c:40
 msgid "suppress error message for non-symbolic (detached) refs"
@@ -8264,9 +8261,8 @@ msgstr ""
 "unterdr=C3=BCckt Fehlermeldungen f=C3=BCr nicht-symbolische (losgel=C3=
=B6ste) Referenzen"
=20
 #: builtin/symbolic-ref.c:41
-#, fuzzy
 msgid "delete symbolic ref"
-msgstr "l=C3=B6scht ersetzende Referenzen"
+msgstr "l=C3=B6scht symbolische Referenzen"
=20
 #: builtin/symbolic-ref.c:42
 msgid "shorten ref output"
@@ -9207,7 +9203,8 @@ msgstr "Kein Neuaufbau im Gange?"
=20
 #: git-rebase.sh:312
 msgid "The --edit-todo action can only be used during interactive reba=
se."
-msgstr ""
+msgstr "Die --edit-todo Aktion kann nur w=C3=A4hrend eines interaktive=
n "
+"Neuaufbaus benutzt werden."
=20
 #: git-rebase.sh:319
 msgid "Cannot read HEAD"
@@ -9492,19 +9489,24 @@ msgstr "'$sm_path' existiert bereits und ist ke=
in g=C3=BCltiges Git-Projektarchiv"
 #: git-submodule.sh:365
 #, sh-format
 msgid "A git directory for '$sm_name' is found locally with remote(s):=
"
-msgstr ""
+msgstr "Ein Git-Verzeichnis f=C3=BCr '$sm_name' wurde lokal gefunden m=
it den "
+"Fernarchiv(en):"
=20
 #: git-submodule.sh:367
 #, sh-format
 msgid ""
 "If you want to reuse this local git directory instead of cloning agai=
n from"
 msgstr ""
+"Wenn du dieses lokale Git-Verzeichnis wiederverwenden m=C3=B6chtest, =
anstatt "
+"erneut zu klonen"
=20
 #: git-submodule.sh:369
 #, sh-format
 msgid ""
 "use the '--force' option. If the local git directory is not the corre=
ct repo"
 msgstr ""
+"benutze die Option '--force'. Wenn das lokale Git-Verzeichnis nicht d=
as "
+"korrekte Projektarchiv ist"
=20
 #: git-submodule.sh:370
 #, sh-format
@@ -9512,11 +9514,13 @@ msgid ""
 "or you are unsure what this means choose another name with the '--nam=
e' "
 "option."
 msgstr ""
+"oder du dir unsicher bist, was das bedeutet, w=C3=A4hle einen anderen=
 Namen mit "
+"der Option '--name'."
=20
 #: git-submodule.sh:372
 #, sh-format
 msgid "Reactivating local git directory for submodule '$sm_name'."
-msgstr ""
+msgstr "Reaktiviere lokales Git-Verzeichnis f=C3=BCr Unterprojekt '$sm=
_name'."
=20
 #: git-submodule.sh:384
 #, sh-format
@@ -9659,9 +9663,9 @@ msgid "# Submodule changes to be committed:"
 msgstr "# =C3=84nderungen in Unterprojekt zum Eintragen:"
=20
 #: git-submodule.sh:1080
-#, fuzzy, sh-format
+#, sh-format
 msgid "Synchronizing submodule url for '$prefix$sm_path'"
-msgstr "Synchronisiere Unterprojekt-URL f=C3=BCr '$name'"
+msgstr "Synchronisiere Unterprojekt-URL f=C3=BCr '$prefix$sm_path'"
=20
 #~ msgid " 0 files changed"
 #~ msgstr " 0 Dateien ge=C3=A4ndert"
--=20
1.8.0.1
