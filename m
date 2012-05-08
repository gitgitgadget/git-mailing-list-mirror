From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=2010/10=5D=20l10n=3A=20de=2Epo=3A=20translate=20one=20new=20message?=
Date: Tue,  8 May 2012 19:33:45 +0200
Message-ID: <1336498425-17890-11-git-send-email-ralf.thielow@googlemail.com>
References: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Tue May 08 19:35:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRoJT-0002G2-Uw
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 19:35:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754386Ab2EHRen convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 May 2012 13:34:43 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:52319 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754305Ab2EHRel (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 13:34:41 -0400
Received: by mail-we0-f174.google.com with SMTP id b10so2143834wer.19
        for <git@vger.kernel.org>; Tue, 08 May 2012 10:34:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=Gw8JMAMJnCFwWM9z8EnqltAUVLeW96T7Wu8JNmvYHBk=;
        b=H9B1Qpk+0SQBdGHiZx8ugYswRDjyPBGUzod86aHyiMRFmZgmpULgK+syeMG2//jKoW
         /SRzJ1N5xSEdo+HoUy+Bkfi8ZuV8kWFF/FTQZ0GhjLD7iTV7sfe4cRYIZf3OQKNhMURD
         8/mhNjBxP+qv3UdNXT1ieHKoaQyx/6glkdJAFvzO7fGunJ2HKvJBLfmh4/sOnqEquDVG
         wxdDkJ8hhmcwnnLa0rYK3IjU1MxJJb5yb5yPeT+bQoK/Wo2mJQMKvaXk8AguZxrZ/ioq
         Y3RZRGk1puuzjTJwPIx9dOqB4z1ZMpKKCjtFLAInlNY6x2aDChi1N+ndDosVw2jO/eI8
         z0UQ==
Received: by 10.216.133.139 with SMTP id q11mr12605404wei.44.1336498480596;
        Tue, 08 May 2012 10:34:40 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id ff2sm47784452wib.9.2012.05.08.10.34.38
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 08 May 2012 10:34:39 -0700 (PDT)
X-Mailer: git-send-email 1.7.10.129.g1ec31a3
In-Reply-To: <1336498425-17890-1-git-send-email-ralf.thielow@googlemail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197406>

Translate one new messages came from git.pot
update in 7795e42 (l10n: Update git.pot (1 new messages)).
It also updates and reformats the de.po file due to "msgmerge".

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po |  278 +++++++++++++++++++++++++++++++++---------------------=
--------
 1 Datei ge=C3=A4ndert, 148 Zeilen hinzugef=C3=BCgt(+), 130 Zeilen entf=
ernt(-)

diff --git a/po/de.po b/po/de.po
index 9f12843..e7a6ebe 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git 1.7.10\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2012-04-28 20:33+0800\n"
+"POT-Creation-Date: 2012-05-08 15:45+0800\n"
 "PO-Revision-Date: 2012-03-28 18:46+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@googlemail.com>\n"
 "Language-Team: German\n"
@@ -189,14 +189,14 @@ msgstr[1] ""
 "Dein Zweig und '%s' sind divergiert,\n"
 "und haben jeweils %d und %d unterschiedliche Versionen.\n"
=20
-#: sequencer.c:120 builtin/merge.c:864 builtin/merge.c:985
-#: builtin/merge.c:1095 builtin/merge.c:1105
+#: sequencer.c:120 builtin/merge.c:865 builtin/merge.c:978
+#: builtin/merge.c:1088 builtin/merge.c:1098
 #, c-format
 msgid "Could not open '%s' for writing"
 msgstr "Konnte '%s' nicht zum Schreiben =C3=B6ffnen."
=20
-#: sequencer.c:122 builtin/merge.c:334 builtin/merge.c:867
-#: builtin/merge.c:1097 builtin/merge.c:1110
+#: sequencer.c:122 builtin/merge.c:333 builtin/merge.c:868
+#: builtin/merge.c:1090 builtin/merge.c:1103
 #, c-format
 msgid "Could not write to '%s'"
 msgstr "Konnte nicht nach '%s' schreiben."
@@ -260,7 +260,8 @@ msgstr "Du hast keine g=C3=BCltige Zweigspitze (HEA=
D)"
 #, c-format
 msgid "Commit %s is a merge but no -m option was given."
 msgstr ""
-"Version %s ist eine Zusammenf=C3=BChrung, aber die Option -m wurde ni=
cht angegeben."
+"Version %s ist eine Zusammenf=C3=BChrung, aber die Option -m wurde ni=
cht "
+"angegeben."
=20
 #: sequencer.c:324
 #, c-format
@@ -296,7 +297,7 @@ msgid "could not apply %s... %s"
 msgstr "Konnte %s nicht anwenden... %s"
