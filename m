From: Ralf Thielow <ralf.thielow@googlemail.com>
Subject: =?UTF-8?q?=5BPATCH=5D=20l10n=3A=20de=2Epo=3A=20translate=202=20new=2C=203=20fuzzy=20messages?=
Date: Sat,  2 Jun 2012 19:53:02 +0200
Message-ID: <1338659582-6864-1-git-send-email-ralf.thielow@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: worldhello.net@gmail.com, git@vger.kernel.org,
	Ralf Thielow <ralf.thielow@googlemail.com>
To: trast@student.ethz.ch, jk@jk.gs, stimming@tuhh.de
X-From: git-owner@vger.kernel.org Sat Jun 02 19:53:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SasWM-0005Nt-Gt
	for gcvg-git-2@plane.gmane.org; Sat, 02 Jun 2012 19:53:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933360Ab2FBRxN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 2 Jun 2012 13:53:13 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:64483 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933344Ab2FBRxL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2012 13:53:11 -0400
Received: by weyu7 with SMTP id u7so2023655wey.19
        for <git@vger.kernel.org>; Sat, 02 Jun 2012 10:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=rsib1vM7MrzyK7DbF8uyeNSR6AIpN5qzpFyesVeHomg=;
        b=QcCtdEUaL+doeb6D/upa883Ie2Db7/Kvv5Auxn+4GwhFH7NR1Yo2ca6TmTdcauyik2
         xFyUAjUAjUa+RAQGBV6wuBDYwaaNP8ZeyOV4gVfUYq13PSJVKBpi+sSHiB8YE4/1L4X1
         xsnGSbxSYdSsgwXd6fRq1+73pxpSfNMLj7yTgloGjcJ7rZMDrpTSUv6ArD6zZaBlzxaA
         y0c9SpDSQ9ZdevzgfB38oGhr0PSC6ckhKDRKS2kf9Cn6DI0zRhdeWL2EXtM+h2Llk5Gu
         xUYOr2igahZ0tZ+k0KtPevWBP2CKWoVYobeb3BXIlkVpHxN4d5wDK5IIOsUXzEtavDZT
         AAsw==
Received: by 10.216.203.201 with SMTP id f51mr5661831weo.52.1338659589537;
        Sat, 02 Jun 2012 10:53:09 -0700 (PDT)
Received: from localhost.localdomain (dslb-094-223-205-117.pools.arcor-ip.net. [94.223.205.117])
        by mx.google.com with ESMTPS id z8sm10150165wiy.1.2012.06.02.10.53.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Jun 2012 10:53:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.rc0.105.g16abda8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199053>

Translate 2 new and 3 fuzzy messages came from git.pot update
in 75f7b4b (l10n: Update git.pot (5 new, 3 removed messages)).

Signed-off-by: Ralf Thielow <ralf.thielow@googlemail.com>
---
 po/de.po | 474 +++++++++++++++++++++++++++++++++----------------------=
--------
 1 Datei ge=C3=A4ndert, 247 Zeilen hinzugef=C3=BCgt(+), 227 Zeilen entf=
ernt(-)

diff --git a/po/de.po b/po/de.po
index 7b3cce8..a7774e0 100644
--- a/po/de.po
+++ b/po/de.po
@@ -7,7 +7,7 @@ msgid ""
 msgstr ""
 "Project-Id-Version: git 1.7.11\n"
 "Report-Msgid-Bugs-To: Git Mailing List <git@vger.kernel.org>\n"
-"POT-Creation-Date: 2012-05-21 08:57+0800\n"
+"POT-Creation-Date: 2012-06-02 07:03+0800\n"
 "PO-Revision-Date: 2012-03-28 18:46+0200\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@googlemail.com>\n"
 "Language-Team: German\n"
@@ -48,7 +48,7 @@ msgstr "'%s' sieht nicht wie eine v2 Paketdatei aus"
 msgid "unrecognized header: %s%s (%d)"
 msgstr "nicht erkannter Kopfbereich: %s%s (%d)"
=20
-#: bundle.c:89 builtin/commit.c:697
+#: bundle.c:89 builtin/commit.c:696
 #, c-format
 msgid "could not open '%s'"
 msgstr "Konnte '%s' nicht =C3=B6ffnen"
@@ -57,8 +57,8 @@ msgstr "Konnte '%s' nicht =C3=B6ffnen"
 msgid "Repository lacks these prerequisite commits:"
 msgstr "Dem Projektarchiv fehlen folgende vorrausgesetzte Versionen:"
=20
-#: bundle.c:164 sequencer.c:533 sequencer.c:965 builtin/log.c:289
-#: builtin/log.c:719 builtin/log.c:1335 builtin/log.c:1554 builtin/mer=
ge.c:347
+#: bundle.c:164 sequencer.c:550 sequencer.c:982 builtin/log.c:289
+#: builtin/log.c:720 builtin/log.c:1309 builtin/log.c:1528 builtin/mer=
ge.c:347
 #: builtin/shortlog.c:181
 msgid "revision walk setup failed"
 msgstr "Einrichtung des Revisionsgangs fehlgeschlagen"
@@ -81,7 +81,7 @@ msgstr[1] "Das Paket ben=C3=B6tigt diese %d Referenze=
n"
 msgid "rev-list died"
 msgstr "\"rev-list\" abgebrochen"
=20
-#: bundle.c:296 builtin/log.c:1231 builtin/shortlog.c:284
+#: bundle.c:296 builtin/log.c:1205 builtin/shortlog.c:284
 #, c-format
 msgid "unrecognized argument: %s"
 msgstr "nicht erkanntes Argument: %s"
@@ -273,17 +273,17 @@ msgstr "gpg hat die Daten nicht akzeptiert"
 msgid "gpg failed to sign the data"
 msgstr "gpg beim Signieren der Daten fehlgeschlagen"
=20
-#: grep.c:1280
+#: grep.c:1320
 #, c-format
 msgid "'%s': unable to read %s"
 msgstr "'%s': konnte nicht lesen %s"
=20
-#: grep.c:1297
+#: grep.c:1337
 #, c-format
 msgid "'%s': %s"
 msgstr "'%s': %s"
=20
-#: grep.c:1308
+#: grep.c:1348
 #, c-format
 msgid "'%s': short read %s"
 msgstr "'%s': read() zu kurz %s"
@@ -364,14 +364,14 @@ msgstr "      oder: %s"
 msgid "    %s"
 msgstr "    %s"
=20
-#: remote.c:1607
+#: remote.c:1629
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
 msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
 msgstr[0] "Dein Zweig ist vor '%s' um %d Version.\n"
 msgstr[1] "Dein Zweig ist vor '%s' um %d Versionen.\n"
=20
-#: remote.c:1613
+#: remote.c:1635
 #, c-format
 msgid "Your branch is behind '%s' by %d commit, and can be fast-forwar=
ded.\n"
 msgid_plural ""
@@ -382,7 +382,7 @@ msgstr[1] ""
 "Dein Zweig ist zu '%s' um %d Versionen hinterher, und kann vorgespult=
 "
 "werden.\n"
