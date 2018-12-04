Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 06B98211B3
	for <e@80x24.org>; Tue,  4 Dec 2018 06:54:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbeLDGyq (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Dec 2018 01:54:46 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:33478 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbeLDGyp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Dec 2018 01:54:45 -0500
Received: by mail-ed1-f54.google.com with SMTP id p6so4682304eds.0
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 22:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wgzhzN+mk0OMm1H/E2B+bL/mT+LFr+EjLyDSz0sUJ7c=;
        b=a+tJ86KIizXr/lwzaKZI92T+C30UaqCWcCese4XuLNEa4DKIdWDo1vNIQho1pQCBxA
         PaJy+YVg3T6WFGyi7TZuzKjFeyT9OaM6QVxATSxLqgYRXZAfoT9eyplzAL6pggxWgobp
         dVcixKxHeUbklsjiExq7ZTVoT2FpoXuTmqfAR1n9Z1/JShgUAdeUCg9wSkDkMfuGdaAP
         XfnDtsMg8wFiwUDyvI2rX7E/QHeiN4aYXdSqSr7NdTddbARPOxGa6qn91yeyNLX7U3po
         dbrCHTJFbNSZMIRVoEY3+iL8KqtmtgENQKCLAbSsrHHfoJEK2KDPEjTySrePVuf6giUQ
         DWHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wgzhzN+mk0OMm1H/E2B+bL/mT+LFr+EjLyDSz0sUJ7c=;
        b=JXXAwB49MR52rupXHEEde0etne5iBzobQS5yiUEmx3BoS8/OPpCtpK2x0OtPqIvI+E
         dpH5eplKCbwq0hvqp//Njv5AhRFmDBw2pyILews2ofsTjJyvXQnsUo5aIunK5pDZvAo8
         SX9viP/Ce5GlowicGdPXz9YZuW0R2o9vW0/Jvy9v/aZqkzSARNeh0UeX6UiXf86zegBf
         OEU6aKQ7PxU73JhpNC4oI1BYLnDqKqU5tAf0ElusoCtOZ+DX14RCo7nlwt+vXfuy9GUh
         I+cFKMoOUCKryJk2jJR8NEaTDQndoq0Xp/+ZvHKnJhbNrzjKld0qaxefdZieEd2HfkKL
         jE9g==
X-Gm-Message-State: AA+aEWbpQTM0v4Qm7KEF5csu/3KN4a8WINom4cqYFHJ3o9Kpp9unFgBn
        oK7cW3fphGUJUNx8yfG0eP7j7xUb+aM=
X-Google-Smtp-Source: AFSGD/W87AAhiGXe30KGJdIejbNloRJE2x6XwZZwc5ENrXSH1XSsWuhVIe+ZQ/J4qrcJkbfbo3FAwA==
X-Received: by 2002:a50:b0e5:: with SMTP id j92mr15896942edd.188.1543906476057;
        Mon, 03 Dec 2018 22:54:36 -0800 (PST)
Received: from localhost (cable-82-119-27-87.cust.telecolumbus.net. [82.119.27.87])
        by smtp.gmail.com with ESMTPSA id z16-v6sm2564939eju.61.2018.12.03.22.54.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Dec 2018 22:54:35 -0800 (PST)
From:   Ralf Thielow <ralf.thielow@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Matthias=20R=C3=BCster?= <matthias.ruester@gmail.com>,
        Phillip Szelat <phillip.szelat@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH v2] l10n: update German translation
Date:   Tue,  4 Dec 2018 07:54:30 +0100
Message-Id: <20181204065430.31033-1-ralf.thielow@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1.379.g1dd7ef354c
In-Reply-To: <20181130173531.10073-1-ralf.thielow@gmail.com>
References: <20181130173531.10073-1-ralf.thielow@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
v2 updates the translation up to the latest update of git.pot.

