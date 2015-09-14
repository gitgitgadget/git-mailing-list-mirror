From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 123 new messages
Date: Mon, 14 Sep 2015 19:20:02 +0200
Message-ID: <1442251202-9944-1-git-send-email-ralf.thielow@gmail.com>
References: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org, phillip.szelat@gmail.com,
	matthias.ruester@gmail.com
X-From: git-owner@vger.kernel.org Mon Sep 14 19:20:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXQT-0004cD-P9
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbbINRUP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2015 13:20:15 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37753 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753291AbbINRUL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:20:11 -0400
Received: by wicfx3 with SMTP id fx3so141648183wic.0
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=lOpZWkBQdj9SjlD+AuRJHHBL2nMnCslcVJYdKSK27lI=;
        b=kqYHZa2CTxBXCdjHrAJICU0M1k9fcV1Cxd8aFw+rz+KsHYNsI3E+iH7ySynOOgiUZt
         LqLuxc0NWhGDfIc/WKPbgh0wX67msHeKfCJCb81S1hvRtx/s21VeMEfjE2SX9M4hddz7
         Ms2HfcSxAa4tKoL4zSDjdPSW9kTEgDwtLAWcGN6n8L8ByxKz/ecwPgc/I4O+q0bfO7Nl
         3WnTSApPyNmDb36FNn2uZ7OaCmxcjc4gBvYZ2axoxS9tgJb46/LnTevZnwlY3BOTXVPb
         GaAghq824T/KydQEobr4Sqbyb3KB8TN6iTZ1J5GcSfRfhrVNZxx6LTI60+DZ+xcT8C2W
         lonQ==
X-Received: by 10.180.108.177 with SMTP id hl17mr27555841wib.45.1442251210077;
        Mon, 14 Sep 2015 10:20:10 -0700 (PDT)
Received: from localhost (cable-94-139-24-49.cust.telecolumbus.net. [94.139.24.49])
        by smtp.gmail.com with ESMTPSA id lh11sm15367634wic.18.2015.09.14.10.20.08
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 14 Sep 2015 10:20:08 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc1.199.g678474c
In-Reply-To: <1441985744-882-1-git-send-email-ralf.thielow@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277846>

Translate 123 new messages came from git.pot update in df0617b
(l10n: git.pot: v2.6.0 round 1 (123 new, 41 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 395 ++++++++++++++++++++++++++++++-------------------------=
--------
 1 file changed, 188 insertions(+), 207 deletions(-)

diff --git a/po/de.po b/po/de.po
index b6fa9b4..7354c59 100644
--- a/po/de.po
+++ b/po/de.po
@@ -33,19 +33,18 @@ msgstr ""
=20
 #: advice.c:101 builtin/merge.c:1227
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existier=
t)."
=20
 #: advice.c:103
-#, fuzzy
 msgid "Please, commit your changes before you can merge."
-msgstr "Bitte gebe die Versionsbeschreibung f=C3=BCr deine =C3=84nderu=
ngen ein."
+msgstr "Bitte committen Sie Ihre =C3=84nderungen, bevor Sie den Merge =
ausf=C3=BChren."
=20
 #: advice.c:104
 msgid "Exiting because of unfinished merge."
-msgstr ""
+msgstr "Beende wegen nicht abgeschlossenem Merge."
=20
 #: archive.c:12
 msgid "git archive [<options>] <tree-ish> [<path>...]"
 msgstr "git archive [<Optionen>] <Commit-Referenz> [<Pfad>...]"
=20
 #: archive.c:13
@@ -1084,25 +1083,25 @@ msgstr ""
 #: builtin/merge.c:983
 #, c-format
 msgid "Could not open '%s' for writing"
 msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
=20
 #: refs.c:3001
-#, fuzzy, c-format
+#, c-format
 msgid "could not delete reference %s: %s"
-msgstr "Konnte %s nicht entfernen"
+msgstr "Konnte Referenz %s nicht entfernen: %s"
=20
 #: refs.c:3004
-#, fuzzy, c-format
+#, c-format
 msgid "could not delete references: %s"
-msgstr "Konnte %s nicht entfernen"
+msgstr "Konnte Referenzen nicht entfernen: %s"
=20
 #: refs.c:3013
-#, fuzzy, c-format
+#, c-format
 msgid "could not remove reference %s"
-msgstr "Konnte Branch %s nicht l=C3=B6schen"
+msgstr "Konnte Referenz %s nicht l=C3=B6schen"
=20
 #: ref-filter.c:660
 msgid "unable to parse format"
 msgstr "Konnte Format nicht parsen."
=20
 #: remote.c:792
@@ -1228,20 +1227,19 @@ msgstr[1] ""
 msgid "  (use \"git pull\" to merge the remote branch into yours)\n"
 msgstr ""
 "  (benutzen Sie \"git pull\", um Ihren Branch mit dem Remote-Branch "
 "zusammenzuf=C3=BChren)\n"
=20
 #: revision.c:2198
-#, fuzzy
 msgid "your current branch appears to be broken"
-msgstr "Sie sind auf einem Branch, der noch geboren wird"
+msgstr "Ihr aktueller Branch scheint fehlerhaft zu sein."
=20
 #: revision.c:2201
-#, fuzzy, c-format
+#, c-format
 msgid "your current branch '%s' does not have any commits yet"
-msgstr "Branch '%s' zeigt auf keinen Commit"
+msgstr "Ihr aktueller Branch '%s' hat noch keine Commits."
=20
 #: revision.c:2395
 msgid "--first-parent is incompatible with --bisect"
 msgstr "Die Optionen --first-parent und --bisect sind inkompatibel."
=20
 #: run-command.c:83
@@ -1260,18 +1258,18 @@ msgstr "Fehler beim Signieren des \"push\"-Zert=
ifikates"
 #: send-pack.c:404
 msgid "the receiving end does not support --signed push"
 msgstr ""
 "die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"--signed=
 push\")"
=20
 #: send-pack.c:406
-#, fuzzy
 msgid ""
 "not sending a push certificate since the receiving end does not suppo=
rt --"
 "signed push"
 msgstr ""
-"die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"--signed=
 push\")"
+"kein Versand des \"push\"-Zertifikates, da die Gegenseite keinen sign=
ierten\n"
+"Versand (\"--signed push\") unterst=C3=BCtzt"
=20
 #: send-pack.c:418
 msgid "the receiving end does not support --atomic push"
 msgstr "die Gegenseite unterst=C3=BCtzt keinen atomaren Versand (\"--a=
tomic push\")"
=20
 #: sequencer.c:183
@@ -1311,13 +1309,13 @@ msgstr ""
 msgid "Your local changes would be overwritten by revert."
 msgstr "Ihre lokalen =C3=84nderungen w=C3=BCrden von \"revert\" =C3=BC=
berschrieben werden."
=20
 #: sequencer.c:222
 msgid "Commit your changes or stash them to proceed."
 msgstr ""
-"Tragen Sie Ihre =C3=84nderungen ein oder benutzen Sie \"stash\", um f=
ortzufahren."
+"Committen Sie Ihre =C3=84nderungen oder benutzen Sie \"stash\", um fo=
rtzufahren."
=20
 #. TRANSLATORS: %s will be "revert" or "cherry-pick"
 #: sequencer.c:309
 #, c-format
 msgid "%s: Unable to write new index file"
 msgstr "%s: Konnte neue Index-Datei nicht schreiben"
@@ -1594,15 +1592,15 @@ msgstr "Konnte Eingabe-Datei '%s' nicht lesen"
=20
 #: trailer.c:704
 msgid "could not read from stdin"
 msgstr "konnte nicht von der Standard-Eingabe lesen"
=20
 #: transport-helper.c:1025
-#, fuzzy, c-format
+#, c-format
 msgid "Could not read ref %s"
-msgstr "Konnte %s nicht lesen."
+msgstr "Konnte Referenz %s nicht lesen."
=20
 #: unpack-trees.c:203
 msgid "Checking out files"
 msgstr "Checke Dateien aus"
=20
 #: urlmatch.c:120
@@ -1632,18 +1630,18 @@ msgstr "ung=C3=BCltige Portnummer"
=20
 #: urlmatch.c:322
 msgid "invalid '..' path segment"
 msgstr "ung=C3=BCltiges '..' Pfadsegment"
=20
 #: wrapper.c:219 wrapper.c:362
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s' for reading and writing"
-msgstr "Konnte '%s' nicht zum Lesen =C3=B6ffnen."
+msgstr "Konnte '%s' nicht zum Lesen und Schreiben =C3=B6ffnen."
=20
 #: wrapper.c:221 wrapper.c:364
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s' for writing"
 msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
=20
 #: wrapper.c:223 wrapper.c:366 builtin/am.c:337 builtin/commit.c:1688
 #: builtin/merge.c:1076 builtin/pull.c:380
 #, c-format
@@ -1896,44 +1894,41 @@ msgstr "  (benutzen Sie \"git am --skip\", um d=
iesen Patch auszulassen)"
 msgid "  (use \"git am --abort\" to restore the original branch)"
 msgstr ""
 "  (benutzen Sie \"git am --abort\", um den urspr=C3=BCnglichen Branch=
 "
 "wiederherzustellen)"