=20
-#: remote.c:1621
+#: remote.c:1643
 #, c-format
 msgid ""
 "Your branch and '%s' have diverged,\n"
@@ -427,7 +427,7 @@ msgstr ""
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'und trage das Ergebnis ein=
 mit "
 "'git commit'"
=20
-#: sequencer.c:160 sequencer.c:741 sequencer.c:824
+#: sequencer.c:160 sequencer.c:758 sequencer.c:841
 #, c-format
 msgid "Could not write to %s"
 msgstr "Konnte nicht nach %s schreiben"
@@ -464,37 +464,37 @@ msgstr "Konnte Version der Zweigspitze (HEAD) nic=
ht aufl=C3=B6sen\n"
 msgid "Unable to update cache tree\n"
 msgstr "Konnte zwischengespeicherten Baum nicht aktualisieren\n"
=20
-#: sequencer.c:323
+#: sequencer.c:324
 #, c-format
 msgid "Could not parse commit %s\n"
 msgstr "Konnte Version %s nicht parsen\n"
=20
-#: sequencer.c:328
+#: sequencer.c:329
 #, c-format
 msgid "Could not parse parent commit %s\n"
 msgstr "Konnte Elternversion %s nicht parsen\n"
=20
-#: sequencer.c:358
+#: sequencer.c:395
 msgid "Your index file is unmerged."
 msgstr "Deine Bereitstellungsdatei ist nicht zusammengef=C3=BChrt."
=20
-#: sequencer.c:361
+#: sequencer.c:398
 msgid "You do not have a valid HEAD"
 msgstr "Du hast keine g=C3=BCltige Zweigspitze (HEAD)"
=20
-#: sequencer.c:376
+#: sequencer.c:413
 #, c-format
 msgid "Commit %s is a merge but no -m option was given."
 msgstr ""
 "Version %s ist eine Zusammenf=C3=BChrung, aber die Option -m wurde ni=
cht "
 "angegeben."
=20
-#: sequencer.c:384
+#: sequencer.c:421
 #, c-format
 msgid "Commit %s does not have parent %d"
 msgstr "Version %s hat keinen Elternteil %d"
=20
-#: sequencer.c:388
+#: sequencer.c:425
 #, c-format
 msgid "Mainline was specified but commit %s is not a merge."
 msgstr ""
@@ -502,145 +502,145 @@ msgstr ""
=20
 #. TRANSLATORS: The first %s will be "revert" or
 #. "cherry-pick", the second %s a SHA1
-#: sequencer.c:399
+#: sequencer.c:436
 #, c-format
 msgid "%s: cannot parse parent commit %s"
 msgstr "%s: kann Elternversion %s nicht parsen"
=20
-#: sequencer.c:403
+#: sequencer.c:440
 #, c-format
 msgid "Cannot get commit message for %s"
 msgstr "Kann keine Versionsbeschreibung f=C3=BCr %s bekommen"
=20
-#: sequencer.c:491
+#: sequencer.c:524
 #, c-format
 msgid "could not revert %s... %s"
 msgstr "Konnte %s nicht zur=C3=BCcksetzen... %s"
=20
-#: sequencer.c:492
+#: sequencer.c:525
 #, c-format
 msgid "could not apply %s... %s"
 msgstr "Konnte %s nicht anwenden... %s"
=20
-#: sequencer.c:536
+#: sequencer.c:553
 msgid "empty commit set passed"
 msgstr "leere Menge von Versionen =C3=BCbergeben"
=20
-#: sequencer.c:544
+#: sequencer.c:561
 #, c-format
 msgid "git %s: failed to read the index"
 msgstr "git %s: Fehler beim Lesen der Bereitstellung"
=20
-#: sequencer.c:549
+#: sequencer.c:566
 #, c-format
 msgid "git %s: failed to refresh the index"
 msgstr "git %s: Fehler beim Aktualisieren der Bereitstellung"
=20
-#: sequencer.c:607
+#: sequencer.c:624
 #, c-format
 msgid "Cannot %s during a %s"
 msgstr "Kann %s nicht w=C3=A4hrend eines %s durchf=C3=BChren"
=20
-#: sequencer.c:629
+#: sequencer.c:646
 #, c-format
 msgid "Could not parse line %d."
 msgstr "Konnte Zeile %d nicht parsen."
=20
-#: sequencer.c:634
+#: sequencer.c:651
 msgid "No commits parsed."
 msgstr "Keine Versionen geparst."
=20
-#: sequencer.c:647
+#: sequencer.c:664
 #, c-format
 msgid "Could not open %s"
 msgstr "Konnte %s nicht =C3=B6ffnen"
=20
-#: sequencer.c:651
+#: sequencer.c:668
 #, c-format
 msgid "Could not read %s."
 msgstr "Konnte %s nicht lesen."
=20
-#: sequencer.c:658
+#: sequencer.c:675
 #, c-format
 msgid "Unusable instruction sheet: %s"
 msgstr "Unbenutzbares Instruktionsblatt: %s"
=20
-#: sequencer.c:686
+#: sequencer.c:703
 #, c-format
 msgid "Invalid key: %s"
 msgstr "Ung=C3=BCltiger Schl=C3=BCssel: %s"
=20
-#: sequencer.c:689
+#: sequencer.c:706
 #, c-format
 msgid "Invalid value for %s: %s"
 msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s: %s"
=20
-#: sequencer.c:701
+#: sequencer.c:718
 #, c-format
 msgid "Malformed options sheet: %s"
 msgstr "Fehlerhaftes Optionsblatt: %s"
=20
-#: sequencer.c:722
+#: sequencer.c:739
 msgid "a cherry-pick or revert is already in progress"
 msgstr "\"cherry-pick\" oder \"revert\" ist bereits im Gang"
=20
-#: sequencer.c:723
+#: sequencer.c:740
 msgid "try \"git cherry-pick (--continue | --quit | --abort)\""
 msgstr "versuche \"git cherry-pick (--continue | --quit | --abort)\""
=20
-#: sequencer.c:727
+#: sequencer.c:744
 #, c-format
 msgid "Could not create sequencer directory %s"
 msgstr "Konnte \"sequencer\"-Verzeichnis %s nicht erstellen"
=20
-#: sequencer.c:743 sequencer.c:828
+#: sequencer.c:760 sequencer.c:845
 #, c-format
 msgid "Error wrapping up %s."
 msgstr "Fehler beim Einpacken von %s."
=20
-#: sequencer.c:762 sequencer.c:896
+#: sequencer.c:779 sequencer.c:913
 msgid "no cherry-pick or revert in progress"
 msgstr "kein \"cherry-pick\" oder \"revert\" im Gang"
=20
-#: sequencer.c:764
+#: sequencer.c:781
 msgid "cannot resolve HEAD"
 msgstr "kann Zweigspitze (HEAD) nicht aufl=C3=B6sen"
=20
-#: sequencer.c:766
+#: sequencer.c:783
 msgid "cannot abort from a branch yet to be born"
 msgstr "kann nicht abbrechen: bin auf einem Zweig, der noch geboren wi=
