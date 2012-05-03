From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20de=2Epo=3A=20collection=20of=20fixes?=
Date: Thu,  3 May 2012 22:09:34 +0200
Message-ID: <1336075774-8447-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs
X-From: git-owner@vger.kernel.org Thu May 03 22:09:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQ2Lc-0006TK-Rz
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 22:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758162Ab2ECUJv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 May 2012 16:09:51 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:55484 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754586Ab2ECUJt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2012 16:09:49 -0400
Received: by wibhj6 with SMTP id hj6so718265wib.1
        for <git@vger.kernel.org>; Thu, 03 May 2012 13:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=W1Uc17Evm4Nj0ypnqBZajFBZ67S2Ac+mogErDGU+78M=;
        b=04uBY/xrts7cS5iCU7bUADQ2J+nOIGWwyRfX65vEfXMX7K9tz9QLUJA2sMN78vjzti
         B26KrGznStpaTnjXEit21F7V9QTCq8yek8ltHqIm4b+q4flxmvRSh3UdQRmV1+fAef0F
         qe1wGub86uHCL8k6uigp9qgRSVcSoPWndv8UR8gddGKVw8mCsKKB5zcIopmbhgDvi0Jq
         T/d4dXMQlBcNm+eRKBTk+Vm1CdJtcQ32CTFTaFrwfO+DXy2tCoS8TyieRKA1nUNCUA8h
         TQekc4OG7IjkQZtNO7AOR0d5egGm3TwfseUIqAI2vcHqv6tye3DPD1p1BGT0y/10MlPm
         4pLA==
Received: by 10.180.83.38 with SMTP id n6mr7626734wiy.1.1336075787637;
        Thu, 03 May 2012 13:09:47 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id e6sm1983272wix.8.2012.05.03.13.09.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 May 2012 13:09:46 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.67.g0b77
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196952>

A long list of fixes from spelling to grammar over
the whole file.

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |  437 +++++++++++++++++++++++++++++++-----------------------=
--------
 1 Datei ge=C3=A4ndert, 221 Zeilen hinzugef=C3=BCgt(+), 216 Zeilen entf=
ernt(-)

diff --git a/po/de.po b/po/de.po
index abb719b..543678e 100644
--- a/po/de.po
+++ b/po/de.po
@@ -41,7 +41,7 @@ msgstr ""
 #: commit.c:47
 #, c-format
 msgid "could not parse %s"
-msgstr "konnte %s nicht parsen"
+msgstr "%s konnte nicht geparst werden"
=20
 #: commit.c:49
 #, c-format
@@ -135,7 +135,7 @@ msgstr "gpg beim Signieren der Daten fehlgeschlagen=
"
 #: grep.c:1280
 #, c-format
 msgid "'%s': unable to read %s"
-msgstr "'%s': konnte nicht lesen %s"
+msgstr "'%s': %s konnte nicht gelesen werden"
=20
 #: grep.c:1297
 #, c-format
@@ -192,7 +192,7 @@ msgstr[1] ""
 #: builtin/merge.c:1095 builtin/merge.c:1105
 #, c-format
 msgid "Could not open '%s' for writing"
-msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
+msgstr "'%s' konnte nicht zum Schreiben ge=C3=B6ffnet werden."
=20
 #: sequencer.c:122 builtin/merge.c:334 builtin/merge.c:867
 #: builtin/merge.c:1097 builtin/merge.c:1110
@@ -215,18 +215,18 @@ msgid ""
 "and commit the result with 'git commit'"
 msgstr ""
 "nach Aufl=C3=B6sung der Konflikte, markiere die korrigierten Pfade\n"
-"mit 'git add <Pfade>' oder 'git rm <Pfade>'und trage das Ergebnis ein=
 mit "
-"'git commit'"
+"mit 'git add <Pfade>' oder 'git rm <Pfade>'und trage das Ergebnis mit=
 "
+"'git commit' ein"
=20
 #: sequencer.c:159 sequencer.c:685 sequencer.c:768
 #, c-format
 msgid "Could not write to %s"
-msgstr "Konnte nicht nach %s schreiben"
+msgstr "Konnte nicht nach '%s' schreiben"
=20
 #: sequencer.c:162
 #, c-format
 msgid "Error wrapping up %s"
-msgstr "Fehler bei Nachbereitung von %s"
+msgstr "Fehler bei Nachbereitung von '%s'"
=20
 #: sequencer.c:177
 msgid "Your local changes would be overwritten by cherry-pick."
@@ -245,7 +245,7 @@ msgstr "Trage deine =C3=84nderungen ein oder benutz=
e \"stash\" um fortzufahren."
 #: sequencer.c:232
 #, c-format
 msgid "%s: Unable to write new index file"
-msgstr "%s: Konnte neue Bereitstellungsdatei nicht schreiben"
+msgstr "%s: neue Bereitstellungsdatei konnte nicht geschrieben werden"
=20
 #: sequencer.c:298
 msgid "Your index file is unmerged."
@@ -259,7 +259,7 @@ msgstr "Du hast keine g=C3=BCltige Zweigspitze (HEA=
D)"
 #, c-format
 msgid "Commit %s is a merge but no -m option was given."
 msgstr ""
-"Version %s ist eine Zusammenf=C3=BChrung, aber es wurde keine Option =
-m angegeben."
+"Version %s ist eine Zusammenf=C3=BChrung, aber die Option -m wurde ni=
cht angegeben."
=20
 #: sequencer.c:324
 #, c-format
@@ -277,7 +277,7 @@ msgstr ""
 #: sequencer.c:339
 #, c-format
 msgid "%s: cannot parse parent commit %s"
-msgstr "%s: kann Elternversion %s nicht parsen"
+msgstr "%s: Elternversion %s konnte nicht geparst werden"
=20
 #: sequencer.c:343
 #, c-format
@@ -317,12 +317,12 @@ msgstr "git %s: Fehler beim Aktualisieren der Ber=
eitstellung"
 #: sequencer.c:551
 #, c-format
 msgid "Cannot %s during a %s"
-msgstr "Kann %s nicht w=C3=A4hrend eines %s durchf=C3=BChren"
+msgstr "Kann '%s' nicht w=C3=A4hrend eines '%s' durchf=C3=BChren"
=20
 #: sequencer.c:573
 #, c-format
 msgid "Could not parse line %d."
-msgstr "Konnte Zeile %d nicht parsen."
+msgstr "Zeile %d konnte nicht geparst werden."
=20
 #: sequencer.c:578
 msgid "No commits parsed."
@@ -374,7 +374,7 @@ msgstr "Konnte \"sequencer\"-Verzeichnis %s nicht e=
rstellen"
 #: sequencer.c:687 sequencer.c:772
 #, c-format
 msgid "Error wrapping up %s."
-msgstr "Fehler beim Einpacken von %s."
+msgstr "Fehler beim Einpacken von '%s'."
=20
 #: sequencer.c:706 sequencer.c:840
 msgid "no cherry-pick or revert in progress"
@@ -391,12 +391,12 @@ msgstr "kann nicht abbrechen: bin auf einem Zweig=
, der noch geboren wird"
 #: sequencer.c:732
 #, c-format
 msgid "cannot open %s: %s"
-msgstr "Kann %s nicht =C3=B6ffnen: %s"
+msgstr "Kann '%s' nicht =C3=B6ffnen: %s"
=20
 #: sequencer.c:735
 #, c-format
 msgid "cannot read %s: %s"
-msgstr "Kann %s nicht lesen: %s"
+msgstr "Kann '%s' nicht lesen: %s"
=20
 #: sequencer.c:736
 msgid "unexpected end of file"
@@ -411,7 +411,7 @@ msgstr "gespeicherte \"pre-cherry-pick\" Datei der =
Zweigspitze (HEAD) '%s' "
 #: sequencer.c:765
 #, c-format
 msgid "Could not format %s."
-msgstr "Konnte %s nicht formatieren."
+msgstr "'%s' konnte nicht formatiert werden."
=20
 #: sequencer.c:927
 msgid "Can't revert as initial commit"
@@ -419,7 +419,7 @@ msgstr "Kann nicht zu initialer Version zur=C3=BCck=
setzen."
=20
 #: sequencer.c:928
 msgid "Can't cherry-pick into empty head"
-msgstr "Kann \"cherry-pick\" nicht in einen leeren Kopf ausf=C3=BChren=
=2E"
+msgstr "\"cherry-pick\" kann nicht in einem leeren Zweig ausgef=C3=BCh=
rt werden."
=20
 #: wt-status.c:134
 msgid "Unmerged paths:"
@@ -634,7 +634,7 @@ msgstr " (Erstelle/Kopiere Dateien und benutze \"gi=
t add\" zum Verfolgen)"
=20
 #: wt-status.c:773
 msgid " (use -u to show untracked files)"
-msgstr " (benutze -u um unverfolgte Dateien anzuzeigen)"
+msgstr " (benutze die Option -u um unverfolgte Dateien anzuzeigen)"
=20
 #: wt-status.c:776
 msgid " (working directory clean)"
@@ -667,7 +667,7 @@ msgstr "unerwarteter Differenz-Status %c"
=20
 #: builtin/add.c:67 builtin/commit.c:298
 msgid "updating files failed"
-msgstr "Aktualisierung von Dateien fehlgeschlagen"
+msgstr "Aktualisierung der Dateien fehlgeschlagen"
=20
 #: builtin/add.c:77
 #, c-format
@@ -701,11 +701,11 @@ msgstr "Konnte die Bereitstellung nicht lesen"
 #: builtin/add.c:286
 #, c-format
 msgid "Could not open '%s' for writing."
-msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
+msgstr "'%s' konnte nicht zum Schreiben ge=C3=B6ffnet werden."
=20
 #: builtin/add.c:290
 msgid "Could not write patch"
-msgstr "Konnte Patch nicht schreiben"
+msgstr "Patch konnte nicht geschrieben werden"
=20
 #: builtin/add.c:295
 #, c-format