=20
 #: wt-status.c:1105
-#, fuzzy
 msgid "No commands done."
-msgstr "Keine Commits geparst."
+msgstr "Keine Kommandos ausgef=C3=BChrt."
=20
 #: wt-status.c:1108
 #, c-format
 msgid "Last command done (%d command done):"
 msgid_plural "Last commands done (%d commands done):"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "Letztes Kommando ausgef=C3=BChrt (%d Kommando ausgef=C3=BCh=
rt):"
+msgstr[1] "Letzte Kommandos ausgef=C3=BChrt (%d Kommandos ausgef=C3=BC=
hrt):"
=20
 #: wt-status.c:1119
 #, c-format
 msgid "  (see more in file %s)"
-msgstr ""
+msgstr "  (mehr Informationen in Datei %s)"
=20
 #: wt-status.c:1124
-#, fuzzy
 msgid "No commands remaining."
-msgstr "Keine Commits geparst."
+msgstr "Keine Kommandos verbleibend."
=20
 #: wt-status.c:1127
 #, c-format
 msgid "Next command to do (%d remaining command):"
 msgid_plural "Next commands to do (%d remaining commands):"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "N=C3=A4chstes auszuf=C3=BChrendes Kommando (%d Kommando ver=
bleibend):"
+msgstr[1] "N=C3=A4chste auszuf=C3=BChrende Kommandos (%d Kommandos ver=
bleibend):"
=20
 #: wt-status.c:1135
-#, fuzzy
 msgid "  (use \"git rebase --edit-todo\" to view and edit)"
-msgstr "  (benutzen Sie \"git rebase --skip\", um diesen Patch auszula=
ssen)"
+msgstr "  (benutzen Sie \"git rebase --edit-todo\" zum Ansehen und Bea=
rbeiten)"
=20
 #: wt-status.c:1148
 #, c-format
 msgid "You are currently rebasing branch '%s' on '%s'."
 msgstr "Sie sind gerade beim Rebase von Branch '%s' auf '%s'."
=20
@@ -2062,15 +2057,14 @@ msgstr ""
=20
 #: wt-status.c:1437
 msgid "On branch "
 msgstr "Auf Branch "
=20
 #: wt-status.c:1445
-#, fuzzy
 msgid "interactive rebase in progress; onto "
-msgstr "Rebase im Gange; auf "
+msgstr "interaktives Rebase im Gange; auf "
=20
 #: wt-status.c:1447
 msgid "rebase in progress; onto "
 msgstr "Rebase im Gange; auf "
=20
 #: wt-status.c:1452
@@ -2346,127 +2340,123 @@ msgstr "Index-Datei besch=C3=A4digt"
=20
 #: builtin/add.c:445 builtin/apply.c:4678 builtin/mv.c:279 builtin/rm.=
c:430
 msgid "Unable to write new index file"
 msgstr "Konnte neue Index-Datei nicht schreiben."
=20
 #: builtin/am.c:41
-#, fuzzy, c-format
+#, c-format
 msgid "could not stat %s"
-msgstr "Konnte Verzeichnis '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen"
=20
 #: builtin/am.c:270 builtin/am.c:1318 builtin/commit.c:737
 #: builtin/merge.c:1079
 #, c-format
 msgid "could not read '%s'"
 msgstr "Konnte '%s' nicht lesen"
=20
 #: builtin/am.c:444
-#, fuzzy
 msgid "could not parse author script"
-msgstr "konnte %s nicht parsen"
+msgstr "konnte Autor-Skript nicht parsen"
=20
 #: builtin/am.c:521
 #, c-format
 msgid "'%s' was deleted by the applypatch-msg hook"
-msgstr ""
+msgstr "'%s' wurde durch den applypatch-msg Hook entfernt"
=20
 #: builtin/am.c:562 builtin/notes.c:300
 #, c-format
 msgid "Malformed input line: '%s'."
 msgstr "Fehlerhafte Eingabezeile: '%s'."
=20
 #: builtin/am.c:599 builtin/notes.c:315
 #, c-format
 msgid "Failed to copy notes from '%s' to '%s'"
 msgstr "Fehler beim Kopieren der Notizen von '%s' nach '%s'"
=20
 #: builtin/am.c:625
-#, fuzzy
 msgid "fseek failed"
-msgstr "\"revert\" fehlgeschlagen"
+msgstr "\"fseek\" fehlgeschlagen"
=20
 #: builtin/am.c:786 builtin/am.c:874
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s' for reading: %s"
-msgstr "Konnte '%s' nicht zum Lesen =C3=B6ffnen."
+msgstr "Konnte '%s' nicht zum Lesen =C3=B6ffnen: %s"
=20
 #: builtin/am.c:793
-#, fuzzy, c-format
+#, c-format
 msgid "could not open '%s' for writing: %s"
-msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
+msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen: %s"
=20
 #: builtin/am.c:802
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse patch '%s'"
-msgstr "konnte %s nicht parsen"
+msgstr "konnte Patch '%s' nicht parsen"
=20
 #: builtin/am.c:867
 msgid "Only one StGIT patch series can be applied at once"
 msgstr "Es kann nur eine StGIT Patch-Serie auf einmal angewendet werde=
n."
=20
 #: builtin/am.c:915
-#, fuzzy
 msgid "invalid timestamp"
-msgstr "'%s' ist kein g=C3=BCltiger Zeitstempel"
+msgstr "ung=C3=BCltiger Zeitstempel"
=20
 #: builtin/am.c:918 builtin/am.c:926
-#, fuzzy
 msgid "invalid Date line"
-msgstr "Ung=C3=BCltige Identifikationszeile: %s"
+msgstr "Ung=C3=BCltige \"Date\"-Zeile"
=20
 #: builtin/am.c:923