rd"
=20
-#: sequencer.c:788 builtin/apply.c:3689
+#: sequencer.c:805 builtin/apply.c:3697
 #, c-format
 msgid "cannot open %s: %s"
 msgstr "Kann %s nicht =C3=B6ffnen: %s"
=20
-#: sequencer.c:791
+#: sequencer.c:808
 #, c-format
 msgid "cannot read %s: %s"
 msgstr "Kann %s nicht lesen: %s"
=20
-#: sequencer.c:792
+#: sequencer.c:809
 msgid "unexpected end of file"
 msgstr "Unerwartetes Dateiende"
=20
-#: sequencer.c:798
+#: sequencer.c:815
 #, c-format
 msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
 msgstr ""
 "gespeicherte \"pre-cherry-pick\" Datei der Zweigspitze (HEAD) '%s' is=
t "
 "besch=C3=A4digt"
=20
-#: sequencer.c:821
+#: sequencer.c:838
 #, c-format
 msgid "Could not format %s."
 msgstr "Konnte %s nicht formatieren."
=20
-#: sequencer.c:983
+#: sequencer.c:1000
 msgid "Can't revert as initial commit"
 msgstr "Kann nicht zu initialer Version zur=C3=BCcksetzen."
=20
-#: sequencer.c:984
+#: sequencer.c:1001
 msgid "Can't cherry-pick into empty head"
 msgstr "Kann \"cherry-pick\" nicht in einem leerem Kopf ausf=C3=BChren=
=2E"
=20
@@ -664,6 +664,15 @@ msgid "Upstream branch '%s' not stored as a remote=
-tracking branch"
 msgstr ""
 "Zweig '%s' des entfernten Projektarchivs ist kein gefolgter =C3=9Cber=
nahmezweig"
=20
+#: wrapper.c:413
+#, c-format
+msgid "unable to look up current user in the passwd file: %s"
+msgstr "konnte aktuellen Benutzer nicht in Passwort-Datei finden: %s"
+
+#: wrapper.c:414
+msgid "no such user"
+msgstr "kein solcher Benutzer"
+
 #: wt-status.c:135
 msgid "Unmerged paths:"
 msgstr "Nicht zusammengef=C3=BChrte Pfade:"
@@ -1008,7 +1017,7 @@ msgstr "Wolltest du vielleicht 'git add .' sagen?=
\n"
 msgid "index file corrupt"
 msgstr "Bereitstellungsdatei besch=C3=A4digt"
=20
-#: builtin/add.c:476 builtin/apply.c:4100 builtin/mv.c:229 builtin/rm.=
c:260
+#: builtin/add.c:476 builtin/apply.c:4108 builtin/mv.c:229 builtin/rm.=
c:260
 msgid "Unable to write new index file"
 msgstr "Konnte neue Bereitstellungsdatei nicht schreiben."
=20
@@ -1250,243 +1259,254 @@ msgstr "%s ist vom Typ %o, erwartete %o"
 msgid "%s: already exists in index"
 msgstr "%s ist bereits bereitgestellt"
=20
-#: builtin/apply.c:3266
+#: builtin/apply.c:3267
 #, c-format
-msgid "new mode (%o) of %s does not match old mode (%o)%s%s"
-msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o)%=
s%s"
+msgid "new mode (%o) of %s does not match old mode (%o)"
+msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o)"
=20
 #: builtin/apply.c:3272
 #, c-format
+msgid "new mode (%o) of %s does not match old mode (%o) of %s"
+msgstr "neuer Modus (%o) von %s entspricht nicht dem alten Modus (%o) =
von %s"
+
+#: builtin/apply.c:3280
+#, c-format
 msgid "%s: patch does not apply"
 msgstr "%s: Patch konnte nicht angewendet werden"
=20
-#: builtin/apply.c:3285
+#: builtin/apply.c:3293
 #, c-format
 msgid "Checking patch %s..."
 msgstr "Pr=C3=BCfe Patch %s..."
=20
-#: builtin/apply.c:3340 builtin/checkout.c:212 builtin/reset.c:158
+#: builtin/apply.c:3348 builtin/checkout.c:212 builtin/reset.c:158
 #, c-format
 msgid "make_cache_entry failed for path '%s'"
 msgstr "make_cache_entry f=C3=BCr Pfad '%s' fehlgeschlagen"
=20
-#: builtin/apply.c:3483
+#: builtin/apply.c:3491
 #, c-format
 msgid "unable to remove %s from index"
 msgstr "konnte %s nicht aus der Bereitstellung entfernen"
=20
-#: builtin/apply.c:3510
+#: builtin/apply.c:3518
 #, c-format
 msgid "corrupt patch for subproject %s"
 msgstr "fehlerhafter Patch f=C3=BCr Unterprojekt %s"
=20
-#: builtin/apply.c:3514
+#: builtin/apply.c:3522
 #, c-format
 msgid "unable to stat newly created file '%s'"
 msgstr "konnte neu erstellte Datei '%s' nicht lesen"
=20
-#: builtin/apply.c:3519
+#: builtin/apply.c:3527
 #, c-format
 msgid "unable to create backing store for newly created file %s"
 msgstr "kann internen Speicher f=C3=BCr eben erstellte Datei %s nicht =
erzeugen"
=20
-#: builtin/apply.c:3522
+#: builtin/apply.c:3530
 #, c-format
 msgid "unable to add cache entry for %s"
 msgstr "kann f=C3=BCr %s keinen Eintrag in den Zwischenspeicher hinzuf=
=C3=BCgen"
=20
-#: builtin/apply.c:3555
+#: builtin/apply.c:3563
 #, c-format
 msgid "closing file '%s'"
 msgstr "schlie=C3=9Fe Datei '%s'"
=20
-#: builtin/apply.c:3604
+#: builtin/apply.c:3612
 #, c-format
 msgid "unable to write file '%s' mode %o"
 msgstr "konnte Datei '%s' mit Modus %o nicht schreiben"
=20
-#: builtin/apply.c:3660
+#: builtin/apply.c:3668
 #, c-format
 msgid "Applied patch %s cleanly."
 msgstr "Patch %s sauber angewendet"
=20
-#: builtin/apply.c:3668
+#: builtin/apply.c:3676
 msgid "internal error"
 msgstr "interner Fehler"
=20
 #. Say this even without --verbose
-#: builtin/apply.c:3671
+#: builtin/apply.c:3679
 #, c-format
 msgid "Applying patch %%s with %d reject..."
 msgid_plural "Applying patch %%s with %d rejects..."
 msgstr[0] "Wende Patch %%s mit %d Zur=C3=BCckweisung an..."
 msgstr[1] "Wende Patch %%s mit %d Zur=C3=BCckweisungen an..."
=20
-#: builtin/apply.c:3681
+#: builtin/apply.c:3689
 #, c-format
 msgid "truncating .rej filename to %.*s.rej"
 msgstr "Verk=C3=BCrze Name von .rej Datei zu %.*s.rej"
=20
-#: builtin/apply.c:3702
+#: builtin/apply.c:3710
 #, c-format
 msgid "Hunk #%d applied cleanly."
 msgstr "Patch-Bereich #%d sauber angewendet."
