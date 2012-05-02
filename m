From: Thomas Rast <trast@student.ethz.ch>
Subject: =?UTF-8?q?=5BPATCH=20de=2Epo=205/5=5D=20de=2Epo=3A=20collection=20of=20suggestions?=
Date: Wed, 2 May 2012 15:49:27 +0200
Message-ID: <abfde735e408a8fc34e143ec25d1a345b6fcbd27.1335966202.git.trast@student.ethz.ch>
References: <cover.1335966202.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jiang Xin <worldhello.net@gmail.com>,
	Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
	Christian Stimming <stimming@tuhh.de>
To: Ralf Thielow <ralf.thielow@googlemail.com>
X-From: git-owner@vger.kernel.org Wed May 02 15:49:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPZwD-0004vt-Qt
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 15:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754215Ab2EBNte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 May 2012 09:49:34 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:27485 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753256Ab2EBNtb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 09:49:31 -0400
Received: from CAS11.d.ethz.ch (172.31.38.211) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.283.3; Wed, 2 May
 2012 15:49:27 +0200
Received: from thomas.inf.ethz.ch (129.132.153.233) by CAS11.d.ethz.ch
 (172.31.38.211) with Microsoft SMTP Server (TLS) id 14.1.355.2; Wed, 2 May
 2012 15:49:28 +0200
X-Mailer: git-send-email 1.7.10.625.g300dcf
In-Reply-To: <cover.1335966202.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196817>

A long list of suggested changes to the translation.  None of them are
clear-cut, though I of course think they are an improvement ;-)

Please do not apply this patch "blindly"; take them as suggestions,
and keep only the ones you like.  The S-O-B refers to the
opensourciness of it.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---
 po/de.po |   97 ++++++++++++++++++++++++++++--------------------------=
--------
 1 file changed, 43 insertions(+), 54 deletions(-)

diff --git a/po/de.po b/po/de.po
index a1a765a..f6df558 100644
--- a/po/de.po
+++ b/po/de.po
@@ -34,8 +34,8 @@ msgid ""
 "or use 'git commit -a'."
 msgstr ""
 "Korrigiere dies im Arbeitsbaum,\n"
-"und benutze dann 'git add/rm <Datei>' wie\n"
-"vorgesehen, um die Aufl=C3=B6sung zu markieren und dann einzutragen,\=
n"
+"und benutze dann 'git add/rm <Datei>' \n"
+"um die Aufl=C3=B6sung entsprechend zu markieren und einzutragen,\n"
 "oder benutze 'git commit -a'."
=20
 #: commit.c:48
@@ -360,7 +360,7 @@ msgstr "Fehlerhaftes Optionsblatt: %s"
=20
 #: sequencer.c:666
 msgid "a cherry-pick or revert is already in progress"
-msgstr "\"cherry-pick\" oder \"revert\" wird bereits ausgef=C3=BChrt"
+msgstr "\"cherry-pick\" oder \"revert\" ist bereits im Gang"
=20
 #: sequencer.c:667
 msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
@@ -378,7 +378,7 @@ msgstr "Fehler beim Einpacken von %s."
=20
 #: sequencer.c:706 sequencer.c:840
 msgid "no cherry-pick or revert in progress"
-msgstr "kein \"cherry-pick\" oder \"revert\" in Ausf=C3=BChrung"
+msgstr "kein \"cherry-pick\" oder \"revert\" im Gang"
=20
 #: sequencer.c:708
 msgid "cannot resolve HEAD"
@@ -386,7 +386,7 @@ msgstr "kann Zweigspitze (HEAD) nicht aufl=C3=B6sen=
"
=20
 #: sequencer.c:710
 msgid "cannot abort from a branch yet to be born"
-msgstr "kann nicht von einem Zweig abbrechen, der noch geboren wird"
+msgstr "kann nicht abbrechen: bin auf einem Zweig, der noch geboren wi=
rd"
=20
 #: sequencer.c:732
 #, c-format
@@ -475,12 +475,11 @@ msgstr "=C3=84nderungen, die nicht zum Eintragen =
bereitgestellt sind:"
=20
 #: wt-status.c:173
 msgid "  (use \"git add <file>...\" to update what will be committed)"
