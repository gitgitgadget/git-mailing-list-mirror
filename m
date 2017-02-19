Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F2D6201A8
	for <e@80x24.org>; Sun, 19 Feb 2017 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751246AbdBSSMC (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Feb 2017 13:12:02 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34662 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751004AbdBSSL7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Feb 2017 13:11:59 -0500
Received: by mail-wr0-f195.google.com with SMTP id 89so3231968wrr.1
        for <git@vger.kernel.org>; Sun, 19 Feb 2017 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4bwCuV6RLkO+6yi5No5r1VEhVQv5BA83WR/+R+CLxfA=;
        b=WjCdJwF8ltrJ2Sl8n5H+CSDi76X1PcImkskC/WkskzexFggcKp9+m/7CMJp5pdxl0q
         rrOtq8GWdop49FdfussZUq5zEr/8rc1GwRTxxEyqYl0T615TmH3PB8uCOKQVaJQ3LBcT
         GOFaGsJfZ9euTD3BJMHuvhSK3Nk8l2pN/QbFAf8vVmEpXvnL5NjwpW6Pruc6TbERVpk4
         LkBH3mcMIZY3Q1HXXr4FBXJUfTjg774NMgi9Ejsng7vDqZqQMmbPEJCvfXko1PxebDVy
         rI9Po3mPgWO2KAZXKH7HSZriPK2DSx0Nw1OSdjMiV8GNqq8HjqygHHJobXmekMMYrDeA
         XivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4bwCuV6RLkO+6yi5No5r1VEhVQv5BA83WR/+R+CLxfA=;
        b=WrSHFnM8EFfgmmvTpet6eKrjwBTqlACt0z0HvmelRQuLMziFCRf+5gFSfbF3IvosW/
         //uTFAlmUx5uyhfRyMXmJTRuiSrIWNQXnaC31UV47g9OV18FH5eXrqTkX+pUuPmT7LSw
         uog7hVS+YlVPQ0CpGzPv/pCl/vt7RJQj96HMCxpz8/YeuBFf7/SKL6gCI7xpqLzs/FkI
         yb1QxI0aJ5Y7zlY76PW/eZ9khZLphHazWEhBKYVkVa+xd/OnyhZItDMCUOzIrY/94n1i
         icuip0KzGAlNQhYJlBIi+xCOxULSuKU7pCeh9j3LsiRjoNkO2Qrkg6IOFDirQ5QXn4Au
         W8FA==
X-Gm-Message-State: AMke39l6tMnEhyG2sbYM4O4t/HMmHCe0+oLnXj+r6NTp7AwZmrR+1nU8Vur623otxgEeow==
X-Received: by 10.223.134.253 with SMTP id 58mr15224821wry.46.1487527915645;
        Sun, 19 Feb 2017 10:11:55 -0800 (PST)
Received: from localhost (cable-94-139-24-87.cust.telecolumbus.net. [94.139.24.87])
        by smtp.gmail.com with ESMTPSA id x25sm21691321wrx.27.2017.02.19.10.11.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Feb 2017 10:11:54 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org, Phillip Szelat <phillip.szelat@gmail.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: translate 241 messages
Date:   Sun, 19 Feb 2017 19:11:52 +0100
Message-Id: <20170219181152.9410-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.12.0.rc1.72.g32572afd0
In-Reply-To: <20170217174132.8816-1-ralf.thielow@gmail.com>
References: <20170217174132.8816-1-ralf.thielow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Translate 241 messages came from git.pot update in 673bfad09
(l10n: git.pot: v2.12.0 round 1 (239 new, 15 removed)) and a4d94835a
(l10n: git.pot: v2.12.0 round 2 (2 new)).

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 po/de.po | 750 ++++++++++++++++++++++++++++++++++-----------------------------
 1 file changed, 409 insertions(+), 341 deletions(-)

diff --git a/po/de.po b/po/de.po
index 2326da1fd..e9c86f548 100644
--- a/po/de.po
+++ b/po/de.po
@@ -913,20 +913,20 @@ msgstr ""
 
 #: bisect.c:742
 #, c-format
 msgid ""
 "The merge base %s is %s.\n"
 "This means the first '%s' commit is between %s and [%s].\n"
 msgstr ""
 "Die Merge-Basis %s ist %s.\n"
-"Das bedeutet, der erste '%s' Commit befindet sich zwischen %s und [%s]\n"
+"Das bedeutet, der erste '%s' Commit befindet sich zwischen %s und [%s].\n"
 
 #: bisect.c:750
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Some %s revs are not ancestors of the %s rev.\n"
 "git bisect cannot work properly in this case.\n"
 "Maybe you mistook %s and %s revs?\n"
 msgstr ""
 "Manche %s Commits sind keine Vorgänger des %s Commits.\n"
 "git bisect kann in diesem Fall nicht richtig arbeiten.\n"
 "Vielleicht verwechselten Sie %s und %s Commits?\n"
@@ -1343,19 +1343,19 @@ msgid "bad zlib compression level %d"
 msgstr "ungültiger zlib Komprimierungsgrad %d"
 
 #: config.c:993
 #, c-format
 msgid "invalid mode for object creation: %s"
 msgstr "Ungültiger Modus für Objekterstellung: %s"
 
 #: config.c:1149
-#, fuzzy, c-format
+#, c-format
 msgid "bad pack compression level %d"
-msgstr "Komprimierungsgrad für Paketierung"
+msgstr "ungültiger Komprimierungsgrad (%d) für Paketierung"
 
 #: config.c:1339
 msgid "unable to parse command-line config"
 msgstr ""
 "Konnte die über die Befehlszeile angegebene Konfiguration nicht parsen."
 
 #: config.c:1389
 msgid "unknown error occurred while reading the configuration files"
@@ -1375,19 +1375,19 @@ msgid "bad config variable '%s' in file '%s' at line %d"
 msgstr "ungültige Konfigurationsvariable '%s' in Datei '%s' bei Zeile %d"
 
 #: config.c:1804
 #, c-format
 msgid "%s has multiple values"
 msgstr "%s hat mehrere Werte"
 
 #: config.c:2225 config.c:2450
-#, fuzzy, c-format
+#, c-format
 msgid "fstat on %s failed"
-msgstr "\"stash\" fehlgeschlagen"
+msgstr "fstat auf %s fehlgeschlagen"
 
 #: config.c:2343
 #, c-format
 msgid "could not set '%s' to '%s'"
 msgstr "Konnte '%s' nicht zu '%s' setzen."
 
 #: config.c:2345
 #, c-format
@@ -1616,19 +1616,19 @@ msgstr "Fehler beim Sammeln von Namen und Informationen zum Kernel"
 
 #: dir.c:1981
 msgid "Untracked cache is disabled on this system or location."
 msgstr ""
 "Cache für unversionierte Dateien ist auf diesem System oder\n"
 "für dieses Verzeichnis deaktiviert."
 
 #: dir.c:2759
-#, fuzzy, c-format
+#, c-format
 msgid "could not migrate git directory from '%s' to '%s'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte Git-Verzeichnis nicht von '%s' nach '%s' migrieren."
 
 #: fetch-pack.c:213
 msgid "git fetch-pack: expected shallow list"
 msgstr "git fetch-pack: erwartete shallow-Liste"
 
 #: fetch-pack.c:225
 msgid "git fetch-pack: expected ACK/NAK, got EOF"
 msgstr "git fetch-pack: ACK/NAK erwartet, EOF bekommen"
@@ -1803,17 +1803,17 @@ msgstr "konnte temporäre Datei nicht erstellen"
 #: gpg-interface.c:217
 #, c-format
 msgid "failed writing detached signature to '%s'"
 msgstr "Fehler beim Schreiben der losgelösten Signatur nach '%s'"
 
 #: graph.c:96
 #, c-format
 msgid "ignore invalid color '%.*s' in log.graphColors"
-msgstr ""
+msgstr "Ignoriere ungültige Farbe '%.*s' in log.graphColors"
 
 #: grep.c:1794
 #, c-format
 msgid "'%s': unable to read %s"
 msgstr "'%s': konnte %s nicht lesen"
 
 #: grep.c:1811 builtin/clone.c:381 builtin/diff.c:81 builtin/rm.c:133
 #, c-format
@@ -2320,17 +2320,17 @@ msgstr "%s: 'literal' und 'glob' sind inkompatibel"
 #: pathspec.c:363
 #, c-format
 msgid "%s: '%s' is outside repository"
 msgstr "%s: '%s' liegt außerhalb des Repositories"
 
 #: pathspec.c:451
 #, c-format
 msgid "'%s' (mnemonic: '%c')"
-msgstr ""
+msgstr "'%s' (Kürzel: '%c')"
 
 #: pathspec.c:461
 #, c-format
 msgid "%s: pathspec magic not supported by this command: %s"
 msgstr ""
 "%s: Pfadspezifikationsangabe wird von diesem Befehl nicht unterstützt: %s"
 
 #: pathspec.c:511
@@ -2418,19 +2418,19 @@ msgid "%%(body) does not take arguments"
 msgstr "%%(body) akzeptiert keine Argumente"
 
 #: ref-filter.c:85
 #, c-format
 msgid "%%(subject) does not take arguments"
 msgstr "%%(subject) akzeptiert keine Argumente"
 
 #: ref-filter.c:92
-#, fuzzy, c-format
+#, c-format
 msgid "%%(trailers) does not take arguments"
-msgstr "%%(body) akzeptiert keine Argumente"
+msgstr "%%(trailers) akzeptiert keine Argumente"
 
 #: ref-filter.c:111
 #, c-format
 msgid "positive value expected contents:lines=%s"
 msgstr "Positiver Wert erwartet contents:lines=%s"
 
 #: ref-filter.c:113
 #, c-format
@@ -2613,32 +2613,30 @@ msgstr "  (benutzen Sie \"git branch --unset-upstream\" zum Beheben)\n"
 #, c-format
 msgid "Your branch is up-to-date with '%s'.\n"
 msgstr "Ihr Branch ist auf dem selben Stand wie '%s'.\n"
 
 #: remote.c:2092
 #, c-format
 msgid "Your branch is ahead of '%s' by %d commit.\n"
 msgid_plural "Your branch is ahead of '%s' by %d commits.\n"
-msgstr[0] "Ihr Branch ist vor '%s' um %d Commit.\n"
-msgstr[1] "Ihr Branch ist vor '%s' um %d Commits.\n"
+msgstr[0] "Ihr Branch ist %2$d Commit vor '%1$s'.\n"
+msgstr[1] "Ihr Branch ist %2$d Commits vor '%1$s'.\n"
 
 #: remote.c:2098
 msgid "  (use \"git push\" to publish your local commits)\n"
 msgstr "  (benutzen Sie \"git push\", um lokale Commits zu publizieren)\n"
 
 #: remote.c:2101
 #, c-format
 msgid "Your branch is behind '%s' by %d commit, and can be fast-forwarded.\n"
 msgid_plural ""
 "Your branch is behind '%s' by %d commits, and can be fast-forwarded.\n"
-msgstr[0] ""
-"Ihr Branch ist zu '%s' um %d Commit hinterher, und kann vorgespult werden.\n"
-msgstr[1] ""
-"Ihr Branch ist zu '%s' um %d Commits hinterher, und kann vorgespult werden.\n"
+msgstr[0] "Ihr Branch ist %2$d Commit hinter '%1$s', und kann vorgespult werden.\n"
+msgstr[1] "Ihr Branch ist %2$d Commits hinter '%1$s', und kann vorgespult werden.\n"
 
 #: remote.c:2109
 msgid "  (use \"git pull\" to update your local branch)\n"
 msgstr ""
 "  (benutzen Sie \"git pull\", um Ihren lokalen Branch zu aktualisieren)\n"
 
 #: remote.c:2112
 #, c-format
@@ -2712,24 +2710,23 @@ msgstr "die Gegenseite unterstützt keine Push-Optionen"
 msgid "revert"
 msgstr "Revert"
 
 #: sequencer.c:217
 msgid "cherry-pick"
 msgstr "Cherry-Pick"
 
 #: sequencer.c:219
-#, fuzzy
 msgid "rebase -i"
-msgstr "Basis-Commit"
+msgstr "interaktives Rebase"
 
 #: sequencer.c:221
-#, fuzzy, c-format
+#, c-format
 msgid "Unknown action: %d"
-msgstr "Unbekannter Typ: %d"
+msgstr "Unbekannte Aktion: %d"
 
 #: sequencer.c:278
 msgid ""
 "after resolving the conflicts, mark the corrected paths\n"
 "with 'git add <paths>' or 'git rm <paths>'"
 msgstr ""
 "nach Auflösung der Konflikte, markieren Sie die korrigierten Pfade\n"
 "mit 'git add <Pfade>' oder 'git rm <Pfade>'"
@@ -2844,72 +2841,76 @@ msgstr "Konnte Eltern-Commit %s nicht parsen\n"
 
 #: sequencer.c:815
 #, c-format
 msgid ""
 "unexpected 1st line of squash message:\n"
 "\n"
 "\t%.*s"
 msgstr ""
+"unerwartete erste Zeile der Squash-Beschreibung:\n"
+"\n"
+"\t%.*s"
 
 #: sequencer.c:821
 #, c-format
 msgid ""
 "invalid 1st line of squash message:\n"
 "\n"
 "\t%.*s"
 msgstr ""
+"ungültige erste Zeile der Squash-Beschreibung:\n"
+"\n"
+"\t%.*s"
 
 #: sequencer.c:827 sequencer.c:852
-#, fuzzy, c-format
+#, c-format
 msgid "This is a combination of %d commits."
-msgstr "Das ist eine Kombination aus 2 Commits."
+msgstr "Das ist eine Kombination aus %d Commits."
 
 #: sequencer.c:836
 msgid "need a HEAD to fixup"
-msgstr ""
+msgstr "benötige HEAD für fixup"
 
 #: sequencer.c:838
-#, fuzzy
 msgid "could not read HEAD"
-msgstr "Konnte HEAD nicht loslösen"
+msgstr "Konnte HEAD nicht lesen"
 
 #: sequencer.c:840
-#, fuzzy
 msgid "could not read HEAD's commit message"
-msgstr "Konnte Commit-Beschreibung nicht lesen: %s"
+msgstr "Konnte Commit-Beschreibung von HEAD nicht lesen"
 
 #: sequencer.c:846
-#, fuzzy, c-format
+#, c-format
 msgid "cannot write '%s'"
-msgstr "kann '%s' nicht erstellen"
+msgstr "kann '%s' nicht schreiben"
 
 #: sequencer.c:855 git-rebase--interactive.sh:445
 msgid "This is the 1st commit message:"
 msgstr "Das ist die erste Commit-Beschreibung:"
 
 #: sequencer.c:863
-#, fuzzy, c-format
+#, c-format
 msgid "could not read commit message of %s"
-msgstr "Konnte Commit-Beschreibung nicht lesen: %s"
+msgstr "Konnte Commit-Beschreibung von %s nicht lesen."
 
 #: sequencer.c:870
-#, fuzzy, c-format
+#, c-format
 msgid "This is the commit message #%d:"
-msgstr "Das ist Commit-Beschreibung #${n}:"
+msgstr "Das ist Commit-Beschreibung #%d:"
 
 #: sequencer.c:875
-#, fuzzy, c-format
+#, c-format
 msgid "The commit message #%d will be skipped:"
-msgstr "Commit-Beschreibung #${n} wird ausgelassen:"
+msgstr "Die Commit-Beschreibung #%d wird ausgelassen:"
 
 #: sequencer.c:880
-#, fuzzy, c-format
+#, c-format
 msgid "unknown command: %d"
-msgstr "Unbekannter Unterbefehl: %s"
+msgstr "Unbekannter Befehl: %d"
 
 #: sequencer.c:946
 msgid "your index file is unmerged."
 msgstr "Ihre Index-Datei ist nicht zusammengeführt."
 
 #: sequencer.c:964
 #, c-format
 msgid "commit %s is a merge but no -m option was given."
@@ -2933,19 +2934,19 @@ msgstr "Kann keine Commit-Beschreibung für %s bekommen."
 #. TRANSLATORS: The first %s will be a "todo" command like
 #. "revert" or "pick", the second %s a SHA1.
 #: sequencer.c:1001
 #, c-format
 msgid "%s: cannot parse parent commit %s"
 msgstr "%s: kann Eltern-Commit %s nicht parsen"
 
 #: sequencer.c:1063 sequencer.c:1812
-#, fuzzy, c-format
+#, c-format
 msgid "could not rename '%s' to '%s'"
-msgstr "Konnte '%s' nicht zu '%s' setzen."
+msgstr "Konnte '%s' nicht zu '%s' umbenennen."
 
 #: sequencer.c:1114
 #, c-format
 msgid "could not revert %s... %s"
 msgstr "Konnte \"revert\" nicht auf %s... (%s) ausführen"
 
 #: sequencer.c:1115
 #, c-format
@@ -2967,29 +2968,28 @@ msgid "git %s: failed to refresh the index"
 msgstr "git %s: Fehler beim Aktualisieren des Index"
 
 #: sequencer.c:1294
 #, c-format
 msgid "invalid line %d: %.*s"
 msgstr "Ungültige Zeile %d: %.*s"
 
 #: sequencer.c:1302
-#, fuzzy, c-format
+#, c-format
 msgid "cannot '%s' without a previous commit"
-msgstr "Kann nicht '$squash_style' ohne vorherigen Commit"
+msgstr "Kann '%s' nicht ohne vorherigen Commit ausführen"
 
 #: sequencer.c:1334
 #, c-format
 msgid "could not read '%s'."
 msgstr "Konnte '%s' nicht lesen."
 
 #: sequencer.c:1341
-#, fuzzy
 msgid "please fix this using 'git rebase --edit-todo'."
-msgstr "Bitte beheben Sie das, indem Sie 'git rebase --edit-todo' ausführen."
+msgstr "Bitte beheben Sie dieses, indem Sie 'git rebase --edit-todo' ausführen."
 
 #: sequencer.c:1343
 #, c-format
 msgid "unusable instruction sheet: '%s'"
 msgstr "Unbenutzbares Instruktionsblatt: '%s'"
 
 #: sequencer.c:1348
 msgid "no commits parsed."
@@ -3062,166 +3062,155 @@ msgid "unexpected end of file"
 msgstr "Unerwartetes Dateiende"
 
 #: sequencer.c:1629
 #, c-format
 msgid "stored pre-cherry-pick HEAD file '%s' is corrupt"
 msgstr "gespeicherte \"pre-cherry-pick\" HEAD Datei '%s' ist beschädigt"
 
 #: sequencer.c:1640
-#, fuzzy
 msgid "You seem to have moved HEAD. Not rewinding, check your HEAD!"
-msgstr ""
-"Sie scheinen seit dem letzten gescheiterten 'am' HEAD geändert zu haben.\n"
-"Keine Zurücksetzung zu ORIG_HEAD."
+msgstr "Sie scheinen HEAD verschoben zu haben. Keine Zurücksetzung, prüfen Sie HEAD."
 
 #: sequencer.c:1777 sequencer.c:2049
-#, fuzzy
 msgid "cannot read HEAD"
 msgstr "Kann HEAD nicht lesen"
 
 #: sequencer.c:1817 builtin/difftool.c:574
-#, fuzzy, c-format
+#, c-format
 msgid "could not copy '%s' to '%s'"
-msgstr "Konnte '%s' nicht zu '%s' setzen."
+msgstr "Konnte '%s' nicht nach '%s' kopieren."
 
 #: sequencer.c:1833
-#, fuzzy
 msgid "could not read index"
-msgstr "Konnte den Index nicht lesen"
+msgstr "Konnte den Index nicht lesen."
 
 #: sequencer.c:1838
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "execution failed: %s\n"
 "%sYou can fix the problem, and then run\n"
 "\n"
 "  git rebase --continue\n"
 "\n"
 msgstr ""
-"Sie können das Problem beheben, und dann\n"
+"Ausführung fehlgeschlagen: %s\n"
+"%sSie können das Problem beheben, und dann\n"
 "\n"
 "\tgit rebase --continue\n"
 "\n"
-"ausführen."
+"ausführen.\n"
 
 #: sequencer.c:1844
-#, fuzzy
 msgid "and made changes to the index and/or the working tree\n"
-msgstr "Der Index und/oder das Arbeitsverzeichnis wurde geändert."
+msgstr "Der Index und/oder das Arbeitsverzeichnis wurde geändert.\n"
 
 #: sequencer.c:1850
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "execution succeeded: %s\n"
 "but left changes to the index and/or the working tree\n"
 "Commit or stash your changes, and then run\n"
 "\n"
 "  git rebase --continue\n"
 "\n"
 msgstr ""
-"Ausführung erfolgreich: $rest\n"
+"Ausführung erfolgreich: %s\n"
 "Aber Änderungen in Index oder Arbeitsverzeichnis verblieben.\n"
 "Committen Sie Ihre Änderungen oder benutzen Sie \"stash\".\n"
 "Führen Sie dann aus:\n"
 "\n"
-"\tgit rebase --continue"
+"  git rebase --continue\n"
+"\n"
 
 #: sequencer.c:1905 git-rebase.sh:168
 #, c-format
 msgid "Applied autostash."
 msgstr "Automatischen Stash angewendet."
 
 #: sequencer.c:1917
-#, fuzzy, c-format
+#, c-format
 msgid "cannot store %s"
-msgstr "kann '%s' nicht öffnen"
+msgstr "kann %s nicht speichern"
 
 #: sequencer.c:1919 git-rebase.sh:172
 #, c-format
 msgid ""
 "Applying autostash resulted in conflicts.\n"
 "Your changes are safe in the stash.\n"
 "You can run \"git stash pop\" or \"git stash drop\" at any time.\n"
 msgstr ""
 "Anwendung des automatischen Stash resultierte in Konflikten.\n"
 "Ihre Änderungen sind im Stash sicher.\n"
 "Sie können jederzeit \"git stash pop\" oder \"git stash drop\" ausführen.\n"
 
 #: sequencer.c:2000
-#, fuzzy, c-format
+#, c-format
 msgid "stopped at %s... %.*s"
-msgstr "Anwendung des Patches fehlgeschlagen bei %s %.*s"
+msgstr "Angehalten bei %s... %.*s"
 
 #: sequencer.c:2027
-#, fuzzy, c-format
+#, c-format
 msgid "unknown command %d"
-msgstr "Unbekannter Unterbefehl: %s"
+msgstr "Unbekannter Befehl %d"
 
 #: sequencer.c:2057
-#, fuzzy
 msgid "could not read orig-head"
-msgstr "Konnte Referenz %s nicht lesen."
+msgstr "Konnte orig-head nicht lesen."
 
 #: sequencer.c:2061
-#, fuzzy
 msgid "could not read 'onto'"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte 'onto' nicht lesen."
 
 #: sequencer.c:2068
-#, fuzzy, c-format
+#, c-format
 msgid "could not update %s"
-msgstr "konnte %s nicht parsen"
+msgstr "Konnte %s nicht aktualisieren."
 
 #: sequencer.c:2075
-#, fuzzy, c-format
+#, c-format
 msgid "could not update HEAD to %s"
-msgstr "Konnte nicht nach '%s' schreiben."
+msgstr "Konnte HEAD nicht auf %s aktualisieren."
 
 #: sequencer.c:2159
-#, fuzzy
 msgid "cannot rebase: You have unstaged changes."
 msgstr ""
-"Rebase nicht möglich: Sie haben Änderungen, die nicht zum Commit vorgemerkt "
-"sind."
+"Rebase nicht möglich: Sie haben Änderungen, die nicht zum Commit\n"
+"vorgemerkt sind."
 
 #: sequencer.c:2164
-#, fuzzy
 msgid "could not remove CHERRY_PICK_HEAD"
-msgstr "Konnte CHERRY_PICK_HEAD nicht löschen"
+msgstr "Konnte CHERRY_PICK_HEAD nicht löschen."
 
 #: sequencer.c:2173
-#, fuzzy
 msgid "cannot amend non-existing commit"
-msgstr "Kann existierendes Objekt %s nicht lesen."
+msgstr "Kann nicht existierenden Commit nicht nachbessern."
 
 #: sequencer.c:2175
-#, fuzzy, c-format
+#, c-format
 msgid "invalid file: '%s'"
-msgstr "Ungültiger Schlüssel: %s"
+msgstr "Ungültige Datei: '%s'"
 
 #: sequencer.c:2177
-#, fuzzy, c-format
+#, c-format
 msgid "invalid contents: '%s'"
-msgstr "Ungültige Option: %s"
+msgstr "Ungültige Inhalte: '%s'"
 
 #: sequencer.c:2180
-#, fuzzy
 msgid ""
 "\n"
 "You have uncommitted changes in your working tree. Please, commit them\n"
 "first and then run 'git rebase --continue' again."
 msgstr ""
+"\n"
 "Sie haben nicht committete Änderungen in Ihrem Arbeitsverzeichnis. Bitte\n"
-"committen Sie diese zuerst und führen Sie dann 'git rebase --continue' "
-"erneut\n"
-"aus."
+"committen Sie diese zuerst und führen Sie dann 'git rebase --continue'\n"
+"erneut aus."
 
 #: sequencer.c:2190
-#, fuzzy
 msgid "could not commit staged changes."
 msgstr "Konnte Änderungen aus der Staging-Area nicht committen."
 
 #: sequencer.c:2270
 #, c-format
 msgid "%s: can't cherry-pick a %s"
 msgstr "%s: %s kann nicht in \"cherry-pick\" benutzt werden"
 
@@ -3416,54 +3405,59 @@ msgstr "Konnte Eintrag '%s' nicht aus .gitmodules entfernen"
 msgid "staging updated .gitmodules failed"
 msgstr "Konnte aktualisierte .gitmodules-Datei nicht zum Commit vormerken"
 
 #: submodule.c:159
 msgid "negative values not allowed for submodule.fetchJobs"
 msgstr "Negative Werte für submodule.fetchJobs nicht erlaubt"
 
 #: submodule.c:1184
-#, fuzzy, c-format
+#, c-format
 msgid "could not start 'git status in submodule '%s'"
-msgstr "Konnte Submodul-Verzeichnis '%s' nicht finden."
+msgstr "Konnte 'git status' in Submodul '%s' nicht starten."
 
 #: submodule.c:1197
-#, fuzzy, c-format
+#, c-format
 msgid "could not run 'git status in submodule '%s'"
-msgstr "konnte Datei '%s' nicht erstellen"
+msgstr "konnte 'git status' in Submodul '%s' nicht ausführen"
 
 #: submodule.c:1398
 #, c-format
 msgid ""
 "relocate_gitdir for submodule '%s' with more than one worktree not supported"
 msgstr ""
+"relocate_gitdir für Submodul '%s' mit mehr als einem Arbeitsverzeichnis\n"
+"wird nicht unterstützt"
 
 #: submodule.c:1410 submodule.c:1471
-#, fuzzy, c-format
+#, c-format
 msgid "could not lookup name for submodule '%s'"
-msgstr "konnte '%s' nicht öffnen oder lesen"
+msgstr "konnte Name für Submodul '%s' nicht nachschlagen"
 
 #: submodule.c:1414 submodule.c:1474 builtin/submodule--helper.c:640
 #: builtin/submodule--helper.c:650
 #, c-format
 msgid "could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
 
 #: submodule.c:1420
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Migrating git directory of '%s%s' from\n"
 "'%s' to\n"
 "'%s'\n"
-msgstr "Fehler beim Kopieren der Notizen von '%s' nach '%s'"
+msgstr ""
+"Migriere Git-Verzeichnis von '%s%s' von\n"
+"'%s' nach\n"
+"'%s'\n"
 
 #: submodule.c:1512
-#, fuzzy, c-format
+#, c-format
 msgid "could not recurse into submodule '%s'"
-msgstr "Fehler bei Rekursion in Submodul-Pfad '$sm_path'"
+msgstr "Fehler bei Rekursion in Submodul-Pfad '%s'"
 
 #: submodule-config.c:360
 #, c-format
 msgid "invalid value for %s"
 msgstr "Ungültiger Wert für %s"
 
 #: trailer.c:240
 #, c-format
@@ -3646,17 +3640,17 @@ msgstr ""
 msgid ""
 "Your local changes to the following files would be overwritten by %s:\n"
 "%%s"
 msgstr ""
 "Ihre lokalen Änderungen würden durch %s überschrieben werden.\n"
 "%%s"
 
 #: unpack-trees.c:116
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Updating the following directories would lose untracked files in them:\n"
 "%s"
 msgstr ""
 "Durch die Aktualisierung der folgenden Verzeichnisse würden unversionierte\n"
 "Dateien in diesen Verzeichnissen verloren gehen:\n"
 "%s"
 
@@ -4104,17 +4098,17 @@ msgstr "  (benutzen Sie \"git am --skip\", um diesen Patch auszulassen)"
 #: wt-status.c:1047
 msgid "  (use \"git am --abort\" to restore the original branch)"
 msgstr ""
 "  (benutzen Sie \"git am --abort\", um den ursprünglichen Branch "
 "wiederherzustellen)"
 
 #: wt-status.c:1176
 msgid "git-rebase-todo is missing."
-msgstr ""
+msgstr "git-rebase-todo fehlt."
 
 #: wt-status.c:1178
 msgid "No commands done."
 msgstr "Keine Befehle ausgeführt."
 
 #: wt-status.c:1181
 #, c-format
 msgid "Last command done (%d command done):"
@@ -4343,42 +4337,40 @@ msgid "no changes added to commit\n"
 msgstr "keine Änderungen zum Commit vorgemerkt\n"
 
 #: wt-status.c:1611
 #, c-format
 msgid ""
 "nothing added to commit but untracked files present (use \"git add\" to "
 "track)\n"
 msgstr ""
-"nichts zum Commit vorgemerkt, aber es gibt unversionierte Dateien (benutzen "
-"Sie \"git add\" zum Versionieren)\n"
+"nichts zum Commit vorgemerkt, aber es gibt unversionierte Dateien\n"
+"(benutzen Sie \"git add\" zum Versionieren)\n"
 
 #: wt-status.c:1614
 #, c-format
 msgid "nothing added to commit but untracked files present\n"
 msgstr "nichts zum Commit vorgemerkt, aber es gibt unversionierte Dateien\n"
 
 #: wt-status.c:1617
 #, c-format
 msgid "nothing to commit (create/copy files and use \"git add\" to track)\n"
 msgstr ""
-"nichts zu committen (Erstellen/Kopieren Sie Dateien und benutzen Sie \"git "
-"add\" zum Versionieren)\n"
+"nichts zu committen (Erstellen/Kopieren Sie Dateien und benutzen\n"
+"Sie \"git add\" zum Versionieren)\n"
 
 #: wt-status.c:1620 wt-status.c:1625
 #, c-format
 msgid "nothing to commit\n"
 msgstr "nichts zu committen\n"
 
 #: wt-status.c:1623
 #, c-format
 msgid "nothing to commit (use -u to show untracked files)\n"
-msgstr ""
-"nichts zu committen (benutzen Sie die Option -u, um unversionierte Dateien "
-"anzuzeigen)\n"
+msgstr "nichts zu committen (benutzen Sie die Option -u, um unversionierte Dateien anzuzeigen)\n"
 
 #: wt-status.c:1627
 #, c-format
 msgid "nothing to commit, working tree clean\n"
 msgstr "nichts zu committen, Arbeitsverzeichnis unverändert\n"
 
 #: wt-status.c:1734
 msgid "Initial commit on "
@@ -5086,21 +5078,20 @@ msgid "Show author email instead of name (Default: off)"
 msgstr ""
 "Anstatt des Namens die E-Mail-Adresse des Autors anzeigen (Standard: aus)"
 
 #: builtin/blame.c:2597
 msgid "Ignore whitespace differences"
 msgstr "Unterschiede im Whitespace ignorieren"
 
 #: builtin/blame.c:2604
-#, fuzzy
 msgid "Use an experimental heuristic to improve diffs"
 msgstr ""
-"eine experimentelle, auf Einrückungen basierende Heuristik zur Verbesserung\n"
-"der Darstellung von Unterschieden verwenden"
+"eine experimentelle Heuristik zur Verbesserung der Darstellung\n"
+"von Unterschieden verwenden"
 
 #: builtin/blame.c:2606
 msgid "Spend extra cycles to find better match"
 msgstr "Länger arbeiten, um bessere Übereinstimmungen zu finden"
 
 #: builtin/blame.c:2607
 msgid "Use revisions from <file> instead of calling git-rev-list"
 msgstr "Commits von <Datei> benutzen, anstatt \"git-rev-list\" aufzurufen"
@@ -5520,17 +5511,17 @@ msgid "object"
 msgstr "Objekt"
 
 #: builtin/branch.c:679
 msgid "print only branches of the object"
 msgstr "nur Branches von diesem Objekt ausgeben"
 
 #: builtin/branch.c:681 builtin/for-each-ref.c:46 builtin/tag.c:388
 msgid "sorting and filtering are case insensitive"
-msgstr ""
+msgstr "Sortierung und Filterung sind unabhängig von Groß- und Kleinschreibung"
 
 #: builtin/branch.c:698
 msgid "Failed to resolve HEAD as a valid ref."
 msgstr "Konnte HEAD nicht als gültige Referenz auflösen."
 
 #: builtin/branch.c:702 builtin/clone.c:706
 msgid "HEAD not found below refs/heads!"
 msgstr "HEAD wurde nicht unter \"refs/heads\" gefunden!"
@@ -6211,30 +6202,30 @@ msgid "Would skip repository %s\n"
 msgstr "Würde Repository %s überspringen\n"
 
 #: builtin/clean.c:33
 #, c-format
 msgid "failed to remove %s"
 msgstr "Fehler beim Löschen von %s"
 
 #: builtin/clean.c:291 git-add--interactive.perl:623
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Prompt help:\n"
 "1          - select a numbered item\n"
 "foo        - select item based on unique prefix\n"
 "           - (empty) select nothing\n"
 msgstr ""
 "Eingabehilfe:\n"
 "1          - nummeriertes Element auswählen\n"
 "foo        - Element anhand eines eindeutigen Präfix auswählen\n"
-"           - (leer) nichts auswählen"
+"           - (leer) nichts auswählen\n"
 
 #: builtin/clean.c:295 git-add--interactive.perl:632
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "Prompt help:\n"
 "1          - select a single item\n"
 "3-5        - select a range of items\n"
 "2-3,6-9    - select multiple ranges\n"
 "foo        - select item based on unique prefix\n"
 "-...       - unselect specified items\n"
 "*          - choose all items\n"
@@ -6242,23 +6233,23 @@ msgid ""
 msgstr ""
 "Eingabehilfe:\n"
 "1          - einzelnes Element auswählen\n"
 "3-5        - Bereich von Elementen auswählen\n"
 "2-3,6-9    - mehrere Bereiche auswählen\n"
 "foo        - Element anhand eines eindeutigen Präfix auswählen\n"
 "-...       - angegebenes Element abwählen\n"
 "*          - alle Elemente auswählen\n"
-"           - (leer) Auswahl beenden"
+"           - (leer) Auswahl beenden\n"
 
 #: builtin/clean.c:511 git-add--interactive.perl:598
 #: git-add--interactive.perl:603
-#, fuzzy, c-format, perl-format
+#, c-format, perl-format
 msgid "Huh (%s)?\n"
-msgstr "Wie bitte (%s)?"
+msgstr "Wie bitte (%s)?\n"
 
 #: builtin/clean.c:653
 #, c-format
 msgid "Input ignore patterns>> "
 msgstr "Ignorier-Muster eingeben>> "
 
 #: builtin/clean.c:690
 #, c-format
@@ -6271,19 +6262,19 @@ msgstr "Wählen Sie Einträge zum Löschen"
 
 #. TRANSLATORS: Make sure to keep [y/N] as is
 #: builtin/clean.c:752
 #, c-format
 msgid "Remove %s [y/N]? "
 msgstr "'%s' löschen [y/N]? "
 
 #: builtin/clean.c:777 git-add--interactive.perl:1669
-#, fuzzy, c-format
+#, c-format
 msgid "Bye.\n"
-msgstr "Tschüss."
+msgstr "Tschüss.\n"
 
 #: builtin/clean.c:785
 msgid ""
 "clean               - start cleaning\n"
 "filter by pattern   - exclude items from deletion\n"
 "select by numbers   - select items to be deleted by numbers\n"
 "ask each            - confirm each deletion (like \"rm -i\")\n"
 "quit                - stop cleaning\n"
@@ -6459,17 +6450,16 @@ msgstr ""
 "Zeit\n"
 "erstellen"
 
 #: builtin/clone.c:101 builtin/fetch.c:124
 msgid "revision"
 msgstr "Commit"
 
 #: builtin/clone.c:102 builtin/fetch.c:125
-#, fuzzy
 msgid "deepen history of shallow clone, excluding rev"
 msgstr ""
 "die Historie eines Klons mit unvollständiger Historie (shallow) mittels\n"
 "Ausschluss eines Commits vertiefen"
 
 #: builtin/clone.c:104
 msgid "clone only one branch, HEAD or --branch"
 msgstr "nur einen Branch klonen, HEAD oder --branch"
@@ -7699,100 +7689,101 @@ msgid "more than two blobs given: '%s'"
 msgstr "Mehr als zwei Blobs angegeben: '%s'"
 
 #: builtin/diff.c:417
 #, c-format
 msgid "unhandled object '%s' given."
 msgstr "unbehandeltes Objekt '%s' angegeben"
 
 #: builtin/difftool.c:28
-#, fuzzy
 msgid "git difftool [<options>] [<commit> [<commit>]] [--] [<path>...]"
-msgstr "git log [<Optionen>] [<Commitbereich>] [[--] <Pfad>...]"
+msgstr "git difftool [<Optionen>] [<Commit> [<Commit>]] [--] [<Pfad>...]"
 
 #: builtin/difftool.c:241
-#, fuzzy, c-format
+#, c-format
 msgid "failed: %d"
-msgstr "Anwendung des Patches fehlgeschlagen: %s:%ld"
+msgstr "fehlgeschlagen: %d"
 
 #: builtin/difftool.c:342
 msgid ""
 "combined diff formats('-c' and '--cc') are not supported in\n"
 "directory diff mode('-d' and '--dir-diff')."
 msgstr ""
+"Kombinierte Diff-Formate('-c' und '--cc') werden im Verzeichnis-\n"
+"Diff-Modus('-d' und '--dir-diff') nicht unterstützt."
 
 #: builtin/difftool.c:567
 #, c-format
 msgid "both files modified: '%s' and '%s'."
-msgstr ""
+msgstr "beide Dateien geändert: '%s' und '%s'."
 
 #: builtin/difftool.c:569
-#, fuzzy
 msgid "working tree file has been left."
-msgstr "Arbeitsverzeichnis '%s' existiert bereits."
+msgstr "Datei im Arbeitsverzeichnis belassen."
 
 #: builtin/difftool.c:580
 #, c-format
 msgid "temporary files exist in '%s'."
-msgstr ""
+msgstr "Es existieren temporäre Dateien in '%s'."
 
 #: builtin/difftool.c:581
 msgid "you may want to cleanup or recover these."
-msgstr ""
+msgstr "Sie könnten diese aufräumen oder wiederherstellen."
 
 #: builtin/difftool.c:626
 msgid "use `diff.guitool` instead of `diff.tool`"
-msgstr ""
+msgstr "`diff.guitool` anstatt `diff.tool` benutzen"
 
 #: builtin/difftool.c:628
 msgid "perform a full-directory diff"
-msgstr ""
+msgstr "Diff über ganzes Verzeichnis ausführen"
 
 #: builtin/difftool.c:630
 msgid "do not prompt before launching a diff tool"
-msgstr ""
+msgstr "keine Eingabeaufforderung vor Ausführung eines Diff-Tools"
 
 #: builtin/difftool.c:636
 msgid "use symlinks in dir-diff mode"
-msgstr ""
+msgstr "symbolische Verknüpfungen im dir-diff Modus verwenden"
 
 #: builtin/difftool.c:637
 msgid "<tool>"
-msgstr ""
+msgstr "<Tool>"
 
 #: builtin/difftool.c:638
 msgid "use the specified diff tool"
-msgstr ""
+msgstr "das angegebene Diff-Tool benutzen"
 
 #: builtin/difftool.c:640
 msgid "print a list of diff tools that may be used with `--tool`"
-msgstr ""
+msgstr "eine Liste mit Diff-Tools darstellen, die mit `--tool` benutzt werden können"
 
 #: builtin/difftool.c:643
 msgid ""
 "make 'git-difftool' exit when an invoked diff tool returns a non - zero exit "
 "code"
 msgstr ""
+"'git-difftool' beenden, wenn das aufgerufene Diff-Tool mit einem Rückkehrwert\n"
+"verschieden 0 ausgeführt wurde"
 
 #: builtin/difftool.c:645
-#, fuzzy
 msgid "<command>"
-msgstr "Programm"
+msgstr "<Programm>"
 
 #: builtin/difftool.c:646
 msgid "specify a custom command for viewing diffs"
-msgstr ""
+msgstr "eigenen Befehl zur Anzeige von Unterschieden angeben"
 
 #: builtin/difftool.c:670
 msgid "no <tool> given for --tool=<tool>"
-msgstr ""
+msgstr "kein <Tool> für --tool=<Tool> angegeben"
 
 #: builtin/difftool.c:677
 msgid "no <cmd> given for --extcmd=<cmd>"
-msgstr ""
+msgstr "kein <Programm> für --extcmd=<Programm> angegeben"
 
 #: builtin/fast-export.c:25
 msgid "git fast-export [rev-list-opts]"
 msgstr "git fast-export [rev-list-opts]"
 
 #: builtin/fast-export.c:980
 msgid "show progress after <n> objects"
 msgstr "Fortschritt nach <n> Objekten anzeigen"
@@ -8399,29 +8390,26 @@ msgstr "auch in Inhalten finden, die nicht von Git verwaltet werden"
 msgid "search in both tracked and untracked files"
 msgstr "in versionierten und unversionierten Dateien suchen"
 
 #: builtin/grep.c:979
 msgid "ignore files specified via '.gitignore'"
 msgstr "Dateien, die über '.gitignore' angegeben sind, ignorieren"
 
 #: builtin/grep.c:981
-#, fuzzy
 msgid "recursivley search in each submodule"
-msgstr "rekursive Anforderungen von Submodulen kontrollieren"
+msgstr "rekursive Suche in jedem Submodul"
 
 #: builtin/grep.c:983
-#, fuzzy
 msgid "basename"
-msgstr "umbenennen"
+msgstr "Basisname"
 
 #: builtin/grep.c:984
-#, fuzzy
 msgid "prepend parent project's basename to output"
-msgstr "dies an die Ausgabe der Submodul-Pfade voranstellen"
+msgstr "Basisname des Elternprojektes an Ausgaben voranstellen"
 
 #: builtin/grep.c:987
 msgid "show non-matching lines"
 msgstr "Zeilen ohne Übereinstimmungen anzeigen"
 
 #: builtin/grep.c:989
 msgid "case insensitive matching"
 msgstr "Übereinstimmungen unabhängig von Groß- und Kleinschreibung finden"
@@ -8590,17 +8578,17 @@ msgstr "ungültige Anzahl von Threads angegeben (%d)"
 #: builtin/grep.c:1215
 msgid "--open-files-in-pager only works on the worktree"
 msgstr ""
 "Die Option --open-files-in-pager kann nur innerhalb des "
 "Arbeitsverzeichnisses verwendet werden."
 
 #: builtin/grep.c:1238
 msgid "option not supported with --recurse-submodules."
-msgstr ""
+msgstr "Option wird mit --recurse-submodules nicht unterstützt."
 
 #: builtin/grep.c:1244
 msgid "--cached or --untracked cannot be used with --no-index."
 msgstr ""
 "Die Optionen --cached und --untracked können nicht mit --no-index verwendet "
 "werden."
 
 #: builtin/grep.c:1249
@@ -9068,20 +9056,18 @@ msgstr "Name der Paketdatei '%s' endet nicht mit '.pack'"
 msgid "bad %s"
 msgstr "%s ist ungültig"
 
 #: builtin/index-pack.c:1734
 msgid "--fix-thin cannot be used without --stdin"
 msgstr "Die Option --fix-thin kann nicht ohne --stdin verwendet werden."
 
 #: builtin/index-pack.c:1736
-#, fuzzy
 msgid "--stdin requires a git repository"
-msgstr ""
-"Die Option --index kann nicht außerhalb eines Repositories verwendet werden."
+msgstr "--stdin erfordert ein Git-Repository"
 
 #: builtin/index-pack.c:1744
 msgid "--verify with no packfile name given"
 msgstr "Die Option --verify wurde ohne Namen der Paketdatei angegeben."
 
 #: builtin/init-db.c:54
 #, c-format
 msgid "cannot stat '%s'"
@@ -9762,19 +9748,18 @@ msgstr "git merge [<Optionen>] [<Commit>...]"
 msgid "git merge [<options>] <msg> HEAD <commit>"
 msgstr "git merge [<Optionen>] <Beschreibung> HEAD <Commit>"
 
 #: builtin/merge.c:48
 msgid "git merge --abort"
 msgstr "git merge --abort"
 
 #: builtin/merge.c:49
-#, fuzzy
 msgid "git merge --continue"
-msgstr "git merge --abort"
+msgstr "git merge --continue"
 
 #: builtin/merge.c:104
 msgid "switch `m' requires a value"
 msgstr "Schalter 'm' erfordert einen Wert."
 
 #: builtin/merge.c:141
 #, c-format
 msgid "Could not find merge strategy '%s'.\n"
@@ -9854,19 +9839,18 @@ msgid "merge commit message (for a non-fast-forward merge)"
 msgstr ""
 "Commit-Beschreibung zusammenführen (für einen Merge, der kein Vorspulen war)"
 
 #: builtin/merge.c:227
 msgid "abort the current in-progress merge"
 msgstr "den sich im Gange befindlichen Merge abbrechen"
 
 #: builtin/merge.c:229
-#, fuzzy
 msgid "continue the current in-progress merge"
-msgstr "den sich im Gange befindlichen Merge abbrechen"
+msgstr "den sich im Gange befindlichen Merge fortsetzen"
 
 #: builtin/merge.c:231 builtin/pull.c:170
 msgid "allow merging unrelated histories"
 msgstr "erlaube das Zusammenführen von nicht zusammenhängenden Historien"
 
 #: builtin/merge.c:259
 msgid "could not run stash."
 msgstr "Konnte \"stash\" nicht ausführen."
@@ -10004,32 +9988,30 @@ msgstr "Konnte '%s' nicht schließen"
 msgid "not something we can merge in %s: %s"
 msgstr "nichts was wir in %s zusammenführen können: %s"
 
 #: builtin/merge.c:1099
 msgid "not something we can merge"
 msgstr "nichts was wir zusammenführen können"
 
 #: builtin/merge.c:1167
-#, fuzzy
 msgid "--abort expects no arguments"
-msgstr "%%(body) akzeptiert keine Argumente"
+msgstr "--abort akzeptiert keine Argumente"
 
 #: builtin/merge.c:1171
 msgid "There is no merge to abort (MERGE_HEAD missing)."
 msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
 
 #: builtin/merge.c:1183
 msgid "--continue expects no arguments"
-msgstr ""
+msgstr "--continue erwartet keine Argumente"
 
 #: builtin/merge.c:1187
-#, fuzzy
 msgid "There is no merge in progress (MERGE_HEAD missing)."
-msgstr "Es gibt keinen Merge zum Abbrechen (MERGE_HEAD fehlt)"
+msgstr "Es ist keine Merge im Gange (MERGE_HEAD fehlt)."
 
 #: builtin/merge.c:1203
 msgid ""
 "You have not concluded your merge (MERGE_HEAD exists).\n"
 "Please, commit your changes before you merge."
 msgstr ""
 "Sie haben Ihren Merge nicht abgeschlossen (MERGE_HEAD existiert).\n"
 "Bitte committen Sie Ihre Änderungen, bevor Sie den Merge ausführen."
@@ -11641,17 +11623,16 @@ msgstr "Anwendung des Filters für partielles Auschecken überspringen"
 msgid "debug unpack-trees"
 msgstr "unpack-trees protokollieren"
 
 #: builtin/receive-pack.c:26
 msgid "git receive-pack <git-dir>"
 msgstr "git receive-pack <Git-Verzeichnis>"
 
 #: builtin/receive-pack.c:793
-#, fuzzy
 msgid ""
 "By default, updating the current branch in a non-bare repository\n"
 "is denied, because it will make the index and work tree inconsistent\n"
 "with what you pushed, and will require 'git reset --hard' to match\n"
 "the work tree to HEAD.\n"
 "\n"
 "You can set the 'receive.denyCurrentBranch' configuration variable\n"
 "to 'ignore' or 'warn' in the remote repository to allow pushing into\n"
@@ -11664,17 +11645,17 @@ msgid ""
 msgstr ""
 "Standardmäßig wird die Aktualisierung des aktuellen Branches in einem\n"
 "nicht-Bare-Repository zurückgewiesen, da dies den Index und das Arbeits-\n"
 "verzeichnis inkonsistent zu dem machen würde, was Sie gepushed haben, und\n"
 "'git reset --hard' erforderlich wäre, damit das Arbeitsverzeichnis HEAD\n"
 "entspricht.\n"
 "\n"
 "Sie könnten die Konfigurationsvariable 'receive.denyCurrentBranch' im\n"
-"Remote-Repository zu 'ignore' oder 'warn' setzen, um den Push in den\n"
+"Remote-Repository auf 'ignore' oder 'warn' setzen, um den Push in den\n"
 "aktuellen Branch zu erlauben; dies wird jedoch nicht empfohlen außer\n"
 "Sie stellen durch andere Wege die Aktualität des Arbeitsverzeichnisses\n"
 "gegenüber dem gepushten Stand sicher.\n"
 "\n"
 "Um diese Meldung zu unterdrücken und das Standardverhalten zu behalten,\n"
 "setzen Sie die Konfigurationsvariable 'receive.denyCurrentBranch' auf\n"
 "'refuse'."
 
@@ -12237,16 +12218,19 @@ msgstr "Unbekannter Unterbefehl: %s"
 msgid "git repack [<options>]"
 msgstr "git repack [<Optionen>]"
 
 #: builtin/repack.c:22
 msgid ""
 "Incremental repacks are incompatible with bitmap indexes.  Use\n"
 "--no-write-bitmap-index or disable the pack.writebitmaps configuration."
 msgstr ""
+"Schrittweises Neupacken ist mit Bitmap-Indexen inkompatibel. Benutzen Sie\n"
+"--no-write-bitmap-index oder deaktivieren Sie die pack.writebitmaps\n"
+"Konfiguration."
 
 #: builtin/repack.c:166
 msgid "pack everything in a single pack"
 msgstr "alles in eine einzige Pack-Datei packen"
 
 #: builtin/repack.c:168
 msgid "same as -a, and turn unreachable objects loose"
 msgstr "genau wie -a, unerreichbare Objekte werden aber nicht gelöscht"
@@ -12740,19 +12724,19 @@ msgid "not removing '%s' recursively without -r"
 msgstr "'%s' wird nicht ohne -r rekursiv entfernt"
 
 #: builtin/rm.c:347
 #, c-format
 msgid "git rm: unable to remove %s"
 msgstr "git rm: konnte %s nicht löschen"
 
 #: builtin/rm.c:370
-#, fuzzy, c-format
+#, c-format
 msgid "could not remove '%s'"
-msgstr "Konnte Referenz '%s' nicht auflösen"
+msgstr "Konnte '%s' nicht löschen"
 
 #: builtin/send-pack.c:18
 msgid ""
 "git send-pack [--all | --mirror] [--dry-run] [--force] [--receive-pack=<git-"
 "receive-pack>] [--verbose] [--thin] [--atomic] [<host>:]<directory> "
 "[<ref>...]\n"
 "  --all and explicit <ref> specification are mutually exclusive."
 msgstr ""
@@ -12779,17 +12763,17 @@ msgid "print status from remote helper"
 msgstr "Status des Remote-Helpers ausgeben"
 
 #: builtin/shortlog.c:13
 msgid "git shortlog [<options>] [<revision-range>] [[--] [<path>...]]"
 msgstr "git shortlog [<Optionen>] [<Commitbereich>] [[--] [<Pfad>...]]"
 
 #: builtin/shortlog.c:249
 msgid "Group by committer rather than author"
-msgstr ""
+msgstr "über Commit-Ersteller anstatt Autor gruppieren"
 
 #: builtin/shortlog.c:251
 msgid "sort output according to the number of commits per author"
 msgstr "die Ausgabe entsprechend der Anzahl von Commits pro Autor sortieren"
 
 #: builtin/shortlog.c:253
 msgid "Suppress commit descriptions, only provides commit count"
 msgstr "Commit-Beschreibungen unterdrücken, nur Anzahl der Commits liefern"
@@ -13217,33 +13201,31 @@ msgstr "Fehlerhafter Wert für --update Parameter"
 msgid ""
 "Submodule (%s) branch configured to inherit branch from superproject, but "
 "the superproject is not on any branch"
 msgstr ""
 "Branch von Submodul (%s) ist konfiguriert, den Branch des Hauptprojektes\n"
 "zu erben, aber das Hauptprojekt befindet sich auf keinem Branch."
 
 #: builtin/submodule--helper.c:1106
-#, fuzzy
 msgid "recurse into submodules"
-msgstr "Rekursion in Submodulen durchführen"
+msgstr "Rekursion in Submodule durchführen"
 
 #: builtin/submodule--helper.c:1112
-#, fuzzy
 msgid "git submodule--helper embed-git-dir [<path>...]"
-msgstr "git submodule--helper init [<Pfad>]"
+msgstr "git submodule--helper embed-git-dir [<Pfad>...]"
 
 #: builtin/submodule--helper.c:1157
 msgid "submodule--helper subcommand must be called with a subcommand"
 msgstr "submodule--helper muss mit einem Unterbefehl aufgerufen werden"
 
 #: builtin/submodule--helper.c:1164
-#, fuzzy, c-format
+#, c-format
 msgid "%s doesn't support --super-prefix"
-msgstr "Server unterstützt kein --deepen"
+msgstr "%s unterstützt kein --super-prefix"
 
 #: builtin/submodule--helper.c:1170
 #, c-format
 msgid "'%s' is not a valid submodule--helper subcommand"
 msgstr "'%s' ist kein gültiger Unterbefehl von submodule--helper"
 
 #: builtin/symbolic-ref.c:7
 msgid "git symbolic-ref [<options>] <name> [<ref>]"
@@ -13290,19 +13272,18 @@ msgstr "git tag -d <Tagname>..."
 msgid ""
 "git tag -l [-n[<num>]] [--contains <commit>] [--points-at <object>]\n"
 "\t\t[--format=<format>] [--[no-]merged [<commit>]] [<pattern>...]"
 msgstr ""
 "git tag -l [-n[<Nummer>]] [--contains <Commit>] [--points-at <Objekt>]\n"
 "\t\t[--format=<Muster>] [--[no-]merged [<Commit>]] [<Muster>...]"
 
 #: builtin/tag.c:27
-#, fuzzy
 msgid "git tag -v [--format=<format>] <tagname>..."
-msgstr "git tag -v <Tagname>..."
+msgstr "git tag -v [--format=<Format>] <Tagname>..."
 
 #: builtin/tag.c:82
 #, c-format
 msgid "tag name too long: %.*s..."
 msgstr "Tagname zu lang: %.*s..."
 
 #: builtin/tag.c:87
 #, c-format
@@ -13762,19 +13743,18 @@ msgstr "git verify-pack [-v | --verbose] [-s | --stat-only] <Paket>..."
 msgid "verbose"
 msgstr "erweiterte Ausgaben"
 
 #: builtin/verify-pack.c:66
 msgid "show statistics only"
 msgstr "nur Statistiken anzeigen"
 
 #: builtin/verify-tag.c:18
-#, fuzzy
 msgid "git verify-tag [-v | --verbose] [--format=<format>] <tag>..."
-msgstr "git verify-tag [-v | --verbose] <Tag>..."
+msgstr "git verify-tag [-v | --verbose] [--format=<Format>] <Tag>..."
 
 #: builtin/verify-tag.c:36
 msgid "print tag contents"
 msgstr "Tag-Inhalte ausgeben"
 
 #: builtin/worktree.c:15
 msgid "git worktree add [<options>] <path> [<branch>]"
 msgstr "git worktree add [<Optionen>] <Pfad> [<Branch>]"
@@ -13816,24 +13796,22 @@ msgid "Removing worktrees/%s: invalid gitdir file"
 msgstr "Lösche worktrees/%s: ungültige gitdir-Datei"
 
 #: builtin/worktree.c:80
 #, c-format
 msgid "Removing worktrees/%s: gitdir file points to non-existent location"
 msgstr "Lösche worktrees/%s: gitdir-Datei verweist auf nicht existierenden Ort"
 
 #: builtin/worktree.c:128
-#, fuzzy
 msgid "report pruned working trees"
-msgstr "gelöschte Notizen melden"
+msgstr "entfernte Arbeitsverzeichnisse ausgeben"
 
 #: builtin/worktree.c:130
-#, fuzzy
 msgid "expire working trees older than <time>"
-msgstr "Objekte älter als <Zeit> verfallen lassen"
+msgstr "Arbeitsverzeichnisse älter als <Zeit> verfallen lassen"
 
 #: builtin/worktree.c:204
 #, c-format
 msgid "'%s' already exists"
 msgstr "'%s' existiert bereits"
 
 #: builtin/worktree.c:236
 #, c-format
@@ -13976,21 +13954,24 @@ msgstr ""
 
 #: http.c:1713
 #, c-format
 msgid ""
 "unable to update url base from redirection:\n"
 "  asked for: %s\n"
 "   redirect: %s"
 msgstr ""
+"Konnte Basis-URL nicht durch Umleitung aktualisieren:\n"
+"  gefragt nach: %s\n"
+"    umgeleitet: %s"
 
 #: remote-curl.c:319
 #, c-format
 msgid "redirecting to %s"
-msgstr ""
+msgstr "Leite nach %s um"
 
 #: common-cmds.h:9
 msgid "start a working area (see also: git help tutorial)"
 msgstr "Arbeitsverzeichnis anlegen (siehe auch: git help tutorial)"
 
 #: common-cmds.h:10
 msgid "work on the current change (see also: git help everyday)"
 msgstr "an aktuellen Änderungen arbeiten (siehe auch: git help everyday)"
@@ -14685,19 +14666,19 @@ msgid "repo URL: '$repo' must be absolute or begin with ./|../"
 msgstr "repo URL: '$repo' muss absolut sein oder mit ./|../ beginnen"
 
 #: git-submodule.sh:210
 #, sh-format
 msgid "'$sm_path' already exists in the index"
 msgstr "'$sm_path' ist bereits zum Commit vorgemerkt"
 
 #: git-submodule.sh:213
-#, fuzzy, sh-format
+#, sh-format
 msgid "'$sm_path' already exists in the index and is not a submodule"
-msgstr "'$sm_path' ist bereits zum Commit vorgemerkt"
+msgstr "'$sm_path' ist bereits zum Commit vorgemerkt und ist kein Submodul"
 
 #: git-submodule.sh:218
 #, sh-format
 msgid ""
 "The following path is ignored by one of your .gitignore files:\n"
 "$sm_path\n"
 "Use -f if you really want to add it."
 msgstr ""
@@ -15441,791 +15422,878 @@ msgstr ""
 #: git-sh-setup.sh:377
 msgid "Unable to determine absolute path of git directory"
 msgstr "Konnte absoluten Pfad des Git-Verzeichnisses nicht bestimmen."
 
 #. TRANSLATORS: you can adjust this to align "git add -i" status menu
 #: git-add--interactive.perl:238
 #, perl-format
 msgid "%12s %12s %s"
-msgstr ""
+msgstr "%28s %25s %s"
 
 #: git-add--interactive.perl:239
 msgid "staged"
-msgstr ""
+msgstr "zur Staging-Area hinzugefügt"
 
 #: git-add--interactive.perl:239
 msgid "unstaged"
-msgstr ""
+msgstr "aus Staging-Area entfernt"
 
 #: git-add--interactive.perl:297 git-add--interactive.perl:322
 msgid "binary"
-msgstr ""
+msgstr "Binär"
 
 #: git-add--interactive.perl:306 git-add--interactive.perl:360
 msgid "nothing"
-msgstr ""
+msgstr "Nichts"
 
 #: git-add--interactive.perl:342 git-add--interactive.perl:357
-#, fuzzy
 msgid "unchanged"
-msgstr "Keine Änderungen"
+msgstr "unverändert"
 
 #: git-add--interactive.perl:653
-#, fuzzy, perl-format
+#, perl-format
 msgid "added %d path\n"
 msgid_plural "added %d paths\n"
-msgstr[0] "von denen hinzugefügt:"
-msgstr[1] "von denen hinzugefügt:"
+msgstr[0] "%d Pfad hinzugefügt\n"
+msgstr[1] "%d Pfade hinzugefügt\n"
 
 #: git-add--interactive.perl:656
 #, perl-format
 msgid "updated %d path\n"
 msgid_plural "updated %d paths\n"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "%d Pfad aktualisiert\n"
+msgstr[1] "%d Pfade aktualisiert\n"
 
 #: git-add--interactive.perl:659
 #, perl-format
 msgid "reverted %d path\n"
 msgid_plural "reverted %d paths\n"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "%d Pfad wiederhergestellt\n"
+msgstr[1] "%d Pfade wiederhergestellt\n"
 
 #: git-add--interactive.perl:662
 #, perl-format
 msgid "touched %d path\n"
 msgid_plural "touched %d paths\n"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "%d Pfad angefasst\n"
+msgstr[1] "%d Pfade angefasst\n"
 
 #: git-add--interactive.perl:671
-#, fuzzy
 msgid "Update"
-msgstr "Datum"
+msgstr "Aktualisieren"
 
 #: git-add--interactive.perl:683
-#, fuzzy
 msgid "Revert"
 msgstr "Revert"
 
 #: git-add--interactive.perl:706
 #, perl-format
 msgid "note: %s is untracked now.\n"
-msgstr ""
+msgstr "Hinweis: %s ist nun unversioniert.\n"
 
 #: git-add--interactive.perl:717
-#, fuzzy
 msgid "Add untracked"
-msgstr " gefolgt"
+msgstr "unversionierte Dateien hinzufügen"
 
 #: git-add--interactive.perl:723
-#, fuzzy
 msgid "No untracked files.\n"
-msgstr "Unversionierte Dateien"
+msgstr "Keine unversionierten Dateien.\n"
 
 #: git-add--interactive.perl:1039
 msgid ""
 "If the patch applies cleanly, the edited hunk will immediately be\n"
 "marked for staging."
 msgstr ""
+"Wenn der Patch sauber angewendet werden kann, wird der bearbeitete Patch-Block\n"
+"direkt als zum Hinzufügen zur Staging-Area markiert."
 
 #: git-add--interactive.perl:1042
 msgid ""
 "If the patch applies cleanly, the edited hunk will immediately be\n"
 "marked for stashing."
 msgstr ""
+"Wenn der Patch sauber angewendet werden kann, wird der bearbeitete Patch-Block\n"
+"direkt als zum Hinzufügen zum Stash markiert."
 
 #: git-add--interactive.perl:1045
 msgid ""
 "If the patch applies cleanly, the edited hunk will immediately be\n"
 "marked for unstaging."
 msgstr ""
+"Wenn der Patch sauber angewendet werden kann, wird der bearbeitete Patch-Block\n"
+"direkt als zum Entfernen aus der Staging-Area markiert."
 
 #: git-add--interactive.perl:1048 git-add--interactive.perl:1057
 msgid ""
 "If the patch applies cleanly, the edited hunk will immediately be\n"
 "marked for applying."
 msgstr ""
+"Wenn der Patch sauber angewendet werden kann, wird der bearbeitete Patch-Block\n"
+"direkt als zum Anwenden markiert."
 
 #: git-add--interactive.perl:1051
 msgid ""
 "If the patch applies cleanly, the edited hunk will immediately be\n"
 "marked for discarding"
 msgstr ""
+"Wenn der Patch sauber angewendet werden kann, wird der bearbeitete Patch-Block\n"
+"direkt als zum Verwerfen markiert."
 
 #: git-add--interactive.perl:1054
 msgid ""
 "If the patch applies cleanly, the edited hunk will immediately be\n"
 "marked for discarding."
 msgstr ""
+"Wenn der Patch sauber angewendet werden kann, wird der bearbeitete Patch-Block\n"
+"direkt als zum Verwerfen markiert."
 
 #: git-add--interactive.perl:1067
-#, fuzzy, perl-format
+#, perl-format
 msgid "failed to open hunk edit file for writing: %s"
-msgstr "Fehler beim Erweitern des Nutzerverzeichnisses in: '%s'"
+msgstr "Fehler beim Öffnen von Editier-Datei eines Patch-Blocks zum Schreiben: %s"
 
 #: git-add--interactive.perl:1068
 msgid "Manual hunk edit mode -- see bottom for a quick guide.\n"
 msgstr ""
+"Manueller Editiermodus für Patch-Blöcke -- siehe nach unten für eine\n"
+"Kurzanleitung.\n"
 
 #: git-add--interactive.perl:1074
 #, perl-format
 msgid ""
 "---\n"
 "To remove '%s' lines, make them ' ' lines (context).\n"
 "To remove '%s' lines, delete them.\n"
 "Lines starting with %s will be removed.\n"
 msgstr ""
+"---\n"
+"Um '%s' Zeilen zu entfernen, machen Sie aus diesen ' ' Zeilen (Kontext).\n"
+"Um '%s' Zeilen zu entfernen, löschen Sie diese.\n"
+"Zeilen, die mit %s beginnen, werden entfernt.\n"
 
 #. TRANSLATORS: 'it' refers to the patch mentioned in the previous messages.
 #: git-add--interactive.perl:1082
 msgid ""
 "If it does not apply cleanly, you will be given an opportunity to\n"
 "edit again.  If all lines of the hunk are removed, then the edit is\n"
 "aborted and the hunk is left unchanged.\n"
 msgstr ""
+"Wenn das nicht sauber angewendet werden kann, haben Sie die Möglichkeit\n"
+"einer erneuten Bearbeitung. Wenn alle Zeilen des Patch-Blocks entfernt werden,\n"
+"wird die Bearbeitung abgebrochen und der Patch-Block bleibt unverändert.\n"
 
 #: git-add--interactive.perl:1096
-#, fuzzy, perl-format
+#, perl-format
 msgid "failed to open hunk edit file for reading: %s"
-msgstr "Fehler beim Erweitern des Nutzerverzeichnisses in: '%s'"
+msgstr "Fehler beim Öffnen von Editier-Datei eines Patch-Blocks zum Lesen: %s"
 
 #. TRANSLATORS: do not translate [y/n]
 #. The program will only accept that input
 #. at this point.
 #. Consider translating (saying "no" discards!) as
 #. (saying "n" for "no" discards!) if the translation
 #. of the word "no" does not start with n.
 #: git-add--interactive.perl:1187
 msgid ""
 "Your edited hunk does not apply. Edit again (saying \"no\" discards!) [y/n]? "
 msgstr ""
+"Ihr bearbeiteter Patch-Block kann nicht angewendet werden.\n"
+"Erneut bearbeiten? (\"n\" verwirft Bearbeitung!) [y/n]?"
 
 #: git-add--interactive.perl:1196
 msgid ""
 "y - stage this hunk\n"
 "n - do not stage this hunk\n"
 "q - quit; do not stage this hunk or any of the remaining ones\n"
 "a - stage this hunk and all later hunks in the file\n"
 "d - do not stage this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block zum Commit vormerken\n"
+"n - diesen Patch-Block nicht zum Commit vormerken\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht zum Commit vormerken\n"
+"a - diesen und alle weiteren Patch-Blöcke dieser Datei zum Commit vormerken\n"
+"d - diesen oder alle weiteren Patch-Blöcke in dieser Datei nicht zum Commit vormerken"
 
 #: git-add--interactive.perl:1202
 msgid ""
 "y - stash this hunk\n"
 "n - do not stash this hunk\n"
 "q - quit; do not stash this hunk or any of the remaining ones\n"
 "a - stash this hunk and all later hunks in the file\n"
 "d - do not stash this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block stashen\n"
+"n - diesen Patch-Block nicht stashen\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht stashen\n"
+"a - diesen und alle weiteren Patch-Blöcke dieser Datei stashen\n"
+"d - diesen oder alle weiteren Patch-Blöcke dieser Datei nicht stashen"
 
 #: git-add--interactive.perl:1208
 msgid ""
 "y - unstage this hunk\n"
 "n - do not unstage this hunk\n"
 "q - quit; do not unstage this hunk or any of the remaining ones\n"
 "a - unstage this hunk and all later hunks in the file\n"
 "d - do not unstage this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block unstashen\n"
+"n - diesen Patch-Block nicht unstashen\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht unstashen\n"
+"a - diesen und alle weiteren Patch-Blöcke dieser Datei unstashen\n"
+"d - diesen oder alle weiteren Patch-Blöcke dieser Datei nicht unstashen"
 
 #: git-add--interactive.perl:1214
 msgid ""
 "y - apply this hunk to index\n"
 "n - do not apply this hunk to index\n"
 "q - quit; do not apply this hunk or any of the remaining ones\n"
 "a - apply this hunk and all later hunks in the file\n"
 "d - do not apply this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block auf den Index anwenden\n"
+"n - diesen Patch-Block nicht auf den Index anwenden\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht auf den Index anwenden\n"
+"a - diesen und alle weiteren Patch-Blöcke dieser Datei auf den Index anwenden\n"
+"d - diesen oder alle weiteren Patch-Blöcke dieser Datei nicht auf den Index anwenden"
 
 #: git-add--interactive.perl:1220
 msgid ""
 "y - discard this hunk from worktree\n"
 "n - do not discard this hunk from worktree\n"
 "q - quit; do not discard this hunk or any of the remaining ones\n"
 "a - discard this hunk and all later hunks in the file\n"
 "d - do not discard this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block im Arbeitsverzeichnis verwerfen\n"
+"n - diesen Patch-Block im Arbeitsverzeichnis nicht verwerfen\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht im Arbeitsverzeichnis verwerfen\n"
+"a - diesen und alle weiteren Patch-Blöcke dieser Datei im Arbeitsverzeichnis verwerfen\n"
+"d - diesen oder alle weiteren Patch-Blöcke dieser Datei nicht im Arbeitsverzeichnis verwerfen"
 
 #: git-add--interactive.perl:1226
 msgid ""
 "y - discard this hunk from index and worktree\n"
 "n - do not discard this hunk from index and worktree\n"
 "q - quit; do not discard this hunk or any of the remaining ones\n"
 "a - discard this hunk and all later hunks in the file\n"
 "d - do not discard this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block im Index und Arbeitsverzeichnis verwerfen\n"
+"n - diesen Patch-Block nicht im Index und Arbeitsverzeichnis verwerfen\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht im Index und Arbeitsverzeichnis verwerfen\n"
+"a - diesen und alle weiteren Patch-Blöcke in der Datei verwerfen\n"
+"d - diesen oder alle weiteren Patch-Blöcke in der Datei nicht verwerfen"
 
 #: git-add--interactive.perl:1232
 msgid ""
 "y - apply this hunk to index and worktree\n"
 "n - do not apply this hunk to index and worktree\n"
 "q - quit; do not apply this hunk or any of the remaining ones\n"
 "a - apply this hunk and all later hunks in the file\n"
 "d - do not apply this hunk or any of the later hunks in the file"
 msgstr ""
+"y - diesen Patch-Block im Index und auf Arbeitsverzeichnis anwenden\n"
+"n - diesen Patch-Block nicht im Index und auf Arbeitsverzeichnis anwenden\n"
+"q - Beenden; diesen oder alle verbleibenden Patch-Blöcke nicht anwenden\n"
+"a - diesen und alle weiteren Patch-Blöcke in der Datei anwenden\n"
+"d - diesen oder alle weiteren Patch-Blöcke in der Datei nicht anwenden"
 
 #: git-add--interactive.perl:1241
 msgid ""
 "g - select a hunk to go to\n"
 "/ - search for a hunk matching the given regex\n"
 "j - leave this hunk undecided, see next undecided hunk\n"
 "J - leave this hunk undecided, see next hunk\n"
 "k - leave this hunk undecided, see previous undecided hunk\n"
 "K - leave this hunk undecided, see previous hunk\n"
 "s - split the current hunk into smaller hunks\n"
 "e - manually edit the current hunk\n"
 "? - print help\n"
 msgstr ""
+"g - Patch-Block zum Hinspringen auswählen\n"
+"/ - nach Patch-Block suchen der gegebenem regulärem Ausdruck entspricht\n"
+"j - diesen Patch-Block unbestimmt lassen, nächsten unbestimmten Patch-Block anzeigen\n"
+"J - diesen Patch-Block unbestimmt lassen, nächsten Patch-Block anzeigen\n"
+"k - diesen Patch-Block unbestimmt lassen, vorherigen unbestimmten Patch-Block anzeigen\n"
+"K - diesen Patch-Block unbestimmt lassen, vorherigen Patch-Block anzeigen\n"
+"s - aktuellen Patch-Block in kleinere Patch-Blöcke aufteilen\n"
+"e - aktuellen Patch-Block manuell editieren\n"
+"? - Hilfe anzeigen\n"
 
 #: git-add--interactive.perl:1272
-#, fuzzy
 msgid "The selected hunks do not apply to the index!\n"
-msgstr "den angegebenen Eintrag zum Commit vormerken"
+msgstr "Die ausgewählten Patch-Blöcke können nicht auf den Index angewendet werden!\n"
 
 #: git-add--interactive.perl:1273
-#, fuzzy
 msgid "Apply them to the worktree anyway? "
-msgstr "Pfad zum Arbeitsverzeichnis"
+msgstr "Trotzdem auf Arbeitsverzeichnis anwenden? "
 
 #: git-add--interactive.perl:1276
 msgid "Nothing was applied.\n"
-msgstr ""
+msgstr "Nichts angewendet.\n"
 
 #: git-add--interactive.perl:1287
-#, fuzzy, perl-format
+#, perl-format
 msgid "ignoring unmerged: %s\n"
-msgstr "Füge zusammengeführte Datei %s hinzu"
+msgstr "ignoriere nicht zusammengeführte Datei: %s\n"
 
 #: git-add--interactive.perl:1296
 msgid "Only binary files changed.\n"
-msgstr ""
+msgstr "Nur Binärdateien geändert.\n"
 
 #: git-add--interactive.perl:1298
-#, fuzzy
 msgid "No changes.\n"
-msgstr "Keine Änderungen"
+msgstr "Keine Änderungen.\n"
 
 #: git-add--interactive.perl:1306
-#, fuzzy
 msgid "Patch update"
-msgstr "[Tag Aktualisierung]"
+msgstr "Patch Aktualisierung"
 
 #: git-add--interactive.perl:1358
 #, perl-format
 msgid "Stage mode change [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung der Staging-Area hinzufügen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1359
 #, perl-format
 msgid "Stage deletion [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung der Staging-Area hinzufügen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1360
 #, perl-format
 msgid "Stage this hunk [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Diesen Patch-Block der Staging-Area hinzufügen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1363
 #, perl-format
 msgid "Stash mode change [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung stashen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1364
 #, perl-format
 msgid "Stash deletion [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung stashen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1365
 #, perl-format
 msgid "Stash this hunk [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Diesen Patch-Block stashen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1368
 #, perl-format
 msgid "Unstage mode change [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung aus der Staging-Area entfernen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1369
 #, perl-format
 msgid "Unstage deletion [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung aus der Staging-Area entfernen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1370
 #, perl-format
 msgid "Unstage this hunk [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Diesen Patch-Block aus der Staging-Area entfernen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1373
 #, perl-format
 msgid "Apply mode change to index [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung auf Index anwenden [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1374
 #, perl-format
 msgid "Apply deletion to index [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung auf Index anwenden [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1375
 #, perl-format
 msgid "Apply this hunk to index [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Diesen Patch-Block auf Index anwenden [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1378
 #, perl-format
 msgid "Discard mode change from worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1379
 #, perl-format
 msgid "Discard deletion from worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1380
 #, perl-format
 msgid "Discard this hunk from worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "diesen Patch-Block im Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1383
 #, perl-format
 msgid "Discard mode change from index and worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1384
 #, perl-format
 msgid "Discard deletion from index and worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1385
 #, perl-format
 msgid "Discard this hunk from index and worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Diesen Patch-Block vom Index und Arbeitsverzeichnis verwerfen [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1388
 #, perl-format
 msgid "Apply mode change to index and worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Modusänderung auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1389
 #, perl-format
 msgid "Apply deletion to index and worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Löschung auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1390
 #, perl-format
 msgid "Apply this hunk to index and worktree [y,n,q,a,d,/%s,?]? "
-msgstr ""
+msgstr "Diesen Patch-Block auf Index und Arbeitsverzeichnis anwenden [y,n,q,a,d,/%s,?]? "
 
 #: git-add--interactive.perl:1493
 msgid "go to which hunk (<ret> to see more)? "
-msgstr ""
+msgstr "zu welchem Patch-Block springen (<Enter> für mehr Informationen)? "
 
 #: git-add--interactive.perl:1495
 msgid "go to which hunk? "
-msgstr ""
+msgstr "zu welchem Patch-Block springen? "
 
 #: git-add--interactive.perl:1504
-#, fuzzy, perl-format
+#, perl-format
 msgid "Invalid number: '%s'\n"
-msgstr "Ungültiger %s: '%s'"
+msgstr "Ungültige Nummer: '%s'\n"
 
 #: git-add--interactive.perl:1509
 #, perl-format
 msgid "Sorry, only %d hunk available.\n"
 msgid_plural "Sorry, only %d hunks available.\n"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "Entschuldigung, nur %d Patch-Block verfügbar.\n"
+msgstr[1] "Entschuldigung, nur %d Patch-Blöcke verfügbar.\n"
 
 #: git-add--interactive.perl:1535
 msgid "search for regex? "
-msgstr ""
+msgstr "Suche nach regulärem Ausdruck? "
 
 #: git-add--interactive.perl:1548
 #, perl-format
 msgid "Malformed search regexp %s: %s\n"
-msgstr ""
+msgstr "Fehlerhafter regulärer Ausdruck für Suche %s: %s\n"
 
 #: git-add--interactive.perl:1558
-#, fuzzy
 msgid "No hunk matches the given pattern\n"
-msgstr "Änderungen nur im angegebenen Pfad anwenden"
+msgstr "Kein Patch-Block entspricht dem angegebenen Pattern\n"
 
 #: git-add--interactive.perl:1570 git-add--interactive.perl:1592
 msgid "No previous hunk\n"
-msgstr ""
+msgstr "Kein vorheriger Patch-Block\n"
 
 #: git-add--interactive.perl:1579 git-add--interactive.perl:1598
 msgid "No next hunk\n"
-msgstr ""
+msgstr "Kein folgender Patch-Block\n"
 
 #: git-add--interactive.perl:1606
 #, perl-format
 msgid "Split into %d hunk.\n"
 msgid_plural "Split into %d hunks.\n"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "In %d Patch-Block aufgeteilt.\n"
+msgstr[1] "In %d Patch-Blöcke aufgeteilt.\n"
 
 #: git-add--interactive.perl:1658
 msgid "Review diff"
-msgstr ""
+msgstr "Diff überprüfen"
 
 #. TRANSLATORS: please do not translate the command names
 #. 'status', 'update', 'revert', etc.
 #: git-add--interactive.perl:1677
 msgid ""
 "status        - show paths with changes\n"
 "update        - add working tree state to the staged set of changes\n"
 "revert        - revert staged set of changes back to the HEAD version\n"
 "patch         - pick hunks and update selectively\n"
 "diff\t      - view diff between HEAD and index\n"
 "add untracked - add contents of untracked files to the staged set of "
 "changes\n"
 msgstr ""
+"status        - Pfade mit Änderungen anzeigen\n"
+"update        - Zustand des Arbeitsverzeichnisses den zum Commit vorgemerkten Änderungen hinzufügen\n"
+"revert        - zum Commit vorgemerkten Änderungen auf HEAD Version zurücksetzen\n"
+"patch         - Patch-Blöcke auswählen und selektiv aktualisieren\n"
+"diff\t      - Unterschiede zwischen HEAD und Index anzeigen\n"
+"add untracked - Inhalte von unversionierten Dateien zum Commit vormerken\n"
 
 #: git-add--interactive.perl:1694 git-add--interactive.perl:1699
 #: git-add--interactive.perl:1702 git-add--interactive.perl:1709
 #: git-add--interactive.perl:1713 git-add--interactive.perl:1719
 msgid "missing --"
-msgstr ""
+msgstr "-- fehlt"
 
 #: git-add--interactive.perl:1715
-#, fuzzy, perl-format
+#, perl-format
 msgid "unknown --patch mode: %s"
-msgstr "Unbekannter Wert für -s/--strategy: %s"
+msgstr "Unbekannter --patch Modus: %s"
 
 #: git-add--interactive.perl:1721 git-add--interactive.perl:1727
-#, fuzzy, perl-format
+#, perl-format
 msgid "invalid argument %s, expecting --"
-msgstr "ungültige Pfadspezifikation"
+msgstr "ungültiges Argument %s, erwarte --"
 
 #: git-send-email.perl:121
 msgid "local zone differs from GMT by a non-minute interval\n"
-msgstr ""
+msgstr "lokale Zeitzone unterscheidet sich von GMT nicht um einen Minutenintervall\n"
 
 #: git-send-email.perl:128 git-send-email.perl:134
 msgid "local time offset greater than or equal to 24 hours\n"
-msgstr ""
+msgstr "lokaler Zeit-Offset größer oder gleich 24 Stunden\n"
 
 #: git-send-email.perl:202 git-send-email.perl:208
 msgid "the editor exited uncleanly, aborting everything"
-msgstr ""
+msgstr "Der Editor wurde unsauber beendet, breche alles ab."
 
 #: git-send-email.perl:282
 #, perl-format
 msgid ""
 "'%s' contains an intermediate version of the email you were composing.\n"
-msgstr ""
+msgstr "'%s' enthält eine Zwischenversion der E-Mail, die Sie gerade verfassen.\n"
 
 #: git-send-email.perl:287
 #, perl-format
 msgid "'%s.final' contains the composed email.\n"
-msgstr ""
+msgstr "'%s.final' enthält die verfasste E-Mail.\n"
 
 #: git-send-email.perl:305
-#, fuzzy
 msgid "--dump-aliases incompatible with other options\n"
-msgstr "Die Option --dirty kann nicht mit Commits verwendet werden."
+msgstr "--dump-aliases ist mit anderen Optionen inkompatibel\n"
 
 #: git-send-email.perl:368 git-send-email.perl:623
-#, fuzzy
 msgid "Cannot run git format-patch from outside a repository\n"
-msgstr ""
-"Die Option --cached kann nicht außerhalb eines Repositories verwendet werden."
+msgstr "Kann 'git format-patch' nicht außerhalb eines Repositories ausführen.\n"
 
 #: git-send-email.perl:437
 #, perl-format
 msgid "Unknown --suppress-cc field: '%s'\n"
-msgstr ""
+msgstr "Unbekanntes --suppress-cc Feld: '%s'\n"
 
 #: git-send-email.perl:466
-#, fuzzy, perl-format
+#, perl-format
 msgid "Unknown --confirm setting: '%s'\n"
-msgstr "Unbekannter Commit %s"
+msgstr "Unbekannte --confirm Einstellung: '%s'\n"
 
 #: git-send-email.perl:498
 #, perl-format
 msgid "warning: sendmail alias with quotes is not supported: %s\n"
-msgstr ""
+msgstr "Warnung: sendemail Alias mit Anführungsstrichen wird nicht unterstützt: %s\n"
 
 #: git-send-email.perl:500
 #, perl-format
 msgid "warning: `:include:` not supported: %s\n"
-msgstr ""
+msgstr "Warnung: `:include:` wird nicht unterstützt: %s\n"
 
 #: git-send-email.perl:502
 #, perl-format
 msgid "warning: `/file` or `|pipe` redirection not supported: %s\n"
-msgstr ""
+msgstr "Warnung: `/file` oder `|pipe` Umleitung wird nicht unterstützt: %s\n"
 
 #: git-send-email.perl:507
 #, perl-format
 msgid "warning: sendmail line is not recognized: %s\n"
-msgstr ""
+msgstr "Warnung: sendmail Zeile wird nicht erkannt: %s\n"
 
 #: git-send-email.perl:589
 #, perl-format
 msgid ""
 "File '%s' exists but it could also be the range of commits\n"
 "to produce patches for.  Please disambiguate by...\n"
 "\n"
 "    * Saying \"./%s\" if you mean a file; or\n"
 "    * Giving --format-patch option if you mean a range.\n"
 msgstr ""
+"Datei '%s' existiert, aber es könnte auch der Bereich von Commits sein,\n"
+"für den Patches erzeugt werden sollen. Bitte machen Sie dies eindeutig\n"
+"indem Sie ...\n"
+"\n"
+"    * \"./%s\" angeben, wenn Sie eine Datei meinen, oder\n"
+"    * die Option --format-patch angeben, wenn Sie einen Commit-Bereich meinen\n"
 
 #: git-send-email.perl:610
-#, fuzzy, perl-format
+#, perl-format
 msgid "Failed to opendir %s: %s"
-msgstr "Fehler beim Öffnen von '%s': %s"
+msgstr "Fehler beim Öffnen von %s: %s"
 
 #: git-send-email.perl:634
 #, perl-format
 msgid ""
 "fatal: %s: %s\n"
 "warning: no patches were sent\n"
 msgstr ""
+"fatal: %s: %s\n"
+"Warnung: Es wurden keine Patches versendet.\n"
 
 #: git-send-email.perl:645
-#, fuzzy
 msgid ""
 "\n"
 "No patch files specified!\n"
 "\n"
-msgstr "kein Pfad angegeben"
+msgstr "\nkeine Patch-Dateien angegeben!\n\n"
 
 #: git-send-email.perl:658
-#, fuzzy, perl-format
+#, perl-format
 msgid "No subject line in %s?"
-msgstr "Objekt nicht gefunden: %s"
+msgstr "Keine Betreffzeile in %s?"
 
 #: git-send-email.perl:668
-#, fuzzy, perl-format
+#, perl-format
 msgid "Failed to open for writing %s: %s"
-msgstr "Fehler beim Öffnen von '%s': %s"
+msgstr "Fehler beim Öffnen von '%s' zum Schreiben: %s"
 
 #: git-send-email.perl:678
 msgid ""
 "Lines beginning in \"GIT:\" will be removed.\n"
 "Consider including an overall diffstat or table of contents\n"
 "for the patch you are writing.\n"
 "\n"
 "Clear the body content if you don't wish to send a summary.\n"
 msgstr ""
+"Zeilen, die mit \"GIT:\" beginnen, werden entfernt.\n"
+"Ziehen Sie in Betracht, einen allgemeinen \"diffstat\" oder ein\n"
+"Inhaltsverzeichnis, für den Patch den Sie schreiben, hinzuzufügen.\n"
+"\n"
+"Leeren Sie den Inhalt des Bodys, wenn Sie keine Zusammenfassung senden möchten.\n"
 
 #: git-send-email.perl:701
-#, fuzzy, perl-format
+#, perl-format
 msgid "Failed to open %s.final: %s"
-msgstr "Fehler beim Öffnen von '%s': %s"
+msgstr "Fehler beim Öffnen von %s.final: %s"
 
 #: git-send-email.perl:704
-#, fuzzy, perl-format
+#, perl-format
 msgid "Failed to open %s: %s"
-msgstr "Fehler beim Öffnen von '%s': %s"
+msgstr "Fehler beim Öffnen von %s: %s"
 
 #: git-send-email.perl:739
 msgid "To/Cc/Bcc fields are not interpreted yet, they have been ignored\n"
-msgstr ""
+msgstr "To/Cc/Bcc Felder wurden noch nicht interpretiert, sie wurden ignoriert\n"
 
 #: git-send-email.perl:748
 msgid "Summary email is empty, skipping it\n"
-msgstr ""
+msgstr "E-Mail mit Zusammenfassung ist leer, wird ausgelassen\n"
 
 #. TRANSLATORS: please keep [y/N] as is.
 #: git-send-email.perl:780
 #, perl-format
 msgid "Are you sure you want to use <%s> [y/N]? "
-msgstr ""
+msgstr "Sind Sie sich sicher, <%s> zu benutzen [y/N]? "
 
 #: git-send-email.perl:809
 msgid ""
 "The following files are 8bit, but do not declare a Content-Transfer-"
 "Encoding.\n"
 msgstr ""
+"Die folgenden Dateien sind 8-Bit, aber deklarieren kein\n"
+"Content-Transfer-Encoding.\n"
 
 #: git-send-email.perl:814
 msgid "Which 8bit encoding should I declare [UTF-8]? "
-msgstr ""
+msgstr "Welches 8-Bit-Encoding soll deklariert werden [UTF-8]? "
 
 #: git-send-email.perl:822
 #, perl-format
 msgid ""
 "Refusing to send because the patch\n"
 "\t%s\n"
 "has the template subject '*** SUBJECT HERE ***'. Pass --force if you really "
 "want to send.\n"
 msgstr ""
+"Versand zurückgewiesen, weil der Patch\n"
+"\t%s\n"
+"die Betreffzeilenvorlage '*** SUBJECT HERE ***' enthält. Geben Sie --force an,\n"
+"wenn Sie den Patch wirklich versenden wollen.\n"
 
 #: git-send-email.perl:841
 msgid "To whom should the emails be sent (if anyone)?"
-msgstr ""
+msgstr "An wen sollen die E-Mails versendet werden (wenn überhaupt jemand)?"
 
 #: git-send-email.perl:859
 #, perl-format
 msgid "fatal: alias '%s' expands to itself\n"
-msgstr ""
+msgstr "fatal: Alias '%s' erweitert sich zu sich selbst\n"
 
 #: git-send-email.perl:871
 msgid "Message-ID to be used as In-Reply-To for the first email (if any)? "
-msgstr ""
+msgstr "Message-ID zur Verwendung als In-Reply-To für die erste E-Mail (wenn eine existiert)? "
 
 #: git-send-email.perl:921 git-send-email.perl:929
 #, perl-format
 msgid "error: unable to extract a valid address from: %s\n"
-msgstr ""
+msgstr "Fehler: konnte keine gültige Adresse aus %s extrahieren\n"
 
 #. TRANSLATORS: Make sure to include [q] [d] [e] in your
 #. translation. The program will only accept English input
 #. at this point.
 #: git-send-email.perl:933
 msgid "What to do with this address? ([q]uit|[d]rop|[e]dit): "
-msgstr ""
+msgstr "Was soll mit dieser Adresse geschehen? (Beenden [q]|Löschen [d]|Bearbeiten [e]): "
 
 #: git-send-email.perl:1234
-#, fuzzy, perl-format
+#, perl-format
 msgid "CA path \"%s\" does not exist"
-msgstr "Pfad '%s' existiert nicht"
+msgstr "CA Pfad \"%s\" existiert nicht"
 
 #: git-send-email.perl:1309
 msgid ""
 "    The Cc list above has been expanded by additional\n"
 "    addresses found in the patch commit message. By default\n"
 "    send-email prompts before sending whenever this occurs.\n"
 "    This behavior is controlled by the sendemail.confirm\n"
 "    configuration setting.\n"
 "\n"
 "    For additional information, run 'git send-email --help'.\n"
 "    To retain the current behavior, but squelch this message,\n"
 "    run 'git config --global sendemail.confirm auto'.\n"
 "\n"
 msgstr ""
+"    Die Cc-Liste oberhalb wurde um zusätzliche Adressen erweitert, die in der\n"
+"    Commit-Beschreibung des Patches gefunden wurden. Wenn dies passiert, werden\n"
+"    Sie von send-email zu einer Eingabe aufgefordert. Dieses Verhalten wird\n"
+"    durch die Konfigurationseinstellung sendemail.confirm gesteuert.\n"
+"\n"
+"    Für weitere Informationen, führen Sie 'git send-email --help' aus.\n"
+"    Um das aktuelle Verhalten beizubehalten, aber diese Meldung zu unterdrücken,\n"
+"    führen Sie 'git config --global sendemail.confirm auto' aus.\n"
+"\n"
 
 #. TRANSLATORS: Make sure to include [y] [n] [q] [a] in your
 #. translation. The program will only accept English input
 #. at this point.
 #: git-send-email.perl:1324
 msgid "Send this email? ([y]es|[n]o|[q]uit|[a]ll): "
-msgstr ""
+msgstr "Diese E-Mail versenden? (Ja [y]|Nein [n]|Beenden [q]|Alle [a]): "
 
 #: git-send-email.perl:1327
 msgid "Send this email reply required"
-msgstr ""
+msgstr "Zum Versenden dieser E-Mail ist eine Antwort erforderlich."
 
 #: git-send-email.perl:1353
 msgid "The required SMTP server is not properly defined."
-msgstr ""
+msgstr "Der erforderliche SMTP-Server ist nicht korrekt definiert."
 
 #: git-send-email.perl:1397
-#, fuzzy, perl-format
+#, perl-format
 msgid "Server does not support STARTTLS! %s"
-msgstr "Server unterstützt kein --deepen"
+msgstr "Server unterstützt kein STARTTLS! %s"
 
 #: git-send-email.perl:1403
 msgid "Unable to initialize SMTP properly. Check config and use --smtp-debug."
 msgstr ""
+"Konnte SMTP nicht korrekt initialisieren. Bitte prüfen Sie Ihre Konfiguration\n"
+"und benutzen Sie --smtp-debug."
 
 #: git-send-email.perl:1421
-#, fuzzy, perl-format
+#, perl-format
 msgid "Failed to send %s\n"
-msgstr "Fehler beim Lesen von %s"
+msgstr "Fehler beim Senden %s\n"
 
 #: git-send-email.perl:1424
 #, perl-format
 msgid "Dry-Sent %s\n"
-msgstr ""
+msgstr "Probeversand %s\n"
 
 #: git-send-email.perl:1424
-#, fuzzy, perl-format
+#, perl-format
 msgid "Sent %s\n"
-msgstr "Lösche %s\n"
+msgstr "%s gesendet\n"
 
 #: git-send-email.perl:1426
 msgid "Dry-OK. Log says:\n"
-msgstr ""
+msgstr "Probeversand OK. Log enthält:\n"
 
 #: git-send-email.perl:1426
 msgid "OK. Log says:\n"
-msgstr ""
+msgstr "OK. Log enthält:\n"
 
 #: git-send-email.perl:1438
 msgid "Result: "
-msgstr ""
+msgstr "Ergebnis: "
 
 #: git-send-email.perl:1441
 msgid "Result: OK\n"
-msgstr ""
+msgstr "Ergebnis: OK\n"
 
 #: git-send-email.perl:1454
-#, fuzzy, perl-format
+#, perl-format
 msgid "can't open file %s"
-msgstr "Kann Datei '%s' nicht öffnen"
+msgstr "Kann Datei %s nicht öffnen"
 
 #: git-send-email.perl:1501 git-send-email.perl:1521
 #, perl-format
 msgid "(mbox) Adding cc: %s from line '%s'\n"
-msgstr ""
+msgstr "(mbox) Füge cc: hinzu: %s von Zeile '%s'\n"
 
 #: git-send-email.perl:1507
 #, perl-format
 msgid "(mbox) Adding to: %s from line '%s'\n"
-msgstr ""
+msgstr "(mbox) Füge to: hinzu: %s von Zeile '%s'\n"
 
 #: git-send-email.perl:1555
 #, perl-format
 msgid "(non-mbox) Adding cc: %s from line '%s'\n"
-msgstr ""
+msgstr "(non-mbox) Füge cc: hinzu: %s von Zeile '%s'\n"
 
 #: git-send-email.perl:1578
 #, perl-format
 msgid "(body) Adding cc: %s from line '%s'\n"
-msgstr ""
+msgstr "(body) Füge cc: hinzu: %s von Zeile '%s'\n"
 
 #: git-send-email.perl:1676
-#, fuzzy, perl-format
+#, perl-format
 msgid "(%s) Could not execute '%s'"
-msgstr "Konnte %s nicht entfernen"
+msgstr "(%s) Konnte '%s' nicht ausführen"
 
 #: git-send-email.perl:1683
 #, perl-format
 msgid "(%s) Adding %s: %s from: '%s'\n"
-msgstr ""
+msgstr "(%s) Füge %s: %s hinzu von: '%s'\n"
 
 #: git-send-email.perl:1687
-#, fuzzy, perl-format
+#, perl-format
 msgid "(%s) failed to close pipe to '%s'"
-msgstr "Konnte Datei nicht nach '%s' kopieren"
+msgstr "(%s) Fehler beim Schließen der Pipe nach '%s'"
 
 #: git-send-email.perl:1714
-#, fuzzy
 msgid "cannot send message as 7bit"
-msgstr "Kann keine Commit-Beschreibung für %s bekommen."
+msgstr "Kann Nachricht nicht als 7bit versenden."
 
 #: git-send-email.perl:1722
-#, fuzzy
 msgid "invalid transfer encoding"
-msgstr "Ungültige Referenz: %s"
+msgstr "Ungültiges Transfer-Encoding"
 
 #: git-send-email.perl:1741 git-send-email.perl:1792 git-send-email.perl:1802
-#, fuzzy, perl-format
+#, perl-format
 msgid "unable to open %s: %s\n"
-msgstr "kann %s nicht öffnen"
+msgstr "konnte %s nicht öffnen: %s\n"
 
 #: git-send-email.perl:1744
 #, perl-format
 msgid "%s: patch contains a line longer than 998 characters"
-msgstr ""
+msgstr "%s: Patch enthält eine Zeile, die länger als 998 Zeichen ist"
 
 #: git-send-email.perl:1760
 #, perl-format
 msgid "Skipping %s with backup suffix '%s'.\n"
-msgstr ""
+msgstr "Lasse %s mit Backup-Suffix '%s' aus.\n"
 
 #. TRANSLATORS: please keep "[y|N]" as is.
 #: git-send-email.perl:1764
 #, perl-format
 msgid "Do you really want to send %s? [y|N]: "
-msgstr ""
+msgstr "Wollen Sie %s wirklich versenden? [y|N]: "
 
 #~ msgid "Use an experimental blank-line-based heuristic to improve diffs"
 #~ msgstr ""
 #~ "eine experimentelle, auf Leerzeilen basierende Heuristik zur "
 #~ "Verbesserung\n"
 #~ "der Darstellung von Unterschieden verwenden"
 
 #~ msgid "Clever... amending the last one with dirty index."
-- 
2.12.0.rc1.72.g32572afd0