=20
-#: builtin/apply.c:3705
+#: builtin/apply.c:3713
 #, c-format
 msgid "Rejected hunk #%d."
 msgstr "Patch-Bereich #%d zur=C3=BCckgewiesen."
=20
-#: builtin/apply.c:3836
+#: builtin/apply.c:3844
 msgid "unrecognized input"
 msgstr "nicht erkannte Eingabe"
=20
-#: builtin/apply.c:3847
+#: builtin/apply.c:3855
 msgid "unable to read index file"
 msgstr "Konnte Bereitstellungsdatei nicht lesen"
=20
-#: builtin/apply.c:3962 builtin/apply.c:3965
+#: builtin/apply.c:3970 builtin/apply.c:3973
 msgid "path"
 msgstr "Pfad"
=20
-#: builtin/apply.c:3963
+#: builtin/apply.c:3971
 msgid "don't apply changes matching the given path"
 msgstr "wendet keine =C3=84nderungen im angegebenen Pfad an"
=20
-#: builtin/apply.c:3966
+#: builtin/apply.c:3974
 msgid "apply changes matching the given path"
 msgstr "wendet =C3=84nderungen nur im angegebenen Pfad an"
=20
-#: builtin/apply.c:3968
+#: builtin/apply.c:3976
 msgid "num"
 msgstr "Anzahl"
=20
-#: builtin/apply.c:3969
+#: builtin/apply.c:3977
 msgid "remove <num> leading slashes from traditional diff paths"
-msgstr "entfernt <Anzahl> vorrangestellte Schr=C3=A4gstriche von herk=C3=
=B6mmlichen "
+msgstr ""
+"entfernt <Anzahl> vorrangestellte Schr=C3=A4gstriche von herk=C3=B6mm=
lichen "
 "Differenzpfaden"
=20
-#: builtin/apply.c:3972
+#: builtin/apply.c:3980
 msgid "ignore additions made by the patch"
 msgstr "ignoriert hinzugef=C3=BCgte Zeilen des Patches"
=20
-#: builtin/apply.c:3974
+#: builtin/apply.c:3982
 msgid "instead of applying the patch, output diffstat for the input"
-msgstr "anstatt der Anwendung des Patches, wird der \"diffstat\" f=C3=BC=
r die Eingabe "
+msgstr ""
+"anstatt der Anwendung des Patches, wird der \"diffstat\" f=C3=BCr die=
 Eingabe "
 "ausgegeben"
=20
-#: builtin/apply.c:3978
+#: builtin/apply.c:3986
 msgid "shows number of added and deleted lines in decimal notation"
-msgstr "zeigt die Anzahl von hinzugef=C3=BCgten/entfernten Zeilen in "
-"Dezimalnotation"
+msgstr ""
+"zeigt die Anzahl von hinzugef=C3=BCgten/entfernten Zeilen in Dezimaln=
otation"
=20
-#: builtin/apply.c:3980
+#: builtin/apply.c:3988
 msgid "instead of applying the patch, output a summary for the input"
-msgstr "anstatt der Anwendung des Patches, wird eine Zusammenfassung f=
=C3=BCr die "
-"Eingabe ausgegeben"
+msgstr ""
+"anstatt der Anwendung des Patches, wird eine Zusammenfassung f=C3=BCr=
 die Eingabe "
+"ausgegeben"
=20
-#: builtin/apply.c:3982
+#: builtin/apply.c:3990
 msgid "instead of applying the patch, see if the patch is applicable"
-msgstr "anstatt der Anwendung des Patches, zeige ob Patch angewendet w=
erden "
-"kann"
+msgstr ""
+"anstatt der Anwendung des Patches, zeige ob Patch angewendet werden k=
ann"
=20
-#: builtin/apply.c:3984
+#: builtin/apply.c:3992
 msgid "make sure the patch is applicable to the current index"
-msgstr "stellt sicher, dass der Patch in der aktuellen Bereitstellung =
"
-"angewendet werden kann"
+msgstr ""
+"stellt sicher, dass der Patch in der aktuellen Bereitstellung angewen=
det "
+"werden kann"
=20
-#: builtin/apply.c:3986
+#: builtin/apply.c:3994
 msgid "apply a patch without touching the working tree"
 msgstr "wendet einen Patch an, ohne =C3=84nderungen im Arbeitszweig vo=
rzunehmen"
=20
-#: builtin/apply.c:3988
+#: builtin/apply.c:3996
 msgid "also apply the patch (use with --stat/--summary/--check)"
 msgstr "wendet den Patch an (Benutzung mit --stat/--summary/--check)"
=20
-#: builtin/apply.c:3990
+#: builtin/apply.c:3998
 msgid "build a temporary index based on embedded index information"
-msgstr "erstellt eine tempor=C3=A4re Bereitstellung basierend auf den =
integrierten "
+msgstr ""
+"erstellt eine tempor=C3=A4re Bereitstellung basierend auf den integri=
erten "
 "Bereitstellungsinformationen"
=20
-#: builtin/apply.c:3992
+#: builtin/apply.c:4000
 msgid "paths are separated with NUL character"
 msgstr "Pfade sind getrennt durch NUL Zeichen"
=20
-#: builtin/apply.c:3995
+#: builtin/apply.c:4003
 msgid "ensure at least <n> lines of context match"
-msgstr "stellt sicher, dass mindestens <Anzahl> Zeilen des Kontextes "
-"=C3=BCbereinstimmen"
+msgstr ""
+"stellt sicher, dass mindestens <Anzahl> Zeilen des Kontextes =C3=BCbe=
reinstimmen"
=20
-#: builtin/apply.c:3996
+#: builtin/apply.c:4004
 msgid "action"
 msgstr "Aktion"
=20
-#: builtin/apply.c:3997
+#: builtin/apply.c:4005
 msgid "detect new or modified lines that have whitespace errors"
 msgstr "ermittelt neue oder ge=C3=A4nderte Zeilen die Fehler in Leerze=
ichen haben"
=20
-#: builtin/apply.c:4000 builtin/apply.c:4003
+#: builtin/apply.c:4008 builtin/apply.c:4011
 msgid "ignore changes in whitespace when finding context"
 msgstr "ignoriert =C3=84nderungen in Leerzeichen bei der Suche des Kon=
textes"
=20
-#: builtin/apply.c:4006
+#: builtin/apply.c:4014
 msgid "apply the patch in reverse"
 msgstr "wendet den Patch in umgekehrter Reihenfolge an"
=20
-#: builtin/apply.c:4008
+#: builtin/apply.c:4016
 msgid "don't expect at least one line of context"
 msgstr "erwartet keinen Kontext"
=20
-#: builtin/apply.c:4010
+#: builtin/apply.c:4018
 msgid "leave the rejected hunks in corresponding *.rej files"
-msgstr "hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bereiche in den en=
tsprechenden *.rej "
+msgstr ""
+"hinterl=C3=A4sst zur=C3=BCckgewiesene Patch-Bereiche in den entsprech=
enden *.rej "
 "Dateien"