range-diff:
1:  f0a6c76bf ! 1:  f8313495e l10n: update German translation
    @@ -205,13 +205,13 @@
     -msgstr ""
     +msgstr "Falsche Reihenfolge bei multi-pack-index Pack-Namen: '%s' vor '%s'"
      
      #: midx.c:205
      #, c-format
    - msgid "bad pack-int-id: %u (%u total packs"
    + msgid "bad pack-int-id: %u (%u total packs)"
     -msgstr ""
    -+msgstr "Fehlerhafte pack-int-id: %u (%u Pakete insgesamt)"
    ++msgstr "Ungültige pack-int-id: %u (%u Pakete insgesamt)"
      
      #: midx.c:246
      msgid "multi-pack-index stores a 64-bit offset, but off_t is too small"
     -msgstr ""
     +msgstr "multi-pack-index speichert einen 64-Bit Offset, aber off_t ist zu klein."
    @@ -364,31 +364,31 @@
     +#, c-format
      msgid "unable to join load_cache_entries thread: %s"
     -msgstr "kann Thread nicht erzeugen: %s"
     +msgstr "Kann Thread für load_cache_entries nicht erzeugen: %s"
      
    - #: read-cache.c:2200
    + #: read-cache.c:2201
     -#, fuzzy, c-format
     +#, c-format
      msgid "unable to create load_index_extensions thread: %s"
     -msgstr "kann Thread nicht erzeugen: %s"
     +msgstr "Kann Thread für load_index_extensions nicht erzeugen: %s"
      
    - #: read-cache.c:2227
    + #: read-cache.c:2228
     -#, fuzzy, c-format
     +#, c-format
      msgid "unable to join load_index_extensions thread: %s"
     -msgstr "kann Thread nicht erzeugen: %s"
    -+msgstr "Kann Thread für load_index_extensions nicht erzeugen: %s"
    ++msgstr "Kann Thread für load_index_extensions nicht beitreten: %s"
      
    - #: read-cache.c:2953 sequencer.c:4727 wrapper.c:658 builtin/merge.c:1086
    + #: read-cache.c:2982 sequencer.c:4727 wrapper.c:658 builtin/merge.c:1086
      #, c-format
      msgid "could not close '%s'"
     -msgstr "Konnte '%s' nicht schließen"
     +msgstr "Konnte '%s' nicht schließen."
      
    - #: read-cache.c:3026 sequencer.c:2203 sequencer.c:3592
    + #: read-cache.c:3055 sequencer.c:2203 sequencer.c:3592
      #, c-format
     @@
      msgstr "Konnte '%s' nicht entfernen."
      
      #: rebase-interactive.c:10
    @@ -802,14 +802,19 @@
      
      #: builtin/grep.c:1051
     -#, fuzzy
      msgid "invalid option combination, ignoring --threads"
     -msgstr "keine Unterstützung von Threads, --threads wird ignoriert"
    -+msgstr "ungültige Kombination von Optionen, --threads wird ignoriert"
    ++msgstr "Ungültige Kombination von Optionen, --threads wird ignoriert."
      
    - #: builtin/grep.c:1054 builtin/pack-objects.c:3395
    + #: builtin/grep.c:1054 builtin/pack-objects.c:3397
      msgid "no threads support, ignoring --threads"
    +-msgstr "keine Unterstützung von Threads, --threads wird ignoriert"
    ++msgstr "Keine Unterstützung für Threads, --threads wird ignoriert."
    + 
    + #: builtin/grep.c:1057 builtin/index-pack.c:1503 builtin/pack-objects.c:2716
    + #, c-format
     @@
      msgstr "Für '%s' wurde der Alias '%s' angelegt."
      
      #: builtin/help.c:444
     -#, fuzzy, c-format
    @@ -944,17 +949,17 @@
      #: builtin/pack-objects.c:2123
      msgid "suboptimal pack - out of memory"
     @@
      "packen"
      
    - #: builtin/pack-objects.c:3316
    + #: builtin/pack-objects.c:3318
     -#, fuzzy
      msgid "respect islands during delta compression"
     -msgstr "Größe des Fensters für die Delta-Kompression"
     +msgstr "Delta-Islands bei Delta-Kompression beachten"
      
    - #: builtin/pack-objects.c:3340
    + #: builtin/pack-objects.c:3342
      #, c-format
     @@
      "wurde nicht angefordert."
      
      #: builtin/pull.c:565
    @@ -964,10 +969,28 @@
     -msgstr "Konnte Commit '%s' nicht parsen."
     +msgstr "Konnte nicht auf Commit '%s' zugreifen."
      
      #: builtin/pull.c:843
      msgid "ignoring --verify-signatures for rebase"
    +@@
    + "config'."
    + 
    + #: builtin/push.c:168
    +-#, fuzzy, c-format
    ++#, c-format
    + msgid ""
    + "The upstream branch of your current branch does not match\n"
    + "the name of your current branch.  To push to the upstream branch\n"
    +@@
    + "Um auf den Branch mit demselben Namen im Remote-Repository zu versenden,\n"
    + "benutzen Sie:\n"
    + "\n"
    +-"    git push %s %s\n"
    ++"    git push %s HEAD\n"
    + "%s"
    + 
    + #: builtin/push.c:183
     @@
      msgstr "unpack-trees protokollieren"
      
      #: builtin/rebase.c:29
     -#, fuzzy
    @@ -1041,11 +1064,11 @@
     -#, fuzzy
      msgid "could not determine HEAD revision"
     -msgstr "Konnte HEAD nicht loslösen"
     +msgstr "Konnte HEAD-Commit nicht bestimmen."
      
    - #: builtin/rebase.c:752
    + #: builtin/rebase.c:753
     -#, fuzzy, c-format
     +#, c-format
      msgid ""
      "%s\n"
      "Please specify which branch you want to rebase against.\n"
    @@ -1060,11 +1083,11 @@
     +"Siehe git-rebase(1) für Details.\n"
     +"\n"
     +"    git rebase '<Branch>'\n"
     +"\n"
      
    - #: builtin/rebase.c:768
    + #: builtin/rebase.c:769
     -#, fuzzy, c-format
     +#, c-format
      msgid ""
      "If you wish to set tracking information for this branch you can do so with:\n"
      "\n"
    @@ -1078,212 +1101,212 @@
     +"können Sie dies tun mit:\n"
     +"\n"
     +"    git branch --set-upstream-to=%s/<Branch> %s\n"
     +"\n"
      
    - #: builtin/rebase.c:814
    + #: builtin/rebase.c:832
     -#, fuzzy
      msgid "rebase onto given branch instead of upstream"
     -msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
     +msgstr "Rebase auf angegebenen Branch anstelle des Upstream-Branches ausführen"
      
    - #: builtin/rebase.c:816
    + #: builtin/rebase.c:834
     -#, fuzzy
      msgid "allow pre-rebase hook to run"
     -msgstr "Der \"pre-rebase hook\" hat den Rebase zurückgewiesen."
     +msgstr "Ausführung des pre-rebase-Hooks erlauben"
      
    - #: builtin/rebase.c:818
    + #: builtin/rebase.c:836
      msgid "be quiet. implies --no-stat"
     -msgstr ""
     +msgstr "weniger Ausgaben (impliziert --no-stat)"
      
    - #: builtin/rebase.c:821
    + #: builtin/rebase.c:839
      msgid "display a diffstat of what changed upstream"
     -msgstr ""
     +msgstr "Zusammenfassung der Unterschiede gegenüber dem Upstream-Branch anzeigen"
      
    - #: builtin/rebase.c:824
    + #: builtin/rebase.c:842
     -#, fuzzy
      msgid "do not show diffstat of what changed upstream"
     -msgstr "keine Zusammenfassung der Unterschiede am Schluss des Merges anzeigen"
     +msgstr "Zusammenfassung der Unterschiede gegenüber dem Upstream-Branch verbergen"
      
    - #: builtin/rebase.c:827
    + #: builtin/rebase.c:845
     -#, fuzzy
      msgid "add a Signed-off-by: line to each commit"
     -msgstr "der Commit-Beschreibung eine Signed-off-by Zeile hinzufügen"
     +msgstr "eine \"Signed-off-by:\"-Zeile zu jedem Commit hinzufügen"
      
    - #: builtin/rebase.c:829 builtin/rebase.c:833 builtin/rebase.c:835
    + #: builtin/rebase.c:847 builtin/rebase.c:851 builtin/rebase.c:853
      msgid "passed to 'git am'"
     -msgstr ""
     +msgstr "an 'git am' übergeben"
      
    - #: builtin/rebase.c:837 builtin/rebase.c:839
    + #: builtin/rebase.c:855 builtin/rebase.c:857
     -#, fuzzy
      msgid "passed to 'git apply'"
     -msgstr "an git-apply übergeben"
    -+msgstr "an 'git-apply' übergeben"
    ++msgstr "an 'git apply' übergeben"
      
    - #: builtin/rebase.c:841 builtin/rebase.c:844
    + #: builtin/rebase.c:859 builtin/rebase.c:862
      msgid "cherry-pick all commits, even if unchanged"
     -msgstr ""
     +msgstr "Cherry-Pick auf alle Commits ausführen, auch wenn diese unverändert sind"
      
    - #: builtin/rebase.c:846
    + #: builtin/rebase.c:864
     -#, fuzzy
      msgid "continue"
     -msgstr "Rebase fortsetzen"
     +msgstr "fortsetzen"
      
    - #: builtin/rebase.c:849
    + #: builtin/rebase.c:867
     -#, fuzzy
      msgid "skip current patch and continue"
     -msgstr "den aktuellen Patch auslassen"
     +msgstr "den aktuellen Patch auslassen und fortfahren"
      
    - #: builtin/rebase.c:851
    + #: builtin/rebase.c:869
     -#, fuzzy
      msgid "abort and check out the original branch"
     -msgstr ""
     -"  (benutzen Sie \"git rebase --abort\", um den ursprünglichen Branch "
     -"auszuchecken)"
     +msgstr "abbrechen und den ursprünglichen Branch auschecken"
      
    - #: builtin/rebase.c:854
    + #: builtin/rebase.c:872
     -#, fuzzy
      msgid "abort but keep HEAD where it is"
     -msgstr "Patch-Operation abbrechen, aber HEAD an aktueller Stelle belassen"
     +msgstr "abbrechen, aber HEAD an aktueller Stelle belassen"
      
    - #: builtin/rebase.c:855
    + #: builtin/rebase.c:873
     -#, fuzzy
      msgid "edit the todo list during an interactive rebase"
     -msgstr ""
     -"Die --edit-todo Aktion kann nur während eines interaktiven Rebase verwendet "
     -"werden."
     +msgstr "TODO-Liste während eines interaktiven Rebase bearbeiten"
      
    - #: builtin/rebase.c:858
    + #: builtin/rebase.c:876
     -#, fuzzy
      msgid "show the patch file being applied or merged"
     -msgstr "den Patch, der gerade angewendet wird, anzeigen"
     +msgstr "den Patch, der gerade angewendet oder zusammengeführt wird, anzeigen"
      
    - #: builtin/rebase.c:861
    + #: builtin/rebase.c:879
     -#, fuzzy
      msgid "use merging strategies to rebase"
     -msgstr "zu verwendende Merge-Strategie"
     +msgstr "Merge-Strategien beim Rebase verwenden"
      
    - #: builtin/rebase.c:865
    + #: builtin/rebase.c:883
      msgid "let the user edit the list of commits to rebase"
     -msgstr ""
     +msgstr "den Benutzer die Liste der Commits für den Rebase bearbeiten lassen"
      
    - #: builtin/rebase.c:869
    + #: builtin/rebase.c:887
      msgid "try to recreate merges instead of ignoring them"
     -msgstr ""
     +msgstr "versuchen, Merges wiederherzustellen anstatt sie zu ignorieren"
      
    - #: builtin/rebase.c:873
    - msgid "allow rerere to update index  with resolved conflict"
    + #: builtin/rebase.c:891
    + msgid "allow rerere to update index with resolved conflict"
     -msgstr ""
    -+msgstr "Rerere erlauben, den Index mit aufgelöstem Konflikt zu aktualisieren"
    ++msgstr "Rerere erlauben, den Index mit dem aufgelöstem Konflikt zu aktualisieren"
      
    - #: builtin/rebase.c:876
    + #: builtin/rebase.c:894
     -#, fuzzy
      msgid "preserve empty commits during rebase"
     -msgstr "ursprüngliche, leere Commits erhalten"
     +msgstr "leere Commits während des Rebase erhalten"
      
    - #: builtin/rebase.c:878
    + #: builtin/rebase.c:896
      msgid "move commits that begin with squash!/fixup! under -i"
     -msgstr ""
     +msgstr "bei -i Commits verschieben, die mit squash!/fixup! beginnen"
      
    - #: builtin/rebase.c:884
    + #: builtin/rebase.c:902
     -#, fuzzy
      msgid "automatically stash/stash pop before and after"
     -msgstr "automatischer Stash/Stash-Pop vor und nach eines Rebase"
     +msgstr "automatischer Stash/Stash-Pop davor und danach"
      
    - #: builtin/rebase.c:886
    + #: builtin/rebase.c:904
      msgid "add exec lines after each commit of the editable list"
     -msgstr ""
     +msgstr "exec-Zeilen nach jedem Commit der editierbaren Liste hinzufügen"
      
    - #: builtin/rebase.c:890
    + #: builtin/rebase.c:908
     -#, fuzzy
      msgid "allow rebasing commits with empty messages"
     -msgstr "Commits mit leerer Beschreibung erlauben"
     +msgstr "Rebase von Commits mit leerer Beschreibung erlauben"
      
    - #: builtin/rebase.c:893
    + #: builtin/rebase.c:911
      msgid "try to rebase merges instead of skipping them"
     -msgstr ""
     +msgstr "versuchen, Rebase mit Merges auszuführen, anstatt diese zu überspringen"
      
    - #: builtin/rebase.c:896
    + #: builtin/rebase.c:914
     -#, fuzzy
      msgid "use 'merge-base --fork-point' to refine upstream"
     -msgstr "git merge-base --fork-point <Referenz> [<Commit>]"
     +msgstr "'git merge-base --fork-point' benutzen, um Upstream-Branch zu bestimmen"
      
    - #: builtin/rebase.c:898
    + #: builtin/rebase.c:916
     -#, fuzzy
      msgid "use the given merge strategy"
     -msgstr "Option für Merge-Strategie"
     +msgstr "angegebene Merge-Strategie verwenden"
      
    - #: builtin/rebase.c:900 builtin/revert.c:111
    + #: builtin/rebase.c:918 builtin/revert.c:111
      msgid "option"
     @@
      
    - #: builtin/rebase.c:901
    + #: builtin/rebase.c:919
      msgid "pass the argument through to the merge strategy"
     -msgstr ""
     +msgstr "Argument zur Merge-Strategie durchreichen"
      
    - #: builtin/rebase.c:904
    + #: builtin/rebase.c:922
     -#, fuzzy
      msgid "rebase all reachable commits up to the root(s)"
     -msgstr "alle nicht erreichbaren Objekte von der Objektdatenbank entfernen"
     +msgstr "Rebase auf alle erreichbaren Commits bis zum Root-Commit ausführen"
      
    - #: builtin/rebase.c:920
    + #: builtin/rebase.c:938
     -#, fuzzy, c-format
     +#, c-format
      msgid "could not exec %s"
     -msgstr "konnte %s nicht parsen"
     +msgstr "Konnte 'exec %s' nicht ausführen."
      
    - #: builtin/rebase.c:938 git-legacy-rebase.sh:213
    + #: builtin/rebase.c:956 git-legacy-rebase.sh:213
      msgid "It looks like 'git am' is in progress. Cannot rebase."
     @@
      "mittels \"git add\" als aufgelöst markieren"
      
    - #: builtin/rebase.c:1026
    + #: builtin/rebase.c:1047
     -#, fuzzy
      msgid "could not discard worktree changes"
     -msgstr "Kann Änderungen im Arbeitsverzeichnis nicht löschen"
     +msgstr "Konnte Änderungen im Arbeitsverzeichnis nicht verwerfen."
      
    - #: builtin/rebase.c:1044
    + #: builtin/rebase.c:1066
     -#, fuzzy, c-format
     +#, c-format
      msgid "could not move back to %s"
     -msgstr "Konnte nicht zu $head_name zurückgehen"
     +msgstr "Konnte nicht zu %s zurückgehen."
      
    - #: builtin/rebase.c:1055 builtin/rm.c:368
    + #: builtin/rebase.c:1077 builtin/rm.c:368
      #, c-format
     @@
      msgstr "Konnte '%s' nicht löschen"
      
    - #: builtin/rebase.c:1081
    + #: builtin/rebase.c:1103
     -#, fuzzy, c-format
     +#, c-format
      msgid ""
      "It seems that there is already a %s directory, and\n"
      "I wonder if you are in the middle of another rebase.  If that is the\n"
    @@ -1302,220 +1325,228 @@
     +"\t%s\n"
      "und führen Sie diesen Befehl nochmal aus. Es wird angehalten, falls noch\n"
     -"etwas Schützenswertes vorhanden ist."
     +"etwas Schützenswertes vorhanden ist.\n"
      
    - #: builtin/rebase.c:1102
    + #: builtin/rebase.c:1124
     -#, fuzzy
      msgid "switch `C' expects a numerical value"
     -msgstr "Schalter '%c' erwartet einen numerischen Wert"
     +msgstr "Schalter `C' erwartet einen numerischen Wert."
      
    - #: builtin/rebase.c:1139
    + #: builtin/rebase.c:1161
     -#, fuzzy, c-format
     +#, c-format
      msgid "Unknown mode: %s"
     -msgstr "Unbekannter --patch Modus: %s"
     +msgstr "Unbekannter Modus: %s"
      
    - #: builtin/rebase.c:1161
    + #: builtin/rebase.c:1183
      msgid "--strategy requires --merge or --interactive"
     -msgstr ""
     +msgstr "--strategy erfordert --merge oder --interactive"
      
    - #: builtin/rebase.c:1204
    + #: builtin/rebase.c:1226
      #, c-format
     @@
      "error: cannot combine interactive options (--interactive, --exec, --rebase-"
      "merges, --preserve-merges, --keep-empty, --root + --onto) with am options "
      "(%s)"
     -msgstr ""
     +msgstr "Fehler: 'interactive'-Optionen (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto ) können nicht mit 'am'-Optionen (%s) kombiniert werden."
      
    - #: builtin/rebase.c:1209
    + #: builtin/rebase.c:1231
     -#, fuzzy, c-format
     +#, c-format
      msgid ""
      "error: cannot combine merge options (--merge, --strategy, --strategy-option) "
      "with am options (%s)"
     -msgstr ""
     -"Fehler: '--rebase-merges' und '--strategy-option' können nicht kombiniert "
     -"werden."
     +msgstr "Fehler: 'merge'-Optionen (--merge, --strategy, --strategy-option) können nicht mit 'am'-Optionen (%s) kombiniert werden."
      
    - #: builtin/rebase.c:1229 git-legacy-rebase.sh:528
    + #: builtin/rebase.c:1251 git-legacy-rebase.sh:536
     -#, fuzzy
      msgid "error: cannot combine '--preserve-merges' with '--rebase-merges'"
    - msgstr ""
    - "Fehler: '--preserve-merges' und '--rebase-merges' können nicht kombiniert "
    - "werden."
    +-msgstr ""
    +-"Fehler: '--preserve-merges' und '--rebase-merges' können nicht kombiniert "
    +-"werden."
    ++msgstr "Fehler: '--preserve-merges' und '--rebase-merges' können nicht kombiniert werden."
      
    - #: builtin/rebase.c:1234 git-legacy-rebase.sh:534
    + #: builtin/rebase.c:1256 git-legacy-rebase.sh:542
     -#, fuzzy
      msgid "error: cannot combine '--rebase-merges' with '--strategy-option'"
      msgstr ""
      "Fehler: '--rebase-merges' und '--strategy-option' können nicht kombiniert "
      "werden."
      
    - #: builtin/rebase.c:1237 git-legacy-rebase.sh:536
    + #: builtin/rebase.c:1259 git-legacy-rebase.sh:544
     -#, fuzzy
      msgid "error: cannot combine '--rebase-merges' with '--strategy'"
      msgstr ""
      "Fehler: '--rebase-merges' und '--strategy' können nicht kombiniert werden."
      
    - #: builtin/rebase.c:1261
    + #: builtin/rebase.c:1283
     -#, fuzzy, c-format
     +#, c-format
      msgid "invalid upstream '%s'"
     -msgstr "Ungültiger Pfad '%s'"
     +msgstr "Ungültiger Upstream '%s'"
      
    - #: builtin/rebase.c:1267
    + #: builtin/rebase.c:1289
     -#, fuzzy
      msgid "Could not create new root commit"
     -msgstr "Konnte neu erstellten Commit nicht analysieren."
     +msgstr "Konnte neuen Root-Commit nicht erstellen."
      
    - #: builtin/rebase.c:1285
    + #: builtin/rebase.c:1307
     -#, fuzzy, c-format
     +#, c-format
      msgid "'%s': need exactly one merge base"
     -msgstr "Brauche genau einen Commit-Bereich."
    -+msgstr "'%s': brauche genau eine Merge-Basis"
    ++msgstr "'%s': benötige genau eine Merge-Basis"
      
    - #: builtin/rebase.c:1292
    + #: builtin/rebase.c:1314
     -#, fuzzy, c-format
     +#, c-format
      msgid "Does not point to a valid commit '%s'"
     -msgstr "$onto_name zeigt auf keinen gültigen Commit"
     +msgstr "'%s' zeigt auf keinen gültigen Commit."
      
    - #: builtin/rebase.c:1317
    + #: builtin/rebase.c:1339
     -#, fuzzy, c-format
     +#, c-format
      msgid "fatal: no such branch/commit '%s'"
     -msgstr "fatal: Branch/Commit '$branch_name' nicht gefunden"
     +msgstr "fatal: Branch/Commit '%s' nicht gefunden"
      
    - #: builtin/rebase.c:1325 builtin/submodule--helper.c:37
    + #: builtin/rebase.c:1347 builtin/submodule--helper.c:37
      #: builtin/submodule--helper.c:1930
     @@
      msgstr "Referenz nicht gefunden: %s"
      
    - #: builtin/rebase.c:1337
    + #: builtin/rebase.c:1359
     -#, fuzzy
      msgid "Could not resolve HEAD to a revision"
     -msgstr "Konnte HEAD-Commit nicht auflösen."
     +msgstr "Konnte HEAD zu keinem Commit auflösen."
      
    - #: builtin/rebase.c:1377 git-legacy-rebase.sh:657
    + #: builtin/rebase.c:1399 git-legacy-rebase.sh:665
      msgid "Cannot autostash"
      msgstr "Kann automatischen Stash nicht erzeugen."
      
    - #: builtin/rebase.c:1380
    + #: builtin/rebase.c:1402
     -#, fuzzy, c-format
     +#, c-format
      msgid "Unexpected stash response: '%s'"
     -msgstr "Unerwartetes wanted-ref: '%s'"
     +msgstr "Unerwartete 'stash'-Antwort: '%s'"
      
    - #: builtin/rebase.c:1386
    + #: builtin/rebase.c:1408
     -#, fuzzy, c-format
     +#, c-format
      msgid "Could not create directory for '%s'"
     -msgstr "Konnte Verzeichnis '%s' nicht erstellen."
     +msgstr "Konnte Verzeichnis für '%s' nicht erstellen."
      
    - #: builtin/rebase.c:1389
    + #: builtin/rebase.c:1411
     -#, fuzzy, c-format
     +#, c-format
      msgid "Created autostash: %s\n"
     -msgstr "Automatischen Stash erzeugt: $stash_abbrev"
     +msgstr "Automatischen Stash erzeugt: %s\n"
      
    - #: builtin/rebase.c:1392
    + #: builtin/rebase.c:1414
     -#, fuzzy
      msgid "could not reset --hard"
     -msgstr "Konnte orig-head nicht lesen."
     +msgstr "Konnte 'reset --hard' nicht ausführen."
      
    - #: builtin/rebase.c:1393 builtin/reset.c:113
    + #: builtin/rebase.c:1415 builtin/reset.c:113
      #, c-format
     @@
      msgstr "Bitte committen Sie die Änderungen oder benutzen Sie \"stash\"."
      
    - #: builtin/rebase.c:1436
    + #: builtin/rebase.c:1458
     -#, fuzzy, c-format
     +#, c-format
      msgid "could not parse '%s'"
     -msgstr "konnte %s nicht parsen"
     +msgstr "Konnte '%s' nicht parsen."
      
    - #: builtin/rebase.c:1447
    + #: builtin/rebase.c:1470
     -#, fuzzy, c-format
     +#, c-format
      msgid "could not switch to %s"
     -msgstr "Konnte nicht nach '%s' schreiben."
     +msgstr "Konnte nicht zu %s wechseln."
      
    - #: builtin/rebase.c:1458 git-legacy-rebase.sh:689
    + #: builtin/rebase.c:1481 git-legacy-rebase.sh:697
      #, sh-format
     @@
      msgstr "HEAD ist aktuell."
      
    - #: builtin/rebase.c:1460
    + #: builtin/rebase.c:1483
     -#, fuzzy, c-format
     +#, c-format
      msgid "Current branch %s is up to date.\n"
     -msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
     +msgstr "Aktueller Branch %s ist auf dem neuesten Stand.\n"
      
    - #: builtin/rebase.c:1468 git-legacy-rebase.sh:699
    + #: builtin/rebase.c:1491 git-legacy-rebase.sh:707
      #, sh-format
     @@
      msgstr "HEAD ist aktuell, Rebase erzwungen."
      
    - #: builtin/rebase.c:1470
    + #: builtin/rebase.c:1493
     -#, fuzzy, c-format
     +#, c-format
      msgid "Current branch %s is up to date, rebase forced.\n"
     -msgstr ""
     -"Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzwungen."
     +msgstr "Aktueller Branch %s ist auf dem neuesten Stand, Rebase erzwungen.\n"
      
    - #: builtin/rebase.c:1478 git-legacy-rebase.sh:208
    + #: builtin/rebase.c:1501 git-legacy-rebase.sh:208
      msgid "The pre-rebase hook refused to rebase."
      msgstr "Der \"pre-rebase hook\" hat den Rebase zurückgewiesen."
      
    - #: builtin/rebase.c:1484
    + #: builtin/rebase.c:1508
    +-#, fuzzy, c-format
    ++#, c-format
    + msgid "Changes to %s:\n"
    +-msgstr "Änderungen von $mb zu $onto:"
    ++msgstr "Änderungen zu %s:\n"
    + 
    + #: builtin/rebase.c:1511
     -#, fuzzy, c-format
     +#, c-format
      msgid "Changes from %s to %s:\n"
     -msgstr "Änderungen von $mb zu $onto:"
     +msgstr "Änderungen von %s zu %s:\n"
      
    - #: builtin/rebase.c:1507
    + #: builtin/rebase.c:1536
     -#, fuzzy, c-format
     +#, c-format
      msgid "First, rewinding head to replay your work on top of it...\n"
     -msgstr ""
     -"Zunächst wird der Branch zurückgespult, um Ihre Änderungen\n"
     -"darauf neu anzuwenden ..."
     +msgstr "Zunächst wird der Branch zurückgespult, um Ihre Änderungen darauf neu anzuwenden...\n"
      
    - #: builtin/rebase.c:1513
    + #: builtin/rebase.c:1543
     -#, fuzzy
      msgid "Could not detach HEAD"
     -msgstr "Konnte HEAD nicht loslösen"
     +msgstr "Konnte HEAD nicht loslösen."
      
    - #: builtin/rebase.c:1522
    + #: builtin/rebase.c:1552
     -#, fuzzy, c-format
     +#, c-format
    - msgid "Fast-forwarded %s to %s. \n"
    + msgid "Fast-forwarded %s to %s.\n"
     -msgstr "Spule vor zu $sha1"
    -+msgstr "%s zu %s vorgespult.\n"
    ++msgstr "Spule %s vor zu %s.\n"
      
      #: builtin/rebase--interactive.c:24
     -#, fuzzy
      msgid "no HEAD?"
      msgstr "Kein HEAD?"
    @@ -1972,11 +2003,11 @@
     @@
      "nicht unterstützt."
      
      #: http.c:837
     -#, fuzzy
    - msgid "CURLSSLOPT_NO_REVOKE not suported with cURL < 7.44.0"
    + msgid "CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"
     -msgstr ""
     -"Das Anheften des öffentlichen Schlüssels wird mit cURL < 7.44.0\n"
     -"nicht unterstützt."
     +msgstr "CURLSSLOPT_NO_REVOKE wird mit cURL < 7.44.0 nicht unterstützt."
      
    @@ -2040,10 +2071,22 @@
     -msgstr "Git Commit Graph-Dateien schreiben und überprüfen"
     +msgstr "multi-pack-indexes schreiben und überprüfen"
      
      #: command-list.h:129
      msgid "Creates a tag object"
    +@@
    + "Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzwungen."
    + 
    + #: git-legacy-rebase.sh:723
    +-#, fuzzy, sh-format
    ++#, sh-format
    + msgid "Changes to $onto:"
    +-msgstr "Änderungen von $mb zu $onto:"
    ++msgstr "Änderungen zu $onto:"
    + 
    + #: git-legacy-rebase.sh:725
    + #, sh-format
     @@
      #: git-send-email.perl:525
      #, perl-format
      msgid "warning: sendmail alias with quotes is not supported: %s\n"
     -msgstr ""

 po/de.po | 845 +++++++++++++++++++++++++------------------------------
 1 file changed, 383 insertions(+), 462 deletions(-)

diff --git a/po/de.po b/po/de.po
index 899b95120..eb213d742 100644
--- a/po/de.po
+++ b/po/de.po
@@ -943,17 +943,17 @@ msgid ""
 "Use '\\!' for literal leading exclamation."
 msgstr ""
 "Verneinende Muster werden in Git-Attributen ignoriert.\n"
 "Benutzen Sie '\\!' für führende Ausrufezeichen."
 
 #: bisect.c:468
 #, c-format
 msgid "Badly quoted content in file '%s': %s"
-msgstr "Ungültiger Inhalt bzgl. Anführungsstriche in Datei '%s': %s"
+msgstr "Ungültiger Inhalt bzgl. Anführungszeichen in Datei '%s': %s"
 
 #: bisect.c:676
 #, c-format
 msgid "We cannot bisect more!\n"
 msgstr "Keine binäre Suche mehr möglich!\n"
 
 #: bisect.c:730
 #, c-format
@@ -1282,19 +1282,18 @@ msgstr "Das Paket speichert eine komplette Historie."
 #: bundle.c:201
 #, c-format
 msgid "The bundle requires this ref:"
 msgid_plural "The bundle requires these %d refs:"
 msgstr[0] "Das Paket benötigt diese Referenz:"
 msgstr[1] "Das Paket benötigt diese %d Referenzen:"
 
 #: bundle.c:267
-#, fuzzy
 msgid "unable to dup bundle descriptor"
-msgstr "Konnte Descriptor nicht umleiten."
+msgstr "Konnte dup für Descriptor des Pakets nicht ausführen."
 
 #: bundle.c:274
 msgid "Could not spawn pack-objects"
 msgstr "Konnte Paketobjekte nicht erstellen"
 
 #: bundle.c:285
 msgid "pack-objects died"
 msgstr "Erstellung der Paketobjekte abgebrochen"
@@ -1433,28 +1432,26 @@ msgid "could not find commit %s"
 msgstr "Konnte Commit %s nicht finden."
 
 #: commit-graph.c:617 builtin/pack-objects.c:2652
 #, c-format
 msgid "unable to get type of object %s"
 msgstr "Konnte Art von Objekt '%s' nicht bestimmen."
 
 #: commit-graph.c:651
-#, fuzzy
 msgid "Annotating commits in commit graph"
-msgstr "Zu viele Commits zum Schreiben des Graphen."
+msgstr "Annotiere Commits in Commit-Graphen"
 
 #: commit-graph.c:691
 msgid "Computing commit graph generation numbers"
-msgstr ""
+msgstr "Commit-Graph Generierungsnummern berechnen"
 
 #: commit-graph.c:803 commit-graph.c:826 commit-graph.c:852