=20
 #: sequencer.c:450 sequencer.c:909 builtin/log.c:288 builtin/log.c:713
-#: builtin/log.c:1329 builtin/log.c:1548 builtin/merge.c:348
+#: builtin/log.c:1329 builtin/log.c:1548 builtin/merge.c:347
 #: builtin/shortlog.c:181
 msgid "revision walk setup failed"
 msgstr "Einrichtung des Revisionsgangs fehlgeschlagen"
@@ -406,8 +407,9 @@ msgstr "Unerwartetes Dateiende"
 #: sequencer.c:742
 #, c-format
 msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
-msgstr "gespeicherte \"pre-cherry-pick\" Datei der Zweigspitze (HEAD) =
'%s' "
-"ist besch=C3=A4digt"
+msgstr ""
+"gespeicherte \"pre-cherry-pick\" Datei der Zweigspitze (HEAD) '%s' is=
t "
+"besch=C3=A4digt"
=20
 #: sequencer.c:765
 #, c-format
@@ -618,7 +620,8 @@ msgstr " (benutze \"git add\" und/oder \"git commit=
 -a\")"
 #: wt-status.c:765
 #, c-format
 msgid "nothing added to commit but untracked files present%s\n"
-msgstr "nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unbeobacht=
ete Dateien%s\n"
+msgstr ""
+"nichts zum Eintragen hinzugef=C3=BCgt, aber es gibt unbeobachtete Dat=
eien%s\n"
=20
 #: wt-status.c:767
 msgid " (use \"git add\" to track)"
@@ -839,7 +842,8 @@ msgstr "Konnte Versionsobjekt f=C3=BCr Zweigspitze =
(HEAD) nicht nachschlagen."
 #: builtin/branch.c:182
 #, c-format
 msgid "Cannot delete the branch '%s' which you are currently on."
-msgstr "Kann Zweig '%s' nicht entfernen, da du dich gerade auf diesem =
befindest."
+msgstr ""
+"Kann Zweig '%s' nicht entfernen, da du dich gerade auf diesem befinde=
st."
=20
 #: builtin/branch.c:192
 #, c-format
@@ -1014,7 +1018,7 @@ msgid "path '%s' is unmerged"
 msgstr "Pfad '%s' ist nicht zusammengef=C3=BChrt."
=20
 #: builtin/checkout.c:302 builtin/checkout.c:498 builtin/clone.c:583
-#: builtin/merge.c:811
+#: builtin/merge.c:812
 msgid "unable to write new index file"
 msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
=20
@@ -1307,8 +1311,8 @@ msgstr "Konnte zu klonenden externer Zweig %s nic=
ht finden."
 #: builtin/clone.c:549
 msgid "remote HEAD refers to nonexistent ref, unable to checkout.\n"
 msgstr ""
-"Externe Zweigspitze (HEAD) bezieht sich auf eine nicht existierende "
-"Referenz und kann nicht ausgecheckt werden.\n"
+"Externe Zweigspitze (HEAD) bezieht sich auf eine nicht existierende R=
eferenz "
+"und kann nicht ausgecheckt werden.\n"
=20
 #: builtin/clone.c:639
 msgid "Too many arguments."
@@ -1550,7 +1554,8 @@ msgid ""
 "with '#' will be ignored, and an empty message aborts the commit.\n"
 msgstr ""
 " Zeilen, die mit '#'\n"
-"beginnen, werden ignoriert, und eine leere Versionsbeschreibung brich=
t die Eintragung ab.\n"
+"beginnen, werden ignoriert, und eine leere Versionsbeschreibung brich=
t die "
+"Eintragung ab.\n"
=20
 #: builtin/commit.c:820
 msgid ""
@@ -1704,7 +1709,7 @@ msgstr "Eintragung abgebrochen; du hast die Besch=
reibung nicht editiert.\n"
 msgid "Aborting commit due to empty commit message.\n"
 msgstr "Eintragung aufgrund leerer Versionsbeschreibung abgebrochen.\n=
"
=20
-#: builtin/commit.c:1554 builtin/merge.c:935 builtin/merge.c:968
+#: builtin/commit.c:1554 builtin/merge.c:936 builtin/merge.c:961
 msgid "failed to write commit object"
 msgstr "Fehler beim Schreiben des Versionsobjektes."
=20
@@ -1849,68 +1854,72 @@ msgstr "unbehandeltes Objekt '%s' angegeben"
 msgid "Couldn't find remote ref HEAD"
 msgstr "Konnte externe Referenz der Zweigspitze (HEAD) nicht finden."
=20
-#: builtin/fetch.c:252
+#: builtin/fetch.c:253
 #, c-format
 msgid "object %s not found"
 msgstr "Objekt %s nicht gefunden"