=20
-#: builtin/apply.c:4012
+#: builtin/apply.c:4020
 msgid "allow overlapping hunks"
 msgstr "erlaubt sich =C3=BCberlappende Patch-Bereiche"
=20
-#: builtin/apply.c:4013
+#: builtin/apply.c:4021
 msgid "be verbose"
 msgstr "erweiterte Ausgaben"
=20
-#: builtin/apply.c:4015
+#: builtin/apply.c:4023
 msgid "tolerate incorrectly detected missing new-line at the end of fi=
le"
 msgstr "toleriert fehlerhaft erkannten fehlenden Zeilenumbruch am Date=
iende"
=20
-#: builtin/apply.c:4018
+#: builtin/apply.c:4026
 msgid "do not trust the line counts in the hunk headers"
 msgstr "vertraut nicht den Zeilennummern im Kopf des Patch-Bereiches"
=20
-#: builtin/apply.c:4020
+#: builtin/apply.c:4028
 msgid "root"
 msgstr "Wurzelverzeichnis"
=20
-#: builtin/apply.c:4021
+#: builtin/apply.c:4029
 msgid "prepend <root> to all filenames"
 msgstr "stellt <Wurzelverzeichnis> vor alle Dateinamen"
=20
-#: builtin/apply.c:4042
+#: builtin/apply.c:4050
 msgid "--index outside a repository"
 msgstr "--index au=C3=9Ferhalb eines Projektarchivs"
=20
-#: builtin/apply.c:4045
+#: builtin/apply.c:4053
 msgid "--cached outside a repository"
 msgstr "--cached au=C3=9Ferhalb eines Projektarchivs"
=20
-#: builtin/apply.c:4061
+#: builtin/apply.c:4069
 #, c-format
 msgid "can't open patch '%s'"
 msgstr "kann Patch '%s' nicht =C3=B6ffnen"
=20
-#: builtin/apply.c:4075
+#: builtin/apply.c:4083
 #, c-format
 msgid "squelched %d whitespace error"
 msgid_plural "squelched %d whitespace errors"
 msgstr[0] "unterdr=C3=BCckte %d Fehler in Leerzeichen"
 msgstr[1] "unterdr=C3=BCckte %d Fehler in Leerzeichen"
=20
-#: builtin/apply.c:4081 builtin/apply.c:4091
+#: builtin/apply.c:4089 builtin/apply.c:4099
 #, c-format
 msgid "%d line adds whitespace errors."
 msgid_plural "%d lines add whitespace errors."
@@ -2227,52 +2247,52 @@ msgstr "Ung=C3=BCltige Version: %s"
 msgid "malformed --author parameter"
 msgstr "Fehlerhafter --author Parameter"
=20
-#: builtin/commit.c:583
+#: builtin/commit.c:582
 #, c-format
 msgid "Malformed ident string: '%s'"
 msgstr "Fehlerhafte Identifikations-String: '%s'"
=20
-#: builtin/commit.c:621 builtin/commit.c:654 builtin/commit.c:968
+#: builtin/commit.c:620 builtin/commit.c:653 builtin/commit.c:967
 #, c-format
 msgid "could not lookup commit %s"
 msgstr "Konnte Version %s nicht nachschlagen"
=20
-#: builtin/commit.c:633 builtin/shortlog.c:296
+#: builtin/commit.c:632 builtin/shortlog.c:296
 #, c-format
 msgid "(reading log message from standard input)\n"
 msgstr "(lese Log-Nachricht von Standard-Eingabe)\n"
=20
-#: builtin/commit.c:635
+#: builtin/commit.c:634
 msgid "could not read log from standard input"
 msgstr "Konnte Log nicht von Standard-Eingabe lesen."
=20
-#: builtin/commit.c:639
+#: builtin/commit.c:638
 #, c-format
 msgid "could not read log file '%s'"
 msgstr "Konnte Log-Datei '%s' nicht lesen"
=20
-#: builtin/commit.c:645
+#: builtin/commit.c:644
 msgid "commit has empty message"
 msgstr "Version hat eine leere Beschreibung"
=20
-#: builtin/commit.c:661
+#: builtin/commit.c:660
 msgid "could not read MERGE_MSG"
 msgstr "Konnte MERGE_MSG nicht lesen"
=20
-#: builtin/commit.c:665
+#: builtin/commit.c:664
 msgid "could not read SQUASH_MSG"
 msgstr "Konnte SQUASH_MSG nicht lesen"
=20
-#: builtin/commit.c:669
+#: builtin/commit.c:668
 #, c-format
 msgid "could not read '%s'"
 msgstr "Konnte '%s' nicht lesen"
=20
-#: builtin/commit.c:721
+#: builtin/commit.c:720
 msgid "could not write commit template"
 msgstr "Konnte Versionsvorlage nicht schreiben"
=20
-#: builtin/commit.c:732
+#: builtin/commit.c:731
 #, c-format
 msgid ""
 "\n"
@@ -2287,7 +2307,7 @@ msgstr ""
 "\t%s\n"
 "und versuche es erneut.\n"
=20
-#: builtin/commit.c:737
+#: builtin/commit.c:736
 #, c-format
 msgid ""
 "\n"
@@ -2302,7 +2322,7 @@ msgstr ""
 "\t%s\n"
 "und versuche es erneut.\n"
=20
-#: builtin/commit.c:749
+#: builtin/commit.c:748
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '#' will be ignored, and an empty message aborts the commit.\n"
@@ -2311,7 +2331,7 @@ msgstr ""
 "die mit '#' beginnen, werden ignoriert, und eine leere Versionsbeschr=
eibung\n"
 "bricht die Eintragung ab.\n"
=20
-#: builtin/commit.c:754
+#: builtin/commit.c:753
 msgid ""
 "Please enter the commit message for your changes. Lines starting\n"
 "with '#' will be kept; you may remove them yourself if you want to.\n=
"
@@ -2322,164 +2342,164 @@ msgstr ""
 "entfernen.\n"
 "Eine leere Versionsbeschreibung bricht die Eintragung ab.\n"
=20
-#: builtin/commit.c:767
+#: builtin/commit.c:766
 #, c-format
 msgid "%sAuthor:    %s"
 msgstr "%sAutor:    %s"
=20
-#: builtin/commit.c:774
+#: builtin/commit.c:773
 #, c-format
 msgid "%sCommitter: %s"
 msgstr "%sEintragender: %s"
=20
-#: builtin/commit.c:794
+#: builtin/commit.c:793
 msgid "Cannot read index"
 msgstr "Kann Bereitstellung nicht lesen"
=20
-#: builtin/commit.c:831
+#: builtin/commit.c:830
 msgid "Error building trees"
 msgstr "Fehler beim Erzeugen der Zweige"
=20
-#: builtin/commit.c:846 builtin/tag.c:361
+#: builtin/commit.c:845 builtin/tag.c:361
 #, c-format
 msgid "Please supply the message using either -m or -F option.\n"
 msgstr "Bitte liefere eine Beschreibung entweder mit der Option -m ode=