-#, fuzzy
 msgid "Finding commits for commit graph"
-msgstr "Zu viele Commits zum Schreiben des Graphen."
+msgstr "Bestimme Commits für Commit-Graphen"
 
 #: commit-graph.c:812
 #, c-format
 msgid "error adding pack %s"
 msgstr "Fehler beim Hinzufügen von Paket %s."
 
 #: commit-graph.c:814
 #, c-format
@@ -1478,17 +1475,17 @@ msgstr "Konnte führende Verzeichnisse von '%s' nicht erstellen."
 #: commit-graph.c:1002
 msgid "the commit-graph file has incorrect checksum and is likely corrupt"
 msgstr ""
 "Die Commit-Graph-Datei hat eine falsche Prüfsumme und ist wahrscheinlich "
 "beschädigt."
 
 #: commit-graph.c:1046
 msgid "Verifying commits in commit graph"
-msgstr ""
+msgstr "Commit in Commit-Graph überprüfen"
 
 #: compat/obstack.c:405 compat/obstack.c:407
 msgid "memory exhausted"
 msgstr "Speicher verbraucht"
 
 #: config.c:123
 #, c-format
 msgid ""
@@ -2193,37 +2190,39 @@ msgstr[1] "%s, und %<PRIuMAX> Monaten"
 #, c-format
 msgid "%<PRIuMAX> year ago"
 msgid_plural "%<PRIuMAX> years ago"
 msgstr[0] "vor %<PRIuMAX> Jahr"
 msgstr[1] "vor %<PRIuMAX> Jahren"
 
 #: delta-islands.c:268
 msgid "Propagating island marks"
-msgstr ""
+msgstr "Erzeuge Delta-Island Markierungen"
 
 #: delta-islands.c:286
-#, fuzzy, c-format
+#, c-format
 msgid "bad tree object %s"
-msgstr "Konnte Objekt %s nicht lesen."
+msgstr "Ungültiges Tree-Objekt %s."
 
 #: delta-islands.c:330
-#, fuzzy, c-format
+#, c-format
 msgid "failed to load island regex for '%s': %s"
-msgstr "Fehler beim Finden des \"Tree\"-Objektes von %s."
+msgstr "Fehler beim Laden des regulären Ausdrucks des Delta-Island für '%s': %s"
 
 #: delta-islands.c:386
 #, c-format
 msgid "island regex from config has too many capture groups (max=%d)"
 msgstr ""
+"Regulärer Ausdruck des Delta-Island aus Konfiguration hat zu\n"
+"viele Capture-Gruppen (maximal %d)."
 
 #: delta-islands.c:462
 #, c-format
 msgid "Marked %d islands, done.\n"
-msgstr ""
+msgstr "%d Delta-Islands markiert, fertig.\n"
 
 #: diffcore-order.c:24
 #, c-format
 msgid "failed to read orderfile '%s'"
 msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
 
 #: diffcore-rename.c:544
 msgid "Performing inexact rename detection"
@@ -2592,21 +2591,21 @@ msgstr "Unerwartete Acknowledgment-Zeile: '%s'"
 
 #: fetch-pack.c:1249
 #, c-format
 msgid "error processing acks: %d"
 msgstr "Fehler beim Verarbeiten von ACKS: %d"
 
 #: fetch-pack.c:1259
 msgid "expected packfile to be sent after 'ready'"
-msgstr ""
+msgstr "Erwartete Versand einer Packdatei nach 'ready'."
 
 #: fetch-pack.c:1261
 msgid "expected no other sections to be sent after no 'ready'"
-msgstr ""
+msgstr "Erwartete keinen Versand einer anderen Sektion ohne 'ready'."
 
 #: fetch-pack.c:1298
 #, c-format
 msgid "error processing shallow info: %d"
 msgstr "Fehler beim Verarbeiten von Shallow-Informationen: %d"
 
 #: fetch-pack.c:1314
 #, c-format
@@ -2746,26 +2745,25 @@ msgid "unsupported command listing type '%s'"
 msgstr "Nicht unterstützte Art zur Befehlsauflistung '%s'."
 
 #: help.c:408
 msgid "The common Git guides are:"
 msgstr "Die allgemeinen Git-Anleitungen sind:"
 
 #: help.c:517
 msgid "See 'git help <command>' to read about a specific subcommand"
-msgstr ""
+msgstr "Siehe 'git help <Befehl>', um mehr über einen spezifischen Unterbefehl zu lesen."
 
 #: help.c:522
-#, fuzzy
 msgid "External commands"
-msgstr "führe $command aus"
+msgstr "Externe Befehle"
 
 #: help.c:530
 msgid "Command aliases"
-msgstr ""
+msgstr "Alias-Befehle"
 
 #: help.c:594
 #, c-format
 msgid ""
 "'%s' appears to be a git command, but we were not\n"
 "able to execute it. Maybe git-%s is broken?"
 msgstr ""
 "'%s' scheint ein git-Befehl zu sein, konnte aber\n"
@@ -2892,19 +2890,18 @@ msgstr "Name besteht nur aus nicht erlaubten Zeichen: %s"
 msgid "invalid date format: %s"
 msgstr "Ungültiges Datumsformat: %s"
 
 #: list-objects-filter-options.c:35
 msgid "multiple filter-specs cannot be combined"
 msgstr "Mehrere filter-specs können nicht kombiniert werden."
 
 #: list-objects-filter-options.c:58
-#, fuzzy
 msgid "only 'tree:0' is supported"
-msgstr "Protokoll '%s' wird nicht unterstützt."
+msgstr "Es wird nur 'tree:0' unterstützt."
 
 #: list-objects-filter-options.c:137
 msgid "cannot change partial clone promisor remote"
 msgstr "Kann Remote-Repository für partielles Klonen nicht ändern."
 
 #: lockfile.c:151
 #, c-format
 msgid ""
@@ -3355,142 +3352,141 @@ msgstr "Merge hat keinen Commit zurückgegeben"
 msgid "Could not parse object '%s'"
 msgstr "Konnte Objekt '%s' nicht parsen."
 
 #: merge-recursive.c:3553 builtin/merge.c:691 builtin/merge.c:849
 msgid "Unable to write index."
 msgstr "Konnte Index nicht schreiben."
 
 #: midx.c:65
-#, fuzzy, c-format
+#, c-format
 msgid "multi-pack-index file %s is too small"
-msgstr "Graph-Datei %s ist zu klein."
+msgstr "multi-pack-index-Datei %s ist zu klein."
 
 #: midx.c:81
-#, fuzzy, c-format
+#, c-format
 msgid "multi-pack-index signature 0x%08x does not match signature 0x%08x"
-msgstr "Graph-Signatur %X stimmt nicht mit Signatur %X überein."
+msgstr "multi-pack-index-Signatur 0x%08x stimmt nicht mit Signatur 0x%08x überein."
 
 #: midx.c:86
 #, c-format
 msgid "multi-pack-index version %d not recognized"
-msgstr ""
+msgstr "multi-pack-index-Version %d nicht erkannt."
 
 #: midx.c:91
-#, fuzzy, c-format
+#, c-format
 msgid "hash version %u does not match"
-msgstr "Hash-Version %X stimmt nicht mit Version %X überein."
+msgstr "Hash-Version %u stimmt nicht überein."
 
 #: midx.c:105
 msgid "invalid chunk offset (too large)"
-msgstr ""
+msgstr "Ungültiger Chunk-Offset (zu groß)"
 
 #: midx.c:129
 msgid "terminating multi-pack-index chunk id appears earlier than expected"
-msgstr ""
+msgstr "Abschließende multi-pack-index Chunk-Id erscheint eher als erwartet."
 
 #: midx.c:142
 msgid "multi-pack-index missing required pack-name chunk"
-msgstr ""
+msgstr "multi-pack-index fehlt erforderlicher pack-name Chunk."
 
 #: midx.c:144
 msgid "multi-pack-index missing required OID fanout chunk"
-msgstr ""
+msgstr "multi-pack-index fehlt erforderlicher OID fanout Chunk."
 
 #: midx.c:146
 msgid "multi-pack-index missing required OID lookup chunk"
-msgstr ""
+msgstr "multi-pack-index fehlt erforderlicher OID lookup Chunk."
 
 #: midx.c:148
 msgid "multi-pack-index missing required object offsets chunk"
-msgstr ""
+msgstr "multi-pack-index fehlt erforderlicher object offset Chunk."
 
 #: midx.c:162
 #, c-format
 msgid "multi-pack-index pack names out of order: '%s' before '%s'"
-msgstr ""
+msgstr "Falsche Reihenfolge bei multi-pack-index Pack-Namen: '%s' vor '%s'"
 
 #: midx.c:205
 #, c-format
 msgid "bad pack-int-id: %u (%u total packs)"
-msgstr ""
+msgstr "Ungültige pack-int-id: %u (%u Pakete insgesamt)"
 
 #: midx.c:246
 msgid "multi-pack-index stores a 64-bit offset, but off_t is too small"
-msgstr ""
+msgstr "multi-pack-index speichert einen 64-Bit Offset, aber off_t ist zu klein."
 
 #: midx.c:271
 msgid "error preparing packfile from multi-pack-index"
-msgstr ""
+msgstr "Fehler bei Vorbereitung der Packdatei aus multi-pack-index."
 
 #: midx.c:407
-#, fuzzy, c-format
+#, c-format
 msgid "failed to add packfile '%s'"
-msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
+msgstr "Fehler beim Hinzufügen von Packdatei'%s'."
 
 #: midx.c:413
-#, fuzzy, c-format
+#, c-format
 msgid "failed to open pack-index '%s'"
-msgstr "Fehler beim Öffnen von '%s'"
+msgstr "Fehler beim Öffnen von pack-index '%s'"
 
 #: midx.c:507
-#, fuzzy, c-format
+#, c-format
 msgid "failed to locate object %d in packfile"
-msgstr "Konnte Objekt %s nicht lesen."
+msgstr "Fehler beim Lokalisieren von Objekt %d in Packdatei."
 
 #: midx.c:943
-#, fuzzy, c-format
+#, c-format
 msgid "failed to clear multi-pack-index at %s"
-msgstr "Fehler beim Bereinigen des Index"
+msgstr "Fehler beim Löschen des multi-pack-index bei %s"
 
 #: midx.c:981
 #, c-format
 msgid ""
 "oid fanout out of order: fanout[%d] = %<PRIx32> > %<PRIx32> = fanout[%d]"
-msgstr ""
+msgstr "Ungültige oid fanout Reihenfolge: fanout[%d] = %<PRIx32> > %<PRIx32> = fanout[%d]"
 
 #: midx.c:992
 #, c-format
 msgid "oid lookup out of order: oid[%d] = %s >= %s = oid[%d]"
-msgstr ""
+msgstr "Ungültige oid lookup Reihenfolge: oid[%d] = %s >= %s = oid[%d]"
 
 #: midx.c:996
-#, fuzzy
 msgid "Verifying object offsets"
-msgstr "Schreibe Objekte"
+msgstr "Überprüfe Objekt-Offsets"
 
 #: midx.c:1004
-#, fuzzy, c-format
+#, c-format
 msgid "failed to load pack entry for oid[%d] = %s"
-msgstr "kann für %s keinen Eintrag in den Zwischenspeicher hinzufügen"
+msgstr "Fehler beim Laden des Pack-Eintrags für oid[%d] = %s"
 
 #: midx.c:1010
-#, fuzzy, c-format
+#, c-format
 msgid "failed to load pack-index for packfile %s"
-msgstr "Fehler beim Lesen der Reihenfolgedatei '%s'."
+msgstr "Fehler beim Laden des Pack-Index für Packdatei %s"
 
 #: midx.c:1019
 #, c-format
 msgid "incorrect object offset for oid[%d] = %s: %<PRIx64> != %<PRIx64>"
-msgstr ""
+msgstr "Falscher Objekt-Offset für oid[%d] = %s: %<PRIx64> != %<PRIx64>"
 
 #: name-hash.c:532
-#, fuzzy, c-format
+#, c-format
 msgid "unable to create lazy_dir thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann lazy_dir Thread nicht erzeugen: %s"
 
 #: name-hash.c:554
-#, fuzzy, c-format
+#, c-format
 msgid "unable to create lazy_name thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann lazy_name Thread nicht erzeugen: %s"
 
 #: name-hash.c:560
-#, fuzzy, c-format
+#, c-format
 msgid "unable to join lazy_name thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann lazy_name Thread nicht beitreten: %s"
 
 #: notes-merge.c:275
 #, c-format
 msgid ""
 "You have not concluded your previous notes merge (%s exists).\n"
 "Please, use 'git notes merge --commit' or 'git notes merge --abort' to "
 "commit/abort the previous merge before you start a new notes merge."
 msgstr ""
@@ -3723,24 +3719,23 @@ msgid "protocol error: bad line length character: %.4s"
 msgstr "Protokollfehler: ungültiges Zeichen für Zeilenlänge: %.4s"
 
 #: pkt-line.c:337 pkt-line.c:342
 #, c-format
 msgid "protocol error: bad line length %d"
 msgstr "Protokollfehler: ungültige Zeilenlänge %d"
 
 #: preload-index.c:118
-#, fuzzy
 msgid "Refreshing index"
-msgstr "Konnte den Index nicht aktualisieren."
+msgstr "Aktualisiere Index"
 
 #: preload-index.c:137
-#, fuzzy, c-format
+#, c-format
 msgid "unable to create threaded lstat: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann Thread für lstat nicht erzeugen: %s"
 
 #: pretty.c:962
 msgid "unable to parse --pretty format"
 msgstr "Konnte --pretty Format nicht parsen."
 
 #: range-diff.c:56
 msgid "could not start `log`"
 msgstr "Konnte `log` nicht starten."
@@ -3759,19 +3754,18 @@ msgid "failed to generate diff"
 msgstr "Fehler beim Generieren des Diffs."
 
 #: range-diff.c:455 range-diff.c:457
 #, c-format
 msgid "could not parse log for '%s'"
 msgstr "Konnte Log für '%s' nicht parsen."
 
 #: read-cache.c:1490
-#, fuzzy
 msgid "Refresh index"
-msgstr "Konnte den Index nicht aktualisieren."
+msgstr "Aktualisiere Index"
 
 #: read-cache.c:1604
 #, c-format
 msgid ""
 "index.version set, but the value is invalid.\n"
 "Using version %i"
 msgstr ""
 "index.version gesetzt, aber Wert ungültig.\n"
@@ -3784,50 +3778,50 @@ msgid ""
 "Using version %i"
 msgstr ""
 "GIT_INDEX_VERSION gesetzt, aber Wert ungültig.\n"
 "Verwende Version %i"
 
 #: read-cache.c:1792
 #, c-format
 msgid "malformed name field in the index, near path '%s'"
-msgstr ""
+msgstr "Ungültiges Namensfeld im Index, in der Nähe von Pfad '%s'."
 
 #: read-cache.c:1960 rerere.c:565 rerere.c:599 rerere.c:1111 builtin/add.c:458
 #: builtin/check-ignore.c:177 builtin/checkout.c:289 builtin/checkout.c:585
 #: builtin/checkout.c:953 builtin/clean.c:954 builtin/commit.c:343
 #: builtin/diff-tree.c:115 builtin/grep.c:489 builtin/mv.c:144
 #: builtin/reset.c:244 builtin/rm.c:270 builtin/submodule--helper.c:329
 msgid "index file corrupt"
 msgstr "Index-Datei beschädigt"
 
 #: read-cache.c:2101
-#, fuzzy, c-format
+#, c-format
 msgid "unable to create load_cache_entries thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann Thread für load_cache_entries nicht erzeugen: %s"
 
 #: read-cache.c:2114
-#, fuzzy, c-format
+#, c-format
 msgid "unable to join load_cache_entries thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann Thread für load_cache_entries nicht erzeugen: %s"
 
 #: read-cache.c:2201
-#, fuzzy, c-format
+#, c-format
 msgid "unable to create load_index_extensions thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann Thread für load_index_extensions nicht erzeugen: %s"
 
 #: read-cache.c:2228
-#, fuzzy, c-format
+#, c-format
 msgid "unable to join load_index_extensions thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann Thread für load_index_extensions nicht beitreten: %s"
 
 #: read-cache.c:2982 sequencer.c:4727 wrapper.c:658 builtin/merge.c:1086
 #, c-format
 msgid "could not close '%s'"
-msgstr "Konnte '%s' nicht schließen"
+msgstr "Konnte '%s' nicht schließen."
 
 #: read-cache.c:3055 sequencer.c:2203 sequencer.c:3592
 #, c-format
 msgid "could not stat '%s'"
 msgstr "Konnte '%s' nicht lesen."
 
 #: read-cache.c:3068
 #, c-format
@@ -3835,17 +3829,16 @@ msgid "unable to open git dir: %s"
 msgstr "konnte Git-Verzeichnis nicht öffnen: %s"
 
 #: read-cache.c:3080
 #, c-format
 msgid "unable to unlink: %s"
 msgstr "Konnte '%s' nicht entfernen."
 
 #: rebase-interactive.c:10
-#, fuzzy
 msgid ""
 "\n"
 "Commands:\n"
 "p, pick <commit> = use commit\n"
 "r, reword <commit> = use commit, but edit the commit message\n"
 "e, edit <commit> = use commit, but stop for amending\n"
 "s, squash <commit> = use commit, but meld into previous commit\n"
 "f, fixup <commit> = like \"squash\", but discard this commit's log message\n"
@@ -3862,26 +3855,25 @@ msgid ""
 "These lines can be re-ordered; they are executed from top to bottom.\n"
 msgstr ""
 "\n"
 "Befehle:\n"
 "p, pick <Commit> = Commit verwenden\n"
 "r, reword <Commit> = Commit verwenden, aber Commit-Beschreibung bearbeiten\n"
 "e, edit <Commit> = Commit verwenden, aber zum Nachbessern anhalten\n"
 "s, squash <Commit> = Commit verwenden, aber mit vorherigem Commit vereinen\n"