@@ -719,7 +719,7 @@ msgstr "Leerer Patch. Abgebrochen."
 #: builtin/add.c:303
 #, c-format
 msgid "Could not apply '%s'"
-msgstr "Konnte '%s' nicht anwenden."
+msgstr "'%s' konnte nicht angewendet werden."
=20
 #: builtin/add.c:312
 msgid "The following paths are ignored by one of your .gitignore files=
:\n"
@@ -766,16 +766,16 @@ msgstr "Bereitstellungsdatei besch=C3=A4digt"
=20
 #: builtin/add.c:476 builtin/mv.c:229 builtin/rm.c:260
 msgid "Unable to write new index file"
-msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
+msgstr "Neue Bereitstellungsdatei konnte nicht geschrieben werden."
=20
 #: builtin/archive.c:17
 #, c-format
 msgid "could not create archive file '%s'"
-msgstr "Konnte Archiv-Datei '%s' nicht erstellen."
+msgstr "Archiv-Datei '%s' konnte nicht erstellt werden."
=20
 #: builtin/archive.c:20
 msgid "could not redirect output"
-msgstr "Konnte Ausgabe nicht umleiten."
+msgstr "Ausgabe konnte nicht umgeleitet werden."
=20
 #: builtin/archive.c:37
 msgid "git archive: Remote with no URL"
@@ -809,7 +809,7 @@ msgid ""
 "deleting branch '%s' that has been merged to\n"
 "         '%s', but not yet merged to HEAD."
 msgstr ""
-"entferne Zweig '%s' der zusammengef=C3=BChrt wurde mit\n"
+"entferne Zweig '%s', der zusammengef=C3=BChrt wurde mit\n"
 "         '%s', aber noch nicht mit der Zweigspitze (HEAD) zusammengef=
=C3=BChrt "
 "wurde."
=20
@@ -819,7 +819,7 @@ msgid ""
 "not deleting branch '%s' that is not yet merged to\n"
 "         '%s', even though it is merged to HEAD."
 msgstr ""
-"entferne nicht Zweig '%s' der noch nicht zusammengef=C3=BChrt wurde m=
it\n"
+"entferne Zweig '%s' nicht, der noch nicht zusammengef=C3=BChrt wurde =
mit\n"
 "         '%s', obwohl er mit der Zweigspitze (HEAD) zusammengef=C3=BC=
hrt wurde."
=20
 #. TRANSLATORS: This is "remote " in "remote branch '%s' not found"
@@ -838,7 +838,7 @@ msgstr "Konnte Versionsobjekt f=C3=BCr Zweigspitze =
(HEAD) nicht nachschlagen."
 #: builtin/branch.c:182
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
-msgstr "Kann Zweig '%s' nicht entfernen auf dem du dich gerade befinde=
st."
+msgstr "Kann Zweig '%s' nicht entfernen, da du dich gerade auf diesem =
befindest."
=20
 #: builtin/branch.c:192
 #, c-format
@@ -966,7 +966,7 @@ msgstr "Um ein Paket zu erstellen wird ein Projekta=
rchiv ben=C3=B6tigt."
=20
 #: builtin/bundle.c:60
 msgid "Need a repository to unbundle."
-msgstr "Zum Zerlegen wird ein Projektarchiv ben=C3=B6tigt."
+msgstr "Zum Entpacken wird ein Projektarchiv ben=C3=B6tigt."
=20
 #: builtin/checkout.c:113 builtin/checkout.c:146
 #, c-format
@@ -991,7 +991,7 @@ msgstr "Pfad '%s' hat nicht die notwendigen Version=
en."
 #: builtin/checkout.c:192
 #, c-format
 msgid "path '%s': cannot merge"
-msgstr "Pfad '%s': kann nicht zusammenf=C3=BChren"
+msgstr "Pfad '%s' konnte nicht zusammengef=C3=BChrt werden"
=20
 #: builtin/checkout.c:209
 #, c-format
@@ -1015,7 +1015,7 @@ msgstr "Pfad '%s' ist nicht zusammengef=C3=BChrt.=
"
 #: builtin/checkout.c:302 builtin/checkout.c:498 builtin/clone.c:583
 #: builtin/merge.c:811
 msgid "unable to write new index file"
-msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
+msgstr "Neue Bereitstellungsdatei konnte nicht geschrieben werden."
=20
 #: builtin/checkout.c:319 builtin/diff.c:302 builtin/merge.c:408
 msgid "diff_setup_done failed"
@@ -1028,7 +1028,7 @@ msgstr "Du musst zuerst deine aktuelle Bereitstel=
lung aufl=C3=B6sen."
 #: builtin/checkout.c:533
 #, c-format
 msgid "Can not do reflog for '%s'\n"
-msgstr "Konnte \"reflog\" f=C3=BCr '%s' nicht durchf=C3=BChren\n"
+msgstr "\"reflog\" konnte nicht f=C3=BCr '%s' durchgef=C3=BChrt werden=
\n"
=20
 #: builtin/checkout.c:565
 msgid "HEAD is now at"
@@ -1113,7 +1113,7 @@ msgstr "Vorherige Position der Zweigspitze (HEAD)=
 war"
=20
 #: builtin/checkout.c:722
 msgid "You are on a branch yet to be born"
-msgstr "Du bist auf einem Zweig, der noch nicht geboren wurde."
+msgstr "du bist auf einem Zweig, der noch geboren wird"
=20
 #. case (1)
 #: builtin/checkout.c:853
@@ -1173,16 +1173,16 @@ msgid ""
 "git checkout: updating paths is incompatible with switching branches.=
\n"
 "Did you intend to checkout '%s' which can not be resolved as commit?"
 msgstr ""
-"git checkout: Aktualisierung der Pfade ist inkompatibel mit dem Wechs=
el von "
-"Zweigen.\n"
+"git checkout: Die Aktualisierung von Pfaden ist inkompatibel mit dem =
Wechsel "
+"von Zweigen.\n"
 "Hast du beabsichtigt '%s' auszuchecken, welcher nicht als Version auf=
gel=C3=B6st "
 "werden kann?"
=20
 #: builtin/checkout.c:1061
 msgid "git checkout: updating paths is incompatible with switching bra=
nches."
 msgstr ""
-"git checkout: Aktualisierung von Pfaden ist inkompatibel mit dem Wech=
sel von "
-"Zweigen."
+"git checkout: Die Aktualisierung von Pfaden ist inkompatibel mit dem =
Wechsel "
+"von Zweigen."
=20
 #: builtin/checkout.c:1066
 msgid "git checkout: --detach does not take a path argument"
@@ -1194,7 +1194,7 @@ msgid ""
 "checking out of the index."
 msgstr ""
 "git checkout: --ours/--theirs, --force and --merge sind inkompatibel =
wenn\n"
-"du au=C3=9Ferhalb der Bereitstellung auscheckst."
+"du aus der Bereitstellung auscheckst."
=20
 #: builtin/checkout.c:1088
 msgid "Cannot switch branch to a non-commit."
@@ -1213,7 +1213,7 @@ msgid ""
 "clean.requireForce set to true and neither -n nor -f given; refusing =
to clean"
 msgstr ""
 "clean.requireForce auf \"true\" gesetzt und weder -n noch -f gegeben;=
 "
-"Ablehnung der Reinigung"
+"S=C3=A4uberung abgelehnt"
=20
 #: builtin/clean.c:85
 msgid ""
@@ -1221,12 +1221,12 @@ msgid ""
 "clean"
 msgstr ""
 "clean.requireForce standardm=C3=A4=C3=9Fig auf \"true\" gesetzt und w=
eder -n noch -f "
-"gegeben; Ablehnung der Reinigung"
+"gegeben; S=C3=A4uberung abgelehnt"
=20
 #: builtin/clean.c:155 builtin/clean.c:176
 #, c-format
 msgid "Would remove %s\n"
-msgstr "W=C3=BCrde entfernen %s\n"
+msgstr "W=C3=BCrde '%s' entfernen\n"
=20
 #: builtin/clean.c:159 builtin/clean.c:179
 #, c-format
@@ -1241,12 +1241,12 @@ msgstr "Fehler beim Entfernen von %s"
 #: builtin/clean.c:166
 #, c-format
 msgid "Would not remove %s\n"
-msgstr "W=C3=BCrde %s nicht entfernen\n"
+msgstr "W=C3=BCrde '%s' nicht entfernen\n"
=20
 #: builtin/clean.c:168
 #, c-format
 msgid "Not removing %s\n"
-msgstr "Entferne %s nicht\n"
+msgstr "Entferne '%s' nicht\n"
=20
 #: builtin/clone.c:243
 #, c-format
@@ -1256,12 +1256,12 @@ msgstr "Referenziertes Projektarchiv '%s' ist k=
ein lokales Verzeichnis."
 #: builtin/clone.c:302
 #, c-format
 msgid "failed to open '%s'"
-msgstr "Fehler beim =C3=96ffnen von '%s'"
+msgstr "'%s' konnte nicht ge=C3=B6ffnet werden"
=20
 #: builtin/clone.c:306
 #, c-format
 msgid "failed to create directory '%s'"
-msgstr "Fehler beim Erstellen von Verzeichnis '%s'"
+msgstr "Verzeichnis '%s' konnte nicht erstellt werden"
=20
 #: builtin/clone.c:308 builtin/diff.c:75
 #, c-format
@@ -1271,17 +1271,17 @@ msgstr "'%s' konnte nicht gelesen werden"
 #: builtin/clone.c:310
 #, c-format
 msgid "%s exists and is not a directory"
-msgstr "%s existiert und ist kein Verzeichnis"
+msgstr "'%s' existiert und ist kein Verzeichnis"
=20
 #: builtin/clone.c:324
 #, c-format
 msgid "failed to stat %s\n"
-msgstr "%s konnte nicht gelesen werden\n"
+msgstr "'%s' konnte nicht gelesen werden\n"
=20
 #: builtin/clone.c:341
 #, c-format
 msgid "failed to unlink '%s'"