r -F.\n"
=20
-#: builtin/commit.c:943
+#: builtin/commit.c:942
 #, c-format
 msgid "No existing author found with '%s'"
 msgstr "Kein existierender Autor mit '%s' gefunden."
=20
-#: builtin/commit.c:958 builtin/commit.c:1158
+#: builtin/commit.c:957 builtin/commit.c:1157
 #, c-format
 msgid "Invalid untracked files mode '%s'"
 msgstr "Ung=C3=BCltiger Modus '%s' f=C3=BCr unbeobachtete Dateien"
=20
-#: builtin/commit.c:998
+#: builtin/commit.c:997
 msgid "Using both --reset-author and --author does not make sense"
 msgstr "Verwendung von --reset-author und --author macht keinen Sinn."
=20
-#: builtin/commit.c:1009
+#: builtin/commit.c:1008
 msgid "You have nothing to amend."
 msgstr "Du hast nichts zum nachbessern."
=20
-#: builtin/commit.c:1012
+#: builtin/commit.c:1011
 msgid "You are in the middle of a merge -- cannot amend."
 msgstr "Eine Zusammenf=C3=BChrung ist im Gange -- kann nicht nachbesse=
rn."
=20
-#: builtin/commit.c:1014
+#: builtin/commit.c:1013
 msgid "You are in the middle of a cherry-pick -- cannot amend."
 msgstr "\"cherry-pick\" ist im Gange -- kann nicht nachbessern."
=20
-#: builtin/commit.c:1017
+#: builtin/commit.c:1016
 msgid "Options --squash and --fixup cannot be used together"
 msgstr ""
 "Die Optionen --squash und --fixup k=C3=B6nnen nicht gemeinsam benutzt=
 werden."
=20
-#: builtin/commit.c:1027
+#: builtin/commit.c:1026
 msgid "Only one of -c/-C/-F/--fixup can be used."
 msgstr "Nur eines von -c/-C/-F/--fixup kann benutzt werden."
=20
-#: builtin/commit.c:1029
+#: builtin/commit.c:1028
 msgid "Option -m cannot be combined with -c/-C/-F/--fixup."
 msgstr "Option -m kann nicht mit -c/-C/-F/--fixup kombiniert werden"
=20
-#: builtin/commit.c:1037
+#: builtin/commit.c:1036
 msgid "--reset-author can be used only with -C, -c or --amend."
 msgstr "--reset--author kann nur mit -C, -c oder --amend benutzt werde=
n"
=20
-#: builtin/commit.c:1054
+#: builtin/commit.c:1053
 msgid "Only one of --include/--only/--all/--interactive/--patch can be=
 used."
 msgstr ""
 "Nur eines von --include/--only/--all/--interactive/--patch kann benut=
zt "
 "werden."
=20
-#: builtin/commit.c:1056
+#: builtin/commit.c:1055
 msgid "No paths with --include/--only does not make sense."
 msgstr "--include/--only machen ohne Pfade keinen Sinn."
=20
-#: builtin/commit.c:1058
+#: builtin/commit.c:1057
 msgid "Clever... amending the last one with dirty index."
 msgstr ""
 "Klug... die letzte Version mit einer unsauberen Bereitstellung nachbe=
ssern."
=20
-#: builtin/commit.c:1060
+#: builtin/commit.c:1059
 msgid "Explicit paths specified without -i nor -o; assuming --only pat=
hs..."
 msgstr ""
 "Explizite Pfade ohne -i oder -o angegeben; unter der Annahme von --on=
ly "
 "Pfaden..."
=20
-#: builtin/commit.c:1070 builtin/tag.c:577
+#: builtin/commit.c:1069 builtin/tag.c:577
 #, c-format
 msgid "Invalid cleanup mode %s"
 msgstr "Ung=C3=BCltiger \"cleanup\" Modus %s"
=20
-#: builtin/commit.c:1075
+#: builtin/commit.c:1074
 msgid "Paths with -a does not make sense."
 msgstr "Pfade mit -a machen keinen Sinn."
=20
-#: builtin/commit.c:1258
+#: builtin/commit.c:1257
 msgid "couldn't look up newly created commit"
 msgstr "Konnte neu erstellte Version nicht nachschlagen."
=20
-#: builtin/commit.c:1260
+#: builtin/commit.c:1259
 msgid "could not parse newly created commit"
 msgstr "Konnte neulich erstellte Version nicht analysieren."
=20
-#: builtin/commit.c:1301
+#: builtin/commit.c:1300
 msgid "detached HEAD"
 msgstr "losgel=C3=B6ste Zweigspitze (HEAD)"
=20
-#: builtin/commit.c:1303
+#: builtin/commit.c:1302
 msgid " (root-commit)"
 msgstr " (Basis-Version)"
=20
-#: builtin/commit.c:1447
+#: builtin/commit.c:1446
 msgid "could not parse HEAD commit"
 msgstr "Konnte Version der Zweigspitze (HEAD) nicht analysieren."
=20
-#: builtin/commit.c:1485 builtin/merge.c:509
+#: builtin/commit.c:1484 builtin/merge.c:509
 #, c-format
 msgid "could not open '%s' for reading"
 msgstr "Konnte '%s' nicht zum Lesen =C3=B6ffnen."
=20
-#: builtin/commit.c:1492
+#: builtin/commit.c:1491
 #, c-format
 msgid "Corrupt MERGE_HEAD file (%s)"
 msgstr "Besch=C3=A4digte MERGE_HEAD-Datei (%s)"
=20
-#: builtin/commit.c:1499
+#: builtin/commit.c:1498
 msgid "could not read MERGE_MODE"
 msgstr "Konnte MERGE_MODE nicht lesen"
=20
-#: builtin/commit.c:1518
+#: builtin/commit.c:1517
 #, c-format
 msgid "could not read commit message: %s"
 msgstr "Konnte Versionsbeschreibung nicht lesen: %s"
=20
-#: builtin/commit.c:1532
+#: builtin/commit.c:1531
 #, c-format
 msgid "Aborting commit; you did not edit the message.\n"
 msgstr "Eintragung abgebrochen; du hast die Beschreibung nicht editier=
t.\n"
=20
-#: builtin/commit.c:1537
+#: builtin/commit.c:1536
 #, c-format
 msgid "Aborting commit due to empty commit message.\n"
 msgstr "Eintragung aufgrund leerer Versionsbeschreibung abgebrochen.\n=
"
=20
-#: builtin/commit.c:1552 builtin/merge.c:936 builtin/merge.c:961
+#: builtin/commit.c:1551 builtin/merge.c:936 builtin/merge.c:961
 msgid "failed to write commit object"
 msgstr "Fehler beim Schreiben des Versionsobjektes."
=20
-#: builtin/commit.c:1573
+#: builtin/commit.c:1572
 msgid "cannot lock HEAD ref"
 msgstr "Kann Referenz der Zweigspitze (HEAD) nicht sperren."
=20
-#: builtin/commit.c:1577
+#: builtin/commit.c:1576
 msgid "cannot update HEAD ref"
 msgstr "Kann Referenz der Zweigspitze (HEAD) nicht aktualisieren."