-"f, fixup <Commit> = wie \"squash\", aber diese Commit-Beschreibung "
-"verwerfen\n"
+"f, fixup <Commit> = wie \"squash\", aber diese Commit-Beschreibung verwerfen\n"
 "x, exec <Commit> = Befehl (Rest der Zeile) mittels Shell ausführen\n"
+"b, break = hier anhalten (Rebase später mit 'git rebase --continue' fortsetzen)\n"
 "d, drop <Commit> = Commit entfernen\n"
 "l, label <Label> = aktuellen HEAD mit Label versehen\n"
 "t, reset <Label> = HEAD zu einem Label umsetzen\n"
 "m, merge [-C <Commit> | -c <Commit>] <Label> [# <eineZeile>]\n"
 ".       Merge-Commit mit der originalen Merge-Commit-Beschreibung erstellen\n"
-".       (oder die eine Zeile, wenn keine originale Merge-Commit-"
-"Beschreibung\n"
+".       (oder die eine Zeile, wenn keine originale Merge-Commit-Beschreibung\n"
 ".       spezifiziert ist). Benutzen Sie -c <Commit> zum Bearbeiten der\n"
 ".       Commit-Beschreibung.\n"
 "\n"
 "Diese Zeilen können umsortiert werden; Sie werden von oben nach unten\n"
 "ausgeführt.\n"
 
 #: rebase-interactive.c:31 git-rebase--preserve-merges.sh:173
 msgid ""
@@ -4182,17 +4174,17 @@ msgstr "Fehlerhafter Feldname: %.*s"
 #, c-format
 msgid "unknown field name: %.*s"
 msgstr "Unbekannter Feldname: %.*s"
 
 #: ref-filter.c:539
 #, c-format
 msgid ""
 "not a git repository, but the field '%.*s' requires access to object data"
-msgstr ""
+msgstr "Kein Git-Repository, aber das Feld '%.*s' erfordert Zugriff auf Objektdaten."
 
 #: ref-filter.c:663
 #, c-format
 msgid "format: %%(if) atom used without a %%(then) atom"
 msgstr "format: %%(if) Atom ohne ein %%(then) Atom verwendet"
 
 #: ref-filter.c:726
 #, c-format
@@ -4446,113 +4438,111 @@ msgstr "doppelte ersetzende Referenz: %s"
 
 #: replace-object.c:73
 #, c-format
 msgid "replace depth too high for object %s"
 msgstr "Ersetzungstiefe zu hoch für Objekt %s"
 
 #: rerere.c:217 rerere.c:226 rerere.c:229
 msgid "corrupt MERGE_RR"
-msgstr ""
+msgstr "Fehlerhaftes MERGE_RR"
 
 #: rerere.c:264 rerere.c:269
-#, fuzzy
 msgid "unable to write rerere record"
-msgstr "Konnte Notiz-Objekt nicht schreiben"
+msgstr "Konnte Rerere-Eintrag nicht schreiben."
 
 #: rerere.c:485 rerere.c:692 sequencer.c:3136 sequencer.c:3162
 #, c-format
 msgid "could not write '%s'"
 msgstr "Konnte '%s' nicht schreiben."
 
 #: rerere.c:495
-#, fuzzy, c-format
+#, c-format
 msgid "there were errors while writing '%s' (%s)"
-msgstr "Lesefehler beim Indizieren von '%s'."
+msgstr "Fehler beim Schreiben von '%s' (%s)."
 
 #: rerere.c:498
-#, fuzzy, c-format
+#, c-format
 msgid "failed to flush '%s'"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Flush bei '%s' fehlgeschlagen."
 
 #: rerere.c:503 rerere.c:1039
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse conflict hunks in '%s'"
-msgstr "Konnte Commit '%s' nicht parsen."
+msgstr "Konnte Konflikt-Blöcke in '%s' nicht parsen."
 
 #: rerere.c:684
-#, fuzzy, c-format
+#, c-format
 msgid "failed utime() on '%s'"
 msgstr "Fehler beim Aufruf von utime() auf '%s'."
 
 #: rerere.c:694
-#, fuzzy, c-format
+#, c-format
 msgid "writing '%s' failed"
-msgstr "Konnte '%s' nicht erstellen"
+msgstr "Schreiben von '%s' fehlgeschlagen."
 
 #: rerere.c:714
 #, c-format
 msgid "Staged '%s' using previous resolution."
-msgstr ""
+msgstr "'%s' mit vorheriger Konfliktauflösung zum Commit vorgemerkt."
 
 #: rerere.c:753
-#, fuzzy, c-format
+#, c-format
 msgid "Recorded resolution for '%s'."
-msgstr "aufgezeichnete Auflösung von Merge-Konflikten wiederverwenden"
+msgstr "Konfliktauflösung für '%s' aufgezeichnet."
 
 #: rerere.c:788
 #, c-format
 msgid "Resolved '%s' using previous resolution."
-msgstr ""
+msgstr "Konflikte in '%s' mit vorheriger Konfliktauflösung beseitigt."
 
 #: rerere.c:803
-#, fuzzy, c-format
+#, c-format
 msgid "cannot unlink stray '%s'"
-msgstr "kann symbolische Verknüpfung '%s' auf '%s' nicht erstellen"
+msgstr "Kann '%s' nicht löschen."
 
 #: rerere.c:807
-#, fuzzy, c-format
+#, c-format
 msgid "Recorded preimage for '%s'"
-msgstr "Konnte Log für '%s' nicht parsen."
+msgstr "Preimage für '%s' aufgezeichnet."
 
 #: rerere.c:881 submodule.c:1763 builtin/submodule--helper.c:1413
 #: builtin/submodule--helper.c:1423
 #, c-format
 msgid "could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
 
 #: rerere.c:1057
-#, fuzzy, c-format
+#, c-format
 msgid "failed to update conflicted state in '%s'"
-msgstr "Fehler beim Ausführen von 'git status' auf '%s'"
+msgstr "Fehler beim Aktualisieren des Konflikt-Status in '%s'."
 
 #: rerere.c:1068 rerere.c:1075
-#, fuzzy, c-format
+#, c-format
 msgid "no remembered resolution for '%s'"
-msgstr "Konnte Merge-Ergebnis von '%s' nicht hinzufügen."
+msgstr "Keine aufgezeichnete Konfliktauflösung für '%s'."
 
 #: rerere.c:1077
-#, fuzzy, c-format
+#, c-format
 msgid "cannot unlink '%s'"
-msgstr "kann Verweis '%s' nicht lesen"
+msgstr "Kann '%s' nicht löschen."
 
 #: rerere.c:1087
-#, fuzzy, c-format
+#, c-format
 msgid "Updated preimage for '%s'"
-msgstr "Ersetzende Referenz '%s' gelöscht."
+msgstr "Preimage für '%s' aktualisiert."
 
 #: rerere.c:1096
-#, fuzzy, c-format
+#, c-format
 msgid "Forgot resolution for '%s'\n"
-msgstr "Konnte Log für '%s' nicht parsen."
+msgstr "Aufgezeichnete Konfliktauflösung für '%s' gelöscht.\n"
 
 #: rerere.c:1199
-#, fuzzy
 msgid "unable to open rr-cache directory"
-msgstr "Konnte Cache-Verzeichnis nicht aktualisieren."
+msgstr "Konnte rr-cache Verzeichnis nicht öffnen."
 
 #: revision.c:2324
 msgid "your current branch appears to be broken"
 msgstr "Ihr aktueller Branch scheint fehlerhaft zu sein."
 
 #: revision.c:2327
 #, c-format
 msgid "your current branch '%s' does not have any commits yet"
@@ -4562,19 +4552,19 @@ msgstr "Ihr aktueller Branch '%s' hat noch keine Commits."
 msgid "--first-parent is incompatible with --bisect"
 msgstr "Die Optionen --first-parent und --bisect sind inkompatibel."
 
 #: run-command.c:740
 msgid "open /dev/null failed"
 msgstr "Öffnen von /dev/null fehlgeschlagen"
 
 #: run-command.c:1229
-#, fuzzy, c-format
+#, c-format
 msgid "cannot create async thread: %s"
-msgstr "kann Thread nicht erzeugen: %s"
+msgstr "Kann Thread für async nicht erzeugen: %s"
 
 #: run-command.c:1293
 #, c-format
 msgid ""
 "The '%s' hook was ignored because it's not set as executable.\n"
 "You can disable this warning with `git config advice.ignoredHook false`."
 msgstr ""
 "Der '%s' Hook wurde ignoriert, weil er nicht als ausführbar markiert ist.\n"
@@ -4715,59 +4705,59 @@ msgstr "%s: Konnte neue Index-Datei nicht schreiben"
 msgid "unable to update cache tree"
 msgstr "Konnte Cache-Verzeichnis nicht aktualisieren."
 
 #: sequencer.c:604
 msgid "could not resolve HEAD commit"
 msgstr "Konnte HEAD-Commit nicht auflösen."
 
 #: sequencer.c:684
-#, fuzzy, c-format
+#, c-format
 msgid "no key present in '%.*s'"
-msgstr "Konnte '%.*s' nicht parsen."
+msgstr "Kein Schlüssel in '%.*s' vorhanden."
 
 #: sequencer.c:695
-#, fuzzy, c-format
+#, c-format
 msgid "unable to dequote value of '%s'"
-msgstr "Konnte Remote-Helper für '%s' nicht finden."
+msgstr "Konnte Anführungszeichen von '%s' nicht entfernen."
 
 #: sequencer.c:732 wrapper.c:227 wrapper.c:397 builtin/am.c:719
 #: builtin/am.c:811 builtin/merge.c:1081
 #, c-format
 msgid "could not open '%s' for reading"
 msgstr "Konnte '%s' nicht zum Lesen öffnen."
 
 #: sequencer.c:742
 msgid "'GIT_AUTHOR_NAME' already given"
-msgstr ""
+msgstr "'GIT_AUTHOR_NAME' bereits angegeben."
 
 #: sequencer.c:747
 msgid "'GIT_AUTHOR_EMAIL' already given"
-msgstr ""
+msgstr "'GIT_AUTHOR_EMAIL' bereits angegeben."
 
 #: sequencer.c:752
 msgid "'GIT_AUTHOR_DATE' already given"
-msgstr ""
+msgstr "'GIT_AUTHOR_DATE' bereits angegeben."
 
 #: sequencer.c:756
-#, fuzzy, c-format
+#, c-format
 msgid "unknown variable '%s'"
-msgstr "Unbekanntes Archivformat '%s'"
+msgstr "Unbekannte Variable '%s'"
 
 #: sequencer.c:761
 msgid "missing 'GIT_AUTHOR_NAME'"
-msgstr ""
+msgstr "'GIT_AUTHOR_NAME' fehlt."
 
 #: sequencer.c:763
 msgid "missing 'GIT_AUTHOR_EMAIL'"
-msgstr ""
+msgstr "'GIT_AUTHOR_EMAIL' fehlt."
 
 #: sequencer.c:765
 msgid "missing 'GIT_AUTHOR_DATE'"
-msgstr ""
+msgstr "'GIT_AUTHOR_DATE' fehlt."
 
 #: sequencer.c:825
 #, c-format
 msgid "invalid date format '%s' in '%s'"
 msgstr "Ungültiges Datumsformat '%s' in '%s'"
 
 #: sequencer.c:842
 #, c-format
@@ -5310,38 +5300,38 @@ msgid ""
 "Your changes are safe in the stash.\n"
 "You can run \"git stash pop\" or \"git stash drop\" at any time.\n"
 msgstr ""
 "Anwendung des automatischen Stash resultierte in Konflikten.\n"
 "Ihre Änderungen sind im Stash sicher.\n"
 "Sie können jederzeit \"git stash pop\" oder \"git stash drop\" ausführen.\n"
 
 #: sequencer.c:3427
-#, fuzzy, c-format
+#, c-format
 msgid "could not checkout %s"
-msgstr "kann %s nicht auschecken"
+msgstr "Konnte %s nicht auschecken."
 
 #: sequencer.c:3441
-#, fuzzy, c-format
+#, c-format
 msgid "%s: not a valid OID"
-msgstr "%s ist kein gültiges Objekt"
+msgstr "%s: keine gültige OID"
 
 #: sequencer.c:3446 git-rebase--preserve-merges.sh:724
 msgid "could not detach HEAD"
 msgstr "Konnte HEAD nicht loslösen"
 
 #: sequencer.c:3461
-#, fuzzy, c-format
+#, c-format
 msgid "Stopped at HEAD\n"
-msgstr "Angehalten bei %s... %.*s\n"
+msgstr "Angehalten bei HEAD\n"
 
 #: sequencer.c:3463
-#, fuzzy, c-format
+#, c-format
 msgid "Stopped at %s\n"
-msgstr "Angehalten bei %s... %.*s\n"
+msgstr "Angehalten bei %s\n"
 
 #: sequencer.c:3471
 #, c-format
 msgid ""
 "Could not execute the todo command\n"
 "\n"
 "    %.*s\n"
 "It has been rescheduled; To edit the command before continuing, please\n"
@@ -5495,41 +5485,38 @@ msgid ""
 "continue'.\n"
 "Or you can abort the rebase with 'git rebase --abort'.\n"
 msgstr ""
 "Sie können das mit 'git rebase --edit-todo' beheben. Führen Sie danach\n"
 "'git rebase --continue' aus.\n"
 "Oder Sie können den Rebase mit 'git rebase --abort' abbrechen.\n"
 
 #: sequencer.c:4848 sequencer.c:4886
-#, fuzzy
 msgid "nothing to do"
-msgstr "nichts zu committen\n"
+msgstr "Nichts zu tun."
 
 #: sequencer.c:4852
-#, fuzzy, c-format
+#, c-format
 msgid "Rebase %s onto %s (%d command)"
 msgid_plural "Rebase %s onto %s (%d commands)"
-msgstr[0] "Rebase von $shortrevisions auf $shortonto ($todocount Kommando)"
-msgstr[1] "Rebase von $shortrevisions auf $shortonto ($todocount Kommandos)"
+msgstr[0] "Rebase von %s auf %s (%d Kommando)"
+msgstr[1] "Rebase von %s auf %s (%d Kommandos)"
 
 #: sequencer.c:4864
-#, fuzzy, c-format
+#, c-format
 msgid "could not copy '%s' to '%s'."
 msgstr "Konnte '%s' nicht nach '%s' kopieren."
 
 #: sequencer.c:4868 sequencer.c:4897
-#, fuzzy
 msgid "could not transform the todo list"
-msgstr "Konnte TODO-Liste nicht erzeugen."
+msgstr "Konnte die TODO-Liste nicht umwandeln."
 
 #: sequencer.c:4900
-#, fuzzy
 msgid "could not skip unnecessary pick commands"
-msgstr "nicht erforderliche \"pick\"-Befehle auslassen"
+msgstr "Konnte unnötige \"pick\"-Befehle nicht auslassen."
 
 #: sequencer.c:4983
 msgid "the script was already rearranged."
 msgstr "Das Script wurde bereits umgeordnet."
 
 #: setup.c:123
 #, c-format
 msgid "'%s' is outside repository"
@@ -6091,17 +6078,17 @@ msgstr "Ignoriere verdächtigen Submodulnamen: %s"
 
 #: submodule-config.c:296
 msgid "negative values not allowed for submodule.fetchjobs"
 msgstr "Negative Werte für submodule.fetchjobs nicht erlaubt."
 
 #: submodule-config.c:390
 #, c-format
 msgid "ignoring '%s' which may be interpreted as a command-line option: %s"
-msgstr ""
+msgstr "Ignoriere '%s', was als eine Befehlszeilenoption '%s' interpretiert werden würde."
 
 #: submodule-config.c:479
 #, c-format
 msgid "invalid value for %s"
 msgstr "Ungültiger Wert für %s"
 
 #: submodule-config.c:754
 #, c-format
@@ -6690,16 +6677,19 @@ msgid "Checking out files"
 msgstr "Checke Dateien aus"
 
 #: unpack-trees.c:368
 msgid ""
 "the following paths have collided (e.g. case-sensitive paths\n"
 "on a case-insensitive filesystem) and only one from the same\n"
 "colliding group is in the working tree:\n"
 msgstr ""
+"Die folgenden Pfade haben kollidiert (z.B. case-sensitive Pfade\n"
+"auf einem case-insensitiven Dateisystem) und nur einer von der\n"
+"selben Kollissionsgruppe ist im Arbeitsverzeichnis:\n"
 
 #: urlmatch.c:163
 msgid "invalid URL scheme name or missing '://' suffix"
 msgstr "Ungültiges URL-Schema oder Suffix '://' fehlt"
 
 #: urlmatch.c:187 urlmatch.c:346 urlmatch.c:405
 #, c-format
 msgid "invalid %XX escape sequence"
@@ -7571,17 +7561,17 @@ msgstr ""
 #, c-format
 msgid "To restore the original branch and stop patching, run \"%s --abort\"."
 msgstr ""
 "Um den ursprünglichen Branch wiederherzustellen und die Anwendung der "
 "Patches abzubrechen, führen Sie \"%s --abort\" aus."
 
 #: builtin/am.c:1196
 msgid "Patch sent with format=flowed; space at the end of lines might be lost."
-msgstr ""
+msgstr "Patch mit format=flowed versendet; Leerzeichen am Ende von Zeilen könnte verloren gehen."
 
 #: builtin/am.c:1224
 msgid "Patch is empty."
 msgstr "Patch ist leer."
 
 #: builtin/am.c:1290
 #, c-format
 msgid "invalid ident line: %.*s"
@@ -8584,19 +8574,18 @@ msgstr ""
 msgid ""
 "git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv | --"
 "filters]"
 msgstr ""
 "git cat-file (--batch | --batch-check) [--follow-symlinks] [--textconv | --"
 "filters]"
 
 #: builtin/cat-file.c:609
-#, fuzzy
 msgid "only one batch option may be specified"
-msgstr "Nur eine Aktion erlaubt."
+msgstr "Nur eine Batch-Option erlaubt."
 
 #: builtin/cat-file.c:627
 msgid "<type> can be one of: blob, tree, commit, tag"
 msgstr "<Art> kann sein: blob, tree, commit, tag"
 
 #: builtin/cat-file.c:628
 msgid "show object type"
 msgstr "Objektart anzeigen"