=20
-#: builtin/fetch.c:258
+#: builtin/fetch.c:259
 msgid "[up to date]"
 msgstr "[aktuell]"
=20
-#: builtin/fetch.c:272
+#: builtin/fetch.c:273
 #, c-format
 msgid "! %-*s %-*s -> %s  (can't fetch in current branch)"
 msgstr "! %-*s %-*s -> %s  (kann nicht im aktuellen Zweig anfordern)"
=20
-#: builtin/fetch.c:273 builtin/fetch.c:351
+#: builtin/fetch.c:274 builtin/fetch.c:360
 msgid "[rejected]"
 msgstr "[zur=C3=BCckgewiesen]"
=20
-#: builtin/fetch.c:284
+#: builtin/fetch.c:285
 msgid "[tag update]"
 msgstr "[Markierungsaktualisierung]"
=20
-#: builtin/fetch.c:286 builtin/fetch.c:313 builtin/fetch.c:331
+#: builtin/fetch.c:287 builtin/fetch.c:322 builtin/fetch.c:340
 msgid "  (unable to update local ref)"
 msgstr "  (kann lokale Referenz nicht aktualisieren)"
=20
-#: builtin/fetch.c:298
+#: builtin/fetch.c:305
 msgid "[new tag]"
 msgstr "[neue Markierung]"
=20
-#: builtin/fetch.c:302
+#: builtin/fetch.c:308
 msgid "[new branch]"
 msgstr "[neuer Zweig]"
=20
-#: builtin/fetch.c:347
+#: builtin/fetch.c:311
+msgid "[new ref]"
+msgstr "[neue Referenz]"
+
+#: builtin/fetch.c:356
 msgid "unable to update local ref"
 msgstr "kann lokale Referenz nicht aktualisieren"
=20
-#: builtin/fetch.c:347
+#: builtin/fetch.c:356
 msgid "forced update"
 msgstr "Aktualisierung erzwungen"
=20
-#: builtin/fetch.c:353
+#: builtin/fetch.c:362
 msgid "(non-fast-forward)"
 msgstr "(kein Vorspulen)"
=20
-#: builtin/fetch.c:384 builtin/fetch.c:676
+#: builtin/fetch.c:393 builtin/fetch.c:685
 #, c-format
 msgid "cannot open %s: %s\n"
 msgstr "kann %s nicht =C3=B6ffnen: %s\n"
=20
-#: builtin/fetch.c:393
+#: builtin/fetch.c:402
 #, c-format
 msgid "%s did not send all necessary objects\n"
 msgstr "%s hat nicht alle erforderlichen Objekte gesendet\n"
=20
-#: builtin/fetch.c:479
+#: builtin/fetch.c:488
 #, c-format
 msgid "From %.*s\n"
 msgstr "Von %.*s\n"
=20
-#: builtin/fetch.c:490
+#: builtin/fetch.c:499
 #, c-format
 msgid ""
 "some local refs could not be updated; try running\n"
@@ -1919,57 +1928,57 @@ msgstr ""
 "Einige lokale Referenzen konnten nicht aktualisiert werden; versuche\=
n"
 "'git remote prune %s' um jeden =C3=A4lteren, widerspr=C3=BCchlichen Z=
weig zu entfernen."
=20
-#: builtin/fetch.c:540
+#: builtin/fetch.c:549
 #, c-format
 msgid "   (%s will become dangling)\n"
 msgstr "   (%s wird unreferenziert)\n"
=20
-#: builtin/fetch.c:541
+#: builtin/fetch.c:550
 #, c-format
 msgid "   (%s has become dangling)\n"
 msgstr "   (%s wurde unreferenziert)\n"
=20
-#: builtin/fetch.c:548
+#: builtin/fetch.c:557
 msgid "[deleted]"
 msgstr "[gel=C3=B6scht]"
=20
-#: builtin/fetch.c:549
+#: builtin/fetch.c:558
 msgid "(none)"
 msgstr "(nichts)"
=20
-#: builtin/fetch.c:666
+#: builtin/fetch.c:675
 #, c-format
 msgid "Refusing to fetch into current branch %s of non-bare repository=
"
 msgstr ""
-"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen\"=
"
-"Projektarchiv wurde verweigert."
+"Das Anfordern in den aktuellen Zweig %s von einem nicht-blo=C3=9Fen"
+"\"Projektarchiv wurde verweigert."
=20
-#: builtin/fetch.c:700
+#: builtin/fetch.c:709
 #, c-format
 msgid "Don't know how to fetch from %s"
 msgstr "Wei=C3=9F nicht wie von %s angefordert wird."
