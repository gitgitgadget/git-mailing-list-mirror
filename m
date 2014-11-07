From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 62 new messages
Date: Fri,  7 Nov 2014 22:05:26 +0100
Message-ID: <1415394326-28696-1-git-send-email-ralf.thielow@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: tr@thomasrast.ch, jk@jk.gs, stimming@tuhh.de,
	phillip.szelat@gmail.com, matthias.ruester@gmail.com,
	magnus.goerlitz@googlemail.com,
	Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 07 22:05:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xmqiu-0001PM-CU
	for gcvg-git-2@plane.gmane.org; Fri, 07 Nov 2014 22:05:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752750AbaKGVFc convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 7 Nov 2014 16:05:32 -0500
Received: from mail-wg0-f44.google.com ([74.125.82.44]:63927 "EHLO
	mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752474AbaKGVFb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Nov 2014 16:05:31 -0500
Received: by mail-wg0-f44.google.com with SMTP id x12so4665037wgg.17
        for <git@vger.kernel.org>; Fri, 07 Nov 2014 13:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=4nYJmc0rWCl8JD2UKQMT2VZ3nYsznOKIDwmmLiBmM6U=;
        b=TNKr6WILrP0fkF36u+ZPRWtzmOFFqRj3m+FRRNyQtsmIZc8fhpTxts5BqX2wm/A2tY
         dqlU57a4lrF2yM8IRBWV6tr2LF5bJUhs/P+BxzqNICuJDzzz2Ew7U8rfhVhfnkE0Lhqe
         YLqlBrP4ZVF2c66H+0Um4+vVYr2aBQu4icnrz1BEzKsrCY0Qek8xBIZ9kNVzfxfI8ClD
         paD2WnNSpk+ZcYuDS6veEi/4cOKDzKoJwElnu9tcxnlfQo57FLx0IbTRDHXqbQrWMmzp
         Izpq+D/FOUwjmKfI+8SvS59RnWcxwljGQvl2OACQJk8HeOBUJhMUGbDDkY1OnsdR17P8
         4H0g==
X-Received: by 10.180.80.74 with SMTP id p10mr6704781wix.31.1415394329415;
        Fri, 07 Nov 2014 13:05:29 -0800 (PST)
Received: from localhost (dslb-088-073-206-248.088.073.pools.vodafone-ip.de. [88.73.206.248])
        by mx.google.com with ESMTPSA id wa10sm8500931wjc.8.2014.11.07.13.05.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Nov 2014 13:05:28 -0800 (PST)
X-Mailer: git-send-email 2.2.0.rc0.232.g8ec773f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 62 new messages came from git.pot update in 16742b0
(l10n: git.pot: proposed updates for v2.2.0 (+62)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 178 +++++++++++++++++++++++++++++--------------------------=
--------
 1 file changed, 82 insertions(+), 96 deletions(-)

diff --git a/po/de.po b/po/de.po
index 96d381e..d422228 100644
--- a/po/de.po
+++ b/po/de.po
@@ -21,18 +21,17 @@ msgstr ""
 #, c-format
 msgid "hint: %.*s\n"
 msgstr "Hinweis: %.*s\n"
=20
 #: advice.c:88
-#, fuzzy
 msgid ""
 "Fix them up in the work tree, and then use 'git add/rm <file>'\n"
 "as appropriate to mark resolution and make a commit."
 msgstr ""
 "Korrigieren Sie dies im Arbeitsverzeichnis, und benutzen Sie\n"
 "dann 'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu mark=
ieren\n"
-"und zu committen, oder benutzen Sie 'git commit -a'."
+"und zu committen."
=20
 #: archive.c:11
 msgid "git archive [options] <tree-ish> [<path>...]"
 msgstr "git archive [Optionen] <Commit-Referenz> [<Pfad>...]"
=20
@@ -326,13 +325,13 @@ msgstr "kann '%s' nicht erstellen"
 #: bundle.c:435
 msgid "index-pack died"
 msgstr "Erstellung der Paketindexdatei abgebrochen"
=20
 #: color.c:157
-#, fuzzy, c-format
+#, c-format
 msgid "invalid color value: %.*s"
-msgstr "Ung=C3=BCltiger Wert f=C3=BCr %s: %s"
+msgstr "Ung=C3=BCltiger Farbwert: %.*s"
=20
 #: commit.c:40
 #, c-format
 msgid "could not parse %s"
 msgstr "konnte %s nicht parsen"
@@ -347,60 +346,60 @@ msgid "memory exhausted"
 msgstr "Speicher verbraucht"
=20
 #: config.c:469 config.c:471
 #, c-format
 msgid "bad config file line %d in %s"
-msgstr ""
+msgstr "Zeile %d in Konfigurationsdatei %s ist ung=C3=BCltig."
=20
 #: config.c:587
 #, c-format
 msgid "bad numeric config value '%s' for '%s' in %s: %s"
-msgstr ""
+msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s' in %s: %s"
=20
 #: config.c:589
-#, fuzzy, c-format
+#, c-format
 msgid "bad numeric config value '%s' for '%s': %s"
-msgstr "Konnte Sektion '%s' in Konfiguration nicht nach '%s' umbenenne=
n"
+msgstr "Ung=C3=BCltiger numerischer Wert '%s' f=C3=BCr Konfiguration '=
%s': %s"
=20
 #: config.c:674
-#, fuzzy, c-format
+#, c-format
 msgid "failed to expand user dir in: '%s'"
-msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
+msgstr "Fehler beim Erweitern des Nutzerverzeichnisses in: '%s'"
=20
 #: config.c:752 config.c:763
-#, fuzzy, c-format
+#, c-format
 msgid "bad zlib compression level %d"
-msgstr "Komprimierungsgrad f=C3=BCr Paketierung"
+msgstr "ung=C3=BCltiger zlib Komprimierungsgrad %d"
=20
 #: config.c:885
-#, fuzzy, c-format
+#, c-format
 msgid "invalid mode for object creation: %s"
-msgstr "Ung=C3=BCltiges Datumsformat: %s"
+msgstr "Ung=C3=BCltiger Modus f=C3=BCr Objekterstellung: %s"
=20
 #: config.c:1201
-#, fuzzy
 msgid "unable to parse command-line config"
-msgstr "Konnte Staging-Area-Datei nicht lesen"
+msgstr "Konnte die =C3=BCber die Kommandozeile angegebene Konfiguratio=
n nicht parsen."
=20
 #: config.c:1262
 msgid "unknown error occured while reading the configuration files"
-msgstr ""
+msgstr "Es trat ein unbekannter Fehler beim Lesen der Konfigurationsda=
teien auf."
=20
 #: config.c:1586
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse '%s' from command-line config"
-msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht parsen"
+msgstr "Konnte Wert '%s' aus der =C3=BCber die Kommandozeile angegeben=
en\n"
+"Konfiguration nicht parsen."
=20
 #: config.c:1588
 #, c-format
 msgid "bad config variable '%s' in file '%s' at line %d"
-msgstr ""
+msgstr "ung=C3=BCltige Konfigurationsvariable '%s' in Datei '%s' bei Z=
eile %d"
=20
 #: config.c:1647
 #, c-format
 msgid "%s has multiple values"
-msgstr ""
+msgstr "%s hat mehrere Werte"
=20
 #: connected.c:69
 msgid "Could not run 'git rev-list'"
 msgstr "Konnte 'git rev-list' nicht ausf=C3=BChren"
=20
@@ -640,15 +639,15 @@ msgstr[1] ""
 msgid "%s: %s - %s"
 msgstr "%s: %s - %s"
=20
 #: lockfile.c:275
 msgid "BUG: reopen a lockfile that is still open"
-msgstr ""
+msgstr "FEHLER: Wiederer=C3=B6ffnen einer bereits ge=C3=B6ffneten Lock=
-Datei"
=20
 #: lockfile.c:277
 msgid "BUG: reopen a lockfile that has been committed"
-msgstr ""
+msgstr "FEHLER: Wiederer=C3=B6ffnen einer bereits committeten Lock-Dat=
ei"
=20
 #: merge.c:41
 msgid "failed to read the cache"
 msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
=20
@@ -1032,13 +1031,12 @@ msgid ""
 msgstr ""
 ":(exclude) Muster, aber keine anderen Pfadspezifikationen angegeben.\=
n"
 "Vielleicht haben Sie vergessen entweder ':/' oder '.' hinzuzuf=C3=BCg=
en?"
=20
 #: pretty.c:968
-#, fuzzy
 msgid "unable to parse --pretty format"
-msgstr "Konnte Objekt '%s' nicht parsen."
+msgstr "Konnte --pretty Format nicht parsen."
=20
 #: progress.c:225
 msgid "done"
 msgstr "Fertig"
=20
@@ -1148,17 +1146,16 @@ msgstr "=C3=96ffnen von /dev/null fehlgeschlage=
n"
 #, c-format
 msgid "dup2(%d,%d) failed"
 msgstr "dup2(%d,%d) fehlgeschlagen"
=20
 #: send-pack.c:265
-#, fuzzy
 msgid "failed to sign the push certificate"
-msgstr "gpg beim Signieren der Daten fehlgeschlagen"
+msgstr "Fehler beim Signieren des \"push\"-Zertifikates"
=20
 #: send-pack.c:322
 msgid "the receiving end does not support --signed push"
-msgstr ""
+msgstr "die Gegenseite unterst=C3=BCtzt keinen signierten Versand (\"-=
-signed push\")"
=20
 #: sequencer.c:172 builtin/merge.c:781 builtin/merge.c:892
 #: builtin/merge.c:1002 builtin/merge.c:1012
 #, c-format
 msgid "Could not open '%s' for writing"
@@ -1486,33 +1483,32 @@ msgstr "Konnte git-Verweis %s nicht erstellen"
 msgid "Could not set core.worktree in %s"
 msgstr "Konnte core.worktree in '%s' nicht setzen."
=20
 #: trailer.c:500 trailer.c:504 trailer.c:508 trailer.c:562 trailer.c:5=
66
 #: trailer.c:570
-#, fuzzy, c-format
+#, c-format
 msgid "unknown value '%s' for key '%s'"
-msgstr "konnte Wert '%s' f=C3=BCr Option %s nicht parsen"
+msgstr "unbekannter Wert '%s' f=C3=BCr Schl=C3=BCssel %s"
=20
 #: trailer.c:552 trailer.c:557 builtin/remote.c:288
 #, c-format
 msgid "more than one %s"
 msgstr "mehr als ein %s"
=20
 #: trailer.c:587
 #, c-format
 msgid "empty trailer token in trailer '%s'"
-msgstr ""
+msgstr "leerer Anhang-Token in Anhang '%s'"
=20
 #: trailer.c:706
-#, fuzzy, c-format
+#, c-format
 msgid "could not read input file '%s'"
-msgstr "Konnte Log-Datei '%s' nicht lesen"
+msgstr "Konnte Eingabe-Datei '%s' nicht lesen"
=20
 #: trailer.c:709
-#, fuzzy
 msgid "could not read from stdin"
-msgstr "konnte nicht von '%s' lesen"
+msgstr "konnte nicht von der Standard-Eingabe lesen"
=20
 #: unpack-trees.c:202
 msgid "Checking out files"
 msgstr "Checke Dateien aus"
=20
@@ -1563,13 +1559,12 @@ msgstr "konnte aktuellen Benutzer nicht in Pass=
wort-Datei finden: %s"
 #: wrapper.c:542
 msgid "no such user"
 msgstr "kein solcher Benutzer"
=20
 #: wrapper.c:550
-#, fuzzy
 msgid "unable to get current working directory"
-msgstr "Kann nicht auf aktuelles Arbeitsverzeichnis zugreifen."
+msgstr "Konnte aktuelles Arbeitsverzeichnis nicht bekommen."
=20
 #: wt-status.c:150
 msgid "Unmerged paths:"
 msgstr "Nicht zusammengef=C3=BChrte Pfade:"
=20
@@ -4232,11 +4227,10 @@ msgstr "git commit [Optionen] [--] <Pfadspezifi=
kation>..."
 #: builtin/commit.c:42
 msgid "git status [options] [--] <pathspec>..."
 msgstr "git status [Optionen] [--] <Pfadspezifikation>..."
=20
 #: builtin/commit.c:47
-#, fuzzy
 msgid ""
 "Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n=
"
 "You can suppress this message by setting them explicitly. Run the\n"
 "following command and follow the instructions in your editor to edit\=
n"
@@ -4249,16 +4243,16 @@ msgid ""
 "    git commit --amend --reset-author\n"
 msgstr ""
 "Ihr Name und E-Mail Adresse wurden automatisch auf Basis\n"
 "Ihres Benutzer- und Rechnernamens konfiguriert. Bitte pr=C3=BCfen Sie=
, dass\n"
 "diese zutreffend sind. Sie k=C3=B6nnen diese Meldung unterdr=C3=BCcke=
n, indem Sie\n"
-"diese explizit setzen:\n"
+"diese explizit setzen. F=C3=BChren Sie dazu das folgende Kommando aus=
 und folgen\n"
+"Sie den Anweisungen in Ihrem Editor, um die Konfigurationsdatei zu be=
arbeiten:\n"
 "\n"
-"    git config --global user.name \"Ihr Name\"\n"
-"    git config --global user.email ihre@emailadresse.de\n"
+"    git config --global --edit\n"
 "\n"
-"Nachdem Sie das getan hast, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=BC=
r diesen Commit "
+"Nachdem Sie das getan haben, k=C3=B6nnen Sie Ihre Identit=C3=A4t f=C3=
=BCr diesen Commit\n"
 "=C3=A4ndern mit:\n"
 "\n"
 "    git commit --amend --reset-author\n"
=20
 #: builtin/commit.c:60
@@ -4343,23 +4337,20 @@ msgstr "Konnte tempor=C3=A4re Staging-Area nich=
t erstellen."
 #: builtin/commit.c:348
 msgid "interactive add failed"
 msgstr "interaktives Hinzuf=C3=BCgen fehlgeschlagen"
=20
 #: builtin/commit.c:359
-#, fuzzy
 msgid "unable to write index file"
-msgstr "Konnte neue Staging-Area-Datei nicht schreiben."
+msgstr "Konnte Staging-Area-Datei nicht schreiben."
=20
 #: builtin/commit.c:361
-#, fuzzy
 msgid "unable to update temporary index"
-msgstr "Konnte tempor=C3=A4re Staging-Area nicht erstellen."
+msgstr "Konnte tempor=C3=A4re Staging-Area nicht aktualisieren."
=20
 #: builtin/commit.c:363
-#, fuzzy
 msgid "Failed to update main cache tree"
-msgstr "Konnte Cache-Verzeichnis nicht aktualisieren\n"
+msgstr "Konnte Haupt-Cache-Verzeichnis nicht aktualisieren"
=20
 #: builtin/commit.c:387 builtin/commit.c:412 builtin/commit.c:461
 msgid "unable to write new_index file"
 msgstr "Konnte new_index Datei nicht schreiben"
=20
@@ -4381,16 +4372,16 @@ msgid "unable to write temporary index file"
 msgstr "Konnte tempor=C3=A4re Staging-Area-Datei nicht schreiben."
=20
 #: builtin/commit.c:592
 #, c-format
 msgid "commit '%s' lacks author header"
-msgstr ""
+msgstr "Commit '%s' fehlt Autor-Kopfbereich"
=20
 #: builtin/commit.c:594
 #, c-format
 msgid "commit '%s' has malformed author line"
-msgstr ""
+msgstr "Commit '%s' hat missgebildete Autor-Zeile"
=20
 #: builtin/commit.c:613
 msgid "malformed --author parameter"
 msgstr "Fehlerhafter --author Parameter"
=20
@@ -4772,11 +4763,11 @@ msgstr "f=C3=BCgt Status in die Commit-Beschrei=
bungsvorlage ein"
 msgid "key-id"
 msgstr "GPG-Schl=C3=BCsselkennung"
=20
 #: builtin/commit.c:1633 builtin/merge.c:225 builtin/revert.c:93
 msgid "GPG sign commit"
-msgstr "signiert Commit mit GPG"
+msgstr "Commit mit GPG signieren"
=20
 #: builtin/commit.c:1636
 msgid "Commit contents options"
 msgstr "Optionen f=C3=BCr Commit-Inhalt"
=20
@@ -4860,11 +4851,10 @@ msgstr "Commit aufgrund leerer Beschreibung abg=
ebrochen.\n"
 #: builtin/commit.c:1794 builtin/merge.c:850 builtin/merge.c:875
 msgid "failed to write commit object"
 msgstr "Fehler beim Schreiben des Commit-Objektes."
=20
 #: builtin/commit.c:1827
-#, fuzzy
 msgid ""
 "Repository has been updated, but unable to write\n"
 "new_index file. Check that disk is not full and quota is\n"
 "not exceeded, and then \"git reset HEAD\" to recover."
 msgstr ""
@@ -5000,28 +4990,32 @@ msgstr "schlie=C3=9Ft Werte mit NUL-Byte ab"
 #: builtin/config.c:81
 msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
=20
 #: builtin/config.c:315
-#, fuzzy
 msgid "unable to parse default color value"
-msgstr "kann lokale Referenz nicht aktualisieren"
+msgstr "konnte Standard-Farbwert nicht parsen"
=20
 #: builtin/config.c:455
 #, c-format
 msgid ""
 "# This is Git's per-user configuration file.\n"
 "[core]\n"
 "# Please adapt and uncomment the following lines:\n"
 "#\tuser =3D %s\n"
 "#\temail =3D %s\n"
 msgstr ""
+"# Das ist Git's benutzerspezifische Konfiguraionsdatei.\n"
+"[core]\n"
+"# Bitte passen Sie die folgenden Zeilen an und kommentieren Sie diese=
 aus:\n"
+"#\tuser =3D %s\n"
+"#\temail =3D %s\n"
=20
 #: builtin/config.c:590
-#, fuzzy, c-format
+#, c-format
 msgid "cannot create configuration file %s"
-msgstr "Konnte Archiv-Datei '%s' nicht erstellen."
+msgstr "Konnte Konfigurationsdatei '%s' nicht erstellen."
=20
 #: builtin/count-objects.c:82
 msgid "git count-objects [-v] [-H | --human-readable]"
 msgstr "git count-objects [-v] [-H | --human-readable]"
=20
@@ -5248,11 +5242,11 @@ msgstr "Refspec"
 msgid "Apply refspec to exported refs"
 msgstr "Wendet Refspec auf exportierte Referenzen an"
=20
 #: builtin/fast-export.c:999
 msgid "anonymize output"
-msgstr ""
+msgstr "Ausgabe anonymisieren"
=20
 #: builtin/fetch.c:20
 msgid "git fetch [<options>] [<repository> [<refspec>...]]"
 msgstr "git fetch [<Optionen>] [<Repository> [<Refspec>...]]"
=20
@@ -5561,13 +5555,12 @@ msgstr "verwendet <Text> als Beschreibungsanfan=
g"
 #: builtin/fmt-merge-msg.c:672
 msgid "file to read from"
 msgstr "Datei zum Einlesen"
=20
 #: builtin/for-each-ref.c:676
-#, fuzzy
 msgid "unable to parse format"
-msgstr "Konnte Kontakt '%s' nicht parsen."
+msgstr "Konnte Format nicht parsen."
=20
 #: builtin/for-each-ref.c:1057
 msgid "git for-each-ref [options] [<pattern>]"
 msgstr "git for-each-ref [Optionen] [<Muster>]"
=20
@@ -5666,13 +5659,13 @@ msgstr "Pr=C3=BCfe Objekte"
 #: builtin/gc.c:24
 msgid "git gc [options]"
 msgstr "git gc [Optionen]"
=20
 #: builtin/gc.c:79
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid gc.pruneexpire: '%s'"
-msgstr "Ung=C3=BCltige Referenz: %s"
+msgstr "Ung=C3=BCltiges Wert f=C3=BCr \"gc.pruneexpire\": '%s'"
=20
 #: builtin/gc.c:107
 #, c-format
 msgid "insanely long object directory %.*s"
 msgstr "zu langes Objekt-Verzeichnis %.*s"
@@ -5999,10 +5992,12 @@ msgstr "speichert Datei wie sie ist, ohne Filte=
r"
=20
 #: builtin/hash-object.c:100
 msgid ""
 "just hash any random garbage to create corrupt objects for debugging =
Git"
 msgstr ""
+"Hash =C3=BCber zuf=C3=A4llige Daten, zur Erzeugung von besch=C3=A4dig=
ten Objekten zur\n"
+Fehlersuche in Git, erzeugen"
=20
 #: builtin/hash-object.c:101
 msgid "process file as it were from this path"
 msgstr "verarbeitet Datei, als ob sie von diesem Pfad w=C3=A4re"
=20
@@ -6088,11 +6083,11 @@ msgstr "kein Informations-Betrachter konnte mit=
 dieser Anfrage umgehen"
 msgid "Defining attributes per path"
 msgstr "Definition von Attributen pro Pfad"
=20
 #: builtin/help.c:424
 msgid "Everyday Git With 20 Commands Or So"
-msgstr ""
+msgstr "T=C3=A4gliche Benutzung von Git mit ungef=C3=A4hr 20 Kommandos=
"
=20
 #: builtin/help.c:425
 msgid "A Git glossary"
 msgstr "Ein Git-Glossar"
=20
@@ -6571,35 +6566,37 @@ msgstr "Kann nicht auf Arbeitsverzeichnis '%s' =
zugreifen."
 #: builtin/interpret-trailers.c:15
 msgid ""
 "git interpret-trailers [--trim-empty] [(--trailer <token>[(=3D|:)<val=
ue>])...] "
 "[<file>...]"
 msgstr ""