-#, fuzzy
 msgid "invalid timezone offset"
-msgstr "Ung=C3=BCltige Option: %s"
+msgstr "Ung=C3=BCltiger Offset in der Zeitzone"
=20
 #: builtin/am.c:1010
 msgid "Patch format detection failed."
 msgstr "Patch-Formaterkennung fehlgeschlagen."
=20
 #: builtin/am.c:1015 builtin/clone.c:368
 #, c-format
 msgid "failed to create directory '%s'"
 msgstr "Fehler beim Erstellen von Verzeichnis '%s'"
=20
 #: builtin/am.c:1019
-#, fuzzy
 msgid "Failed to split patches."
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Fehler beim Aufteilen der Patches."
=20
 #: builtin/am.c:1151 builtin/commit.c:362
 msgid "unable to write index file"
 msgstr "Konnte Index-Datei nicht schreiben."
=20
 #: builtin/am.c:1202
 #, c-format
 msgid "When you have resolved this problem, run \"%s --continue\"."
-msgstr ""
+msgstr "Wenn Sie das Problem aufgel=C3=B6st haben, f=C3=BChren Sie \"%=
s --continue\" aus."
=20
 #: builtin/am.c:1203
 #, c-format
 msgid "If you prefer to skip this patch, run \"%s --skip\" instead."
-msgstr ""
+msgstr "Falls Sie diesen Patch auslassen m=C3=B6chten, f=C3=BChren Sie=
 stattdessen "
+"\"%s --skip\" aus."
=20
 #: builtin/am.c:1204
 #, c-format
 msgid "To restore the original branch and stop patching, run \"%s --ab=
ort\"."
-msgstr ""
+msgstr "Um den urspr=C3=BCnglichen Branch wiederherzustellen und die A=
nwendung der "
+"Patches abzubrechen, f=C3=BChren Sie \"%s --abort\" aus."
=20
 #: builtin/am.c:1312
 msgid "Patch is empty. Was it split wrong?"
-msgstr ""
+msgstr "Patch ist leer. War dessen Aufteilung falsch?"
=20
 #: builtin/am.c:1386 builtin/log.c:1345
 #, c-format
 msgid "invalid ident line: %s"
 msgstr "Ung=C3=BCltige Identifikationszeile: %s"
=20
 #: builtin/am.c:1413
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse commit %s"
-msgstr "Konnte Kontakt '%s' nicht parsen."
+msgstr "Konnte Commit '%s' nicht parsen."
=20
 #: builtin/am.c:1587
 msgid "Repository lacks necessary blobs to fall back on 3-way merge."
 msgstr ""
 "Dem Repository fehlen notwendige Blobs um auf einen 3-Wege-Merge "
 "zur=C3=BCckzufallen."
@@ -2504,15 +2494,15 @@ msgstr "auf leere Historie anwenden"
 #: builtin/am.c:1684 builtin/commit.c:1752 builtin/merge.c:829
 #: builtin/merge.c:854
 msgid "failed to write commit object"
 msgstr "Fehler beim Schreiben des Commit-Objektes."
=20
 #: builtin/am.c:1716 builtin/am.c:1720
-#, fuzzy, c-format
+#, c-format
 msgid "cannot resume: %s does not exist."
-msgstr "Branch '%s' existiert nicht"
+msgstr "Kann nicht fortsetzen: %s existiert nicht"
=20
 #: builtin/am.c:1736
 msgid "cannot be interactive without stdin connected to a terminal."
 msgstr ""
 "Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit einem =
"
 "Terminal verbunden ist."
@@ -2523,41 +2513,39 @@ msgstr "Commit-Beschreibung ist:"
=20
 #. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
 #. in your translation. The program will only accept English
 #. input at this point.
 #.
 #: builtin/am.c:1751
-#, fuzzy
 msgid "Apply? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "
-msgstr "Anwenden? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all "
+msgstr "Anwenden? [y]es/[n]o/[e]dit/[v]iew patch/[a]ccept all: "
=20
 #: builtin/am.c:1801
-#, fuzzy, c-format
+#, c-format
 msgid "Dirty index: cannot apply patches (dirty: %s)"
-msgstr "Ge=C3=A4nderter Index: kann Patches nicht anwenden (ge=C3=A4nd=
ert: $files)"
+msgstr "Ge=C3=A4nderter Index: kann Patches nicht anwenden (ge=C3=A4nd=
ert: %s)"
=20
 #: builtin/am.c:1836 builtin/am.c:1907
-#, fuzzy, c-format
+#, c-format
 msgid "Applying: %.*s"
-msgstr "Hinweis: %.*s\n"
+msgstr "Wende an: %.*s"
=20
 #: builtin/am.c:1852
 msgid "No changes -- Patch already applied."
 msgstr "Keine =C3=84nderungen -- Patches bereits angewendet."
=20
 #: builtin/am.c:1860
-#, fuzzy, c-format
+#, c-format
 msgid "Patch failed at %s %.*s"
-msgstr "Anwendung des Patches fehlgeschlagen: %s:%ld"
+msgstr "Anwendung des Patches fehlgeschlagen bei %s %.*s"
=20
 #: builtin/am.c:1866
-#, fuzzy, c-format
+#, c-format
 msgid "The copy of the patch that failed is found in: %s"
 msgstr ""
-"Die Kopie des fehlgeschlagenen Patches befindet sich in:\n"
-"   $dotest/patch"
+"Die Kopie des fehlgeschlagenen Patches befindet sich in: %s"
=20
 #: builtin/am.c:1910
 msgid ""
 "No changes - did you forget to use 'git add'?\n"
 "If there is nothing left to stage, chances are that something else\n"
 "already introduced the same changes; you might want to skip this patc=
h."
@@ -2565,13 +2553,12 @@ msgstr ""
 "Keine =C3=84nderungen - haben Sie vergessen 'git add' zu benutzen?\n"
 "Wenn keine =C3=84nderungen mehr zum Commit vorzumerken sind, k=C3=B6n=
nten\n"
 "diese bereits anderweitig eingef=C3=BCgt worden sein; Sie k=C3=B6nnte=
n diesen Patch\n"
 "auslassen."
=20
 #: builtin/am.c:1917
-#, fuzzy
 msgid ""
 "You still have unmerged paths in your index.\n"
 "Did you forget to use 'git add'?"
 msgstr ""
 "Sie haben immer noch nicht zusammengef=C3=BChrte Pfade im Index.\n"
 "Haben Sie vergessen 'git add' zu benutzen?"
@@ -2580,104 +2567,94 @@ msgstr ""
 #: builtin/reset.c:316
 #, c-format
 msgid "Could not parse object '%s'."
 msgstr "Konnte Objekt '%s' nicht parsen."
=20
 #: builtin/am.c:2077
-#, fuzzy
 msgid "failed to clean index"
-msgstr "Konnte Datei '%s' nicht erstellen"
+msgstr "Fehler beim Bereinigen des Index"
=20
 #: builtin/am.c:2111
 msgid ""
 "You seem to have moved HEAD since the last 'am' failure.\n"
 "Not rewinding to ORIG_HEAD"
 msgstr ""
 "Sie scheinen seit dem letzten gescheiterten 'am' HEAD ge=C3=A4ndert z=
u haben.\n"
 "Keine Zur=C3=BCcksetzung zu ORIG_HEAD."
