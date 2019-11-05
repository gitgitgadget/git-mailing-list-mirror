Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757D31F454
	for <e@80x24.org>; Tue,  5 Nov 2019 17:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390388AbfKERHr (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Nov 2019 12:07:47 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41115 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388897AbfKERHo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Nov 2019 12:07:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id p4so22291637wrm.8
        for <git@vger.kernel.org>; Tue, 05 Nov 2019 09:07:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=aj9SITtu2FmxiGJCDuTXqyQfmjsyy9+VWpLGyFdxbEs=;
        b=Yb0nFwQ/ZuG3Qvx+zVmm+JzpHerh8HFIuvcY/wrqh3040he6WC40I1THYUwT277ERs
         dpKka1/1pTvtPK6N9Z59sZsp6hzsi6fREjwRHFC51xvVA7rHrpjjdnOCtMFBeEnWu/t4
         8gS6k2nhJTzI/UDia4iQBUom0aLBVrd1cFe3vpJYj4XAN1O3wsMGyXbP3I/dg4qfnDEN
         Gk/3aKQB/iK1bYQHrbot+ldB9mhuVFh0unQMHPJkVg3rsFgE0zKn4EXuT9c0PU9hdRAa
         xiiQqAM6RQJjeebJaYuB84RrGRO/aurm7NijcuC2HEbh5paf5u7krm7G7mML6Pa9es1t
         cJ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=aj9SITtu2FmxiGJCDuTXqyQfmjsyy9+VWpLGyFdxbEs=;
        b=GzOYsVN53YwJLIgCncrK8rbXRORRK9Thg/e89sXNog4quAOsPi6oWyxq17yW5QY5KZ
         mkVa4FwnI5xQmIquBkntq1+RLhfXvt5hEFTY8dZEZpVp2/0dmtSdlzEO7uonHet0mIxd
         t44fBiL0MgqTbFb/uGRR4tmhTx/Ye0Hac96rLlQfLKSvu6twC+mxEARTCECB6wQ47w7K
         fprG00V9rjJOpt6fAky6+BNRXOvHwWABozdYvP+TfLnyrtN5o4JVDVbFDANCKNmhLMkD
         dqC63KwrT3YGkYT1/Zog5hCM55bT/yIPf3wJRqQuZHhWPG8lRfbD9OoV7WAT1AEfNkwU
         w+6g==
X-Gm-Message-State: APjAAAWxkBQ09Ed3Tq+ar69LVZqyMQS3NKyjyCXfjhnTOQia4kErDdP/
        P6v0yXTfE6eMYGtYfxLbOf+B1Ev9
X-Google-Smtp-Source: APXvYqzIsEPL5Jn/WGDN/S6uDwlFYlnPfSwninXnnJdI3VF268ty93sl9ezqlhpb0FuUU/YNElh5CA==
X-Received: by 2002:a5d:674d:: with SMTP id l13mr19266675wrw.170.1572973655913;
        Tue, 05 Nov 2019 09:07:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w4sm1149wmi.39.2019.11.05.09.07.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 05 Nov 2019 09:07:35 -0800 (PST)
Message-Id: <c5855f8b6b8d2953021d3f9bf878d53c9052c036.1572973650.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
References: <pull.418.git.1571790574.gitgitgadget@gmail.com>
        <pull.418.v2.git.1572973650.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 05 Nov 2019 17:07:20 +0000
Subject: [PATCH v2 01/11] Documentation: fix a bunch of typos, both old and
 new
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Reported-by: Jens Schleusener <Jens.Schleusener@fossies.org>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/CodingGuidelines                     |  4 ++--
 Documentation/RelNotes/1.5.0.txt                   |  4 ++--
 Documentation/RelNotes/1.6.5.4.txt                 |  2 +-
 Documentation/RelNotes/1.7.0.2.txt                 |  2 +-
 Documentation/RelNotes/1.7.10.4.txt                |  2 +-
 Documentation/RelNotes/1.7.12.3.txt                |  2 +-
 Documentation/RelNotes/1.7.5.3.txt                 |  2 +-
 Documentation/RelNotes/1.8.0.txt                   |  2 +-
 Documentation/RelNotes/1.8.4.1.txt                 |  2 +-
 Documentation/RelNotes/2.1.3.txt                   |  2 +-
 Documentation/RelNotes/2.10.0.txt                  |  2 +-
 Documentation/RelNotes/2.10.2.txt                  |  2 +-
 Documentation/RelNotes/2.11.1.txt                  |  2 +-
 Documentation/RelNotes/2.12.0.txt                  |  2 +-
 Documentation/RelNotes/2.13.0.txt                  |  2 +-
 Documentation/RelNotes/2.13.3.txt                  |  4 ++--
 Documentation/RelNotes/2.14.0.txt                  |  4 ++--
 Documentation/RelNotes/2.16.0.txt                  |  2 +-
 Documentation/RelNotes/2.16.3.txt                  |  2 +-
 Documentation/RelNotes/2.17.0.txt                  |  2 +-
 Documentation/RelNotes/2.18.0.txt                  |  2 +-
 Documentation/RelNotes/2.19.0.txt                  |  2 +-
 Documentation/RelNotes/2.20.0.txt                  |  2 +-
 Documentation/RelNotes/2.3.3.txt                   |  2 +-
 Documentation/RelNotes/2.3.7.txt                   |  2 +-
 Documentation/RelNotes/2.4.3.txt                   |  2 +-
 Documentation/RelNotes/2.7.0.txt                   |  2 +-
 Documentation/RelNotes/2.8.0.txt                   |  2 +-
 Documentation/RelNotes/2.9.3.txt                   |  2 +-
 Documentation/config.txt                           |  2 +-
 Documentation/config/tag.txt                       |  2 +-
 Documentation/git-bisect-lk2009.txt                |  2 +-
 Documentation/git-check-attr.txt                   |  2 +-
 Documentation/git-check-ignore.txt                 |  2 +-
 Documentation/git-cvsserver.txt                    |  2 +-
 Documentation/git-fast-export.txt                  |  2 +-
 Documentation/git-filter-branch.txt                |  2 +-
 Documentation/git-range-diff.txt                   |  2 +-
 Documentation/git-tag.txt                          |  2 +-
 Documentation/git-update-index.txt                 |  2 +-
 Documentation/git.txt                              |  4 ++--
 Documentation/gitattributes.txt                    |  6 +++---
 Documentation/gitmodules.txt                       |  2 +-
 Documentation/howto/separating-topic-branches.txt  |  2 +-
 Documentation/merge-options.txt                    |  2 +-
 Documentation/technical/api-submodule-config.txt   |  2 +-
 Documentation/technical/api-trace2.txt             | 14 +++++++-------
 Documentation/technical/commit-graph.txt           | 12 ++++++------
 .../technical/hash-function-transition.txt         |  4 ++--
 Documentation/technical/index-format.txt           |  4 ++--
 Documentation/technical/pack-protocol.txt          |  2 +-
 Documentation/technical/partial-clone.txt          |  2 +-
 Documentation/technical/protocol-v2.txt            |  2 +-
 Documentation/technical/rerere.txt                 |  2 +-
 54 files changed, 74 insertions(+), 74 deletions(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index f45db5b727..ed4e443a3c 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -75,7 +75,7 @@ For shell scripts specifically (not exhaustive):
 
  - If you want to find out if a command is available on the user's
    $PATH, you should use 'type <command>', instead of 'which <command>'.
-   The output of 'which' is not machine parseable and its exit code
+   The output of 'which' is not machine parsable and its exit code
    is not reliable across platforms.
 
  - We use POSIX compliant parameter substitutions and avoid bashisms;
@@ -203,7 +203,7 @@ For C programs:
    . since early 2012 with e1327023ea, we have been using an enum
      definition whose last element is followed by a comma.  This, like
      an array initializer that ends with a trailing comma, can be used
-     to reduce the patch noise when adding a new identifer at the end.
+     to reduce the patch noise when adding a new identifier at the end.
 
    . since mid 2017 with cbc0f81d, we have been using designated
      initializers for struct (e.g. "struct t v = { .val = 'a' };").
diff --git a/Documentation/RelNotes/1.5.0.txt b/Documentation/RelNotes/1.5.0.txt
index daf4bdb0d7..d6d42f3183 100644
--- a/Documentation/RelNotes/1.5.0.txt
+++ b/Documentation/RelNotes/1.5.0.txt
@@ -251,7 +251,7 @@ Updates in v1.5.0 since v1.4.4 series
    the repository when that happens.
 
 
-* Crufts removal
+* Cruft removal
 
  - We used to say "old commits are retrievable using reflog and
    'master@{yesterday}' syntax as long as you haven't run
@@ -379,7 +379,7 @@ Updates in v1.5.0 since v1.4.4 series
  - The value of i18n.commitencoding in the originating
    repository is recorded in the commit object on the "encoding"
    header, if it is not UTF-8.  git-log and friends notice this,
-   and reencodes the message to the log output encoding when
+   and re-encodes the message to the log output encoding when
    displaying, if they are different.  The log output encoding
    is determined by "git log --encoding=<encoding>",
    i18n.logoutputencoding configuration, or i18n.commitencoding
diff --git a/Documentation/RelNotes/1.6.5.4.txt b/Documentation/RelNotes/1.6.5.4.txt
index d3a2a3e712..344333de66 100644
--- a/Documentation/RelNotes/1.6.5.4.txt
+++ b/Documentation/RelNotes/1.6.5.4.txt
@@ -10,7 +10,7 @@ Fixes since v1.6.5.3
 
  * "git prune-packed" gave progress output even when its standard error is
    not connected to a terminal; this caused cron jobs that run it to
-   produce crufts.
+   produce cruft.
 
  * "git pack-objects --all-progress" is an option to ask progress output
    from write-object phase _if_ progress output were to be produced, and
diff --git a/Documentation/RelNotes/1.7.0.2.txt b/Documentation/RelNotes/1.7.0.2.txt
index fcb46ca6a4..73ed2b5278 100644
--- a/Documentation/RelNotes/1.7.0.2.txt
+++ b/Documentation/RelNotes/1.7.0.2.txt
@@ -34,7 +34,7 @@ Fixes since v1.7.0.1
  * "git status" in 1.7.0 lacked the optimization we used to have in 1.6.X series
    to speed up scanning of large working tree.
 
- * "gitweb" did not diagnose parsing errors properly while reading tis configuration
+ * "gitweb" did not diagnose parsing errors properly while reading its configuration
    file.
 
 And other minor fixes and documentation updates.
diff --git a/Documentation/RelNotes/1.7.10.4.txt b/Documentation/RelNotes/1.7.10.4.txt
index 326670df6e..57597f2bf3 100644
--- a/Documentation/RelNotes/1.7.10.4.txt
+++ b/Documentation/RelNotes/1.7.10.4.txt
@@ -7,7 +7,7 @@ Fixes since v1.7.10.3
  * The message file for Swedish translation has been updated a bit.
 
  * A name taken from mailmap was copied into an internal buffer
-   incorrectly and could overun the buffer if it is too long.
+   incorrectly and could overrun the buffer if it is too long.
 
  * A malformed commit object that has a header line chomped in the
    middle could kill git with a NULL pointer dereference.
diff --git a/Documentation/RelNotes/1.7.12.3.txt b/Documentation/RelNotes/1.7.12.3.txt
index ecda427a35..4b822976b8 100644
--- a/Documentation/RelNotes/1.7.12.3.txt
+++ b/Documentation/RelNotes/1.7.12.3.txt
@@ -25,7 +25,7 @@ Fixes since v1.7.12.2
    its Accept-Encoding header.
 
  * "git receive-pack" (the counterpart to "git push") did not give
-   progress output while processing objects it received to the puser
+   progress output while processing objects it received to the user
    when run over the smart-http protocol.
 
  * "git status" honored the ignore=dirty settings in .gitmodules but
diff --git a/Documentation/RelNotes/1.7.5.3.txt b/Documentation/RelNotes/1.7.5.3.txt
index 9c03353af2..1d24edcf2f 100644
--- a/Documentation/RelNotes/1.7.5.3.txt
+++ b/Documentation/RelNotes/1.7.5.3.txt
@@ -22,7 +22,7 @@ Fixes since v1.7.5.2
  * "git log --stdin path" with an input that has additional pathspec
    used to corrupt memory.
 
- * "git send-pack" (hence "git push") over smalt-HTTP protocol could
+ * "git send-pack" (hence "git push") over smart-HTTP protocol could
    deadlock when the client side pack-object died early.
 
  * Compressed tarball gitweb generates used to be made with the timestamp
diff --git a/Documentation/RelNotes/1.8.0.txt b/Documentation/RelNotes/1.8.0.txt
index 43883c14f0..63d6e4afa4 100644
--- a/Documentation/RelNotes/1.8.0.txt
+++ b/Documentation/RelNotes/1.8.0.txt
@@ -233,7 +233,7 @@ to them for details).
    together, misdetected branches.
 
  * "git receive-pack" (the counterpart to "git push") did not give
-   progress output while processing objects it received to the puser
+   progress output while processing objects it received to the user
    when run over the smart-http protocol.
 
  * When you misspell the command name you give to the "exec" action in
diff --git a/Documentation/RelNotes/1.8.4.1.txt b/Documentation/RelNotes/1.8.4.1.txt
index 96090ef599..c257beb114 100644
--- a/Documentation/RelNotes/1.8.4.1.txt
+++ b/Documentation/RelNotes/1.8.4.1.txt
@@ -15,7 +15,7 @@ Fixes since v1.8.4
    in 1.8.4-rc1).
 
  * "git rebase -i" and other scripted commands were feeding a