+"git interpret-trailers [--trim-empty] [(--trailer <Token>[(=3D|:)<Wer=
t>])...] "
+"[<Datei>...]"
=20
 #: builtin/interpret-trailers.c:25
 msgid "trim empty trailers"
-msgstr ""
+msgstr "k=C3=BCrzt leere Anh=C3=A4nge"
=20
 #: builtin/interpret-trailers.c:26
 msgid "trailer"
-msgstr ""
+msgstr "Anhang"
=20
 #: builtin/interpret-trailers.c:27
 msgid "trailer(s) to add"
-msgstr ""
+msgstr "Anhang/Anh=C3=A4nge hinzuf=C3=BCgen"
=20
 #: builtin/log.c:41
 msgid "git log [<options>] [<revision range>] [[--] <path>...]\n"
 msgstr "git log [<Optionen>] [Commitbereich>] [[--] <Pfad>...]\n"
=20
 #: builtin/log.c:42
 msgid "   or: git show [options] <object>..."
 msgstr "   oder: git show [Optionen] <Objekt>..."
=20
 #: builtin/log.c:81
-#, fuzzy, c-format
+#, c-format
 msgid "invalid --decorate option: %s"
-msgstr "Ung=C3=BCltige Option: %s"
+msgstr "Ung=C3=BCltige Option f=C3=BCr --decorate: %s"
=20
 #: builtin/log.c:127
 msgid "suppress diff output"
 msgstr "unterdr=C3=BCckt Ausgabe der Unterschiede"