@@ -10363,19 +10352,18 @@ msgstr "globale Konfigurationsdatei verwenden"
 msgid "use system config file"
 msgstr "systemweite Konfigurationsdatei verwenden"
 
 #: builtin/config.c:127
 msgid "use repository config file"
 msgstr "Konfigurationsdatei des Repositories verwenden"
 
 #: builtin/config.c:128
-#, fuzzy
 msgid "use per-worktree config file"
-msgstr "Konfigurationsdatei des Repositories verwenden"
+msgstr "Konfigurationsdatei pro Arbeitsverzeichnis verwenden"
 
 #: builtin/config.c:129
 msgid "use given config file"
 msgstr "die angegebene Konfigurationsdatei verwenden"
 
 #: builtin/config.c:130
 msgid "blob-id"
 msgstr "Blob-Id"
@@ -10576,16 +10564,19 @@ msgid "$HOME not set"
 msgstr "$HOME nicht gesetzt."
 
 #: builtin/config.c:657
 msgid ""
 "--worktree cannot be used with multiple working trees unless the config\n"
 "extension worktreeConfig is enabled. Please read \"CONFIGURATION FILE\"\n"
 "section in \"git help worktree\" for details"
 msgstr ""
+"--worktree kann nicht mit mehreren Arbeitsverzeichnissen verwendet werden,\n"
+"außer die Konfigurationserweiterung worktreeConfig ist aktiviert. Bitte\n"
+"lesen Sie die Sektion \"CONFIGURATION_FILE\" in \"git help worktree\" für Details"
 
 #: builtin/config.c:687
 msgid "--get-color and variable type are incoherent"
 msgstr "Angabe von --get-color und Variablentyp sind ungültig."
 
 #: builtin/config.c:692
 msgid "only one action at a time"
 msgstr "Nur eine Aktion erlaubt."
@@ -11030,19 +11021,18 @@ msgstr "fordert von allen Remote-Repositories an"
 msgid "append to .git/FETCH_HEAD instead of overwriting"
 msgstr "an .git/FETCH_HEAD anhängen, anstatt zu überschreiben"
 
 #: builtin/fetch.c:119 builtin/pull.c:200
 msgid "path to upload pack on remote end"
 msgstr "Pfad des Programms zum Hochladen von Paketen auf der Gegenseite"
 
 #: builtin/fetch.c:120
-#, fuzzy
 msgid "force overwrite of local reference"
-msgstr "das Überschreiben von lokalen Branches erzwingen"
+msgstr "das Überschreiben einer lokalen Referenz erzwingen"
 
 #: builtin/fetch.c:122
 msgid "fetch from multiple remotes"
 msgstr "von mehreren Remote-Repositories anfordern"
 
 #: builtin/fetch.c:124 builtin/pull.c:204
 msgid "fetch all tags and associated objects"
 msgstr "alle Tags und verbundene Objekte anfordern"
@@ -11171,17 +11161,17 @@ msgstr "[Tag Aktualisierung]"
 
 #: builtin/fetch.c:731 builtin/fetch.c:771 builtin/fetch.c:787
 #: builtin/fetch.c:802
 msgid "unable to update local ref"
 msgstr "kann lokale Referenz nicht aktualisieren"
 
 #: builtin/fetch.c:735
 msgid "would clobber existing tag"
-msgstr ""
+msgstr "würde bestehende Tags verändern"
 
 #: builtin/fetch.c:757
 msgid "[new tag]"
 msgstr "[neues Tag]"
 
 #: builtin/fetch.c:760
 msgid "[new branch]"
 msgstr "[neuer Branch]"
@@ -11655,19 +11645,18 @@ msgstr "binäre Dateien als Text verarbeiten"
 msgid "don't match patterns in binary files"
 msgstr "keine Muster in Binärdateien finden"
 
 #: builtin/grep.c:822
 msgid "process binary files with textconv filters"
 msgstr "binäre Dateien mit \"textconv\"-Filtern verarbeiten"
 
 #: builtin/grep.c:824
-#, fuzzy
 msgid "search in subdirectories (default)"
-msgstr "lose Referenzen entfernen (Standard)"
+msgstr "in Unterverzeichnissen suchen (Standard)"
 
 #: builtin/grep.c:826
 msgid "descend at most <depth> levels"
 msgstr "höchstens <Tiefe> Ebenen durchlaufen"
 
 #: builtin/grep.c:830
 msgid "use extended POSIX regular expressions"
 msgstr "erweiterte reguläre Ausdrücke aus POSIX verwenden"
@@ -11817,23 +11806,22 @@ msgid "--no-index or --untracked cannot be used with revs"
 msgstr "--no-index oder --untracked können nicht mit Commits verwendet werden"
 
 #: builtin/grep.c:1020
 #, c-format
 msgid "unable to resolve revision: %s"
 msgstr "Konnte Commit nicht auflösen: %s"
 
 #: builtin/grep.c:1051
-#, fuzzy
 msgid "invalid option combination, ignoring --threads"
-msgstr "keine Unterstützung von Threads, --threads wird ignoriert"
+msgstr "Ungültige Kombination von Optionen, --threads wird ignoriert."
 
 #: builtin/grep.c:1054 builtin/pack-objects.c:3397
 msgid "no threads support, ignoring --threads"
-msgstr "keine Unterstützung von Threads, --threads wird ignoriert"
+msgstr "Keine Unterstützung für Threads, --threads wird ignoriert."
 
 #: builtin/grep.c:1057 builtin/index-pack.c:1503 builtin/pack-objects.c:2716
 #, c-format
 msgid "invalid number of threads specified (%d)"
 msgstr "ungültige Anzahl von Threads angegeben (%d)"
 
 #: builtin/grep.c:1080
 msgid "--open-files-in-pager only works on the worktree"
@@ -11993,19 +11981,19 @@ msgid "no info viewer handled the request"
 msgstr "kein Informations-Betrachter konnte mit dieser Anfrage umgehen"
 
 #: builtin/help.c:430 builtin/help.c:441 git.c:322
 #, c-format
 msgid "'%s' is aliased to '%s'"
 msgstr "Für '%s' wurde der Alias '%s' angelegt."
 
 #: builtin/help.c:444
-#, fuzzy, c-format
+#, c-format
 msgid "bad alias.%s string: %s"
-msgstr "Ungültiger branch.%s.mergeoptions String: %s"
+msgstr "Ungültiger alias.%s String: %s"
 
 #: builtin/help.c:473 builtin/help.c:503
 #, c-format
 msgid "usage: %s%s"
 msgstr "Verwendung: %s%s"
 
 #: builtin/help.c:487
 msgid "'git help config' for more information"
@@ -12460,17 +12448,17 @@ msgid "join whitespace-continued values"
 msgstr "durch Leerzeichen fortgesetzte Werte verbinden"
 
 #: builtin/interpret-trailers.c:107
 msgid "set parsing options"
 msgstr "Optionen für das Parsen setzen"
 
 #: builtin/interpret-trailers.c:109
 msgid "do not treat --- specially"
-msgstr ""
+msgstr "--- nicht speziell behandeln"
 
 #: builtin/interpret-trailers.c:110
 msgid "trailer"
 msgstr "Anhang"
 
 #: builtin/interpret-trailers.c:111
 msgid "trailer(s) to add"
 msgstr "Anhang/Anhänge hinzufügen"
@@ -12621,19 +12609,18 @@ msgstr "Basis-Commit sollte der Vorgänger der Revisionsliste sein."
 msgid "base commit shouldn't be in revision list"
 msgstr "Basis-Commit sollte nicht in der Revisionsliste enthalten sein."
 
 #: builtin/log.c:1418
 msgid "cannot get patch id"
 msgstr "kann Patch-Id nicht lesen"
 
 #: builtin/log.c:1470
-#, fuzzy
 msgid "failed to infer range-diff ranges"
-msgstr "Fehler beim Generieren des Diffs."
+msgstr "Fehler beim Ableiten des range-diff-Bereichs."
 
 #: builtin/log.c:1515
 msgid "use [PATCH n/m] even with a single patch"
 msgstr "[PATCH n/m] auch mit einzelnem Patch verwenden"
 
 #: builtin/log.c:1518
 msgid "use [PATCH] even with multiple patches"
 msgstr "[PATCH] auch mit mehreren Patches verwenden"
@@ -12781,30 +12768,28 @@ msgstr "eine Signatur aus einer Datei hinzufügen"
 msgid "don't print the patch filenames"
 msgstr "keine Dateinamen der Patches anzeigen"
 
 #: builtin/log.c:1584
 msgid "show progress while generating patches"
 msgstr "Forschrittsanzeige während der Erzeugung der Patches"
 
 #: builtin/log.c:1585
-#, fuzzy
 msgid "rev"
-msgstr "Revert"
+msgstr "Commit"
 
 #: builtin/log.c:1586
 msgid "show changes against <rev> in cover letter or single patch"
-msgstr ""
+msgstr "Änderungen gegenüber <Commit> im Deckblatt oder einzelnem Patch anzeigen"
 
 #: builtin/log.c:1589
 msgid "show changes against <refspec> in cover letter or single patch"
-msgstr ""
+msgstr "Änderungen gegenüber <Refspec> im Deckblatt oder einzelnem Patch anzeigen"
 
 #: builtin/log.c:1591
-#, fuzzy
 msgid "percentage by which creation is weighted"
 msgstr "Prozentsatz mit welchem Erzeugung gewichtet wird"
 
 #: builtin/log.c:1666
 #, c-format
 msgid "invalid ident line: %s"
 msgstr "Ungültige Identifikationszeile: %s"
 
@@ -12834,43 +12819,43 @@ msgstr "Standard-Ausgabe oder Verzeichnis, welches von beidem?"
 
 #: builtin/log.c:1729
 #, c-format
 msgid "Could not create directory '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
 
 #: builtin/log.c:1816
 msgid "--interdiff requires --cover-letter or single patch"
-msgstr ""
+msgstr "--interdiff erfordert --cover-letter oder einzelnen Patch."
 
 #: builtin/log.c:1820
 msgid "Interdiff:"
-msgstr ""
+msgstr "Interdiff:"
 
 #: builtin/log.c:1821
 #, c-format
 msgid "Interdiff against v%d:"
-msgstr ""
+msgstr "Interdiff gegen v%d:"
 
 #: builtin/log.c:1827
 msgid "--creation-factor requires --range-diff"
-msgstr ""
+msgstr "--creation-factor erfordert --range-diff"
 
 #: builtin/log.c:1831
 msgid "--range-diff requires --cover-letter or single patch"
-msgstr ""
+msgstr "--range-diff erfordert --cover-letter oder einzelnen Patch."
 
 #: builtin/log.c:1839
 msgid "Range-diff:"
-msgstr ""
+msgstr "Range-Diff:"
 
 #: builtin/log.c:1840
 #, c-format
 msgid "Range-diff against v%d:"
-msgstr ""
+msgstr "Range-Diff gegen v%d:"
 
 #: builtin/log.c:1851
 #, c-format
 msgid "unable to read signature file '%s'"
 msgstr "Konnte Signatur-Datei '%s' nicht lesen"
 
 #: builtin/log.c:1887
 msgid "Generating patches"
@@ -13585,31 +13570,30 @@ msgid "allow missing objects"
 msgstr "fehlende Objekte erlauben"
 
 #: builtin/mktree.c:156
 msgid "allow creation of more than one tree"
 msgstr "die Erstellung von mehr als einem \"Tree\"-Objekt erlauben"
 
 #: builtin/multi-pack-index.c:8
 msgid "git multi-pack-index [--object-dir=<dir>] (write|verify)"
-msgstr ""
+msgstr "git multi-pack-index [--object-dir=<Verzeichnis>] (write|verify)"
 
 #: builtin/multi-pack-index.c:21
 msgid "object directory containing set of packfile and pack-index pairs"
-msgstr ""
+msgstr "Objekt-Verzeichnis, welches Paare von Packdateien und pack-index enthält"
 
 #: builtin/multi-pack-index.c:39
-#, fuzzy
 msgid "too many arguments"
 msgstr "Zu viele Argumente."
 
 #: builtin/multi-pack-index.c:48
-#, fuzzy, c-format
+#, c-format
 msgid "unrecognized verb: %s"
-msgstr "nicht erkanntes Argument: %s"
+msgstr "Nicht erkanntes Verb: %s"
 
 #: builtin/mv.c:17
 msgid "git mv [<options>] <source>... <destination>"
 msgstr "git mv [<Optionen>] <Quelle>... <Ziel>"
 
 #: builtin/mv.c:82
 #, c-format
 msgid "Directory %s is in index and no submodule?"
@@ -14268,19 +14252,19 @@ msgstr "Konnte Kopfbereich von Objekt '%s' nicht parsen."
 
 #: builtin/pack-objects.c:2083 builtin/pack-objects.c:2099
 #: builtin/pack-objects.c:2109
 #, c-format
 msgid "object %s cannot be read"
 msgstr "Objekt %s kann nicht gelesen werden."
 
 #: builtin/pack-objects.c:2086 builtin/pack-objects.c:2113
-#, fuzzy, c-format
+#, c-format
 msgid "object %s inconsistent object length (%<PRIuMAX> vs %<PRIuMAX>)"
-msgstr "Inkonsistente Objektlänge bei Objekt %s (%lu vs. %lu)"
+msgstr "Inkonsistente Objektlänge bei Objekt %s (%<PRIuMAX> vs %<PRIuMAX>)"
 
 #: builtin/pack-objects.c:2123
 msgid "suboptimal pack - out of memory"
 msgstr "ungünstiges Packet - Speicher voll"
 
 #: builtin/pack-objects.c:2451
 #, c-format
 msgid "Delta compression using up to %d threads"
@@ -14512,19 +14496,18 @@ msgstr "Behandlung für fehlende Objekte"
 
 #: builtin/pack-objects.c:3316
 msgid "do not pack objects in promisor packfiles"
 msgstr ""
 "keine Objekte aus Packdateien von partiell geklonten Remote-Repositories "
 "packen"
 
 #: builtin/pack-objects.c:3318
-#, fuzzy
 msgid "respect islands during delta compression"
-msgstr "Größe des Fensters für die Delta-Kompression"
+msgstr "Delta-Islands bei Delta-Kompression beachten"
 
 #: builtin/pack-objects.c:3342
 #, c-format
 msgid "delta chain depth %d is too deep, forcing %d"
 msgstr "Tiefe für Verkettung von Unterschieden %d ist zu tief, erzwinge %d"
 
 #: builtin/pack-objects.c:3347
 #, c-format
@@ -14735,19 +14718,19 @@ msgid ""
 "Your configuration specifies to merge with the ref '%s'\n"
 "from the remote, but no such ref was fetched."
 msgstr ""
 "Ihre Konfiguration gibt an, den Merge mit Referenz '%s'\n"
 "des Remote-Repositories durchzuführen, aber diese Referenz\n"
 "wurde nicht angefordert."
 
 #: builtin/pull.c:565
-#, fuzzy, c-format
+#, c-format
 msgid "unable to access commit %s"
-msgstr "Konnte Commit '%s' nicht parsen."
+msgstr "Konnte nicht auf Commit '%s' zugreifen."
 
 #: builtin/pull.c:843
 msgid "ignoring --verify-signatures for rebase"
 msgstr "Ignoriere --verify-signatures für Rebase"
 
 #: builtin/pull.c:891
 msgid "--[no-]autostash option is only valid with --rebase."
 msgstr "--[no-]autostash ist nur mit --rebase zulässig."
@@ -14824,17 +14807,17 @@ msgid ""
 "\n"
 "To choose either option permanently, see push.default in 'git help config'."
 msgstr ""
 "\n"
 "Um eine Variante permanent zu verwenden, siehe push.default in 'git help "
 "config'."
 
 #: builtin/push.c:168
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "The upstream branch of your current branch does not match\n"
 "the name of your current branch.  To push to the upstream branch\n"
 "on the remote, use\n"
 "\n"
 "    git push %s HEAD:%s\n"
 "\n"
 "To push to the branch of the same name on the remote, use\n"
@@ -14846,17 +14829,17 @@ msgstr ""
 "aktuellen Branches überein. Um auf den Upstream-Branch in dem Remote-\n"
 "Repository zu versenden, benutzen Sie:\n"
 "\n"
 "    git push %s HEAD:%s\n"
 "\n"
 "Um auf den Branch mit demselben Namen im Remote-Repository zu versenden,\n"
 "benutzen Sie:\n"
 "\n"
-"    git push %s %s\n"
+"    git push %s HEAD\n"
 "%s"
 
 #: builtin/push.c:183
 #, c-format
 msgid ""
 "You are not currently on a branch.\n"
 "To push the history leading to the current (detached HEAD)\n"
 "state now, use\n"
@@ -15214,63 +15197,59 @@ msgstr "weder den Index, noch das Arbeitsverzeichnis aktualisieren"
 msgid "skip applying sparse checkout filter"
 msgstr "Anwendung des Filters für partielles Auschecken überspringen"
 
 #: builtin/read-tree.c:152
 msgid "debug unpack-trees"
 msgstr "unpack-trees protokollieren"
 
 #: builtin/rebase.c:29
-#, fuzzy
 msgid ""
 "git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] [<upstream>] "
 "[<branch>]"
-msgstr ""
-"git archive --remote <Repository> [--exec <Programm>] [<Optionen>] <Commit-"
-"Referenz> [<Pfad>...]"
+msgstr "git rebase [-i] [<Optionen>] [--exec <Programm>] [--onto <neue-Basis>] [<Upstream>] [<Branch>]"
 
 #: builtin/rebase.c:31
 msgid ""
 "git rebase [-i] [options] [--exec <cmd>] [--onto <newbase>] --root [<branch>]"
-msgstr ""
+msgstr "git rebase [-i] [<Optionen>] [--exec <Programm>] [--onto <neue-Basis>] --root [<Branch>]"
 
 #: builtin/rebase.c:33
-#, fuzzy
 msgid "git rebase --continue | --abort | --skip | --edit-todo"