-msgstr "Verkn=C3=BCpfung von '%s' konnte nicht aufgehoben werden."
+msgstr "'%s' konnte nicht entfernt werden"
=20
 #: builtin/clone.c:346
 #, c-format
@@ -1315,7 +1315,7 @@ msgstr "Zu viele Argumente."
=20
 #: builtin/clone.c:643
 msgid "You must specify a repository to clone."
-msgstr "Du musst ein Projektarchiv zum Klonen spezifizieren."
+msgstr "Du musst ein Projektarchiv zum Klonen angeben."
=20
 #: builtin/clone.c:654
 #, c-format
@@ -1364,12 +1364,12 @@ msgstr "Klone nach '%s'...\n"
 #: builtin/clone.c:786
 #, c-format
 msgid "Don't know how to clone %s"
-msgstr "Wei=C3=9F nicht wie %s zu klonen ist."
+msgstr "Wei=C3=9F nicht wie '%s' zu klonen ist."
=20
 #: builtin/clone.c:835
 #, c-format
 msgid "Remote branch %s not found in upstream %s"
-msgstr "entfernten Zweig %s nicht im anderen Projektarchiv %s gefunden=
"
+msgstr "entfernten Zweig '%s' nicht im anderen Projektarchiv %s gefund=
en"
=20
 #: builtin/clone.c:842
 msgid "You appear to have cloned an empty repository."
@@ -1434,7 +1434,7 @@ msgstr "zusammenf=C3=BChren"
=20
 #: builtin/commit.c:208
 msgid "cherry-pick"
-msgstr "cherry-pick"
+msgstr "herauspicken"
=20
 #: builtin/commit.c:325
 msgid "failed to unpack HEAD tree object"
@@ -1450,12 +1450,12 @@ msgstr "interaktives Hinzuf=C3=BCgen fehlgeschl=
agen"
=20
 #: builtin/commit.c:406 builtin/commit.c:427 builtin/commit.c:473
 msgid "unable to write new_index file"
-msgstr "Konnte new_index Datei nicht schreiben"
+msgstr "'new_index' Datei konnte nicht geschrieben werden"
=20
 #: builtin/commit.c:457
 #, c-format
 msgid "cannot do a partial commit during a %s."
-msgstr "Kann keine partielle Eintragung w=C3=A4hrend eines %s durchf=C3=
=BChren."
+msgstr "Kann keine partielle Eintragung durchf=C3=BChren, w=C3=A4hrend=
 '%s' im Gange ist."
=20
 #: builtin/commit.c:466
 msgid "cannot read the index"
@@ -1463,7 +1463,7 @@ msgstr "Kann Bereitstellung nicht lesen"
=20
 #: builtin/commit.c:486
 msgid "unable to write temporary index file"
-msgstr "Konnte tempor=C3=A4re Bereitstellungsdatei nicht schreiben."
+msgstr "tempor=C3=A4re Bereitstellungsdatei konnte nicht geschrieben w=
erden"
=20
 #: builtin/commit.c:561 builtin/commit.c:567
 #, c-format
@@ -1482,7 +1482,7 @@ msgstr "Fehlerhafter Identifikations-String: '%s'=
"
 #: builtin/commit.c:689 builtin/commit.c:722 builtin/commit.c:1033
 #, c-format
 msgid "could not lookup commit %s"
-msgstr "Konnte Version %s nicht nachschlagen"
+msgstr "Version %s konnte nicht nachschlagen werden"
=20
 #: builtin/commit.c:701 builtin/shortlog.c:296
 #, c-format
@@ -1496,7 +1496,7 @@ msgstr "Konnte Log nicht von Standard-Eingabe les=
en."
 #: builtin/commit.c:707
 #, c-format
 msgid "could not read log file '%s'"
-msgstr "Konnte Log-Datei '%s' nicht lesen"
+msgstr "Log-Datei '%s' konnte nicht gelesen werden"
=20
 #: builtin/commit.c:713
 msgid "commit has empty message"
@@ -1513,12 +1513,12 @@ msgstr "Konnte SQUASH_MSG nicht lesen"
 #: builtin/commit.c:737
 #, c-format
 msgid "could not read '%s'"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "'%s' konnte nicht gelesen werden"
=20
 #: builtin/commit.c:765
 #, c-format
 msgid "could not open '%s'"
-msgstr "Konnte '%s' nicht =C3=B6ffnen"
+msgstr "'%s' konnte nicht ge=C3=B6ffnet werden"
=20
 #: builtin/commit.c:789
 msgid "could not write commit template"
@@ -1577,7 +1577,7 @@ msgstr "Kann Bereitstellung nicht lesen"
=20
 #: builtin/commit.c:896
 msgid "Error building trees"
-msgstr "Fehler beim Erzeugen der B=C3=A4ume"
+msgstr "Fehler beim Erzeugen der Zweige"
=20
 #: builtin/commit.c:911 builtin/tag.c:357
 #, c-format
@@ -1605,7 +1605,7 @@ msgstr "Du hast nichts zum nachbessern."
 #: builtin/commit.c:1076
 #, c-format
 msgid "You are in the middle of a %s -- cannot amend."
-msgstr "Du bist in der Mitte eines %s -- kann nicht nachbessern."
+msgstr "'%s' ist im Gange -- kann nicht nachbessern."
=20
 #: builtin/commit.c:1078
 msgid "Options --squash and --fixup cannot be used together"
@@ -1637,18 +1637,18 @@ msgstr "--include/--only machen ohne Pfade kein=
en Sinn."
 #: builtin/commit.c:1119
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
-"Klug... nachbessern der letzten Version mit einer unsauberen Bereitst=
ellung."
+"Klug... die letzte Version mit einer unsauberen Bereitstellung nachbe=
ssern."
=20
 #: builtin/commit.c:1121
 msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
 msgstr ""
-"Explizite Pfade ohne -i oder -o spezifiziert; unter der Annahme von -=
-only "
+"Explizite Pfade ohne -i oder -o angegeben; unter der Annahme von --on=
ly "
 "Pfaden..."
=20
 #: builtin/commit.c:1131 builtin/tag.c:556
 #, c-format
 msgid "Invalid cleanup mode %s"
-msgstr "Ung=C3=BCltiger \"cleanup\" Modus %s"
+msgstr "Ung=C3=BCltiger \"cleanup\" Modus '%s'"
=20
 #: builtin/commit.c:1136
 msgid "Paths with -a does not make sense."
@@ -1656,11 +1656,11 @@ msgstr "Pfade mit -a machen keinen Sinn."
=20
 #: builtin/commit.c:1315
 msgid "couldn't look up newly created commit"
-msgstr "Konnte neu erstellte Version nicht nachschlagen."
+msgstr "neu erstellte Version konnte nicht nachgeschlagen werden"
=20
 #: builtin/commit.c:1317
 msgid "could not parse newly created commit"
-msgstr "Konnte neu erstellte Version nicht analysieren."
+msgstr "neu erstellte Version konnte nicht geparst werden"
=20
 #: builtin/commit.c:1358
 msgid "detached HEAD"
@@ -1672,12 +1672,12 @@ msgstr " (Basis-Version)"
=20
 #: builtin/commit.c:1450
 msgid "could not parse HEAD commit"
-msgstr "Konnte Version der Zweigspitze (HEAD) nicht analysieren."
+msgstr "Version der Zweigspitze (HEAD) konnte nicht geparst werden"
=20
 #: builtin/commit.c:1487 builtin/merge.c:509
 #, c-format
 msgid "could not open '%s' for reading"
-msgstr "Konnte '%s' nicht zum Lesen =C3=B6ffnen."
+msgstr "'%s' konnte nicht zum Lesen ge=C3=B6ffnet werden"
=20
 #: builtin/commit.c:1494
 #, c-format
@@ -1686,12 +1686,12 @@ msgstr "Besch=C3=A4digte MERGE_HEAD-Datei (%s)"
=20
 #: builtin/commit.c:1501
 msgid "could not read MERGE_MODE"
-msgstr "Konnte MERGE_MODE nicht lesen"
+msgstr "MERGE_MODE konnte nicht gelesen werden"
=20
 #: builtin/commit.c:1520
 #, c-format
 msgid "could not read commit message: %s"
-msgstr "Konnte Versionsbeschreibung nicht lesen: %s"
+msgstr "Versionsbeschreibung konnte nicht gelesen werden: %s"
=20
 #: builtin/commit.c:1534
 #, c-format
@@ -1729,12 +1729,12 @@ msgstr ""
 #: builtin/describe.c:234
 #, c-format
 msgid "annotated tag %s not available"
-msgstr "annotierte Markierung %s ist nicht verf=C3=BCgbar"
+msgstr "annotierte Markierung '%s' ist nicht verf=C3=BCgbar"
=20
 #: builtin/describe.c:238
 #, c-format
 msgid "annotated tag %s has no embedded name"
-msgstr "annotierte Markierung %s hat keinen eingebetteten Namen"
+msgstr "annotierte Markierung '%s' hat keinen eingebetteten Namen"
=20
 #: builtin/describe.c:240
 #, c-format
@@ -1744,7 +1744,7 @@ msgstr "Markierung '%s' ist eigentlich '%s' hier"
 #: builtin/describe.c:267
 #, c-format
 msgid "Not a valid object name %s"
-msgstr "kein g=C3=BCltiger Objekt-Name %s"
+msgstr "%s ist kein g=C3=BCltiger Objekt-Name"
=20
 #: builtin/describe.c:270
 #, c-format
@@ -1759,7 +1759,7 @@ msgstr "kein Markierung entspricht exakt '%s'"
 #: builtin/describe.c:289
 #, c-format
 msgid "searching to describe %s\n"
-msgstr "suche um zu beschreiben %s\n"
+msgstr "suche zur Beschreibung von %s\n"
=20
 #: builtin/describe.c:329
 #, c-format
@@ -1787,7 +1787,7 @@ msgstr ""
 #: builtin/describe.c:378
 #, c-format
 msgid "traversed %lu commits\n"