-msgstr "  (benutze \"git add <Datei>...\" zur Aktualisierung der Eintr=
agung)"
+msgstr "  (benutze \"git add <Datei>...\" zum Bereitstellen)"
=20
 #: wt-status.c:175
 msgid "  (use \"git add/rm <file>...\" to update what will be committe=
d)"
-msgstr ""
-"  (benutze \"git add/rm <Datei>...\" zur Aktualisierung der Eintragun=
g)"
+msgstr "  (benutze \"git add/rm <Datei>...\" zum Bereitstellen)"
=20
 #: wt-status.c:176
 msgid ""
@@ -507,7 +506,7 @@ msgstr "  (benutze \"git %s <Datei>...\" zum Einf=C3=
=BCgen in die Eintragung)"
=20
 #: wt-status.c:207
 msgid "bug"
-msgstr "Fehler"
+msgstr "Bug"
=20
 #: wt-status.c:212
 msgid "both deleted:"
@@ -676,11 +675,11 @@ msgstr "hinter "
=20
 #: wt-status.c:908 wt-status.c:911
 msgid "ahead "
-msgstr "=C3=BCber "
+msgstr "weiter: "
=20
 #: wt-status.c:913
 msgid ", behind "
-msgstr ", hinter "
+msgstr ", zur=C3=BCckgefallen "
=20
 #: builtin/add.c:62
 #, c-format
@@ -903,12 +902,12 @@ msgstr "Zweig '%s' zeigt auf keine Version"
 #: builtin/branch.c:396
 #, c-format
 msgid "behind %d] "
-msgstr "hinter %d] "
+msgstr "%d hinterher] "
=20
 #: builtin/branch.c:398
 #, c-format
 msgid "ahead %d] "
-msgstr "vor %d] "
+msgstr "%d voraus] "
=20
 #: builtin/branch.c:400
 #, c-format
@@ -1570,9 +1569,8 @@ msgid ""
 " Lines starting\n"
 "with '#' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
-" Zeilen beginnend\n"
-"mit '#' werden ignoriert, und eine leere Versionsbeschreibung bricht =
die "
-"Eintragung ab.\n"
+" Zeilen, die mit '#'\n"
+"beginnen, werden ignoriert, und eine leere Versionsbeschreibung brich=
t die Eintragung ab.\n"
=20
 #: builtin/commit.c:820
 msgid ""
@@ -1580,8 +1578,8 @@ msgid ""
 "with '#' will be kept; you may remove them yourself if you want to.\n=
"
 "An empty message aborts the commit.\n"
 msgstr ""
-" Zeilen beginnend\n"
-"mit '#' werden beibehalten; wenn du m=C3=B6chtest, kannst du diese en=
tfernen.\n"
+" Zeilen, die mit '#'\n"
+"beginnen, werden beibehalten; wenn du m=C3=B6chtest, kannst du diese =
entfernen.\n"
 "Eine leere Versionsbeschreibung bricht die Eintragung ab.\n"
=20
 #: builtin/commit.c:832
@@ -1762,7 +1760,7 @@ msgstr "annotierte Markierung %s hat keinen einge=
betteten Namen"
 #: builtin/describe.c:240
 #, c-format
 msgid "tag '%s' is really '%s' here"
-msgstr "Markierung '%s' ist wirklich '%s' hier"
+msgstr "Markierung '%s' ist eigentlich '%s' hier"
=20
 #: builtin/describe.c:267
 #, c-format
@@ -1831,7 +1829,7 @@ msgstr "Keine Namen gefunden, kann nichts beschre=
iben."
=20
 #: builtin/describe.c:482
 msgid "--dirty is incompatible with committishes"
-msgstr "--dirty ist inkompatibel mit \"committish\"-Werten"
+msgstr "--dirty ist inkompatibel mit Versionen"
=20
 #: builtin/diff.c:77
 #, c-format
@@ -2001,8 +1999,8 @@ msgid ""
 "remote name from which new revisions should be fetched."
 msgstr ""
 "Kein entferntes Projektarchiv spezifiziert. Bitte spezifiziere entwed=
er\n"
-"eine URL oder einen Entfernungsname, von welchem neue Revisionen ange=
fordert "
-"werden sollen."
+"eine URL oder den Namen eines entfernten Archivs, von welchem neue\n"
+"Revisionen angefordert werden sollen."
=20
 #: builtin/fetch.c:927
 msgid "You need to specify a tag name."