-msgstr "git am [<Optionen>] (--continue | --skip | --abort)"
+msgstr "git rebase --continue | --abort | --skip | --edit-todo"
 
 #: builtin/rebase.c:119
-#, fuzzy, c-format
+#, c-format
 msgid "%s requires an interactive rebase"
-msgstr "interaktiv ausführen"
+msgstr "%s erfordert ein interaktives Rebase"
 
 #: builtin/rebase.c:171
-#, fuzzy, c-format
+#, c-format
 msgid "could not get 'onto': '%s'"
-msgstr "Konnte '%s' nicht zu '%s' setzen."
+msgstr "Konnte 'onto' nicht bestimmen: '%s'"
 
 #: builtin/rebase.c:186
-#, fuzzy, c-format
+#, c-format
 msgid "invalid orig-head: '%s'"
-msgstr "Ungültige Datei: '%s'"
+msgstr "Ungültiges orig-head: '%s'"
 
 #: builtin/rebase.c:214
 #, c-format
 msgid "ignoring invalid allow_rerere_autoupdate: '%s'"
-msgstr ""
+msgstr "Ignoriere ungültiges allow_rerere_autoupdate: '%s'"
 
 #: builtin/rebase.c:259
-#, fuzzy, c-format
+#, c-format
 msgid "Could not read '%s'"
-msgstr "Konnte '%s' nicht lesen"
+msgstr "Konnte '%s' nicht lesen."
 
 #: builtin/rebase.c:277
-#, fuzzy, c-format
+#, c-format
 msgid "Cannot store %s"
-msgstr "kann %s nicht speichern"
+msgstr "Kann %s nicht speichern."
 
 #: builtin/rebase.c:337
 msgid ""
 "Resolve all conflicts manually, mark them as resolved with\n"
 "\"git add/rm <conflicted_files>\", then run \"git rebase --continue\".\n"
 "You can instead skip this commit: run \"git rebase --skip\".\n"
 "To abort and get back to the state before \"git rebase\", run \"git rebase --"
 "abort\"."
@@ -15279,191 +15258,174 @@ msgstr ""
 "\"git add/rm <konfliktbehaftete_Dateien>\" und führen Sie dann\n"
 "\"git rebase --continue\" aus.\n"
 "Sie können auch stattdessen diesen Commit auslassen, indem\n"
 "Sie \"git rebase --skip\" ausführen.\n"
 "Um abzubrechen und zurück zum Zustand vor \"git rebase\" zu gelangen,\n"
 "führen Sie \"git rebase --abort\" aus."
 
 #: builtin/rebase.c:561
-#, fuzzy
 msgid "could not determine HEAD revision"
-msgstr "Konnte HEAD nicht loslösen"
+msgstr "Konnte HEAD-Commit nicht bestimmen."
 
 #: builtin/rebase.c:753
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "%s\n"
 "Please specify which branch you want to rebase against.\n"
 "See git-rebase(1) for details.\n"
 "\n"
 "    git rebase '<branch>'\n"
 "\n"
 msgstr ""
-"Bitte geben Sie den Branch an, gegen welchen Sie \"rebase\" ausführen "
-"möchten."
+"%s\n"
+"Bitte geben Sie den Branch an, gegen welchen Sie \"rebase\" ausführen möchten.\n"
+"Siehe git-rebase(1) für Details.\n"
+"\n"
+"    git rebase '<Branch>'\n"
+"\n"
 
 #: builtin/rebase.c:769
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "If you wish to set tracking information for this branch you can do so with:\n"
 "\n"
 "    git branch --set-upstream-to=%s/<branch> %s\n"
 "\n"
 msgstr ""
-"Wenn Sie Tracking-Informationen für diesen Branch setzen möchten, können "
-"Sie\n"
-"dies tun mit:"
+"Wenn Sie Tracking-Informationen für diesen Branch setzen möchten,\n"
+"können Sie dies tun mit:\n"
+"\n"
+"    git branch --set-upstream-to=%s/<Branch> %s\n"
+"\n"
 
 #: builtin/rebase.c:832
-#, fuzzy
 msgid "rebase onto given branch instead of upstream"
-msgstr "Branch %s kann nicht sein eigener Upstream-Branch sein."
+msgstr "Rebase auf angegebenen Branch anstelle des Upstream-Branches ausführen"
 
 #: builtin/rebase.c:834
-#, fuzzy
 msgid "allow pre-rebase hook to run"
-msgstr "Der \"pre-rebase hook\" hat den Rebase zurückgewiesen."
+msgstr "Ausführung des pre-rebase-Hooks erlauben"
 
 #: builtin/rebase.c:836
 msgid "be quiet. implies --no-stat"
-msgstr ""
+msgstr "weniger Ausgaben (impliziert --no-stat)"
 
 #: builtin/rebase.c:839
 msgid "display a diffstat of what changed upstream"
-msgstr ""
+msgstr "Zusammenfassung der Unterschiede gegenüber dem Upstream-Branch anzeigen"
 
 #: builtin/rebase.c:842
-#, fuzzy
 msgid "do not show diffstat of what changed upstream"
-msgstr "keine Zusammenfassung der Unterschiede am Schluss des Merges anzeigen"
+msgstr "Zusammenfassung der Unterschiede gegenüber dem Upstream-Branch verbergen"
 
 #: builtin/rebase.c:845
-#, fuzzy
 msgid "add a Signed-off-by: line to each commit"
-msgstr "der Commit-Beschreibung eine Signed-off-by Zeile hinzufügen"
+msgstr "eine \"Signed-off-by:\"-Zeile zu jedem Commit hinzufügen"
 
 #: builtin/rebase.c:847 builtin/rebase.c:851 builtin/rebase.c:853
 msgid "passed to 'git am'"
-msgstr ""
+msgstr "an 'git am' übergeben"
 
 #: builtin/rebase.c:855 builtin/rebase.c:857
-#, fuzzy
 msgid "passed to 'git apply'"
-msgstr "an git-apply übergeben"
+msgstr "an 'git apply' übergeben"
 
 #: builtin/rebase.c:859 builtin/rebase.c:862
 msgid "cherry-pick all commits, even if unchanged"
-msgstr ""
+msgstr "Cherry-Pick auf alle Commits ausführen, auch wenn diese unverändert sind"
 
 #: builtin/rebase.c:864
-#, fuzzy
 msgid "continue"
-msgstr "Rebase fortsetzen"
+msgstr "fortsetzen"
 
 #: builtin/rebase.c:867
-#, fuzzy
 msgid "skip current patch and continue"
-msgstr "den aktuellen Patch auslassen"
+msgstr "den aktuellen Patch auslassen und fortfahren"
 
 #: builtin/rebase.c:869
-#, fuzzy
 msgid "abort and check out the original branch"
-msgstr ""
-"  (benutzen Sie \"git rebase --abort\", um den ursprünglichen Branch "
-"auszuchecken)"
+msgstr "abbrechen und den ursprünglichen Branch auschecken"
 
 #: builtin/rebase.c:872
-#, fuzzy
 msgid "abort but keep HEAD where it is"
-msgstr "Patch-Operation abbrechen, aber HEAD an aktueller Stelle belassen"
+msgstr "abbrechen, aber HEAD an aktueller Stelle belassen"
 
 #: builtin/rebase.c:873
-#, fuzzy
 msgid "edit the todo list during an interactive rebase"
-msgstr ""
-"Die --edit-todo Aktion kann nur während eines interaktiven Rebase verwendet "
-"werden."
+msgstr "TODO-Liste während eines interaktiven Rebase bearbeiten"
 
 #: builtin/rebase.c:876
-#, fuzzy
 msgid "show the patch file being applied or merged"
-msgstr "den Patch, der gerade angewendet wird, anzeigen"
+msgstr "den Patch, der gerade angewendet oder zusammengeführt wird, anzeigen"
 
 #: builtin/rebase.c:879
-#, fuzzy
 msgid "use merging strategies to rebase"
-msgstr "zu verwendende Merge-Strategie"
+msgstr "Merge-Strategien beim Rebase verwenden"
 
 #: builtin/rebase.c:883
 msgid "let the user edit the list of commits to rebase"
-msgstr ""
+msgstr "den Benutzer die Liste der Commits für den Rebase bearbeiten lassen"
 
 #: builtin/rebase.c:887
 msgid "try to recreate merges instead of ignoring them"
-msgstr ""
+msgstr "versuchen, Merges wiederherzustellen anstatt sie zu ignorieren"
 
 #: builtin/rebase.c:891
 msgid "allow rerere to update index with resolved conflict"
-msgstr ""
+msgstr "Rerere erlauben, den Index mit dem aufgelöstem Konflikt zu aktualisieren"
 
 #: builtin/rebase.c:894
-#, fuzzy
 msgid "preserve empty commits during rebase"
-msgstr "ursprüngliche, leere Commits erhalten"
+msgstr "leere Commits während des Rebase erhalten"
 
 #: builtin/rebase.c:896
 msgid "move commits that begin with squash!/fixup! under -i"
-msgstr ""
+msgstr "bei -i Commits verschieben, die mit squash!/fixup! beginnen"
 
 #: builtin/rebase.c:902
-#, fuzzy
 msgid "automatically stash/stash pop before and after"
-msgstr "automatischer Stash/Stash-Pop vor und nach eines Rebase"
+msgstr "automatischer Stash/Stash-Pop davor und danach"
 
 #: builtin/rebase.c:904
 msgid "add exec lines after each commit of the editable list"
-msgstr ""
+msgstr "exec-Zeilen nach jedem Commit der editierbaren Liste hinzufügen"
 
 #: builtin/rebase.c:908
-#, fuzzy
 msgid "allow rebasing commits with empty messages"
-msgstr "Commits mit leerer Beschreibung erlauben"
+msgstr "Rebase von Commits mit leerer Beschreibung erlauben"
 
 #: builtin/rebase.c:911
 msgid "try to rebase merges instead of skipping them"
-msgstr ""
+msgstr "versuchen, Rebase mit Merges auszuführen, anstatt diese zu überspringen"
 
 #: builtin/rebase.c:914
-#, fuzzy
 msgid "use 'merge-base --fork-point' to refine upstream"
-msgstr "git merge-base --fork-point <Referenz> [<Commit>]"
+msgstr "'git merge-base --fork-point' benutzen, um Upstream-Branch zu bestimmen"
 
 #: builtin/rebase.c:916
-#, fuzzy
 msgid "use the given merge strategy"
-msgstr "Option für Merge-Strategie"
+msgstr "angegebene Merge-Strategie verwenden"
 
 #: builtin/rebase.c:918 builtin/revert.c:111
 msgid "option"
 msgstr "Option"
 
 #: builtin/rebase.c:919
 msgid "pass the argument through to the merge strategy"
-msgstr ""
+msgstr "Argument zur Merge-Strategie durchreichen"
 
 #: builtin/rebase.c:922
-#, fuzzy
 msgid "rebase all reachable commits up to the root(s)"
-msgstr "alle nicht erreichbaren Objekte von der Objektdatenbank entfernen"
+msgstr "Rebase auf alle erreichbaren Commits bis zum Root-Commit ausführen"
 
 #: builtin/rebase.c:938
-#, fuzzy, c-format
+#, c-format
 msgid "could not exec %s"
-msgstr "konnte %s nicht parsen"
+msgstr "Konnte 'exec %s' nicht ausführen."
 
 #: builtin/rebase.c:956 git-legacy-rebase.sh:213
 msgid "It looks like 'git am' is in progress. Cannot rebase."
 msgstr "'git-am' scheint im Gange zu sein. Kann Rebase nicht durchführen."
 
 #: builtin/rebase.c:997 git-legacy-rebase.sh:395
 msgid "No rebase in progress?"
 msgstr "Kein Rebase im Gange?"
@@ -15482,262 +15444,242 @@ msgstr "Kann HEAD nicht lesen"
 msgid ""
 "You must edit all merge conflicts and then\n"
 "mark them as resolved using git add"
 msgstr ""
 "Sie müssen alle Merge-Konflikte editieren und diese dann\n"
 "mittels \"git add\" als aufgelöst markieren"
 
 #: builtin/rebase.c:1047
-#, fuzzy
 msgid "could not discard worktree changes"
-msgstr "Kann Änderungen im Arbeitsverzeichnis nicht löschen"
+msgstr "Konnte Änderungen im Arbeitsverzeichnis nicht verwerfen."
 
 #: builtin/rebase.c:1066
-#, fuzzy, c-format
+#, c-format
 msgid "could not move back to %s"
-msgstr "Konnte nicht zu $head_name zurückgehen"
+msgstr "Konnte nicht zu %s zurückgehen."
 
 #: builtin/rebase.c:1077 builtin/rm.c:368
 #, c-format
 msgid "could not remove '%s'"
 msgstr "Konnte '%s' nicht löschen"
 
 #: builtin/rebase.c:1103
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "It seems that there is already a %s directory, and\n"
 "I wonder if you are in the middle of another rebase.  If that is the\n"
 "case, please try\n"
 "\t%s\n"
 "If that is not the case, please\n"
 "\t%s\n"
 "and run me again.  I am stopping in case you still have something\n"
 "valuable there.\n"
 msgstr ""
-"Es sieht so aus, als ob es das Verzeichnis $state_dir_base bereits gibt\n"
+"Es sieht so aus, als ob es das Verzeichnis %s bereits gibt\n"
 "und es könnte ein anderer Rebase im Gange sein. Wenn das der Fall ist,\n"
 "probieren Sie bitte\n"
-"\t$cmd_live_rebase\n"
+"\t%s\n"
 "Wenn das nicht der Fall ist, probieren Sie bitte\n"
-"\t$cmd_clear_stale_rebase\n"
+"\t%s\n"
 "und führen Sie diesen Befehl nochmal aus. Es wird angehalten, falls noch\n"
-"etwas Schützenswertes vorhanden ist."
+"etwas Schützenswertes vorhanden ist.\n"
 
 #: builtin/rebase.c:1124
-#, fuzzy
 msgid "switch `C' expects a numerical value"
-msgstr "Schalter '%c' erwartet einen numerischen Wert"
+msgstr "Schalter `C' erwartet einen numerischen Wert."
 
 #: builtin/rebase.c:1161
-#, fuzzy, c-format
+#, c-format
 msgid "Unknown mode: %s"
-msgstr "Unbekannter --patch Modus: %s"
+msgstr "Unbekannter Modus: %s"
 
 #: builtin/rebase.c:1183
 msgid "--strategy requires --merge or --interactive"
-msgstr ""
+msgstr "--strategy erfordert --merge oder --interactive"
 
 #: builtin/rebase.c:1226
 #, c-format
 msgid ""
 "error: cannot combine interactive options (--interactive, --exec, --rebase-"
 "merges, --preserve-merges, --keep-empty, --root + --onto) with am options "
 "(%s)"
-msgstr ""
+msgstr "Fehler: 'interactive'-Optionen (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto ) können nicht mit 'am'-Optionen (%s) kombiniert werden."
 
 #: builtin/rebase.c:1231
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "error: cannot combine merge options (--merge, --strategy, --strategy-option) "
 "with am options (%s)"
-msgstr ""
-"Fehler: '--rebase-merges' und '--strategy-option' können nicht kombiniert "
-"werden."
+msgstr "Fehler: 'merge'-Optionen (--merge, --strategy, --strategy-option) können nicht mit 'am'-Optionen (%s) kombiniert werden."
 
 #: builtin/rebase.c:1251 git-legacy-rebase.sh:536
-#, fuzzy
 msgid "error: cannot combine '--preserve-merges' with '--rebase-merges'"
-msgstr ""
-"Fehler: '--preserve-merges' und '--rebase-merges' können nicht kombiniert "
-"werden."
+msgstr "Fehler: '--preserve-merges' und '--rebase-merges' können nicht kombiniert werden."
 
 #: builtin/rebase.c:1256 git-legacy-rebase.sh:542
-#, fuzzy
 msgid "error: cannot combine '--rebase-merges' with '--strategy-option'"
 msgstr ""
 "Fehler: '--rebase-merges' und '--strategy-option' können nicht kombiniert "
 "werden."
 
 #: builtin/rebase.c:1259 git-legacy-rebase.sh:544
-#, fuzzy
 msgid "error: cannot combine '--rebase-merges' with '--strategy'"
 msgstr ""
 "Fehler: '--rebase-merges' und '--strategy' können nicht kombiniert werden."
 
 #: builtin/rebase.c:1283
-#, fuzzy, c-format
+#, c-format
 msgid "invalid upstream '%s'"
-msgstr "Ungültiger Pfad '%s'"
+msgstr "Ungültiger Upstream '%s'"
 
 #: builtin/rebase.c:1289
-#, fuzzy
 msgid "Could not create new root commit"
-msgstr "Konnte neu erstellten Commit nicht analysieren."
+msgstr "Konnte neuen Root-Commit nicht erstellen."
 
 #: builtin/rebase.c:1307
-#, fuzzy, c-format
+#, c-format
 msgid "'%s': need exactly one merge base"
-msgstr "Brauche genau einen Commit-Bereich."
+msgstr "'%s': benötige genau eine Merge-Basis"
 
 #: builtin/rebase.c:1314
-#, fuzzy, c-format
+#, c-format
 msgid "Does not point to a valid commit '%s'"
-msgstr "$onto_name zeigt auf keinen gültigen Commit"
+msgstr "'%s' zeigt auf keinen gültigen Commit."
 
 #: builtin/rebase.c:1339
-#, fuzzy, c-format
+#, c-format
 msgid "fatal: no such branch/commit '%s'"
-msgstr "fatal: Branch/Commit '$branch_name' nicht gefunden"
+msgstr "fatal: Branch/Commit '%s' nicht gefunden"
 
 #: builtin/rebase.c:1347 builtin/submodule--helper.c:37
 #: builtin/submodule--helper.c:1930
 #, c-format
 msgid "No such ref: %s"
 msgstr "Referenz nicht gefunden: %s"
 
 #: builtin/rebase.c:1359
-#, fuzzy
 msgid "Could not resolve HEAD to a revision"