=20
 #: builtin/am.c:2172
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid value for --patch-format: %s"
-msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s: %s"
+msgstr "Ung=C3=BCltiger Wert f=C3=BCr --patch-format: %s"
=20
 #: builtin/am.c:2194
-#, fuzzy
 msgid "git am [options] [(<mbox>|<Maildir>)...]"
-msgstr "git merge [<Optionen>] [<Commit>...]"
+msgstr "git am [Optionen] [(<mbox>|<E-Mail-Verzeichnis>)...]"
=20
 #: builtin/am.c:2195
-#, fuzzy
 msgid "git am [options] (--continue | --skip | --abort)"
-msgstr "versuchen Sie \"git cherry-pick (--continue | --quit | --abort=
)\""
+msgstr "git am [Optionen] (--continue | --skip | --abort)"
=20
 #: builtin/am.c:2201
-#, fuzzy
 msgid "run interactively"
-msgstr "Bl=C3=B6cke interaktiv ausw=C3=A4hlen"
+msgstr "interaktiv ausf=C3=BChren"
=20
 #: builtin/am.c:2203
 msgid "historical option -- no-op"
-msgstr ""
+msgstr "historische Option -- kein Effekt"
=20
 #: builtin/am.c:2205
-#, fuzzy
 msgid "allow fall back on 3way merging if needed"
-msgstr "Kann nicht zu 3-Wege-Merge zur=C3=BCckfallen."
+msgstr "erlaube, falls notwendig, das Zur=C3=BCckfallen auf einen 3-We=
ge-Merge"
=20
 #: builtin/am.c:2206 builtin/init-db.c:509 builtin/prune-packed.c:57
 #: builtin/repack.c:171
 msgid "be quiet"
 msgstr "weniger Ausgaben"
=20
 #: builtin/am.c:2208
-#, fuzzy
 msgid "add a Signed-off-by line to the commit message"
-msgstr "Commit-Beschreibung bearbeiten"
+msgstr "der Commit-Beschreibung eine Signed-off-by Zeile hinzuf=C3=BCg=
en"
=20
 #: builtin/am.c:2211
-#, fuzzy
 msgid "recode into utf8 (default)"
-msgstr "ignorierte Dateien aktualisieren (Standard)"
+msgstr "nach UTF-8 umkodieren (Standard)"
=20
 #: builtin/am.c:2213
-#, fuzzy
 msgid "pass -k flag to git-mailinfo"
-msgstr "--local an git-pack-objects =C3=BCbergeben"
+msgstr "-k an git-mailinfo =C3=BCbergeben"
=20
 #: builtin/am.c:2215
-#, fuzzy
 msgid "pass -b flag to git-mailinfo"
-msgstr "--local an git-pack-objects =C3=BCbergeben"
+msgstr "-b an git-mailinfo =C3=BCbergeben"
=20
 #: builtin/am.c:2217
-#, fuzzy
 msgid "pass -m flag to git-mailinfo"
-msgstr "--local an git-pack-objects =C3=BCbergeben"
+msgstr "-m an git-mailinfo =C3=BCbergeben"
=20
 #: builtin/am.c:2219
 msgid "pass --keep-cr flag to git-mailsplit for mbox format"
-msgstr ""
+msgstr "--keep-cr an git-mailsplit f=C3=BCr mbox-Format =C3=BCbergeben=
"
=20
 #: builtin/am.c:2222
 msgid "do not pass --keep-cr flag to git-mailsplit independent of am.k=
eepcr"
-msgstr ""
+msgstr "kein --keep-cr an git-mailsplit =C3=BCbergeben, unabh=C3=A4ngi=
g von am.keepcr"
=20
 #: builtin/am.c:2225
 msgid "strip everything before a scissors line"
-msgstr ""
+msgstr "alles vor einer Scheren-Zeile entfernen"
=20
 #: builtin/am.c:2226 builtin/apply.c:4563
 msgid "action"
 msgstr "Aktion"
=20
 #: builtin/am.c:2227 builtin/am.c:2230 builtin/am.c:2233 builtin/am.c:=
2236
 #: builtin/am.c:2239 builtin/am.c:2242 builtin/am.c:2245 builtin/am.c:=
2248
 #: builtin/am.c:2254
 msgid "pass it through git-apply"
-msgstr ""
+msgstr "an git-apply =C3=BCbergeben"
=20
 #: builtin/am.c:2235 builtin/apply.c:4587
 msgid "root"
 msgstr "Wurzelverzeichnis"
=20
 #: builtin/am.c:2238 builtin/am.c:2241 builtin/apply.c:4525
@@ -2701,84 +2678,81 @@ msgstr "Anzahl"
 #: builtin/am.c:2250 builtin/for-each-ref.c:34 builtin/replace.c:438
 msgid "format"
 msgstr "Format"
=20
 #: builtin/am.c:2251
 msgid "format the patch(es) are in"
-msgstr ""
+msgstr "Patch-Format"
=20
 #: builtin/am.c:2257
 msgid "override error message when patch failure occurs"
-msgstr ""
+msgstr "Meldung bei fehlerhafter Patch-Anwendung =C3=BCberschreiben"
=20
 #: builtin/am.c:2259
 msgid "continue applying patches after resolving a conflict"
-msgstr ""
+msgstr "Anwendung der Patches nach Aufl=C3=B6sung eines Konfliktes for=
tsetzen"
=20
 #: builtin/am.c:2262
-#, fuzzy
 msgid "synonyms for --continue"
-msgstr "(Synonym f=C3=BCr --stat)"
+msgstr "Synonyme f=C3=BCr --continue"
=20
 #: builtin/am.c:2265
-#, fuzzy
 msgid "skip the current patch"
-msgstr "den aktuellen Branch einbeziehen"
+msgstr "den aktuellen Patch auslassen"
=20
 #: builtin/am.c:2268
 msgid "restore the original branch and abort the patching operation."
-msgstr ""
+msgstr "urspr=C3=BCnglichen Branch wiederherstellen und Anwendung der =
Patches "
+"abbrechen"
=20
 #: builtin/am.c:2272
 msgid "lie about committer date"
-msgstr ""
+msgstr "Autor-Datum als Commit-Datum verwenden"
=20
 #: builtin/am.c:2274
 msgid "use current timestamp for author date"
-msgstr ""
+msgstr "aktuellen Zeitstempel als Autor-Datum verwenden"
=20
 #: builtin/am.c:2276 builtin/commit.c:1590 builtin/merge.c:225
 #: builtin/pull.c:155 builtin/revert.c:92 builtin/tag.c:606
 msgid "key-id"
 msgstr "GPG-Schl=C3=BCsselkennung"
=20
 #: builtin/am.c:2277
-#, fuzzy
 msgid "GPG-sign commits"
-msgstr "Commit mit GPG signieren"
+msgstr "Commits mit GPG signieren"
=20
 #: builtin/am.c:2280
 msgid "(internal use for git-rebase)"
-msgstr ""
+msgstr "(intern f=C3=BCr git-rebase verwendet)"
=20
 #: builtin/am.c:2295
 msgid ""
 "The -b/--binary option has been a no-op for long time, and\n"
 "it will be removed. Please do not use it anymore."
 msgstr ""
 "Die -b/--binary Option hat seit Langem keinen Effekt und wird\n"
 "entfernt. Bitte nicht mehr verwenden."
=20
 #: builtin/am.c:2302
-#, fuzzy
 msgid "failed to read the index"