@@ -2034,7 +2032,7 @@ msgstr "Ung=C3=BCltiger %s: '%s'"
=20
 #: builtin/gc.c:78
 msgid "Too many options specified"
-msgstr "Zu viele Optionen spezifiziert"
+msgstr "Zu viele Optionen angegeben"
=20
 #: builtin/gc.c:103
 #, c-format
@@ -2044,7 +2042,7 @@ msgstr "wahnsinnig langes Objekt-Verzeichnis %.*s=
"
 #: builtin/gc.c:223
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
-msgstr "Automatische Paketierung des Repositories f=C3=BCr optimale Le=
itung.\n"
+msgstr "Automatisches packen des Projektarchivs f=C3=BCr optimale Leis=
tung.\n"
=20
 #: builtin/gc.c:226
 #, c-format
@@ -2052,17 +2050,13 @@ msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
-"Automatische Paketierung des Repositories f=C3=BCr optimale Leitung. =
Du darfst "
-"auch\n"
-"\"git gc\" manuell ausf=C3=BChren. Siehe \"git help gc\" f=C3=BCr wei=
tere "
-"Informationen.\n"
+"Automatisches packen des Projektarchivs f=C3=BCr optimale Leistung. D=
u kannst auch\n"
+"\"git gc\" manuell ausf=C3=BChren. Siehe \"git help gc\" f=C3=BCr wei=
tere Informationen.\n"
=20
 #: builtin/gc.c:256
 msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
-msgstr ""
-"Es gibt zu viele unerreichbare, verlorene Objekte; f=C3=BChre 'git pr=
une' aus um "
-"diese zu entfernen."
+msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' aus um diese zu entfernen."
=20
 #: builtin/grep.c:216
 #, c-format
@@ -2328,11 +2322,11 @@ msgstr "unechte Einreicher-Informationen %s"
=20
 #: builtin/log.c:1224
 msgid "-n and -k are mutually exclusive."
-msgstr "-n und -k sind zueinander exklusiv"
+msgstr "-n und -k schliessen sich gegenseitig aus"
=20
 #: builtin/log.c:1226
 msgid "--subject-prefix and -k are mutually exclusive."
-msgstr "--subject-prefix und -k sind zueinander exklusiv"
+msgstr "--subject-prefix und -k schliessen sich gegenseitig aus"
=20
 #: builtin/log.c:1231 builtin/shortlog.c:284
 #, c-format
@@ -2594,12 +2588,11 @@ msgstr "Kann nur exakt eine Version in einem le=
eren Kopf zusammenf=C3=BChren."
=20
 #: builtin/merge.c:1296
 msgid "Squash commit into empty head not supported yet"
-msgstr ""
-"Quetschen einer Version in einen leeren Kopf wird momentan nicht unte=
rst=C3=BCtzt."
+msgstr "Bin auf einem Zweig, der noch geboren wird; kann nicht quetsch=
en."
=20
 #: builtin/merge.c:1298
 msgid "Non-fast-forward commit does not make sense into an empty head"
-msgstr "nicht vorzuspulende Version macht in einem leeren Kopf keinen =
Sinn"
+msgstr "Bin auf einem Zweig, der noch geboren wird; --no-ff macht kein=
en Sinn."
=20
 #: builtin/merge.c:1413
 #, c-format
@@ -2997,7 +2990,7 @@ msgstr ""
 #: builtin/push.c:190
 #, c-format
 msgid "Pushing to %s\n"
-msgstr "Schiebe zu %s\n"
+msgstr "Versende nach %s\n"
=20
 #: builtin/push.c:194
 #, c-format
@@ -3061,19 +3054,19 @@ msgstr "--delete macht ohne irgendeine Referenz=
 keinen Sinn"
=20
 #: builtin/reset.c:33
 msgid "mixed"
-msgstr "gemischt"
+msgstr "mixed"
=20
 #: builtin/reset.c:33
 msgid "soft"
-msgstr "weich"
+msgstr "soft"
=20
 #: builtin/reset.c:33
 msgid "hard"