-msgstr "verarbeitete %lu Versionen\n"
+msgstr "%lu Versionen durchlaufen\n"
=20
 #: builtin/describe.c:381
 #, c-format
@@ -1795,7 +1795,7 @@ msgid ""
 "more than %i tags found; listed %i most recent\n"
 "gave up search at %s\n"
 msgstr ""
-"mehr als %i Markierungen gefunden; F=C3=BChre die %i j=C3=BCngsten au=
f\n"
+"mehr als %i Markierungen gefunden; F=C3=BChre die ersten %i auf\n"
 "Suche bei %s aufgegeben\n"
=20
 #: builtin/describe.c:436
@@ -1827,26 +1827,26 @@ msgstr "Kein Git-Projektarchiv"
 #: builtin/diff.c:347
 #, c-format
 msgid "invalid object '%s' given."
-msgstr "Ung=C3=BCltiges Objekt '%s' gegeben."
+msgstr "Objekt '%s' ist ung=C3=BCltig."
=20
 #: builtin/diff.c:352
 #, c-format
 msgid "more than %d trees given: '%s'"
-msgstr "Mehr als %d B=C3=A4ume gegeben: '%s'"
+msgstr "Mehr als %d Zweige angegeben: '%s'"
=20
 #: builtin/diff.c:362
 #, c-format
 msgid "more than two blobs given: '%s'"
-msgstr "Mehr als zwei Blobs gegeben: '%s'"
+msgstr "Mehr als zwei Blobs angegeben: '%s'"
=20
 #: builtin/diff.c:370
 #, c-format
 msgid "unhandled object '%s' given."
-msgstr "unbehandeltes Objekt '%s' gegeben"
+msgstr "unbehandeltes Objekt '%s' angegeben"
=20
 #: builtin/fetch.c:200
 msgid "Couldn't find remote ref HEAD"
-msgstr "Konnte entfernte Referenz der Zweigspitze (HEAD) nicht finden.=
"
+msgstr "entfernte Referenz der Zweigspitze (HEAD) konnte nicht gefunde=
n werden."
=20
 #: builtin/fetch.c:252
 #, c-format
@@ -1872,7 +1872,7 @@ msgstr "[Markierungsaktualisierung]"
=20
 #: builtin/fetch.c:286 builtin/fetch.c:313 builtin/fetch.c:331
 msgid "  (unable to update local ref)"
-msgstr "  (kann lokale Referenz nicht aktualisieren)"
+msgstr "  (lokale Referenz konnte nicht aktualisiert werden)"
=20
 #: builtin/fetch.c:298
 msgid "[new tag]"
@@ -1884,7 +1884,7 @@ msgstr "[neuer Zweig]"
=20
 #: builtin/fetch.c:347
 msgid "unable to update local ref"
-msgstr "kann lokale Referenz nicht aktualisieren"
+msgstr "lokale Referenz konnte nicht aktualisiert werden"
=20
 #: builtin/fetch.c:347
 msgid "forced update"
@@ -1897,7 +1897,7 @@ msgstr "(kein Vorspulen)"
 #: builtin/fetch.c:384 builtin/fetch.c:676
 #, c-format
 msgid "cannot open %s: %s\n"
-msgstr "kann %s nicht =C3=B6ffnen: %s\n"
+msgstr "'%s' konnte nicht ge=C3=B6ffnet werden: %s\n"
=20
 #: builtin/fetch.c:393
 #, c-format
@@ -1921,7 +1921,7 @@ msgstr ""
 #: builtin/fetch.c:540
 #, c-format
 msgid "   (%s will become dangling)\n"
-msgstr "   (%s wird unreferenziert werden)\n"
+msgstr "   (%s wird unreferenziert)\n"
=20
 #: builtin/fetch.c:541
 #, c-format
@@ -1934,14 +1934,14 @@ msgstr "[gel=C3=B6scht]"
=20
 #: builtin/fetch.c:549
 msgid "(none)"
-msgstr "(keine)"
+msgstr "(nichts)"
=20
 #: builtin/fetch.c:666
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository=
"
 msgstr ""
-"Ablehnung des Anforderns in aktuellen Zweig %s von einem nicht-leeren=
 "
-"Projektarchiv"
+"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen\"=
"
+"Projektarchiv wurde abgelehnt."
=20
 #: builtin/fetch.c:700
 #, c-format
@@ -1961,29 +1961,29 @@ msgstr "Option \"%s\" wird ignoriert f=C3=BCr %=
s\n"
 #: builtin/fetch.c:879
 #, c-format
 msgid "Fetching %s\n"
-msgstr "Hole %s ab\n"
+msgstr "Fordere an von %s\n"
=20
 #: builtin/fetch.c:881
 #, c-format
 msgid "Could not fetch %s"
-msgstr "Konnte %s nicht anfordern"
+msgstr "Konnte nicht von %s anfordern"
=20
 #: builtin/fetch.c:898
 msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
 msgstr ""
-"Kein entferntes Projektarchiv spezifiziert. Bitte spezifiziere entwed=
er\n"
-"eine URL oder den Namen eines entfernten Archivs, von welchem neue\n"
-"Revisionen angefordert werden sollen."
+"Kein entferntes Projektarchiv spezifiziert. Bitte gebe entweder eine =
URL\n"
+"oder den Namen des entfernten Archivs an, von welchem neue\n"
+"Versionen angefordert werden sollen."
=20
 #: builtin/fetch.c:918
 msgid "You need to specify a tag name."
-msgstr "Du musst den Namen der Markierung spezifizieren."
+msgstr "Du musst den Namen der Markierung angeben."
=20
 #: builtin/fetch.c:970
 msgid "fetch --all does not take a repository argument"
-msgstr "fetch -all nimmt kein Projektarchiv als Argument"
+msgstr "fetch --all akzeptiert kein Projektarchiv als Argument"
=20
 #: builtin/fetch.c:972
 msgid "fetch --all does not make sense with refspecs"
@@ -2017,7 +2017,7 @@ msgstr "wahnsinnig langes Objekt-Verzeichnis %.*s=
"
 #: builtin/gc.c:223
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
-msgstr "Automatisches Packen des Projektarchivs f=C3=BCr optimale Leis=
tung.\n"
+msgstr "Das Projektarchiv wird f=C3=BCr die optimale Leistung gepackt.=
\n"
=20
 #: builtin/gc.c:226
 #, c-format
@@ -2025,13 +2025,14 @@ msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
-"Automatisches Packen des Projektarchivs f=C3=BCr optimale Leistung. D=
u kannst auch\n"
+"Das Projektarchiv wird f=C3=BCr die optimale Leistung gepackt. Du kan=
nst auch\n"
 "\"git gc\" manuell ausf=C3=BChren. Siehe \"git help gc\" f=C3=BCr wei=
tere Informationen.\n"
=20
 #: builtin/gc.c:256
 msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
-msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' aus um diese zu entfernen."
+msgstr "Es gibt zu viele unerreichbare verlorene Objekte; f=C3=BChre '=
git prune' "
+"aus um diese zu entfernen."
=20
 #: builtin/grep.c:216
 #, c-format
@@ -2046,12 +2047,12 @@ msgstr "Fehler beim Verzeichniswechsel: %s"
 #: builtin/grep.c:478 builtin/grep.c:512
 #, c-format
 msgid "unable to read tree (%s)"
-msgstr "konnte Baum (%s) nicht lesen"
+msgstr "Baum (%s) konnte nicht gelesen werden"
=20
 #: builtin/grep.c:526
 #, c-format
 msgid "unable to grep from object of type %s"
-msgstr "kann \"grep\" nicht mit Objekt des Typs \"%s\" durchf=C3=BChre=
n"
+msgstr "kann \"grep\" nicht mit Objekten des Typs \"%s\" durchf=C3=BCh=
ren"
=20
 #: builtin/grep.c:584
 #, c-format
@@ -2061,7 +2062,7 @@ msgstr "Schalter '%c' erwartet einen numerischen =
Wert"
 #: builtin/grep.c:601
 #, c-format
 msgid "cannot open '%s'"
-msgstr "kann '%s' nicht =C3=B6ffnen"
+msgstr "'%s' konnte nicht ge=C3=B6ffnet werden"
=20
 #: builtin/grep.c:888
 msgid "no pattern given."
@@ -2091,7 +2092,7 @@ msgstr ""
=20
 #: builtin/grep.c:982
 msgid "both --cached and trees are given."
-msgstr "sowohl --cached als auch B=C3=A4ume gegeben"
+msgstr "sowohl --cached als auch Zweige gegeben"
=20
 #: builtin/init-db.c:35
 #, c-format
@@ -2101,7 +2102,7 @@ msgstr "Konnte %s nicht schreibbar f=C3=BCr Grupp=
en machen"
 #: builtin/init-db.c:62
 #, c-format
 msgid "insanely long template name %s"
-msgstr "verr=C3=BCckt langer Vorlagen-Name %s"
+msgstr "zu langer Vorlagen-Name %s"
=20
 #: builtin/init-db.c:67
 #, c-format
@@ -2111,27 +2112,27 @@ msgstr "'%s' kann nicht gelesen werden"
 #: builtin/init-db.c:73
 #, c-format
 msgid "cannot stat template '%s'"
-msgstr "kann Vorlage '%s' nicht lesen"
+msgstr "Vorlage '%s' kann nicht lesen"
=20
 #: builtin/init-db.c:80
 #, c-format
 msgid "cannot opendir '%s'"
-msgstr "kann Verzeichnis '%s' nicht =C3=B6ffnen"
+msgstr "Verzeichnis '%s' kann nicht ge=C3=B6ffnet werden"
=20
 #: builtin/init-db.c:97
 #, c-format
 msgid "cannot readlink '%s'"
-msgstr "kann Verkn=C3=BCfpung '%s' nicht lesen"
+msgstr "Verkn=C3=BCpfung '%s' kann nicht aufgel=C3=B6st werden"
=20
 #: builtin/init-db.c:99
 #, c-format
 msgid "insanely long symlink %s"