-   random, data dependant error message to 'echo' and expecting it
+   random, data dependent error message to 'echo' and expecting it
    to come out literally.
 
  * Setting the "submodule.<name>.path" variable to the empty
diff --git a/Documentation/RelNotes/2.1.3.txt b/Documentation/RelNotes/2.1.3.txt
index acc9ebb886..0dfb17c4fc 100644
--- a/Documentation/RelNotes/2.1.3.txt
+++ b/Documentation/RelNotes/2.1.3.txt
@@ -13,7 +13,7 @@ Git v2.1.3 Release Notes
    they are new enough to support the `--output` option.
 
  * "git pack-objects" forgot to disable the codepath to generate
-   object recheability bitmap when it needs to split the resulting
+   object reachability bitmap when it needs to split the resulting
    pack.
 
  * "gitweb" used deprecated CGI::startfrom, which was removed from
diff --git a/Documentation/RelNotes/2.10.0.txt b/Documentation/RelNotes/2.10.0.txt
index f4da28ab66..3792b7d03d 100644
--- a/Documentation/RelNotes/2.10.0.txt
+++ b/Documentation/RelNotes/2.10.0.txt
@@ -478,7 +478,7 @@ notes for details).
  * One part of "git am" had an oddball helper function that called
    stuff from outside "his" as opposed to calling what we have "ours",
    which was not gender-neutral and also inconsistent with the rest of