-msgstr "hart"
+msgstr "hard"
=20
 #: builtin/reset.c:33
 msgid "keep"
-msgstr "halten"
+msgstr "keep"
=20
 #: builtin/reset.c:77
 msgid "You do not have a valid HEAD."
@@ -3108,8 +3101,7 @@ msgstr "Nicht bereitgestellte =C3=84nderungen nac=
h Zur=C3=BCcksetzung:"
 #: builtin/reset.c:223
 #, c-format
 msgid "Cannot do a %s reset in the middle of a merge."
-msgstr ""
-"Kann keine %s Zur=C3=BCcksetzung innerhalb einer Zusammenf=C3=BChrung=
 durchf=C3=BChren."
+msgstr "Kann keine '%s' Zur=C3=BCcksetzung innerhalb einer Zusammenf=C3=
=BChrung durchf=C3=BChren."
=20
 #: builtin/reset.c:297
 #, c-format
@@ -3128,7 +3120,7 @@ msgstr ""
 #: builtin/reset.c:313
 #, c-format
 msgid "Cannot do %s reset with paths."
-msgstr "Kann keine %s Zur=C3=BCcksetzung mit Pfaden machen."
+msgstr "Kann keine '%s' Zur=C3=BCcksetzung mit Pfaden machen."
=20
 #: builtin/reset.c:325
 #, c-format
@@ -3237,7 +3229,7 @@ msgstr ""
 "\n"
 "#\n"
 "# Gebe eine Markierungsbeschreibung ein\n"
-"# Zeilen beginnend mit '#' werden ignoriert.\n"
+"# Zeilen, die mit '#' beginnen, werden ignoriert.\n"
 "#\n"
=20
 #: builtin/tag.c:254
@@ -3252,8 +3244,8 @@ msgstr ""
 "\n"
 "#\n"
 "# Gebe eine Markierungsbeschreibung ein\n"
-"# Zeilen beginnend mit '#' werden behalten; du darfst diese selbst en=
tfernen "
-"wenn du m=C3=B6chtest.\n"
+"# Zeilen, die mit '#' beginnen, werden behalten; du darfst diese\n"
+"# selbst entfernen wenn du m=C3=B6chtest.\n"
 "#\n"
=20
 #: builtin/tag.c:294
@@ -3351,8 +3343,7 @@ msgid ""
 "It does not apply to blobs recorded in its index."
 msgstr ""
 "Hast du den Patch per Hand editiert?\n"
-"Er kann nicht auf aufgezeichnete Blobs in seiner Bereitstellung angew=
endet "
-"werden."
+"Er kann nicht auf die Blobs in seiner 'index' Zeile angewendet werden=
=2E"
=20
 #: git-am.sh:163
 msgid "Falling back to patching base and 3-way merge..."
@@ -3398,9 +3389,7 @@ msgstr ""
=20
 #: git-am.sh:755
 msgid "cannot be interactive without stdin connected to a terminal."
-msgstr ""
-"Kann nicht interaktiv sein, ohne das die Standard-Eingabe mit einem T=
erminal "
-"verbunden ist."
+msgstr "Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit=
 einem Terminal verbunden ist."
=20
 #. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
 #. in your translation. The program will only accept English
@@ -3500,7 +3489,7 @@ msgid ""
 "Could not check out original HEAD '$branch'.\n"
 "Try 'git bisect reset <commit>'."
 msgstr ""
-"Konnte die originale Zweigspitze (HEAD) '$branch' nicht auschecken.\n=
"
+"Konnte die urspr=C3=BCngliche Zweigspitze (HEAD) '$branch' nicht ausc=
hecken.\n"
 "Versuche 'git bisect reset <Version>'."
=20
 #: git-bisect.sh:390
@@ -3543,7 +3532,7 @@ msgstr ""
=20
 #: git-pull.sh:253
 msgid "Cannot merge multiple branches into empty head"
-msgstr "Kann nicht mehrere Zweige in einen leeren Kopf zusammenf=C3=BC=
hren"
+msgstr "Kann nicht mehrere Zweige in einen ungeborenen Zweig zusammenf=
=C3=BChren"
=20
 #: git-pull.sh:257
 msgid "Cannot rebase onto multiple branches"
--=20
1.7.10.625.g300dcf
