From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: =?UTF-8?q?=5BPATCHv2=5D=20l10n=3A=20de=2Epo=3A=20translate=2022=20new=20messages?=
Date: Tue,  4 Dec 2012 07:19:51 +0100
Message-ID: <1354601991-3523-1-git-send-email-ralf.thielow@gmail.com>
References: <50BCC0A3.4050203@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: trast@inf.ethz.ch, jk@jk.gs, stimming@tuhh.de, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@drmicha.warpmail.net
X-From: git-owner@vger.kernel.org Tue Dec 04 07:20:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tflrn-0005dp-7J
	for gcvg-git-2@plane.gmane.org; Tue, 04 Dec 2012 07:20:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023Ab2LDGUI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 4 Dec 2012 01:20:08 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39677 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750980Ab2LDGUH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Dec 2012 01:20:07 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so1407875bkw.19
        for <git@vger.kernel.org>; Mon, 03 Dec 2012 22:20:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=au7kf4j13I1sDA6zcK+f9t2n39G+6Uqa/IRnrT0OBSU=;
        b=pJ6vODIp32u0nmrUXiXDC5/aVklxfqTftTt5sNL0u6ubhGnIMLdpsTXaoHtaqM0QUL
         9CrfJW6OAH2zD0oZTWBBqkSTJU7pITVUvCopYxJh4G0fVfzEWpzP+eNAMYIn0fnV8pb2
         mbAhTIzo/SwNFBnwaRopEsasNLc/EKPoXwkEPJMRA0W5irSFJzLETVL1HuNrCya43o6w
         RKK8KGKgRw860eZ4tsgqmESzA0y2poIjIW9rGPp2iBR57giRXm1Mgkro4lDQYQHvkd5Q
         ceOTspfIyoB1vHuc+Qh3L3XW9X+D3VOGD4Avc2qoIRJWtBfy0AoNQVGfsLLKFlipfFi0
         lnAA==
Received: by 10.204.6.82 with SMTP id 18mr3570273bky.1.1354602005779;
        Mon, 03 Dec 2012 22:20:05 -0800 (PST)
Received: from localhost.localdomain (dslb-094-222-147-091.pools.arcor-ip.net. [94.222.147.91])
        by mx.google.com with ESMTPS id m20sm75622bkw.4.2012.12.03.22.20.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 03 Dec 2012 22:20:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0.1
In-Reply-To: <50BCC0A3.4050203@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211068>

Translate 22 new messages came from git.pot
updates in 9306b5b (l10n: Update git.pot (3 new,
6 removed messages)), fe52cd6 (l10n: Update git.pot
(14 new, 3 removed messages)) and f9472e3
(l10n: Update git.pot (5 new, 1 removed messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
Reviewed-by: Michael J Gruber <git@drmicha.warpmail.net>
---

Thanks for review!

>> -"  (benutze \"git am --abort\" um den urspr=C3=BCnglichen Zweig wie=
derherzustellen)"
>> +"  (benutze \"git pull\" um den externen Zweig mit Deinem zusammenz=
uf=C3=BChren)\n"
[...]
> BTW: Is there a standard about capitalising or not "Deine/Du" in de.p=
ot?
> I think I've seen both here. (New spelling after the reform(s)
> recommends du/deine but Sie/Ihr, me thinks.)

Usually it's written in lower case. But there are some original message=
s
starting with capital letters, in which case the translation does simpl=
y the
same. In this special case, "Deinem" was meant as a short for "dein Zwe=
ig".

Switching to formal addressing is a point on my TODO list.

Thanks,
Ralf

 po/de.po | 68 ++++++++++++++++++++++++++++++++++----------------------=
--------
 1 file changed, 36 insertions(+), 32 deletions(-)

diff --git a/po/de.po b/po/de.po
index a0bf3da..0e8ed54 100644
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
+"  (benutze \"git pull\" um deinen Zweig mit dem externen zusammenzuf=C3=
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
+"Unterprojekt '%s' (oder ein geschachteltes Unterprojekt hiervon) verw=
endet\n"
+"ein .git-Verzeichnis (benutze 'rm -rf' wenn du dieses wirklich mitsam=
t\n"
+"seiner Historie l=C3=B6schen m=C3=B6chtest)"
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