-   the system where outside stuff is usuall called "theirs" in
+   the system where outside stuff is usually called "theirs" in
    contrast to "ours".
 
  * "git blame file" allowed the lineage of lines in the uncommitted,
diff --git a/Documentation/RelNotes/2.10.2.txt b/Documentation/RelNotes/2.10.2.txt
index c4d4397023..abbd331508 100644
--- a/Documentation/RelNotes/2.10.2.txt
+++ b/Documentation/RelNotes/2.10.2.txt
@@ -86,7 +86,7 @@ Fixes since v2.10.1
    by refusing to check out a branch that is already checked out in
    another worktree.  However, this also prevented checking out a
    branch, which is designated as the primary branch of a bare
-   reopsitory, in a worktree that is connected to the bare
+   repository, in a worktree that is connected to the bare
    repository.  The check has been corrected to allow it.
 
  * "git rebase" immediately after "git clone" failed to find the fork
diff --git a/Documentation/RelNotes/2.11.1.txt b/Documentation/RelNotes/2.11.1.txt
index 9cd14c8197..7d35cf186d 100644
--- a/Documentation/RelNotes/2.11.1.txt
+++ b/Documentation/RelNotes/2.11.1.txt
@@ -104,7 +104,7 @@ Fixes since v2.11
    "git difftool --dir-diff" from a subdirectory never worked. This
    has been fixed.
 
- * "git p4" that tracks multile p4 paths imported a single changelist
+ * "git p4" that tracks multiple p4 paths imported a single changelist
    that touches files in these multiple paths as one commit, followed
    by many empty commits.  This has been fixed.
 
diff --git a/Documentation/RelNotes/2.12.0.txt b/Documentation/RelNotes/2.12.0.txt
index ef8b97da9b..d2f6a83614 100644
--- a/Documentation/RelNotes/2.12.0.txt
+++ b/Documentation/RelNotes/2.12.0.txt
@@ -315,7 +315,7 @@ notes for details).
    "git difftool --dir-diff" from a subdirectory never worked. This
    has been fixed.
 
- * "git p4" that tracks multile p4 paths imported a single changelist
+ * "git p4" that tracks multiple p4 paths imported a single changelist
    that touches files in these multiple paths as one commit, followed
    by many empty commits.  This has been fixed.
 