=20
-#: builtin/fetch.c:777
+#: builtin/fetch.c:786
 #, c-format
 msgid "Option \"%s\" value \"%s\" is not valid for %s"
 msgstr "Option \"%s\" Wert \"%s\" ist nicht g=C3=BCltig f=C3=BCr %s"
=20
-#: builtin/fetch.c:780
+#: builtin/fetch.c:789
 #, c-format
 msgid "Option \"%s\" is ignored for %s\n"
 msgstr "Option \"%s\" wird ignoriert f=C3=BCr %s\n"
=20
-#: builtin/fetch.c:879
+#: builtin/fetch.c:888
 #, c-format
 msgid "Fetching %s\n"
 msgstr "Fordere an von %s\n"
=20
-#: builtin/fetch.c:881
+#: builtin/fetch.c:890
 #, c-format
 msgid "Could not fetch %s"
 msgstr "Konnte nicht von %s anfordern"
=20
-#: builtin/fetch.c:898
+#: builtin/fetch.c:907
 msgid ""
 "No remote repository specified.  Please, specify either a URL or a\n"
 "remote name from which new revisions should be fetched."
@@ -1978,24 +1987,24 @@ msgstr ""
 "oder den Namen des externen Archivs an, von welchem neue\n"
 "Versionen angefordert werden sollen."
=20
-#: builtin/fetch.c:918
+#: builtin/fetch.c:927
 msgid "You need to specify a tag name."
 msgstr "Du musst den Namen der Markierung angeben."
=20
-#: builtin/fetch.c:970
+#: builtin/fetch.c:979
 msgid "fetch --all does not take a repository argument"
 msgstr "fetch --all akzeptiert kein Projektarchiv als Argument"
=20
-#: builtin/fetch.c:972
+#: builtin/fetch.c:981
 msgid "fetch --all does not make sense with refspecs"
 msgstr "fetch --all macht keinen Sinn mit Referenzspezifikationen"
=20
-#: builtin/fetch.c:983
+#: builtin/fetch.c:992
 #, c-format
 msgid "No such remote or remote group: %s"
 msgstr "Kein externes Archiv (einzeln oder Gruppe): %s"
=20
-#: builtin/fetch.c:991
+#: builtin/fetch.c:1000
 msgid "Fetching a group and specifying refspecs does not make sense"
 msgstr ""
 "Abholen einer Gruppe und Spezifizieren von Referenzspezifikationen ma=
cht "
@@ -2018,7 +2027,8 @@ msgstr "zu langes Objekt-Verzeichnis %.*s"
 #: builtin/gc.c:223
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
-msgstr "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale P=
erformance "
+msgstr ""
+"Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce "
 "komprimiert.\n"
=20
 #: builtin/gc.c:226
@@ -2028,14 +2038,15 @@ msgid ""
 "run \"git gc\" manually. See \"git help gc\" for more information.\n"
 msgstr ""
 "Die Datenbank des Projektarchivs wird f=C3=BCr eine optimale Performa=
nce\n"
-"komprimiert. Du kannst auch \"git gc\" manuell ausf=C3=BChren. "
-"Siehe \"git help gc\" f=C3=BCr weitere Informationen.\n"
+"komprimiert. Du kannst auch \"git gc\" manuell ausf=C3=BChren. Siehe =
\"git help gc"
+"\" f=C3=BCr weitere Informationen.\n"
=20
 #: builtin/gc.c:256
 msgid ""
 "There are too many unreachable loose objects; run 'git prune' to remo=
ve them."
-msgstr "Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git p=
rune' aus, "
-"um diese zu entfernen."
+msgstr ""
+"Es gibt zu viele unerreichbare lose Objekte; f=C3=BChre 'git prune' a=
us, um diese "
+"zu entfernen."
=20
 #: builtin/grep.c:216
 #, c-format
@@ -2342,71 +2353,72 @@ msgstr "Fehler beim Erstellen der Ausgabedateie=
n."
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
 msgstr ""
-"Konnte gefolgten, externen Zweig nicht finden, bitte gebe "
-"<upstream> manuell an.\n"
+"Konnte gefolgten, externen Zweig nicht finden, bitte gebe <upstream> =
manuell "
+"an.\n"
=20
 #: builtin/log.c:1530 builtin/log.c:1532 builtin/log.c:1544
 #, c-format
 msgid "Unknown commit %s"
 msgstr "Unbekannte Version %s"
=20
-#: builtin/merge.c:91
+#: builtin/merge.c:90
 msgid "switch `m' requires a value"
 msgstr "Schalter 'm' erfordert einen Wert."
=20
-#: builtin/merge.c:128
+#: builtin/merge.c:127
 #, c-format
 msgid "Could not find merge strategy '%s'.\n"
 msgstr "Konnte Zusammenf=C3=BChrungsstrategie '%s' nicht finden.\n"