-msgstr "git %s: Fehler beim Lesen des Index"
+msgstr "Fehler beim Lesen des Index"
=20
 #: builtin/am.c:2317
-#, fuzzy, c-format
+#, c-format
 msgid "previous rebase directory %s still exists but mbox given."
 msgstr ""
-"Vorheriges Rebase-Verzeichnis $dotest existiert noch, aber mbox gegeb=
en."
+"Vorheriges Rebase-Verzeichnis %s existiert noch, aber mbox gegeben."
=20
 #: builtin/am.c:2341
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Stray %s directory found.\n"
 "Use \"git am --abort\" to remove it."
 msgstr ""
-"Stray $dotest Verzeichnis gefunden.\n"
+"Stray %s Verzeichnis gefunden.\n"
 "Benutzen Sie \"git am --abort\", um es zu entfernen."
=20
 #: builtin/am.c:2347
 msgid "Resolve operation not in progress, we are not resuming."
 msgstr "Es ist keine Aufl=C3=B6sung im Gange, es wird nicht fortgesetz=
t."
=20
@@ -3920,13 +3894,13 @@ msgstr "eine Textkonvertierung auf den Inhalt v=
on Blob-Objekten ausf=C3=BChren"
 #: builtin/cat-file.c:475
 msgid "allow -s and -t to work with broken/corrupt objects"
 msgstr "-s und -t mit besch=C3=A4digten Objekten erlauben"
=20
 #: builtin/cat-file.c:476
 msgid "buffer --batch output"
-msgstr ""
+msgstr "Ausgabe von --batch puffern"
=20
 #: builtin/cat-file.c:478
 msgid "show info and content of objects fed from the standard input"
 msgstr ""
 "Anzeige von Informationen und Inhalt von Objekten, gelesen von der St=
andard-"
 "Eingabe"
@@ -3940,17 +3914,14 @@ msgstr ""
 msgid "follow in-tree symlinks (used with --batch or --batch-check)"
 msgstr ""
 "symbolischen Verkn=C3=BCpfungen innerhalb des Repositories folgen (ve=
rwendet mit "
 "--batch oder --batch-check)"
=20
 #: builtin/cat-file.c:486
-#, fuzzy
 msgid "show all objects with --batch or --batch-check"
-msgstr ""
-"symbolischen Verkn=C3=BCpfungen innerhalb des Repositories folgen (ve=
rwendet mit "
-"--batch oder --batch-check)"
+msgstr "alle Objekte mit --batch oder --batch-check anzeigen"
=20
 #: builtin/check-attr.c:11
 msgid "git check-attr [-a | --all | <attr>...] [--] <pathname>..."
 msgstr "git check-attr [-a | --all | <Attribut>...] [--] <Pfadname>...=
"
=20
 #: builtin/check-attr.c:12
@@ -4141,15 +4112,15 @@ msgstr "Pfad '%s' ist nicht zusammengef=C3=BChr=
t."
=20
 #: builtin/checkout.c:495
 msgid "you need to resolve your current index first"
 msgstr "Sie m=C3=BCssen zuerst die Konflikte in Ihrem aktuellen Index =
aufl=C3=B6sen."
=20
 #: builtin/checkout.c:622
-#, fuzzy, c-format
+#, c-format
 msgid "Can not do reflog for '%s': %s\n"
-msgstr "Konnte \"reflog\" f=C3=BCr '%s' nicht durchf=C3=BChren\n"
+msgstr "Kann \"reflog\" f=C3=BCr '%s' nicht durchf=C3=BChren: %s\n"
=20
 #: builtin/checkout.c:660
 msgid "HEAD is now at"
 msgstr "HEAD ist jetzt bei"
=20
 #: builtin/checkout.c:667
@@ -5624,15 +5595,14 @@ msgstr "Sonstiges"
=20
 #: builtin/config.c:81
 msgid "terminate values with NUL byte"
 msgstr "schlie=C3=9Ft Werte mit NUL-Byte ab"
=20
 #: builtin/config.c:82
-#, fuzzy
 msgid "show variable names only"
-msgstr "Dateinamen anzeigen"
+msgstr "nur Variablennamen anzeigen"
=20
 #: builtin/config.c:83
 msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
=20
 #: builtin/config.c:311
@@ -6269,15 +6239,14 @@ msgstr "Reflogs in Erreichbarkeitspr=C3=BCfung =
einbeziehen (Standard)"
=20
 #: builtin/fsck.c:643
 msgid "also consider packs and alternate objects"
 msgstr "ebenso Pakete und alternative Objekte betrachten"
=20
 #: builtin/fsck.c:644
-#, fuzzy
 msgid "check only connectivity"
-msgstr "Pr=C3=BCfe Konnektivit=C3=A4t"
+msgstr "nur Konnektivit=C3=A4t pr=C3=BCfen"
=20
 #: builtin/fsck.c:645
 msgid "enable more strict checking"
 msgstr "genauere Pr=C3=BCfung aktivieren"
=20
 #: builtin/fsck.c:647
@@ -7879,21 +7848,21 @@ msgstr "Es gibt keinen Merge zum Abbrechen (MER=
GE_HEAD fehlt)"
 #: builtin/merge.c:1224
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie den Merge ausf=C3=
=BChren."
=20
 #: builtin/merge.c:1231
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie den Merge ausf=C3=
=BChren."
=20
 #: builtin/merge.c:1234
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
 msgstr ""
 "Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert)."
=20
@@ -8530,13 +8499,13 @@ msgstr "Konfliktaufl=C3=B6sung beim Merge von N=
otizen abbrechen"
 msgid "abort notes merge"
 msgstr "Merge von Notizen abbrechen"
=20
 #: builtin/notes.c:853
 #, c-format
 msgid "A notes merge into %s is already in-progress at %s"
-msgstr ""
+msgstr "Ein Merge von Notizen nach %s ist bereits im Gange bei %s"
=20
 #: builtin/notes.c:880
 #, c-format
 msgid "Object %s has no note\n"
 msgstr "Objekt %s hat keine Notiz\n"
=20
@@ -8559,24 +8528,24 @@ msgstr "Notizen von <Notiz-Referenz> verwenden"
 #: builtin/notes.c:1012 builtin/remote.c:1588
 #, c-format
 msgid "Unknown subcommand: %s"
 msgstr "Unbekanntes Unterkommando: %s"
=20
 #: builtin/pack-objects.c:28
-#, fuzzy
 msgid ""
 "git pack-objects --stdout [<options>...] [< <ref-list> | < <object-li=
st>]"
 msgstr ""
-"git pack-objects --stdout [Optionen...] [< Referenzliste | < Objektli=
ste]"
+"git pack-objects --stdout [<Optionen>...] [< <Referenzliste> | < "
+"<Objektliste>]"
=20
 #: builtin/pack-objects.c:29
-#, fuzzy
 msgid ""
 "git pack-objects [<options>...] <base-name> [< <ref-list> | < <object=
-list>]"
 msgstr ""
-"git pack-objects [Optionen...] Basis-Name [< Referenzliste | < Objekt=
liste]"
+"git pack-objects [<Optionen>...] <Basis-Name> [< <Referenzliste> | < =
"
+"<Objektliste>]"
=20
 #: builtin/pack-objects.c:175 builtin/pack-objects.c:178
 #, c-format
 msgid "deflate error (%d)"
 msgstr "Fehler beim Komprimieren (%d)"
