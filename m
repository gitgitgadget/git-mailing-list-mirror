From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=2004/10=5D=20l10n=3A=20de=2Epo=3A=20collection=20of=20suggestions?=
Date: Tue,  8 May 2012 19:33:39 +0200
Message-ID: <1336498425-17890-5-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:34:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJ6-00029S-3b
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753730Ab2EHRec convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:32 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:41121 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753503Ab2EHRea (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:30 -0400
Received: by mail-wi0-f178.google.com with SMTP id hn19so437464wib.1
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=+dPXfcGhKsFxmh5CcOaJnkueYETsK7E6ZQW329SaQeQ=;
        b=E2TiU3oMfFWbLPQz6l2nh+MohuLD21f8wRs7nwe5zymm9E+1fIhDbJ1SoAnzG0sjbc
         MQRdCv9a1Hoq40tUwZYu2gKtx7Kin/dwz6IyYIpa25PdTr/Yd+gjWTgbdT5RoDGb3WmZ
         mPBCOdCwkm++VAgVpwmtx/JKjDIkjBOLqn94/r7etnhsw86I0FhNB/BSeiNNNyK0bduZ
         VPPZpN563NfyVVzSGb4HD7Ir0ZRCq16Q1cKbvm7ZIpPRlE1bRPevB+4mAj6XZBkoSaa/
         vkQGl2iuTAccSM0+vsTikHRGxLVzbVLpu6rrH9Pa69ykDl8pTXvMRD13clkl+vyfMZDL
         jbRQ==
Received: by 10.180.96.228 with SMTP id dv4mr46682031wib.14.1336498469382;
        Tue, 08 May 2012 10:34:29 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197402>

=46rom: Thomas Rast <trast@student.ethz.ch>

A long list of suggested changes to the translation.  None of them are
clear-cut, though I of course think they are an improvement ;-)

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |   99 ++++++++++++++++++++++++++++--------------------------=
--------
 1 Datei ge=C3=A4ndert, 44 Zeilen hinzugef=C3=BCgt(+), 55 Zeilen entfer=
nt(-)

diff --git a/po/de.po b/po/de.po
index 04e8468..abb719b 100644
--- a/po/de.po
+++ b/po/de.po
@@ -34,8 +34,8 @@ msgid ""
 "or use 'git commit -a'."
 msgstr ""
 "Korrigiere dies im Arbeitsbaum,\n"
-"und benutze dann 'git add/rm <Datei>' wie\n"
-"vorgesehen, um die Aufl=C3=B6sung zu markieren und dann einzutragen,\=
n"
+"und benutze dann 'git add/rm <Datei>'\n"
+"um die Aufl=C3=B6sung entsprechend zu markieren und einzutragen,\n"
 "oder benutze 'git commit -a'."
=20
 #: commit.c:47
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
@@ -441,7 +441,7 @@ msgstr ""
 #: wt-status.c:143
 msgid "  (use \"git add/rm <file>...\" as appropriate to mark resoluti=
on)"
 msgstr ""
-"  (benutze \"git add/rm <Datei>...\" wie vorgesehen, um die Aufl=C3=B6=
sung zu "
+"  (benutze \"git add/rm <Datei>...\" um die Aufl=C3=B6sung entspreche=
nd zu "
 "markieren)"
=20
 #: wt-status.c:151
@@ -454,12 +454,11 @@ msgstr "=C3=84nderungen, die nicht zum Eintragen =
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
@@ -655,11 +654,11 @@ msgstr "hinter "
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
@@ -882,12 +881,12 @@ msgstr "Zweig '%s' zeigt auf keine Version"
 #: builtin/branch.c:394
 #, c-format
 msgid "behind %d] "
-msgstr "hinter %d] "
+msgstr "%d hinterher] "
=20
 #: builtin/branch.c:396
 #, c-format
 msgid "ahead %d] "
-msgstr "vor %d] "
+msgstr "%d voraus] "
=20
 #: builtin/branch.c:398
 #, c-format
@@ -1549,9 +1548,8 @@ msgid ""
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
@@ -1559,8 +1557,8 @@ msgid ""
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
@@ -1741,7 +1739,7 @@ msgstr "annotierte Markierung %s hat keinen einge=
betteten Namen"
 #: builtin/describe.c:240
 #, c-format
 msgid "tag '%s' is really '%s' here"
-msgstr "Markierung '%s' ist wirklich '%s' hier"
+msgstr "Markierung '%s' ist eigentlich '%s' hier"
=20
 #: builtin/describe.c:267
 #, c-format
@@ -1810,7 +1808,7 @@ msgstr "Keine Namen gefunden, kann nichts beschre=
iben."
=20
 #: builtin/describe.c:482
 msgid "--dirty is incompatible with committishes"
-msgstr "--dirty ist inkompatibel mit \"committish\"-Werten"
+msgstr "--dirty ist inkompatibel mit Versionen"
=20
 #: builtin/diff.c:77
 #, c-format
@@ -1976,8 +1974,8 @@ msgid ""
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
 #: builtin/fetch.c:918
 msgid "You need to specify a tag name."
@@ -2009,7 +2007,7 @@ msgstr "Ung=C3=BCltiger %s: '%s'"
=20
 #: builtin/gc.c:78
 msgid "Too many options specified"
-msgstr "Zu viele Optionen spezifiziert"
+msgstr "Zu viele Optionen angegeben"
=20
 #: builtin/gc.c:103
 #, c-format
