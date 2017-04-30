Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EB6BA1F829
	for <e@80x24.org>; Sun, 30 Apr 2017 18:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1946090AbdD3SrN (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Apr 2017 14:47:13 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34576 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1427452AbdD3SrI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Apr 2017 14:47:08 -0400
Received: by mail-wr0-f195.google.com with SMTP id 6so12178238wrb.1
        for <git@vger.kernel.org>; Sun, 30 Apr 2017 11:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjLBuPVuJYRoG8epw+rU/kd4Wv2iLCLB4BkiOi8SWao=;
        b=SI5fL5WKW/DF1bWskSP4yXujQf+yaJ7tYz7cMYrKeV31IwmH3fynZA64Zquxedo8kc
         eeqsk9Vr7SaC5mt9rSJfXlPff2m2lXyG2JysZHcWa7IiaUW/CSgtiONUUxyO9bNh6btd
         6mAHYhxxcsEcSudCmNjnQKZo56w5zbrEzwovLVVDTFBK9ILXngCIvxqx/+RAkhhOvLSu
         gPCqZ+Zd+z/FfU8V4xa3M5ekAZvxela/pcfRCHXDsUQT2/WOCHYXKLcHqgJ82z/zIEoF
         CaPVaCHprWHc2di8y4vev3h8+ro1q+WLdou5Od6cjCCzc6u0WB2Mr7qHrQB1ssgY+f4F
         K1PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MjLBuPVuJYRoG8epw+rU/kd4Wv2iLCLB4BkiOi8SWao=;
        b=gzls4Yy5iimfaOcOJp/IjapI+vIkuEjv/32bFqJs2w1w94nWjeaWbh22dsiDcV4Y6B
         BPeKuiwbUCHDNsTzuOv+7GgXbbpRu/PDsLomVCipE1ZbDpwYvNEsLkehp2p1HLyXq7Mp
         msKjj+nOxvkkRR13MX1wzjFio9gMfTLVuZ09TKYpgqmd64h0ItN607g0qchKPZcc5lpm
         5LdCPJm/5q51fkgu5B0Rhc+oh8xkkEXwa7gcUH1Dv96YqOUjRVMqAH99ts3564omfpAe
         ddse43o8dPdGQCU5plifpmQPf9pjemnzXA4j4inAL8NS+lyAs8vbCCDqQ2xoiw+xCJR0
         QxDQ==
X-Gm-Message-State: AN3rC/6CvWAlQWKSvT5TGLCEzjRxXJXYsALF7wiUdacSnwGAffZRtXLq
        hxjEXl6KoYb+mKv5
X-Received: by 10.223.162.219 with SMTP id t27mr13913999wra.28.1493578026235;
        Sun, 30 Apr 2017 11:47:06 -0700 (PDT)
Received: from localhost (cable-86-56-21-109.cust.telecolumbus.net. [86.56.21.109])
        by smtp.gmail.com with ESMTPSA id i199sm13374245wmf.33.2017.04.30.11.47.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Apr 2017 11:47:05 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: update German translation
Date:   Sun, 30 Apr 2017 20:47:02 +0200
Message-Id: <20170430184702.17351-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.13.0.rc0.207.gb44265493
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 96 new messages came from git.pot update in dfc182b (l10n:
git.pot: v2.13.0 round 1 (96 new, 37 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 309 +++++++++++++++++++++++++++------------------------------------
 1 file changed, 134 insertions(+), 175 deletions(-)

diff --git a/po/de.po b/po/de.po
index e2d15c4aa..14289e564 100644
--- a/po/de.po
+++ b/po/de.po
@@ -866,9 +866,9 @@ msgid "Argument not supported for format '%s': -%d"
 msgstr "Argument für Format '%s' nicht unterstützt: -%d"
 
 #: attr.c:212
-#, fuzzy, c-format
+#, c-format
 msgid "%.*s is not a valid attribute name"
-msgstr "'%s' ist kein gültiger Name für ein Remote-Repository"
+msgstr "%.*s ist kein gültiger Attributname"
 
 #: attr.c:408
 msgid ""
@@ -1260,6 +1260,8 @@ msgstr "Speicher verbraucht"
 #: config.c:191
 msgid "relative config include conditionals must come from files"
 msgstr ""
+"Bedingungen für das Einbinden von Konfigurationen aus relativen Pfaden muss\n"
+"aus Dateien kommen."
 
 #: config.c:701
 #, c-format
@@ -1379,12 +1381,12 @@ msgstr "Ungültiger %s: '%s'"
 #: config.c:1952
 #, c-format
 msgid "unknown core.untrackedCache value '%s'; using 'keep' default value"
-msgstr ""
+msgstr "Unbekannter Wert '%s' in core.untrackedCache; benutze Stardardwert 'keep'"
 
 #: config.c:1978
 #, c-format
 msgid "splitIndex.maxPercentChange value '%d' should be between 0 and 100"
-msgstr ""
+msgstr "Der Wert '%d' von splitIndex.maxPercentChange sollte zwischen 0 und 100 liegen."
 
 #: config.c:1989
 #, c-format
@@ -1645,9 +1647,9 @@ msgstr ""
 "für dieses Verzeichnis deaktiviert."
 
 #: dir.c:2776 dir.c:2781
-#, fuzzy, c-format
+#, c-format
 msgid "could not create directories for %s"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte Verzeichnisse für '%s' nicht erstellen."
 
 #: dir.c:2806
 #, c-format
@@ -1655,9 +1657,9 @@ msgid "could not migrate git directory from '%s' to '%s'"
 msgstr "Konnte Git-Verzeichnis nicht von '%s' nach '%s' migrieren."
 
 #: entry.c:280
-#, fuzzy, c-format
+#, c-format
 msgid "could not stat file '%s'"
-msgstr "konnte Datei '%s' nicht erstellen"
+msgstr "konnte Datei '%s' nicht lesen"
 
 #: fetch-pack.c:249
 msgid "git fetch-pack: expected shallow list"
@@ -1827,14 +1829,14 @@ msgid "no matching remote head"
 msgstr "kein übereinstimmender Remote-Branch"
 
 #: fetch-pack.c:1147
-#, fuzzy, c-format
+#, c-format
 msgid "no such remote ref %s"
-msgstr "Kein solches Remote-Repository: %s"
+msgstr "keine solche Remote-Referenz %s"
 
 #: fetch-pack.c:1150
 #, c-format
 msgid "Server does not allow request for unadvertised object %s"
-msgstr ""
+msgstr "Der Server erlaubt keine Anfrage für nicht angebotenes Objekt %s."
 
 #: gpg-interface.c:185
 msgid "gpg failed to sign the data"
@@ -1961,31 +1963,31 @@ msgstr ""
 
 #: ident.c:367
 msgid "no email was given and auto-detection is disabled"
-msgstr ""
+msgstr "keine E-Mail angegeben und automatische Erkennung ist deaktiviert"
 
 #: ident.c:372
-#, fuzzy, c-format
+#, c-format
 msgid "unable to auto-detect email address (got '%s')"
-msgstr "Fehler: konnte keine gültige Adresse aus %s extrahieren\n"
+msgstr "Konnte die E-Mail-Adresse nicht automatisch erkennen ('%s' erhalten)"
 
 #: ident.c:382
 msgid "no name was given and auto-detection is disabled"
-msgstr ""
+msgstr "kein Name angegeben und automatische Erkennung ist deaktiviert"
 
 #: ident.c:388
-#, fuzzy, c-format
+#, c-format
 msgid "unable to auto-detect name (got '%s')"
-msgstr "konnte \"Tree\"-Objekt (%s) nicht lesen"
+msgstr "konnte Namen nicht automatisch erkennen ('%s' erhalten)"
 
 #: ident.c:396
 #, c-format
 msgid "empty ident name (for <%s>) not allowed"
-msgstr ""
+msgstr "Leerer Name in Identifikation (für <%s>) nicht erlaubt."
 
 #: ident.c:402
 #, c-format
 msgid "name consists only of disallowed characters: %s"
-msgstr ""
+msgstr "Name besteht nur aus nicht erlaubten Zeichen: %s"
 
 #: ident.c:417 builtin/commit.c:611
 #, c-format
@@ -2102,13 +2104,11 @@ msgstr ""
 "im Arbeitsbereich gelassen."
 
 #: merge-recursive.c:1097
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s to %s in %s. Version %s of %s "
 "left in tree."
-msgstr ""
-"KONFLIKT (%s/löschen): %s gelöscht in %s und %s in %s. Stand %s von %s wurde "
-"im Arbeitsbereich gelassen."
+msgstr "KONFLIKT (%s/löschen): %s gelöscht in %s und %s nach %s in %s. Stand %s von %s wurde im Arbeitsbereich gelassen."
 
 #: merge-recursive.c:1104
 #, c-format
@@ -2120,13 +2120,11 @@ msgstr ""
 "im Arbeitsbereich bei %s gelassen."
 
 #: merge-recursive.c:1109
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s to %s in %s. Version %s of %s "
 "left in tree at %s."
-msgstr ""
-"KONFLIKT (%s/löschen): %s gelöscht in %s und %s in %s. Stand %s von %s wurde "
-"im Arbeitsbereich bei %s gelassen."
+msgstr "KONFLIKT (%s/löschen): %s gelöscht in %s und %s nach %s in %s. Stand %s von %s wurde im Arbeitsbereich bei %s gelassen."
 
 #: merge-recursive.c:1143
 msgid "rename"
@@ -2371,21 +2369,20 @@ msgstr "Konnte Gruppenschreibrecht für %s nicht setzen."
 
 #: pathspec.c:125
 msgid "Escape character '\\' not allowed as last character in attr value"
-msgstr ""
+msgstr "Escape-Zeichen '\\' als letztes Zeichen in Attributwert nicht erlaubt"
 
 #: pathspec.c:143
-#, fuzzy
 msgid "Only one 'attr:' specification is allowed."
-msgstr "nur eine -F oder -m Option ist erlaubt."
+msgstr "Es ist nur eine Angabe von 'attr:' erlaubt."
 
 #: pathspec.c:146
 msgid "attr spec must not be empty"
-msgstr ""
+msgstr "Angabe von 'attr:' darf nicht leer sein"
 
 #: pathspec.c:189
-#, fuzzy, c-format
+#, c-format
 msgid "invalid attribute name %s"
-msgstr "Ungültige Identifikationszeile: %s"
+msgstr "Ungültiger Attributname %s"
 
 #: pathspec.c:254
 msgid "global 'glob' and 'noglob' pathspec settings are incompatible"
@@ -2483,17 +2480,17 @@ msgstr ""
 "Verwende Version %i"
 
 #: read-cache.c:2232
-#, fuzzy, c-format
+#, c-format
 msgid "could not stat '%s"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen."
 
 #: read-cache.c:2245
-#, fuzzy, c-format
+#, c-format
 msgid "unable to open git dir: %s"
-msgstr "konnte %s nicht öffnen: %s\n"
+msgstr "konnte Git-Verzeichnis nicht öffnen: %s"
 
 #: read-cache.c:2257
-#, fuzzy, c-format
+#, c-format
 msgid "unable to unlink: %s"
 msgstr "Konnte '%s' nicht entfernen."
 
@@ -2522,19 +2519,19 @@ msgid "gone"
 msgstr "entfernt"
 
 #: ref-filter.c:36
-#, fuzzy, c-format
+#, c-format
 msgid "ahead %d"
-msgstr "[%d voraus]"
+msgstr "%d voraus"
 
 #: ref-filter.c:37
-#, fuzzy, c-format
+#, c-format
 msgid "behind %d"
-msgstr "[%d hinterher]"
+msgstr "%d hinterher"
 
 #: ref-filter.c:38
-#, fuzzy, c-format
+#, c-format
 msgid "ahead %d, behind %d"
-msgstr "[%d voraus, %d hinterher]"
+msgstr "%d voraus, %d hinterher"
 
 #: ref-filter.c:104
 #, c-format
@@ -2547,19 +2544,19 @@ msgid "unrecognized color: %%(color:%s)"
 msgstr "nicht erkannte Farbe: %%(color:%s)"
 
 #: ref-filter.c:120
-#, fuzzy, c-format
+#, c-format
 msgid "Integer value expected refname:lstrip=%s"
-msgstr "Positiver Wert erwartet contents:lines=%s"
+msgstr "Positiver Wert erwartet refname:lstrip=%s"
 
 #: ref-filter.c:124
-#, fuzzy, c-format
+#, c-format
 msgid "Integer value expected refname:rstrip=%s"
-msgstr "Positiver Wert erwartet contents:lines=%s"
+msgstr "Positiver Wert erwartet refname:rstrip=%s"
 
 #: ref-filter.c:126
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(%s) argument: %s"
-msgstr "nicht erkanntes %%(align) Argument: %s"
+msgstr "nicht erkanntes %%(%s) Argument: %s"
 
 #: ref-filter.c:166
 #, c-format
@@ -2587,9 +2584,9 @@ msgid "unrecognized %%(contents) argument: %s"
 msgstr "nicht erkanntes %%(contents) Argument: %s"
 
 #: ref-filter.c:214
-#, fuzzy, c-format
+#, c-format
 msgid "positive value expected objectname:short=%s"
-msgstr "Positiver Wert erwartet contents:lines=%s"
+msgstr "Positiver Wert erwartet objectname:short=%s"
 
 #: ref-filter.c:218
 #, c-format
@@ -2622,9 +2619,9 @@ msgid "positive width expected with the %%(align) atom"
 msgstr "Positive Breitenangabe für %%(align) erwartet"
 
 #: ref-filter.c:286
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized %%(if) argument: %s"
-msgstr "nicht erkanntes %%(align) Argument: %s"
+msgstr "nicht erkanntes %%(if) Argument: %s"
 
 #: ref-filter.c:371
 #, c-format
@@ -2637,39 +2634,39 @@ msgid "unknown field name: %.*s"
 msgstr "Unbekannter Feldname: %.*s"
 
 #: ref-filter.c:501
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(if) atom used without a %%(then) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(if) Atom ohne ein %%(then) Atom verwendet"
 
 #: ref-filter.c:561
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(then) atom used without an %%(if) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(then) Atom ohne ein %%(if) Atom verwendet"
 
 #: ref-filter.c:563
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(then) atom used more than once"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(then) Atom mehr als einmal verwendet"
 
 #: ref-filter.c:565
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(then) atom used after %%(else)"
-msgstr "Format: %%(end) Atom fehlt"
+msgstr "format: %%(then) nach %%(else) verwendet"
 
 #: ref-filter.c:591
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(else) atom used without an %%(if) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "format: %%(else) Atom ohne ein %%(if) Atom verwendet"
 
 #: ref-filter.c:593
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(else) atom used without a %%(then) atom"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "Format: %%(else) Atom ohne ein %%(then) Atom verwendet"
 
 #: ref-filter.c:595
-#, fuzzy, c-format
+#, c-format
 msgid "format: %%(else) atom used more than once"
-msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
+msgstr "Format: %%(end) Atom mehr als einmal verwendet"
 
 #: ref-filter.c:608
 #, c-format
@@ -2892,14 +2889,14 @@ msgid "dup2(%d,%d) failed"
 msgstr "dup2(%d,%d) fehlgeschlagen"
 
 #: send-pack.c:150
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse remote unpack status: %s"
-msgstr "Konnte Kontakt '%s' nicht parsen."
+msgstr "Konnte Status des Entpackens der Gegenseite nicht parsen: %s"
 
 #: send-pack.c:152
-#, fuzzy, c-format
+#, c-format
 msgid "remote unpack failed: %s"
-msgstr "Anwendung des Patches fehlgeschlagen: %s:%ld"
+msgstr "Entpacken auf der Gegenseite fehlgeschlagen: %s"
 
 #: send-pack.c:315
 msgid "failed to sign the push certificate"
@@ -3365,9 +3362,9 @@ msgstr ""
 "Sie können jederzeit \"git stash pop\" oder \"git stash drop\" ausführen.\n"
 
 #: sequencer.c:2009
-#, fuzzy, c-format
+#, c-format
 msgid "Stopped at %s...  %.*s\n"
-msgstr "Angehalten bei %s... %.*s"
+msgstr "Angehalten bei %s... %.*s\n"
 
 #: sequencer.c:2036
 #, c-format
@@ -3501,9 +3498,9 @@ msgid "Unable to read current working directory"
 msgstr "Konnte aktuelles Arbeitsverzeichnis nicht lesen."
 
 #: setup.c:1022 setup.c:1028
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot change to '%s'"
-msgstr "Kann nicht in Verzeichnis '%s/..' wechseln"
+msgstr "Kann nicht nach '%s' wechseln."
 
 #: setup.c:1041
 #, c-format
@@ -3642,9 +3639,9 @@ msgid "could not run 'git status in submodule '%s'"
 msgstr "konnte 'git status' in Submodul '%s' nicht ausführen"
 
 #: submodule.c:1343
-#, fuzzy, c-format
+#, c-format
 msgid "submodule '%s' has dirty index"
-msgstr "Submodul '%s' kann Alternative nicht hinzufügen: %s"
+msgstr "Submodul '%s' hat geänderten Index"
 
 #: submodule.c:1601
 #, c-format
@@ -3682,18 +3679,17 @@ msgid "could not recurse into submodule '%s'"
 msgstr "Fehler bei Rekursion in Submodul-Pfad '%s'"
 
 #: submodule.c:1748
-#, fuzzy
 msgid "could not start ls-files in .."
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte 'ls-files' nicht in .. starten"
 
 #: submodule.c:1768
 msgid "BUG: returned path string doesn't match cwd?"
-msgstr ""
+msgstr "FEHLER: zurückgegebene Zeichenkette für Pfad entspricht nicht cwd?"
 
 #: submodule.c:1787
 #, c-format
 msgid "ls-tree returned unexpected return code %d"
-msgstr ""
+msgstr "ls-tree mit unerwartetem Rückgabewert %d beendet"
 
 #: submodule-config.c:380
 #, c-format
@@ -4060,9 +4056,9 @@ msgstr ""
 "%s"
 
 #: unpack-trees.c:170
-#, fuzzy, c-format
+#, c-format
 msgid "Submodule '%s' cannot checkout new HEAD"
-msgstr "Submodul '%s' kann Alternative nicht hinzufügen: %s"
+msgstr "Submodul '%s' kann neuen HEAD nicht auschecken"
 
 #: unpack-trees.c:247
 #, c-format
@@ -4070,9 +4066,9 @@ msgid "Aborting\n"
 msgstr "Abbruch\n"
 
 #: unpack-trees.c:272
-#, fuzzy, c-format
+#, c-format
 msgid "submodule update strategy not supported for submodule '%s'"
-msgstr "konnte Name für Submodul '%s' nicht nachschlagen"
+msgstr "Strategie zur Aktualisierung von Submodulen für Submodul '%s' nicht unterstützt."
 
 #: unpack-trees.c:340
 msgid "Checking out files"
@@ -5441,9 +5437,8 @@ msgid "git branch [<options>] [-r | -a] [--points-at]"
 msgstr "git branch [<Optionen>] [-r | -a] [--points-at]"
 
 #: builtin/branch.c:31
-#, fuzzy
 msgid "git branch [<options>] [-r | -a] [--format]"
-msgstr "git branch [<Optionen>] [-r | -a] [--points-at]"
+msgstr "git branch [<Optionen>] [-r | -a] [--format]"
 
 #: builtin/branch.c:144
 #, c-format
@@ -5618,12 +5613,11 @@ msgstr "auf Remote-Tracking-Branches wirken"
 
 #: builtin/branch.c:564 builtin/branch.c:566
 msgid "print only branches that contain the commit"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur Branches ausgeben, die diesen Commit enthalten"
 
 #: builtin/branch.c:565 builtin/branch.c:567
-#, fuzzy
 msgid "print only branches that don't contain the commit"
-msgstr "nur Branches ausgeben, welche diesen Commit beinhalten"
+msgstr "nur Branches ausgeben, die diesen Commit nicht enthalten"
 
 #: builtin/branch.c:570
 msgid "Specific git-branch actions:"
@@ -6577,9 +6571,8 @@ msgid "setup as shared repository"
 msgstr "als verteiltes Repository einrichten"
 
 #: builtin/clone.c:93 builtin/clone.c:97
-#, fuzzy
 msgid "pathspec"
-msgstr "Pfad"
+msgstr "Pfadspezifikation"
 
 #: builtin/clone.c:93 builtin/clone.c:97
 msgid "initialize submodules in the clone"
@@ -7844,9 +7837,8 @@ msgid "only consider tags matching <pattern>"
 msgstr "nur Tags, die <Muster> entsprechen, betrachten"
 
 #: builtin/describe.c:452
-#, fuzzy
 msgid "do not consider tags matching <pattern>"
-msgstr "nur Tags, die <Muster> entsprechen, betrachten"
+msgstr "keine Tags betrachten, die <Muster> entsprechen"
 
 #: builtin/describe.c:454 builtin/name-rev.c:354
 msgid "show abbreviated commit object as fallback"
@@ -7858,16 +7850,11 @@ msgstr "Kennzeichen"
 
 #: builtin/describe.c:456
 msgid "append <mark> on dirty working tree (default: \"-dirty\")"
-msgstr ""
-"<Kennzeichen> bei geändertem Arbeitsverzeichnis hinzufügen (Standard: \"-"
-"dirty\")"
+msgstr "<Kennzeichen> bei geändertem Arbeitsverzeichnis anhängen (Standard: \"-dirty\")"
 
 #: builtin/describe.c:459
-#, fuzzy
 msgid "append <mark> on broken working tree (default: \"-broken\")"
-msgstr ""
-"<Kennzeichen> bei geändertem Arbeitsverzeichnis hinzufügen (Standard: \"-"
-"dirty\")"
+msgstr "<Kennzeichen> bei defektem Arbeitsverzeichnis anhängen (Standard: \"-broken\")"
 
 #: builtin/describe.c:477
 msgid "--long is incompatible with --abbrev=0"
@@ -7882,9 +7869,8 @@ msgid "--dirty is incompatible with commit-ishes"
 msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
 
 #: builtin/describe.c:551
-#, fuzzy
 msgid "--broken is incompatible with commit-ishes"
-msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
+msgstr "Die Option --broken kann nicht nit Commits verwendet werden."
 
 #: builtin/diff.c:83
 #, c-format
@@ -7925,19 +7911,19 @@ msgid "failed: %d"
 msgstr "fehlgeschlagen: %d"
 
 #: builtin/difftool.c:283
-#, fuzzy, c-format
+#, c-format
 msgid "could not read symlink %s"
 msgstr "konnte symbolische Verknüpfung %s nicht lesen"
 
 #: builtin/difftool.c:285
-#, fuzzy, c-format
+#, c-format
 msgid "could not read symlink file %s"
-msgstr "Konnte Eingabe-Datei '%s' nicht lesen"
+msgstr "Konnte Datei von symbolischer Verknüpfung '%s' nicht lesen."
 
 #: builtin/difftool.c:293
-#, fuzzy, c-format
+#, c-format
 msgid "could not read object %s for symlink %s"
-msgstr "Kann Objekt %s nicht lesen."
+msgstr "Konnte Objekt '%s' für symbolische Verknüpfung '%s' nicht lesen."
 
 #: builtin/difftool.c:383
 msgid ""
@@ -8399,14 +8385,12 @@ msgid "git for-each-ref [--points-at <object>]"
 msgstr "git for-each-ref [--points-at <Objekt>]"
 
 #: builtin/for-each-ref.c:11
-#, fuzzy
 msgid "git for-each-ref [(--merged | --no-merged) [<commit>]]"
-msgstr "git for-each-ref [(--merged | --no-merged) [<Objekt>]]"
+msgstr "git for-each-ref [(--merged | --no-merged) [<Commit>]]"
 
 #: builtin/for-each-ref.c:12
-#, fuzzy
 msgid "git for-each-ref [--contains [<commit>]] [--no-contains [<commit>]]"
-msgstr "git for-each-ref [--contains [<Objekt>]]"
+msgstr "git for-each-ref [--contains [<Objekt>]] [--no-contains [<Commit>]]"
 
 #: builtin/for-each-ref.c:27
 msgid "quote placeholders suitably for shells"
@@ -8445,9 +8429,8 @@ msgid "print only refs which contain the commit"
 msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
 
 #: builtin/for-each-ref.c:46
-#, fuzzy
 msgid "print only refs which don't contain the commit"
-msgstr "nur Referenzen ausgeben, die diesen Commit enthalten"
+msgstr "nur Referenzen ausgeben, die diesen nicht Commit enthalten"
 
 #: builtin/fsck.c:554
 msgid "Checking object directories"
@@ -8514,9 +8497,9 @@ msgid "git gc [<options>]"
 msgstr "git gc [<Optionen>]"
 
 #: builtin/gc.c:78
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to fstat %s: %s"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen: %s"
 
 #: builtin/gc.c:150
 #, c-format
@@ -8524,9 +8507,9 @@ msgid "insanely long object directory %.*s"
 msgstr "zu langes Objekt-Verzeichnis %.*s"
 
 #: builtin/gc.c:312
-#, fuzzy, c-format
+#, c-format
 msgid "Can't stat %s"
-msgstr "Kann '%s' nicht lesen"
+msgstr "Kann '%s' nicht lesen."
 
 #: builtin/gc.c:321
 #, c-format
@@ -8563,9 +8546,9 @@ msgstr ""
 "\"git gc\" bereits ausgeführt wird"
 
 #: builtin/gc.c:381
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to parse gc.logexpiry value %s"
-msgstr "konnte Standard-Farbwert nicht parsen"
+msgstr "Fehler beim Parsen des Wertes '%s' von gc.logexpiry"
 
 #: builtin/gc.c:409
 #, c-format
@@ -8647,7 +8630,6 @@ msgid "ignore files specified via '.gitignore'"
 msgstr "Dateien, die über '.gitignore' angegeben sind, ignorieren"
 
 #: builtin/grep.c:988
-#, fuzzy
 msgid "recursively search in each submodule"
 msgstr "rekursive Suche in jedem Submodul"
 
@@ -8824,16 +8806,13 @@ msgid "no pattern given."
 msgstr "keine Muster angegeben"
 
 #: builtin/grep.c:1189
-#, fuzzy
 msgid "--no-index or --untracked cannot be used with revs"
-msgstr ""
-"Die Optionen --no-index und --untracked können nicht mit Commits verwendet "
-"werden."
+msgstr "--no-index oder --untracked können nicht mit Commits verwendet werden"
 
 #: builtin/grep.c:1195
-#, fuzzy, c-format
+#, c-format
 msgid "unable to resolve revision: %s"
-msgstr "Konnte %s nicht nach %s verschieben"
+msgstr "Konnte Commit nicht auflösen: %s"
 
 #: builtin/grep.c:1228 builtin/index-pack.c:1481
 #, c-format
@@ -10637,9 +10616,8 @@ msgid "only use refs matching <pattern>"
 msgstr "nur Referenzen verwenden die <Muster> entsprechen"
 
 #: builtin/name-rev.c:348
-#, fuzzy
 msgid "ignore refs matching <pattern>"
-msgstr "nur Referenzen verwenden die <Muster> entsprechen"
+msgstr "ignoriere Referenzen die <Muster> entsprechen"
 
 #: builtin/name-rev.c:350
 msgid "list all commits reachable from all refs"
@@ -11879,18 +11857,16 @@ msgid "debug unpack-trees"
 msgstr "unpack-trees protokollieren"
 
 #: builtin/rebase--helper.c:7
-#, fuzzy
 msgid "git rebase--helper [<options>]"
-msgstr "git repack [<Optionen>]"
+msgstr "git rebase--helper [<Optionen>]"
 
 #: builtin/rebase--helper.c:19
 msgid "continue rebase"
-msgstr ""
+msgstr "Rebase fortsetzen"
 
 #: builtin/rebase--helper.c:21
-#, fuzzy
 msgid "abort rebase"
-msgstr "Merge von Notizen abbrechen"
+msgstr "Rebase abbrechen"
 
 #: builtin/receive-pack.c:27
 msgid "git receive-pack <git-dir>"
@@ -12880,13 +12856,12 @@ msgid "edit the commit message"
 msgstr "Commit-Beschreibung bearbeiten"
 
 #: builtin/revert.c:105
-#, fuzzy
 msgid "parent-number"
 msgstr "Nummer des Elternteils"
 
 #: builtin/revert.c:106
 msgid "select mainline parent"
-msgstr ""
+msgstr "Elternteil der Hauptlinie auswählen"
 
 #: builtin/revert.c:108
 msgid "merge strategy"
@@ -13301,6 +13276,8 @@ msgid ""
 "could not lookup configuration '%s'. Assuming this repository is its own "
 "authoritative upstream."
 msgstr ""
+"Konnte Konfiguration '%s' nicht nachschlagen. Nehme an, dass dieses Repository\n"
+"sein eigenes verbindliches Upstream-Repository ist."
 
 #: builtin/submodule--helper.c:406
 #, c-format
@@ -13540,13 +13517,12 @@ msgid "git tag -d <tagname>..."
 msgstr "git tag -d <Tagname>..."
 
 #: builtin/tag.c:25
-#, fuzzy
 msgid ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--"
 "points-at <object>]\n"
 "\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"
 msgstr ""
-"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>]\n"
+"git tag -l [-n[<Nummer>]] [--contains <Commit>] [--no-contains <Commit>] [--points-at <Objekt>]\n"
 "\t\t[--format=<Muster>] [--[no-]merged [<Commit>]] [<Muster>...]"
 
 #: builtin/tag.c:27
@@ -13623,32 +13599,27 @@ msgstr "Die Tag-Beschreibung wurde gelassen in %s\n"
 
 #: builtin/tag.c:318
 msgid "tag: tagging "
-msgstr ""
+msgstr "Tag: tagge "
 
 #: builtin/tag.c:326
-#, fuzzy
 msgid "object of unknown type"
-msgstr "Art des Objektes"
+msgstr "Art des Objektes unbekannt"
 
 #: builtin/tag.c:333
-#, fuzzy
 msgid "commit object"
-msgstr "Fehler in Objekt"
+msgstr "Commit-Objekt"
 
 #: builtin/tag.c:341
-#, fuzzy
 msgid "tree object"
-msgstr "Objekt"
+msgstr "Tree-Objekt"
 
 #: builtin/tag.c:344
-#, fuzzy
 msgid "blob object"
-msgstr "Objekt"
+msgstr "Blob-Objekt"
 
 #: builtin/tag.c:347
-#, fuzzy
 msgid "other tag object"
-msgstr "zu kurzes Tree-Objekt"
+msgstr "anderes Tree-Objekt"
 
 #: builtin/tag.c:403
 msgid "list tag names"
@@ -13707,9 +13678,8 @@ msgid "print only tags that contain the commit"
 msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
 
 #: builtin/tag.c:427 builtin/tag.c:429
-#, fuzzy
 msgid "print only tags that don't contain the commit"
-msgstr "nur Tags ausgeben, die diesen Commit beinhalten"
+msgstr "nur Tags ausgeben, die diesen nicht Commit enthalten"
 
 #: builtin/tag.c:430
 msgid "print only tags that are merged"
@@ -13728,29 +13698,24 @@ msgid "--column and -n are incompatible"
 msgstr "--column und -n sind inkompatibel"
 
 #: builtin/tag.c:497
-#, fuzzy
 msgid "-n option is only allowed in list mode"
-msgstr "-n Option ist nur erlaubt mit -l."
+msgstr "-n Option ist nur im Listenmodus erlaubt"
 
 #: builtin/tag.c:499
-#, fuzzy
 msgid "--contains option is only allowed in list mode"
-msgstr "--contains Option ist nur erlaubt mit -l."
+msgstr "--contains Option ist nur im Listenmodus erlaubt"
 
 #: builtin/tag.c:501
-#, fuzzy
 msgid "--no-contains option is only allowed in list mode"
-msgstr "--contains Option ist nur erlaubt mit -l."
+msgstr "--no-contains Option ist nur im Listenmodus erlaubt"
 
 #: builtin/tag.c:503
-#, fuzzy
 msgid "--points-at option is only allowed in list mode"
-msgstr "--points-at Option ist nur erlaubt mit -l."
+msgstr "--points-at Option ist nur im Listenmodus erlaubt"
 
 #: builtin/tag.c:505
-#, fuzzy
 msgid "--merged and --no-merged options are only allowed in list mode"
-msgstr "Die Optionen --merged und --no-merged sind nur mit -l erlaubt."
+msgstr "Die Optionen --merged und --no-merged sind nur im Listenmodus erlaubt."
 
 #: builtin/tag.c:516
 msgid "only one -F or -m option is allowed."
@@ -13977,23 +13942,20 @@ msgstr ""
 "Cache für unversionierte Dateien ohne Prüfung des Dateisystems aktivieren"
 
 #: builtin/update-index.c:1107
-#, fuzzy
 msgid ""
 "core.splitIndex is set to false; remove or change it, if you really want to "
 "enable split index"
 msgstr ""
-"core.untrackedCache ist auf 'false' gesetzt. Entfernen oder ändern Sie "
-"dies,\n"
-"wenn sie wirklich den Cache für unversionierte Dateien aktivieren möchten."
+"core.splitIndex ist auf 'false' gesetzt. Entfernen oder ändern Sie dies,\n"
+"wenn sie wirklich das Splitting des Index aktivieren möchten."
 
 #: builtin/update-index.c:1116
-#, fuzzy
 msgid ""
 "core.splitIndex is set to true; remove or change it, if you really want to "
 "disable split index"
 msgstr ""
-"core.untrackedCache ist auf 'true' gesetzt. Entfernen oder ändern Sie dies,\n"
-"wenn Sie wirklich den Cache für unversionierte Dateien deaktivieren möchten."
+"core.splitIndex ist auf 'true' gesetzt. Entfernen oder ändern Sie dies,\n"
+"wenn Sie wirklich das Splitting des Index deaktivieren möchten."
 
 #: builtin/update-index.c:1127
 msgid ""
@@ -16270,7 +16232,6 @@ msgstr "Diff überprüfen"
 #. TRANSLATORS: please do not translate the command names
 #. 'status', 'update', 'revert', etc.
 #: git-add--interactive.perl:1668
-#, fuzzy
 msgid ""
 "status        - show paths with changes\n"
 "update        - add working tree state to the staged set of changes\n"
@@ -16281,12 +16242,10 @@ msgid ""
 "changes\n"
 msgstr ""
 "status        - Pfade mit Änderungen anzeigen\n"
-"update        - Zustand des Arbeitsverzeichnisses den zum Commit "
-"vorgemerkten Änderungen hinzufügen\n"
-"revert        - zum Commit vorgemerkten Änderungen auf HEAD Version "
-"zurücksetzen\n"
+"update        - Zustand des Arbeitsverzeichnisses den zum Commit vorgemerkten Änderungen hinzufügen\n"
+"revert        - zum Commit vorgemerkte Änderungen auf HEAD Version zurücksetzen\n"
 "patch         - Patch-Blöcke auswählen und selektiv aktualisieren\n"
-"diff\t      - Unterschiede zwischen HEAD und Index anzeigen\n"
+"diff          - Unterschiede zwischen HEAD und Index anzeigen\n"
 "add untracked - Inhalte von unversionierten Dateien zum Commit vormerken\n"
 
 #: git-add--interactive.perl:1685 git-add--interactive.perl:1690
-- 
2.13.0.rc0.207.gb44265493