=20
@@ -8787,164 +8756,176 @@ msgstr "gel=C3=B6schte Objekte melden"
=20
 #: builtin/prune.c:109 builtin/worktree.c:124
 msgid "expire objects older than <time>"
 msgstr "Objekte =C3=A4lter als <Zeit> verfallen lassen"
=20
 #: builtin/pull.c:69
-#, fuzzy
 msgid "git pull [options] [<repository> [<refspec>...]]"
-msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
+msgstr "git pull [<Optionen>] [<Repository> [<Refspec>...]]"
=20
 #: builtin/pull.c:113
-#, fuzzy
 msgid "Options related to merging"
-msgstr "Option f=C3=BCr ausgew=C3=A4hlte Merge-Strategie"
+msgstr "Optionen bezogen auf Merge"
=20
 #: builtin/pull.c:115
 msgid "false|true|preserve"
-msgstr ""
+msgstr "false|true|preserve"
=20
 #: builtin/pull.c:116
 msgid "incorporate changes by rebasing rather than merging"
-msgstr ""
+msgstr "Integration von =C3=84nderungen durch Rebase statt Merge"
=20
 #: builtin/pull.c:140 builtin/revert.c:105
 msgid "allow fast-forward"
 msgstr "Vorspulen erlauben"
=20
 #: builtin/pull.c:146
-#, fuzzy
 msgid "verify that the named commit has a valid GPG signature"
 msgstr "den genannten Commit auf eine g=C3=BCltige GPG-Signatur =C3=BC=
berpr=C3=BCfen"
=20
 #: builtin/pull.c:160
-#, fuzzy
 msgid "Options related to fetching"
-msgstr "entferne veraltete Branches im Remote-Repository nach \"fetch\=
""
+msgstr "Optionen bezogen auf Fetch"
=20
 #: builtin/pull.c:268
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid value for pull.ff: %s"
-msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s: %s"
+msgstr "Ung=C3=BCltiger Wert f=C3=BCr pull.ff: %s"
=20
 #: builtin/pull.c:352
 msgid "Cannot pull with rebase: You have unstaged changes."
-msgstr ""
+msgstr "Kann \"pull\" mit \"rebase\" nicht ausf=C3=BChren: Sie haben =C3=
=84nderungen, "
+"die nicht zum Commit vorgemerkt sind."
=20
 #: builtin/pull.c:358
 msgid "Additionally, your index contains uncommitted changes."
-msgstr ""
+msgstr "Zus=C3=A4tzlich beinhaltet die Staging-Area nicht committete =C3=
=84nderungen."
=20
 #: builtin/pull.c:360
 msgid "Cannot pull with rebase: Your index contains uncommitted change=
s."
-msgstr ""
+msgstr "Kann \"pull\" mit \"rebase\" nicht ausf=C3=BChren: Die Staging=
-Area "
+"beinhaltet nicht committete =C3=84nderungen."
=20
 #: builtin/pull.c:436
 msgid ""
 "There is no candidate for rebasing against among the refs that you ju=
st "
 "fetched."
 msgstr ""
+"Es gibt keinen Kandidaten f=C3=BCr Rebase innerhalb der Referenzen, d=
ie eben "
+"angefordert wurden."
=20
 #: builtin/pull.c:438
 msgid ""
 "There are no candidates for merging among the refs that you just fetc=
hed."
 msgstr ""
+"Es gibt keine Kandidaten f=C3=BCr Merge innerhalb der Referenzen, die=
 eben "
+"angefordert wurden."
=20
 #: builtin/pull.c:439
 msgid ""
 "Generally this means that you provided a wildcard refspec which had n=
o\n"
 "matches on the remote end."
 msgstr ""
+"Im Allgemeinen bedeutet das, dass Sie einen Refspec mit Wildcards ang=
egeben\n"
+"haben, der auf der Gegenseite mit keinen Referenzen =C3=BCbereinstimm=
t."
=20
 #: builtin/pull.c:442
 #, c-format
 msgid ""
 "You asked to pull from the remote '%s', but did not specify\n"
 "a branch. Because this is not the default configured remote\n"
 "for your current branch, you must specify a branch on the command lin=
e."
 msgstr ""
+"Sie f=C3=BChrten \"pull\" von Remote-Repository '%s' aus, ohne einen\=
n"
+"Branch anzugeben. Da das nicht das konfigurierte Standard-Remote-\n"
+"Repository f=C3=BCr den aktuellen Branch ist, m=C3=BCssen Sie einen B=
ranch auf\n"
+"der Kommandozeile angeben."
=20
 #: builtin/pull.c:447
-#, fuzzy
 msgid "You are not currently on a branch."
 msgstr "Im Moment auf keinem Branch."
=20
 #: builtin/pull.c:449 builtin/pull.c:464
 msgid "Please specify which branch you want to rebase against."
-msgstr ""
+msgstr "Bitte geben Sie den Branch an, gegen welchen Sie \"rebase\" au=
sf=C3=BChren "
+"m=C3=B6chten."
=20
 #: builtin/pull.c:451 builtin/pull.c:466
 msgid "Please specify which branch you want to merge with."
-msgstr ""
+msgstr "Bitte geben Sie den Branch an, welchen Sie zusammenf=C3=BChren=
 m=C3=B6chten."
=20
 #: builtin/pull.c:452 builtin/pull.c:467
 msgid "See git-pull(1) for details."
-msgstr ""
+msgstr "Siehe git-pull(1) f=C3=BCr weitere Details."
=20
 #: builtin/pull.c:462
-#, fuzzy
 msgid "There is no tracking information for the current branch."
-msgstr "Kein Remote-Repository f=C3=BCr den aktuellen Branch."
+msgstr "Es gibt keine Tracking-Informationen f=C3=BCr den aktuellen Br=
anch."
=20
 #: builtin/pull.c:471
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "If you wish to set tracking information for this branch you can do so=
 with:\n"
 "\n"
 "    git branch --set-upstream-to=3D%s/<branch> %s\n"
 msgstr ""
-"Wenn Sie diese durch einen neuen Branch behalten m=C3=B6chten, dann k=
=C3=B6nnte jetzt\n"
-"ein guter Zeitpunkt sein dies zu tun mit:\n"
-"\n"
-" git branch <neuer-Branchname> %s\n"
+"Wenn Sie Tracking-Informationen f=C3=BCr diesen Branch setzen m=C3=B6=
chten, k=C3=B6nnen Sie\n"
+"dies tun mit:\n"
 "\n"
+" git branch --set-upstream-to=3D%s/<Branch> %s\n"
=20
 #: builtin/pull.c:476
 #, c-format
 msgid ""
 "Your configuration specifies to merge with the ref '%s'\n"
 "from the remote, but no such ref was fetched."
 msgstr ""
+"Ihre Konfiguration gibt an, den Merge mit Referenz '%s'\n"
+"des Remote-Repositories durchzuf=C3=BChren, aber diese Referenz\n"
+"wurde nicht angefordert."
=20
 #: builtin/pull.c:830
-#, fuzzy
 msgid "Updating an unborn branch with changes added to the index."
 msgstr ""
 "Aktualisiere einen ungeborenen Branch mit =C3=84nderungen, die zum Co=
mmit "
-"vorgemerkt sind"
+"vorgemerkt sind."
=20
 #: builtin/pull.c:859
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "fetch updated the current branch head.\n"
 "fast-forwarding your working tree from\n"
 "commit %s."
 msgstr ""