=20
-#: builtin/merge.c:129
+#: builtin/merge.c:128
 #, c-format
 msgid "Available strategies are:"
 msgstr "Verf=C3=BCgbare Strategien sind:"
=20
-#: builtin/merge.c:134
+#: builtin/merge.c:133
 #, c-format
 msgid "Available custom strategies are:"
 msgstr "Verf=C3=BCgbare benutzerdefinierte Strategien sind:"
=20
-#: builtin/merge.c:241
+#: builtin/merge.c:240
 msgid "could not run stash."
 msgstr "Konnte \"stash\" nicht ausf=C3=BChren."
=20
-#: builtin/merge.c:246
+#: builtin/merge.c:245
 msgid "stash failed"
 msgstr "\"stash\" fehlgeschlagen"
=20
-#: builtin/merge.c:251
+#: builtin/merge.c:250
 #, c-format
 msgid "not a valid object: %s"
 msgstr "kein g=C3=BCltiges Objekt: %s"
=20
-#: builtin/merge.c:270 builtin/merge.c:287
+#: builtin/merge.c:269 builtin/merge.c:286
 msgid "read-tree failed"
 msgstr "read-tree fehlgeschlagen"
=20
-#: builtin/merge.c:317
+#: builtin/merge.c:316
 msgid " (nothing to squash)"
 msgstr " (nichts zu quetschen)"
=20
-#: builtin/merge.c:330
+#: builtin/merge.c:329
 #, c-format
 msgid "Squash commit -- not updating HEAD\n"
 msgstr "Quetsche Version -- Zweigspitze (HEAD) wird nicht aktualisiert=
\n"
=20
-#: builtin/merge.c:362
+#: builtin/merge.c:361
 msgid "Writing SQUASH_MSG"
 msgstr "Schreibe SQUASH_MSG"
=20
-#: builtin/merge.c:364
+#: builtin/merge.c:363
 msgid "Finishing SQUASH_MSG"
 msgstr "Schlie=C3=9Fe SQUASH_MSG ab"
=20
 #: builtin/merge.c:386
 #, c-format
 msgid "No merge message -- not updating HEAD\n"
-msgstr "Keine Zusammenf=C3=BChrungsbeschreibung -- Zweigspitze (HEAD) =
wird nicht "
+msgstr ""
+"Keine Zusammenf=C3=BChrungsbeschreibung -- Zweigspitze (HEAD) wird ni=
cht "
 "aktualisiert\n"
=20
 #: builtin/merge.c:437
@@ -2427,37 +2439,37 @@ msgstr "\"git write-tree\" schlug beim Schreibe=
n eines Baumes fehl"
 msgid "failed to read the cache"
 msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
=20
-#: builtin/merge.c:696
+#: builtin/merge.c:697
 msgid "Unable to write index."
 msgstr "Konnte Bereitstellung nicht schreiben."
=20
-#: builtin/merge.c:709
+#: builtin/merge.c:710
 msgid "Not handling anything other than two heads merge."
 msgstr "Es wird nur die Zusammenf=C3=BChrung von zwei Zweigen behandel=
t."
=20
-#: builtin/merge.c:723
+#: builtin/merge.c:724
 #, c-format
 msgid "Unknown option for merge-recursive: -X%s"
 msgstr "Unbekannte Option f=C3=BCr merge-recursive: -X%s"
=20
-#: builtin/merge.c:737
+#: builtin/merge.c:738
 #, c-format
 msgid "unable to write %s"
 msgstr "konnte %s nicht schreiben"
=20
-#: builtin/merge.c:876
+#: builtin/merge.c:877
 #, c-format
 msgid "Could not read from '%s'"
 msgstr "konnte nicht von '%s' lesen"
=20
-#: builtin/merge.c:885
+#: builtin/merge.c:886
 #, c-format
 msgid "Not committing merge; use 'git commit' to complete the merge.\n=
"
 msgstr ""
 "Zusammenf=C3=BChrung wurde nicht eingetragen; benutze 'git commit' um=
 die "
 "Zusammenf=C3=BChrung abzuschlie=C3=9Fen.\n"
=20
-#: builtin/merge.c:891
+#: builtin/merge.c:892
 msgid ""
 "Please enter a commit message to explain why this merge is necessary,=
\n"
 "especially if it merges an updated upstream into a topic branch.\n"
@@ -2467,56 +2479,62 @@ msgid ""
 msgstr ""
 "Bitte gebe eine Versionsbeschreibung ein um zu erkl=C3=A4ren, warum d=
iese "
 "Zusammenf=C3=BChrung erforderlich ist,\n"