=20
-#: builtin/commit.c:1588
+#: builtin/commit.c:1587
 msgid ""
 "Repository has been updated, but unable to write\n"
 "new_index file. Check that disk is not full or quota is\n"
@@ -2832,33 +2852,33 @@ msgstr "Schalter '%c' erwartet einen numerische=
n Wert"
 msgid "cannot open '%s'"
 msgstr "kann '%s' nicht =C3=B6ffnen"
=20
-#: builtin/grep.c:888
+#: builtin/grep.c:885
 msgid "no pattern given."
 msgstr "keine Muster angegeben"
=20
-#: builtin/grep.c:902
+#: builtin/grep.c:899
 #, c-format
 msgid "bad object %s"
 msgstr "ung=C3=BCltiges Objekt %s"
=20
-#: builtin/grep.c:943
+#: builtin/grep.c:940
 msgid "--open-files-in-pager only works on the worktree"
 msgstr "--open-files-in-pager arbeitet nur innerhalb des Arbeitsbaums"
=20
-#: builtin/grep.c:966
+#: builtin/grep.c:963
 msgid "--cached or --untracked cannot be used with --no-index."
 msgstr "--cached oder --untracked kann nicht mit --no-index benutzt we=
rden"
=20
-#: builtin/grep.c:971
+#: builtin/grep.c:968
 msgid "--no-index or --untracked cannot be used with revs."
 msgstr "--no-index oder --untracked kann nicht mit Versionen benutzt w=
erden"
=20
-#: builtin/grep.c:974
+#: builtin/grep.c:971
 msgid "--[no-]exclude-standard cannot be used for tracked contents."
 msgstr ""
 "--[no-]exlude-standard kann nicht mit beobachteten Inhalten benutzt w=
erden"
=20
-#: builtin/grep.c:982
+#: builtin/grep.c:979
 msgid "both --cached and trees are given."
 msgstr "sowohl --cached als auch Zweige gegeben"
=20
@@ -3330,79 +3350,75 @@ msgstr "Unbekannter Typ: %d"
 msgid "format.headers without value"
 msgstr "format.headers ohne Wert"
=20
-#: builtin/log.c:675
+#: builtin/log.c:676
 msgid "name of output directory is too long"
 msgstr "Name des Ausgabeverzeichnisses ist zu lang."
=20
-#: builtin/log.c:686
+#: builtin/log.c:687
 #, c-format
 msgid "Cannot open patch file %s"
 msgstr "Kann Patch-Datei %s nicht =C3=B6ffnen"
=20
-#: builtin/log.c:700
+#: builtin/log.c:701
 msgid "Need exactly one range."
 msgstr "Brauche genau einen Versionsbereich."
=20
-#: builtin/log.c:708
+#: builtin/log.c:709
 msgid "Not a range."
 msgstr "Kein Versionsbereich."
=20
-#: builtin/log.c:745
-msgid "Could not extract email from committer identity."
-msgstr "Konnte E-Mail-Adresse des Einreichers nicht extrahieren."
-
-#: builtin/log.c:791
+#: builtin/log.c:786
 msgid "Cover letter needs email format"
 msgstr "Anschreiben ben=C3=B6tigt E-Mail-Format"
=20
-#: builtin/log.c:885
+#: builtin/log.c:859
 #, c-format
 msgid "insane in-reply-to: %s"
 msgstr "ung=C3=BCltiges in-reply-to: %s"
=20
-#: builtin/log.c:958
+#: builtin/log.c:932
 msgid "Two output directories?"
 msgstr "Zwei Ausgabeverzeichnisse?"
=20
-#: builtin/log.c:1179
+#: builtin/log.c:1153
 #, c-format
 msgid "bogus committer info %s"
 msgstr "unechte Einreicher-Informationen %s"
=20
-#: builtin/log.c:1224
+#: builtin/log.c:1198
 msgid "-n and -k are mutually exclusive."
 msgstr "-n und -k schliessen sich gegenseitig aus"
=20
-#: builtin/log.c:1226
+#: builtin/log.c:1200
 msgid "--subject-prefix and -k are mutually exclusive."
 msgstr "--subject-prefix und -k schliessen sich gegenseitig aus"
=20
-#: builtin/log.c:1234
+#: builtin/log.c:1208
 msgid "--name-only does not make sense"
 msgstr "--name-only macht keinen Sinn"
=20
-#: builtin/log.c:1236
+#: builtin/log.c:1210
 msgid "--name-status does not make sense"
 msgstr "--name-status macht keinen Sinn"
=20
-#: builtin/log.c:1238
+#: builtin/log.c:1212
 msgid "--check does not make sense"
 msgstr "--check macht keinen Sinn"
=20
-#: builtin/log.c:1261
+#: builtin/log.c:1235
 msgid "standard output, or directory, which one?"
 msgstr "Standard-Ausgabe oder Verzeichnis, welches von beidem?"
=20
-#: builtin/log.c:1263
+#: builtin/log.c:1237
 #, c-format
 msgid "Could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
=20
-#: builtin/log.c:1416
+#: builtin/log.c:1390
 msgid "Failed to create output files"
 msgstr "Fehler beim Erstellen der Ausgabedateien."
=20
-#: builtin/log.c:1520
+#: builtin/log.c:1494
 #, c-format
 msgid ""
 "Could not find a tracked remote branch, please specify <upstream> man=
ually.\n"
@@ -3410,7 +3426,7 @@ msgstr ""
 "Konnte gefolgten, externen Zweig nicht finden, bitte gebe <upstream> =
manuell "
 "an.\n"
=20
-#: builtin/log.c:1536 builtin/log.c:1538 builtin/log.c:1550
+#: builtin/log.c:1510 builtin/log.c:1512 builtin/log.c:1524
 #, c-format
 msgid "Unknown commit %s"
 msgstr "Unbekannte Version %s"
@@ -3910,22 +3926,22 @@ msgstr "Objekt %s hat keine Notiz\n"
 msgid "Unknown subcommand: %s"
 msgstr "Unbekanntes Unterkommando: %s"
=20
-#: builtin/pack-objects.c:2315
+#: builtin/pack-objects.c:2337
 #, c-format
 msgid "unsupported index version %s"
 msgstr "Nicht unterst=C3=BCtzte Bereitstellungsversion %s"
=20
-#: builtin/pack-objects.c:2319
+#: builtin/pack-objects.c:2341
 #, c-format
 msgid "bad index version '%s'"
 msgstr "Ung=C3=BCltige Bereitstellungsversion '%s'"
=20
-#: builtin/pack-objects.c:2342
+#: builtin/pack-objects.c:2364
 #, c-format
 msgid "option %s does not accept negative form"
 msgstr "Option %s akzeptiert keine negative Form"
=20
-#: builtin/pack-objects.c:2346
+#: builtin/pack-objects.c:2368
 #, c-format
 msgid "unable to parse value '%s' for option %s"
 msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht parsen"