=20
@@ -6614,23 +6611,22 @@ msgstr "verwendet \"mailmap\"-Datei"
 #: builtin/log.c:130
 msgid "decorate options"
 msgstr "decorate-Optionen"
=20
 #: builtin/log.c:133
-#, fuzzy
 msgid "Process line range n,m in file, counting from 1"
-msgstr "Verarbeitet nur Zeilen im Bereich n,m, gez=C3=A4hlt von 1"
+msgstr "Verarbeitet nur Zeilen im Bereich n,m in der Datei, gez=C3=A4h=
lt von 1"
=20
 #: builtin/log.c:229
 #, c-format
 msgid "Final output: %d %s\n"
 msgstr "letzte Ausgabe: %d %s\n"
=20
 #: builtin/log.c:458
 #, c-format
 msgid "git show %s: bad file"
-msgstr ""
+msgstr "git show %s: ung=C3=BCltige Datei"
=20
 #: builtin/log.c:472 builtin/log.c:564
 #, c-format
 msgid "Could not read object %s"
 msgstr "Kann Objekt %s nicht lesen."
@@ -6915,11 +6911,10 @@ msgstr ""
 #: builtin/ls-files.c:475
 msgid "show files on the filesystem that need to be removed"
 msgstr "zeigt Dateien im Dateisystem, die gel=C3=B6scht werden m=C3=BC=