-msgstr "Konnte HEAD-Commit nicht auflösen."
+msgstr "Konnte HEAD zu keinem Commit auflösen."
 
 #: builtin/rebase.c:1399 git-legacy-rebase.sh:665
 msgid "Cannot autostash"
 msgstr "Kann automatischen Stash nicht erzeugen."
 
 #: builtin/rebase.c:1402
-#, fuzzy, c-format
+#, c-format
 msgid "Unexpected stash response: '%s'"
-msgstr "Unerwartetes wanted-ref: '%s'"
+msgstr "Unerwartete 'stash'-Antwort: '%s'"
 
 #: builtin/rebase.c:1408
-#, fuzzy, c-format
+#, c-format
 msgid "Could not create directory for '%s'"
-msgstr "Konnte Verzeichnis '%s' nicht erstellen."
+msgstr "Konnte Verzeichnis für '%s' nicht erstellen."
 
 #: builtin/rebase.c:1411
-#, fuzzy, c-format
+#, c-format
 msgid "Created autostash: %s\n"
-msgstr "Automatischen Stash erzeugt: $stash_abbrev"
+msgstr "Automatischen Stash erzeugt: %s\n"
 
 #: builtin/rebase.c:1414
-#, fuzzy
 msgid "could not reset --hard"
-msgstr "Konnte orig-head nicht lesen."
+msgstr "Konnte 'reset --hard' nicht ausführen."
 
 #: builtin/rebase.c:1415 builtin/reset.c:113
 #, c-format
 msgid "HEAD is now at %s"
 msgstr "HEAD ist jetzt bei %s"
 
 #: builtin/rebase.c:1431 git-legacy-rebase.sh:674
 msgid "Please commit or stash them."
 msgstr "Bitte committen Sie die Änderungen oder benutzen Sie \"stash\"."
 
 #: builtin/rebase.c:1458
-#, fuzzy, c-format
+#, c-format
 msgid "could not parse '%s'"
-msgstr "konnte %s nicht parsen"
+msgstr "Konnte '%s' nicht parsen."
 
 #: builtin/rebase.c:1470
-#, fuzzy, c-format
+#, c-format
 msgid "could not switch to %s"
-msgstr "Konnte nicht nach '%s' schreiben."
+msgstr "Konnte nicht zu %s wechseln."
 
 #: builtin/rebase.c:1481 git-legacy-rebase.sh:697
 #, sh-format
 msgid "HEAD is up to date."
 msgstr "HEAD ist aktuell."
 
 #: builtin/rebase.c:1483
-#, fuzzy, c-format
+#, c-format
 msgid "Current branch %s is up to date.\n"
-msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
+msgstr "Aktueller Branch %s ist auf dem neuesten Stand.\n"
 
 #: builtin/rebase.c:1491 git-legacy-rebase.sh:707
 #, sh-format
 msgid "HEAD is up to date, rebase forced."
 msgstr "HEAD ist aktuell, Rebase erzwungen."
 
 #: builtin/rebase.c:1493
-#, fuzzy, c-format
+#, c-format
 msgid "Current branch %s is up to date, rebase forced.\n"
-msgstr ""
-"Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzwungen."
+msgstr "Aktueller Branch %s ist auf dem neuesten Stand, Rebase erzwungen.\n"
 
 #: builtin/rebase.c:1501 git-legacy-rebase.sh:208
 msgid "The pre-rebase hook refused to rebase."
 msgstr "Der \"pre-rebase hook\" hat den Rebase zurückgewiesen."
 
 #: builtin/rebase.c:1508
-#, fuzzy, c-format
+#, c-format
 msgid "Changes to %s:\n"
-msgstr "Änderungen von $mb zu $onto:"
+msgstr "Änderungen zu %s:\n"
 
 #: builtin/rebase.c:1511
-#, fuzzy, c-format
+#, c-format
 msgid "Changes from %s to %s:\n"
-msgstr "Änderungen von $mb zu $onto:"
+msgstr "Änderungen von %s zu %s:\n"
 
 #: builtin/rebase.c:1536
-#, fuzzy, c-format
+#, c-format
 msgid "First, rewinding head to replay your work on top of it...\n"
-msgstr ""
-"Zunächst wird der Branch zurückgespult, um Ihre Änderungen\n"
-"darauf neu anzuwenden ..."
+msgstr "Zunächst wird der Branch zurückgespult, um Ihre Änderungen darauf neu anzuwenden...\n"
 
 #: builtin/rebase.c:1543
-#, fuzzy
 msgid "Could not detach HEAD"
-msgstr "Konnte HEAD nicht loslösen"
+msgstr "Konnte HEAD nicht loslösen."
 
 #: builtin/rebase.c:1552
-#, fuzzy, c-format
+#, c-format
 msgid "Fast-forwarded %s to %s.\n"
-msgstr "Spule vor zu $sha1"
+msgstr "Spule %s vor zu %s.\n"
 
 #: builtin/rebase--interactive.c:24
-#, fuzzy
 msgid "no HEAD?"
 msgstr "Kein HEAD?"
 
 #: builtin/rebase--interactive.c:51
-#, fuzzy, c-format
+#, c-format
 msgid "could not create temporary %s"
-msgstr "konnte temporäre Datei nicht erstellen"
+msgstr "Konnte temporäres Verzeichnis '%s' nicht erstellen."
 
 #: builtin/rebase--interactive.c:57
-#, fuzzy
 msgid "could not mark as interactive"
-msgstr "Konnte nicht als interaktiven Rebase markieren."
+msgstr "Markierung auf interaktiven Rebase fehlgeschlagen."
 
 #: builtin/rebase--interactive.c:101
-#, fuzzy, c-format
+#, c-format
 msgid "could not open %s"
-msgstr "Konnte '%s' nicht öffnen"
+msgstr "Konnte '%s' nicht öffnen."
 
 #: builtin/rebase--interactive.c:114
-#, fuzzy
 msgid "could not generate todo list"
 msgstr "Konnte TODO-Liste nicht erzeugen."
 
 #: builtin/rebase--interactive.c:129
-#, fuzzy
 msgid "git rebase--interactive [<options>]"
-msgstr "git rebase--helper [<Optionen>]"
+msgstr "git rebase--interactive [<Optionen>]"
 
 #: builtin/rebase--interactive.c:148
 msgid "keep empty commits"
 msgstr "leere Commits behalten"
 
 #: builtin/rebase--interactive.c:150 builtin/revert.c:124
 msgid "allow commits with empty messages"
 msgstr "Commits mit leerer Beschreibung erlauben"
@@ -15747,41 +15689,37 @@ msgid "rebase merge commits"
 msgstr "Rebase auf Merge-Commits ausführen"
 
 #: builtin/rebase--interactive.c:153
 msgid "keep original branch points of cousins"
 msgstr "originale Branch-Punkte der Cousins behalten"
 
 #: builtin/rebase--interactive.c:155
 msgid "move commits that begin with squash!/fixup!"
-msgstr ""
+msgstr "Commits verschieben, die mit squash!/fixup! beginnen"
 
 #: builtin/rebase--interactive.c:156
-#, fuzzy
 msgid "sign commits"
-msgstr "Commits mit GPG signieren"
+msgstr "Commits signieren"
 
 #: builtin/rebase--interactive.c:158
 msgid "continue rebase"
 msgstr "Rebase fortsetzen"
 
 #: builtin/rebase--interactive.c:160
-#, fuzzy
 msgid "skip commit"
-msgstr "Commit"
+msgstr "Commit auslassen"
 
 #: builtin/rebase--interactive.c:161
-#, fuzzy
 msgid "edit the todo list"
-msgstr "die TODO-Liste prüfen"
+msgstr "die TODO-Liste bearbeiten"
 
 #: builtin/rebase--interactive.c:163
-#, fuzzy
 msgid "show the current patch"
-msgstr "den aktuellen Patch auslassen"
+msgstr "den aktuellen Patch anzeigen"
 
 #: builtin/rebase--interactive.c:166
 msgid "shorten commit ids in the todo list"
 msgstr "Commit-IDs in der TODO-Liste verkürzen"
 
 #: builtin/rebase--interactive.c:168
 msgid "expand commit ids in the todo list"
 msgstr "Commit-IDs in der TODO-Liste erweitern"
@@ -15795,104 +15733,89 @@ msgid "rearrange fixup/squash lines"
 msgstr "fixup/squash-Zeilen umordnen"
 
 #: builtin/rebase--interactive.c:174
 msgid "insert exec commands in todo list"
 msgstr "\"exec\"-Befehle in TODO-Liste einfügen"
 
 #: builtin/rebase--interactive.c:175
 msgid "onto"
-msgstr ""
+msgstr "auf"
 
 #: builtin/rebase--interactive.c:177
-#, fuzzy
 msgid "restrict-revision"
-msgstr "Commit"
+msgstr "Begrenzungscommit"
 
 #: builtin/rebase--interactive.c:177
-#, fuzzy
 msgid "restrict revision"
-msgstr "Commit"
+msgstr "Begrenzungscommit"
 
 #: builtin/rebase--interactive.c:178
-#, fuzzy
 msgid "squash-onto"
-msgstr "squash-onto schreiben"
+msgstr "squash-onto"
 
 #: builtin/rebase--interactive.c:179
-#, fuzzy
 msgid "squash onto"
-msgstr "squash-onto schreiben"
+msgstr "squash onto"
 
 #: builtin/rebase--interactive.c:181
-#, fuzzy
 msgid "the upstream commit"
-msgstr "Informationen zum Upstream-Branch entfernen"
+msgstr "der Upstream-Commit"
 
 #: builtin/rebase--interactive.c:182
-#, fuzzy
 msgid "head-name"
-msgstr "umbenennen"
+msgstr "head-Name"
 
 #: builtin/rebase--interactive.c:182
-#, fuzzy
 msgid "head name"
-msgstr "voraus "
+msgstr "head-Name"
 
 #: builtin/rebase--interactive.c:187
-#, fuzzy
 msgid "rebase strategy"
-msgstr "Merge-Strategie"
+msgstr "Rebase-Strategie"
 
 #: builtin/rebase--interactive.c:188
-#, fuzzy
 msgid "strategy-opts"
-msgstr "Strategie"
+msgstr "Strategie-Optionen"
 
 #: builtin/rebase--interactive.c:189
-#, fuzzy
 msgid "strategy options"
-msgstr "decorate-Optionen"
+msgstr "Strategie-Optionen"
 
 #: builtin/rebase--interactive.c:190
 msgid "switch-to"
-msgstr ""
+msgstr "wechseln zu"
 
 #: builtin/rebase--interactive.c:191
-#, fuzzy
 msgid "the branch or commit to checkout"
-msgstr "einzelnen Commit zu einem ausgecheckten CSV-Repository exportieren"
+msgstr "der Branch oder Commit zum Auschecken"
 
 #: builtin/rebase--interactive.c:192
-#, fuzzy
 msgid "onto-name"
-msgstr "Name"
+msgstr "onto-Name"
 
 #: builtin/rebase--interactive.c:192
-#, fuzzy
 msgid "onto name"
-msgstr "Name des Remote-Repositories"
+msgstr "onto-Name"
 
 #: builtin/rebase--interactive.c:193
-#, fuzzy
 msgid "cmd"
-msgstr "Programm"
+msgstr "Befehl"
 
 #: builtin/rebase--interactive.c:193
-#, fuzzy
 msgid "the command to run"
-msgstr "Keine Befehle ausgeführt."
+msgstr "auszuführender Befehl"
 
 #: builtin/rebase--interactive.c:220
 msgid "--[no-]rebase-cousins has no effect without --rebase-merges"
 msgstr "--[no-]rebase-cousins hat ohne --rebase-merges keine Auswirkung"
 
 #: builtin/rebase--interactive.c:226
 msgid "a base commit must be provided with --upstream or --onto"
-msgstr ""
+msgstr "Ein Basis-Commit muss mit --upstream oder --onto angegeben werden."
 
 #: builtin/receive-pack.c:33
 msgid "git receive-pack <git-dir>"
 msgstr "git receive-pack <Git-Verzeichnis>"
 
 #: builtin/receive-pack.c:830
 msgid ""
 "By default, updating the current branch in a non-bare repository\n"
@@ -16121,19 +16044,19 @@ msgstr "Konnte Fetch-Map für Refspec %s nicht bekommen"
 msgid "(matching)"
 msgstr "(übereinstimmend)"
 
 #: builtin/remote.c:455
 msgid "(delete)"
 msgstr "(lösche)"
 
 #: builtin/remote.c:629 builtin/remote.c:765 builtin/remote.c:864
-#, fuzzy, c-format
+#, c-format
 msgid "No such remote: '%s'"
-msgstr "Kein solches Remote-Repository '%s'"
+msgstr "Kein solches Remote-Repository: '%s'"
 
 #: builtin/remote.c:646
 #, c-format
 msgid "Could not rename config section '%s' to '%s'"
 msgstr "Konnte Sektion '%s' in Konfiguration nicht nach '%s' umbenennen"
 
 #: builtin/remote.c:666
 #, c-format
@@ -16519,19 +16442,18 @@ msgstr "git-update-server-info nicht ausführen"
 msgid "pass --local to git-pack-objects"
 msgstr "--local an git-pack-objects übergeben"
 
 #: builtin/repack.c:310
 msgid "write bitmap index"
 msgstr "Bitmap-Index schreiben"
 
 #: builtin/repack.c:312
-#, fuzzy
 msgid "pass --delta-islands to git-pack-objects"
-msgstr "--local an git-pack-objects übergeben"
+msgstr "--delta-islands an git-pack-objects übergeben"
 
 #: builtin/repack.c:313
 msgid "approxidate"
 msgstr "Datumsangabe"
 
 #: builtin/repack.c:314
 msgid "with -A, do not loosen objects older than this"
 msgstr "mit -A, keine Objekte älter als dieses Datum löschen"
@@ -16842,22 +16764,22 @@ msgid "git rerere [clear | forget <path>... | status | remaining | diff | gc]"
 msgstr "git rerere [clean | forget <Pfad>... | status | remaining | diff | gc]"
 
 #: builtin/rerere.c:60
 msgid "register clean resolutions in index"
 msgstr "saubere Auflösungen im Index registrieren"
 
 #: builtin/rerere.c:79
 msgid "'git rerere forget' without paths is deprecated"
-msgstr ""
+msgstr "'git rerere forget' ohne Pfade ist veraltet."
 
 #: builtin/rerere.c:111
-#, fuzzy, c-format
+#, c-format
 msgid "unable to generate diff for '%s'"
-msgstr "Fehler beim Generieren des Diffs."
+msgstr "Konnte kein Diff für '%s' generieren."
 
 #: builtin/reset.c:31
 msgid ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<commit>]"
 msgstr ""
 "git reset [--mixed | --soft | --hard | --merge | --keep] [-q] [<Commit>]"
 
 #: builtin/reset.c:32
@@ -16971,16 +16893,21 @@ msgstr "Nicht zum Commit vorgemerkte Änderungen nach Zurücksetzung:"
 #: builtin/reset.c:390
 #, c-format
 msgid ""
 "\n"
 "It took %.2f seconds to enumerate unstaged changes after reset.  You can\n"
 "use '--quiet' to avoid this.  Set the config setting reset.quiet to true\n"
 "to make this the default.\n"
 msgstr ""
+"\n"
+"Es dauerte %.2f Sekunden, um über die nach einem Reset nicht zum Commit\n"
+"vorgemerkten Änderungen zu zählen. Sie können '--quiet' benutzen, um\n"
+"das zu verhindern. Setzen Sie die Konfigurationseinstellung reset.quiet\n"
+"auf \"true\", um das zum Standard zu machen.\n"
 
 #: builtin/reset.c:400
 #, c-format
 msgid "Could not reset index file to revision '%s'."
 msgstr "Konnte Index-Datei nicht zu Commit '%s' setzen."
 
 #: builtin/reset.c:404
 msgid "Could not write new index file."
@@ -17546,24 +17473,23 @@ msgstr ""
 msgid "Recurse into nested submodules"
 msgstr "Rekursion in verschachtelte Submodule durchführen"
 
 #: builtin/submodule--helper.c:568
 msgid "git submodule--helper foreach [--quiet] [--recursive] <command>"
 msgstr "git submodule--helper foreach [--quiet] [--recursive] <Befehl>"
 
 #: builtin/submodule--helper.c:595
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "could not look up configuration '%s'. Assuming this repository is its own "
 "authoritative upstream."
 msgstr ""
-"Konnte Konfiguration '%s' nicht nachschlagen. Nehme an, dass dieses "
-"Repository\n"
-"sein eigenes verbindliches Upstream-Repository ist."
+"Konnte Konfiguration '%s' nicht nachschlagen. Nehme an, dass dieses\n"
+"Repository sein eigenes verbindliches Upstream-Repository ist."
 
 #: builtin/submodule--helper.c:663
 #, c-format
 msgid "Failed to register url for submodule path '%s'"
 msgstr ""
 "Fehler beim Eintragen der URL für Submodul-Pfad '%s' in die Konfiguration."
 
 #: builtin/submodule--helper.c:667
@@ -17768,28 +17694,24 @@ msgid "clone of '%s' into submodule path '%s' failed"
 msgstr "Klonen von '%s' in Submodul-Pfad '%s' fehlgeschlagen"
 
 #: builtin/submodule--helper.c:1433
 #, c-format
 msgid "could not get submodule directory for '%s'"
 msgstr "Konnte Submodul-Verzeichnis '%s' nicht finden."
 
 #: builtin/submodule--helper.c:1469
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid update mode '%s' for submodule path '%s'"
-msgstr ""
-"Fehler bei Änderung des Aktualisierungsmodus für Submodul-Pfad '%s' in der\n"
-"Konfiguration."
+msgstr "Ungültiger Aktualisierungsmodus '%s' für Submodul-Pfad '%s'."
 
 #: builtin/submodule--helper.c:1473
-#, fuzzy, c-format
+#, c-format
 msgid "Invalid update mode '%s' configured for submodule path '%s'"