@@ -4216,12 +4232,13 @@ msgstr "Konnte Sektion '%s' nicht aus Konfigura=
tion entfernen"
 #: builtin/remote.c:677
 #, c-format
 msgid ""
-"Not updating non-default fetch respec\n"
+"Not updating non-default fetch refspec\n"
 "\t%s\n"
 "\tPlease update the configuration manually if necessary."
 msgstr ""
 "Keine Aktualisierung der nicht standardm=C3=A4=C3=9Figen Referenzspez=
ifikation zum "
-"Abholen\t%s\n"
+"Abholen\n"
+"\t%s\n"
 "\tBitte aktualisiere, falls notwendig, die Konfiguration manuell."
=20
 #: builtin/remote.c:683
@@ -5290,29 +5307,29 @@ msgstr "Betrete '$prefix$sm_path'"
 msgid "Stopping at '$sm_path'; script returned non-zero status."
 msgstr "Stoppe bei '$sm_path'; Skript gab nicht-Null Status zur=C3=BCc=
k."
=20
-#: git-submodule.sh:405
+#: git-submodule.sh:406
 #, sh-format
 msgid "No url found for submodule path '$sm_path' in .gitmodules"
 msgstr "Keine URL f=C3=BCr Unterprojekt-Pfad '$sm_path' in .gitmodules=
 gefunden"
=20
-#: git-submodule.sh:414
+#: git-submodule.sh:415
 #, sh-format
 msgid "Failed to register url for submodule path '$sm_path'"
 msgstr "Registrierung der URL f=C3=BCr Unterprojekt-Pfad '$sm_path' fe=
hlgeschlagen"
=20
-#: git-submodule.sh:422
+#: git-submodule.sh:417
+#, sh-format
+msgid "Submodule '$name' ($url) registered for path '$sm_path'"
+msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$sm_path' regis=
triert"
+
+#: git-submodule.sh:425
 #, sh-format
 msgid "Failed to register update mode for submodule path '$sm_path'"
 msgstr ""
 "Registrierung des Aktualisierungsmodus f=C3=BCr Unterprojekt-Pfad '$s=
m_path' "
 "fehlgeschlagen"
=20
-#: git-submodule.sh:424
-#, sh-format
-msgid "Submodule '$name' ($url) registered for path '$sm_path'"
-msgstr "Unterprojekt '$name' ($url) ist f=C3=BCr Pfad '$sm_path' regis=
triert"
-
-#: git-submodule.sh:523
+#: git-submodule.sh:524
 #, sh-format
 msgid ""
 "Submodule path '$sm_path' not initialized\n"
@@ -5321,85 +5338,88 @@ msgstr ""
 "Unterprojekt-Pfad '$sm_path' ist nicht initialisiert\n"
 "Vielleicht m=C3=B6chtest du 'update --init' benutzen?"
=20
-#: git-submodule.sh:536
+#: git-submodule.sh:537
 #, sh-format
 msgid "Unable to find current revision in submodule path '$sm_path'"
 msgstr "Konnte aktuelle Version in Unterprojekt-Pfad '$sm_path' nicht =
finden"
=20
-#: git-submodule.sh:555
+#: git-submodule.sh:556
 #, sh-format
 msgid "Unable to fetch in submodule path '$sm_path'"
 msgstr "Konnte in Unterprojekt-Pfad '$sm_path' nicht anfordern"
=20
-#: git-submodule.sh:569
+#: git-submodule.sh:570
 #, sh-format
 msgid "Unable to rebase '$sha1' in submodule path '$sm_path'"
 msgstr "Neuaufbau von '$sha1' in Unterprojekt-Pfad '$sm_path' nicht m=C3=
=B6glich"
=20
-#: git-submodule.sh:570
+#: git-submodule.sh:571
 #, sh-format
 msgid "Submodule path '$sm_path': rebased into '$sha1'"
 msgstr "Unterprojekt-Pfad '$sm_path': neu aufgebaut in '$sha1'"
=20
-#: git-submodule.sh:575
+#: git-submodule.sh:576
 #, sh-format
 msgid "Unable to merge '$sha1' in submodule path '$sm_path'"
 msgstr ""
 "Zusammenf=C3=BChrung von '$sha1' in Unterprojekt-Pfad '$sm_path' fehl=
geschlagen"
=20
-#: git-submodule.sh:576
+#: git-submodule.sh:577
 #, sh-format
 msgid "Submodule path '$sm_path': merged in '$sha1'"
 msgstr "Unterprojekt-Pfad '$sm_path': zusammengef=C3=BChrt in '$sha1'"
=20
-#: git-submodule.sh:581
+#: git-submodule.sh:582
 #, sh-format
 msgid "Unable to checkout '$sha1' in submodule path '$sm_path'"
 msgstr "Konnte '$sha1' in Unterprojekt-Pfad '$sm_path' nicht auschecke=
n."
=20
-#: git-submodule.sh:582
+#: git-submodule.sh:583
 #, sh-format
 msgid "Submodule path '$sm_path': checked out '$sha1'"
 msgstr "Unterprojekt-Pfad: '$sm_path': '$sha1' ausgecheckt"
=20
-#: git-submodule.sh:604 git-submodule.sh:927
+#: git-submodule.sh:605 git-submodule.sh:928
 #, sh-format
 msgid "Failed to recurse into submodule path '$sm_path'"
 msgstr "Fehler bei Rekursion in Unterprojekt-Pfad '$sm_path'"
=20
-#: git-submodule.sh:712
+#: git-submodule.sh:713
 msgid "--"
 msgstr "--"
=20
-#: git-submodule.sh:770
+#: git-submodule.sh:771
 #, sh-format
 msgid "  Warn: $name doesn't contain commit $sha1_src"
 msgstr "  Warnung: $name beinhaltet nicht Version $sha1_src"
=20
-#: git-submodule.sh:773
+#: git-submodule.sh:774
 #, sh-format
 msgid "  Warn: $name doesn't contain commit $sha1_dst"
 msgstr "  Warnung: $name beinhaltet nicht Version $sha1_dst"
=20
-#: git-submodule.sh:776
+#: git-submodule.sh:777
 #, sh-format
 msgid "  Warn: $name doesn't contain commits $sha1_src and $sha1_dst"
 msgstr ""
 "  Warnung: $name beinhaltet nicht die Versionen $sha1_src und $sha1_d=
st"
=20
-#: git-submodule.sh:801
+#: git-submodule.sh:802
 msgid "blob"
 msgstr "Blob"
=20
-#: git-submodule.sh:802
+#: git-submodule.sh:803
 msgid "submodule"
 msgstr "Unterprojekt"
=20
-#: git-submodule.sh:973
+#: git-submodule.sh:974
 #, sh-format
 msgid "Synchronizing submodule url for '$name'"
 msgstr "Synchronisiere Unterprojekt-URL f=C3=BCr '$name'"
=20
+#~ msgid "Could not extract email from committer identity."
+#~ msgstr "Konnte E-Mail-Adresse des Einreichers nicht extrahieren."
+
 #~ msgid "cherry-pick"
 #~ msgstr "cherry-pick"
=20
--=20
1.7.11.rc0.105.g16abda8