ssen, an"
=20
 #: builtin/ls-files.c:477
-#, fuzzy
 msgid "show 'other' directories' names only"
 msgstr "zeigt nur Namen von 'sonstigen' Verzeichnissen an"
=20
 #: builtin/ls-files.c:480
 msgid "don't show empty directories"
@@ -7246,30 +7241,28 @@ msgstr "Kein Remote-Tracking-Branch f=C3=BCr %s=
 von %s"
 #: builtin/merge.c:1129
 msgid "There is no merge to abort (MERGE_HEAD missing)."
 msgstr "Es gibt keinen Merge zum Abbrechen (vermisse MERGE_HEAD)"
=20
 #: builtin/merge.c:1145
-#, fuzzy
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren."
=20
 #: builtin/merge.c:1148 git-pull.sh:34
 msgid "You have not concluded your merge (MERGE_HEAD exists)."
 msgstr "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existier=
t)."
=20
 #: builtin/merge.c:1152
-#, fuzzy
 msgid ""
 "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert).\n"
-"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren k=C3=B6nnen."
+"Bitte committen Sie Ihre =C3=84nderungen, bevor Sie \"merge\" ausf=C3=
=BChren."
=20
 #: builtin/merge.c:1155
 msgid "You have not concluded your cherry-pick (CHERRY_PICK_HEAD exist=