diff --git a/Documentation/RelNotes/2.13.0.txt b/Documentation/RelNotes/2.13.0.txt
index aa99d4b3ce..2a47b4cb0c 100644
--- a/Documentation/RelNotes/2.13.0.txt
+++ b/Documentation/RelNotes/2.13.0.txt
@@ -177,7 +177,7 @@ UI, Workflows & Features
    been changed to enable "--decorate".
 
  * The output from "git status --short" has been extended to show
-   various kinds of dirtyness in submodules differently; instead of to
+   various kinds of dirtiness in submodules differently; instead of to
    "M" for modified, 'm' and '?' can be shown to signal changes only
    to the working tree of the submodule but not the commit that is
    checked out.
diff --git a/Documentation/RelNotes/2.13.3.txt b/Documentation/RelNotes/2.13.3.txt
index 5d76ad5310..384e4de265 100644
--- a/Documentation/RelNotes/2.13.3.txt
+++ b/Documentation/RelNotes/2.13.3.txt
@@ -25,7 +25,7 @@ Fixes since v2.13.2
  * The code to pick up and execute command alias definition from the
    configuration used to switch to the top of the working tree and
    then come back when the expanded alias was executed, which was
-   unnecessarilyl complex.  Attempt to simplify the logic by using the
+   unnecessarily complex.  Attempt to simplify the logic by using the
    early-config mechanism that does not chdir around.
 
  * "git add -p" were updated in 2.12 timeframe to cope with custom
@@ -35,7 +35,7 @@ Fixes since v2.13.2
  * Fix a recent regression to "git rebase -i" and add tests that would
    have caught it and others.
 
- * An unaligned 32-bit access in pack-bitmap code ahs been corrected.
+ * An unaligned 32-bit access in pack-bitmap code has been corrected.
 
  * Tighten error checks for invalid "git apply" input.
 
diff --git a/Documentation/RelNotes/2.14.0.txt b/Documentation/RelNotes/2.14.0.txt
index 4246c68ff5..2711a2529d 100644
--- a/Documentation/RelNotes/2.14.0.txt
+++ b/Documentation/RelNotes/2.14.0.txt
@@ -141,7 +141,7 @@ Performance, Internal Implementation, Development Support etc.
  * Some platforms have ulong that is smaller than time_t, and our
    historical use of ulong for timestamp would mean they cannot
    represent some timestamp that the platform allows.  Invent a
-   separate and dedicated timestamp_t (so that we can distingiuish
+   separate and dedicated timestamp_t (so that we can distinguish
    timestamps and a vanilla ulongs, which along is already a good
    move), and then declare uintmax_t is the type to be used as the
    timestamp_t.
@@ -442,7 +442,7 @@ notes for details).
  * The code to pick up and execute command alias definition from the
    configuration used to switch to the top of the working tree and
    then come back when the expanded alias was executed, which was
-   unnecessarilyl complex.  Attempt to simplify the logic by using the
+   unnecessarily complex.  Attempt to simplify the logic by using the
    early-config mechanism that does not chdir around.
 
  * Fix configuration codepath to pay proper attention to commondir
diff --git a/Documentation/RelNotes/2.16.0.txt b/Documentation/RelNotes/2.16.0.txt
index 0c81c5915f..b474781ed8 100644
--- a/Documentation/RelNotes/2.16.0.txt
+++ b/Documentation/RelNotes/2.16.0.txt
@@ -407,7 +407,7 @@ Fixes since v2.15
    (merge eef3df5a93 bw/pathspec-match-submodule-boundary later to maint).
 
  * Amending commits in git-gui broke the author name that is non-ascii
-   due to incorrect enconding conversion.
+   due to incorrect encoding conversion.
 
  * Recent update to the submodule configuration code broke "diff-tree"
    by accidentally stopping to read from the index upfront.
diff --git a/Documentation/RelNotes/2.16.3.txt b/Documentation/RelNotes/2.16.3.txt
index 64a0bcb0d2..f0121a8f2d 100644
--- a/Documentation/RelNotes/2.16.3.txt
+++ b/Documentation/RelNotes/2.16.3.txt
@@ -24,7 +24,7 @@ Fixes since v2.16.2
 
  * The http tracing code, often used to debug connection issues,
    learned to redact potentially sensitive information from its output
-   so that it can be more safely sharable.
+   so that it can be more safely shareable.
 
  * Crash fix for a corner case where an error codepath tried to unlock
    what it did not acquire lock on.
diff --git a/Documentation/RelNotes/2.17.0.txt b/Documentation/RelNotes/2.17.0.txt
index c2cf891f71..8b17c26033 100644
--- a/Documentation/RelNotes/2.17.0.txt
+++ b/Documentation/RelNotes/2.17.0.txt
@@ -216,7 +216,7 @@ Fixes since v2.16
 
  * The http tracing code, often used to debug connection issues,
    learned to redact potentially sensitive information from its output
-   so that it can be more safely sharable.
+   so that it can be more safely shareable.
    (merge 8ba18e6fa4 jt/http-redact-cookies later to maint).
 
  * Crash fix for a corner case where an error codepath tried to unlock
diff --git a/Documentation/RelNotes/2.18.0.txt b/Documentation/RelNotes/2.18.0.txt
index 3ea280cf68..6c8a0e97c1 100644
--- a/Documentation/RelNotes/2.18.0.txt
+++ b/Documentation/RelNotes/2.18.0.txt
@@ -179,7 +179,7 @@ Performance, Internal Implementation, Development Support etc.
    (merge 00a3da2a13 nd/remove-ignore-env-field later to maint).
 
  * Code to find the length to uniquely abbreviate object names based
-   on packfile content, which is a relatively recent addtion, has been
+   on packfile content, which is a relatively recent addition, has been
    optimized to use the same fan-out table.
 
  * The mechanism to use parse-options API to automate the command line