-msgstr "verr=C3=BCckt lange symbolische Verkn=C3=BCpfung %s"
+msgstr "zu lange symbolische Verkn=C3=BCpfung %s"
=20
 #: builtin/init-db.c:102
 #, c-format
 msgid "cannot symlink '%s' '%s'"
-msgstr "kann '%s' '%s' nicht symbolisch verkn=C3=BCpfen"
+msgstr "kann '%s' nicht mit '%s' symbolisch verkn=C3=BCpfen"
=20
 #: builtin/init-db.c:106
 #, c-format
@@ -2146,42 +2147,43 @@ msgstr "ignoriere Vorlage %s"
 #: builtin/init-db.c:133
 #, c-format
 msgid "insanely long template path %s"
-msgstr "verr=C3=BCckt langer Vorlagen-Pfad %s"
+msgstr "zu langer Vorlagen-Pfad %s"
=20
 #: builtin/init-db.c:141
 #, c-format
 msgid "templates not found %s"
-msgstr "Vorlagen nicht gefunden %s"
+msgstr "keine Vorlagen in '%s' gefunden"
=20
 #: builtin/init-db.c:154
 #, c-format
 msgid "not copying templates of a wrong format version %d from '%s'"
-msgstr "kopiere keine Vorlagen mit einer falschen Formatversion %d von=
 '%s'"
+msgstr "Vorlagen mit der falscher Formatversion %d werden nicht von '%=
s' "
+"kopiert"
=20
 #: builtin/init-db.c:192
 #, c-format
 msgid "insane git directory %s"
-msgstr "verr=C3=BCcktes git Verzeichnis %s"
+msgstr "ung=C3=BCltiges git Verzeichnis %s"
=20
 #: builtin/init-db.c:322 builtin/init-db.c:325
 #, c-format
 msgid "%s already exists"
-msgstr "%s existiert bereits"
+msgstr "'%s' existiert bereits"
=20
 #: builtin/init-db.c:354
 #, c-format
 msgid "unable to handle file type %d"
-msgstr "kann Dateityp %d nicht behandeln"
+msgstr "kann nicht mit Dateityp '%d' umgehen"
=20
 #: builtin/init-db.c:357
 #, c-format
 msgid "unable to move %s to %s"
-msgstr "konnte %s nicht nach %s verschieben"
+msgstr "konnte '%s' nicht nach '%s' verschieben"
=20
 #: builtin/init-db.c:362
 #, c-format
 msgid "Could not create git link %s"
-msgstr "Konnte git-Verkn=C3=BCfung %s nicht erstellen"
+msgstr "Git-Verkn=C3=BCpfung '%s' konnte nicht erstellt werden"
=20
 #.
 #. * TRANSLATORS: The first '%s' is either "Reinitialized
@@ -2212,12 +2214,12 @@ msgstr "kann aktuelles Verzeichnis nicht bestim=
men"
 #: builtin/init-db.c:521 builtin/init-db.c:528
 #, c-format
 msgid "cannot mkdir %s"
-msgstr "kann Verzeichnis %s nicht erstellen"
+msgstr "Verzeichnis %s konnte nicht erstellt werden"
=20
 #: builtin/init-db.c:532
 #, c-format
 msgid "cannot chdir to %s"
-msgstr "kann nicht zu Verzeichnis %s wechseln"
+msgstr "kann nicht in Verzeichnis %s wechseln"
=20
 #: builtin/init-db.c:554
 #, c-format
@@ -2230,12 +2232,12 @@ msgstr ""
=20
 #: builtin/init-db.c:578
 msgid "Cannot access current working directory"
-msgstr "Kann nicht auf aktuelles Arbeitsverzeichnis zugreifen."
+msgstr "Zugriff auf aktuelles Arbeitsverzeichnis nicht m=C3=B6glich."
=20
 #: builtin/init-db.c:585
 #, c-format
 msgid "Cannot access work tree '%s'"
-msgstr "Kann nicht auf Arbeitsbaum '%s' zugreifen."
+msgstr "Zugriff auf Arbeitsbaum '%s' nicht m=C3=B6glich."
=20
 #: builtin/log.c:187
 #, c-format
@@ -2263,19 +2265,19 @@ msgstr "Name des Ausgabeverzeichnisses ist zu l=
ang."
 #: builtin/log.c:680
 #, c-format
 msgid "Cannot open patch file %s"
-msgstr "Kann Patch-Datei %s nicht =C3=B6ffnen"
+msgstr "Patch-Datei %s konnte nicht ge=C3=B6ffnet werden"
=20
 #: builtin/log.c:694
 msgid "Need exactly one range."
-msgstr "Brauche genau einen Bereich."
+msgstr "Brauche genau einen Versionsbereich."
=20
 #: builtin/log.c:702
 msgid "Not a range."
-msgstr "Kein Bereich."
+msgstr "Kein Versionsbereich."
=20
 #: builtin/log.c:739
 msgid "Could not extract email from committer identity."
-msgstr "Konnte E-Mail von der Intentit=C3=A4t des Einreichers nicht ex=
trahieren."
+msgstr "E-Mail-Adresse des Einreichers konnte nicht extrahiert werden.=
"
=20
 #: builtin/log.c:785
 msgid "Cover letter needs email format"
@@ -2284,7 +2286,7 @@ msgstr "Deckblatt ben=C3=B6tigt E-Mail-Format"
 #: builtin/log.c:879
 #, c-format
 msgid "insane in-reply-to: %s"
-msgstr "verr=C3=BCcktes in-reply-to: %s"
+msgstr "ung=C3=BCltiges in-reply-to: %s"
=20
 #: builtin/log.c:952
 msgid "Two output directories?"
@@ -2327,7 +2329,7 @@ msgstr "Standard-Ausgabe oder Verzeichnis, welche=
s von beidem?"
 #: builtin/log.c:1257
 #, c-format
 msgid "Could not create directory '%s'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Verzeichnis '%s' konnte nicht erstellt werden."
=20
 #: builtin/log.c:1410
 msgid "Failed to create output files"
@@ -2338,8 +2340,8 @@ msgstr "Fehler beim Erstellen der Ausgabedateien.=
"
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten, entfernten Zweig nicht finden, bitte spezifiziere "
-"<upstream> manuell.\n"
+"Konnte gefolgten, entfernten Zweig nicht finden, bitte gebe "
+"<upstream> manuell an.\n"
=20
 #: builtin/log.c:1530 builtin/log.c:1532 builtin/log.c:1544
 #, c-format
@@ -2376,11 +2378,11 @@ msgstr "\"stash\" fehlgeschlagen"
 #: builtin/merge.c:251
 #, c-format
 msgid "not a valid object: %s"
-msgstr "kein g=C3=BCltiges Objekt: %s"
+msgstr "'%s' ist kein g=C3=BCltiges Objekt"
=20
 #: builtin/merge.c:270 builtin/merge.c:287
 msgid "read-tree failed"
-msgstr "read-tree fehlgeschlagen"
+msgstr "'read-tree' fehlgeschlagen"
=20
 #: builtin/merge.c:317
 msgid " (nothing to squash)"
@@ -2389,7 +2391,7 @@ msgstr " (nichts zu quetschen)"
 #: builtin/merge.c:330
 #, c-format
 msgid "Squash commit -- not updating HEAD\n"
-msgstr "Quetsche Version -- aktualisiere Zweigspitze (HEAD) nicht\n"
+msgstr "Quetsche Version -- Zweigspitze (HEAD) wird nicht aktualisiert=
\n"
=20
 #: builtin/merge.c:362
 msgid "Writing SQUASH_MSG"
@@ -2402,8 +2404,8 @@ msgstr "Schlie=C3=9Fe SQUASH_MSG ab"
 #: builtin/merge.c:386
 #, c-format
 msgid "No merge message -- not updating HEAD\n"
-msgstr "Keine Zusammenf=C3=BChrungsbeschreibung -- aktualisiere Zweigs=
pitze (HEAD) "
-"nicht\n"
+msgstr "Keine Zusammenf=C3=BChrungsbeschreibung -- Zweigspitze (HEAD) =
wird nicht "
+"aktualisiert\n"
=20
 #: builtin/merge.c:437
 #, c-format
@@ -2425,11 +2427,11 @@ msgstr "Lesen des Zwischenspeichers fehlgeschla=
gen"
=20
 #: builtin/merge.c:696
 msgid "Unable to write index."
-msgstr "Konnte Bereitstellung nicht schreiben."
+msgstr "Bereitstellung konnte nicht geschrieben werden."
=20
 #: builtin/merge.c:709
 msgid "Not handling anything other than two heads merge."
-msgstr "Behandle nichts anderes als die Zusammenf=C3=BChrung von zwei =
K=C3=B6pfen."
+msgstr "Es wird nur die Zusammenf=C3=BChrung von zwei Zweigen behandel=
t."
=20
 #: builtin/merge.c:723
 #, c-format
@@ -2439,18 +2441,18 @@ msgstr "Unbekannte Option f=C3=BCr merge-recurs=
ive: -X%s"
 #: builtin/merge.c:737
 #, c-format
 msgid "unable to write %s"
-msgstr "konnte %s nicht schreiben"
+msgstr "'%s' konnte nicht geschrieben werden"
=20
 #: builtin/merge.c:876
 #, c-format
 msgid "Could not read from '%s'"
-msgstr "konnte nicht von '%s' lesen"
+msgstr "'%s' konnte nicht gelesen werden"
=20
 #: builtin/merge.c:885
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
 msgstr ""
-"Zusammenf=C3=BChrung nicht eingetragen; benutze 'git commit' um die "
+"Zusammenf=C3=BChrung wird nicht eingetragen; benutze 'git commit' um =
die "
 "Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
=20
 #: builtin/merge.c:891
@@ -2492,7 +2494,7 @@ msgstr "'%s' ist keine Version"
=20
 #: builtin/merge.c:1057
 msgid "No current branch."
-msgstr "Kein aktueller Zweig."
+msgstr "Du befindest dich auf keinem Zweig."
=20
 #: builtin/merge.c:1059
 msgid "No remote for the current branch."
