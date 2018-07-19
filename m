Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 289F21F597
	for <e@80x24.org>; Thu, 19 Jul 2018 17:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732003AbeGSR7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 13:59:35 -0400
Received: from mail-ed1-f50.google.com ([209.85.208.50]:37164 "EHLO
        mail-ed1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbeGSR7f (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 13:59:35 -0400
Received: by mail-ed1-f50.google.com with SMTP id b10-v6so7655655eds.4
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 10:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4u6qv6E26a+CGgxaj++7J+MsP0izaAL+nyT7XA8C3g=;
        b=OznjlNSx+wgdk8IOUM6sdt9ahMq8PbZS7VDP6EoxIu4nt98/PyGCnUOwHkMBgIlYJV
         NjZEC5OxZyYAKyRfMr9ceQnVCJA34Pp6qLUAjhuEaJAToMIfGecsnvjYY5dsFEardaPf
         9ihpkTTj/1LbpfTIstoI9VpqpvSAtt/lAFirsbo5g+ErJ2RZD7z8RLRVO8RQ3PUB3So1
         s6HcdshXDHgc73WzEp+/pUBPZtC5AFX+xrok9jeLbaLtB89JEFUc4DoZ5HwMevP39s05
         6AJUkn5iWZEe81GSCeKDlhwimPrNUltDOabQD54AiSV+CqWjYouKjCgyJnqGD8LszNVH
         XqhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=U4u6qv6E26a+CGgxaj++7J+MsP0izaAL+nyT7XA8C3g=;
        b=qqULoZ0/UQmY+PonEZSIBCHt5YDlxFfnFeOpwwE1BhY+0biDptwfFjn7kk/QsMTTpN
         kZcfsNW9g1xypfVkoBbUQ4d7Vega89uDFIMDuSBm6m/lEE+rLcqIxZh3nG52kjCMmGmW
         uL0wFn/qlUMwxpeaOdQeylfNL0YWh7JKP64M2ce+OJfFIKPwdGtXa2hazKinc0kJSajm
         pkSYt/QZ388eQBOilQ4K5dD0oq1gERLyjbCjFfP6elr4EI7/WrqDmv7+mtiWmmsiiTxp
         bWmwzU15bLU0yc+0QmiQ7ahs6FY1MkTDLYQEytXNABT4p04Za9nCD7Up3L6pG+V8PF9u
         XTtw==
X-Gm-Message-State: AOUpUlEaPpUQAYHRcDwDz3iIn/eq2kdMuZWdhAG0F6synaAZ2QrdXRK5
        a0z72pekVKI2xn5iESv8JF8=
X-Google-Smtp-Source: AAOMgpd76IQU0BNqnr6DQNgP27EF5AEDlOMTpYC+mERbIzVru5DtE4vb3msMDnTSrawY2KM8u9wUOA==
X-Received: by 2002:a50:90e7:: with SMTP id d36-v6mr11883537eda.279.1532020523176;
        Thu, 19 Jul 2018 10:15:23 -0700 (PDT)
Received: from localhost (cable-158-181-67-181.cust.telecolumbus.net. [158.181.67.181])
        by smtp.gmail.com with ESMTPSA id x11-v6sm15597edb.39.2018.07.19.10.15.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jul 2018 10:15:21 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Phillip Szelat <phillip.szelat@gmail.com>
Cc:     git@vger.kernel.org, Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] l10n: de.po: translate 108 new messages
Date:   Thu, 19 Jul 2018 19:15:12 +0200
Message-Id: <20180719171512.11039-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 108 new messages came from git.pot update in 9b7388a85 (l10n:
git.pot: v2.18.0 round 1 (108 new, 14 removed)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 373 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 194 insertions(+), 179 deletions(-)

diff --git a/po/de.po b/po/de.po
index bdc5830e1..47986814c 100644
--- a/po/de.po
+++ b/po/de.po
@@ -10,25 +10,25 @@ msgstr ""
 "POT-Creation-Date: 2018-05-31 23:32+0800\n"
 "PO-Revision-Date: 2016-11-28 18:10+0100\n"
 "Last-Translator: Ralf Thielow <ralf.thielow@gmail.com>\n"
 "Language-Team: German <>\n"
 "Language: de\n"
 "MIME-Version: 1.0\n"
 "Content-Type: text/plain; charset=UTF-8\n"
 "Content-Transfer-Encoding: 8bit\n"
 "Plural-Forms: nplurals=2; plural=(n!=1);\n"
 
 #: advice.c:92
-#, fuzzy, c-format
+#, c-format
 msgid "%shint: %.*s%s\n"
-msgstr "Hinweis: %.*s\n"
+msgstr "%sHinweis: %.*s%s\n"
 
 #: advice.c:137
 msgid "Cherry-picking is not possible because you have unmerged files."
 msgstr ""
 "Cherry-Picken ist nicht möglich, weil Sie nicht zusammengeführte Dateien "
 "haben."
 
 #: advice.c:139
 msgid "Committing is not possible because you have unmerged files."
 msgstr ""
 "Committen ist nicht möglich, weil Sie nicht zusammengeführte Dateien haben."
@@ -1284,44 +1284,52 @@ msgstr "%s %s ist kein Commit!"
 #: commit.c:182
 msgid ""
 "Support for <GIT_DIR>/info/grafts is deprecated\n"
 "and will be removed in a future Git version.\n"
 "\n"
 "Please use \"git replace --convert-graft-file\"\n"
 "to convert the grafts into replace refs.\n"
 "\n"
 "Turn this message off by running\n"
 "\"git config advice.graftFileDeprecated false\""
 msgstr ""
+"Die Unterstützung für <GIT_DIR>/info/grafts ist veraltet\n"
+"und wird in zukünftigen Git Versionen entfernt.\n"
+"\n"
+"Bitte benutzen Sie \"git replace --convert-graft-file\"\n"
+"zum Konvertieren der künstlichen Vorgänger (\"grafts\")\n"
+"in ersetzende Referenzen.<\n"
+"\n"
+"Sie können diese Meldung unterdrücken, indem Sie\n"
+"\"git config advice.graftFileDeprecated false\" ausführen."
 
 #: commit.c:1537
 msgid ""
 "Warning: commit message did not conform to UTF-8.\n"
 "You may want to amend it after fixing the message, or set the config\n"
 "variable i18n.commitencoding to the encoding your project uses.\n"
 msgstr ""
 "Warnung: Die Commit-Beschreibung ist nicht UTF-8 konform.\n"
 "Sie können das nachbessern, nachdem Sie die Beschreibung korrigiert haben,\n"
 "oder Sie setzen die Konfigurationsvariable i18n.commitencoding auf das "
 "Encoding,\n"
 "welches von ihrem Projekt verwendet wird.\n"
 
 #: commit-graph.c:669
 #, c-format
 msgid "the commit graph format cannot write %d commits"
-msgstr ""
+msgstr "Das Commit-Graph Format kann nicht %d Commits schreiben."
 
 #: commit-graph.c:696
-#, fuzzy
 msgid "too many commits to write graph"
-msgstr "nur Commits anzeigen, die sich nicht im ersten Branch befinden"
+msgstr "Zu viele Commits zum Schreiben des Graphen."
 
 #: commit-graph.c:707 builtin/init-db.c:516 builtin/init-db.c:521
 #, c-format
 msgid "cannot mkdir %s"
 msgstr "kann Verzeichnis %s nicht erstellen"
 
 #: compat/obstack.c:405 compat/obstack.c:407
 msgid "memory exhausted"
 msgstr "Speicher verbraucht"
 
 #: config.c:187
@@ -1554,56 +1562,61 @@ msgstr "LF würde in %s durch CRLF ersetzt werden."
 msgid ""
 "LF will be replaced by CRLF in %s.\n"
 "The file will have its original line endings in your working directory."
 msgstr ""
 "LF wird in %s durch CRLF ersetzt.\n"
 "Die Datei wird ihre ursprünglichen Zeilenenden im Arbeitsverzeichnis "
 "behalten."
 
 #: convert.c:279
 #, c-format
 msgid "BOM is prohibited in '%s' if encoded as %s"
-msgstr ""
+msgstr "BOM ist in '%s' unzulässig, wenn als %s codiert."
 
 #: convert.c:286
 #, c-format
 msgid ""
 "The file '%s' contains a byte order mark (BOM). Please use UTF-%s as working-"
 "tree-encoding."
 msgstr ""
+"Die Datei '%s' enthält ein Byte-Order-Mark (BOM). Bitte benutzen Sie UTF-%s\n"
+"als Codierung im Arbeitsverzeichnis."
 
 #: convert.c:304
 #, c-format
 msgid "BOM is required in '%s' if encoded as %s"
-msgstr ""
+msgstr "BOM ist erforderlich in '%s', wenn als %s codiert."
 
 #: convert.c:306
 #, c-format
 msgid ""
 "The file '%s' is missing a byte order mark (BOM). Please use UTF-%sBE or UTF-"
 "%sLE (depending on the byte order) as working-tree-encoding."
 msgstr ""
+"Der Datei '%s' fehlt ein Byte-Order-Mark (BOM). Bitte benutzen Sie UTF-%sBE\n"
+"oder UTF-%sLE (abhängig von der Byte-Reihenfolge) als Codierung im\n"
+"Arbeitsverzeichnis."
 
 #: convert.c:424
-#, fuzzy, c-format
+#, c-format
 msgid "failed to encode '%s' from %s to %s"
-msgstr "Fehler beim Kopieren der Notizen von '%s' nach '%s'"
+msgstr "Fehler beim Codieren von '%s' von %s nach %s."
 
 #: convert.c:467
 #, c-format
 msgid "encoding '%s' from %s to %s and back is not the same"
-msgstr ""
+msgstr "Die Codierung '%s' von %s nach %s und zurück ist nicht dasselbe."
 
 #: convert.c:1225
 msgid "true/false are no valid working-tree-encodings"
-msgstr ""
+msgstr "true/false sind keine gültigen Codierungen im Arbeitsverzeichnis."
 
 #: date.c:116
 msgid "in the future"
 msgstr "in der Zukunft"
 
 #: date.c:122
 #, c-format
 msgid "%<PRIuMAX> second ago"
 msgid_plural "%<PRIuMAX> seconds ago"
 msgstr[0] "vor %<PRIuMAX> Sekunde"
 msgstr[1] "vor %<PRIuMAX> Sekunden"
@@ -1970,25 +1983,24 @@ msgid "Server does not support --deepen"
 msgstr "Server unterstützt kein --deepen"
 
 #: fetch-pack.c:1065
 msgid "no common commits"
 msgstr "keine gemeinsamen Commits"
 
 #: fetch-pack.c:1077 fetch-pack.c:1414
 msgid "git fetch-pack: fetch failed."
 msgstr "git fetch-pack: Abholen fehlgeschlagen."
 
 #: fetch-pack.c:1199
-#, fuzzy
 msgid "Server does not support shallow requests"
-msgstr "Server unterstützt keine shallow-Clients"
+msgstr "Server unterstützt keine shallow-Anfragen."
 
 #: fetch-pack.c:1584
 msgid "no matching remote head"
 msgstr "kein übereinstimmender Remote-Branch"
 
 #: fetch-pack.c:1610
 #, c-format
 msgid "no such remote ref %s"
 msgstr "keine solche Remote-Referenz %s"
 
 #: fetch-pack.c:1613
@@ -2212,30 +2224,32 @@ msgstr "Lesen des Zwischenspeichers fehlgeschlagen"
 
 #: merge.c:136 builtin/am.c:1946 builtin/am.c:1980 builtin/checkout.c:378
 #: builtin/checkout.c:606 builtin/clone.c:761
 msgid "unable to write new index file"
 msgstr "Konnte neue Index-Datei nicht schreiben."
 
 #: merge-recursive.c:298
 msgid "(bad commit)\n"
 msgstr "(ungültiger Commit)\n"
 
 #: merge-recursive.c:320
-#, fuzzy, c-format
+#, c-format
 msgid "add_cacheinfo failed for path '%s'; merge aborting."
-msgstr "addinfo_cache für Pfad '%s' fehlgeschlagen"
+msgstr "add_cacheinfo für Pfad '%s' fehlgeschlagen; Merge wird abgebrochen."
 
 #: merge-recursive.c:328
-#, fuzzy, c-format
+#, c-format
 msgid "add_cacheinfo failed to refresh for path '%s'; merge aborting."
-msgstr "addinfo_cache für Pfad '%s' fehlgeschlagen"
+msgstr ""
+"add_cacheinfo zur Aktualisierung für Pfad '%s' fehlgeschlagen;\n"
+"Merge wird abgebrochen."
 
 #: merge-recursive.c:410
 msgid "error building trees"
 msgstr "Fehler beim Erstellen der \"Tree\"-Objekte"
 
 #: merge-recursive.c:881
 #, c-format
 msgid "failed to create path '%s'%s"
 msgstr "Fehler beim Erstellen des Pfades '%s'%s"
 
 #: merge-recursive.c:892
@@ -2270,94 +2284,101 @@ msgstr "Fehler beim Öffnen von '%s': %s"
 #: merge-recursive.c:994
 #, c-format
 msgid "failed to symlink '%s': %s"
 msgstr "Fehler beim Erstellen einer symbolischen Verknüpfung für '%s': %s"
 
 #: merge-recursive.c:999
 #, c-format
 msgid "do not know what to do with %06o %s '%s'"
 msgstr "weiß nicht was mit %06o %s '%s' zu machen ist"
 
 #: merge-recursive.c:1186
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to merge submodule %s (not checked out)"
-msgstr "Fehler beim Eintragen von Submodul '$sm_path' in die Konfiguration."
+msgstr "Fehler beim Merge von Submodul %s (nicht ausgecheckt)."
 
 #: merge-recursive.c:1193
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to merge submodule %s (commits not present)"
-msgstr "Fehler beim Eintragen von Submodul '$sm_path' in die Konfiguration."
+msgstr "Fehler beim Merge von Submodul %s (Commits nicht vorhanden)."
 
 #: merge-recursive.c:1200
 #, c-format
 msgid "Failed to merge submodule %s (commits don't follow merge-base)"
-msgstr ""
+msgstr "Fehler beim Merge von Submodul %s (Commits folgen keiner Merge-Basis)"
 
 #: merge-recursive.c:1208 merge-recursive.c:1220
 #, c-format
 msgid "Fast-forwarding submodule %s to the following commit:"
-msgstr ""
+msgstr "Spule Submodul %s zu dem folgenden Commit vor:"
 
 #: merge-recursive.c:1211 merge-recursive.c:1223
-#, fuzzy, c-format
+#, c-format
 msgid "Fast-forwarding submodule %s to %s"
-msgstr "Spule vor zu $sha1"
+msgstr "Spule Submodul %s vor zu %s"
 
 #: merge-recursive.c:1245
 #, c-format
 msgid "Failed to merge submodule %s (merge following commits not found)"
-msgstr ""
+msgstr "Fehler beim Merge von Submodule %s (dem Merge nachfolgende Commits nicht gefunden)"
 
 #: merge-recursive.c:1249
-#, fuzzy, c-format
+#, c-format
 msgid "Failed to merge submodule %s (not fast-forward)"
-msgstr "Fehler beim Eintragen von Submodul '$sm_path' in die Konfiguration."
+msgstr "Fehler beim Merge von Submodul %s (kein Vorspulen)"
 
 #: merge-recursive.c:1250
 msgid "Found a possible merge resolution for the submodule:\n"
-msgstr ""
+msgstr "Mögliche Auflösung des Merges für Submodul gefunden:\n"
 
 #: merge-recursive.c:1253
 #, c-format
 msgid ""
 "If this is correct simply add it to the index for example\n"
 "by using:\n"
 "\n"
 "  git update-index --cacheinfo 160000 %s \"%s\"\n"
 "\n"
 "which will accept this suggestion.\n"
 msgstr ""
+"Falls das korrekt ist, fügen Sie es einfach der Staging-Area, zum Beispiel mit:\n"
+"\n"
+"  git update-index --cacheinfo 160000 %s \"%s\"\n"
+"\n"
+"hinzu, um diesen Vorschlag zu akzeptieren.\n"
 
 #: merge-recursive.c:1262
 #, c-format
 msgid "Failed to merge submodule %s (multiple merges found)"
-msgstr ""
+msgstr "Fehler beim Merge von Submodul %s (mehrere Merges gefunden)"
 
 #: merge-recursive.c:1321
 msgid "Failed to execute internal merge"
 msgstr "Fehler bei Ausführung des internen Merges"
 
 #: merge-recursive.c:1326
 #, c-format
 msgid "Unable to add %s to database"
 msgstr "Konnte %s nicht zur Datenbank hinzufügen"
 
 #: merge-recursive.c:1358
 #, c-format
 msgid "Auto-merging %s"
 msgstr "automatischer Merge von %s"
 
 #: merge-recursive.c:1423
-#, fuzzy, c-format
+#, c-format
 msgid "Error: Refusing to lose untracked file at %s; writing to %s instead."
-msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen würden"
+msgstr ""
+"Fehler: Verweigere unversionierte Datei bei %s zu verlieren;\n"
+"schreibe stattdessen nach %s."
 
 #: merge-recursive.c:1475
 #, c-format
 msgid ""
 "CONFLICT (%s/delete): %s deleted in %s and %s in %s. Version %s of %s left "
 "in tree."
 msgstr ""
 "KONFLIKT (%s/löschen): %s gelöscht in %s und %s in %s. Stand %s von %s wurde "
 "im Arbeitsbereich gelassen."
 
 #: merge-recursive.c:1480
@@ -2389,35 +2410,35 @@ msgstr ""
 
 #: merge-recursive.c:1526
 msgid "rename"
 msgstr "umbenennen"
 
 #: merge-recursive.c:1526
 msgid "renamed"
 msgstr "umbenannt"
 
 #: merge-recursive.c:1580 merge-recursive.c:1736 merge-recursive.c:2368
 #: merge-recursive.c:3086
-#, fuzzy, c-format
+#, c-format
 msgid "Refusing to lose dirty file at %s"
-msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen würden"
+msgstr "Verweigere geänderte Datei bei %s zu verlieren."
 
 #: merge-recursive.c:1594
 #, c-format
 msgid "%s is a directory in %s adding as %s instead"
 msgstr "%s ist ein Verzeichnis in %s, füge es stattdessen als %s hinzu"
 
 #: merge-recursive.c:1599
-#, fuzzy, c-format
+#, c-format
 msgid "Refusing to lose untracked file at %s; adding as %s instead"
-msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen würden"
+msgstr "Verweigere unversionierte Datei bei %s zu verlieren; füge stattdessen %s hinzu"
 
 #: merge-recursive.c:1625
 #, c-format
 msgid ""
 "CONFLICT (rename/rename): Rename \"%s\"->\"%s\" in branch \"%s\" rename \"%s"
 "\"->\"%s\" in \"%s\"%s"
 msgstr ""
 "KONFLIKT (umbenennen/umbenennen): Benenne um \"%s\"->\"%s\" in Branch \"%s\" "
 "und \"%s\"->\"%s\" in Branch \"%s\"%s"
 
 #: merge-recursive.c:1630
@@ -2429,63 +2450,72 @@ msgstr " (bleibt unaufgelöst)"
 msgid "CONFLICT (rename/rename): Rename %s->%s in %s. Rename %s->%s in %s"
 msgstr ""
 "KONFLIKT (umbenennen/umbenennen): Benenne um %s->%s in %s. Benenne um %s->%s "
 "in %s"
 
 #: merge-recursive.c:1733
 #, c-format
 msgid "Renaming %s to %s and %s to %s instead"
 msgstr "Benenne stattdessen %s nach %s und %s nach %s um"
 
 #: merge-recursive.c:1745
-#, fuzzy, c-format
+#, c-format
 msgid "Refusing to lose untracked file at %s, even though it's in the way."
-msgstr "verweigere, da unversionierte Dateien in '%s' verloren gehen würden"
+msgstr "Verweigere unversionierte Datei bei %s zu verlieren, auch wenn diese im Weg ist."
 
 #: merge-recursive.c:1951
 #, c-format
 msgid ""
 "CONFLICT (directory rename split): Unclear where to place %s because "
 "directory %s was renamed to multiple other directories, with no destination "
 "getting a majority of the files."
 msgstr ""
+"KONFLIKT (Aufteilung Verzeichnisumbenennung): Unklar, wo %s zu platzieren ist,\n"
+"weil Verzeichnis %s zu mehreren anderen Verzeichnissen umbenannt wurde, wobei\n"
+"keines dieser Ziele die Mehrheit der Dateien erhielt."
 
 #: merge-recursive.c:1983
 #, c-format
 msgid ""
 "CONFLICT (implicit dir rename): Existing file/dir at %s in the way of "
 "implicit directory rename(s) putting the following path(s) there: %s."
 msgstr ""
+"KONFLIKT (implizite Verzeichnisumbenennung): Existierende Datei/Pfad bei %s im\n"
+"Weg von impliziter Verzeichnisumbenennung, die versucht, einen oder mehrere\n"
+"Pfade dahin zu setzen: %s."
 
 #: merge-recursive.c:1993
 #, c-format
 msgid ""
 "CONFLICT (implicit dir rename): Cannot map more than one path to %s; "
 "implicit directory renames tried to put these paths there: %s"
 msgstr ""
+"KONFLIKT (implizite Verzeichnisumbenennung): Kann nicht mehr als ein Pfad zu\n"
+"%s mappen; implizite Verzeichnisumbenennungen versuchten diese Pfade dahin\n"
+"zu setzen: %s"
 
 #: merge-recursive.c:2085
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "CONFLICT (rename/rename): Rename directory %s->%s in %s. Rename directory %s-"
 ">%s in %s"
 msgstr ""
-"KONFLIKT (umbenennen/umbenennen): Benenne um %s->%s in %s. Benenne um %s->%s "
-"in %s"
+"KONFLIKT (umbenennen/umbenennen): Benenne Verzeichnis um %s->%s in %s.\n"
+"Benenne Verzeichnis um %s->%s in %s"
 
 #: merge-recursive.c:2330
 #, c-format
 msgid ""
 "WARNING: Avoiding applying %s -> %s rename to %s, because %s itself was "
 "renamed."
-msgstr ""
+msgstr "WARNUNG: Vermeide Umbenennung %s -> %s von %s, weil %s selbst umbenannt wurde."
 
 #: merge-recursive.c:2736
 #, c-format
 msgid "CONFLICT (rename/add): Rename %s->%s in %s. %s added in %s"
 msgstr ""
 "KONFLIKT (umbenennen/hinzufügen): Benenne um %s->%s in %s. %s hinzugefügt in "
 "%s"
 
 #: merge-recursive.c:2751
 #, c-format
 msgid "Adding merged %s"
@@ -2682,25 +2712,25 @@ msgstr "      oder: %s"
 
 #: parse-options.c:649
 #, c-format
 msgid "    %s"
 msgstr "    %s"
 
 #: parse-options.c:688
 msgid "-NUM"
 msgstr "-NUM"
 
 #: parse-options-cb.c:44
-#, fuzzy, c-format
+#, c-format
 msgid "malformed expiration date '%s'"
-msgstr "Fehlerhaftes Optionsblatt: '%s'"
+msgstr "Fehlerhaftes Ablaufdatum '%s'"
 
 #: parse-options-cb.c:112
 #, c-format
 msgid "malformed object name '%s'"
 msgstr "fehlerhafter Objekt-Name '%s'"
 
 #: path.c:892
 #, c-format
 msgid "Could not make %s writable by group"
 msgstr "Konnte Gruppenschreibrecht für %s nicht setzen."
 
@@ -3012,25 +3042,25 @@ msgstr "Format: %%(end) Atom ohne zugehöriges Atom verwendet"
 #: ref-filter.c:779
 #, c-format
 msgid "malformed format string %s"
 msgstr "Fehlerhafter Formatierungsstring %s"
 
 #: ref-filter.c:1387
 #, c-format
 msgid "(no branch, rebasing %s)"
 msgstr "(kein Branch, Rebase von Branch %s im Gange)"
 
 #: ref-filter.c:1390
-#, fuzzy, c-format
+#, c-format
 msgid "(no branch, rebasing detached HEAD %s)"
-msgstr "(kein Branch, Rebase von Branch %s im Gange)"
+msgstr "(kein Branch, Rebase von losgelöstem HEAD %s)"
 
 #: ref-filter.c:1393
 #, c-format
 msgid "(no branch, bisect started on %s)"
 msgstr "(kein Branch, binäre Suche begonnen bei %s)"
 
 #. TRANSLATORS: make sure this matches "HEAD
 #. detached at " in wt-status.c
 #.
 #: ref-filter.c:1401
 #, c-format
@@ -3283,25 +3313,25 @@ msgstr "die Gegenseite unterstützt keinen atomaren Versand (\"--atomic push\")"
 
 #: send-pack.c:440
 msgid "the receiving end does not support push options"
 msgstr "die Gegenseite unterstützt keine Push-Optionen"
 
 #: sequencer.c:174
 #, c-format
 msgid "invalid commit message cleanup mode '%s'"
 msgstr "Ungültiger \"cleanup\"-Modus '%s' für Commit-Beschreibungen."
 
 #: sequencer.c:274
-#, fuzzy, c-format
+#, c-format
 msgid "could not delete '%s'"
-msgstr "Konnte %s nicht entfernen"
+msgstr "Konnte '%s' nicht löschen."
 
 #: sequencer.c:300
 msgid "revert"
 msgstr "Revert"
 
 #: sequencer.c:302
 msgid "cherry-pick"
 msgstr "Cherry-Pick"
 
 #: sequencer.c:304
 msgid "rebase -i"
@@ -3414,25 +3444,24 @@ msgstr ""
 "  git commit --amend %s\n"
 "\n"
 "Wenn daraus ein neuer Commit erzeugt werden soll, führen Sie aus:\n"
 "\n"
 "  git commit %s\n"
 "\n"
 "Im Anschluss führen Sie zum Fortfahren aus:\n"
 "\n"
 "  git rebase --continue\n"
 
 #: sequencer.c:817
-#, fuzzy
 msgid "writing root commit"
-msgstr "nichts zu committen\n"
+msgstr "Root-Commit schreiben"
 
 #: sequencer.c:1042
 msgid "'prepare-commit-msg' hook failed"
 msgstr "'prepare-commit-msg' Hook fehlgeschlagen."
 
 #: sequencer.c:1049
 msgid ""
 "Your name and email address were configured automatically based\n"
 "on your username and hostname. Please check that they are accurate.\n"
 "You can suppress this message by setting them explicitly. Run the\n"
 "following command and follow the instructions in your editor to edit\n"
@@ -3588,25 +3617,24 @@ msgstr "Die Commit-Beschreibung #%d wird ausgelassen:"
 
 #: sequencer.c:1552
 #, c-format
 msgid "unknown command: %d"
 msgstr "Unbekannter Befehl: %d"
 
 #: sequencer.c:1630
 msgid "your index file is unmerged."
 msgstr "Ihre Index-Datei ist nicht zusammengeführt."
 
 #: sequencer.c:1637
-#, fuzzy
 msgid "cannot fixup root commit"
-msgstr "kann Commit %s (%s) nicht finden"
+msgstr "kann fixup nicht auf Root-Commit anwenden"
 
 #: sequencer.c:1656
 #, c-format
 msgid "commit %s is a merge but no -m option was given."
 msgstr "Commit %s ist ein Merge, aber die Option -m wurde nicht angegeben."
 
 #: sequencer.c:1664
 #, c-format
 msgid "commit %s does not have parent %d"
 msgstr "Commit %s hat keinen Eltern-Commit %d"
 
@@ -3707,23 +3735,23 @@ msgstr "Kann Revert nicht während eines Cherry-Picks ausführen."
 #, c-format
 msgid "invalid key: %s"
 msgstr "Ungültiger Schlüssel: %s"
 
 #: sequencer.c:2197
 #, c-format
 msgid "invalid value for %s: %s"
 msgstr "Ungültiger Wert für %s: %s"
 
 #: sequencer.c:2268
 msgid "unusable squash-onto"
-msgstr ""
+msgstr "Unbenutzbares squash-onto."
 
 #: sequencer.c:2284
 #, c-format
 msgid "malformed options sheet: '%s'"
 msgstr "Fehlerhaftes Optionsblatt: '%s'"
 
 #: sequencer.c:2322
 msgid "a cherry-pick or revert is already in progress"
 msgstr "\"cherry-pick\" oder \"revert\" ist bereits im Gang"
 
 #: sequencer.c:2323
@@ -3824,69 +3852,65 @@ msgid ""
 "\n"
 msgstr ""
 "Ausführung erfolgreich: %s\n"
 "Aber Änderungen in Index oder Arbeitsverzeichnis verblieben.\n"
 "Committen Sie Ihre Änderungen oder benutzen Sie \"stash\".\n"
 "Führen Sie dann aus:\n"
 "\n"
 "  git rebase --continue\n"
 "\n"
 
 #: sequencer.c:2770
-#, fuzzy
 msgid "writing fake root commit"
-msgstr "nichts zu committen\n"
+msgstr "unechten Root-Commit schreiben"
 
 #: sequencer.c:2775
 msgid "writing squash-onto"
-msgstr ""
+msgstr "squash-onto schreiben"
 
 #: sequencer.c:2810
-#, fuzzy, c-format
+#, c-format
 msgid "failed to find tree of %s"
 msgstr "Fehler beim Finden des \"Tree\"-Objektes von %s."
 
 #: sequencer.c:2828
-#, fuzzy
 msgid "could not write index"
-msgstr "Konnte den Index nicht lesen."
+msgstr "Konnte Index nicht schreiben."
 
 #: sequencer.c:2860
-#, fuzzy
 msgid "cannot merge without a current revision"
-msgstr "Kann '%s' nicht ohne vorherigen Commit ausführen"
+msgstr "Kann nicht ohne einen aktuellen Commit mergen."
 
 #: sequencer.c:2883
-#, fuzzy, c-format
+#, c-format
 msgid "could not resolve '%s'"
-msgstr "Konnte '%s' nicht löschen"
+msgstr "Konnte '%s' nicht auflösen."
 
 #: sequencer.c:2905
-#, fuzzy, c-format
+#, c-format
 msgid "could not get commit message of '%s'"
-msgstr "Konnte Commit-Beschreibung von %s nicht lesen."
+msgstr "Konnte keine Commit-Beschreibung von '%s' bekommen."
 
 #: sequencer.c:2915 sequencer.c:2940
-#, fuzzy, c-format
+#, c-format
 msgid "could not write '%s'"
-msgstr "Konnte nicht nach '%s' schreiben."
+msgstr "Konnte '%s' nicht schreiben."
 
 #: sequencer.c:3004
-#, fuzzy, c-format
+#, c-format
 msgid "could not even attempt to merge '%.*s'"
-msgstr "konnte '%s' nicht öffnen oder lesen"
+msgstr "Konnte nicht einmal versuchen '%.*s' zu mergen."
 
 #: sequencer.c:3020
-#, fuzzy
 msgid "merge: Unable to write new index file"
-msgstr "%s: Konnte neue Index-Datei nicht schreiben"
+msgstr "merge: Konnte neue Index-Datei nicht schreiben."
 
 #: sequencer.c:3087
 #, c-format
 msgid "Applied autostash.\n"
 msgstr "Automatischen Stash angewendet.\n"
 
 #: sequencer.c:3099
 #, c-format
 msgid "cannot store %s"
 msgstr "kann %s nicht speichern"
 
@@ -3905,22 +3929,30 @@ msgstr ""
 #, c-format
 msgid ""
 "Could not execute the todo command\n"
 "\n"
 "    %.*s\n"
 "It has been rescheduled; To edit the command before continuing, please\n"
 "edit the todo list first:\n"
 "\n"
 "    git rebase --edit-todo\n"
 "    git rebase --continue\n"
 msgstr ""
+"Konnte TODO-Befehl nicht ausführen\n"
+"\n"
+"    %.*s\n"
+"Dieser wurde neu angesetzt; Um den Befehl zu bearbeiten, bevor fortgesetzt wird,\n"
+"bearbeiten Sie bitte zuerst die TODO-Liste:\n"
+"\n"
+"    git rebase --edit-todo\n"
+"    git rebase --continue\n"
 
 #: sequencer.c:3201
 #, c-format
 msgid "Stopped at %s...  %.*s\n"
 msgstr "Angehalten bei %s... %.*s\n"
 
 #: sequencer.c:3263
 #, c-format
 msgid "unknown command %d"
 msgstr "Unbekannter Befehl %d"
 
@@ -3961,25 +3993,25 @@ msgstr "Ungültige Inhalte: '%s'"
 msgid ""
 "\n"
 "You have uncommitted changes in your working tree. Please, commit them\n"
 "first and then run 'git rebase --continue' again."
 msgstr ""
 "\n"
 "Sie haben nicht committete Änderungen in Ihrem Arbeitsverzeichnis. Bitte\n"
 "committen Sie diese zuerst und führen Sie dann 'git rebase --continue'\n"
 "erneut aus."
 
 #: sequencer.c:3454 sequencer.c:3492
-#, fuzzy, c-format
+#, c-format
 msgid "could not write file: '%s'"
-msgstr "konnte Datei '%s' nicht erstellen"
+msgstr "Konnte Datei nicht schreiben: '%s'"
 
 #: sequencer.c:3507
 msgid "could not remove CHERRY_PICK_HEAD"
 msgstr "Konnte CHERRY_PICK_HEAD nicht löschen."
 
 #: sequencer.c:3514
 msgid "could not commit staged changes."
 msgstr "Konnte Änderungen aus der Staging-Area nicht committen."
 
 #: sequencer.c:3611
 #, c-format
@@ -4388,25 +4420,25 @@ msgstr "Fehler bei Rekursion in Submodul-Pfad '%s'"
 
 #: submodule.c:1863
 msgid "could not start ls-files in .."
 msgstr "Konnte 'ls-files' nicht in .. starten"
 
 #: submodule.c:1902
 #, c-format
 msgid "ls-tree returned unexpected return code %d"
 msgstr "ls-tree mit unerwartetem Rückgabewert %d beendet"
 
 #: submodule-config.c:230
-#, fuzzy, c-format
+#, c-format
 msgid "ignoring suspicious submodule name: %s"
-msgstr "Ignoriere Referenz mit fehlerhaftem Namen %s"
+msgstr "Ignoriere verdächtigen Submodulnamen: %s"
 
 #: submodule-config.c:294
 msgid "negative values not allowed for submodule.fetchjobs"
 msgstr "Negative Werte für submodule.fetchjobs nicht erlaubt."
 
 #: submodule-config.c:467
 #, c-format
 msgid "invalid value for %s"
 msgstr "Ungültiger Wert für %s"
 
 #: trailer.c:238
@@ -4466,25 +4498,24 @@ msgstr "konnte temporäre Datei nicht zu %s umbenennen"
 #: transport.c:116
 #, c-format
 msgid "Would set upstream of '%s' to '%s' of '%s'\n"
 msgstr "Würde Upstream-Branch von '%s' zu '%s' von '%s' setzen\n"
 
 #: transport.c:208
 #, c-format
 msgid "transport: invalid depth option '%s'"
 msgstr "transport: ungültige --depth Option '%s'"
 
 #: transport.c:584
-#, fuzzy
 msgid "could not parse transport.color.* config"
-msgstr "konnte Autor-Skript nicht parsen"
+msgstr "Konnte transport.color.* Konfiguration nicht parsen."
 
 #: transport.c:996
 #, c-format
 msgid ""
 "The following submodule paths contain changes that can\n"
 "not be found on any remote:\n"
 msgstr ""
 "Die folgenden Submodul-Pfade enthalten Änderungen, die in keinem\n"
 "Remote-Repository gefunden wurden:\n"
 
 #: transport.c:1000
@@ -6090,51 +6121,50 @@ msgid "--bisect-clean-state requires no arguments"
 msgstr "--bisect-clean-state erwartet keine Argumente."
 
 #: builtin/blame.c:29
 msgid "git blame [<options>] [<rev-opts>] [<rev>] [--] <file>"
 msgstr "git blame [<Optionen>] [<rev-opts>] [<Commit>] [--] <Datei>"
 
 #: builtin/blame.c:34
 msgid "<rev-opts> are documented in git-rev-list(1)"
 msgstr "<rev-opts> sind dokumentiert in git-rev-list(1)"
 
 #: builtin/blame.c:404
-#, fuzzy, c-format
+#, c-format
 msgid "expecting a color: %s"
-msgstr "Formatfarben beachten"
+msgstr "Erwarte eine Farbe: %s"
 
 #: builtin/blame.c:411
 msgid "must end with a color"
-msgstr ""
+msgstr "Muss mit einer Farbe enden."
 
 #: builtin/blame.c:697
-#, fuzzy, c-format
+#, c-format
 msgid "invalid color '%s' in color.blame.repeatedLines"
-msgstr "Ignoriere ungültige Farbe '%.*s' in log.graphColors"
+msgstr "Ungültige Farbe '%s' in color.blame.repeatedLines."
 
 #: builtin/blame.c:715
-#, fuzzy
 msgid "invalid value for blame.coloring"
-msgstr "Ungültiger Wert für --missing."
+msgstr "Ungültiger Wert für blame.coloring."
 
 #: builtin/blame.c:786
 msgid "Show blame entries as we find them, incrementally"
 msgstr "\"blame\"-Einträge schrittweise anzeigen, während wir sie generieren"
 
 #: builtin/blame.c:787
 msgid "Show blank SHA-1 for boundary commits (Default: off)"
 msgstr "leere SHA-1 für Grenz-Commits anzeigen (Standard: aus)"
 
 #: builtin/blame.c:788
 msgid "Do not treat root commits as boundaries (Default: off)"
-msgstr "Ursprungs-Commits nicht als Grenzen behandeln (Standard: aus)"
+msgstr "Root-Commits nicht als Grenzen behandeln (Standard: aus)"
 
 #: builtin/blame.c:789
 msgid "Show work cost statistics"
 msgstr "Statistiken zum Arbeitsaufwand anzeigen"
 
 #: builtin/blame.c:790
 msgid "Force progress reporting"
 msgstr "Fortschrittsanzeige erzwingen"
 
 #: builtin/blame.c:791
 msgid "Show output score for blame entries"
@@ -6177,27 +6207,27 @@ msgstr "Den Namen des Autors und den Zeitstempel unterdrücken (Standard: aus)"
 #: builtin/blame.c:800
 msgid "Show author email instead of name (Default: off)"
 msgstr ""
 "Anstatt des Namens die E-Mail-Adresse des Autors anzeigen (Standard: aus)"
 
 #: builtin/blame.c:801
 msgid "Ignore whitespace differences"
 msgstr "Unterschiede im Whitespace ignorieren"
 
 #: builtin/blame.c:802
 msgid "color redundant metadata from previous line differently"
-msgstr ""
+msgstr "redundante Metadaten der vorherigen Zeile unterschiedlich einfärben"
 
 #: builtin/blame.c:803
 msgid "color lines by age"
-msgstr ""
+msgstr "Zeilen nach Alter einfärben"
 
 #: builtin/blame.c:810
 msgid "Use an experimental heuristic to improve diffs"
 msgstr ""
 "eine experimentelle Heuristik zur Verbesserung der Darstellung\n"
 "von Unterschieden verwenden"
 
 #: builtin/blame.c:812
 msgid "Spend extra cycles to find better match"
 msgstr "Länger arbeiten, um bessere Übereinstimmungen zu finden"
 
@@ -8147,29 +8177,28 @@ msgid ""
 "ignore changes to submodules, optional when: all, dirty, untracked. "
 "(Default: all)"
 msgstr ""
 "Änderungen in Submodulen ignorieren, optional wenn: all, dirty, untracked. "
 "(Standard: all)"
 
 #: builtin/commit.c:1329
 msgid "list untracked files in columns"
 msgstr "unversionierte Dateien in Spalten auflisten"
 
 #: builtin/commit.c:1330
-#, fuzzy
 msgid "do not detect renames"
-msgstr "keine Abfrage von Remote-Repositories"
+msgstr "keine Umbenennungen ermitteln"
 
 #: builtin/commit.c:1332
 msgid "detect renames, optionally set similarity index"
-msgstr ""
+msgstr "Umbenennungen erkennen, optional Index für Gleichheit setzen"
 
 #: builtin/commit.c:1352
 msgid "Unsupported combination of ignored and untracked-files arguments"
 msgstr ""
 "Nicht unterstützte Kombination von ignored und untracked-files Argumenten."
 
 #: builtin/commit.c:1450
 msgid "suppress summary after successful commit"
 msgstr "Zusammenfassung nach erfolgreichem Commit unterdrücken"
 
 #: builtin/commit.c:1451
@@ -8346,68 +8375,68 @@ msgid ""
 "Repository has been updated, but unable to write\n"
 "new_index file. Check that disk is not full and quota is\n"
 "not exceeded, and then \"git reset HEAD\" to recover."
 msgstr ""
 "Das Repository wurde aktualisiert, aber die \"new_index\"-Datei\n"
 "konnte nicht geschrieben werden. Prüfen Sie, dass Ihre Festplatte nicht\n"
 "voll und Ihr Kontingent nicht aufgebraucht ist und führen Sie\n"
 "anschließend \"git reset HEAD\" zu Wiederherstellung aus."
 
 #: builtin/commit-graph.c:9
 msgid "git commit-graph [--object-dir <objdir>]"
-msgstr ""
+msgstr "git commit-graph [--object-dir <Objektverzeichnis>]"
 
 #: builtin/commit-graph.c:10 builtin/commit-graph.c:16
 msgid "git commit-graph read [--object-dir <objdir>]"
-msgstr ""
+msgstr "git commit-graph read [--object-dir <Objektverzeichnis>]"
 
 #: builtin/commit-graph.c:11 builtin/commit-graph.c:21
 msgid ""
 "git commit-graph write [--object-dir <objdir>] [--append] [--stdin-packs|--"
 "stdin-commits]"
-msgstr ""
+msgstr "git commit-graph write [--object-dir <Objektverzeichnis>] [--append] [--stdin-packs|--stdin-commits]"
 
 #: builtin/commit-graph.c:39 builtin/commit-graph.c:92
 #: builtin/commit-graph.c:147 builtin/fetch.c:161 builtin/log.c:1466
 msgid "dir"
 msgstr "Verzeichnis"
 
 #: builtin/commit-graph.c:40 builtin/commit-graph.c:93
 #: builtin/commit-graph.c:148
 msgid "The object directory to store the graph"
-msgstr ""
+msgstr "Das Objektverzeichnis zum Speichern des Graphen."
 
 #: builtin/commit-graph.c:95
 msgid "scan pack-indexes listed by stdin for commits"
-msgstr ""
+msgstr "durch Standard-Eingabe gelistete Pack-Indexe nach Commits scannen"
 
 #: builtin/commit-graph.c:97
 msgid "start walk at commits listed by stdin"
-msgstr ""
+msgstr "Lauf bei Commits beginnen, die über die Standard-Eingabe gelistet sind"
 
 #: builtin/commit-graph.c:99
 msgid "include all commits already in the commit-graph file"
-msgstr ""
+msgstr "alle Commits einschließen, die sich bereits in der Commit-Graph-Datei befinden"
 
 #: builtin/commit-graph.c:108
 msgid "cannot use both --stdin-commits and --stdin-packs"
-msgstr ""
+msgstr "Kann nicht --stdin-commits und --stdin-packs benutzen."
 
 #: builtin/config.c:10
 msgid "git config [<options>]"
 msgstr "git config [<Optionen>]"
 
 #: builtin/config.c:101
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized --type argument, %s"
-msgstr "nicht erkanntes Argument: %s"
+msgstr "nicht erkanntes --type Argument, %s"
 
 #: builtin/config.c:123
 msgid "Config file location"
 msgstr "Ort der Konfigurationsdatei"
 
 #: builtin/config.c:124
 msgid "use global config file"
 msgstr "globale Konfigurationsdatei verwenden"
 
 #: builtin/config.c:125
 msgid "use system config file"
@@ -8486,25 +8515,24 @@ msgid "find the color configured: slot [default]"
 msgstr "die konfigurierte Farbe finden: Slot [Standard]"
 
 #: builtin/config.c:143
 msgid "find the color setting: slot [stdout-is-tty]"
 msgstr "die Farbeinstellung finden: Slot [Standard-Ausgabe-ist-Terminal]"
 
 #: builtin/config.c:144
 msgid "Type"
 msgstr "Typ"
 
 #: builtin/config.c:145
-#, fuzzy
 msgid "value is given this type"
-msgstr "Wert ist ein Verfallsdatum"
+msgstr "Wert ist mit diesem Typ angegeben"
 
 #: builtin/config.c:146
 msgid "value is \"true\" or \"false\""
 msgstr "Wert ist \"true\" oder \"false\""
 
 #: builtin/config.c:147
 msgid "value is decimal number"
 msgstr "Wert ist eine Dezimalzahl"
 
 #: builtin/config.c:148
 msgid "value is --bool or --int"
@@ -8533,34 +8561,33 @@ msgstr "nur Variablennamen anzeigen"
 #: builtin/config.c:154
 msgid "respect include directives on lookup"
 msgstr "beachtet \"include\"-Direktiven beim Nachschlagen"
 
 #: builtin/config.c:155
 msgid "show origin of config (file, standard input, blob, command line)"
 msgstr ""
 "Ursprung der Konfiguration anzeigen (Datei, Standard-Eingabe, Blob, "
 "Befehlszeile)"
 
 #: builtin/config.c:156
-#, fuzzy
 msgid "value"
-msgstr "Schlüssel=Wert"
+msgstr "Wert"
 
 #: builtin/config.c:156
 msgid "with --get, use default value when missing entry"
-msgstr ""
+msgstr "mit --get, benutze den Standardwert, wenn der Eintrag fehlt"
 
 #: builtin/config.c:332
-#, fuzzy, c-format
+#, c-format
 msgid "failed to format default config value: %s"
-msgstr "Konnte Datei '%s' nicht erstellen"
+msgstr "Fehler beim Formatieren des Standardkonfigurationswertes: %s"
 
 #: builtin/config.c:431
 msgid "unable to parse default color value"
 msgstr "konnte Standard-Farbwert nicht parsen"
 
 #: builtin/config.c:575
 #, c-format
 msgid ""
 "# This is Git's per-user configuration file.\n"
 "[user]\n"
 "# Please adapt and uncomment the following lines:\n"
@@ -8570,25 +8597,24 @@ msgstr ""
 "# Das ist Git's benutzerspezifische Konfigurationsdatei.\n"
 "[user]\n"
 "# Bitte passen Sie die folgenden Zeilen an und kommentieren Sie diese aus:\n"
 "#\tname = %s\n"
 "#\temail = %s\n"
 
 #: builtin/config.c:603
 msgid "--local can only be used inside a git repository"
 msgstr "--local kann nur innerhalb eines Git-Repositories verwendet werden."
 
 #: builtin/config.c:606
-#, fuzzy
 msgid "--blob can only be used inside a git repository"
-msgstr "--local kann nur innerhalb eines Git-Repositories verwendet werden."
+msgstr "--blob kann nur innerhalb eines Git-Repositories verwendet werden."
 
 #: builtin/config.c:735
 #, c-format
 msgid "cannot create configuration file %s"
 msgstr "Konnte Konfigurationsdatei '%s' nicht erstellen."
 
 #: builtin/config.c:748
 #, c-format
 msgid ""
 "cannot overwrite multiple values with a single value\n"
 "       Use a regexp, --add or --replace-all to change %s."
@@ -9147,24 +9173,24 @@ msgid "non-fast-forward"
 msgstr "kein Vorspulen"
 
 #: builtin/fetch.c:795
 #, c-format
 msgid "%s did not send all necessary objects\n"
 msgstr "%s hat nicht alle erforderlichen Objekte gesendet\n"
 
 #: builtin/fetch.c:815
 #, c-format
 msgid "reject %s because shallow roots are not allowed to be updated"
 msgstr ""
-"%s wurde zurückgewiesen, da Ursprungs-Commits von Repositories mit "
-"unvollständiger Historie (shallow) nicht aktualisiert werden dürfen."
+"%s wurde zurückgewiesen, da Root-Commits von Repositories mit unvollständiger\n"
+"Historie (shallow) nicht aktualisiert werden dürfen."
 
 #: builtin/fetch.c:903 builtin/fetch.c:999
 #, c-format
 msgid "From %.*s\n"
 msgstr "Von %.*s\n"
 
 #: builtin/fetch.c:914
 #, c-format
 msgid ""
 "some local refs could not be updated; try running\n"
 " 'git remote prune %s' to remove any old, conflicting branches"
@@ -9464,33 +9490,33 @@ msgstr "mehr Gründlichkeit (erhöht Laufzeit)"
 msgid "enable auto-gc mode"
 msgstr "\"auto-gc\" Modus aktivieren"
 
 #: builtin/gc.c:508
 msgid "force running gc even if there may be another gc running"
 msgstr ""
 "Ausführung von \"git gc\" erzwingen, selbst wenn ein anderes\n"
 "\"git gc\" bereits ausgeführt wird"
 
 #: builtin/gc.c:511
 msgid "repack all other packs except the largest pack"
-msgstr ""
+msgstr "alle anderen Pakete, außer das größte Paket, neu packen"
 
 #: builtin/gc.c:528
-#, fuzzy, c-format
+#, c-format
 msgid "failed to parse gc.logexpiry value %s"
-msgstr "Fehler beim Parsen des Wertes '%s' von gc.logexpiry"
+msgstr "Fehler beim Parsen des Wertes '%s' von gc.logexpiry."
 
 #: builtin/gc.c:539
-#, fuzzy, c-format
+#, c-format
 msgid "failed to parse prune expiry value %s"
-msgstr "Fehler beim Parsen des Wertes '%s' von gc.logexpiry"
+msgstr "Fehler beim Parsen des \"prune expiry\" Wertes %s"
 
 #: builtin/gc.c:559
 #, c-format
 msgid "Auto packing the repository in background for optimum performance.\n"
 msgstr ""
 "Die Datenbank des Repositories wird für eine optimale Performance im\n"
 "Hintergrund komprimiert.\n"
 
 #: builtin/gc.c:561
 #, c-format
 msgid "Auto packing the repository for optimum performance.\n"
@@ -10080,25 +10106,24 @@ msgstr "Kann existierende Informationen zu Objekt %s nicht lesen."
 #: builtin/index-pack.c:825
 #, c-format
 msgid "cannot read existing object %s"
 msgstr "Kann existierendes Objekt %s nicht lesen."
 
 #: builtin/index-pack.c:839
 #, c-format
 msgid "invalid blob object %s"
 msgstr "ungültiges Blob-Objekt %s"
 
 #: builtin/index-pack.c:842 builtin/index-pack.c:860
-#, fuzzy
 msgid "fsck error in packed object"
-msgstr "gepackte Objekte ignorieren"
+msgstr "fsck Fehler in gepacktem Objekt"
 
 #: builtin/index-pack.c:857
 #, c-format
 msgid "invalid %s"
 msgstr "Ungültiger Objekt-Typ %s"
 
 #: builtin/index-pack.c:862
 #, c-format
 msgid "Not all child objects of %s are reachable"
 msgstr "Nicht alle Kind-Objekte von %s sind erreichbar"
 
@@ -10243,25 +10268,24 @@ msgid "--fix-thin cannot be used without --stdin"
 msgstr "Die Option --fix-thin kann nicht ohne --stdin verwendet werden."
 
 #: builtin/index-pack.c:1776
 msgid "--stdin requires a git repository"
 msgstr "--stdin erfordert ein Git-Repository"
 
 #: builtin/index-pack.c:1782
 msgid "--verify with no packfile name given"
 msgstr "Die Option --verify wurde ohne Namen der Paketdatei angegeben."
 
 #: builtin/index-pack.c:1832 builtin/unpack-objects.c:578
-#, fuzzy
 msgid "fsck error in pack objects"
-msgstr "Fehler in Objekt: %s"
+msgstr "fsck Fehler beim Packen von Objekten"
 
 #: builtin/init-db.c:55
 #, c-format
 msgid "cannot stat '%s'"
 msgstr "Kann '%s' nicht lesen"
 
 #: builtin/init-db.c:61
 #, c-format
 msgid "cannot stat template '%s'"
 msgstr "kann Vorlage '%s' nicht lesen"
 
@@ -12098,30 +12122,30 @@ msgstr "Schreibe Objekte"
 msgid "disabling bitmap writing, as some objects are not being packed"
 msgstr ""
 "Deaktiviere Schreiben der Bitmap, da einige Objekte nicht in eine Pack-"
 "Datei\n"
 "geschrieben wurden."
 
 #: builtin/pack-objects.c:1765
 msgid "Counting objects"
 msgstr "Zähle Objekte"
 
 #: builtin/pack-objects.c:1895
-#, fuzzy, c-format
+#, c-format
 msgid "unable to get size of %s"
-msgstr "Konnte %s nicht nach %s verschieben"
+msgstr "Konnte Größe von %s nicht bestimmen."
 
 #: builtin/pack-objects.c:1910
-#, fuzzy, c-format
+#, c-format
 msgid "unable to parse object header of %s"
-msgstr "Konnte Objekt '%s' nicht parsen."
+msgstr "Konnte Kopfbereich von Objekt '%s' nicht parsen."
 
 #: builtin/pack-objects.c:2564
 msgid "Compressing objects"
 msgstr "Komprimiere Objekte"
 
 #: builtin/pack-objects.c:2735
 msgid "invalid value for --missing"
 msgstr "Ungültiger Wert für --missing."
 
 #: builtin/pack-objects.c:3067
 #, c-format
@@ -12253,25 +12277,24 @@ msgstr "dünnere Pakete erzeugen"
 
 #: builtin/pack-objects.c:3163
 msgid "create packs suitable for shallow fetches"
 msgstr ""
 "Pakete geeignet für Abholung mit unvollständiger Historie (shallow) erzeugen"
 
 #: builtin/pack-objects.c:3165
 msgid "ignore packs that have companion .keep file"
 msgstr "Pakete ignorieren, die .keep Dateien haben"
 
 #: builtin/pack-objects.c:3167
-#, fuzzy
 msgid "ignore this pack"
-msgstr "kleinere Pakete verwenden"
+msgstr "dieses Paket ignorieren"
 
 #: builtin/pack-objects.c:3169
 msgid "pack compression level"
 msgstr "Komprimierungsgrad für Paketierung"
 
 #: builtin/pack-objects.c:3171
 msgid "do not hide commits by grafts"
 msgstr "keine künstlichen Vorgänger-Commits (\"grafts\") verbergen"
 
 #: builtin/pack-objects.c:3173
 msgid "use a bitmap index if available to speed up counting objects"
@@ -12287,33 +12310,32 @@ msgid "handling for missing objects"
 msgstr "Behandlung für fehlende Objekte"
 
 #: builtin/pack-objects.c:3181
 msgid "do not pack objects in promisor packfiles"
 msgstr ""
 "keine Objekte aus Packdateien von partiell geklonten Remote-Repositories "
 "packen"
 
 #: builtin/pack-objects.c:3205
 #, c-format
 msgid "delta chain depth %d is too deep, forcing %d"
-msgstr ""
+msgstr "Tiefe für Verkettung von Unterschieden %d ist zu tief, erzwinge %d"
 
 #: builtin/pack-objects.c:3210
 #, c-format
 msgid "pack.deltaCacheLimit is too high, forcing %d"
-msgstr ""
+msgstr "pack.deltaCacheLimit ist zu hoch, erzwinge %d"
 
 #: builtin/pack-objects.c:3338
-#, fuzzy
 msgid "Enumerating objects"
-msgstr "Schreibe Objekte"
+msgstr "Objekte aufzählen"
 
 #: builtin/pack-refs.c:7
 msgid "git pack-refs [<options>]"
 msgstr "git pack-refs [<Optionen>]"
 
 #: builtin/pack-refs.c:15
 msgid "pack everything"
 msgstr "alles packen"
 
 #: builtin/pack-refs.c:16
 msgid "prune loose refs (default)"
@@ -12920,29 +12942,28 @@ msgid "git rebase--helper [<options>]"
 msgstr "git rebase--helper [<Optionen>]"
 
 #: builtin/rebase--helper.c:24
 msgid "keep empty commits"
 msgstr "leere Commits behalten"
 
 #: builtin/rebase--helper.c:26 builtin/revert.c:123
 msgid "allow commits with empty messages"
 msgstr "Commits mit leerer Beschreibung erlauben"
 
 #: builtin/rebase--helper.c:27
-#, fuzzy
 msgid "rebase merge commits"
-msgstr "ungültiger Merge-Tag in Commit '%s'"
+msgstr "Rebase auf Merge-Commits ausführen"
 
 #: builtin/rebase--helper.c:29
 msgid "keep original branch points of cousins"
-msgstr ""
+msgstr "originale Branch-Punkte der Cousins behalten"
 
 #: builtin/rebase--helper.c:30
 msgid "continue rebase"
 msgstr "Rebase fortsetzen"
 
 #: builtin/rebase--helper.c:32
 msgid "abort rebase"
 msgstr "Rebase abbrechen"
 
 #: builtin/rebase--helper.c:35
 msgid "make rebase script"
@@ -12966,23 +12987,23 @@ msgstr "nicht erforderliche \"pick\"-Befehle auslassen"
 
 #: builtin/rebase--helper.c:45
 msgid "rearrange fixup/squash lines"
 msgstr "fixup/squash-Zeilen umordnen"
 
 #: builtin/rebase--helper.c:47
 msgid "insert exec commands in todo list"
 msgstr "\"exec\"-Befehle in TODO-Liste einfügen"
 
 #: builtin/rebase--helper.c:68
 msgid "--[no-]rebase-cousins has no effect without --rebase-merges"
-msgstr ""
+msgstr "--[no-]rebase-cousins hat ohne --rebase-merges keine Auswirkung"
 
 #: builtin/receive-pack.c:31
 msgid "git receive-pack <git-dir>"
 msgstr "git receive-pack <Git-Verzeichnis>"
 
 #: builtin/receive-pack.c:842
 msgid ""
 "By default, updating the current branch in a non-bare repository\n"
 "is denied, because it will make the index and work tree inconsistent\n"
 "with what you pushed, and will require 'git reset --hard' to match\n"
 "the work tree to HEAD.\n"
@@ -13288,25 +13309,25 @@ msgstr " ???"
 #: builtin/remote.c:962
 #, c-format
 msgid "invalid branch.%s.merge; cannot rebase onto > 1 branch"
 msgstr "ungültiges branch.%s.merge; kann Rebase nicht auf > 1 Branch ausführen"
 
 #: builtin/remote.c:971
 #, c-format
 msgid "rebases interactively onto remote %s"
 msgstr "interaktiver Rebase auf Remote-Branch %s"
 
 #: builtin/remote.c:973
-#, fuzzy, c-format
+#, c-format
 msgid "rebases interactively (with merges) onto remote %s"
-msgstr "interaktiver Rebase auf Remote-Branch %s"
+msgstr "interaktiver Rebase (mit Merges) auf Remote-Branch %s"
 
 #: builtin/remote.c:976
 #, c-format
 msgid "rebases onto remote %s"
 msgstr "Rebase auf Remote-Branch %s"
 
 #: builtin/remote.c:980
 #, c-format
 msgid " merges with remote %s"
 msgstr " führt mit Remote-Branch %s zusammen"
 
@@ -13650,27 +13671,24 @@ msgstr "maximale Anzahl von Threads limitieren"
 
 #: builtin/repack.c:210
 msgid "maximum size of each packfile"
 msgstr "maximale Größe für jede Paketdatei"
 
 #: builtin/repack.c:212
 msgid "repack objects in packs marked with .keep"
 msgstr ""
 "Objekte umpacken, die sich in mit .keep markierten Pack-Dateien befinden"
 
 #: builtin/repack.c:214
-#, fuzzy
 msgid "do not repack this pack"
-msgstr ""
-"keine Objekte aus Packdateien von partiell geklonten Remote-Repositories "
-"packen"
+msgstr "dieses Paket nicht neu packen"
 
 #: builtin/repack.c:224
 msgid "cannot delete packs in a precious-objects repo"
 msgstr "kann Pack-Dateien in precious-objects Repository nicht löschen"
 
 #: builtin/repack.c:228
 msgid "--keep-unreachable and -A are incompatible"
 msgstr "--keep-unreachable und -A sind inkompatibel"
 
 #: builtin/repack.c:425 builtin/worktree.c:139
 #, c-format
@@ -13682,25 +13700,24 @@ msgid "git replace [-f] <object> <replacement>"
 msgstr "git replace [-f] <Objekt> <Ersetzung>"
 
 #: builtin/replace.c:23
 msgid "git replace [-f] --edit <object>"
 msgstr "git replace [-f] --edit <Objekt>"
 
 #: builtin/replace.c:24
 msgid "git replace [-f] --graft <commit> [<parent>...]"
 msgstr "git replace [-f] --graft <Commit> [<Eltern-Commit>...]"
 
 #: builtin/replace.c:25
-#, fuzzy
 msgid "git replace [-f] --convert-graft-file"
-msgstr "git replace [-f] --edit <Objekt>"
+msgstr "git replace [-f] --convert-graft-file"
 
 #: builtin/replace.c:26
 msgid "git replace -d <object>..."
 msgstr "git replace -d <Objekt>..."
 
 #: builtin/replace.c:27
 msgid "git replace [--format=<format>] [-l [<pattern>]]"
 msgstr "git replace [--format=<Format>] [-l [<Muster>]]"
 
 #: builtin/replace.c:371 builtin/replace.c:415 builtin/replace.c:445
 #, c-format
@@ -13733,48 +13750,49 @@ msgstr "Der ursprüngliche Commit '%s' hat eine GPG-Signatur."
 
 #: builtin/replace.c:461
 msgid "the signature will be removed in the replacement commit!"
 msgstr "Die Signatur wird in dem Ersetzungs-Commit entfernt!"
 
 #: builtin/replace.c:471
 #, c-format
 msgid "could not write replacement commit for: '%s'"
 msgstr "Konnte Ersetzungs-Commit für '%s' nicht schreiben"
 
 #: builtin/replace.c:514
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "could not convert the following graft(s):\n"
 "%s"
-msgstr "Würde das folgende Element entfernen:"
+msgstr ""
+"Konnte die folgenden künstlichen Vorgänger (\"grafts\") nicht konvertieren:\n"
+"%s"
 
 #: builtin/replace.c:535
 msgid "list replace refs"
 msgstr "ersetzende Referenzen auflisten"
 
 #: builtin/replace.c:536
 msgid "delete replace refs"
 msgstr "ersetzende Referenzen löschen"
 
 #: builtin/replace.c:537
 msgid "edit existing object"
 msgstr "existierendes Objekt bearbeiten"
 
 #: builtin/replace.c:538
 msgid "change a commit's parents"
 msgstr "Eltern-Commits eines Commits ändern"
 
 #: builtin/replace.c:539
-#, fuzzy
 msgid "convert existing graft file"
-msgstr "das Überschreiben bereits existierender Dateien erzwingen"
+msgstr "existierende Datei des künstlichen Vorgängers (\"graft\") konvertieren"
 
 #: builtin/replace.c:540
 msgid "replace the ref if it exists"
 msgstr "die Referenz ersetzen, wenn sie existiert"
 
 #: builtin/replace.c:542
 msgid "do not pretty-print contents for --edit"
 msgstr "keine ansprechende Anzeige des Objektinhaltes für --edit"
 
 #: builtin/replace.c:543
 msgid "use this format"
@@ -14157,44 +14175,40 @@ msgid "use stateless RPC protocol"
 msgstr "zustandsloses RPC-Protokoll verwenden"
 
 #: builtin/send-pack.c:178
 msgid "read refs from stdin"
 msgstr "Referenzen von der Standard-Eingabe lesen"
 
 #: builtin/send-pack.c:179
 msgid "print status from remote helper"
 msgstr "Status des Remote-Helpers ausgeben"
 
 #: builtin/serve.c:7
-#, fuzzy
 msgid "git serve [<options>]"
-msgstr "git repack [<Optionen>]"
+msgstr "git serve [<Optionen>]"
 
 #: builtin/serve.c:17 builtin/upload-pack.c:23
 msgid "quit after a single request/response exchange"
 msgstr "nach einem einzigen Request/Response-Austausch beenden"
 
 #: builtin/serve.c:19
-#, fuzzy
 msgid "exit immediately after advertising capabilities"
-msgstr "direkt nach der initialen Angabe der Commits beenden"
+msgstr "direkt nach Anzeige der angebotenen Fähigkeiten beenden"
 
 #: builtin/shortlog.c:14
-#, fuzzy
 msgid "git shortlog [<options>] [<revision-range>] [[--] <path>...]"
-msgstr "git shortlog [<Optionen>] [<Commitbereich>] [[--] [<Pfad>...]]"
+msgstr "git shortlog [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
 
 #: builtin/shortlog.c:15
-#, fuzzy
 msgid "git log --pretty=short | git shortlog [<options>]"
-msgstr "git worktree list [<Optionen>]"
+msgstr "git log --pretty=short | git shortlog [<Optionen>]"
 
 #: builtin/shortlog.c:264
 msgid "Group by committer rather than author"
 msgstr "über Commit-Ersteller anstatt Autor gruppieren"
 
 #: builtin/shortlog.c:266
 msgid "sort output according to the number of commits per author"
 msgstr "die Ausgabe entsprechend der Anzahl von Commits pro Autor sortieren"
 
 #: builtin/shortlog.c:268
 msgid "Suppress commit descriptions, only provides commit count"
@@ -14205,27 +14219,24 @@ msgid "Show the email address of each author"
 msgstr "die E-Mail-Adresse von jedem Autor anzeigen"
 
 #: builtin/shortlog.c:271
 msgid "w[,i1[,i2]]"
 msgstr "w[,i1[,i2]]"
 
 #: builtin/shortlog.c:272
 msgid "Linewrap output"
 msgstr "Ausgabe mit Zeilenumbrüchen"
 
 #: builtin/shortlog.c:298
-#, fuzzy
 msgid "too many arguments given outside repository"
-msgstr ""
-"zu viele Argumente angegeben, um Konfiguration zu Upstream-Branch zu "
-"entfernen"
+msgstr "zu viele Argumente außerhalb des Repositories angegeben"
 
 #: builtin/show-branch.c:12
 msgid ""
 "git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
 "\t\t[--current] [--color[=<when>] | --no-color] [--sparse]\n"
 "\t\t[--more=<n> | --list | --independent | --merge-base]\n"
 "\t\t[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"
 msgstr ""
 "git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
 "\t\t[--current] [--color[=<Wann>] | --no-color] [--sparse]\n"
 "\t\t[--more=<n> | --list | --independent | --merge-base]\n"
@@ -15457,40 +15468,40 @@ msgstr "Arbeitsverzeichnisse älter als <Zeit> verfallen lassen"
 #: builtin/worktree.c:229
 #, c-format
 msgid "'%s' already exists"
 msgstr "'%s' existiert bereits"
 
 #: builtin/worktree.c:260
 #, c-format
 msgid "could not create directory of '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
 
 #: builtin/worktree.c:373 builtin/worktree.c:379
-#, fuzzy, c-format
+#, c-format
 msgid "Preparing worktree (new branch '%s')"
-msgstr "Fehler beim Entfernen des Branches '%s'"
+msgstr "Bereite Arbeitsverzeichnis vor (neuer Branch '%s')"
 
 #: builtin/worktree.c:375
 #, c-format
 msgid "Preparing worktree (resetting branch '%s'; was at %s)"
-msgstr ""
+msgstr "Bereite Arbeitsverzeichnis vor (setze Branch '%s' um; war bei %s)"
 
 #: builtin/worktree.c:384
 #, c-format
 msgid "Preparing worktree (checking out '%s')"
-msgstr ""
+msgstr "Bereite Arbeitsverzeichnis vor (checke '%s' aus)"
 
 #: builtin/worktree.c:390
-#, fuzzy, c-format
+#, c-format
 msgid "Preparing worktree (detached HEAD %s)"
-msgstr "Bereite %s vor (Identifikation %s)"
+msgstr "Bereite Arbeitsverzeichnis vor (losgelöster HEAD %s)"
 
 #: builtin/worktree.c:431
 msgid "checkout <branch> even if already checked out in other worktree"
 msgstr ""
 "<Branch> auschecken, auch wenn dieser bereits in einem anderen "
 "Arbeitsverzeichnis ausgecheckt ist"
 
 #: builtin/worktree.c:434
 msgid "create a new branch"
 msgstr "neuen Branch erstellen"
 
@@ -15661,34 +15672,33 @@ msgstr ""
 "Ziehen Sie in Betracht\n"
 "\n"
 "\tchmod 0700 %s\n"
 "\n"
 "auszuführen."
 
 #: credential-cache--daemon.c:271
 msgid "print debugging messages to stderr"
 msgstr "Meldungen zur Fehlersuche in Standard-Fehlerausgabe ausgeben"
 
 #: git.c:26
-#, fuzzy
 msgid ""
 "git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
 "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--"
 "bare]\n"
 "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
 "           <command> [<args>]"
 msgstr ""
 "git [--version] [--help] [-C <Pfad>] [-c <Name>=<Wert>]\n"
 "           [--exec-path[=<Pfad>]] [--html-path] [--man-path] [--info-path]\n"
-"           [-p | --paginate | --no-pager] [--no-replace-objects] [--bare]\n"
+"           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--bare]\n"
 "           [--git-dir=<Pfad>] [--work-tree=<Pfad>] [--namespace=<Name>]\n"
 "           <Befehl> [<Argumente>]"
 
 #: git.c:33
 msgid ""
 "'git help -a' and 'git help -g' list available subcommands and some\n"
 "concept guides. See 'git help <command>' or 'git help <concept>'\n"
 "to read about a specific subcommand or concept."
 msgstr ""
 "'git help -a' und 'git help -g' listet verfügbare Unterbefehle und\n"
 "einige Anleitungen zu Git-Konzepten auf. Benutzen Sie 'git help <Befehl>'\n"
@@ -16223,23 +16233,23 @@ msgstr ""
 "Es sieht so aus, als ob es das Verzeichnis $state_dir_base bereits gibt\n"
 "und es könnte ein anderer Rebase im Gange sein. Wenn das der Fall ist,\n"
 "probieren Sie bitte\n"
 "\t$cmd_live_rebase\n"
 "Wenn das nicht der Fall ist, probieren Sie bitte\n"
 "\t$cmd_clear_stale_rebase\n"
 "und führen Sie diesen Befehl nochmal aus. Es wird angehalten, falls noch\n"
 "etwas Schützenswertes vorhanden ist."
 
 #: git-rebase.sh:509
 msgid "error: cannot combine '--signoff' with '--preserve-merges'"
-msgstr ""
+msgstr "Fehler: '--signoff' und '--preserve-merges' können nicht kombiniert werden."
 
 #: git-rebase.sh:537
 #, sh-format
 msgid "invalid upstream '$upstream_name'"
 msgstr "Ungültiger Upstream-Branch '$upstream_name'."
 
 #: git-rebase.sh:561
 #, sh-format
 msgid "$onto_name: there are more than one merge bases"
 msgstr "$onto_name: es gibt mehr als eine Merge-Basis"
 
@@ -16664,51 +16674,57 @@ msgstr ""
 #: git-parse-remote.sh:89
 #, sh-format
 msgid "See git-${cmd}(1) for details."
 msgstr "Siehe git-${cmd}(1) für weitere Details."
 
 #: git-rebase--interactive.sh:142
 #, sh-format
 msgid "Rebasing ($new_count/$total)"
 msgstr "Führe Rebase aus ($new_count/$total)"
 
 #: git-rebase--interactive.sh:158
-#, fuzzy
 msgid ""
 "\n"
 "Commands:\n"
 "p, pick <commit> = use commit\n"
 "r, reword <commit> = use commit, but edit the commit message\n"
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
 "x, exec <commit> = run command (the rest of the line) using shell\n"
 "d, drop <commit> = remove commit\n"
 "l, label <label> = label current HEAD with a name\n"
 "t, reset <label> = reset HEAD to a label\n"
 "m, merge [-C <commit> | -c <commit>] <label> [# <oneline>]\n"
 ".       create a merge commit using the original merge commit's\n"
 ".       message (or the oneline, if no original merge commit was\n"
 ".       specified). Use -c <commit> to reword the commit message.\n"
 "\n"
 "These lines can be re-ordered; they are executed from top to bottom.\n"
 msgstr ""
 "\n"
 "Befehle:\n"
-"p, pick = Commit verwenden\n"
-"r, reword = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
-"e, edit = Commit verwenden, aber zum Nachbessern anhalten\n"
-"s, squash = Commit verwenden, aber mit vorherigem Commit vereinen\n"
-"f, fixup = wie \"squash\", aber diese Commit-Beschreibung verwerfen\n"
-"x, exec = Befehl (Rest der Zeile) mittels Shell ausführen\n"
-"d, drop = Commit entfernen\n"
+"p, pick <Commit> = Commit verwenden\n"
+"r, reword <Commit> = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
+"e, edit <Commit> = Commit verwenden, aber zum Nachbessern anhalten\n"
+"s, squash <Commit> = Commit verwenden, aber mit vorherigem Commit vereinen\n"
+"f, fixup <Commit> = wie \"squash\", aber diese Commit-Beschreibung verwerfen\n"
+"x, exec <Commit> = Befehl (Rest der Zeile) mittels Shell ausführen\n"
+"d, drop <Commit> = Commit entfernen\n"
+"l, label <Label> = aktuellen HEAD mit Label versehen\n"
+"t, reset <Label> = HEAD zu einem Label umsetzen\n"
+"m, merge [-C <Commit> | -c <Commit>] <Label> [# <eineZeile>]\n"
+".       Merge-Commit mit der originalen Merge-Commit-Beschreibung erstellen\n"
+".       (oder die eine Zeile, wenn keine originale Merge-Commit-Beschreibung\n"
+".       spezifiziert ist). Benutzen Sie -c <Commit> zum Bearbeiten der\n"
+".       Commit-Beschreibung.\n"
 "\n"
 "Diese Zeilen können umsortiert werden; Sie werden von oben nach unten\n"
 "ausgeführt.\n"
 
 #: git-rebase--interactive.sh:179
 msgid ""
 "\n"
 "Do not remove any line. Use 'drop' explicitly to remove a commit.\n"
 msgstr ""
 "\n"
 "Keine Zeile entfernen. Benutzen Sie 'drop', um explizit einen Commit zu\n"
@@ -16997,32 +17013,32 @@ msgstr "Konnte temporäres Verzeichnis $state_dir nicht erstellen."
 msgid "Could not mark as interactive"
 msgstr "Konnte nicht als interaktiven Rebase markieren."
 
 #: git-rebase--interactive.sh:915
 #, sh-format
 msgid "Rebase $shortrevisions onto $shortonto ($todocount command)"
 msgid_plural "Rebase $shortrevisions onto $shortonto ($todocount commands)"
 msgstr[0] "Rebase von $shortrevisions auf $shortonto ($todocount Kommando)"
 msgstr[1] "Rebase von $shortrevisions auf $shortonto ($todocount Kommandos)"
 
 #: git-rebase--interactive.sh:920
-#, fuzzy
 msgid ""
 "\n"
 "\tHowever, if you remove everything, the rebase will be aborted.\n"
 "\n"
 "\t"
 msgstr ""
 "\n"
-"Wenn Sie jedoch alles löschen, wird der Rebase abgebrochen.\n"
+"\tWenn Sie jedoch alles löschen, wird der Rebase abgebrochen.\n"
 "\n"
+"\t"
 
 #: git-rebase--interactive.sh:927
 msgid "Note that empty commits are commented out"
 msgstr "Leere Commits sind auskommentiert."
 
 #: git-rebase--interactive.sh:980
 msgid "Could not generate todo list"
 msgstr "Konnte TODO-Liste nicht erzeugen."
 
 #: git-rebase--interactive.sh:1001 git-rebase--interactive.sh:1006
 msgid "Could not init rewritten commits"
@@ -17899,25 +17915,24 @@ msgstr ""
 "\n"
 "    Für weitere Informationen, führen Sie 'git send-email --help' aus.\n"
 "    Um das aktuelle Verhalten beizubehalten, aber diese Meldung zu "
 "unterdrücken,\n"
 "    führen Sie 'git config --global sendemail.confirm auto' aus.\n"
 "\n"
 
 #. TRANSLATORS: Make sure to include [y] [n] [e] [q] [a] in your
 #. translation. The program will only accept English input
 #. at this point.
 #: git-send-email.perl:1415
-#, fuzzy
 msgid "Send this email? ([y]es|[n]o|[e]dit|[q]uit|[a]ll): "
-msgstr "Diese E-Mail versenden? (Ja [y]|Nein [n]|Beenden [q]|Alle [a]): "
+msgstr "Diese E-Mail versenden? (Ja [y]|Nein [n]|Bearbeiten [e]|Beenden [q]|Alle [a]): "
 
 #: git-send-email.perl:1418
 msgid "Send this email reply required"
 msgstr "Zum Versenden dieser E-Mail ist eine Antwort erforderlich."
 
 #: git-send-email.perl:1446
 msgid "The required SMTP server is not properly defined."
 msgstr "Der erforderliche SMTP-Server ist nicht korrekt definiert."
 
 #: git-send-email.perl:1493
 #, perl-format
-- 
2.18.0.203.gfac676dfb9