diff --git a/Documentation/RelNotes/2.19.0.txt b/Documentation/RelNotes/2.19.0.txt
index a06ccf6e2a..891c79b9cb 100644
--- a/Documentation/RelNotes/2.19.0.txt
+++ b/Documentation/RelNotes/2.19.0.txt
@@ -106,7 +106,7 @@ Performance, Internal Implementation, Development Support etc.
  * The conversion to pass "the_repository" and then "a_repository"
    throughout the object access API continues.
 
- * Continuing with the idea to programatically enumerate various
+ * Continuing with the idea to programmatically enumerate various
    pieces of data required for command line completion, teach the
    codebase to report the list of configuration variables
    subcommands care about to help complete them.
diff --git a/Documentation/RelNotes/2.20.0.txt b/Documentation/RelNotes/2.20.0.txt
index e71fe3dee1..3dd7e6e1fc 100644
--- a/Documentation/RelNotes/2.20.0.txt
+++ b/Documentation/RelNotes/2.20.0.txt
@@ -119,7 +119,7 @@ UI, Workflows & Features
    alias expansion.
 
  * The documentation of "git gc" has been updated to mention that it
-   is no longer limited to "pruning away crufts" but also updates
+   is no longer limited to "pruning away cruft" but also updates
    ancillary files like commit-graph as a part of repository
    optimization.
 
diff --git a/Documentation/RelNotes/2.3.3.txt b/Documentation/RelNotes/2.3.3.txt
index 5ef12644c2..850dc68ede 100644
--- a/Documentation/RelNotes/2.3.3.txt
+++ b/Documentation/RelNotes/2.3.3.txt
@@ -12,7 +12,7 @@ Fixes since v2.3.2
  * Description given by "grep -h" for its --exclude-standard option
    was phrased poorly.
 
- * Documentaton for "git remote add" mentioned "--tags" and
+ * Documentation for "git remote add" mentioned "--tags" and
    "--no-tags" and it was not clear that fetch from the remote in
    the future will use the default behaviour when neither is given
    to override it.
diff --git a/Documentation/RelNotes/2.3.7.txt b/Documentation/RelNotes/2.3.7.txt
index fc95812cb3..5769184081 100644
--- a/Documentation/RelNotes/2.3.7.txt
+++ b/Documentation/RelNotes/2.3.7.txt
@@ -4,7 +4,7 @@ Git v2.3.7 Release Notes
 Fixes since v2.3.6
 ------------------
 
- * An earlier update to the parser that disects a URL broke an
+ * An earlier update to the parser that dissects a URL broke an
    address, followed by a colon, followed by an empty string (instead
    of the port number), e.g. ssh://example.com:/path/to/repo.
 
diff --git a/Documentation/RelNotes/2.4.3.txt b/Documentation/RelNotes/2.4.3.txt
index 914d2c1860..422e930aa2 100644
--- a/Documentation/RelNotes/2.4.3.txt
+++ b/Documentation/RelNotes/2.4.3.txt
@@ -66,7 +66,7 @@ Fixes since v2.4.3
  * Some time ago, "git blame" (incorrectly) lost the convert_to_git()
    call when synthesizing a fake "tip" commit that represents the
    state in the working tree, which broke folks who record the history
-   with LF line ending to make their project portabile across
+   with LF line ending to make their project portable across
    platforms while terminating lines in their working tree files with
    CRLF for their platform.
 
diff --git a/Documentation/RelNotes/2.7.0.txt b/Documentation/RelNotes/2.7.0.txt
index 563dadc57e..e3cbf3a73c 100644
--- a/Documentation/RelNotes/2.7.0.txt
+++ b/Documentation/RelNotes/2.7.0.txt
@@ -40,7 +40,7 @@ UI, Workflows & Features
 
  * "git interpret-trailers" can now run outside of a Git repository.
 
- * "git p4" learned to reencode the pathname it uses to communicate
+ * "git p4" learned to re-encode the pathname it uses to communicate
    with the p4 depot with a new option.
 
  * Give progress meter to "git filter-branch".
diff --git a/Documentation/RelNotes/2.8.0.txt b/Documentation/RelNotes/2.8.0.txt
index 5fbe1b86ee..27320b6a9f 100644
--- a/Documentation/RelNotes/2.8.0.txt
+++ b/Documentation/RelNotes/2.8.0.txt
@@ -189,7 +189,7 @@ Performance, Internal Implementation, Development Support etc.
  * Some calls to strcpy(3) triggers a false warning from static
    analyzers that are less intelligent than humans, and reducing the
    number of these false hits helps us notice real issues.  A few
-   calls to strcpy(3) in a couple of protrams that are already safe
+   calls to strcpy(3) in a couple of programs that are already safe
    has been rewritten to avoid false warnings.
 
  * The "name_path" API was an attempt to reduce the need to construct
diff --git a/Documentation/RelNotes/2.9.3.txt b/Documentation/RelNotes/2.9.3.txt
index 695b86f612..305e08062b 100644
--- a/Documentation/RelNotes/2.9.3.txt
+++ b/Documentation/RelNotes/2.9.3.txt
@@ -36,7 +36,7 @@ Fixes since v2.9.2
  * One part of "git am" had an oddball helper function that called
    stuff from outside "his" as opposed to calling what we have "ours",
    which was not gender-neutral and also inconsistent with the rest of
-   the system where outside stuff is usuall called "theirs" in
+   the system where outside stuff is usually called "theirs" in
    contrast to "ours".
 
  * The test framework learned a new helper test_match_signal to
diff --git a/Documentation/config.txt b/Documentation/config.txt
index f50f1b4128..83e7bba872 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -142,7 +142,7 @@ refer to linkgit:gitignore[5] for details. For convenience:
 
 `gitdir/i`::
 	This is the same as `gitdir` except that matching is done