-msgstr ""
-"Fehler bei Änderung des Aktualisierungsmodus für Submodul-Pfad '%s' in der\n"
-"Konfiguration."
+msgstr "Ungültiger Aktualisierungsmodus '%s' für Submodul-Pfad '%s' konfiguriert."
 
 #: builtin/submodule--helper.c:1566
 #, c-format
 msgid "Submodule path '%s' not initialized"
 msgstr "Submodul-Pfad '%s' nicht initialisiert"
 
 #: builtin/submodule--helper.c:1570
 msgid "Maybe you want to use 'update --init'?"
@@ -17862,48 +17784,44 @@ msgstr "Fehlerhafter Wert für --update Parameter"
 msgid ""
 "Submodule (%s) branch configured to inherit branch from superproject, but "
 "the superproject is not on any branch"
 msgstr ""
 "Branch von Submodul (%s) ist konfiguriert, den Branch des Hauptprojektes\n"
 "zu erben, aber das Hauptprojekt befindet sich auf keinem Branch."
 
 #: builtin/submodule--helper.c:2057
-#, fuzzy, c-format
+#, c-format
 msgid "could not get a repository handle for submodule '%s'"
-msgstr "konnte Name für Submodul '%s' nicht nachschlagen"
+msgstr "Konnte kein Repository-Handle für Submodul '%s' erhalten."
 
 #: builtin/submodule--helper.c:2090
 msgid "recurse into submodules"
 msgstr "Rekursion in Submodule durchführen"
 
 #: builtin/submodule--helper.c:2096
 msgid "git submodule--helper embed-git-dir [<path>...]"
 msgstr "git submodule--helper embed-git-dir [<Pfad>...]"
 
 #: builtin/submodule--helper.c:2152
 msgid "check if it is safe to write to the .gitmodules file"
-msgstr ""
+msgstr "prüfen, ob es sicher ist, in die Datei .gitmodules zu schreiben"
 
 #: builtin/submodule--helper.c:2157
-#, fuzzy
 msgid "git submodule--helper config name [value]"
-msgstr "git submodule--helper name <Pfad>"
+msgstr "git submodule--helper config name [Wert]"
 
 #: builtin/submodule--helper.c:2158
-#, fuzzy
 msgid "git submodule--helper config --check-writeable"
-msgstr "git submodule--helper init [<Pfad>]"
+msgstr "git submodule--helper config --check-writeable"
 
 #: builtin/submodule--helper.c:2175 git-submodule.sh:169
-#, fuzzy, sh-format
+#, sh-format
 msgid "please make sure that the .gitmodules file is in the working tree"
-msgstr ""
-"Bitte merken Sie Ihre Änderungen in .gitmodules zum Commit vor oder\n"
-"benutzen Sie \"stash\", um fortzufahren."
+msgstr "Bitte stellen Sie sicher, dass sich die Datei .gitmodules im Arbeitsverzeichnis befindet."
 
 #: builtin/submodule--helper.c:2225
 #, c-format
 msgid "%s doesn't support --super-prefix"
 msgstr "%s unterstützt kein --super-prefix"
 
 #: builtin/submodule--helper.c:2231
 #, c-format
@@ -18587,33 +18505,39 @@ msgid "expire working trees older than <time>"
 msgstr "Arbeitsverzeichnisse älter als <Zeit> verfallen lassen"
 
 #: builtin/worktree.c:234
 #, c-format
 msgid "'%s' already exists"
 msgstr "'%s' existiert bereits"
 
 #: builtin/worktree.c:251
-#, fuzzy, c-format
+#, c-format
 msgid "unable to re-add worktree '%s'"
-msgstr "konnte \"Tree\"-Objekt (%s) nicht lesen"
+msgstr "Konnte Arbeitsverzeichnis '%s' nicht neu hinzufügen."
 
 #: builtin/worktree.c:256
 #, c-format
 msgid ""
 "'%s' is a missing but locked worktree;\n"
 "use 'add -f -f' to override, or 'unlock' and 'prune' or 'remove' to clear"
 msgstr ""
+"'%s' ist ein fehlendes, aber gesperrtes Arbeitsverzeichnis;\n"
+"Benutzen Sie 'add -f -f' zum Überschrieben, oder 'unlock' und 'prune'\n"
+"oder 'remove' zum Löschen."
 
 #: builtin/worktree.c:258
 #, c-format
 msgid ""
 "'%s' is a missing but already registered worktree;\n"
 "use 'add -f' to override, or 'prune' or 'remove' to clear"
 msgstr ""
+"'%s' ist ein fehlendes, aber bereits registriertes Arbeitsverzeichnis;\n"
+"Benutzen Sie 'add -f' zum Überschreiben, oder 'prune' oder 'remove' zum\n"
+"Löschen."
 
 #: builtin/worktree.c:309
 #, c-format
 msgid "could not create directory of '%s'"
 msgstr "Konnte Verzeichnis '%s' nicht erstellen."
 
 #: builtin/worktree.c:428 builtin/worktree.c:434
 #, c-format
@@ -18707,19 +18631,18 @@ msgstr "'%s' ist nicht gesperrt"
 
 #: builtin/worktree.c:743
 msgid "working trees containing submodules cannot be moved or removed"
 msgstr ""
 "Arbeitsverzeichnisse, die Submodule enthalten, können nicht verschoben oder\n"
 "entfernt werden."
 
 #: builtin/worktree.c:751
-#, fuzzy
 msgid "force move even if worktree is dirty or locked"
-msgstr "Löschen erzwingen, auch wenn das Arbeitsverzeichnis geändert wurde"
+msgstr "Verschieben erzwingen, auch wenn das Arbeitsverzeichnis geändert oder gesperrt ist"
 
 #: builtin/worktree.c:774 builtin/worktree.c:901
 #, c-format
 msgid "'%s' is a main working tree"
 msgstr "'%s' ist ein Hauptarbeitsverzeichnis"
 
 #: builtin/worktree.c:779
 #, c-format
@@ -18727,28 +18650,33 @@ msgid "could not figure out destination name from '%s'"
 msgstr "Konnte Zielname aus '%s' nicht bestimmen."
 
 #: builtin/worktree.c:785
 #, c-format
 msgid "target '%s' already exists"
 msgstr "Ziel '%s' existiert bereits."
 
 #: builtin/worktree.c:793
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "cannot move a locked working tree, lock reason: %s\n"
 "use 'move -f -f' to override or unlock first"
-msgstr "Kann gesperrtes Arbeitsverzeichnis nicht verschieben, Sperrgrund: %s"
+msgstr ""
+"Kann kein gesperrtes Arbeitsverzeichnis verschieben, Sperrgrund: %s\n"
+"Benutzen Sie 'move -f -f' zum Überschreiben oder entsperren Sie zuerst\n"
+"das Arbeitsverzeichnis."
 
 #: builtin/worktree.c:795
-#, fuzzy
 msgid ""
 "cannot move a locked working tree;\n"
 "use 'move -f -f' to override or unlock first"
-msgstr "Kann gesperrtes Arbeitsverzeichnis nicht verschieben, Sperrgrund: %s"
+msgstr ""
+"Kann kein gesperrtes Arbeitsverzeichnis verschieben.\n"
+"Benutzen Sie 'move -f -f' zum Überschreiben oder entsperren Sie zuerst\n"
+"das Arbeitsverzeichnis."
 
 #: builtin/worktree.c:798
 #, c-format
 msgid "validation failed, cannot move working tree: %s"
 msgstr "Validierung fehlgeschlagen, kann Arbeitszeichnis nicht verschieben: %s"
 
 #: builtin/worktree.c:803
 #, c-format
@@ -18766,33 +18694,37 @@ msgid "'%s' is dirty, use --force to delete it"
 msgstr "'%s' ist verändert, benutzen Sie --force zum Löschen"
 
 #: builtin/worktree.c:860
 #, c-format
 msgid "failed to run 'git status' on '%s', code %d"
 msgstr "Fehler beim Ausführen von 'git status' auf '%s'. Code: %d"
 
 #: builtin/worktree.c:883
-#, fuzzy
 msgid "force removal even if worktree is dirty or locked"
-msgstr "Löschen erzwingen, auch wenn das Arbeitsverzeichnis geändert wurde"
+msgstr "Löschen erzwingen, auch wenn das Arbeitsverzeichnis geändert oder gesperrt ist"
 
 #: builtin/worktree.c:906
-#, fuzzy, c-format
+#, c-format
 msgid ""
 "cannot remove a locked working tree, lock reason: %s\n"
 "use 'remove -f -f' to override or unlock first"
-msgstr "Kann gesperrtes Arbeitsverzeichnis nicht löschen, Sperrgrund: %s"
+msgstr ""
+"Kann kein gesperrtes Arbeitsverzeichnis löschen, Sperrgrund: %s\n"
+"Benutzen Sie 'remove -f -f' zum Überschreiben oder entsperren Sie zuerst\n"
+"das Arbeitsverzeichnis."
 
 #: builtin/worktree.c:908
-#, fuzzy
 msgid ""
 "cannot remove a locked working tree;\n"
 "use 'remove -f -f' to override or unlock first"
-msgstr "Kann gesperrtes Arbeitsverzeichnis nicht löschen, Sperrgrund: %s"
+msgstr ""
+"Kann kein gesperrtes Arbeitsverzeichnis löschen.\n"
+"Benutzen Sie 'remove -f -f' zum Überschreiben oder entsperren Sie zuerst\n"
+"das Arbeitsverzeichnis."
 
 #: builtin/worktree.c:911
 #, c-format
 msgid "validation failed, cannot remove working tree: %s"
 msgstr "Validierung fehlgeschlagen, kann Arbeitsverzeichnis nicht löschen: %s"
 
 #: builtin/write-tree.c:14
 msgid "git write-tree [--missing-ok] [--prefix=<prefix>/]"
@@ -18826,24 +18758,23 @@ msgstr ""
 "\n"
 "auszuführen."
 
 #: credential-cache--daemon.c:271
 msgid "print debugging messages to stderr"
 msgstr "Meldungen zur Fehlersuche in Standard-Fehlerausgabe ausgeben"
 
 #: t/helper/test-reach.c:152
-#, fuzzy, c-format
+#, c-format
 msgid "commit %s is not marked reachable"
-msgstr "Commit %s hat keinen Eltern-Commit %d"
+msgstr "Commit %s ist nicht als erreichbar gekennzeichnet."
 
 #: t/helper/test-reach.c:162
-#, fuzzy
 msgid "too many commits marked reachable"
-msgstr "Zu viele Commits zum Schreiben des Graphen."
+msgstr "Zu viele Commits als erreichbar gekennzeichnet."
 
 #: git.c:27
 msgid ""
 "git [--version] [--help] [-C <path>] [-c <name>=<value>]\n"
 "           [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]\n"
 "           [-p | --paginate | -P | --no-pager] [--no-replace-objects] [--"
 "bare]\n"
 "           [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]\n"
@@ -18900,17 +18831,17 @@ msgstr "Kein Verzeichnis für -C angegeben.\n"
 #: git.c:300
 #, c-format
 msgid "unknown option: %s\n"
 msgstr "Unbekannte Option: %s\n"
 
 #: git.c:719
 #, c-format
 msgid "alias loop detected: expansion of '%s' does not terminate:%s"
-msgstr ""
+msgstr "Alias-Schleife erkannt: Erweiterung von '%s' schließt nicht ab:%s"
 
 #: git.c:802
 #, c-format
 msgid "expansion of alias '%s' failed; '%s' is not a git command\n"
 msgstr "Erweiterung von Alias '%s' fehlgeschlagen; '%s' ist kein Git-Befehl.\n"
 
 #: git.c:814
 #, c-format
@@ -18928,43 +18859,37 @@ msgstr "Kontrolle über Delegation wird mit cURL < 7.22.0 nicht unterstützt"
 
 #: http.c:404
 msgid "Public key pinning not supported with cURL < 7.44.0"
 msgstr ""
 "Das Anheften des öffentlichen Schlüssels wird mit cURL < 7.44.0\n"
 "nicht unterstützt."
 
 #: http.c:837
-#, fuzzy
 msgid "CURLSSLOPT_NO_REVOKE not supported with cURL < 7.44.0"
-msgstr ""
-"Das Anheften des öffentlichen Schlüssels wird mit cURL < 7.44.0\n"
-"nicht unterstützt."
+msgstr "CURLSSLOPT_NO_REVOKE wird mit cURL < 7.44.0 nicht unterstützt."
 
 #: http.c:910
-#, fuzzy
 msgid "Protocol restrictions not supported with cURL < 7.19.4"
-msgstr ""
-"Das Anheften des öffentlichen Schlüssels wird mit cURL < 7.44.0\n"
-"nicht unterstützt."
+msgstr "Protokollbeschränkungen werden mit cURL < 7.19.4 nicht unterstützt."
 
 #: http.c:1046
 #, c-format
 msgid "Unsupported SSL backend '%s'. Supported SSL backends:"
-msgstr ""
+msgstr "Nicht unterstütztes SSL-Backend '%s'. Unterstützte SSL-Backends:"
 
 #: http.c:1053
 #, c-format
 msgid "Could not set SSL backend to '%s': cURL was built without SSL backends"
-msgstr ""
+msgstr "Konnte SSL-Backend nicht zu '%s' setzen: cURL wurde ohne SSL-Backends gebaut."
 
 #: http.c:1057
-#, fuzzy, c-format
+#, c-format
 msgid "Could not set SSL backend to '%s': already set"
-msgstr "Konnte nicht zu $head_name zurückgehen"
+msgstr "Konnte SSL-Backend nicht zu '%s' setzen: bereits gesetzt"
 
 #: http.c:1921
 #, c-format
 msgid ""
 "unable to update url base from redirection:\n"
 "  asked for: %s\n"
 "   redirect: %s"
 msgstr ""
@@ -19017,19 +18942,18 @@ msgstr "eine Serie von Patches von einer Mailbox anwenden"
 msgid "Annotate file lines with commit information"
 msgstr "Zeilen der Datei mit Commit-Informationen versehen und anzeigen"
 
 #: command-list.h:53
 msgid "Apply a patch to files and/or to the index"
 msgstr "einen Patch auf Dateien und/oder den Index anwenden"
 
 #: command-list.h:54
-#, fuzzy
 msgid "Import a GNU Arch repository into Git"
-msgstr "ein Arch Repository in Git importieren"
+msgstr "ein GNU Arch Repository in Git importieren"
 
 #: command-list.h:55
 msgid "Create an archive of files from a named tree"
 msgstr "Dateiarchiv von angegebenem Verzeichnis erstellen"
 
 #: command-list.h:56
 msgid "Use binary search to find the commit that introduced a bug"
 msgstr ""
@@ -19105,19 +19029,18 @@ msgstr "ein Repository in einem neuen Verzeichnis klonen"
 msgid "Display data in columns"
 msgstr "Daten in Spalten anzeigen"
 
 #: command-list.h:73
 msgid "Record changes to the repository"
 msgstr "Änderungen in das Repository eintragen"
 
 #: command-list.h:74
-#, fuzzy
 msgid "Write and verify Git commit-graph files"
-msgstr "Git Commit Graph-Dateien schreiben und überprüfen"
+msgstr "Git Commit-Graph-Dateien schreiben und überprüfen"
 
 #: command-list.h:75
 msgid "Create a new commit object"
 msgstr "ein neues Commit-Objekt erstellen"
 
 #: command-list.h:76
 msgid "Get and set repository or global options"
 msgstr "repositoryweite oder globale Optionen lesen oder setzen"
@@ -19337,19 +19260,18 @@ msgid "Run merge conflict resolution tools to resolve merge conflicts"
 msgstr ""
 "Ausführen von Tools zur Auflösung von Merge-Konflikten zur Behebung dieser"
 
 #: command-list.h:127
 msgid "Show three-way merge without touching index"
 msgstr "3-Wege-Merge anzeigen ohne den Index zu verändern"
 
 #: command-list.h:128
-#, fuzzy
 msgid "Write and verify multi-pack-indexes"
-msgstr "Git Commit Graph-Dateien schreiben und überprüfen"
+msgstr "multi-pack-indexes schreiben und überprüfen"
 
 #: command-list.h:129
 msgid "Creates a tag object"
 msgstr "ein Tag-Objekt erstellen"
 
 #: command-list.h:130
 msgid "Build a tree-object from ls-tree formatted text"
 msgstr "Tree-Objekt aus ls-tree formattiertem Text erzeugen"
@@ -19980,19 +19902,19 @@ msgstr "Aktueller Branch $branch_name ist auf dem neuesten Stand."
 
 #: git-legacy-rebase.sh:709
 #, sh-format
 msgid "Current branch $branch_name is up to date, rebase forced."
 msgstr ""
 "Aktueller Branch $branch_name ist auf dem neuesten Stand, Rebase erzwungen."
 
 #: git-legacy-rebase.sh:723
-#, fuzzy, sh-format
+#, sh-format
 msgid "Changes to $onto:"
-msgstr "Änderungen von $mb zu $onto:"
+msgstr "Änderungen zu $onto:"
 
 #: git-legacy-rebase.sh:725
 #, sh-format
 msgid "Changes from $mb to $onto:"
 msgstr "Änderungen von $mb zu $onto:"
 
 #: git-legacy-rebase.sh:736
 msgid "First, rewinding head to replay your work on top of it..."
@@ -21348,18 +21270,17 @@ msgstr "Unbekanntes --suppress-cc Feld: '%s'\n"
 #: git-send-email.perl:497
 #, perl-format
 msgid "Unknown --confirm setting: '%s'\n"
 msgstr "Unbekannte --confirm Einstellung: '%s'\n"
 
 #: git-send-email.perl:525
 #, perl-format
 msgid "warning: sendmail alias with quotes is not supported: %s\n"
-msgstr ""
-"Warnung: sendemail Alias mit Anführungsstrichen wird nicht unterstützt: %s\n"
+msgstr "Warnung: sendemail-Alias mit Anführungszeichen wird nicht unterstützt: %s\n"
 
 #: git-send-email.perl:527
 #, perl-format
 msgid "warning: `:include:` not supported: %s\n"
 msgstr "Warnung: `:include:` wird nicht unterstützt: %s\n"
 
 #: git-send-email.perl:529
 #, perl-format
-- 
2.20.0.rc1.379.g1dd7ef354c