s)."
 msgstr ""
 "Sie haben \"cherry-pick\" nicht abgeschlossen (CHERRY_PICK_HEAD exist=
iert)."
@@ -7472,39 +7465,38 @@ msgstr "erlaubt die Erstellung von mehr als ein=
em \"Tree\"-Objekt"
 #: builtin/mv.c:15
 msgid "git mv [options] <source>... <destination>"
 msgstr "git mv [Optionen] <Quelle>... <Ziel>"
=20
 #: builtin/mv.c:69
-#, fuzzy, c-format
+#, c-format
 msgid "Directory %s is in index and no submodule?"
-msgstr "Huh? Verzeichnis %s ist zum Commit vorgemerkt und kein Submodu=
l?"
+msgstr "Verzeichnis %s ist zum Commit vorgemerkt und kein Submodul?"
=20
 #: builtin/mv.c:71
-#, fuzzy
 msgid "Please stage your changes to .gitmodules or stash them to proce=
ed"
 msgstr ""
 "Bitte merken Sie Ihre =C3=84nderungen in .gitmodules zum Commit vor o=
der "
 "benutzen\n"
 "Sie \"stash\", um fortzufahren."
=20
 #: builtin/mv.c:89
-#, fuzzy, c-format
+#, c-format
 msgid "%.*s is in index"