@@ -2019,7 +2017,7 @@ msgstr "wahnsinnig langes Objekt-Verzeichnis %.*s=
"
 #: builtin/gc.c:223
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
-msgstr "Automatische Paketierung des Repositories f=C3=BCr optimale Le=
itung.\n"
+msgstr "Automatisches Packen des Projektarchivs f=C3=BCr optimale Leis=
tung.\n"
=20
 #: builtin/gc.c:226
 #, c-format
@@ -2027,17 +2025,13 @@ msgid ""
 "Auto packing the repository for optimum performance. You may also\n"
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
-"Automatische Paketierung des Repositories f=C3=BCr optimale Leitung. =
Du darfst "
-"auch\n"
-"\"git gc\" manuell ausf=C3=BChren. Siehe \"git help gc\" f=C3=BCr wei=
tere "
-"Informationen.\n"
+"Automatisches Packen des Projektarchivs f=C3=BCr optimale Leistung. D=
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
@@ -2303,11 +2297,11 @@ msgstr "unechte Einreicher-Information %s"
=20
 #: builtin/log.c:1218
 msgid "-n and -k are mutually exclusive."
-msgstr "-n und -k sind zueinander exklusiv"
+msgstr "-n und -k schliessen sich gegenseitig aus"
=20
 #: builtin/log.c:1220
 msgid "--subject-prefix and -k are mutually exclusive."
-msgstr "--subject-prefix und -k sind zueinander exklusiv"
+msgstr "--subject-prefix und -k schliessen sich gegenseitig aus"
=20
 #: builtin/log.c:1225 builtin/shortlog.c:284
 #, c-format
@@ -2564,12 +2558,11 @@ msgstr "Kann nur exakt eine Version in einem le=
eren Kopf zusammenf=C3=BChren."
=20
 #: builtin/merge.c:1269
 msgid "Squash commit into empty head not supported yet"
-msgstr ""
-"Quetschen einer Version in einen leeren Kopf wird momentan nicht unte=
rst=C3=BCtzt."
+msgstr "Bin auf einem Zweig, der noch geboren wird; kann nicht quetsch=
en."
=20
 #: builtin/merge.c:1271
 msgid "Non-fast-forward commit does not make sense into an empty head"
-msgstr "nicht vorzuspulende Version macht in einem leeren Kopf keinen =
Sinn"
+msgstr "Bin auf einem Zweig, der noch geboren wird; --no-ff macht kein=
en Sinn."
=20
 #: builtin/merge.c:1275 builtin/merge.c:1319
 #, c-format
@@ -2932,7 +2925,7 @@ msgstr ""
 #: builtin/push.c:147
 #, c-format
 msgid "Pushing to %s\n"
-msgstr "Sende nach %s\n"
+msgstr "Versende nach %s\n"
=20
 #: builtin/push.c:151
 #, c-format
@@ -3009,19 +3002,19 @@ msgstr "--delete macht ohne irgendeine Referenz=
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
@@ -3056,8 +3049,7 @@ msgstr "Nicht bereitgestellte =C3=84nderungen nac=
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
@@ -3076,7 +3068,7 @@ msgstr ""
 #: builtin/reset.c:313
 #, c-format
 msgid "Cannot do %s reset with paths."
-msgstr "Kann keine %s Zur=C3=BCcksetzung mit Pfaden machen."
+msgstr "Kann keine '%s' Zur=C3=BCcksetzung mit Pfaden machen."
=20
 #: builtin/reset.c:325
 #, c-format
@@ -3185,7 +3177,7 @@ msgstr ""
 "\n"
 "#\n"
 "# Gebe eine Markierungsbeschreibung ein\n"
-"# Zeilen beginnend mit '#' werden ignoriert.\n"
+"# Zeilen, die mit '#' beginnen, werden ignoriert.\n"
 "#\n"
=20
 #: builtin/tag.c:254
@@ -3200,8 +3192,8 @@ msgstr ""
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
@@ -3299,8 +3291,7 @@ msgid ""
 "It does not apply to blobs recorded in its index."
 msgstr ""
 "Hast du den Patch per Hand editiert?\n"
-"Er kann nicht auf aufgezeichnete Blobs in seiner Bereitstellung angew=
endet "
-"werden."
+"Er kann nicht auf die Blobs in seiner 'index' Zeile angewendet werden=
=2E"
=20
 #: git-am.sh:156
 msgid "Falling back to patching base and 3-way merge..."
@@ -3346,9 +3337,7 @@ msgstr ""
=20
 #: git-am.sh:748
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
@@ -3448,7 +3437,7 @@ msgid ""
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
@@ -3476,7 +3465,7 @@ msgid ""
 msgstr ""
 "\"pull\" ist nicht m=C3=B6glich weil du nicht zusammengef=C3=BChrte D=
ateien hast.\n"
 "Bitte korrigiere dies im Arbeitsbaum und benutze dann 'git add/rm <Da=
tei>'\n"
-"wie vorgesehen, um die Aufl=C3=B6sung zu markieren, oder benutze 'git=
 commit -a'."
+"um die Aufl=C3=B6sung entsprechend zu markieren, oder benutze 'git co=
mmit -a'."
=20
 #: git-pull.sh:25
 msgid "Pull is not possible because you have unmerged files."
@@ -3491,7 +3480,7 @@ msgstr ""
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
1.7.10.129.g1ec31a3