@@ -2500,7 +2502,7 @@ msgstr "Kein anderes Archiv f=C3=BCr den aktuelle=
n Zweig."
=20
 #: builtin/merge.c:1061
 msgid "No default upstream defined for the current branch."
-msgstr "Kein entferntes Standard-Projektarchiv f=C3=BCr den aktuellen =
Zweig "
+msgstr "Es ist kein entferntes Standard-Projektarchiv f=C3=BCr den akt=
uellen Zweig "
 "definiert."
=20
 #: builtin/merge.c:1066
@@ -2530,15 +2532,13 @@ msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you can merge."
 msgstr ""
-"Du hast deinen \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD =
"
-"existiert).\n"
+"Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt).\n"
 "Bitte trage deine =C3=84nderungen ein, bevor du zusammenf=C3=BChren k=
annst."
=20
 #: builtin/merge.c:1214
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
 msgstr ""
-"Du hast deinen \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD =
"
-"existiert)."
+"Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt)."
=20
 #: builtin/merge.c:1223
 msgid "You cannot combine --squash with --no-ff."
@@ -2550,11 +2550,11 @@ msgstr "Du kannst --no-ff nicht mit --ff--only =
kombinieren."
=20
 #: builtin/merge.c:1235
 msgid "No commit specified and merge.defaultToUpstream not set."
-msgstr "Keine Version spezifiziert und merge.defaultToUpstream nicht g=
esetzt."
+msgstr "Keine Version angegeben und merge.defaultToUpstream ist nicht =
gesetzt."
=20
 #: builtin/merge.c:1266
 msgid "Can merge only exactly one commit into empty head"
-msgstr "Kann nur exakt eine Version in einem leeren Kopf zusammenf=C3=BC=
hren."
+msgstr "Kann nur exakt eine Version in einem leeren Zweig zusammenf=C3=
=BChren."
=20
 #: builtin/merge.c:1269
 msgid "Squash commit into empty head not supported yet"
@@ -2591,7 +2591,7 @@ msgstr "Vorspulen nicht m=C3=B6glich, breche ab."
 #: builtin/merge.c:1482 builtin/merge.c:1559
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
-msgstr "R=C3=BCcklauf des Baumes bis zum Ursprung...\n"
+msgstr "R=C3=BCcklauf des Zweiges bis zum Ursprung...\n"
=20
 #: builtin/merge.c:1486
 #, c-format
@@ -2601,7 +2601,7 @@ msgstr "Probiere Zusammenf=C3=BChrungsstrategie %=
s...\n"
 #: builtin/merge.c:1550
 #, c-format
 msgid "No merge strategy handled the merge.\n"
-msgstr "Keine Zusammenf=C3=BChrungsstrategie behandelt die Zusammenf=C3=
=BChrung.\n"
+msgstr "Keine Zusammenf=C3=BChrungsstrategie behandelt diese Zusammenf=
=C3=BChrung.\n"
=20
 #: builtin/merge.c:1552
 #, c-format
@@ -2617,13 +2617,13 @@ msgstr "Benutze \"%s\" um die Aufl=C3=B6sung pe=
r Hand vorzubereiten.\n"
 #, c-format
 msgid "Automatic merge went well; stopped before committing as request=
ed\n"
 msgstr ""
-"Automatische Zusammenf=C3=BChrung gut gegangen; stoppe, wie angefragt=
, vor der "
-"Eintragung\n"
+"Automatische Zusammenf=C3=BChrung abgeschlossen; halte, wie angefragt=
, vor der "
+"Eintragung an\n"
=20
 #: builtin/mv.c:108
 #, c-format
 msgid "Checking rename of '%s' to '%s'\n"
-msgstr "Pr=C3=BCfe Umbenennen von '%s' nach '%s'\n"
+msgstr "Umbenennung von '%s' nach '%s' wird gepr=C3=BCft\n"
=20
 #: builtin/mv.c:112
 msgid "bad source"
@@ -2652,7 +2652,7 @@ msgstr "nicht unter Versionskontrolle"
=20
 #: builtin/mv.c:173
 msgid "destination exists"
-msgstr "Ziel existiert"
+msgstr "Ziel existiert bereits"
=20
 #: builtin/mv.c:181
 #, c-format
@@ -2680,7 +2680,7 @@ msgstr "Benenne %s nach %s um\n"
 #: builtin/mv.c:215
 #, c-format
 msgid "renaming '%s' failed"
-msgstr "Umbenennen von '%s' fehlgeschlagen"
+msgstr "Umbenennung von '%s' fehlgeschlagen"
=20
 #: builtin/notes.c:139
 #, c-format
@@ -2694,7 +2694,8 @@ msgstr "konnte Datei-Deskriptor f=C3=BCr Ausgabe =
von 'show' nicht =C3=B6ffnen"
 #: builtin/notes.c:155
 #, c-format
 msgid "failed to close pipe to 'show' for object '%s'"
-msgstr "Schlie=C3=9Fen der Pipe zu 'show' f=C3=BCr Objekt '%s' fehlges=
chlagen."
+msgstr "Das Schlie=C3=9Fen der Verbindung zu 'show' ist f=C3=BCr Objek=
t '%s' "
+"fehlgeschlagen."
=20
 #: builtin/notes.c:158
 #, c-format
@@ -2704,7 +2705,7 @@ msgstr "'show' konnte f=C3=BCr Objekt '%s' nicht =
abgeschlossen werden"
 #: builtin/notes.c:175 builtin/tag.c:343
 #, c-format
 msgid "could not create file '%s'"
-msgstr "konnte Datei '%s' nicht erstellen"
+msgstr "Datei '%s' konnte nicht erstellt werden."
=20
 #: builtin/notes.c:189
 msgid "Please supply the note contents using either -m or -F option"
@@ -2717,7 +2718,7 @@ msgstr "Entferne Notiz f=C3=BCr Objekt %s\n"
=20
 #: builtin/notes.c:215
 msgid "unable to write note object"
-msgstr "Konnte Notiz-Objekt nicht schreiben"
+msgstr "Notiz-Objekt konnte nicht geschrieben werden"
=20
 #: builtin/notes.c:217
 #, c-format
@@ -2727,12 +2728,12 @@ msgstr "Die Notiz-Inhalte wurden in %s belassen=
"
 #: builtin/notes.c:251 builtin/tag.c:521
 #, c-format
 msgid "cannot read '%s'"
-msgstr "kann '%s' nicht lesen"
+msgstr "'%s' konnte nicht gelesen"
=20
 #: builtin/notes.c:253 builtin/tag.c:524
 #, c-format
 msgid "could not open or read '%s'"
-msgstr "konnte '%s' nicht =C3=B6ffnen oder lesen"
+msgstr "'%s' konnte nicht ge=C3=B6ffnet oder gelesen werden"
=20
 #: builtin/notes.c:272 builtin/notes.c:445 builtin/notes.c:447
 #: builtin/notes.c:507 builtin/notes.c:561 builtin/notes.c:644
@@ -2777,7 +2778,7 @@ msgstr "Fehlerhafte Eingabezeile: '%s'."
 #: builtin/notes.c:456
 #, c-format
 msgid "Failed to copy notes from '%s' to '%s'"
-msgstr "Fehler beim Kopieren der Notizen von '%s' nach '%s'"
+msgstr "Notizen konnten nicht von '%s' nach '%s' kopiert werden."
=20
 #: builtin/notes.c:500 builtin/notes.c:554 builtin/notes.c:627
 #: builtin/notes.c:639 builtin/notes.c:712 builtin/notes.c:759
@@ -2796,8 +2797,8 @@ msgid ""
 "Cannot add notes. Found existing notes for object %s. Use '-f' to ove=
rwrite "
 "existing notes"
 msgstr ""
-"Konnte Notizen nicht hinzuf=C3=BCgen. Existierende Notizen f=C3=BCr O=
bjekt %s "
-"gefunden. Verwende '-f' um die existierenden Notizen zu =C3=BCberschr=
eiben."
+"Notizen konnten nicht hinzugef=C3=BCgt werden. Existierende Notizen f=
=C3=BCr Objekt %s "
+"gefunden. Benutze '-f' um die existierenden Notizen zu =C3=BCberschre=
iben."
=20
 #: builtin/notes.c:585 builtin/notes.c:662
 #, c-format
@@ -2814,13 +2815,13 @@ msgid ""
 "Cannot copy notes. Found existing notes for object %s. Use '-f' to ov=
erwrite "
 "existing notes"
 msgstr ""
-"Kann Notizen nicht kopieren. Existierende Notizen f=C3=BCr Objekt %s =
gefunden. "
-"Verwende '-f' um die existierenden Notizen zu =C3=BCberschreiben."
+"Notizen konnte nicht kopiert werden. Existierende Notizen f=C3=BCr Ob=
jekt %s "
+"gefunden. Verwende '-f' um die existierenden Notizen zu =C3=BCberschr=
eiben."
=20
 #: builtin/notes.c:668
 #, c-format
 msgid "Missing notes on source object %s. Cannot copy."
-msgstr "Vermisse Notizen f=C3=BCr Quell-Objekt %s. Kann nicht kopieren=
=2E"
+msgstr "Keine Notizen f=C3=BCr Quell-Objekt %s. Kopie nicht m=C3=B6gli=
ch."
=20
 #: builtin/notes.c:717
 #, c-format
@@ -2828,7 +2829,7 @@ msgid ""
 "The -m/-F/-c/-C options have been deprecated for the 'edit' subcomman=
d.\n"
 "Please use 'git notes add -f -m/-F/-c/-C' instead.\n"
 msgstr ""
-"Die Optionen -m/-F/-c/-C sind veraltet f=C3=BCr das 'edit' Unterkomma=
ndo.\n"
+"Die Optionen -m/-F/-c/-C sind f=C3=BCr das Unterkommando 'edit' veral=
tet.\n"
 "Bitte benutze stattdessen 'git notes add -f -m/-F/-c/-C'.\n"
=20
 #: builtin/notes.c:971