-"Warnung: \"fetch\" aktualisierte die Spitze des aktuellen Branches.\n=
"
-"Warnung: Spule Ihr Arbeitsverzeichnis von Commit $orig_head vor."
+"\"fetch\" aktualisierte die Spitze des aktuellen Branches.\n"
+"Spule Ihr Arbeitsverzeichnis von Commit %s vor."
=20
 #: builtin/pull.c:864
 #, c-format
 msgid ""
 "Cannot fast-forward your working tree.\n"
 "After making sure that you saved anything precious from\n"
 "$ git diff %s\n"
 "output, run\n"
 "$ git reset --hard\n"
 "to recover."
 msgstr ""
+"Kann Arbeitsverzeichnis nicht vorspulen.\n"
+"Nachdem Sie sichergestellt haben, alles Sch=C3=BCtzenswerte der Ausga=
be von\n"
+"$ git diff %s\n"
+"gespeichert zu haben. F=C3=BChren Sie\n"
+"$ git reset --hard\n"
+"zur Wiederherstellung aus."
=20
 #: builtin/pull.c:879
-#, fuzzy
 msgid "Cannot merge multiple branches into empty head."
-msgstr "Kann nicht mehrere Branches in einen ungeborenen Branch zusamm=
enf=C3=BChren"
+msgstr "Kann nicht mehrere Branches in einen leeren Branch zusammenf=C3=
=BChren."
=20
 #: builtin/pull.c:883
-#, fuzzy
 msgid "Cannot rebase onto multiple branches."
-msgstr "kann Rebase nicht auf mehrere Branches ausf=C3=BChren"
+msgstr "Kann Rebase nicht auf mehrere Branches ausf=C3=BChren."
=20
 #: builtin/push.c:15
 msgid "git push [<options>] [<repository> [<refspec>...]]"
 msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
=20
 #: builtin/push.c:86
@@ -9289,19 +9270,18 @@ msgstr "Die Option --delete ist inkompatibel mi=
t --all, --mirror und --tags."
=20
 #: builtin/push.c:581
 msgid "--delete doesn't make sense without any refs"
 msgstr "Die Option --delete kann nur mit Referenzen verwendet werden."
=20
 #: builtin/read-tree.c:37
-#, fuzzy
 msgid ""
 "git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<prefix>) "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
 "index-output=3D<file>] (--empty | <tree-ish1> [<tree-ish2> [<tree-ish=
3>]])"
 msgstr ""
-"git read-tree [[-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Pr=C3=A4fix>] "
+"git read-tree [(-m [--trivial] [--aggressive] | --reset | --prefix=3D=
<Pr=C3=A4fix>) "
 "[-u [--exclude-per-directory=3D<gitignore>] | -i]] [--no-sparse-check=
out] [--"
 "index-output=3D<Datei>] (--empty | <Commit-Referenz1> [<Commit-Refere=
nz2> "
 "[<Commit-Referenz3>]])"
=20
 #: builtin/read-tree.c:110
 msgid "write resulting index to <file>"
@@ -9365,15 +9345,15 @@ msgstr "Anwendung des Filters f=C3=BCr sp=C3=A4=
rliches Auschecken =C3=BCberspringen"
=20
 #: builtin/read-tree.c:139
 msgid "debug unpack-trees"
 msgstr "Entpacken der B=C3=A4ume protokollieren"
=20
 #: builtin/reflog.c:432
-#, fuzzy, c-format
+#, c-format
 msgid "'%s' for '%s' is not a valid timestamp"
-msgstr "'%s' f=C3=BCr '%s' ist kein g=C3=BCltiger Zeitstempel"
+msgstr "'%s' ist kein g=C3=BCltiger Zeitstempel f=C3=BCr '%s'"
=20
 #: builtin/reflog.c:549 builtin/reflog.c:554
 #, c-format
 msgid "'%s' is not a valid timestamp"
 msgstr "'%s' ist kein g=C3=BCltiger Zeitstempel"
=20
@@ -10170,15 +10150,14 @@ msgstr "Konnte Index-Datei nicht zu Commit '%=
s' setzen."
=20
 #: builtin/reset.c:374
 msgid "Could not write new index file."
 msgstr "Konnte neue Index-Datei nicht schreiben."
=20
 #: builtin/rev-list.c:354
-#, fuzzy
 msgid "rev-list does not support display of notes"
-msgstr "die Gegenseite unterst=C3=BCtzt keinen atomaren Versand (\"--a=
tomic push\")"
+msgstr "rev-list unterst=C3=BCtzt keine Anzeige von Notizen"
=20
 #: builtin/rev-parse.c:361
 msgid "git rev-parse --parseopt [<options>] -- [<args>...]"
 msgstr "git rev-parse --parseopt [<Optionen>] -- [<Argumente>...]"
=20
 #: builtin/rev-parse.c:366
@@ -10406,30 +10385,33 @@ msgstr "git rm: konnte %s nicht l=C3=B6schen"
 msgid ""
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pac=
k=3D<git-"
 "receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> "
 "[<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive."
 msgstr ""
+"git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pac=
k=3D<git-"
+"receive-pack>] [--verbose] [--thin] [--atomic] [<Host>:]<Verzeichnis>=
 "
+"[<Referenz>...]\n"
+"  --all und die explizite Angabe einer <Referenz> schlie=C3=9Fen sich=
 gegenseitig "
+"aus."
=20
 #: builtin/send-pack.c:160
-#, fuzzy
 msgid "remote name"
-msgstr "umbenennen"
+msgstr "Name des Remote-Repositories"
=20
 #: builtin/send-pack.c:171
 msgid "use stateless RPC protocol"
-msgstr ""
+msgstr "zustandsloses RPC-Protokoll verwenden"
=20
 #: builtin/send-pack.c:172
-#, fuzzy
 msgid "read refs from stdin"
-msgstr "von der Standard-Eingabe lesen"
+msgstr "Referenzen von der Standard-Eingabe lesen"
=20
 #: builtin/send-pack.c:173
 msgid "print status from remote helper"
-msgstr ""
+msgstr "Status des Remote-Helpers ausgeben"
=20
 #: builtin/shortlog.c:13
 msgid "git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"
 msgstr "git shortlog [<Optionen>] [<Commitbereich>] [[--] [<Pfad>...]]=
"
=20
 #: builtin/shortlog.c:131
@@ -10774,15 +10756,14 @@ msgstr "einen anderen Schl=C3=BCssel verwende=
n, um das Tag zu signieren"
=20
 #: builtin/tag.c:608
 msgid "replace the tag if exists"
 msgstr "das Tag ersetzen, wenn es existiert"
=20
 #: builtin/tag.c:609 builtin/update-ref.c:368
-#, fuzzy
 msgid "create_reflog"
-msgstr "erstellt"
+msgstr "create_reflog"
=20
 #: builtin/tag.c:611
 msgid "Tag listing options"
 msgstr "Optionen f=C3=BCr Auflistung der Tags"
=20
 #: builtin/tag.c:612
@@ -11092,13 +11073,13 @@ msgstr "git verify-commit [-v | --verbose] <C=
ommit>..."
 #: builtin/verify-commit.c:72
 msgid "print commit contents"
 msgstr "Commit-Inhalte ausgeben"
=20
 #: builtin/verify-commit.c:73 builtin/verify-tag.c:84
 msgid "print raw gpg status output"
-msgstr ""
+msgstr "unbearbeitete Ausgabe des Status von gpg ausgeben"
=20
 #: builtin/verify-pack.c:54
 msgid "git verify-pack [-v | --verbose] [-s | --stat-only] <pack>..."
 msgstr "git verify-pack [-v | --verbose] [-s | --stat-only] <Paket>...=
"
=20
 #: builtin/verify-pack.c:64
@@ -11163,15 +11144,15 @@ msgstr "'%s' existiert bereits"
 #: builtin/worktree.c:232
 #, c-format
 msgid "could not create directory of '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
 #: builtin/worktree.c:268
-#, fuzzy, c-format
+#, c-format
 msgid "Preparing %s (identifier %s)"
-msgstr "Betrete %s (Identifikation %s)"
+msgstr "Bereite %s vor (Identifikation %s)"
=20
 #: builtin/worktree.c:316
 msgid "checkout <branch> even if already checked out in other worktree=
"
 msgstr ""
 "<Branch> auschecken, auch wenn dieser bereits in einem anderen "
 "Arbeitsverzeichnis ausgecheckt ist"
@@ -11186,15 +11167,14 @@ msgstr "Branch erstellen oder umsetzen"
=20
 #: builtin/worktree.c:321
 msgid "detach HEAD at named commit"
 msgstr "HEAD bei benanntem Commit losl=C3=B6sen"
=20
 #: builtin/worktree.c:328
-#, fuzzy
 msgid "-b, -B, and --detach are mutually exclusive"
-msgstr "Die Optionen -b, -B und --orphan schlie=C3=9Fen sich gegenseit=
ig aus."
+msgstr "-b, -B und --detach schlie=C3=9Fen sich gegenseitig aus"
=20
 #: builtin/write-tree.c:13
 msgid "git write-tree [--missing-ok] [--prefix=3D<prefix>/]"
 msgstr "git write-tree [--missing-ok] [--prefix=3D<Pr=C3=A4fix>/]"
=20
 #: builtin/write-tree.c:26
@@ -11246,16 +11226,15 @@ msgstr "mit anderen zusammenarbeiten (siehe a=
uch: git help workflows)"
=20
 #: common-cmds.h:17
 msgid "Add file contents to the index"
 msgstr "Dateiinhalte zum Commit vormerken"