-"insbesondere wenn es einen aktualisierten, externen Zweig mit einem "
-"Thema-Zweig zusammenf=C3=BChrt.\n"
+"insbesondere wenn es einen aktualisierten, externen Zweig mit einem T=
hema-"
+"Zweig zusammenf=C3=BChrt.\n"
 "\n"
 "Zeilen beginnend mit '#' werden ignoriert, und eine leere Beschreibun=
g "
 "bricht die Eintragung ab.\n"
=20
-#: builtin/merge.c:915
+#: builtin/merge.c:916
 msgid "Empty commit message."
 msgstr "Leere Versionsbeschreibung."
=20
-#: builtin/merge.c:927
+#: builtin/merge.c:928
 #, c-format
 msgid "Wonderful.\n"
 msgstr "Wunderbar.\n"
=20
-#: builtin/merge.c:1000
+#: builtin/merge.c:993
 #, c-format
 msgid "Automatic merge failed; fix conflicts and then commit the resul=
t.\n"
 msgstr ""
 "Automatische Zusammenf=C3=BChrung fehlgeschlagen; behebe die Konflikt=
e und trage "
 "dann das Ergebnis ein.\n"
=20
-#: builtin/merge.c:1016
+#: builtin/merge.c:1009
 #, c-format
 msgid "'%s' is not a commit"
 msgstr "'%s' ist keine Version"
=20
-#: builtin/merge.c:1057
+#: builtin/merge.c:1050
 msgid "No current branch."
 msgstr "Du befindest dich auf keinem Zweig."
=20
-#: builtin/merge.c:1059
+#: builtin/merge.c:1052
 msgid "No remote for the current branch."
 msgstr "Kein externes Archiv f=C3=BCr den aktuellen Zweig."
=20
-#: builtin/merge.c:1061
+#: builtin/merge.c:1054
 msgid "No default upstream defined for the current branch."
-msgstr "Es ist kein externes Standard-Projektarchiv f=C3=BCr den aktue=
llen Zweig "
+msgstr ""
+"Es ist kein externes Standard-Projektarchiv f=C3=BCr den aktuellen Zw=
eig "
 "definiert."
=20
-#: builtin/merge.c:1066
+#: builtin/merge.c:1059
 #, c-format
 msgid "No remote tracking branch for %s from %s"
 msgstr "Kein externer =C3=9Cbernahmezweig f=C3=BCr %s von %s"
=20
-#: builtin/merge.c:1188
+#: builtin/merge.c:1146 builtin/merge.c:1303
+#, c-format
+msgid "%s - not something we can merge"
+msgstr "%s - nichts was wir zusammenf=C3=BChren k=C3=B6nnen"
+
+#: builtin/merge.c:1214
 msgid "There is no merge to abort (MERGE_HEAD missing)."
 msgstr "Es gibt keine Zusammenf=C3=BChrung zum Abbrechen (vermisse MER=
GE_HEAD)"
=20
-#: builtin/merge.c:1204 git-pull.sh:31
+#: builtin/merge.c:1230 git-pull.sh:31
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you can merge."
@@ -2524,12 +2542,12 @@ msgstr ""
 "Du hast deine Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD ex=
istiert).\n"
 "Bitte trage deine =C3=84nderungen ein, bevor du zusammenf=C3=BChren k=
annst."
=20
-#: builtin/merge.c:1207 git-pull.sh:34
+#: builtin/merge.c:1233 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr ""
 "Du hast deine Zusammenf=C3=BChrung nicht abgeschlossen (MERGE_HEAD ex=
istiert)."
=20
-#: builtin/merge.c:1211
+#: builtin/merge.c:1237
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you can merge."
@@ -2537,85 +2555,80 @@ msgstr ""
 "Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt).\n"
 "Bitte trage deine =C3=84nderungen ein, bevor du zusammenf=C3=BChren k=
annst."
=20
-#: builtin/merge.c:1214
+#: builtin/merge.c:1240
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
 msgstr ""
 "Du hast \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD existie=
rt)."
=20
-#: builtin/merge.c:1223
+#: builtin/merge.c:1249
 msgid "You cannot combine --squash with --no-ff."
 msgstr "Du kannst --squash nicht mit --no-ff kombinieren."
=20
-#: builtin/merge.c:1228
+#: builtin/merge.c:1254
 msgid "You cannot combine --no-ff with --ff-only."
 msgstr "Du kannst --no-ff nicht mit --ff--only kombinieren."
=20
-#: builtin/merge.c:1235
+#: builtin/merge.c:1261
 msgid "No commit specified and merge.defaultToUpstream not set."
 msgstr "Keine Version angegeben und merge.defaultToUpstream ist nicht =
gesetzt."
=20
-#: builtin/merge.c:1266
+#: builtin/merge.c:1293
 msgid "Can merge only exactly one commit into empty head"
 msgstr "Kann nur exakt eine Version in einem leeren Zweig zusammenf=C3=