@@ -2844,12 +2845,12 @@ msgstr "Unbekanntes Unterkommando: %s"
 #: builtin/pack-objects.c:2310
 #, c-format
 msgid "unsupported index version %s"
-msgstr "Nicht unterst=C3=BCtzte Bereitstellungsversion %s"
+msgstr "Bereitstellungsversion '%s' wird nicht unterst=C3=BCtzt"
=20
 #: builtin/pack-objects.c:2314
 #, c-format
 msgid "bad index version '%s'"
-msgstr "Ung=C3=BCltige Bereitstellungsversion '%s'"
+msgstr "Bereitstellungsversion '%s' ung=C3=BCltig"
=20
 #: builtin/pack-objects.c:2322
 #, c-format
@@ -2859,7 +2860,7 @@ msgstr "Option %s akzeptiert keine negative Form"
 #: builtin/pack-objects.c:2326
 #, c-format
 msgid "unable to parse value '%s' for option %s"
-msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht analysieren"
+msgstr "Wert '%s' f=C3=BCr Option %s konnte nicht analysiert werden"
=20
 #: builtin/push.c:44
 msgid "tag shorthand without <tag>"
@@ -2911,7 +2912,7 @@ msgid ""
 "your current branch '%s', without telling me what to push\n"
 "to update which remote branch."
 msgstr ""
-"Du versendest nach '%s', welches kein entferntes Projektarchiv deines=
\n"
+"Du versendest zu '%s', welches kein entferntes Projektarchiv deines\n=
"
 "aktuellen Zweiges '%s' ist, ohne mir mitzuteilen, was ich versenden\n=
"
 "soll, um welchen entfernten Zweig zu aktualisieren."
=20
@@ -2919,7 +2920,7 @@ msgstr ""
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
-"Du hast keine Referenzspezifikationen zum Versenden spezifiziert, und=
 "
+"Du hast keine Referenzspezifikationen zum Versenden angegeben, und "
 "push.default ist \"nothing\"."
=20
 #: builtin/push.c:147
@@ -2930,7 +2931,7 @@ msgstr "Versende nach %s\n"
 #: builtin/push.c:151
 #, c-format
 msgid "failed to push some refs to '%s'"
-msgstr "Fehler beim Versenden einiger Referenzen nach '%s'"
+msgstr "Einige Referenzen konnte nicht nach '%s' versendet werden."
=20
 #: builtin/push.c:159
 #, c-format
@@ -3022,16 +3023,16 @@ msgstr "Du hast keine g=C3=BCltige Zweigspitze =
(HEAD)."
=20
 #: builtin/reset.c:79
 msgid "Failed to find tree of HEAD."
-msgstr "Fehler beim Finden des Baumes der Zweigspitze (HEAD)."
+msgstr "Baum der Zweigspitze (HEAD) konnte nicht gefunden werden"
=20
 #: builtin/reset.c:85
 #, c-format
 msgid "Failed to find tree of %s."
-msgstr "Fehler beim Finden des Baumes von %s."
+msgstr "Baum von '%s' konnte nicht gefunden werden."
=20
 #: builtin/reset.c:96
 msgid "Could not write new index file."
-msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
+msgstr "Neue Bereitstellungsdatei konnte nicht geschrieben werden."
=20
 #: builtin/reset.c:106
 #, c-format
@@ -3040,7 +3041,7 @@ msgstr "Zweigspitze (HEAD) ist jetzt bei %s"
=20
 #: builtin/reset.c:130
 msgid "Could not read index"
-msgstr "Konnte Bereitstellung nicht lesen"
+msgstr "Bereitstellung konnte nicht gelesen werden"
=20
 #: builtin/reset.c:133
 msgid "Unstaged changes after reset:"
@@ -3049,12 +3050,13 @@ msgstr "Nicht bereitgestellte =C3=84nderungen n=
ach Zur=C3=BCcksetzung:"
 #: builtin/reset.c:223
 #, c-format
 msgid "Cannot do a %s reset in the middle of a merge."
-msgstr "Kann keine '%s' Zur=C3=BCcksetzung innerhalb einer Zusammenf=C3=
=BChrung durchf=C3=BChren."
+msgstr "Kann keine '%s' Zur=C3=BCcksetzung durchf=C3=BChren, w=C3=A4hr=
end eine "
+"Zusammenf=C3=BChrung im Gange ist."
=20
 #: builtin/reset.c:297
 #, c-format
 msgid "Could not parse object '%s'."
-msgstr "Konnte Objekt '%s' nicht parsen."
+msgstr "Objekt '%s' konnte nicht geparst werden."
=20
 #: builtin/reset.c:302
 msgid "--patch is incompatible with --{hard,mixed,soft}"
@@ -3068,7 +3070,7 @@ msgstr ""
 #: builtin/reset.c:313
 #, c-format
 msgid "Cannot do %s reset with paths."
-msgstr "Kann keine '%s' Zur=C3=BCcksetzung mit Pfaden machen."
+msgstr "Eine '%s' Zur=C3=BCcksetzung mit Pfaden ist nicht m=C3=B6glich=
=2E"
=20
 #: builtin/reset.c:325
 #, c-format
@@ -3078,7 +3080,7 @@ msgstr "'%s' Zur=C3=BCcksetzung ist in einem blo=C3=
=9Fen Projektarchiv nicht erlaubt"
 #: builtin/reset.c:341
 #, c-format
 msgid "Could not reset index file to revision '%s'."
-msgstr "Konnte Bereitstellungsdatei nicht zu Revision '%s' zur=C3=BCck=
setzen."
+msgstr "Bereitstellungsdatei konnte nicht zu Version '%s' zur=C3=BCckg=
esetzt werden."
=20
 #: builtin/revert.c:70 builtin/revert.c:91
 #, c-format
@@ -3129,12 +3131,12 @@ msgstr ""
 #: builtin/rm.c:194
 #, c-format
 msgid "not removing '%s' recursively without -r"
-msgstr "entferne '%s' nicht rekursiv ohne -r"
+msgstr "'%s' wird nicht ohne -r rekursiv entfernt"
=20
 #: builtin/rm.c:230
 #, c-format
 msgid "git rm: unable to remove %s"
-msgstr "git rm: konnte %s nicht entfernen"
+msgstr "git rm: %s konnte nicht entfernt werden"
=20
 #: builtin/shortlog.c:157
 #, c-format
@@ -3198,11 +3200,11 @@ msgstr ""
=20
 #: builtin/tag.c:294
 msgid "unable to sign the tag"
-msgstr "konnte Markierung nicht signieren"
+msgstr "Markierung konnte nicht signiert werden"
=20
 #: builtin/tag.c:296
 msgid "unable to write tag file"
-msgstr "konnte Markierungsdatei nicht schreiben"
+msgstr "Markierungsdatei konnte nicht geschrieben werden"
=20
 #: builtin/tag.c:321
 msgid "bad object type."
@@ -3327,13 +3329,13 @@ msgstr "Bitte werde dir klar. --skip oder --abo=
rt?"
=20
 #: git-am.sh:506
 msgid "Resolve operation not in progress, we are not resuming."
-msgstr "keine Aufl=C3=B6sung in Durchf=C3=BChrung, wir setzen nicht fo=
rt."
+msgstr "Es ist keine Aufl=C3=B6sung im Gange, es wird nicht fortgesetz=
t."
=20
 #: git-am.sh:572
 #, sh-format
 msgid "Dirty index: cannot apply patches (dirty: $files)"
 msgstr ""
-"Unsaubere Bereitstellung: kann Patches nicht anwenden (unsauber: $fil=
es)"
+"Unsaubere Bereitstellung: Patches konnten nicht angewendet werden (un=
sauber: $files)"
=20
 #: git-am.sh:748
 msgid "cannot be interactive without stdin connected to a terminal."
@@ -3378,7 +3380,7 @@ msgstr "'$arg' scheint keine g=C3=BCltige Version=
 zu sein"
=20
 #: git-bisect.sh:117
 msgid "Bad HEAD - I need a HEAD"
-msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Ich brauche eine Zweigspit=
ze (HEAD)"
+msgstr "Ung=C3=BCltige Zweigspitze (HEAD) - Zweigspitze (HEAD) wird be=
n=C3=B6tigt"
=20
 #: git-bisect.sh:130
 #, sh-format
@@ -3390,7 +3392,7 @@ msgstr ""
=20
 #: git-bisect.sh:140
 msgid "won't bisect on seeked tree"
-msgstr "werde nicht auf gesuchtem Baum halbieren"
+msgstr "\"bisect\" auf gesuchtem Zweig nicht m=C3=B6glich"
=20
 #: git-bisect.sh:144
 msgid "Bad HEAD - strange symbolic ref"
@@ -3447,7 +3449,7 @@ msgstr "Keine Log-Datei gegeben"
 #: git-bisect.sh:391
 #, sh-format
 msgid "cannot read $file for replaying"
-msgstr "kann $file nicht zum neu abspielen lesen"
+msgstr "'$file' konnte nicht zum neu abspielen gelesen werden"
=20
 #: git-bisect.sh:408
 msgid "?? what are you talking about?"
@@ -3463,7 +3465,7 @@ msgid ""
 "Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
 "as appropriate to mark resolution, or use 'git commit -a'."
 msgstr ""
-"\"pull\" ist nicht m=C3=B6glich weil du nicht zusammengef=C3=BChrte D=
ateien hast.\n"
+"\"pull\" ist nicht m=C3=B6glich, weil du nicht zusammengef=C3=BChrte =
Dateien hast.\n"
 "Bitte korrigiere dies im Arbeitsbaum und benutze dann 'git add/rm <Da=
tei>'\n"
 "um die Aufl=C3=B6sung entsprechend zu markieren, oder benutze 'git co=
mmit -a'."
=20
@@ -3496,11 +3498,11 @@ msgstr "Du hast bisher noch keine initiale Vers=
ion"
=20
 #: git-stash.sh:89
 msgid "Cannot save the current index state"
