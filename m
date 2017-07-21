Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E2AE220288
	for <e@80x24.org>; Fri, 21 Jul 2017 15:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754083AbdGUPNg (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Jul 2017 11:13:36 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35173 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754475AbdGUPLv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2017 11:11:51 -0400
Received: by mail-wm0-f65.google.com with SMTP id m75so992918wmb.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2017 08:11:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kGAy5kFgmyergyHB/3R+nod5U3MIwoA6ZHFdZuum+I=;
        b=QyDgccswTlVExCaE4IJKp3lpbUKiY5dpzUzpdNy7WUDkHpEuCTwNGB59TKYZ9StES4
         FTWDjZz3Ds9ihkH7zhT1TFOb0azqhA6DHSwNy9NYunmkFzmGteH4RdjcLrG1NksDN5qT
         c/G77q/keNTFar69NIE7xuq7dJ9y2hey4QL5PJK+KiAEQMxxVv7mRSuU7vswJHIwmcH5
         DCoR3PO5C0ExLHIHSH1d0ISExsNykOVIP8p8RRQON5F+CmCfvVcGioieiVar2Oo5WL70
         swyjOFmRrAsioXL9GPirz0x28yYsitSbJPM2oR9rY4ARhQwnNUr7SuKlXnO9RjRJVOrx
         +k9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kGAy5kFgmyergyHB/3R+nod5U3MIwoA6ZHFdZuum+I=;
        b=PybdaTli3zxpwwlo2lJYKLNCHfOUpR45HbSiFeZVgBVehFG0ml46bKwOLV6y2bp99I
         3gxrvq0M9GBpplxyfI8efbZRuks55dBtOE8XTWVjrV6qH1PeJSy2Z11TZ465kvI80hlI
         P2ttzda+3GCK0vcCJ2umF9bjfRLs5WtpQxD0BFoF7/aYGNOGEXENLmloBuY1kGKFuKCI
         yQ1eEsPUIrdp6flo6jQnYhKhmxYuhauIVuc3YS9e3+ThGAnzrjcdQebFELN+9eqV3KRz
         kL4G7eiIy2LDnCU5mpmzQqBBrZIEtlQKqUxJo6Hw8GUNdz6ZEWmL8VIwPlpfgtXyWxMd
         mcPw==
X-Gm-Message-State: AIVw110bemn5ilkGVeIZYO7XkvZjJ2wUhs5z9I74XO5eLw9k5W/YXno+
        ORM3toYkYgzKxG93
X-Received: by 10.80.154.131 with SMTP id p3mr6172477edb.181.1500649907794;
        Fri, 21 Jul 2017 08:11:47 -0700 (PDT)
Received: from localhost (cable-82-119-17-233.cust.telecolumbus.net. [82.119.17.233])
        by smtp.gmail.com with ESMTPSA id b22sm3148458edb.9.2017.07.21.08.11.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Jul 2017 08:11:46 -0700 (PDT)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org,
        =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>
Cc:     Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Jan=20Kr=C3=BCger?= <jk@jk.gs>,
        Christian Stimming <stimming@tuhh.de>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        =?UTF-8?q?Magnus=20G=C3=B6rlitz?= <magnus.goerlitz@googlemail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: de.po: update German translation
Date:   Fri, 21 Jul 2017 17:11:44 +0200
Message-Id: <20170721151144.4410-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.14.0.rc0.284.gd933b75aa
In-Reply-To: <4f846a80-dfd8-f895-3b90-df1f78041a9f@gmail.com>
References: <4f846a80-dfd8-f895-3b90-df1f78041a9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
Hi Matthias,

2017-07-20 20:36 GMT+02:00 Matthias Rüster <matthias.ruester@gmail.com>:
> Hi Ralf,
>
> I think the following should be "hinzugefügt":
>

Sure. Thanks for review!

Ciao,
Ralf

 po/de.po | 123 +++++++++++++++++++++++++++++++++------------------------------
 1 file changed, 64 insertions(+), 59 deletions(-)

diff --git a/po/de.po b/po/de.po
index 5619fa962..f905c7ec7 100644
--- a/po/de.po
+++ b/po/de.po
@@ -176,26 +176,26 @@ msgid "git apply: bad git-diff - inconsistent old filename on line %d"
 msgstr ""
 "git apply: ungültiges 'git-diff' - Inkonsistenter alter Dateiname in Zeile %d"
 
 #: apply.c:979
 #, c-format
 msgid "git apply: bad git-diff - expected /dev/null on line %d"
 msgstr "git apply: ungültiges 'git-diff' - erwartete /dev/null in Zeile %d"
 
 #: apply.c:1008
-#, fuzzy, c-format
+#, c-format
 msgid "invalid mode on line %d: %s"
-msgstr "Ungültige Identifikationszeile: %s"
+msgstr "Ungültiger Modus in Zeile %d: %s"
 
 #: apply.c:1326
 #, c-format
 msgid "inconsistent header lines %d and %d"
-msgstr ""
+msgstr "Inkonsistente Kopfzeilen %d und %d."
 
 #: apply.c:1498
 #, c-format
 msgid "recount: unexpected line: %.*s"
 msgstr "recount: unerwartete Zeile: %.*s"
 
 #: apply.c:1567
 #, c-format
 msgid "patch fragment without header at line %d: %.*s"
@@ -1528,27 +1528,27 @@ msgstr "LF würde in %s durch CRLF ersetzt werden."
 
 #: date.c:116
 msgid "in the future"
 msgstr "in der Zukunft"
 
 #: date.c:122 date.c:129 date.c:136 date.c:143 date.c:149 date.c:156 date.c:167
 #: date.c:175 date.c:180
 msgid "%"
 msgid_plural "%"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "%"
+msgstr[1] "%"
 
 #. TRANSLATORS: "%s" is "<n> years"
 #: date.c:170
 msgid "%s, %"
 msgid_plural "%s, %"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "%s, %"
+msgstr[1] "%s, %"
 
 #: diffcore-order.c:24
 #, c-format
 msgid "failed to read orderfile '%s'"
 msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
 
 #: diffcore-rename.c:536
 msgid "Performing inexact rename detection"
 msgstr "Führe Erkennung für ungenaue Umbenennung aus"
@@ -1890,53 +1890,50 @@ msgid ""
 msgstr ""
 "'%s' scheint ein git-Befehl zu sein, konnte aber\n"
 "nicht ausgeführt werden. Vielleicht ist git-%s fehlerhaft?"
 
 #: help.c:336
 msgid "Uh oh. Your system reports no Git commands at all."
 msgstr "Uh oh. Keine Git-Befehle auf Ihrem System vorhanden."
 
 #: help.c:358
-#, fuzzy, c-format
+#, c-format
 msgid "WARNING: You called a Git command named '%s', which does not exist."
-msgstr ""
-"Warnung: Sie haben den nicht existierenden Git-Befehl '%s' ausgeführt.\n"
-"Setze fort unter der Annahme, dass Sie '%s' gemeint haben."
+msgstr "WARNUNG: Sie haben Git-Befehl '%s' ausgeführt, welcher nicht existiert."
 
 #: help.c:363
 #, c-format
 msgid "Continuing under the assumption that you meant '%s'."
-msgstr ""
+msgstr "Setze fort unter der Annahme, dass Sie '%s' meinten."
 
 #: help.c:368
 #, c-format
 msgid "Continuing in %0.1f seconds, assuming that you meant '%s'."
-msgstr ""
+msgstr "Setze in %0.1f Sekunden fort unter der Annahme, dass Sie '%s' meinten."
 
 #: help.c:376
 #, c-format
 msgid "git: '%s' is not a git command. See 'git --help'."
 msgstr "git: '%s' ist kein Git-Befehl. Siehe 'git --help'."
 
 #: help.c:380
 msgid ""
 "\n"
 "The most similar command is"
 msgid_plural ""
 "\n"
 "The most similar commands are"
-msgstr[0] ""
-msgstr[1] ""
+msgstr[0] "\nDer ähnlichste Befehl ist"
+msgstr[1] "\nDie ähnlichsten Befehle sind"
 
 #: help.c:395
-#, fuzzy
 msgid "git version [<options>]"
-msgstr "git column [<Optionen>]"
+msgstr "git version [<Optionen>]"
 
 #: help.c:456
 #, c-format
 msgid "%s: %s - %s"
 msgstr "%s: %s - %s"
 
 #: help.c:460
 msgid ""
 "\n"
@@ -3361,21 +3358,21 @@ msgstr ""
 "Ausführung erfolgreich: %s\n"
 "Aber Änderungen in Index oder Arbeitsverzeichnis verblieben.\n"
 "Committen Sie Ihre Änderungen oder benutzen Sie \"stash\".\n"
 "Führen Sie dann aus:\n"
 "\n"
 "  git rebase --continue\n"
 "\n"
 
 #: sequencer.c:1925
-#, fuzzy, c-format
+#, c-format
 msgid "Applied autostash.\n"
-msgstr "Automatischen Stash angewendet."
+msgstr "Automatischen Stash angewendet.\n"
 
 #: sequencer.c:1937
 #, c-format
 msgid "cannot store %s"
 msgstr "kann %s nicht speichern"
 
 #: sequencer.c:1940 git-rebase.sh:173
 #, c-format
 msgid ""
@@ -3649,21 +3646,21 @@ msgstr "Konnte Eintrag '%s' nicht aus .gitmodules entfernen"
 #: submodule.c:126
 msgid "staging updated .gitmodules failed"
 msgstr "Konnte aktualisierte .gitmodules-Datei nicht zum Commit vormerken"
 
 #: submodule.c:165
 msgid "negative values not allowed for submodule.fetchJobs"
 msgstr "Negative Werte für submodule.fetchJobs nicht erlaubt"
 
 #: submodule.c:376
-#, fuzzy, c-format
+#, c-format
 msgid "in unpopulated submodule '%s'"
-msgstr "Überspringe Submodul '%s'"
+msgstr "In nicht ausgechecktem Submodul '%s'."
 
 #: submodule.c:407
 #, c-format
 msgid "Pathspec '%s' is in submodule '%.*s'"
 msgstr "Pfadspezifikation '%s' befindet sich in Submodul '%.*s'"
 
 #: submodule.c:1337
 #, c-format
 msgid "'%s' not recognized as a git repository"
@@ -4330,23 +4327,23 @@ msgstr "neue Commits, "
 #: wt-status.c:374
 msgid "modified content, "
 msgstr "geänderter Inhalt, "
 
 #: wt-status.c:376
 msgid "untracked content, "
 msgstr "unversionierter Inhalt, "
 
 #: wt-status.c:821
-#, fuzzy, c-format
+#, c-format
 msgid "Your stash currently has %d entry"
 msgid_plural "Your stash currently has %d entries"
-msgstr[0] "Sie sind gerade beim Rebase."
-msgstr[1] "Sie sind gerade beim Rebase."
+msgstr[0] "Ihr Stash hat gerade %d Eintrag"
+msgstr[1] "Ihr Stash hat gerade %d Einträge"
 
 #: wt-status.c:853
 msgid "Submodules changed but not updated:"
 msgstr "Submodule geändert, aber nicht aktualisiert:"
 
 #: wt-status.c:855
 msgid "Submodule changes to be committed:"
 msgstr "Änderungen in Submodul zum Committen:"
 
@@ -4587,21 +4584,20 @@ msgstr "HEAD losgelöst von "
 #: wt-status.c:1586
 msgid "Not currently on any branch."
 msgstr "Im Moment auf keinem Branch."
 
 #: wt-status.c:1606
 msgid "Initial commit"
 msgstr "Initialer Commit"
 
 #: wt-status.c:1607
-#, fuzzy
 msgid "No commits yet"
-msgstr "Keine Commits geparst."
+msgstr "Noch keine Commits"
 
 #: wt-status.c:1621
 msgid "Untracked files"
 msgstr "Unversionierte Dateien"
 
 #: wt-status.c:1623
 msgid "Ignored files"
 msgstr "Ignorierte Dateien"
 
@@ -4674,21 +4670,20 @@ msgstr ""
 "nichts zu committen (benutzen Sie die Option -u, um unversionierte Dateien "
 "anzuzeigen)\n"
 
 #: wt-status.c:1668
 #, c-format
 msgid "nothing to commit, working tree clean\n"
 msgstr "nichts zu committen, Arbeitsverzeichnis unverändert\n"
 
 #: wt-status.c:1780
-#, fuzzy
 msgid "No commits yet on "
-msgstr "Keine Befehle ausgeführt."
+msgstr "Noch keine Commits in "
 
 #: wt-status.c:1784
 msgid "HEAD (no branch)"
 msgstr "HEAD (kein Branch)"
 
 #: wt-status.c:1813 wt-status.c:1821
 msgid "behind "
 msgstr "hinterher "
 
@@ -4834,44 +4829,57 @@ msgstr "prüfen ob - auch fehlende - Dateien im Probelauf ignoriert werden"
 #: builtin/add.c:286 builtin/update-index.c:952
 msgid "(+/-)x"
 msgstr "(+/-)x"
 
 #: builtin/add.c:286 builtin/update-index.c:953
 msgid "override the executable bit of the listed files"
 msgstr "das \"ausführbar\"-Bit der aufgelisteten Dateien überschreiben"
 
 #: builtin/add.c:288
-#, fuzzy
 msgid "warn when adding an embedded repository"
-msgstr "ein Bare-Repository erstellen"
+msgstr "warnen wenn eingebettetes Repository hinzugefügt wird"
 
 #: builtin/add.c:303
 #, c-format
 msgid ""
 "You've added another git repository inside your current repository.\n"
 "Clones of the outer repository will not contain the contents of\n"
 "the embedded repository and will not know how to obtain it.\n"
 "If you meant to add a submodule, use:\n"
 "\n"
 "\tgit submodule add <url> %s\n"
 "\n"
 "If you added this path by mistake, you can remove it from the\n"
 "index with:\n"
 "\n"
 "\tgit rm --cached %s\n"
 "\n"
 "See \"git help submodule\" for more information."
 msgstr ""
+"Sie haben ein Git-Repository innerhalb ihres aktuellen Repositories hinzugefügt.\n"
+"Klone des äußeren Repositories werden die Inhalte des eingebetteten Repositories\n"
+"weder enthalten, noch wissen, wie diese zu beschaffen sind.\n"
+"Wenn Sie ein Submodul hinzufügen wollten, benutzen Sie:\n"
+"\n"
+"\tgit submodule add <URL> %s\n"
+"\n"
+"Wenn Sie diesen Pfad aus Versehen hinzugefügt haben, können Sie diesen mit\n"
+"\n"
+"\tgit rm --cached %s\n"
+"\n"
+"vom Index entfernen.\n"
+"\n"
+"Siehe \"git help submodule\" für weitere Informationen."
 
 #: builtin/add.c:331
-#, fuzzy, c-format
+#, c-format
 msgid "adding embedded git repository: %s"
-msgstr "--stdin erfordert ein Git-Repository"
+msgstr "Füge eingebettetes Repository hinzu: %s"
 
 #: builtin/add.c:349
 #, c-format
 msgid "Use -f if you really want to add them.\n"
 msgstr "Verwenden Sie -f wenn Sie diese wirklich hinzufügen möchten.\n"
 
 #: builtin/add.c:357
 msgid "adding files failed"
 msgstr "Hinzufügen von Dateien fehlgeschlagen"
@@ -4983,26 +4991,25 @@ msgstr ""
 
 #: builtin/am.c:1173
 #, c-format
 msgid "To restore the original branch and stop patching, run \"%s --abort\"."
 msgstr ""
 "Um den ursprünglichen Branch wiederherzustellen und die Anwendung der "
 "Patches abzubrechen, führen Sie \"%s --abort\" aus."
 
 #: builtin/am.c:1304
-#, fuzzy
 msgid "Patch is empty."
-msgstr "Der aktuelle Patch ist leer."
+msgstr "Patch ist leer."
 
 #: builtin/am.c:1370
-#, fuzzy, c-format
+#, c-format
 msgid "invalid ident line: %.*s"
-msgstr "Ungültige Identifikationszeile: %s"
+msgstr "Ungültige Identifikationszeile: %.*s"
 
 #: builtin/am.c:1392
 #, c-format
 msgid "unable to parse commit %s"
 msgstr "Konnte Commit '%s' nicht parsen."
 
 #: builtin/am.c:1586
 msgid "Repository lacks necessary blobs to fall back on 3-way merge."
 msgstr ""
@@ -5103,18 +5110,23 @@ msgstr ""
 "auslassen."
 
 #: builtin/am.c:1922
 msgid ""
 "You still have unmerged paths in your index.\n"
 "You should 'git add' each file with resolved conflicts to mark them as "
 "such.\n"
 "You might run `git rm` on a file to accept \"deleted by them\" for it."
 msgstr ""
+"Sie haben noch immer nicht zusammengeführte Pfade in Ihrem Index.\n"
+"Sie sollten 'git add' für jede Datei mit aufgelösten Konflikten ausführen,\n"
+"um diese als solche zu markieren.\n"
+"Sie können 'git rm' auf Dateien ausführen, um \"von denen gelöscht\" für\n"
+"diese zu akzeptieren."
 
 #: builtin/am.c:2031 builtin/am.c:2035 builtin/am.c:2047 builtin/reset.c:323
 #: builtin/reset.c:331
 #, c-format
 msgid "Could not parse object '%s'."
 msgstr "Konnte Objekt '%s' nicht parsen."
 
 #: builtin/am.c:2083
 msgid "failed to clean index"
@@ -6388,19 +6400,19 @@ msgid "Missing branch name; try -b"
 msgstr "Vermisse Branchnamen; versuchen Sie -b"
 
 #: builtin/checkout.c:1261
 msgid "invalid path specification"
 msgstr "ungültige Pfadspezifikation"
 
 #: builtin/checkout.c:1268
 #, c-format
 msgid "'%s' is not a commit and a branch '%s' cannot be created from it"
-msgstr ""
+msgstr "'%s' ist kein Commit und es kann kein Branch '%s' aus diesem erstellt werden."
 
 #: builtin/checkout.c:1272
 #, c-format
 msgid "git checkout: --detach does not take a path argument '%s'"
 msgstr "git checkout: --detach nimmt kein Pfad-Argument '%s'"
 
 #: builtin/checkout.c:1276
 msgid ""
 "git checkout: --ours/--theirs, --force and --merge are incompatible when\n"
@@ -6700,19 +6712,19 @@ msgstr ""
 "die Historie eines Klons mit unvollständiger Historie (shallow) mittels\n"
 "Ausschluss eines Commits vertiefen"
 
 #: builtin/clone.c:124
 msgid "clone only one branch, HEAD or --branch"
 msgstr "nur einen Branch klonen, HEAD oder --branch"
 
 #: builtin/clone.c:126
 msgid "don't clone any tags, and make later fetches not to follow them"
-msgstr ""
+msgstr "keine Tags klonen, und auch bei späteren Abrufen nicht beachten"
 
 #: builtin/clone.c:128
 msgid "any cloned submodules will be shallow"
 msgstr "jedes geklonte Submodul mit unvollständiger Historie (shallow)"
 
 #: builtin/clone.c:129 builtin/init-db.c:485
 msgid "gitdir"
 msgstr ".git-Verzeichnis"
 
@@ -6906,20 +6918,20 @@ msgstr ""
 #: builtin/clone.c:1071
 msgid "--shallow-exclude is ignored in local clones; use file:// instead."
 msgstr ""
 "--shallow-exclude wird in lokalen Klonen ignoriert; benutzen Sie stattdessen "
 "file://"
 
 #: builtin/clone.c:1074
 msgid "source repository is shallow, ignoring --local"
 msgstr ""
-"Quelle ist ein Repository mit unvollständiger Historie (shallow),ignoriere --"
-"local"
+"Quelle ist ein Repository mit unvollständiger Historie (shallow),\n"
+"--local wird ignoriert"
 
 #: builtin/clone.c:1079
 msgid "--local is ignored"
 msgstr "--local wird ignoriert"
 
 #: builtin/clone.c:1083
 #, c-format
 msgid "Don't know how to clone %s"
 msgstr "Weiß nicht wie %s zu klonen ist."
@@ -7324,21 +7336,20 @@ msgstr "Die Option -a kann nicht mit der Angabe von Pfaden verwendet werden."
 #: builtin/commit.c:1342 builtin/commit.c:1617
 msgid "show status concisely"
 msgstr "Status im Kurzformat anzeigen"
 
 #: builtin/commit.c:1344 builtin/commit.c:1619
 msgid "show branch information"
 msgstr "Branchinformationen anzeigen"
 
 #: builtin/commit.c:1346
-#, fuzzy
 msgid "show stash information"
-msgstr "Branchinformationen anzeigen"
+msgstr "Stashinformationen anzeigen"
 
 #: builtin/commit.c:1348
 msgid "version"
 msgstr "Version"
 
 #: builtin/commit.c:1348 builtin/commit.c:1621 builtin/push.c:530
 #: builtin/worktree.c:449
 msgid "machine-readable output"
 msgstr "maschinenlesbare Ausgabe"
@@ -7733,22 +7744,20 @@ msgid ""
 "#\temail = %s\n"
 msgstr ""
 "# Das ist Git's benutzerspezifische Konfiguraionsdatei.\n"
 "[user]\n"
 "# Bitte passen Sie die folgenden Zeilen an und kommentieren Sie diese aus:\n"
 "#\tname = %s\n"
 "#\temail = %s\n"
 
 #: builtin/config.c:499
-#, fuzzy
 msgid "--local can only be used inside a git repository"
-msgstr ""
-"Die Option --cached kann nicht außerhalb eines Repositories verwendet werden."
+msgstr "--local kann nur innerhalb eines Git-Repositories verwendet werden."
 
 #: builtin/config.c:621
 #, c-format
 msgid "cannot create configuration file %s"
 msgstr "Konnte Konfigurationsdatei '%s' nicht erstellen."
 
 #: builtin/config.c:633
 #, c-format
 msgid ""
@@ -8213,18 +8222,20 @@ msgstr "Verzeichnis"
 #: builtin/fetch.c:127
 msgid "prepend this to submodule path output"
 msgstr "dies an die Ausgabe der Submodul-Pfade voranstellen"
 
 #: builtin/fetch.c:130
 msgid ""
 "default for recursive fetching of submodules (lower priority than config "
 "files)"
 msgstr ""
+"Standard für die rekursive Anforderung von Submodulen (geringere Priorität\n"
+"als Konfigurationsdateien)"
 
 #: builtin/fetch.c:134 builtin/pull.c:212
 msgid "accept refs that update .git/shallow"
 msgstr "Referenzen, die .git/shallow aktualisieren, akzeptieren"
 
 #: builtin/fetch.c:135 builtin/pull.c:214
 msgid "refmap"
 msgstr "Refmap"
 
@@ -8883,21 +8894,20 @@ msgstr "--no-index oder --untracked können nicht mit Commits verwendet werden"
 msgid "unable to resolve revision: %s"
 msgstr "Konnte Commit nicht auflösen: %s"
 
 #: builtin/grep.c:1245 builtin/index-pack.c:1490
 #, c-format
 msgid "invalid number of threads specified (%d)"
 msgstr "ungültige Anzahl von Threads angegeben (%d)"
 
 #: builtin/grep.c:1250
-#, fuzzy
 msgid "no threads support, ignoring --threads"
-msgstr "keine Unterstützung von Threads, '%s' wird ignoriert"
+msgstr "keine Unterstützung von Threads, --threads wird ignoriert"
 
 #: builtin/grep.c:1281
 msgid "--open-files-in-pager only works on the worktree"
 msgstr ""
 "Die Option --open-files-in-pager kann nur innerhalb des "
 "Arbeitsverzeichnisses verwendet werden."
 
 #: builtin/grep.c:1304
 msgid "option not supported with --recurse-submodules."
@@ -10054,19 +10064,19 @@ msgstr "vollständige Pfadnamen verwenden"
 #: builtin/ls-tree.c:144
 msgid "list entire tree; not just current directory (implies --full-name)"
 msgstr ""
 "das gesamte Verzeichnis auflisten; nicht nur das aktuelle Verzeichnis "
 "(impliziert --full-name)"
 
 #: builtin/mailsplit.c:241
 #, c-format
 msgid "empty mbox: '%s'"
-msgstr ""
+msgstr "Leere mbox: '%s'"
 
 #: builtin/merge.c:47
 msgid "git merge [<options>] [<commit>...]"
 msgstr "git merge [<Optionen>] [<Commit>...]"
 
 #: builtin/merge.c:48
 msgid "git merge --abort"
 msgstr "git merge --abort"
 
@@ -11376,19 +11386,18 @@ msgstr "kann \"prune\" in precious-objects Repository nicht ausführen"
 #, c-format
 msgid "Invalid value for %s: %s"
 msgstr "Ungültiger Wert für %s: %s"
 
 #: builtin/pull.c:76
 msgid "git pull [<options>] [<repository> [<refspec>...]]"
 msgstr "git pull [<Optionen>] [<Repository> [<Refspec>...]]"
 
 #: builtin/pull.c:124
-#, fuzzy
 msgid "control for recursive fetching of submodules"
 msgstr "rekursive Anforderungen von Submodulen kontrollieren"
 
 #: builtin/pull.c:128
 msgid "Options related to merging"
 msgstr "Optionen bezogen auf Merge"
 
 #: builtin/pull.c:131
 msgid "incorporate changes by rebasing rather than merging"
@@ -11553,19 +11562,19 @@ msgstr ""
 msgid "Cannot merge multiple branches into empty head."
 msgstr "Kann nicht mehrere Branches in einen leeren Branch zusammenführen."
 
 #: builtin/pull.c:901
 msgid "Cannot rebase onto multiple branches."
 msgstr "Kann Rebase nicht auf mehrere Branches ausführen."
 
 #: builtin/pull.c:908
 msgid "cannot rebase with locally recorded submodule modifications"
-msgstr ""
+msgstr "Kann Rebase nicht mit lokal aufgezeichneten Änderungen in Submodulen ausführen."
 
 #: builtin/push.c:17
 msgid "git push [<options>] [<repository> [<refspec>...]]"
 msgstr "git push [<Optionen>] [<Repository> [<Refspec>...]]"
 
 #: builtin/push.c:90
 msgid "tag shorthand without <tag>"
 msgstr "Kurzschrift für Tag ohne <Tag>"
 
@@ -12620,21 +12629,20 @@ msgid "same as the above, but limit memory size instead of entries count"
 msgstr ""
 "gleiches wie oben, aber die Speichergröße anstatt der\n"
 "Anzahl der Einträge limitieren"
 
 #: builtin/repack.c:194
 msgid "limits the maximum delta depth"
 msgstr "die maximale Delta-Tiefe limitieren"
 
 #: builtin/repack.c:196
-#, fuzzy
 msgid "limits the maximum number of threads"
-msgstr "die maximale Delta-Tiefe limitieren"
+msgstr "maximale Anzahl von Threads limitieren"
 
 #: builtin/repack.c:198
 msgid "maximum size of each packfile"
 msgstr "maximale Größe für jede Paketdatei"
 
 #: builtin/repack.c:200
 msgid "repack objects in packs marked with .keep"
 msgstr ""
 "Objekte umpacken, die sich in mit .keep markierten Pack-Dateien befinden"
@@ -14946,21 +14954,20 @@ msgstr "Speicherte Arbeitsverzeichnis und Index-Status $stash_msg"
 msgid "Cannot remove worktree changes"
 msgstr "Kann Änderungen im Arbeitsverzeichnis nicht löschen"
 
 #: git-stash.sh:474
 #, sh-format
 msgid "unknown option: $opt"
 msgstr "unbekannte Option: $opt"
 
 #: git-stash.sh:487
-#, fuzzy
 msgid "No stash entries found."
-msgstr "Kein Stash-Eintrag gefunden."
+msgstr "Keine Stash-Einträge gefunden."
 
 #: git-stash.sh:494
 #, sh-format
 msgid "Too many revisions specified: $REV"
 msgstr "Zu viele Commits angegeben: $REV"
 
 #: git-stash.sh:509
 #, sh-format
 msgid "$reference is not a valid reference"
@@ -14987,34 +14994,32 @@ msgstr "Kann \"stash\" nicht anwenden, solang ein Merge im Gange ist"
 #: git-stash.sh:568
 msgid "Conflicts in index. Try without --index."
 msgstr "Konflikte im Index. Versuchen Sie es ohne --index."
 
 #: git-stash.sh:570
 msgid "Could not save index tree"
 msgstr "Konnte Index-Verzeichnis nicht speichern"
 
 #: git-stash.sh:579
-#, fuzzy
 msgid "Could not restore untracked files from stash entry"
-msgstr "Konnte unversionierte Dateien vom Stash nicht wiederherstellen"
+msgstr "Konnte unversionierte Dateien vom Stash-Eintrag nicht wiederherstellen."
 
 #: git-stash.sh:604
 msgid "Cannot unstage modified files"
 msgstr "Kann geänderte Dateien nicht aus dem Index entfernen"
 
 #: git-stash.sh:619
 msgid "Index was not unstashed."
 msgstr "Index wurde nicht aus dem Stash zurückgeladen."
 
 #: git-stash.sh:633
-#, fuzzy
 msgid "The stash entry is kept in case you need it again."
-msgstr "Der Stash wird behalten, im Falle Sie benötigen diesen nochmal."
+msgstr "Der Stash-Eintrag wird behalten, im Falle Sie benötigen diesen nochmal."
 
 #: git-stash.sh:642
 #, sh-format
 msgid "Dropped ${REV} ($s)"
 msgstr "Gelöscht ${REV} ($s)"
 
 #: git-stash.sh:643
 #, sh-format
 msgid "${REV}: Could not drop stash entry"
@@ -16593,19 +16598,19 @@ msgstr "Der erforderliche SMTP-Server ist nicht korrekt definiert."
 
 #: git-send-email.perl:1411
 #, perl-format
 msgid "Server does not support STARTTLS! %s"
 msgstr "Server unterstützt kein STARTTLS! %s"
 
 #: git-send-email.perl:1416 git-send-email.perl:1420
 #, perl-format
 msgid "STARTTLS failed! %s"
-msgstr ""
+msgstr "STARTTLS fehlgeschlagen! %s"
 
 #: git-send-email.perl:1430
 msgid "Unable to initialize SMTP properly. Check config and use --smtp-debug."
 msgstr ""
 "Konnte SMTP nicht korrekt initialisieren. Bitte prüfen Sie Ihre "
 "Konfiguration\n"
 "und benutzen Sie --smtp-debug."
 
 #: git-send-email.perl:1448
-- 
2.14.0.rc0.284.gd933b75aa