=BChren."
=20
-#: builtin/merge.c:1269
+#: builtin/merge.c:1296
 msgid "Squash commit into empty head not supported yet"
 msgstr "Bin auf einem Zweig, der noch geboren wird; kann nicht quetsch=
en."
=20
-#: builtin/merge.c:1271
+#: builtin/merge.c:1298
 msgid "Non-fast-forward commit does not make sense into an empty head"
 msgstr "Bin auf einem Zweig, der noch geboren wird; --no-ff macht kein=
en Sinn."
=20
-#: builtin/merge.c:1275 builtin/merge.c:1319
-#, c-format
-msgid "%s - not something we can merge"
-msgstr "%s - nichts was wir zusammenf=C3=BChren k=C3=B6nnen"
-
-#: builtin/merge.c:1382
+#: builtin/merge.c:1413
 #, c-format
 msgid "Updating %s..%s\n"
 msgstr "Aktualisiere %s..%s\n"
=20
-#: builtin/merge.c:1420
+#: builtin/merge.c:1451
 #, c-format
 msgid "Trying really trivial in-index merge...\n"
 msgstr "Probiere wirklich triviale \"in-index\"-Zusammenf=C3=BChrung..=
=2E\n"
=20
-#: builtin/merge.c:1427
+#: builtin/merge.c:1458
 #, c-format
 msgid "Nope.\n"
 msgstr "Nein.\n"
=20
-#: builtin/merge.c:1459
+#: builtin/merge.c:1490
 msgid "Not possible to fast-forward, aborting."
 msgstr "Vorspulen nicht m=C3=B6glich, breche ab."
=20
-#: builtin/merge.c:1482 builtin/merge.c:1559
+#: builtin/merge.c:1513 builtin/merge.c:1592
 #, c-format
 msgid "Rewinding the tree to pristine...\n"
 msgstr "R=C3=BCcklauf des Zweiges bis zum Ursprung...\n"
=20
-#: builtin/merge.c:1486
+#: builtin/merge.c:1517
 #, c-format
 msgid "Trying merge strategy %s...\n"
 msgstr "Probiere Zusammenf=C3=BChrungsstrategie %s...\n"
=20
-#: builtin/merge.c:1550
+#: builtin/merge.c:1583
 #, c-format
 msgid "No merge strategy handled the merge.\n"
 msgstr "Keine Zusammenf=C3=BChrungsstrategie behandelt diese Zusammenf=
=C3=BChrung.\n"
=20
-#: builtin/merge.c:1552
+#: builtin/merge.c:1585
 #, c-format
 msgid "Merge with strategy %s failed.\n"
 msgstr "Zusammenf=C3=BChrung mit Strategie %s fehlgeschlagen.\n"
=20
-#: builtin/merge.c:1561
+#: builtin/merge.c:1594
 #, c-format
 msgid "Using the %s to prepare resolving by hand.\n"
 msgstr "Benutze \"%s\" um die Aufl=C3=B6sung per Hand vorzubereiten.\n=
"
=20
-#: builtin/merge.c:1572
+#: builtin/merge.c:1606
 #, c-format
 msgid "Automatic merge went well; stopped before committing as request=
ed\n"
 msgstr ""
@@ -2696,8 +2709,7 @@ msgstr "konnte Datei-Deskriptor f=C3=BCr Ausgabe =
von 'show' nicht =C3=B6ffnen"
 #: builtin/notes.c:155
 #, c-format
 msgid "failed to close pipe to 'show' for object '%s'"
-msgstr "Schlie=C3=9Fen der Verbindung zu 'show' ist f=C3=BCr Objekt '%=
s' "
-"fehlgeschlagen."
+msgstr "Schlie=C3=9Fen der Verbindung zu 'show' ist f=C3=BCr Objekt '%=
s' fehlgeschlagen."
=20
 #: builtin/notes.c:158
 #, c-format
@@ -2904,8 +2916,7 @@ msgstr ""
 #: builtin/push.c:98
 #, c-format
 msgid "The current branch %s has multiple upstream branches, refusing =
to push."
-msgstr ""
-"Der aktuelle Zweig %s hat mehrere externe Zweige, Versand verweigert.=
"
+msgstr "Der aktuelle Zweig %s hat mehrere externe Zweige, Versand verw=
eigert."
=20
 #: builtin/push.c:101
 #, c-format
@@ -2922,8 +2933,8 @@ msgstr ""
 msgid ""
 "You didn't specify any refspecs to push, and push.default is \"nothin=
g\"."
 msgstr ""