-msgstr "Huh? %.*s ist zum Commit vorgemerkt?"
+msgstr "%.*s ist zum Commit vorgemerkt"
=20
 #: builtin/mv.c:111
 msgid "force move/rename even if target exists"
 msgstr "erzwingt Verschieben/Umbenennen, auch wenn das Ziel existiert"
=20
 #: builtin/mv.c:112
 msgid "skip move/rename errors"
 msgstr "=C3=BCberspringt Fehler beim Verschieben oder Umbenennen"
=20
 #: builtin/mv.c:151
-#, fuzzy, c-format
+#, c-format
 msgid "destination '%s' is not a directory"
-msgstr "%s existiert und ist kein Verzeichnis"
+msgstr "Ziel '%s' ist kein Verzeichnis"
=20
 #: builtin/mv.c:162
 #, c-format
 msgid "Checking rename of '%s' to '%s'\n"
 msgstr "Pr=C3=BCfe Umbenennung von '%s' nach '%s'\n"
@@ -7749,11 +7741,11 @@ msgstr "Entferne Notiz f=C3=BCr Objekt %s\n"
 #: builtin/notes.c:211
 msgid "unable to write note object"
 msgstr "Konnte Notiz-Objekt nicht schreiben"
=20
 #: builtin/notes.c:213