-	case-insensitively (e.g. on case-insensitive file sytems)
+	case-insensitively (e.g. on case-insensitive file systems)
 
 `onbranch`::
 	The data that follows the keyword `onbranch:` is taken to be a
diff --git a/Documentation/config/tag.txt b/Documentation/config/tag.txt
index ef5adb3f42..6d9110d84c 100644
--- a/Documentation/config/tag.txt
+++ b/Documentation/config/tag.txt
@@ -13,7 +13,7 @@ tag.gpgSign::
 	Use of this option when running in an automated script can
 	result in a large number of tags being signed. It is therefore
 	convenient to use an agent to avoid typing your gpg passphrase
-	several times. Note that this option doesn't affects tag signing
+	several times. Note that this option doesn't affect tag signing
 	behavior enabled by "-u <keyid>" or "--local-user=<keyid>" options.
 
 tar.umask::
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index e99925184d..2957bc5e0a 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -158,7 +158,7 @@ Test suites are very nice. But when they are used alone, they are
 supposed to be used so that all the tests are checked after each
 commit. This means that they are not very efficient, because many
 tests are run for no interesting result, and they suffer from
-combinational explosion.
+combinatorial explosion.
 
 In fact the problem is that big software often has many different
 configuration options and that each test case should pass for each
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 3c0578217b..84f41a8e82 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -32,7 +32,7 @@ OPTIONS
 	instead of from the command-line.
 
 -z::
-	The output format is modified to be machine-parseable.
+	The output format is modified to be machine-parsable.
 	If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 8b42cb3fb2..8b2d49c79e 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -39,7 +39,7 @@ OPTIONS
 	instead of from the command-line.
 
 -z::