-"Du hast keine Referenzspezifikationen zum Versenden angegeben, und "
-"push.default ist \"nothing\"."
+"Du hast keine Referenzspezifikationen zum Versenden angegeben, und pu=
sh."
+"default ist \"nothing\"."
=20
 #: builtin/push.c:147
 #, c-format
@@ -3052,8 +3063,9 @@ msgstr "Nicht bereitgestellte =C3=84nderungen nac=
h Zur=C3=BCcksetzung:"
 #: builtin/reset.c:223
 #, c-format
 msgid "Cannot do a %s reset in the middle of a merge."
-msgstr "Kann keine '%s' Zur=C3=BCcksetzung durchf=C3=BChren, w=C3=A4hr=
end eine "
-"Zusammenf=C3=BChrung im Gange ist."
+msgstr ""
+"Kann keine '%s' Zur=C3=BCcksetzung durchf=C3=BChren, w=C3=A4hrend ein=
e Zusammenf=C3=BChrung im "
+"Gange ist."
=20
 #: builtin/reset.c:297
 #, c-format
@@ -3093,11 +3105,11 @@ msgstr "%s: %s kann nicht mit %s benutzt werden=
"
 msgid "program error"
 msgstr "Programmfehler"
=20
-#: builtin/revert.c:209
+#: builtin/revert.c:212
 msgid "revert failed"
 msgstr "\"revert\" fehlgeschlagen"
=20
-#: builtin/revert.c:224
+#: builtin/revert.c:227
 msgid "cherry-pick failed"
 msgstr "\"cherry-pick\" fehlgeschlagen"
=20
@@ -3341,7 +3353,9 @@ msgstr ""
=20
 #: git-am.sh:748
 msgid "cannot be interactive without stdin connected to a terminal."
-msgstr "Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit=
 einem Terminal verbunden ist."
+msgstr ""
+"Kann nicht interaktiv sein, ohne dass die Standard-Eingabe mit einem =
"
+"Terminal verbunden ist."
=20
 #. TRANSLATORS: Make sure to include [y], [n], [e], [v] and [a]
 #. in your translation. The program will only accept English
@@ -3564,8 +3578,8 @@ msgstr "Konnte die Bereitstellung nicht aktualisi=
eren"
=20
 #: git-stash.sh:416
 msgid "Cannot apply a stash in the middle of a merge"
-msgstr "Kann \"stash\" nicht anwenden, solang eine Zusammenf=C3=BChrun=
g "
-"im Gange ist"
+msgstr ""
+"Kann \"stash\" nicht anwenden, solang eine Zusammenf=C3=BChrung im Ga=
nge ist"
=20
 #: git-stash.sh:424
 msgid "Conflicts in index. Try without --index."
@@ -3615,7 +3629,8 @@ msgstr "Klonen von '$url' in Unterprojekt-Pfad '$=
path' fehlgeschlagen"
 #: git-submodule.sh:159
 #, sh-format
 msgid "Gitdir '$a' is part of the submodule path '$b' or vice versa"
-msgstr "Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b', od=
er umgekehrt"
+msgstr ""
+"Git-Verzeichnis '$a' ist Teil des Unterprojekt-Pfades '$b', oder umge=
kehrt"
=20
 #: git-submodule.sh:247
 #, sh-format
@@ -3670,7 +3685,8 @@ msgstr "Registrierung der URL f=C3=BCr Unterproje=
kt-Pfad '$path' fehlgeschlagen"
 #: git-submodule.sh:418
 #, sh-format
 msgid "Failed to register update mode for submodule path '$path'"
-msgstr "Registrierung des Aktualisierungsmodus f=C3=BCr Unterprojekt-P=
fad '$path' "
+msgstr ""
+"Registrierung des Aktualisierungsmodus f=C3=BCr Unterprojekt-Pfad '$p=
ath' "
 "fehlgeschlagen"
=20
 #: git-submodule.sh:420
@@ -3710,7 +3726,8 @@ msgstr "Unterprojekt-Pfad '$path': neu aufgebaut =
in '$sha1'"
 #: git-submodule.sh:571
 #, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$path'"
-msgstr "Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$path' =
fehlgeschlagen"
+msgstr ""
+"Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$path' fehlges=
chlagen"
=20
 #: git-submodule.sh:572
 #, sh-format
@@ -3749,7 +3766,8 @@ msgstr "  Warnung: $name beinhaltet nicht Version=
 $sha1_dst"
 #: git-submodule.sh:772
 #, sh-format
 msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
-msgstr "  Warnung: $name beinhaltet nicht die Versionen $sha1_src und =
$sha1_dst"
+msgstr ""
+"  Warnung: $name beinhaltet nicht die Versionen $sha1_src und $sha1_d=
st"
=20
 #: git-submodule.sh:797
 msgid "blob"
--=20
1.7.10.129.g1ec31a3