=20
 #: common-cmds.h:18
-#, fuzzy
 msgid "Use binary search to find the commit that introduced a bug"
-msgstr ""
-"=C3=BCber eine Bin=C3=A4rsuche die =C3=84nderungen finden, die einen =
=46ehler verursacht haben"
+msgstr "Bin=C3=A4rsuche verwenden, um den Commit zu finden, der einen =
=46ehler "
+"verursacht hat"
=20
 #: common-cmds.h:19
 msgid "List, create, or delete branches"
 msgstr "Branches anzeigen, erstellen oder entfernen"
=20
 #: common-cmds.h:20
@@ -11422,49 +11401,50 @@ msgstr "Bitte rufen Sie 'bisect_state' mit mi=
ndestens einem Argument auf."
 #: git-bisect.sh:267
 #, sh-format
 msgid "Bad rev input: $rev"
 msgstr "Ung=C3=BCltige Referenz-Eingabe: $rev"
=20
 #: git-bisect.sh:276
-#, fuzzy, sh-format
+#, sh-format
 msgid "'git bisect $TERM_BAD' can take only one argument."
-msgstr "'git bisect bad' kann nur ein Argument entgegennehmen."
+msgstr "'git bisect $TERM_BAD' kann nur ein Argument entgegennehmen."
=20
 #: git-bisect.sh:299
-#, fuzzy, sh-format
+#, sh-format
 msgid "Warning: bisecting only with a $TERM_BAD commit."
-msgstr "Warnung: bin=C3=A4re Suche nur mit einem fehlerhaften Commit"
+msgstr "Warnung: bin=C3=A4re Suche nur mit einem $TERM_BAD Commit."
=20
 #. TRANSLATORS: Make sure to include [Y] and [n] in your
 #. translation. The program will only accept English input
 #. at this point.
 #: git-bisect.sh:305
 msgid "Are you sure [Y/n]? "
 msgstr "Sind Sie sicher [Y/n]? "
=20
 #: git-bisect.sh:317
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "You need to give me at least one $bad_syn and one $good_syn revision.=
\n"
 "(You can use \"git bisect $bad_syn\" and \"git bisect $good_syn\" for=
 that.)"
 msgstr ""
-"Sie m=C3=BCssen mindestens einen korrekten und einen fehlerhaften Com=
mit "
+"Sie m=C3=BCssen mindestens einen \"$bad_syn\" und einen \"$good_syn\"=
 Commit "
 "angeben.\n"
-"(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
+"(Sie k=C3=B6nnen daf=C3=BCr \"git bisect $bad_syn\" und \"git bisect =
$good_syn\" "
+"benutzen.)"
=20
 #: git-bisect.sh:320
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "You need to start by \"git bisect start\".\n"
 "You then need to give me at least one $good_syn and one $bad_syn revi=
sion.\n"
 "(You can use \"git bisect $bad_syn\" and \"git bisect $good_syn\" for=
 that.)"
 msgstr ""
 "Sie m=C3=BCssen mit \"git bisect start\" beginnen.\n"
-"Danach m=C3=BCssen Sie mindestens einen korrekten und einen fehlerhaf=
ten Commit "
+"Danach m=C3=BCssen Sie mindestens einen \"$good_syn\" und einen \"$ba=
d_syn\" Commit "
 "angeben.\n"
-"(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
+"(Sie k=C3=B6nnen daf=C3=BCr \"git bisect $bad_syn\" und \"git bisect =
$good_syn\" benutzen.)"
=20
 #: git-bisect.sh:391 git-bisect.sh:521
 msgid "We are not bisecting."
 msgstr "keine bin=C3=A4re Suche im Gange"
=20
 #: git-bisect.sh:398
@@ -11525,13 +11505,14 @@ msgstr ""
 msgid "bisect run success"
 msgstr "'bisect run' erfolgreich ausgef=C3=BChrt"
=20
 #: git-bisect.sh:548
 #, sh-format
 msgid "Invalid command: you're currently in a $TERM_BAD/$TERM_GOOD bis=
ect."
-msgstr ""
+msgstr "Ung=C3=BCltiges Kommando: Sie sind gerade bei einer bin=C3=A4r=
en "
+"$TERM_BAD/$TERM_GOOD Suche."
=20
 #: git-rebase.sh:57
 msgid ""
 "When you have resolved this problem, run \"git rebase --continue\".\n=
"
 "If you prefer to skip this patch, run \"git rebase --skip\" instead.\=
n"
 "To check out the original branch and stop rebasing, run \"git rebase =
--abort"
@@ -12080,13 +12061,13 @@ msgstr "Merge von '$sha1' in Submodul-Pfad '$=
displaypath' fehlgeschlagen"
 #: git-submodule.sh:902
 #, sh-format
 msgid "Submodule path '$displaypath': merged in '$sha1'"
 msgstr "Submodul-Pfad '$displaypath': zusammengef=C3=BChrt in '$sha1'"
=20
 #: git-submodule.sh:907
-#, fuzzy, sh-format
+#, sh-format
 msgid ""
 "Execution of '$command $sha1' failed in submodule path '$prefix$sm_pa=
th'"
 msgstr ""
 "Ausf=C3=BChrung von '$command $sha1' in Submodul-Pfad '$prefix$sm_pat=
h' "
 "fehlgeschlagen"
=20
--=20
2.6.0.rc1.199.g678474c