-	The output format is modified to be machine-parseable (see
+	The output format is modified to be machine-parsable (see
 	below).  If `--stdin` is also given, input paths are separated
 	with a NUL character instead of a linefeed character.
 
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index 79e22b1f3a..1b1c71ad9d 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -294,7 +294,7 @@ In `dbDriver` and `dbUser` you can use the following variables:
 	Git directory name
 %g::
 	Git directory name, where all characters except for
-	alpha-numeric ones, `.`, and `-` are replaced with
+	alphanumeric ones, `.`, and `-` are replaced with
 	`_` (this should make it easier to use the directory
 	name in a filename if wanted)
 %m::
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 37634bffd1..e8950de3ba 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -142,7 +142,7 @@ by keeping the marks the same across runs.
 	Specify how to handle `encoding` header in commit objects.  When
 	asking to 'abort' (which is the default), this program will die
 	when encountering such a commit object.  With 'yes', the commit
-	message will be reencoded into UTF-8.  With 'no', the original
+	message will be re-encoded into UTF-8.  With 'no', the original
 	encoding will be preserved.
 
 --refspec::
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 5876598852..59395b42df 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -534,7 +534,7 @@ repo-filter' also provides
 https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
 a drop-in git-filter-branch replacement (with a few caveats).  While
 filter-lamely suffers from all the same safety issues as
-git-filter-branch, it at least ameloriates the performance issues a
+git-filter-branch, it at least ameliorates the performance issues a
 little.
 
 [[SAFETY]]
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 8a6ea2c6c5..006feb7ec1 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -242,7 +242,7 @@ corresponding.
 
 The overall time needed to compute this algorithm is the time needed to
 compute n+m commit diffs and then n*m diffs of patches, plus the time
-needed to compute the least-cost assigment between n and m diffs. Git
+needed to compute the least-cost assignment between n and m diffs. Git
 uses an implementation of the Jonker-Volgenant algorithm to solve the
 assignment problem, which has cubic runtime complexity. The matching
 found in this case will look like this:
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 2e5599a67f..f6d9791780 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -65,7 +65,7 @@ OPTIONS
 --sign::
 	Make a GPG-signed tag, using the default e-mail address's key.
 	The default behavior of tag GPG-signing is controlled by `tag.gpgSign`
-	configuration variable if it exists, or disabled oder otherwise.
+	configuration variable if it exists, or disabled otherwise.
 	See linkgit:git-config[1].
 
 --no-sign::
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 1c4d146a41..c58efd5a55 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -426,7 +426,7 @@ specified by the splitIndex.sharedIndexExpire config variable (see
 linkgit:git-config[1]).
 
 To avoid deleting a shared index file that is still used, its
-modification time is updated to the current time everytime a new split
+modification time is updated to the current time every time a new split
 index based on the shared index file is either created or read from.
 
 UNTRACKED CACHE
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 9b82564d1a..1b678e22db 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -271,8 +271,8 @@ In general, the interrogate commands do not touch the files in
 the working tree.
 
 
-Synching repositories
-~~~~~~~~~~~~~~~~~~~~~
+Syncing repositories
+~~~~~~~~~~~~~~~~~~~~
 
 include::cmds-synchingrepositories.txt[]
 
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index c5a528c667..88b82b5252 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -293,10 +293,10 @@ web front ends do not visualize the contents of these files by default.
 
 In these cases you can tell Git the encoding of a file in the working
 directory with the `working-tree-encoding` attribute. If a file with this
-attribute is added to Git, then Git reencodes the content from the
+attribute is added to Git, then Git re-encodes the content from the
 specified encoding to UTF-8. Finally, Git stores the UTF-8 encoded
 content in its internal data structure (called "the index"). On checkout
-the content is reencoded back to the specified encoding.
+the content is re-encoded back to the specified encoding.
 
 Please note that using the `working-tree-encoding` attribute may have a
 number of pitfalls:
@@ -498,7 +498,7 @@ command. This is achieved by using the long-running process protocol
 When Git encounters the first file that needs to be cleaned or smudged,
 it starts the filter and performs the handshake. In the handshake, the
 welcome message sent by Git is "git-filter-client", only version 2 is
-suppported, and the supported capabilities are "clean", "smudge", and
+supported, and the supported capabilities are "clean", "smudge", and
 "delay".
 
 Afterwards Git sends a list of "key=value" pairs terminated with
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index f2a65ba0ca..953c3876f0 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -81,7 +81,7 @@ submodule.<name>.ignore::
 	    Committed differences and modifications to tracked files will show
 	    up.
 
-	none;; No modifiations to submodules are ignored, all of committed
+	none;; No modifications to submodules are ignored, all of committed
 	    differences, and modifications to tracked and untracked files are
 	    shown. This is the default option.
 
diff --git a/Documentation/howto/separating-topic-branches.txt b/Documentation/howto/separating-topic-branches.txt
index bd1027433b..81be0d6115 100644
--- a/Documentation/howto/separating-topic-branches.txt
+++ b/Documentation/howto/separating-topic-branches.txt
@@ -81,7 +81,7 @@ After I am done, I'd try a pretend-merge between "topicA" and
               o---o---o---o---o---o
 
 The last diff better not to show anything other than cleanups
-for crufts.  Then I can finally clean things up:
+for cruft.  Then I can finally clean things up:
 
         $ git branch -D topic
         $ git reset --hard HEAD^ ;# nuke pretend merge
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index 59b8ff1e51..40dc4f5e8c 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -34,7 +34,7 @@ set to `no` at the beginning of them.
 
 --cleanup=<mode>::
 	This option determines how the merge message will be cleaned up before
-	commiting. See linkgit:git-commit[1] for more details. In addition, if
+	committing. See linkgit:git-commit[1] for more details. In addition, if
 	the '<mode>' is given a value of `scissors`, scissors will be appended
 	to `MERGE_MSG` before being passed on to the commit machinery in the
 	case of a merge conflict.
diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
index fb06089393..c409559b86 100644
--- a/Documentation/technical/api-submodule-config.txt
+++ b/Documentation/technical/api-submodule-config.txt
@@ -58,7 +58,7 @@ Functions
 
 Whenever a submodule configuration is parsed in `parse_submodule_config_option`
 via e.g. `gitmodules_config()`, it will overwrite the null_sha1 entry.
-So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
+So in the normal case, when HEAD:.gitmodules is parsed first and then overlaid
 with the repository configuration, the null_sha1 entry contains the local
 configuration of a submodule (e.g. consolidated values from local git
 configuration and the .gitmodules file in the worktree).
diff --git a/Documentation/technical/api-trace2.txt b/Documentation/technical/api-trace2.txt
index a045dbe422..17490b528c 100644
--- a/Documentation/technical/api-trace2.txt
+++ b/Documentation/technical/api-trace2.txt
@@ -178,7 +178,7 @@ describe the simplified forms.
 
 == Public API
 
-All Trace2 API functions send a messsage to all of the active
+All Trace2 API functions send a message to all of the active
 Trace2 Targets.  This section describes the set of available
 messages.
 
@@ -377,7 +377,7 @@ of `pthread_create()`.
 	and the thread elapsed time.
 +
 This function must be called by the thread-proc before it returns
-(so that the coorect TLS data is used and cleaned up.  It should
+(so that the correct TLS data is used and cleaned up).  It should
 not be called by the caller of `pthread_join()`.
 
 === Region and Data Messages
@@ -406,7 +406,7 @@ The `label` field is an arbitrary label used to describe the activity
 being started, such as "read_recursive" or "do_read_index".
 +
 The `repo` field, if set, will be used to get the "repo-id", so that
-recursive oerations can be attributed to the correct repository.
+recursive operations can be attributed to the correct repository.
 
 `void trace2_region_leave(const char *category, const char *label, const struct repository *repo)`::
 
@@ -421,7 +421,7 @@ This function pops the region nesting stack on the current thread
 and reports the elapsed time of the stack frame.
 +
 The `category`, `label`, and `repo` fields are the same as above.
-The `category` and `label` do not need to match the correpsonding
+The `category` and `label` do not need to match the corresponding
 "region_enter" message, but it makes the data stream easier to
 understand.
 
@@ -816,7 +816,7 @@ with "?".
 Note that the session-id of the child process is not available to
 the current/spawning process, so the child's PID is reported here as
 a hint for post-processing.  (But it is only a hint because the child
-proces may be a shell script which doesn't have a session-id.)
+process may be a shell script which doesn't have a session-id.)
 +
 Note that the `t_rel` field contains the observed run time in seconds
 for the child process (starting before the fork/exec/spawn and
@@ -1176,7 +1176,7 @@ d0 | main                     | atexit       |     |  0.028809 |           |
 +
 Regions may be nested.  This causes messages to be indented in the
 PERF target, for example.
-Elapsed times are relative to the start of the correpsonding nesting
+Elapsed times are relative to the start of the corresponding nesting
 level as expected.  For example, if we add region message to:
 +
 ----------------
@@ -1371,7 +1371,7 @@ d0 | main                     | atexit       |     |  0.030027 |           |
 In this example, the preload region took 0.009122 seconds.  The 7 threads
 took between 0.006069 and 0.008947 seconds to work on their portion of
 the index.  Thread "th01" worked on 508 items at offset 0.  Thread "th02"
-worked on 508 items at offset 2032.  Thread "th04" worked on 508 itemts
+worked on 508 items at offset 2032.  Thread "th04" worked on 508 items
 at offset 508.
 +
 This example also shows that thread names are assigned in a racy manner
diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 729fbcb32f..1507117dc2 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -22,11 +22,11 @@ as "commit-graph" either in the .git/objects/info directory or in the info
 directory of an alternate.
 
 The commit-graph file stores the commit graph structure along with some
-extra metadata to speed up graph walks. By listing commit OIDs in lexi-
-cographic order, we can identify an integer position for each commit and
-refer to the parents of a commit using those integer positions. We use
-binary search to find initial commits and then use the integer positions
-for fast lookups during the walk.
+extra metadata to speed up graph walks. By listing commit OIDs in
+lexicographic order, we can identify an integer position for each commit
+and refer to the parents of a commit using those integer positions. We
+use binary search to find initial commits and then use the integer
+positions for fast lookups during the walk.
 
 A consumer may load the following info for a commit from the graph:
 
@@ -85,7 +85,7 @@ have generation number represented by the macro GENERATION_NUMBER_ZERO = 0.
 Since the commit-graph file is closed under reachability, we can guarantee
 the following weaker condition on all commits:
 
-    If A and B are commits with generation numbers N amd M, respectively,
+    If A and B are commits with generation numbers N and M, respectively,
     and N < M, then A cannot reach B.
 
 Note how the strict inequality differs from the inequality when we have
diff --git a/Documentation/technical/hash-function-transition.txt b/Documentation/technical/hash-function-transition.txt
index 2ae8fa470a..8a4596bec1 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -531,7 +531,7 @@ Until Git protocol gains SHA-256 support, using SHA-256 based storage
 on public-facing Git servers is strongly discouraged. Once Git
 protocol gains SHA-256 support, SHA-256 based servers are likely not
 to support SHA-1 compatibility, to avoid what may be a very expensive
-hash reencode during clone and to encourage peers to modernize.
+hash re-encode during clone and to encourage peers to modernize.
 
 The design described here allows fetches by SHA-1 clients of a
 personal SHA-256 repository because it's not much more difficult than
@@ -602,7 +602,7 @@ git --output-format=sha1 log abac87a^{sha1}..f787cac^{sha256}
 
 Choice of Hash
 --------------
-In early 2005, around the time that Git was written,  Xiaoyun Wang,
+In early 2005, around the time that Git was written, Xiaoyun Wang,
 Yiqun Lisa Yin, and Hongbo Yu announced an attack finding SHA-1
 collisions in 2^69 operations. In August they published details.
 Luckily, no practical demonstrations of a collision in full SHA-1 were
diff --git a/Documentation/technical/index-format.txt b/Documentation/technical/index-format.txt
index 7c4d67aa6a..faa25c5c52 100644
--- a/Documentation/technical/index-format.txt
+++ b/Documentation/technical/index-format.txt
@@ -318,7 +318,7 @@ The remaining data of each directory block is grouped by type:
 == End of Index Entry
 
   The End of Index Entry (EOIE) is used to locate the end of the variable
-  length index entries and the begining of the extensions. Code can take
+  length index entries and the beginning of the extensions. Code can take
   advantage of this to quickly locate the index extensions without having
   to parse through all of the index entries.
 
@@ -351,7 +351,7 @@ The remaining data of each directory block is grouped by type:
 
   - A number of index offset entries each consisting of:
 
-    - 32-bit offset from the begining of the file to the first cache entry
+    - 32-bit offset from the beginning of the file to the first cache entry
 	in this block of entries.
 
     - 32-bit count of cache entries in this block
diff --git a/Documentation/technical/pack-protocol.txt b/Documentation/technical/pack-protocol.txt
index c73e72de0e..d5ce4eea8a 100644
--- a/Documentation/technical/pack-protocol.txt
+++ b/Documentation/technical/pack-protocol.txt
@@ -644,7 +644,7 @@ update was successful, or 'ng [refname] [error]' if the update was not.
   command-ok        = PKT-LINE("ok" SP refname)
   command-fail      = PKT-LINE("ng" SP refname SP error-msg)
 
-  error-msg         = 1*(OCTECT) ; where not "ok"
+  error-msg         = 1*(OCTET) ; where not "ok"
 ----
 
 Updates can be unsuccessful for a number of reasons.  The reference can have
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/technical/partial-clone.txt
index 210373e258..a6034d5610 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -32,7 +32,7 @@ if/when needed.
 
 A remote that can later provide the missing objects is called a
 promisor remote, as it promises to send the objects when
-requested. Initialy Git supported only one promisor remote, the origin
+requested. Initially Git supported only one promisor remote, the origin
 remote from which the user cloned and that was configured in the
 "extensions.partialClone" config option. Later support for more than
 one promisor remote has been implemented.
diff --git a/Documentation/technical/protocol-v2.txt b/Documentation/technical/protocol-v2.txt
index 40f91f6b1e..7e3766cafb 100644
--- a/Documentation/technical/protocol-v2.txt
+++ b/Documentation/technical/protocol-v2.txt
@@ -252,7 +252,7 @@ A `fetch` request can take the following arguments:
     ofs-delta
 	Indicate that the client understands PACKv2 with delta referring
 	to its base by position in pack rather than by an oid.  That is,
-	they can read OBJ_OFS_DELTA (ake type 6) in a packfile.
+	they can read OBJ_OFS_DELTA (aka type 6) in a packfile.
 
 If the 'shallow' feature is advertised the following arguments can be
 included in the clients request as well as the potential addition of the
diff --git a/Documentation/technical/rerere.txt b/Documentation/technical/rerere.txt
index aa22d7ace8..af5f9fc24f 100644
--- a/Documentation/technical/rerere.txt
+++ b/Documentation/technical/rerere.txt
@@ -117,7 +117,7 @@ early A became C or B, a late X became Y or Z".  We can see there are
 4 combinations of ("B or C", "C or B") x ("X or Y", "Y or X").
 
 By sorting, the conflict is given its canonical name, namely, "an
-early part became B or C, a late part becames X or Y", and whenever
+early part became B or C, a late part became X or Y", and whenever
 any of these four patterns appear, and we can get to the same conflict
 and resolution that we saw earlier.
 
-- 
gitgitgadget