-#, fuzzy, c-format
+#, c-format
 msgid "The note contents have been left in %s"
 msgstr "Die Notiz-Inhalte wurden in %s belassen"
=20
 #: builtin/notes.c:247 builtin/tag.c:693
 #, c-format
@@ -8497,13 +8489,12 @@ msgstr "umgeht \"pre-push hook\""
 #: builtin/push.c:507
 msgid "push missing but relevant tags"
 msgstr "versendet fehlende, aber relevante Tags"
=20
 #: builtin/push.c:509
-#, fuzzy
 msgid "GPG sign the push"
-msgstr "signiert Commit mit GPG"
+msgstr "signiert \"push\" mit GPG"
=20
 #: builtin/push.c:518
 msgid "--delete is incompatible with --all, --mirror and --tags"
 msgstr "Die Option --delete ist inkompatibel mit --all, --mirror und -=
-tags."
=20
@@ -9529,11 +9520,10 @@ msgstr "\"cherry-pick\" fehlgeschlagen"
 #: builtin/rm.c:17
 msgid "git rm [options] [--] <file>..."
 msgstr "git rm [Optionen] [--] [<Datei>...]"
=20
 #: builtin/rm.c:65
-#, fuzzy
 msgid ""
 "the following submodule (or one of its nested submodules)\n"
 "uses a .git directory:"
 msgid_plural ""
 "the following submodules (or one of their nested submodules)\n"