-msgstr "Kann den aktuellen Zustand der Bereitstellung nicht speichern"
+msgstr "Der aktuelle Zustand der Bereitstellung kann nicht gespeichert=
 werden."
=20
 #: git-stash.sh:123 git-stash.sh:136
 msgid "Cannot save the current worktree state"
-msgstr "Kann den aktuellen Zustand des Arbeitsbaumes nicht speichern"
+msgstr "Der aktuelle Zustand des Arbeitsbaumes kann nicht gespeichert =
werden."
=20
 #: git-stash.sh:140
 msgid "No changes selected"
@@ -3508,11 +3510,11 @@ msgstr "Keine =C3=84nderungen ausgew=C3=A4hlt"
=20
 #: git-stash.sh:143
 msgid "Cannot remove temporary index (can't happen)"
-msgstr "Kann tempor=C3=A4re Bereitstellung nicht entfernen (kann nicht=
 passieren)"
+msgstr "Tempor=C3=A4re Bereitstellung kann nicht entfernt werden (kann=
 nicht passieren)"
=20
 #: git-stash.sh:156
 msgid "Cannot record working tree state"
-msgstr "Kann Zustand des Arbeitsbaumes nicht aufzeichnen"
+msgstr "Zustand des Arbeitsbaumes kann nicht aufgezeichnet werden"
=20
 #: git-stash.sh:223
 msgid "No local changes to save"
@@ -3520,15 +3522,15 @@ msgstr "Keine lokalen =C3=84nderungen zum Speic=
hern"
=20
 #: git-stash.sh:227
 msgid "Cannot initialize stash"
-msgstr "Kann \"stash\" nicht initialisieren"
+msgstr "\"stash\" kann nicht initialisiert werden"
=20
 #: git-stash.sh:235
 msgid "Cannot save the current status"
-msgstr "Kann den aktuellen Status nicht speichern"
+msgstr "Aktueller Status kann nicht gespeichert werden"
=20
 #: git-stash.sh:253
 msgid "Cannot remove worktree changes"
-msgstr "Kann =C3=84nderungen am Arbeitsbaum nicht entfernen"
+msgstr "=C3=84nderungen am Arbeitsbaum k=C3=B6nnen nicht entfernt werd=
en"
=20
 #: git-stash.sh:352
 msgid "No stash found."
@@ -3537,7 +3539,7 @@ msgstr "Kein \"stash\" gefunden."
 #: git-stash.sh:359
 #, sh-format
 msgid "Too many revisions specified: $REV"
-msgstr "Zu viele Revisionen spezifiziert: $REV"
+msgstr "Zu viele Revisionen angegeben: $REV"
=20
 #: git-stash.sh:365
 #, sh-format
@@ -3556,11 +3558,12 @@ msgstr "'$args' ist keine \"stash\"-Referenz"
=20
 #: git-stash.sh:412
 msgid "unable to refresh index"
-msgstr "Konnte die Bereitstellung nicht aktualisieren"
+msgstr "Bereitstellung konnte nicht aktualisiert werden"
=20
 #: git-stash.sh:416
 msgid "Cannot apply a stash in the middle of a merge"
-msgstr "Kann keinen \"stash\" innerhalb einer Zusammenf=C3=BChrung anw=
enden"
+msgstr "\"stash\" kann nicht angewendet werden, solang eine Zusammenf=C3=
=BChrung "
+"im Gange ist"
=20
 #: git-stash.sh:424
 msgid "Conflicts in index. Try without --index."
@@ -3568,11 +3571,11 @@ msgstr "Konflikte in der Bereitstellung. Versuc=
he es ohne --index."
=20
 #: git-stash.sh:426
 msgid "Could not save index tree"
-msgstr "Konnte Bereitstellungsbaum nicht speichern"
+msgstr "Bereitstellungsbaum konnte nicht gespeichert werden."
=20
 #: git-stash.sh:460
 msgid "Cannot unstage modified files"
-msgstr "Kann ge=C3=A4nderte Dateien nicht aus der Bereitstellung herau=
snehmen"
+msgstr "Ge=C3=A4nderte Dateien konnte nicht aus der Bereitstellung ent=
fernt werden."
=20
 #: git-stash.sh:491
 #, sh-format
@@ -3582,7 +3585,7 @@ msgstr "Gel=C3=B6scht ${REV} ($s)"
 #: git-stash.sh:492
 #, sh-format
 msgid "${REV}: Could not drop stash entry"
-msgstr "${REV}: Konnte \"stash\"-Eintrag nicht l=C3=B6schen"
+msgstr "${REV}: \"stash\"-Eintrag konnte nicht gel=C3=B6scht werden"
=20
 #: git-stash.sh:499
 msgid "No branch name specified"
@@ -3590,17 +3593,18 @@ msgstr "Kein Zweigname spezifiziert"
=20
 #: git-stash.sh:570
 msgid "(To restore them type \"git stash apply\")"
-msgstr "(Um es wiederherzustellen, schreibe \"git stash apply\")"
+msgstr "(Zur Wiederherstellung gebe ein \"git stash apply\")"
=20
 #: git-submodule.sh:56
 #, sh-format
 msgid "cannot strip one component off url '$remoteurl'"
-msgstr "Kann eine Komponente von URL '$remoteurl' nicht rausziehen"
+msgstr "Eine Komponente von URL '$remoteurl' konnte nicht extrahiert w=
erden."
=20
 #: git-submodule.sh:108
 #, sh-format
 msgid "No submodule mapping found in .gitmodules for path '$path'"
-msgstr "Keine Unterprojekt-Zuordnung in .gitmodules f=C3=BCr Pfad '$pa=
th' gefunden"
+msgstr "F=C3=BCr Pfad '$path' wurde keine Unterprojekt-Zuordnung in .g=
itmodules "
+"gefunden."
=20
 #: git-submodule.sh:149
 #, sh-format
@@ -3610,7 +3614,7 @@ msgstr "Klonen von '$url' in Unterprojekt-Pfad '$=
path' fehlgeschlagen"
 #: git-submodule.sh:159
 #, sh-format
 msgid "Gitdir '$a' is part of the submodule path '$b' or vice versa"
-msgstr "Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b' ode=
r umgekehrt"
+msgstr "Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b', od=
er umgekehrt"
=20
 #: git-submodule.sh:247
 #, sh-format
@@ -3630,12 +3634,12 @@ msgstr "'$path' existiert bereits und ist kein =
g=C3=BCltiges Git-Projektarchiv"
 #: git-submodule.sh:295
 #, sh-format
 msgid "Unable to checkout submodule '$path'"
-msgstr "Unf=C3=A4hig Unterprojekt '$path' auszuchecken"
+msgstr "Unterprojekt '$path' konnte nicht ausgecheckt werden"
=20
 #: git-submodule.sh:300
 #, sh-format
 msgid "Failed to add submodule '$path'"
-msgstr "Hinzuf=C3=BCgen von Unterprojekt '$path' fehlgeschlagen"
+msgstr "Unterprojekt '$path' konnte nicht hinzugef=C3=BCgt werden"
=20
 #: git-submodule.sh:305
 #, sh-format
@@ -3655,23 +3659,23 @@ msgstr "Stoppe bei '$path'; Skript gab nicht-Nu=
ll Status zur=C3=BCck."
 #: git-submodule.sh:401
 #, sh-format
 msgid "No url found for submodule path '$path' in .gitmodules"
-msgstr "Keine URL f=C3=BCr Unterprojekt-Pfad '$path' in .gitmodules ge=
funden"
+msgstr "F=C3=BCr Unterprojekt-Pfad '$path' wurde keine URL in .gitmodu=
les gefunden"
=20
 #: git-submodule.sh:410
 #, sh-format
 msgid "Failed to register url for submodule path '$path'"
-msgstr "Fehler beim Registrieren der URL f=C3=BCr Unterprojekt-Pfad '$=
path'"
+msgstr "Registrierung der URL f=C3=BCr Unterprojekt-Pfad '$path' fehlg=
eschlagen"
=20
 #: git-submodule.sh:418
 #, sh-format
 msgid "Failed to register update mode for submodule path '$path'"
-msgstr "Fehler beim Registrieren des Aktualisierungsmodus f=C3=BCr Unt=
erprojekt-Pfad"
-" '$path'"
+msgstr "Registrierung des Aktualisierungsmodus f=C3=BCr Unterprojekt-P=
fad '$path' "
+"fehlgeschlagen"
=20
 #: git-submodule.sh:420
 #, sh-format
 msgid "Submodule '$name' ($url) registered for path '$path'"
-msgstr "Unterprojekt '$name' ($url) registriert f=C3=BCr Pfad '$path'"
+msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$path' registri=
ert"
=20
 #: git-submodule.sh:519
 #, sh-format
@@ -3679,13 +3683,14 @@ msgid ""
 "Submodule path '$path' not initialized\n"
 "Maybe you want to use 'update --init'?"
 msgstr ""
-"Unterprojekt-Pfad '$path' nicht initialisiert\n"
+"Unterprojekt-Pfad '$path' ist nicht initialisiert\n"
 "Vielleicht m=C3=B6chtest du 'update --init' benutzen?"
=20
 #: git-submodule.sh:532
 #, sh-format
 msgid "Unable to find current revision in submodule path '$path'"
-msgstr "Konnte aktuelle Revision in Unterprojekt-Pfad '$path' nicht fi=
nden"
+msgstr "Aktuelle Version in Unterprojekt-Pfad '$path' konnte nicht gef=
unden "
+"werden"
=20
 #: git-submodule.sh:551
 #, sh-format
@@ -3705,7 +3710,7 @@ msgstr "Unterprojekt-Pfad '$path': neu aufgebaut =
in '$sha1'"
 #: git-submodule.sh:571
 #, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$path'"
-msgstr "Konnte '$sha1' nicht in Unterprojekt-Pfad '$path' zusammenf=C3=
=BChren"
+msgstr "Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$path' =
fehlgeschlagen"
=20
 #: git-submodule.sh:572
 #, sh-format
--=20
1.7.10.67.g0b77