@@ -10251,14 +10241,13 @@ msgstr "schreibt das \"Tree\"-Objekt f=C3=BCr=
 ein Unterverzeichnis <Pr=C3=A4fix>"
 msgid "only useful for debugging"
 msgstr "nur n=C3=BCtzlich f=C3=BCr Fehlersuche"
=20
 #: credential-cache--daemon.c:267
 msgid "print debugging messages to stderr"
-msgstr ""
+msgstr "Meldungen zur Fehlersuche in Standard-Fehlerausgabe ausgeben"
=20
 #: git.c:17
-#, fuzzy
 msgid ""
 "'git help -a' and 'git help -g' list available subcommands and some\n=
"
 "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 "to read about a specific subcommand or concept."
 msgstr ""
@@ -10380,11 +10369,11 @@ msgstr "weniger Ausgaben"
 msgid "use <n> digits to display SHA-1s"
 msgstr "benutze <n> Ziffern zur Anzeige von SHA-1s"
=20
 #: rerere.h:27
 msgid "update the index with reused conflict resolution if possible"
-msgstr ""
+msgstr "Staging-Area, wenn m=C3=B6glich, mit wiederverwendeter Konflik=
taufl=C3=B6sung aktualisieren"
=20
 #: git-am.sh:52
 msgid "You need to set your committer info first"
 msgstr "Sie m=C3=BCssen zuerst die Informationen zum Commit-Ersteller =
setzen."
=20
@@ -10646,21 +10635,19 @@ msgstr "Warnung: bin=C3=A4re Suche nur mit ei=
nem fehlerhaften Commit"
 #: git-bisect.sh:279
 msgid "Are you sure [Y/n]? "
 msgstr "Sind Sie sicher [Y/n]? "
=20
 #: git-bisect.sh:289
-#, fuzzy
 msgid ""
 "You need to give me at least one good and one bad revision.\n"
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
 msgstr ""
 "Sie m=C3=BCssen mindestens einen korrekten und einen fehlerhaften Com=
mit "
 "angeben.\n"
 "(Sie k=C3=B6nnen daf=C3=BCr \"git bisect bad\" und \"git bisect good\=
" benutzen.)"
=20
 #: git-bisect.sh:292
-#, fuzzy
 msgid ""
 "You need to start by \"git bisect start\".\n"
 "You then need to give me at least one good and one bad revision.\n"
 "(You can use \"git bisect bad\" and \"git bisect good\" for that.)"
 msgstr ""
@@ -10730,20 +10717,19 @@ msgstr ""
 #: git-bisect.sh:482
 msgid "bisect run success"
 msgstr "'bisect run' erfolgreich ausgef=C3=BChrt"
=20
 #: git-pull.sh:21
-#, fuzzy
 msgid ""
 "Pull is not possible because you have unmerged files.\n"
 "Please, fix them up in the work tree, and then use 'git add/rm <file>=
'\n"
 "as appropriate to mark resolution and make a commit."
 msgstr ""
 "\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben.\n"
-"Bitte korrigieren Sie dies im Arbeitsverzeichnis und benutzen Sie dan=
n \n"
-"'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu markieren=
, oder\n"
-"benutzen Sie 'git commit -a'."
+"Bitte korrigieren Sie dies im Arbeitsverzeichnis und benutzen Sie dan=
n\n"
+"'git add/rm <Datei>', um die Aufl=C3=B6sung entsprechend zu markieren=
 und zu\n"
+"committen."
=20
 #: git-pull.sh:25
 msgid "Pull is not possible because you have unmerged files."
 msgstr ""
 "\"pull\" ist nicht m=C3=B6glich, weil Sie nicht zusammengef=C3=BChrte=
 Dateien haben."
@@ -11015,11 +11001,11 @@ msgstr "Kein \"stash\" gefunden."
 #, sh-format
 msgid "Too many revisions specified: $REV"
 msgstr "Zu viele Commits angegeben: $REV"
=20
 #: git-stash.sh:397
-#, fuzzy, sh-format
+#, sh-format
 msgid "$reference is not a valid reference"
 msgstr "$reference ist keine g=C3=BCltige Referenz"
=20
 #: git-stash.sh:425
 #, sh-format
--=20
2.2.0.rc0.232.g8ec773f
