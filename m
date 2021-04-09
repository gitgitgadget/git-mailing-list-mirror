Return-Path: <git-owner@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A034C43460
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B43996115C
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 04:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231440AbhDIEGK (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 00:06:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbhDIEF7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Apr 2021 00:05:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E0C061765
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 21:05:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id p19so2196994wmq.1
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 21:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lU0A+x1PLHQF6NMG3fhiVQnC3HP/G/ubGDZSkmn32Q0=;
        b=KqgQ5ELEsOAYi87f975M7IhNRIAVb0Hz2Gfo1i5y0A9TZEYS1YQtEPK66k6BS7PL0e
         /dTYcFhAstJ2wLeEXzfYQZBMiJbaPRXSJQV2f7at8Om7iLih+1BBOHZYwdWe1XBszVbb
         6xCLIcRouAB5IhWw5Z6VAAo73IjZSJp083lxCBo09K2mW0AajIJFdVb+LIP8Tyz/1fpD
         VaMQWmtS+aup2BM3UhadyIwQ+1tKRbxWSkRgiYfNV/BcTbWlqQoI00Rwq09U28Qk5vo4
         buBHURGcq8Ff17Gkafesp8bZS0xcHtrGWOxfp/qga7fD8jSjBMN8/9XUwzhaqWaRrKET
         RDGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lU0A+x1PLHQF6NMG3fhiVQnC3HP/G/ubGDZSkmn32Q0=;
        b=ttOw1CkuvwpCBQ7lv+HB/ZO9ThJ62uQvFEiy42pvLRZrpTFrPbrQHbI/q3ztkvzJBc
         efVJZwfgRHYsT2SyeLpqa12HX5f1DCKZjLmq9QCEBlipBYTBeVKumx8QwdJ8oE6Ze8AN
         muAlY0at/gnqy+V+PkIFFsFuARfTcjfgYVsCYA2elSZiLpAESgchP1Wb2xjApO/QDt7m
         WHsAq2M/aXL4206XI+Q6XlzZUYn8y/PydyigfW6Ah+bbdsOc2/ziijGCIU1B7RQuryS+
         LlDqKqpru07QkG+e1+tWf24LRqAHcnv5rVFRpPKfHkD5hHxAB/LrUxoVIQiEtCFdzoon
         k0Gw==
X-Gm-Message-State: AOAM530pydfaIRYF/vnLGjFJqWFKTc/xhQA8lScfjTr3ryaiGbht3Jrb
        nvVWvtilxI+wtGxn+2Vq6DFRPB9ITy7zdA==
X-Google-Smtp-Source: ABdhPJwVwrrcuD0+EemmUDM72yKREbTinUKh2f9OFBqXNz0VPnfrzmGPuIuWkwowRiignuWa3829lQ==
X-Received: by 2002:a05:600c:4788:: with SMTP id k8mr7175255wmo.77.1617941142977;
        Thu, 08 Apr 2021 21:05:42 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c420080e637770dc2ae3c.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:80e6:3777:dc2:ae3c])
        by smtp.gmail.com with ESMTPSA id c9sm2064636wrr.78.2021.04.08.21.05.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 21:05:41 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     git@vger.kernel.org
Cc:     Firmin Martin <firminmartin24@gmail.com>
Subject: [RFC PATCH v1 04/13] doc: typeset git-related commands in monospace
Date:   Fri,  9 Apr 2021 06:02:52 +0200
Message-Id: <20210409040301.3260358-5-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.133.g84d06cdc06
In-Reply-To: <20210409040301.3260358-1-firminmartin24@gmail.com>
References: <20210409040301.3260358-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wrap git-related commands with backticks as indicated in the
CodingGuidelines.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 Documentation/MyFirstContribution.txt         |   8 +-
 Documentation/config.txt                      |   2 +-
 Documentation/diff-format.txt                 |   8 +-
 Documentation/diff-generate-patch.txt         |   4 +-
 Documentation/diff-options.txt                |   8 +-
 Documentation/fetch-options.txt               |  18 +-
 Documentation/git-add.txt                     |   6 +-
 Documentation/git-am.txt                      |  20 +-
 Documentation/git-apply.txt                   |  14 +-
 Documentation/git-archimport.txt              |  12 +-
 Documentation/git-archive.txt                 |   6 +-
 Documentation/git-bisect-lk2009.txt           | 164 ++++++++--------
 Documentation/git-bisect.txt                  |  38 ++--
 Documentation/git-blame.txt                   |  10 +-
 Documentation/git-branch.txt                  |  28 +--
 Documentation/git-bugreport.txt               |   4 +-
 Documentation/git-bundle.txt                  |  34 ++--
 Documentation/git-cat-file.txt                |   6 +-
 Documentation/git-check-attr.txt              |   4 +-
 Documentation/git-check-ignore.txt            |   4 +-
 Documentation/git-check-mailmap.txt           |   2 +-
 Documentation/git-check-ref-format.txt        |   8 +-
 Documentation/git-checkout-index.txt          |  10 +-
 Documentation/git-checkout.txt                |  42 ++--
 Documentation/git-cherry-pick.txt             |   6 +-
 Documentation/git-cherry.txt                  |   8 +-
 Documentation/git-citool.txt                  |   6 +-
 Documentation/git-clean.txt                   |  14 +-
 Documentation/git-clone.txt                   |   2 +-
 Documentation/git-column.txt                  |   4 +-
 Documentation/git-commit-graph.txt            |   4 +-
 Documentation/git-commit-tree.txt             |   6 +-
 Documentation/git-commit.txt                  |  16 +-
 Documentation/git-config.txt                  |  42 ++--
 Documentation/git-count-objects.txt           |   2 +-
 .../git-credential-cache--daemon.txt          |   2 +-
 Documentation/git-credential-cache.txt        |   2 +-
 Documentation/git-credential-store.txt        |   4 +-
 Documentation/git-credential.txt              |  16 +-
 Documentation/git-cvsexportcommit.txt         |   4 +-
 Documentation/git-cvsimport.txt               |  20 +-
 Documentation/git-cvsserver.txt               |  56 +++---
 Documentation/git-daemon.txt                  |  52 ++---
 Documentation/git-describe.txt                |  22 +--
 Documentation/git-diff-files.txt              |   4 +-
 Documentation/git-diff-index.txt              |  20 +-
 Documentation/git-diff-tree.txt               |  12 +-
 Documentation/git-diff.txt                    |  30 +--
 Documentation/git-difftool.txt                |  34 ++--
 Documentation/git-fast-export.txt             |  28 +--
 Documentation/git-fast-import.txt             |  36 ++--
 Documentation/git-fetch-pack.txt              |  18 +-
 Documentation/git-fetch.txt                   |  14 +-
 Documentation/git-filter-branch.txt           |  92 ++++-----
 Documentation/git-fmt-merge-msg.txt           |   8 +-
 Documentation/git-for-each-ref.txt            |   4 +-
 Documentation/git-for-each-repo.txt           |   2 +-
 Documentation/git-format-patch.txt            |  22 +--
 Documentation/git-fsck-objects.txt            |   2 +-
 Documentation/git-fsck.txt                    |   8 +-
 Documentation/git-gc.txt                      |  18 +-
 Documentation/git-get-tar-commit-id.txt       |   8 +-
 Documentation/git-grep.txt                    |  10 +-
 Documentation/git-gui.txt                     |  24 +--
 Documentation/git-hash-object.txt             |   6 +-
 Documentation/git-help.txt                    |  18 +-
 Documentation/git-http-backend.txt            |  38 ++--
 Documentation/git-http-fetch.txt              |   6 +-
 Documentation/git-http-push.txt               |   2 +-
 Documentation/git-imap-send.txt               |   4 +-
 Documentation/git-index-pack.txt              |  10 +-
 Documentation/git-init-db.txt                 |   2 +-
 Documentation/git-init.txt                    |   8 +-
 Documentation/git-instaweb.txt                |  10 +-
 Documentation/git-interpret-trailers.txt      |  10 +-
 Documentation/git-log.txt                     |  10 +-
 Documentation/git-ls-files.txt                |  12 +-
 Documentation/git-ls-remote.txt               |   6 +-
 Documentation/git-ls-tree.txt                 |   8 +-
 Documentation/git-mailinfo.txt                |   6 +-
 Documentation/git-mailsplit.txt               |   2 +-
 Documentation/git-maintenance.txt             |   2 +-
 Documentation/git-merge-base.txt              |  20 +-
 Documentation/git-merge-file.txt              |  12 +-
 Documentation/git-merge-index.txt             |  10 +-
 Documentation/git-merge-one-file.txt          |   6 +-
 Documentation/git-merge-tree.txt              |   4 +-
 Documentation/git-merge.txt                   |  54 +++---
 Documentation/git-mergetool--lib.txt          |   4 +-
 Documentation/git-mergetool.txt               |  20 +-
 Documentation/git-mktag.txt                   |   2 +-
 Documentation/git-mktree.txt                  |   2 +-
 Documentation/git-multi-pack-index.txt        |   4 +-
 Documentation/git-mv.txt                      |   8 +-
 Documentation/git-name-rev.txt                |   6 +-
 Documentation/git-notes.txt                   |  52 ++---
 Documentation/git-p4.txt                      | 132 ++++++-------
 Documentation/git-pack-objects.txt            |   8 +-
 Documentation/git-pack-redundant.txt          |   4 +-
 Documentation/git-pack-refs.txt               |   2 +-
 Documentation/git-patch-id.txt                |  12 +-
 Documentation/git-prune-packed.txt            |   2 +-
 Documentation/git-prune.txt                   |  16 +-
 Documentation/git-pull.txt                    |  18 +-
 Documentation/git-push.txt                    |  24 +--
 Documentation/git-quiltimport.txt             |   4 +-
 Documentation/git-range-diff.txt              |   2 +-
 Documentation/git-read-tree.txt               |  54 +++---
 Documentation/git-rebase.txt                  |  48 ++---
 Documentation/git-receive-pack.txt            |  28 +--
 Documentation/git-reflog.txt                  |  12 +-
 Documentation/git-remote-ext.txt              |  26 +--
 Documentation/git-remote-fd.txt               |  12 +-
 Documentation/git-remote.txt                  |  28 +--
 Documentation/git-repack.txt                  |  14 +-
 Documentation/git-replace.txt                 |  22 +--
 Documentation/git-request-pull.txt            |   2 +-
 Documentation/git-rerere.txt                  |  34 ++--
 Documentation/git-reset.txt                   |  22 +--
 Documentation/git-restore.txt                 |   6 +-
 Documentation/git-rev-list.txt                |   6 +-
 Documentation/git-rev-parse.txt               |  34 ++--
 Documentation/git-revert.txt                  |  10 +-
 Documentation/git-rm.txt                      |   4 +-
 Documentation/git-send-email.txt              |  28 +--
 Documentation/git-send-pack.txt               |  12 +-
 Documentation/git-sh-i18n--envsubst.txt       |   2 +-
 Documentation/git-sh-i18n.txt                 |   2 +-
 Documentation/git-sh-setup.txt                |   2 +-
 Documentation/git-shell.txt                   |  24 +--
 Documentation/git-shortlog.txt                |  10 +-
 Documentation/git-show-branch.txt             |  22 +--
 Documentation/git-show-index.txt              |   2 +-
 Documentation/git-show-ref.txt                |   8 +-
 Documentation/git-show.txt                    |  10 +-
 Documentation/git-sparse-checkout.txt         |   6 +-
 Documentation/git-stage.txt                   |   2 +-
 Documentation/git-stash.txt                   |  28 +--
 Documentation/git-status.txt                  |   6 +-
 Documentation/git-stripspace.txt              |   8 +-
 Documentation/git-submodule.txt               |  44 ++---
 Documentation/git-svn.txt                     | 176 ++++++++---------
 Documentation/git-switch.txt                  |  10 +-
 Documentation/git-symbolic-ref.txt            |   8 +-
 Documentation/git-tag.txt                     |  22 +--
 Documentation/git-unpack-file.txt             |   2 +-
 Documentation/git-unpack-objects.txt          |   2 +-
 Documentation/git-update-index.txt            |  42 ++--
 Documentation/git-update-ref.txt              |   2 +-
 Documentation/git-update-server-info.txt      |   2 +-
 Documentation/git-upload-archive.txt          |   8 +-
 Documentation/git-upload-pack.txt             |   8 +-
 Documentation/git-var.txt                     |   2 +-
 Documentation/git-verify-commit.txt           |   4 +-
 Documentation/git-verify-pack.txt             |   4 +-
 Documentation/git-verify-tag.txt              |   4 +-
 Documentation/git-web--browse.txt             |   8 +-
 Documentation/git-whatchanged.txt             |   6 +-
 Documentation/git-worktree.txt                |  18 +-
 Documentation/git-write-tree.txt              |  10 +-
 Documentation/git.txt                         |  36 ++--
 Documentation/gitattributes.txt               |  22 +--
 Documentation/gitcore-tutorial.txt            | 164 ++++++++--------
 Documentation/gitcredentials.txt              |   8 +-
 Documentation/gitcvs-migration.txt            |  14 +-
 Documentation/gitdiffcore.txt                 |  32 ++--
 Documentation/giteveryday.txt                 |   8 +-
 Documentation/gitfaq.txt                      |   2 +-
 Documentation/githooks.txt                    |  10 +-
 Documentation/gitignore.txt                   |   6 +-
 Documentation/gitk.txt                        |  24 +--
 Documentation/gitmodules.txt                  |   2 +-
 Documentation/gitnamespaces.txt               |   8 +-
 Documentation/gitremote-helpers.txt           |  32 ++--
 Documentation/gitrepository-layout.txt        |  22 +--
 Documentation/gittutorial-2.txt               |  22 +--
 Documentation/gittutorial.txt                 |  56 +++---
 Documentation/gitweb.conf.txt                 | 180 +++++++++---------
 Documentation/gitweb.txt                      |  90 ++++-----
 Documentation/gitworkflows.txt                |   6 +-
 Documentation/glossary-content.txt            |   8 +-
 Documentation/i18n.txt                        |   4 +-
 Documentation/merge-options.txt               |   4 +-
 Documentation/pull-fetch-param.txt            |  10 +-
 Documentation/revisions.txt                   |   2 +-
 Documentation/urls-remotes.txt                |  12 +-
 Documentation/urls.txt                        |   2 +-
 Documentation/user-manual.txt                 |  30 +--
 188 files changed, 1731 insertions(+), 1731 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index af0a9da62e..06f9f370d7 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -481,7 +481,7 @@ git-psuh - Delight users' typo with a shy horse
 SYNOPSIS
 --------
 [verse]
-'git-psuh [<arg>...]'
+`git-psuh [<arg>...]`
 
 DESCRIPTION
 -----------
@@ -590,7 +590,7 @@ you the rest of the options afterwards, untouched.
 
 Now that you have a usage hint, you can teach Git how to show it in the general
 command list shown by `git help git` or `git help -a`, which is generated from
-`command-list.txt`. Find the line for 'git-pull' so you can add your 'git-psuh'
+`command-list.txt`. Find the line for `git-pull` so you can add your `git-psuh`
 line above it in alphabetical order. Now, we can add some attributes about the
 command which impacts where it shows up in the aforementioned help commands. The
 top of `command-list.txt` shares some information about what each attribute
@@ -652,7 +652,7 @@ Create a new file `t/t9999-psuh-tutorial.sh`. Begin with the header as so (see
 
 test_description='git-psuh test
 
-This test runs git-psuh and makes sure it does not crash.'
+This test runs `git-psuh` and makes sure it does not crash.'
 
 . ./test-lib.sh
 ----
@@ -971,7 +971,7 @@ Here's an example body for `psuh`:
 
 ----
 Our internal metrics indicate widespread interest in the command
-git-psuh - that is, many users are trying to use it, but finding it is
+`git-psuh` - that is, many users are trying to use it, but finding it is
 unavailable, using some unknown workaround instead.
 
 The following handful of patches add the psuh command and implement some
diff --git a/Documentation/config.txt b/Documentation/config.txt
index bf82766a6a..05bcf1bf2b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -249,7 +249,7 @@ boolean::
 		`0` and the empty string.
 +
 When converting a value to its canonical form using the `--type=bool` type
-specifier, 'git config' will ensure that the output is "true" or
+specifier, `git config` will ensure that the output is "true" or
 "false" (spelled in lowercase).
 
 integer::
diff --git a/Documentation/diff-format.txt b/Documentation/diff-format.txt
index fbbd410a84..14ef11d552 100644
--- a/Documentation/diff-format.txt
+++ b/Documentation/diff-format.txt
@@ -1,8 +1,8 @@
 Raw output format
 -----------------
 
-The raw output format from "git-diff-index", "git-diff-tree",
-"git-diff-files" and "git diff --raw" are very similar.
+The raw output format from `git-diff-index`, `git-diff-tree`,
+`git-diff-files` and `git diff --raw` are very similar.
 
 These commands all compare two sets of things; what is
 compared differs:
@@ -19,7 +19,7 @@ git-diff-tree [-r] <tree-ish-1> <tree-ish-2> [<pattern>...]::
 git-diff-files [<pattern>...]::
         compares the index and the files on the filesystem.
 
-The "git-diff-tree" command begins its output by printing the hash of
+The `git-diff-tree` command begins its output by printing the hash of
 what is being compared. After that, all the commands print one output
 line per changed file.
 
@@ -86,7 +86,7 @@ verbatim and the line is terminated by a NUL byte.
 diff format for merges
 ----------------------
 
-"git-diff-tree", "git-diff-files" and "git-diff --raw"
+`git-diff-tree`, `git-diff-files` and `git-diff --raw`
 can take `-c` or `--cc` option
 to generate diff output also for merge commits.  The output differs
 from the format described above in the following way:
diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 2615b29cb0..da1572b765 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -16,7 +16,7 @@ You can customize the creation of patch text via the
 What the `-p` option produces is slightly different from the traditional
 diff format:
 
-1.   It is preceded with a "git diff" header that looks like this:
+1.   It is preceded with a `git diff` header that looks like this:
 
        diff --git a/file1 b/file2
 +
@@ -117,7 +117,7 @@ index fabadb8,cc95eb0..4866510
 		for_each_ref(get_name);
 ------------
 
-1.   It is preceded with a "git diff" header, that looks like
+1.   It is preceded with a `git diff` header, that looks like
      this (when the `-c` option is used):
 
        diff --combined file
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 86c19bed1e..34570aa445 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -825,10 +825,10 @@ endif::git-format-patch[]
 	Prepend an additional prefix to every line of output.
 
 --ita-invisible-in-index::
-	By default entries added by "git add -N" appear as an existing
-	empty file in "git diff" and a new file in "git diff --cached".
-	This option makes the entry appear as a new file in "git diff"
-	and non-existent in "git diff --cached". This option could be
+	By default entries added by `git add -N` appear as an existing
+	empty file in `git diff` and a new file in `git diff --cached`.
+	This option makes the entry appear as a new file in `git diff`
+	and non-existent in `git diff --cached`. This option could be
 	reverted with `--ita-visible-in-index`. Both options are
 	experimental and could be removed in future.
 
diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 60a268cc4a..6aa07a54b9 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -79,7 +79,7 @@ endif::git-pull[]
 
 -f::
 --force::
-	When 'git fetch' is used with `<src>:<dst>` refspec it may
+	When `git fetch` is used with `<src>:<dst>` refspec it may
 	refuse to update the local branch as discussed
 ifdef::git-pull[]
 	in the `<refspec>` part of the linkgit:git-fetch[1]
@@ -223,25 +223,25 @@ ifndef::git-pull[]
 
 -u::
 --update-head-ok::
-	By default 'git fetch' refuses to update the head which
+	By default `git fetch` refuses to update the head which
 	corresponds to the current branch.  This flag disables the
-	check.  This is purely for the internal use for 'git pull'
-	to communicate with 'git fetch', and unless you are
+	check.  This is purely for the internal use for `git pull`
+	to communicate with `git fetch`, and unless you are
 	implementing your own Porcelain you are not supposed to
 	use it.
 endif::git-pull[]
 
 --upload-pack <upload-pack>::
 	When given, and the repository to fetch from is handled
-	by 'git fetch-pack', `--exec=<upload-pack>` is passed to
+	by `git fetch-pack`, `--exec=<upload-pack>` is passed to
 	the command to specify non-default path for the command
 	run on the other end.
 
 ifndef::git-pull[]
 -q::
 --quiet::
-	Pass `--quiet` to git-fetch-pack and silence any other internally
-	used git commands. Progress is not reported to the standard error
+	Pass `--quiet` to `git-fetch-pack` and silence any other internally
+	used `git` commands. Progress is not reported to the standard error
 	stream.
 
 -v::
@@ -265,13 +265,13 @@ endif::git-pull[]
 	sent to the other side in the order listed on the command line.
 
 --show-forced-updates::
-	By default, git checks if a branch is force-updated during
+	By default, `git` checks if a branch is force-updated during
 	fetch. This can be disabled through `fetch.showForcedUpdates`, but
 	the `--show-forced-updates` option guarantees this check occurs.
 	See linkgit:git-config[1].
 
 --no-show-forced-updates::
-	By default, git checks if a branch is force-updated during
+	By default, `git` checks if a branch is force-updated during
 	fetch. Pass `--no-show-forced-updates` or set `fetch.showForcedUpdates`
 	to false to skip this check for performance reasons. If used during
 	'git-pull' the `--ff-only` option will still check for forced updates
diff --git a/Documentation/git-add.txt b/Documentation/git-add.txt
index 8ec99c5c12..786c31fc60 100644
--- a/Documentation/git-add.txt
+++ b/Documentation/git-add.txt
@@ -41,7 +41,7 @@ The `git add` command will not add ignored files by default.  If any
 ignored files were explicitly specified on the command line, `git add`
 will fail with a list of ignored files.  Ignored files reached by
 directory recursion or filename globbing performed by Git (quote your
-globs before the shell) will be silently ignored.  The 'git add' command can
+globs before the shell) will be silently ignored.  The `git add` command can
 be used to add ignored files with the `-f` (force) option.
 
 Please see linkgit:git-commit[1] for alternative ways to add content to a
@@ -141,8 +141,8 @@ subdirectories).
 	option is a no-op when no <pathspec> is used.
 +
 This option is primarily to help users who are used to older
-versions of Git, whose "git add <pathspec>..." was a synonym
-for "git add --no-all <pathspec>...", i.e. ignored removed files.
+versions of Git, whose `git add <pathspec>...` was a synonym
+for `git add --no-all <pathspec>...`, i.e. ignored removed files.
 
 -N::
 --intent-to-add::
diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index cd56054be0..80f2f89cbd 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -39,13 +39,13 @@ OPTIONS
 
 -k::
 --keep::
-	Pass `-k` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-k` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 
 --keep-non-patch::
-	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-b` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 
 --[no-]keep-cr::
-	With `--keep-cr`, call 'git mailsplit' (see linkgit:git-mailsplit[1])
+	With `--keep-cr`, call `git mailsplit` (see linkgit:git-mailsplit[1])
 	with the same option, to prevent it from stripping CR at the end of
 	lines. `am.keepcr` configuration variable can be used to specify the
 	default behaviour.  `--no-keep-cr` is useful to override `am.keepcr`.
@@ -61,7 +61,7 @@ OPTIONS
 
 -m::
 --message-id::
-	Pass the `-m` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]),
+	Pass the `-m` flag to `git mailinfo` (see linkgit:git-mailinfo[1]),
 	so that the Message-ID header is added to the commit message.
 	The `am.messageid` configuration variable can be used to specify
 	the default behaviour.
@@ -76,7 +76,7 @@ OPTIONS
 
 -u::
 --utf8::
-	Pass `-u` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-u` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 	The proposed commit log message taken from the e-mail
 	is re-coded into UTF-8 encoding (configuration variable
 	`i18n.commitEncoding` can be used to specify project's
@@ -86,7 +86,7 @@ This was optional in prior versions of git, but now it is the
 default.   You can use `--no-utf8` to override this.
 
 --no-utf8::
-	Pass `-n` flag to 'git mailinfo' (see
+	Pass `-n` flag to `git mailinfo` (see
 	linkgit:git-mailinfo[1]).
 
 -3::
@@ -97,7 +97,7 @@ default.   You can use `--no-utf8` to override this.
 	it is supposed to apply to and we have those blobs
 	available locally. `--no-3way` can be used to override
 	am.threeWay configuration variable. For more information,
-	see am.threeWay in linkgit:git-config[1].
+	see `am.threeWay` in linkgit:git-config[1].
 
 --rerere-autoupdate::
 --no-rerere-autoupdate::
@@ -113,7 +113,7 @@ default.   You can use `--no-utf8` to override this.
 --exclude=<path>::
 --include=<path>::
 --reject::
-	These flags are passed to the 'git apply' (see linkgit:git-apply[1])
+	These flags are passed to the `git apply` (see linkgit:git-apply[1])
 	program that applies
 	the patch.
 
@@ -170,7 +170,7 @@ default.   You can use `--no-utf8` to override this.
 	to the screen before exiting.  This overrides the
 	standard message informing you to use `--continue`
 	or `--skip` to handle the failure.  This is solely
-	for internal use between 'git rebase' and 'git am'.
+	for internal use between `git rebase` and `git am`.
 
 --abort::
 	Restore the original branch and abort the patching operation.
@@ -231,7 +231,7 @@ names.
 
 Before any patches are applied, `ORIG_HEAD` is set to the tip of the
 current branch.  This is useful if you have problems with multiple
-commits, like running 'git am' on the wrong branch or an error in the
+commits, like running `git am` on the wrong branch or an error in the
 commits that is more easily fixed by changing the mailbox (e.g.
 errors in the "From:" lines).
 
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index f1c8098c0b..a836021d5e 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -51,7 +51,7 @@ OPTIONS
 
 --summary::
 	Instead of applying the patch, output a condensed
-	summary of information obtained from git diff extended
+	summary of information obtained from `git diff` extended
 	headers, such as creations, renames and mode changes.
 	Turns off "apply".
 
@@ -92,7 +92,7 @@ OPTIONS
 	with the `--reject` and the `--cached` options.
 
 --build-fake-ancestor=<file>::
-	Newer 'git diff' output has embedded 'index information'
+	Newer `git diff` output has embedded 'index information'
 	for each blob to help identify the original version that
 	the patch applies to.  When this flag is given, and if
 	the original versions of the blobs are available locally,
@@ -106,7 +106,7 @@ the information is read from the current index instead.
 	Apply the patch in reverse.
 
 --reject::
-	For atomicity, 'git apply' by default fails the whole patch and
+	For atomicity, `git apply` by default fails the whole patch and
 	does not touch the working tree when some of the hunks
 	do not apply.  This option makes it apply
 	the parts of the patch that are applicable, and leave the
@@ -133,7 +133,7 @@ linkgit:git-config[1]).
 	ever ignored.
 
 --unidiff-zero::
-	By default, 'git apply' expects that the patch being
+	By default, `git apply` expects that the patch being
 	applied is a unified diff with at least one line of context.
 	This provides good safety measures, but breaks down when
 	applying a diff generated with `--unified=0`. To bypass these
@@ -144,7 +144,7 @@ discouraged.
 
 --apply::
 	If you use any of the options marked "Turns off
-	'apply'" above, 'git apply' reads and outputs the
+	'apply'" above, `git apply` reads and outputs the
 	requested information without actually applying the
 	patch.  Give this flag after those flags to also apply
 	the patch.
@@ -243,7 +243,7 @@ running `git apply --directory=modules/git-gui`.
 --unsafe-paths::
 	By default, a patch that affects outside the working area
 	(either a Git controlled working tree, or the current working
-	directory when "git apply" is used as a replacement of GNU
+	directory when `git apply` is used as a replacement of GNU
 	patch) is rejected as a mistake (or a mischief).
 +
 When `git apply` is used as a "better GNU patch", the user can pass
@@ -263,7 +263,7 @@ apply.whitespace::
 
 SUBMODULES
 ----------
-If the patch contains any changes to submodules then 'git apply'
+If the patch contains any changes to submodules then `git apply`
 treats these changes as follows.
 
 If `--index` is specified (explicitly or implicitly), then the submodule
diff --git a/Documentation/git-archimport.txt b/Documentation/git-archimport.txt
index 6e2dec5ef1..b5c9e500ca 100644
--- a/Documentation/git-archimport.txt
+++ b/Documentation/git-archimport.txt
@@ -30,17 +30,17 @@ branches that have different roots, it will refuse to run. In that case,
 edit your <archive/branch> parameters to define clearly the scope of the
 import.
 
-'git archimport' uses `tla` extensively in the background to access the
+`git archimport` uses `tla` extensively in the background to access the
 Arch repository.
 Make sure you have a recent version of `tla` available in the path. `tla` must
-know about the repositories you pass to 'git archimport'.
+know about the repositories you pass to `git archimport`.
 
-For the initial import, 'git archimport' expects to find itself in an empty
+For the initial import, `git archimport` expects to find itself in an empty
 directory. To follow the development of a project that uses Arch, rerun
-'git archimport' with the same parameters as the initial import to perform
+`git archimport` with the same parameters as the initial import to perform
 incremental imports.
 
-While 'git archimport' will try to create sensible branch names for the
+While `git archimport` will try to create sensible branch names for the
 archives that it imports, it is also possible to specify Git branch names
 manually.  To do so, write a Git branch name after each <archive/branch>
 parameter, separated by a colon.  This way, you can shorten the Arch
@@ -85,7 +85,7 @@ OPTIONS
 
 -o::
 	Use this for compatibility with old-style branch names used by
-	earlier versions of 'git archimport'.  Old-style branch names
+	earlier versions of `git archimport`.  Old-style branch names
 	were category{litdd}branch, whereas new-style branch names are
 	archive,category{litdd}branch{litdd}version.  In both cases, names given
 	on the command-line will override the automatically-generated
diff --git a/Documentation/git-archive.txt b/Documentation/git-archive.txt
index 0af18c9df3..4bd6299046 100644
--- a/Documentation/git-archive.txt
+++ b/Documentation/git-archive.txt
@@ -21,13 +21,13 @@ structure for the named tree, and writes it out to the standard
 output.  If <prefix> is specified it is
 prepended to the filenames in the archive.
 
-'git archive' behaves differently when given a tree ID versus when
+`git archive` behaves differently when given a tree ID versus when
 given a commit ID or tag ID.  In the first case the current time is
 used as the modification time of each file in the archive.  In the latter
 case the commit time as recorded in the referenced commit object is
 used instead.  Additionally the commit ID is stored in a global
 extended pax header if the tar format is used; it can be extracted
-using 'git get-tar-commit-id'. In ZIP files it is stored as a file
+using `git get-tar-commit-id`. In ZIP files it is stored as a file
 comment.
 
 OPTIONS
@@ -78,7 +78,7 @@ OPTIONS
 
 --exec=<git-upload-archive>::
 	Used with `--remote` to specify the path to the
-	'git-upload-archive' on the remote side.
+	`git-upload-archive` on the remote side.
 
 <tree-ish>::
 	The tree or commit to produce an archive for.
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 1276424d65..b919b3ea42 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -7,16 +7,16 @@ Fighting regressions with git bisect
 Abstract
 --------
 
-"git bisect" enables software users and developers to easily find the
+`git bisect` enables software users and developers to easily find the
 commit that introduced a regression. We show why it is important to
-have good tools to fight regressions. We describe how "git bisect"
+have good tools to fight regressions. We describe how `git bisect`
 works from the outside and the algorithms it uses inside. Then we
-explain how to take advantage of "git bisect" to improve current
-practices. And we discuss how "git bisect" could improve in the
+explain how to take advantage of `git bisect` to improve current
+practices. And we discuss how `git bisect` could improve in the
 future.
 
 
-Introduction to "git bisect"
+Introduction to `git bisect`
 ----------------------------
 
 Git is a Distributed Version Control system (DVCS) created by Linus
@@ -36,14 +36,14 @@ properly fix a problem when you only need to check a very small set of
 changes, than when you don't know where look in the first place.
 
 So to help people find commits that introduce a "bad" behavior, the
-"git bisect" set of commands was invented. And it follows of course
-that in "git bisect" parlance, commits where the "interesting
+`git bisect` set of commands was invented. And it follows of course
+that in `git bisect` parlance, commits where the "interesting
 behavior" is present are called "bad" commits, while other commits are
 called "good" commits. And a commit that introduce the behavior we are
 interested in is called a "first bad commit". Note that there could be
 more than one "first bad commit" in the commit space we are searching.
 
-So "git bisect" is designed to help find a "first bad commit". And to
+So `git bisect` is designed to help find a "first bad commit". And to
 be as efficient as possible, it tries to perform a binary search.
 
 
@@ -133,7 +133,7 @@ time. But this is not the end of the fight yet, as of course it
 continues after the release.
 
 And then this is what Ingo Molnar (a well known Linux kernel
-developer) says about his use of git bisect:
+developer) says about his use of `git bisect`:
 
 _____________
 I most actively use it during the merge window (when a lot of trees
@@ -152,7 +152,7 @@ Other tools to fight regressions
 
 So what are the tools used to fight regressions? They are nearly the
 same as those used to fight regular bugs. The only specific tools are
-test suites and tools similar as "git bisect".
+test suites and tools similar as `git bisect`.
 
 Test suites are very nice. But when they are used alone, they are
 supposed to be used so that all the tests are checked after each
@@ -180,17 +180,17 @@ emulate a bisection process or you will perhaps bluntly test each
 commit backward starting from the "bad" commit you have which may be
 very wasteful.
 
-"git bisect" overview
+`git bisect` overview
 ---------------------
 
 Starting a bisection
 ~~~~~~~~~~~~~~~~~~~~
 
-The first "git bisect" subcommand to use is "git bisect start" to
+The first `git bisect` subcommand to use is `git bisect start` to
 start the search. Then bounds must be set to limit the commit
 space. This is done usually by giving one "bad" and at least one
-"good" commit. They can be passed in the initial call to "git bisect
-start" like this:
+"good" commit. They can be passed in the initial call to `git bisect
+start` like this:
 
 -------------
 $ git bisect start [BAD [GOOD...]]
@@ -211,7 +211,7 @@ $ git bisect good [COMMIT...]
 where BAD, GOOD and COMMIT are all names that can be resolved to a
 commit.
 
-Then "git bisect" will checkout a commit of its choosing and ask the
+Then `git bisect` will checkout a commit of its choosing and ask the
 user to test it, like this:
 
 -------------
@@ -224,8 +224,8 @@ Note that the example that we will use is really a toy example, we
 will be looking for the first commit that has a version like
 "2.6.26-something", that is the commit that has a "SUBLEVEL = 26" line
 in the top level Makefile. This is a toy example because there are
-better ways to find this commit with Git than using "git bisect" (for
-example "git blame" or "git log -S<string>").
+better ways to find this commit with Git than using `git bisect` (for
+example `git blame` or `git log -S<string>`).
 
 Driving a bisection manually
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -236,7 +236,7 @@ script or a command.
 
 If the user is driving it, then at each step of the search, the user
 will have to test the current commit and say if it is "good" or "bad"
-using the "git bisect good" or "git bisect bad" commands respectively
+using the `git bisect good` or `git bisect bad` commands respectively
 that have been described above. For example:
 
 -------------
@@ -245,7 +245,7 @@ Bisecting: 5480 revisions left to test after this (roughly 13 steps)
 [66c0b394f08fd89236515c1c84485ea712a157be] KVM: kill file->f_count abuse in kvm
 -------------
 
-And after a few more steps like that, "git bisect" will eventually
+And after a few more steps like that, `git bisect` will eventually
 find a first bad commit:
 
 -------------
@@ -287,7 +287,7 @@ index 5cf8258..4492984 100644
  # *DOCUMENTATION*
 -------------
 
-And when we are finished we can use "git bisect reset" to go back to
+And when we are finished we can use `git bisect reset` to go back to
 the branch we were in before we started bisecting:
 
 -------------
@@ -300,10 +300,10 @@ Switched to branch 'master'
 Driving a bisection automatically
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-The other way to drive the bisection process is to tell "git bisect"
+The other way to drive the bisection process is to tell `git bisect`
 to launch a script or command at each bisection step to know if the
-current commit is "good" or "bad". To do that, we use the "git bisect
-run" command. For example:
+current commit is "good" or "bad". To do that, we use the `git bisect
+run` command. For example:
 
 -------------
 $ git bisect start v2.6.27 v2.6.25
@@ -336,19 +336,19 @@ bisect run success
 -------------
 
 In this example, we passed "grep '^SUBLEVEL = 25' Makefile" as
-parameter to "git bisect run". This means that at each step, the grep
+parameter to `git bisect run`. This means that at each step, the grep
 command we passed will be launched. And if it exits with code 0 (that
-means success) then git bisect will mark the current state as
+means success) then `git bisect` will mark the current state as
 "good". If it exits with code 1 (or any code between 1 and 127
 included, except the special code 125), then the current state will be
 marked as "bad".
 
-Exit code between 128 and 255 are special to "git bisect run". They
+Exit code between 128 and 255 are special to `git bisect run`. They
 make it stop immediately the bisection process. This is useful for
 example if the command passed takes too long to complete, because you
 can kill it with a signal and it will stop the bisection process.
 
-It can also be useful in scripts passed to "git bisect run" to "exit
+It can also be useful in scripts passed to `git bisect run` to "exit
 255" if some very abnormal situation is detected.
 
 Avoiding untestable commits
@@ -357,15 +357,15 @@ Avoiding untestable commits
 Sometimes it happens that the current state cannot be tested, for
 example if it does not compile because there was a bug preventing it
 at that time. This is what the special exit code 125 is for. It tells
-"git bisect run" that the current commit should be marked as
+`git bisect run` that the current commit should be marked as
 untestable and that another one should be chosen and checked out.
 
-If the bisection process is driven manually, you can use "git bisect
-skip" to do the same thing. (In fact the special exit code 125 makes
-"git bisect run" use "git bisect skip" in the background.)
+If the bisection process is driven manually, you can use `git bisect
+skip` to do the same thing. (In fact the special exit code 125 makes
+`git bisect run` use `git bisect skip` in the background.)
 
 Or if you want more control, you can inspect the current state using
-for example "git bisect visualize". It will launch gitk (or "git log"
+for example `git bisect visualize`. It will launch gitk (or `git log`
 if the `DISPLAY` environment variable is not set) to help you find a
 better bisection point.
 
@@ -374,7 +374,7 @@ happen that the regression you are looking for has been introduced by
 one of these untestable commits. In this case it's not possible to
 tell for sure which commit introduced the regression.
 
-So if you used "git bisect skip" (or the run script exited with
+So if you used `git bisect skip` (or the run script exited with
 special code 125) you could get a result like this:
 
 -------------
@@ -415,7 +415,7 @@ best bisection commit to test at each step is not so simple. Anyway
 Linus found and implemented a "truly stupid" algorithm, later improved
 by Junio Hamano, that works quite well.
 
-So the algorithm used by "git bisect" to find the best bisection
+So the algorithm used by `git bisect` to find the best bisection
 commit when there are no skipped commits is the following:
 
 1) keep only the commits that:
@@ -530,7 +530,7 @@ Bisection algorithm debugging
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For any commit graph, you can see the number associated with each
-commit using "git rev-list --bisect-all".
+commit using `git rev-list --bisect-all`.
 
 For example, for the above graph, a command like:
 
@@ -658,7 +658,7 @@ A-B-C-D-E-F         O
             4 3 2 1
 -------------
 
-but with the algorithm used by git bisect we get:
+but with the algorithm used by `git bisect` we get:
 
 -------------
             7 7 6 5
@@ -682,7 +682,7 @@ initially supposed.
 Skip algorithm
 ~~~~~~~~~~~~~~
 
-When some commits have been skipped (using "git bisect skip"), then
+When some commits have been skipped (using `git bisect skip`), then
 the bisection algorithm is the same for step 1) to 3). But then we use
 roughly the following steps:
 
@@ -709,7 +709,7 @@ Skip algorithm discussed
 
 After step 7) (in the skip algorithm), we could check if the second
 commit has been skipped and return it if it is not the case. And in
-fact that was the algorithm we used from when "git bisect skip" was
+fact that was the algorithm we used from when `git bisect skip` was
 developed in Git version 1.5.4 (released on February 1st 2008) until
 Git version 1.6.4 (released July 29th 2009).
 
@@ -852,10 +852,10 @@ usual after this step.
 Best bisecting practices
 ------------------------
 
-Using test suites and git bisect together
+Using test suites and `git bisect` together
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-If you both have a test suite and use git bisect, then it becomes less
+If you both have a test suite and use `git bisect`, then it becomes less
 important to check that all tests pass after each commit. Though of
 course it is probably a good idea to have some checks to avoid
 breaking too many things because it could make bisecting other bugs
@@ -864,7 +864,7 @@ more difficult.
 You can focus your efforts to check at a few points (for example rc
 and beta releases) that all the T test cases pass for all the N
 configurations. And when some tests don't pass you can use "git
-bisect" (or better "git bisect run"). So you should perform roughly:
+bisect" (or better `git bisect run`). So you should perform roughly:
 
 -------------
 c * N * T + b * M * log2(M) tests
@@ -879,11 +879,11 @@ you would test everything after each commit.
 This means that test suites are good to prevent some bugs from being
 committed and they are also quite good to tell you that you have some
 bugs. But they are not so good to tell you where some bugs have been
-introduced. To tell you that efficiently, git bisect is needed.
+introduced. To tell you that efficiently, `git bisect` is needed.
 
 The other nice thing with test suites, is that when you have one, you
 already know how to test for bad behavior. So you can use this
-knowledge to create a new test case for "git bisect" when it appears
+knowledge to create a new test case for `git bisect` when it appears
 that there is a regression. So it will be easier to bisect the bug and
 fix it. And then you can add the test case you just created to your
 test suite.
@@ -893,7 +893,7 @@ subject to a virtuous circle:
 
 more tests => easier to create tests => easier to bisect => more tests
 
-So test suites and "git bisect" are complementary tools that are very
+So test suites and `git bisect` are complementary tools that are very
 powerful and efficient when used together.
 
 Bisecting build failures
@@ -907,7 +907,7 @@ $ git bisect start BAD GOOD
 $ git bisect run make
 -------------
 
-Passing sh -c "some commands" to "git bisect run"
+Passing sh -c "some commands" to `git bisect run`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 For example:
@@ -925,7 +925,7 @@ Finding performance regressions
 Here is an example script that comes slightly modified from a real
 world script used by Junio Hamano <<4>>.
 
-This script can be passed to "git bisect run" to find the commit that
+This script can be passed to `git bisect run` to find the commit that
 introduced a performance regression:
 
 -------------
@@ -969,7 +969,7 @@ It is also a good idea when using any VCS to have only one small
 logical change in each commit.
 
 The smaller the changes in your commit, the most effective "git
-bisect" will be. And you will probably need "git bisect" less in the
+bisect" will be. And you will probably need `git bisect` less in the
 first place, as small changes are easier to review even if they are
 only reviewed by the committer.
 
@@ -996,7 +996,7 @@ misleading to know the first bad commit if it happens to be such a
 merge, because people might think that the bug comes from bad conflict
 resolution when it comes from a semantic change in one branch.
 
-Anyway "git rebase" can be used to linearize history. This can be used
+Anyway `git rebase` can be used to linearize history. This can be used
 either to avoid merging in the first place. Or it can be used to
 bisect on a linear history instead of the non linear one, as this
 should give more information in case of a semantic change in one
@@ -1016,7 +1016,7 @@ A special work-flow to process regressions can give great results.
 Here is an example of a work-flow used by Andreas Ericsson:
 
 * write, in the test suite, a test script that exposes the regression
-* use "git bisect run" to find the commit that introduced it
+* use `git bisect run` to find the commit that introduced it
 * fix the bug that is often made obvious by the previous step
 * commit both the fix and the test script (and if needed more tests)
 
@@ -1034,7 +1034,7 @@ due to how we now feel about writing tests).
 _____________
 
 Clearly this work-flow uses the virtuous circle between test suites
-and "git bisect". In fact it makes it the standard procedure to deal
+and `git bisect`. In fact it makes it the standard procedure to deal
 with regression.
 
 In other messages Andreas says that they also use the "best practices"
@@ -1048,7 +1048,7 @@ is making bisecting easier, more useful and standard.
 Involving QA people and if possible end users
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-One nice about "git bisect" is that it is not only a developer
+One nice about `git bisect` is that it is not only a developer
 tool. It can effectively be used by QA people or even end users (if
 they have access to the source code or if they can get access to all
 the builds).
@@ -1091,7 +1091,7 @@ Here is what Ingo Molnar says about that <<7>>:
 
 _____________
 i have a fully automated bootup-hang bisection script. It is based on
-"git-bisect run". I run the script, it builds and boots kernels fully
+`git-bisect run`. I run the script, it builds and boots kernels fully
 automatically, and when the bootup fails (the script notices that via
 the serial log, which it continuously watches - or via a timeout, if
 the system does not come up within 10 minutes it's a "bad" kernel),
@@ -1100,28 +1100,28 @@ box. (yeah, i should make use of a managed power outlet to 100%
 automate it)
 _____________
 
-Combining test suites, git bisect and other systems together
+Combining test suites, `git bisect` and other systems together
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-We have seen that test suites and git bisect are very powerful when
+We have seen that test suites and `git bisect` are very powerful when
 used together. It can be even more powerful if you can combine them
 with other systems.
 
 For example some test suites could be run automatically at night with
 some unusual (or even random) configurations. And if a regression is
-found by a test suite, then "git bisect" can be automatically
+found by a test suite, then `git bisect` can be automatically
 launched, and its result can be emailed to the author of the first bad
-commit found by "git bisect", and perhaps other people too. And a new
+commit found by `git bisect`, and perhaps other people too. And a new
 entry in the bug tracking system could be automatically created too.
 
 
 The future of bisecting
 -----------------------
 
-"git replace"
+`git replace`
 ~~~~~~~~~~~~~
 
-We saw earlier that "git bisect skip" is now using a PRNG to try to
+We saw earlier that `git bisect skip` is now using a PRNG to try to
 avoid areas in the commit graph where commits are untestable. The
 problem is that sometimes the first bad commit will be in an
 untestable area.
@@ -1177,26 +1177,26 @@ For example:
 $ git bisect start Z' Y
 -------------
 
-If you are using "git bisect run", you can use the same manual fix up
-as above, and then start another "git bisect run" in the special
-branch. Or as the "git bisect" man page says, the script passed to
-"git bisect run" can apply a patch before it compiles and test the
+If you are using `git bisect run`, you can use the same manual fix up
+as above, and then start another `git bisect run` in the special
+branch. Or as the `git bisect` man page says, the script passed to
+`git bisect run` can apply a patch before it compiles and test the
 software <<8>>. The patch should turn a current untestable commits
 into a testable one. So the testing will result in "good" or "bad" and
-"git bisect" will be able to find the first bad commit. And the script
+`git bisect` will be able to find the first bad commit. And the script
 should not forget to remove the patch once the testing is done before
 exiting from the script.
 
-(Note that instead of a patch you can use "git cherry-pick BFC" to
-apply the fix, and in this case you should use "git reset --hard
-HEAD^" to revert the cherry-pick after testing and before returning
+(Note that instead of a patch you can use `git cherry-pick BFC` to
+apply the fix, and in this case you should use `git reset --hard
+HEAD` to revert the cherry-pick after testing and before returning
 from the script.)
 
 But the above ways to work around untestable areas are a little bit
 clunky. Using special branches is nice because these branches can be
 shared by developers like usual branches, but the risk is that people
-will get many such branches. And it disrupts the normal "git bisect"
-work-flow. So, if you want to use "git bisect run" completely
+will get many such branches. And it disrupts the normal `git bisect`
+work-flow. So, if you want to use `git bisect run` completely
 automatically, you have to add special code in your script to restart
 bisection in the special branches.
 
@@ -1217,13 +1217,13 @@ With the example above that would give:
 ...-Y-BBC-X1-X2-X3-X4-X5-X6-BFC-Z
 -------------
 
-That's why the "git replace" command was created. Technically it
+That's why the `git replace` command was created. Technically it
 stores replacements "refs" in the "refs/replace/" hierarchy. These
 "refs" are like branches (that are stored in "refs/heads/") or tags
 (that are stored in "refs/tags"), and that means that they can
 automatically be shared like branches or tags among developers.
 
-"git replace" is a very powerful mechanism. It can be used to fix
+`git replace` is a very powerful mechanism. It can be used to fix
 commits in already released history, for example to change the commit
 message or the author. And it can also be used instead of git "grafts"
 to link a repository with another old repository.
@@ -1232,7 +1232,7 @@ In fact it's this last feature that "sold" it to the Git community, so
 it is now in the `master` branch of Git's Git repository and it should
 be released in Git 1.6.5 in October or November 2009.
 
-One problem with "git replace" is that currently it stores all the
+One problem with `git replace` is that currently it stores all the
 replacements refs in "refs/replace/", but it would be perhaps better
 if the replacement refs that are useful only for bisecting would be in
 "refs/replace/bisect/". This way the replacement refs could be used
@@ -1242,7 +1242,7 @@ be used nearly all the time.
 Bisecting sporadic bugs
 ~~~~~~~~~~~~~~~~~~~~~~~
 
-Another possible improvement to "git bisect" would be to optionally
+Another possible improvement to `git bisect` would be to optionally
 add some redundancy to the tests performed so that it would be more
 reliable when tracking sporadic bugs.
 
@@ -1250,7 +1250,7 @@ This has been requested by some kernel developers because some bugs
 called sporadic bugs do not appear in all the kernel builds because
 they are very dependent on the compiler output.
 
-The idea is that every 3 test for example, "git bisect" could ask the
+The idea is that every 3 test for example, `git bisect` could ask the
 user to test a commit that has already been found to be "good" or
 "bad" (because one of its descendants or one of its ancestors has been
 found to be "good" or "bad" respectively). If it happens that a commit
@@ -1264,7 +1264,7 @@ on Github that does something like that using Bayesian Search Theory
 <<9>>:
 
 _____________
-BBChop is like 'git bisect' (or equivalent), but works when your bug
+BBChop is like `git bisect` (or equivalent), but works when your bug
 is intermittent. That is, it works in the presence of false negatives
 (when a version happens to work this time even though it contains the
 bug). It assumes that there are no false positives (in principle, the
@@ -1283,12 +1283,12 @@ other tools, especially test suites, that are generally used to fight
 regressions. But it might be needed to change some work-flows and
 (bad) habits to get the most out of it.
 
-Some improvements to the algorithms inside "git bisect" are possible
+Some improvements to the algorithms inside `git bisect` are possible
 and some new features could help in some cases, but overall "git
 bisect" works already very well, is used a lot, and is already very
 useful. To back up that last claim, let's give the final word to Ingo
 Molnar when he was asked by the author how much time does he think
-"git bisect" saves him when he uses it:
+`git bisect` saves him when he uses it:
 
 _____________
 a _lot_.
@@ -1307,7 +1307,7 @@ manual help or when bisecting multiple, overlapping bugs, it's rarely
 more than an hour.
 
 In fact it's invaluable because there are bugs i would never even
-_try_ to debug if it wasn't for git bisect. In the past there were bug
+_try_ to debug if it wasn't for `git bisect`. In the past there were bug
 patterns that were immediately hopeless for me to debug - at best i
 could send the crash/bug signature to lkml and hope that someone else
 can think of something.
@@ -1316,7 +1316,7 @@ And even if a bisection fails today it tells us something valuable
 about the bug: that it's non-deterministic - timing or kernel image
 layout dependent.
 
-So git bisect is unconditional goodness - and feel free to quote that
+So `git bisect` is unconditional goodness - and feel free to quote that
 ;-)
 _____________
 
@@ -1325,16 +1325,16 @@ Acknowledgments
 
 Many thanks to Junio Hamano for his help in reviewing this paper, for
 reviewing the patches I sent to the Git mailing list, for discussing
-some ideas and helping me improve them, for improving "git bisect" a
+some ideas and helping me improve them, for improving `git bisect` a
 lot and for his awesome work in maintaining and developing Git.
 
 Many thanks to Ingo Molnar for giving me very useful information that
 appears in this paper, for commenting on this paper, for his
-suggestions to improve "git bisect" and for evangelizing "git bisect"
+suggestions to improve `git bisect` and for evangelizing `git bisect`
 on the linux kernel mailing lists.
 
 Many thanks to Linus Torvalds for inventing, developing and
-evangelizing "git bisect", Git and Linux.
+evangelizing `git bisect`, Git and Linux.
 
 Many thanks to the many other great people who helped one way or
 another when I worked on Git, especially to Andreas Ericsson, Johannes
@@ -1351,7 +1351,7 @@ References
 - [[[2]]] http://www.oracle.com/technetwork/java/codeconvtoc-136057.html['Code Conventions for the Java Programming Language'. Sun Microsystems.]
 - [[[3]]] https://en.wikipedia.org/wiki/Software_maintenance['Software maintenance'. Wikipedia.]
 - [[[4]]] https://lore.kernel.org/git/7vps5xsbwp.fsf_-_@assigned-by-dhcp.cox.net/[Junio C Hamano. 'Automated bisect success story'.]
-- [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with "git bisect run"'. LWN.net.]
+- [[[5]]] https://lwn.net/Articles/317154/[Christian Couder. 'Fully automated bisecting with `git bisect run`'. LWN.net.]
 - [[[6]]] https://lwn.net/Articles/277872/[Jonathan Corbet. 'Bisection divides users and developers'. LWN.net.]
 - [[[7]]] https://lore.kernel.org/lkml/20071207113734.GA14598@elte.hu/[Ingo Molnar. 'Re: BUG 2.6.23-rc3 can't see sd partitions on Alpha'. Linux-kernel mailing list.]
 - [[[8]]] https://www.kernel.org/pub/software/scm/git/docs/git-bisect.html[Junio C Hamano and the git-list. 'git-bisect(1) Manual Page'. Linux Kernel Archives.]
diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index ff50c66e29..d59422636b 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -9,25 +9,25 @@ git-bisect - Use binary search to find the commit that introduced a bug
 SYNOPSIS
 --------
 [verse]
-'git bisect' <subcommand> <options>
+`git bisect` <subcommand> <options>
 
 DESCRIPTION
 -----------
 The command takes various subcommands, and different options depending
 on the subcommand:
 
- git bisect start [--term-{new,bad}=<term> --term-{old,good}=<term>]
-		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
- git bisect (bad|new|<term-new>) [<rev>]
- git bisect (good|old|<term-old>) [<rev>...]
- git bisect terms [--term-good | --term-bad]
- git bisect skip [(<rev>|<range>)...]
- git bisect reset [<commit>]
- git bisect (visualize|view)
- git bisect replay <logfile>
- git bisect log
- git bisect run <cmd>...
- git bisect help
+ `git bisect` start [--term-{new,bad}=<term> --term-{old,good}=<term>]
+ 	    	  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
+ `git bisect` (bad|new|<term-new>) [<rev>]
+ `git bisect` (good|old|<term-old>) [<rev>...]
+ `git bisect` terms [--term-good | --term-bad]
+ `git bisect` skip [(<rev>|<range>)...]
+ `git bisect` reset [<commit>]
+ `git bisect` (visualize|view)
+ `git bisect` replay <logfile>
+ `git bisect` log
+ `git bisect` run <cmd>...
+ `git bisect` help
 
 This command uses a binary search algorithm to find which commit in
 your project's history introduced a bug. You use it by first telling
@@ -196,7 +196,7 @@ of `git bisect good` and `git bisect bad` to mark commits.
 Bisect visualize/view
 ~~~~~~~~~~~~~~~~~~~~~
 
-To see the currently remaining suspects in 'gitk', issue the following
+To see the currently remaining suspects in `gitk`, issue the following
 command during the bisection process (the subcommand `view` can be used
 as an alternative to `visualize`):
 
@@ -204,7 +204,7 @@ as an alternative to `visualize`):
 $ git bisect visualize
 ------------
 
-If the `DISPLAY` environment variable is not set, 'git log' is used
+If the `DISPLAY` environment variable is not set, `git log` is used
 instead.  You can also give command-line options such as `-p` and
 `--stat`.
 
@@ -344,7 +344,7 @@ header file, or "revision that does not have this commit needs this
 patch applied to work around another problem this bisection is not
 interested in") applied to the revision being tested.
 
-To cope with such a situation, after the inner 'git bisect' finds the
+To cope with such a situation, after the inner `git bisect` finds the
 next revision to test, the script can apply the patch
 before compiling, run the real test, and afterwards decide if the
 revision (possibly with the needed patch) passed the test and then
@@ -475,9 +475,9 @@ $ git bisect run sh -c '
 $ git bisect reset                   # quit the bisect session
 ------------
 +
-In this case, when 'git bisect run' finishes, bisect/bad will refer to a commit that
+In this case, when `git bisect run` finishes, bisect/bad will refer to a commit that
 has at least one parent whose reachable graph is fully traversable in the sense
-required by 'git pack objects'.
+required by `git pack objects`.
 
 * Look for a fix instead of a regression in the code
 +
@@ -502,7 +502,7 @@ help` or `git bisect -h` to get a long usage description.
 
 SEE ALSO
 --------
-link:git-bisect-lk2009.html[Fighting regressions with git bisect],
+link:git-bisect-lk2009.html[Fighting regressions with `git bisect`],
 linkgit:git-blame[1].
 
 GIT
diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index 3bf5d5d8b4..aa1b5d56d3 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -8,7 +8,7 @@ git-blame - Show what revision and author last modified each line of a file
 SYNOPSIS
 --------
 [verse]
-'git blame' [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
+`git blame` [-c] [-b] [-l] [--root] [-t] [-f] [-n] [-s] [-e] [-p] [-w] [--incremental]
 	    [-L <range>] [-S <revs-file>] [-M] [-C] [-C] [-C] [--since=<date>]
 	    [--ignore-rev <rev>] [--ignore-revs-file <file>]
 	    [--progress] [--abbrev=<n>] [<rev> | --contents <file> | --reverse <rev>..<rev>]
@@ -30,7 +30,7 @@ lines that were copied and pasted from another file, etc., see the
 `-C` and `-M` options.
 
 The report does not tell you anything about lines which have been deleted or
-replaced; you need to use a tool such as 'git diff' or the "pickaxe"
+replaced; you need to use a tool such as `git diff` or the "pickaxe"
 interface briefly mentioned in the following paragraph.
 
 Apart from supporting file annotation, Git also supports searching the
@@ -59,7 +59,7 @@ include::blame-options.txt[]
 	file (see `-M`).  The first number listed is the score.
 	This is the number of alphanumeric characters detected
 	as having been moved between or within files.  This must be above
-	a certain threshold for 'git blame' to consider those lines
+	a certain threshold for `git blame` to consider those lines
 	of code to have been moved.
 
 -f::
@@ -136,7 +136,7 @@ usage like:
 SPECIFYING RANGES
 -----------------
 
-Unlike 'git blame' and 'git annotate' in older versions of git, the extent
+Unlike `git blame` and `git annotate` in older versions of git, the extent
 of the annotation can be limited to both line ranges and revision
 ranges. The `-L` option, which limits annotation to a range of lines, may be
 specified multiple times.
@@ -157,7 +157,7 @@ which limits the annotation to the body of the `hello` subroutine.
 
 When you are not interested in changes older than version
 v2.6.18, or changes older than 3 weeks, you can use revision
-range specifiers  similar to 'git rev-list':
+range specifiers  similar to `git rev-list`:
 
 	git blame v2.6.18.. -- foo
 	git blame --since=3.weeks -- foo
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index 8ea6e1e523..6f37f11b33 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete branches
 SYNOPSIS
 --------
 [verse]
-'git branch' [--color[=<when>] | --no-color] [--show-current]
+`git branch` [--color[=<when>] | --no-color] [--show-current]
 	[-v [--abbrev=<n> | --no-abbrev]]
 	[--column[=<options>] | --no-column] [--sort=<key>]
 	[--merged [<commit>]] [--no-merged [<commit>]]
@@ -16,13 +16,13 @@ SYNOPSIS
 	[--points-at <object>] [--format=<format>]
 	[(-r | --remotes) | (-a | --all)]
 	[--list] [<pattern>...]
-'git branch' [--track | --no-track] [-f] <branchname> [<start-point>]
-'git branch' (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
-'git branch' --unset-upstream [<branchname>]
-'git branch' (-m | -M) [<oldbranch>] <newbranch>
-'git branch' (-c | -C) [<oldbranch>] <newbranch>
-'git branch' (-d | -D) [-r] <branchname>...
-'git branch' --edit-description [<branchname>]
+`git branch` [--track | --no-track] [-f] <branchname> [<start-point>]
+`git branch` (--set-upstream-to=<upstream> | -u <upstream>) [<branchname>]
+`git branch` --unset-upstream [<branchname>]
+`git branch` (-m | -M) [<oldbranch>] <newbranch>
+`git branch` (-c | -C) [<oldbranch>] <newbranch>
+`git branch` (-d | -D) [-r] <branchname>...
+`git branch` --edit-description [<branchname>]
 
 DESCRIPTION
 -----------
@@ -60,12 +60,12 @@ can leave out at most one of `A` and `B`, in which case it defaults to
 `HEAD`.
 
 Note that this will create the new branch, but it will not switch the
-working tree to it; use "git switch <newbranch>" to switch to the
+working tree to it; use `git switch <newbranch>` to switch to the
 new branch.
 
 When a local branch is started off a remote-tracking branch, Git sets up the
 branch (specifically the `branch.<name>.remote` and `branch.<name>.merge`
-configuration entries) so that 'git pull' will appropriately merge from
+configuration entries) so that `git pull` will appropriately merge from
 the remote-tracking branch. This behavior may be changed via the global
 `branch.autoSetupMerge` configuration flag. That setting can be
 overridden by using the `--track` and `--no-track` options, and
@@ -87,7 +87,7 @@ has a reflog then the reflog will also be deleted.
 
 Use `-r` together with `-d` to delete remote-tracking branches. Note, that it
 only makes sense to delete remote-tracking branches if they no longer exist
-in the remote repository or if 'git fetch' was configured not to fetch
+in the remote repository or if `git fetch` was configured not to fetch
 them again. See also the 'prune' subcommand of linkgit:git-remote[1] for a
 way to clean up all obsolete remote-tracking branches.
 
@@ -116,7 +116,7 @@ OPTIONS
 -f::
 --force::
 	Reset <branchname> to <startpoint>, even if <branchname> exists
-	already. Without `-f`, 'git branch' refuses to change an existing branch.
+	already. Without `-f`, `git branch` refuses to change an existing branch.
 	In combination with `-d` (or `--delete`), allow deleting the
 	branch irrespective of its merged status. In combination with
 	`-m` (or `--move`), allow renaming the branch even if the new
@@ -209,7 +209,7 @@ This option is only applicable in non-verbose mode.
 	When creating a new branch, set up `branch.<name>.remote` and
 	`branch.<name>.merge` configuration entries to mark the
 	start-point branch as "upstream" from the new branch. This
-	configuration will tell git to show the relationship between the
+	configuration will tell `git` to show the relationship between the
 	two branches in `git status` and `git branch -v`. Furthermore,
 	it directs `git pull` without arguments to pull from the
 	upstream when the new branch is checked out.
@@ -351,7 +351,7 @@ NOTES
 -----
 
 If you are creating a branch that you want to switch to immediately,
-it is easier to use the "git switch" command with its `-c` option to
+it is easier to use the `git switch` command with its `-c` option to
 do the same thing with a single command.
 
 The options `--contains`, `--no-contains`, `--merged` and `--no-merged`
diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index 66e88c2e31..bb1355248e 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -25,7 +25,7 @@ The following information is requested from the user:
 
 The following information is captured automatically:
 
- - 'git version --build-options'
+ - `git version --build-options`
  - uname sysname, release, version, and machine strings
  - Compiler-specific info string
  - A list of enabled hooks
@@ -46,7 +46,7 @@ OPTIONS
 -s <format>::
 --suffix <format>::
 	Specify an alternate suffix for the bugreport name, to create a file
-	named 'git-bugreport-<formatted suffix>'. This should take the form of a
+	named `git-bugreport-<formatted suffix>`. This should take the form of a
 	strftime(3) format string; the current local time will be used.
 
 GIT
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 20da47cbd6..fb0ebe1257 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -9,11 +9,11 @@ git-bundle - Move objects and refs by archive
 SYNOPSIS
 --------
 [verse]
-'git bundle' create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
+`git bundle` create [-q | --quiet | --progress | --all-progress] [--all-progress-implied]
 		    [--version=<version>] <file> <git-rev-list-args>
-'git bundle' verify [-q | --quiet] <file>
-'git bundle' list-heads <file> [<refname>...]
-'git bundle' unbundle <file> [<refname>...]
+`git bundle` verify [-q | --quiet] <file>
+`git bundle` list-heads <file> [<refname>...]
+`git bundle` unbundle <file> [<refname>...]
 
 DESCRIPTION
 -----------
@@ -23,9 +23,9 @@ machine be replicated on another machine, but the two machines cannot
 be directly connected, and therefore the interactive Git protocols (git,
 ssh, http) cannot be used.
 
-The 'git bundle' command packages objects and references in an archive
+The `git bundle` command packages objects and references in an archive
 at the originating machine, which can then be imported into another
-repository using 'git fetch', 'git pull', or 'git clone',
+repository using `git fetch`, `git pull`, or `git clone`,
 after moving the archive by some means (e.g., by sneakernet).
 
 As no
@@ -40,7 +40,7 @@ OPTIONS
 create [options] <file> <git-rev-list-args>::
 	Used to create a bundle named 'file'.  This requires the
 	'<git-rev-list-args>' arguments to define the bundle contents.
-	'options' contains the options specific to the 'git bundle create'
+	'options' contains the options specific to the `git bundle create`
 	subcommand.
 
 verify <file>::
@@ -48,7 +48,7 @@ verify <file>::
 	cleanly to the current repository.  This includes checks on the
 	bundle format itself as well as checking that the prerequisite
 	commits exist and are fully linked in the current repository.
-	'git bundle' prints a list of missing commits, if any, and exits
+	`git bundle` prints a list of missing commits, if any, and exits
 	with a non-zero status.
 
 list-heads <file>::
@@ -57,15 +57,15 @@ list-heads <file>::
 	printed out.
 
 unbundle <file>::
-	Passes the objects in the bundle to 'git index-pack'
+	Passes the objects in the bundle to `git index-pack`
 	for storage in the repository, then prints the names of all
 	defined references. If a list of references is given, only
 	references matching those in the list are printed. This command is
-	really plumbing, intended to be called only by 'git fetch'.
+	really plumbing, intended to be called only by `git fetch`.
 
 <git-rev-list-args>::
-	A list of arguments, acceptable to 'git rev-parse' and
-	'git rev-list' (and containing a named ref, see SPECIFYING REFERENCES
+	A list of arguments, acceptable to `git rev-parse` and
+	`git rev-list` (and containing a named ref, see SPECIFYING REFERENCES
 	below), that specifies the specific objects and references
 	to transport.  For example, `master~10..master` causes the
 	current `master` reference to be packaged along with all objects
@@ -76,10 +76,10 @@ unbundle <file>::
 
 [<refname>...]::
 	A list of references used to limit the references reported as
-	available. This is principally of use to 'git fetch', which
+	available. This is principally of use to `git fetch`, which
 	expects to receive only those references asked for and not
-	necessarily everything in the pack (in this case, 'git bundle' acts
-	like 'git fetch-pack').
+	necessarily everything in the pack (in this case, `git bundle` acts
+	like `git fetch-pack`).
 
 --progress::
 	Progress status is reported on the standard error stream
@@ -117,8 +117,8 @@ unbundle <file>::
 SPECIFYING REFERENCES
 ---------------------
 
-'git bundle' will only package references that are shown by
-'git show-ref': this includes heads, tags, and remote heads.  References
+`git bundle` will only package references that are shown by
+`git show-ref`: this includes heads, tags, and remote heads.  References
 such as `master~1` cannot be packaged, but are perfectly suitable for
 defining the basis.  More than one reference may be packaged, and more
 than one basis can be specified.  The objects packaged are those not
diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 4eb0421b3f..3ac3d44fcb 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -9,8 +9,8 @@ git-cat-file - Provide content or type and size information for repository objec
 SYNOPSIS
 --------
 [verse]
-'git cat-file' (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
-'git cat-file' (--batch[=<format>] | --batch-check[=<format>]) [ --textconv | --filters ] [--follow-symlinks]
+`git cat-file` (-t [--allow-unknown-type]| -s [--allow-unknown-type]| -e | -p | <type> | --textconv | --filters ) [--path=<path>] <object>
+`git cat-file` (--batch[=<format>] | --batch-check[=<format>]) [ --textconv | --filters ] [--follow-symlinks]
 
 DESCRIPTION
 -----------
@@ -134,7 +134,7 @@ one in the tree.
 This option cannot (currently) be used unless `--batch` or
 `--batch-check` is used.
 +
-For example, consider a git repository containing:
+For example, consider a `git` repository containing:
 +
 --
 	f: a file containing "hello\n"
diff --git a/Documentation/git-check-attr.txt b/Documentation/git-check-attr.txt
index 84f41a8e82..0ac496700e 100644
--- a/Documentation/git-check-attr.txt
+++ b/Documentation/git-check-attr.txt
@@ -9,8 +9,8 @@ git-check-attr - Display gitattributes information
 SYNOPSIS
 --------
 [verse]
-'git check-attr' [-a | --all | <attr>...] [--] <pathname>...
-'git check-attr' --stdin [-z] [-a | --all | <attr>...]
+`git check-attr` [-a | --all | <attr>...] [--] <pathname>...
+`git check-attr` --stdin [-z] [-a | --all | <attr>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 0c3924a63d..56a4f655c8 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -9,8 +9,8 @@ git-check-ignore - Debug gitignore / exclude files
 SYNOPSIS
 --------
 [verse]
-'git check-ignore' [<options>] <pathname>...
-'git check-ignore' [<options>] --stdin
+`git check-ignore` [<options>] <pathname>...
+`git check-ignore` [<options>] --stdin
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-check-mailmap.txt b/Documentation/git-check-mailmap.txt
index 02f4418323..302049afe4 100644
--- a/Documentation/git-check-mailmap.txt
+++ b/Documentation/git-check-mailmap.txt
@@ -9,7 +9,7 @@ git-check-mailmap - Show canonical names and email addresses of contacts
 SYNOPSIS
 --------
 [verse]
-'git check-mailmap' [<options>] <contact>...
+`git check-mailmap` [<options>] <contact>...
 
 
 DESCRIPTION
diff --git a/Documentation/git-check-ref-format.txt b/Documentation/git-check-ref-format.txt
index f39622c0da..77beb46e98 100644
--- a/Documentation/git-check-ref-format.txt
+++ b/Documentation/git-check-ref-format.txt
@@ -8,10 +8,10 @@ git-check-ref-format - Ensures that a reference name is well formed
 SYNOPSIS
 --------
 [verse]
-'git check-ref-format' [--normalize]
+`git check-ref-format` [--normalize]
        [--[no-]allow-onelevel] [--refspec-pattern]
        <refname>
-'git check-ref-format' --branch <branchname-shorthand>
+`git check-ref-format` --branch <branchname-shorthand>
 
 DESCRIPTION
 -----------
@@ -73,7 +73,7 @@ reference name expressions (see linkgit:gitrevisions[7]):
 . A colon `:` is used as in `srcref:dstref` to mean "use srcref\'s
   value and store it in dstref" in fetch and push operations.
   It may also be used to select a specific object such as with
-  'git cat-file': "git cat-file blob v1.3.3:refs.c".
+  `git cat-file`: `git cat-file blob v1.3.3:refs.c`.
 
 . at-open-brace `@{` is used as a notation to access a reflog entry.
 
@@ -88,7 +88,7 @@ but it is explicitly forbidden at the beginning of a branch name).
 When run with `--branch` option in a repository, the input is first
 expanded for the ``previous checkout syntax''
 `@{-n}`.  For example, `@{-1}` is a way to refer the last thing that
-was checked out using "git switch" or "git checkout" operation.
+was checked out using `git switch` or `git checkout` operation.
 This option should be
 used by porcelains to accept this syntax anywhere a branch name is
 expected, so they can act as if you typed the branch name. As an
diff --git a/Documentation/git-checkout-index.txt b/Documentation/git-checkout-index.txt
index b06d3ae3d9..6e49062ea3 100644
--- a/Documentation/git-checkout-index.txt
+++ b/Documentation/git-checkout-index.txt
@@ -9,7 +9,7 @@ git-checkout-index - Copy files from the index to the working tree
 SYNOPSIS
 --------
 [verse]
-'git checkout-index' [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
+`git checkout-index` [-u] [-q] [-a] [-f] [-n] [--prefix=<string>]
 		   [--stage=<number>|all]
 		   [--temp]
 		   [-z] [--stdin]
@@ -88,7 +88,7 @@ $ find . -name '*.h' -print0 | xargs -0 git checkout-index -f --
 which will force all existing `*.h` files to be replaced with their
 cached copies. If an empty command line implied "all", then this would
 force-refresh everything in the index, which was not the point.  But
-since 'git checkout-index' accepts `--stdin` it would be faster to use:
+since `git checkout-index` accepts `--stdin` it would be faster to use:
 
 ----------------
 $ find . -name '*.h' -print0 | git checkout-index -f -z --stdin
@@ -102,7 +102,7 @@ Using `--` is probably a good policy in scripts.
 Using --temp or --stage=all
 ---------------------------
 When `--temp` is used (or implied by `--stage=all`)
-'git checkout-index' will create a temporary file for each index
+`git checkout-index` will create a temporary file for each index
 entry being checked out.  The index will not be updated with stat
 information.  These options can be useful if the caller needs all
 stages of all unmerged entries so that the unmerged files can be
@@ -147,9 +147,9 @@ To update and refresh only the files already checked out::
 $ git checkout-index -n -f -a && git update-index --ignore-missing --refresh
 ----------------
 
-Using 'git checkout-index' to "export an entire tree"::
+Using `git checkout-index` to "export an entire tree"::
 	The prefix ability basically makes it trivial to use
-	'git checkout-index' as an "export as tree" function.
+	`git checkout-index` as an "export as tree" function.
 	Just read the desired tree into the index, and do:
 +
 ----------------
diff --git a/Documentation/git-checkout.txt b/Documentation/git-checkout.txt
index 192dbfe9b0..c3fc807d91 100644
--- a/Documentation/git-checkout.txt
+++ b/Documentation/git-checkout.txt
@@ -8,22 +8,22 @@ git-checkout - Switch branches or restore working tree files
 SYNOPSIS
 --------
 [verse]
-'git checkout' [-q] [-f] [-m] [<branch>]
-'git checkout' [-q] [-f] [-m] --detach [<branch>]
-'git checkout' [-q] [-f] [-m] [--detach] <commit>
-'git checkout' [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
+`git checkout` [-q] [-f] [-m] [<branch>]
+`git checkout` [-q] [-f] [-m] --detach [<branch>]
+`git checkout` [-q] [-f] [-m] [--detach] <commit>
+`git checkout` [-q] [-f] [-m] [[-b|-B|--orphan] <new_branch>] [<start_point>]
+`git checkout` [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...
+`git checkout` [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]
+`git checkout` (-p|--patch) [<tree-ish>] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
 Updates files in the working tree to match the version in the index
-or the specified tree.  If no pathspec was given, 'git checkout' will
+or the specified tree.  If no pathspec was given, `git checkout` will
 also update `HEAD` to set the specified branch as the current
 branch.
 
-'git checkout' [<branch>]::
+`git checkout` [<branch>]::
 	To prepare for working on `<branch>`, switch to it by updating
 	the index and the files in the working tree, and by pointing
 	`HEAD` at the branch. Local modifications to the files in the
@@ -43,12 +43,12 @@ You could omit `<branch>`, in which case the command degenerates to
 rather expensive side-effects to show only the tracking information,
 if exists, for the current branch.
 
-'git checkout' -b|-B <new_branch> [<start point>]::
+`git checkout` -b|-B <new_branch> [<start point>]::
 
 	Specifying `-b` causes a new branch to be created as if
 	linkgit:git-branch[1] were called and then checked out.  In
 	this case you can use the `--track` or `--no-track` options,
-	which will be passed to 'git branch'.  As a convenience,
+	which will be passed to `git branch`.  As a convenience,
 	`--track` without `-b` implies branch creation; see the
 	description of `--track` below.
 +
@@ -60,11 +60,11 @@ $ git branch -f <branch> [<start point>]
 $ git checkout <branch>
 ------------
 +
-that is to say, the branch is not reset/created unless "git checkout" is
+that is to say, the branch is not reset/created unless `git checkout` is
 successful.
 
-'git checkout' --detach [<branch>]::
-'git checkout' [--detach] <commit>::
+`git checkout` --detach [<branch>]::
+`git checkout` [--detach] <commit>::
 
 	Prepare to work on top of `<commit>`, by detaching `HEAD` at it
 	(see "DETACHED HEAD" section), and updating the index and the
@@ -79,8 +79,8 @@ be used to detach `HEAD` at the tip of the branch (`git checkout
 +
 Omitting `<branch>` detaches `HEAD` at the tip of the current branch.
 
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
-'git checkout' [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]::
+`git checkout` [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] [--] <pathspec>...::
+`git checkout` [-f|--ours|--theirs|-m|--conflict=<style>] [<tree-ish>] --pathspec-from-file=<file> [--pathspec-file-nul]::
 
 	Overwrite the contents of the files that match the pathspec.
 	When the `<tree-ish>` (most often a commit) is not given,
@@ -96,7 +96,7 @@ specific side of the merge can be checked out of the index by
 using `--ours` or `--theirs`.  With `-m`, changes made to the working tree
 file can be discarded to re-create the original conflicted merge result.
 
-'git checkout' (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
+`git checkout` (-p|--patch) [<tree-ish>] [--] [<pathspec>...]::
 	This is similar to the previous mode, but lets you use the
 	interactive interface to show the "diff" output and choose which
 	hunks to use in the result.  See below for the description of
@@ -151,7 +151,7 @@ of it").
 -B <new_branch>::
 	Creates the branch `<new_branch>` and start it at `<start_point>`;
 	if it already exists, then reset it to `<start_point>`. This is
-	equivalent to running "git branch" with `-f`; see
+	equivalent to running `git branch` with `-f`; see
 	linkgit:git-branch[1] for details.
 
 -t::
@@ -333,7 +333,7 @@ Note that this option uses the no overlay mode by default (see also
 	any branch (see below for details).
 +
 You can use the `@{-N}` syntax to refer to the N-th last
-branch/commit checked out using "git checkout" operation. You may
+branch/commit checked out using `git checkout` operation. You may
 also specify `-` which is synonymous to `@{-1}`.
 +
 As a special case, you may use `A...B` as a shortcut for the
@@ -384,7 +384,7 @@ a---b---c  branch 'master' (refers to commit 'c')
 ------------
 
 When a commit is created in this state, the branch is updated to refer to
-the new commit. Specifically, 'git commit' creates a new commit `d`, whose
+the new commit. Specifically, `git commit` creates a new commit `d`, whose
 parent is commit `c`, and then updates branch `master` to refer to new
 commit `d`. `HEAD` still refers to branch `master` and so indirectly now refers
 to commit `d`:
@@ -493,7 +493,7 @@ $ git tag foo           <3>
     leaving `HEAD` detached.
 
 If we have moved away from commit `f`, then we must first recover its object
-name (typically by using git reflog), and then we can create a reference to
+name (typically by using `git reflog`), and then we can create a reference to
 it. For example, to see the last two commits to which `HEAD` referred, we
 can use either of these commands:
 
diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index 6069cc77a0..fb12a67778 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -8,9 +8,9 @@ git-cherry-pick - Apply the changes introduced by some existing commits
 SYNOPSIS
 --------
 [verse]
-'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
+`git cherry-pick` [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
 		  [-S[<keyid>]] <commit>...
-'git cherry-pick' (--continue | --skip | --abort | --quit)
+`git cherry-pick` (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
 -----------
@@ -52,7 +52,7 @@ OPTIONS
 
 -e::
 --edit::
-	With this option, 'git cherry-pick' will let you edit the commit
+	With this option, `git cherry-pick` will let you edit the commit
 	message prior to committing.
 
 --cleanup=<mode>::
diff --git a/Documentation/git-cherry.txt b/Documentation/git-cherry.txt
index 4374f398fa..ab55060668 100644
--- a/Documentation/git-cherry.txt
+++ b/Documentation/git-cherry.txt
@@ -8,7 +8,7 @@ git-cherry - Find commits yet to be applied to upstream
 SYNOPSIS
 --------
 [verse]
-'git cherry' [-v] [<upstream> [<head> [<limit>]]]
+`git cherry` [-v] [<upstream> [<head> [<limit>]]]
 
 DESCRIPTION
 -----------
@@ -16,7 +16,7 @@ Determine whether there are commits in `<head>..<upstream>` that are
 equivalent to those in the range `<limit>..<head>`.
 
 The equivalence test is based on the diff, after removing whitespace
-and line numbers.  git-cherry therefore detects when commits have been
+and line numbers.  `git-cherry` therefore detects when commits have been
 "copied" by means of linkgit:git-cherry-pick[1], linkgit:git-am[1] or
 linkgit:git-rebase[1].
 
@@ -45,7 +45,7 @@ EXAMPLES
 Patch workflows
 ~~~~~~~~~~~~~~~
 
-git-cherry is frequently used in patch-based workflows (see
+`git-cherry` is frequently used in patch-based workflows (see
 linkgit:gitworkflows[7]) to determine if a series of patches has been
 applied by the upstream maintainer.  In such a workflow you might
 create and send a topic branch like this:
@@ -85,7 +85,7 @@ $ git log --graph --oneline --decorate --boundary origin/master...topic
 o 1234567 branch point
 ------------
 
-In such cases, git-cherry shows a concise summary of what has yet to
+In such cases, `git-cherry` shows a concise summary of what has yet to
 be applied:
 
 ------------
diff --git a/Documentation/git-citool.txt b/Documentation/git-citool.txt
index c7a11c36c1..f750f754ae 100644
--- a/Documentation/git-citool.txt
+++ b/Documentation/git-citool.txt
@@ -8,16 +8,16 @@ git-citool - Graphical alternative to git-commit
 SYNOPSIS
 --------
 [verse]
-'git citool'
+`git citool`
 
 DESCRIPTION
 -----------
 A Tcl/Tk based graphical interface to review modified files, stage
 them into the index, enter a commit message and record the new
 commit onto the current branch.  This interface is an alternative
-to the less interactive 'git commit' program.
+to the less interactive `git commit` program.
 
-'git citool' is actually a standard alias for `git gui citool`.
+`git citool` is actually a standard alias for `git gui citool`.
 See linkgit:git-gui[1] for more details.
 
 GIT
diff --git a/Documentation/git-clean.txt b/Documentation/git-clean.txt
index cbec3e649a..7923ae27a5 100644
--- a/Documentation/git-clean.txt
+++ b/Documentation/git-clean.txt
@@ -8,7 +8,7 @@ git-clean - Remove untracked files from the working tree
 SYNOPSIS
 --------
 [verse]
-'git clean' [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
+`git clean` [-d] [-f] [-i] [-n] [-q] [-e <pattern>] [-x | -X] [--] <path>...
 
 DESCRIPTION
 -----------
@@ -26,19 +26,19 @@ are affected.
 OPTIONS
 -------
 -d::
-	Normally, when no <path> is specified, git clean will not
+	Normally, when no <path> is specified, `git clean` will not
 	recurse into untracked directories to avoid removing too much.
 	Specify `-d` to have it recurse into such directories as well.
 	If any paths are specified, `-d` is irrelevant; all untracked
 	files matching the specified paths (with exceptions for nested
-	git directories mentioned under `--force`) will be removed.
+	`git` directories mentioned under `--force`) will be removed.
 
 -f::
 --force::
 	If the Git configuration variable `clean.requireForce` is not set
-	to false, 'git clean' will refuse to delete files or directories
+	to false, `git clean` will refuse to delete files or directories
 	unless given `-f` or `-i`.  Git will refuse to modify untracked
-	nested git repositories (directories with a .git subdirectory)
+	nested `git` repositories (directories with a .git subdirectory)
 	unless a second `-f` is given.
 
 -i::
@@ -65,7 +65,7 @@ OPTIONS
 	still use the ignore rules given with `-e` options from the command
 	line.  This allows removing all untracked
 	files, including build products.  This can be used (possibly in
-	conjunction with 'git restore' or 'git reset') to create a pristine
+	conjunction with `git restore` or `git reset`) to create a pristine
 	working directory to test a clean build.
 
 -X::
@@ -131,7 +131,7 @@ quit::
 
 help::
 
-  Show brief usage of interactive git-clean.
+  Show brief usage of interactive `git-clean`.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 8cd602a852..b8ca823467 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -9,7 +9,7 @@ git-clone - Clone a repository into a new directory
 SYNOPSIS
 --------
 [verse]
-'git clone' [--template=<template_directory>]
+`git clone` [--template=<template_directory>]
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
diff --git a/Documentation/git-column.txt b/Documentation/git-column.txt
index ab545fc52d..0865d22bdc 100644
--- a/Documentation/git-column.txt
+++ b/Documentation/git-column.txt
@@ -8,14 +8,14 @@ git-column - Display data in columns
 SYNOPSIS
 --------
 [verse]
-'git column' [--command=<name>] [--[raw-]mode=<mode>] [--width=<width>]
+`git column` [--command=<name>] [--[raw-]mode=<mode>] [--width=<width>]
 	     [--indent=<string>] [--nl=<string>] [--padding=<n>]
 
 DESCRIPTION
 -----------
 This command formats the lines of its standard input into a table with
 multiple columns. Each input line occupies one cell of the table. It
-is used internally by other git commands to format output into
+is used internally by other `git` commands to format output into
 columns.
 
 OPTIONS
diff --git a/Documentation/git-commit-graph.txt b/Documentation/git-commit-graph.txt
index e1f48c95b3..3246616b10 100644
--- a/Documentation/git-commit-graph.txt
+++ b/Documentation/git-commit-graph.txt
@@ -9,8 +9,8 @@ git-commit-graph - Write and verify Git commit-graph files
 SYNOPSIS
 --------
 [verse]
-'git commit-graph verify' [--object-dir <dir>] [--shallow] [--[no-]progress]
-'git commit-graph write' <options> [--object-dir <dir>] [--[no-]progress]
+`git commit-graph verify` [--object-dir <dir>] [--shallow] [--[no-]progress]
+`git commit-graph write` <options> [--object-dir <dir>] [--[no-]progress]
 
 
 DESCRIPTION
diff --git a/Documentation/git-commit-tree.txt b/Documentation/git-commit-tree.txt
index b76a825c94..48a76dd029 100644
--- a/Documentation/git-commit-tree.txt
+++ b/Documentation/git-commit-tree.txt
@@ -9,8 +9,8 @@ git-commit-tree - Create a new commit object
 SYNOPSIS
 --------
 [verse]
-'git commit-tree' <tree> [(-p <parent>)...]
-'git commit-tree' [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]
+`git commit-tree` <tree> [(-p <parent>)...]
+`git commit-tree` [(-p <parent>)...] [-S[<keyid>]] [(-m <message>)...]
 		  [(-F <file>)...] <tree>
 
 
@@ -77,7 +77,7 @@ A commit encapsulates:
 - committer name and email and the commit time.
 
 A commit comment is read from stdin. If a changelog
-entry is not provided via "<" redirection, 'git commit-tree' will just wait
+entry is not provided via "<" redirection, `git commit-tree` will just wait
 for one to be entered and terminated with ^D.
 
 include::date-formats.txt[]
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 6d10f2bdc7..3b22ba718c 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -8,7 +8,7 @@ git-commit - Record changes to the repository
 SYNOPSIS
 --------
 [verse]
-'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
+`git commit` [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
 	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
@@ -58,7 +58,7 @@ summary of what is included by any of the above for the next
 commit by giving the same set of parameters (options and paths).
 
 If you make a commit and then find a mistake immediately after
-that, you can recover from it with 'git reset'.
+that, you can recover from it with `git reset`.
 
 :git-commit: 1
 
@@ -310,7 +310,7 @@ FROM UPSTREAM REBASE" section in linkgit:git-rebase[1].)
 	of the paths specified on the
 	command line, disregarding any contents that have been
 	staged for other paths. This is the default mode of operation of
-	'git commit' if any paths are given on the command line,
+	`git commit` if any paths are given on the command line,
 	in which case this option can be omitted.
 	If this option is specified together with `--amend`, then
 	no paths need to be specified, which can be used to amend
@@ -409,10 +409,10 @@ EXAMPLES
 --------
 When recording your own work, the contents of modified files in
 your working tree are temporarily stored to a staging area
-called the "index" with 'git add'.  A file can be
+called the "index" with `git add`.  A file can be
 reverted back, only in the index but not in the working tree,
 to that of the last commit with `git restore --staged <file>`,
-which effectively reverts 'git add' and prevents the changes to
+which effectively reverts `git add` and prevents the changes to
 this file from participating in the next commit.  After building
 the state to be committed incrementally with these commands,
 `git commit` (without any pathname parameter) is used to record what
@@ -468,13 +468,13 @@ $ git commit
 this second commit would record the changes to `hello.c` and
 `hello.h` as expected.
 
-After a merge (initiated by 'git merge' or 'git pull') stops
+After a merge (initiated by `git merge` or `git pull`) stops
 because of conflicts, cleanly merged
 paths are already staged to be committed for you, and paths that
 conflicted are left in unmerged state.  You would have to first
-check which paths are conflicting with 'git status'
+check which paths are conflicting with `git status`
 and after fixing them manually in your working tree, you would
-stage the result as usual with 'git add':
+stage the result as usual with `git add`:
 
 ------------
 $ git status | grep unmerged
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 606411c816..85e02aff92 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,21 +9,21 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
-'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
-'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] [--fixed-value] --unset name [value-pattern]
-'git config' [<file-option>] [--fixed-value] --unset-all name [value-pattern]
-'git config' [<file-option>] --rename-section old_name new_name
-'git config' [<file-option>] --remove-section name
-'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
-'git config' [<file-option>] --get-color name [default]
-'git config' [<file-option>] --get-colorbool name [stdout-is-tty]
-'git config' [<file-option>] -e | --edit
+`git config` [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
+`git config` [<file-option>] [--type=<type>] --add name value
+`git config` [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
+`git config` [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
+`git config` [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
+`git config` [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
+`git config` [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
+`git config` [<file-option>] [--fixed-value] --unset name [value-pattern]
+`git config` [<file-option>] [--fixed-value] --unset-all name [value-pattern]
+`git config` [<file-option>] --rename-section old_name new_name
+`git config` [<file-option>] --remove-section name
+`git config` [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
+`git config` [<file-option>] --get-color name [default]
+`git config` [<file-option>] --get-colorbool name [stdout-is-tty]
+`git config` [<file-option>] -e | --edit
 
 DESCRIPTION
 -----------
@@ -41,7 +41,7 @@ prepend a single exclamation mark in front (see also <<EXAMPLES>>),
 but note that this only works when the `--fixed-value` option is not
 in use.
 
-The `--type=<type>` option instructs 'git config' to ensure that incoming and
+The `--type=<type>` option instructs `git config` to ensure that incoming and
 outgoing values are canonicalize-able under the given <type>.  If no
 `--type=<type>` is given, no canonicalization will be performed. Callers may
 unset an existing `--type` specifier with `--no-type`.
@@ -175,7 +175,7 @@ See also <<FILES>>.
 	is exactly equal to the `value-pattern`.
 
 --type <type>::
-  'git config' will ensure that any input or output is valid under the given
+  `git config` will ensure that any input or output is valid under the given
   type constraint(s), and will canonicalize outgoing values in `<type>`'s
   canonical form.
 +
@@ -209,7 +209,7 @@ Valid `<type>`'s include:
 
 --no-type::
   Un-sets the previously set type specifier (if one was previously set). This
-  option requests that 'git config' not canonicalize the retrieved variable.
+  option requests that `git config` not canonicalize the retrieved variable.
   `--no-type` has no effect without `--type=<type>` or `--<type>`.
 
 -z::
@@ -284,7 +284,7 @@ FILES
 -----
 
 If not set explicitly with `--file`, there are four files where
-'git config' will search for configuration options:
+`git config` will search for configuration options:
 
 $(prefix)/etc/gitconfig::
 	System-wide configuration file.
@@ -311,7 +311,7 @@ $GIT_DIR/config.worktree::
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
 file are not available they will be ignored. If the repository configuration
-file is not available or readable, 'git config' will exit with a non-zero
+file is not available or readable, `git config` will exit with a non-zero
 error code. However, in neither case will an error message be issued.
 
 The files are read in the order given above, with last value found taking
@@ -358,7 +358,7 @@ GIT_CONFIG_VALUE_<n>::
 	in configuration files, but will be overridden by any explicit options
 	passed via `git -c`.
 +
-This is useful for cases where you want to spawn multiple git commands
+This is useful for cases where you want to spawn multiple `git` commands
 with a common configuration but cannot depend on a configuration file,
 for example when writing scripts.
 
diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
index d12ce08789..a52bd618c4 100644
--- a/Documentation/git-count-objects.txt
+++ b/Documentation/git-count-objects.txt
@@ -8,7 +8,7 @@ git-count-objects - Count unpacked number of objects and their disk consumption
 SYNOPSIS
 --------
 [verse]
-'git count-objects' [-v] [-H | --human-readable]
+`git count-objects` [-v] [-H | --human-readable]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-credential-cache--daemon.txt b/Documentation/git-credential-cache--daemon.txt
index 7051c6bdf8..ed4d4c4f35 100644
--- a/Documentation/git-credential-cache--daemon.txt
+++ b/Documentation/git-credential-cache--daemon.txt
@@ -8,7 +8,7 @@ git-credential-cache--daemon - Temporarily store user credentials in memory
 SYNOPSIS
 --------
 [verse]
-git credential-cache--daemon [--debug] <socket>
+`git credential-cache--daemon` [--debug] <socket>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-credential-cache.txt b/Documentation/git-credential-cache.txt
index b1a9d9b29a..e9834b8b95 100644
--- a/Documentation/git-credential-cache.txt
+++ b/Documentation/git-credential-cache.txt
@@ -8,7 +8,7 @@ git-credential-cache - Helper to temporarily store passwords in memory
 SYNOPSIS
 --------
 -----------------------------
-git config credential.helper 'cache [<options>]'
+`git config` credential.helper 'cache [<options>]'
 -----------------------------
 
 DESCRIPTION
diff --git a/Documentation/git-credential-store.txt b/Documentation/git-credential-store.txt
index 76b0798856..376b0d6c5f 100644
--- a/Documentation/git-credential-store.txt
+++ b/Documentation/git-credential-store.txt
@@ -8,7 +8,7 @@ git-credential-store - Helper to store credentials on disk
 SYNOPSIS
 --------
 -------------------
-git config credential.helper 'store [<options>]'
+`git config` credential.helper 'store [<options>]'
 -------------------
 
 DESCRIPTION
@@ -45,7 +45,7 @@ FILES
 -----
 
 If not set explicitly with `--file`, there are two files where
-git-credential-store will search for credentials in order of precedence:
+`git-credential-store` will search for credentials in order of precedence:
 
 ~/.git-credentials::
 	User-specific credentials file.
diff --git a/Documentation/git-credential.txt b/Documentation/git-credential.txt
index 31c81c4c02..9bfcb3f90a 100644
--- a/Documentation/git-credential.txt
+++ b/Documentation/git-credential.txt
@@ -8,7 +8,7 @@ git-credential - Retrieve and store user credentials
 SYNOPSIS
 --------
 ------------------
-git credential <fill|approve|reject>
+`git credential` <fill|approve|reject>
 ------------------
 
 DESCRIPTION
@@ -16,28 +16,28 @@ DESCRIPTION
 
 Git has an internal interface for storing and retrieving credentials
 from system-specific helpers, as well as prompting the user for
-usernames and passwords. The git-credential command exposes this
+usernames and passwords. The `git-credential` command exposes this
 interface to scripts which may want to retrieve, store, or prompt for
 credentials in the same manner as Git. The design of this scriptable
 interface models the internal C API; see credential.h for more
 background on the concepts.
 
-git-credential takes an "action" option on the command-line (one of
+`git-credential` takes an "action" option on the command-line (one of
 `fill`, `approve`, or `reject`) and reads a credential description
 on stdin (see <<IOFMT,INPUT/OUTPUT FORMAT>>).
 
-If the action is `fill`, git-credential will attempt to add "username"
+If the action is `fill`, `git-credential` will attempt to add "username"
 and "password" attributes to the description by reading config files,
 by contacting any configured credential helpers, or by prompting the
 user. The username and password attributes of the credential
 description are then printed to stdout together with the attributes
 already provided.
 
-If the action is `approve`, git-credential will send the description
+If the action is `approve`, `git-credential` will send the description
 to any configured credential helpers, which may store the credential
 for later use.
 
-If the action is `reject`, git-credential will send the description to
+If the action is `reject`, `git-credential` will send the description to
 any configured credential helpers, which may erase any stored
 credential matching the description.
 
@@ -46,7 +46,7 @@ If the action is `approve` or `reject`, no output should be emitted.
 TYPICAL USE OF GIT CREDENTIAL
 -----------------------------
 
-An application using git-credential will typically use `git
+An application using `git-credential` will typically use `git
 credential` following these steps:
 
   1. Generate a credential description based on the context.
@@ -61,7 +61,7 @@ information it has):
 	 host=example.com
 	 path=foo.git
 
-  2. Ask git-credential to give us a username and password for this
+  2. Ask `git-credential` to give us a username and password for this
      description. This is done by running `git credential fill`,
      feeding the description from step (1) to its standard input. The complete
      credential description (including the credential per se, i.e. the
diff --git a/Documentation/git-cvsexportcommit.txt b/Documentation/git-cvsexportcommit.txt
index 76b16f9dae..596512ec73 100644
--- a/Documentation/git-cvsexportcommit.txt
+++ b/Documentation/git-cvsexportcommit.txt
@@ -9,7 +9,7 @@ git-cvsexportcommit - Export a single commit to a CVS checkout
 SYNOPSIS
 --------
 [verse]
-'git cvsexportcommit' [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot]
+`git cvsexportcommit` [-h] [-u] [-v] [-c] [-P] [-p] [-a] [-d cvsroot]
 	[-w cvsworkdir] [-W] [-f] [-m msgprefix] [PARENTCOMMIT] COMMITID
 
 
@@ -28,7 +28,7 @@ by default.
 
 Supports file additions, removals, and commits that affect binary files.
 
-If the commit is a merge commit, you must tell 'git cvsexportcommit' what
+If the commit is a merge commit, you must tell `git cvsexportcommit` what
 parent the changeset should be done against.
 
 OPTIONS
diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index 95fa94de74..586184bbd4 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -9,7 +9,7 @@ git-cvsimport - Salvage your data out of another SCM people love to hate
 SYNOPSIS
 --------
 [verse]
-'git cvsimport' [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
+`git cvsimport` [-o <branch-for-HEAD>] [-h] [-v] [-d <CVSROOT>]
 	      [-A <author-conv-file>] [-p <options-for-cvsps>] [-P <file>]
 	      [-C <git_repository>] [-z <fuzz>] [-i] [-k] [-u] [-s <subst>]
 	      [-a] [-m] [-M <regex>] [-S <regex>] [-L <commitlimit>]
@@ -34,9 +34,9 @@ At least version 2.1 is required.
 Please see the section <<issues,ISSUES>> for further reference.
 
 You should *never* do any work of your own on the branches that are
-created by 'git cvsimport'.  By default initial import will create and populate a
+created by `git cvsimport`.  By default initial import will create and populate a
 `master` branch from the CVS repository's main branch which you're free
-to work with; after that, you need to 'git merge' incremental imports, or
+to work with; after that, you need to `git merge` incremental imports, or
 any CVS branches, yourself.  It is advisable to specify a named remote via
 `-r` to separate and protect the incoming branches.
 
@@ -55,13 +55,13 @@ OPTIONS
 -d <CVSROOT>::
 	The root of the CVS archive. May be local (a simple path) or remote;
 	currently, only the :local:, :ext: and :pserver: access methods
-	are supported. If not given, 'git cvsimport' will try to read it
+	are supported. If not given, `git cvsimport` will try to read it
 	from `CVS/Root`. If no such file exists, it checks for the
 	`CVSROOT` environment variable.
 
 <CVS_module>::
 	The CVS module you want to import. Relative to <CVSROOT>.
-	If not given, 'git cvsimport' tries to read it from
+	If not given, `git cvsimport` tries to read it from
 	`CVS/Repository`.
 
 -C <target-dir>::
@@ -71,14 +71,14 @@ OPTIONS
 -r <remote>::
 	The Git remote to import this CVS repository into.
 	Moves all CVS branches into remotes/<remote>/<branch>
-	akin to the way 'git clone' uses `origin` by default.
+	akin to the way `git clone` uses `origin` by default.
 
 -o <branch-for-HEAD>::
 	When no remote is specified (via `-r`) the `HEAD` branch
 	from CVS is imported to the `origin` branch within the Git
 	repository, as `HEAD` already has a special meaning for Git.
 	When a remote is specified the `HEAD` branch is named
-	remotes/<remote>/master mirroring 'git clone' behaviour.
+	remotes/<remote>/master mirroring `git clone` behaviour.
 	Use this option if you want to import into a different
 	branch.
 +
@@ -152,18 +152,18 @@ This option can be used several times to provide several detection regexes.
 
 ---------
 +
-'git cvsimport' will make it appear as those authors had
+`git cvsimport` will make it appear as those authors had
 their GIT_AUTHOR_NAME and GIT_AUTHOR_EMAIL set properly
 all along.  If a time zone is specified, GIT_AUTHOR_DATE will
 have the corresponding offset applied.
 +
 For convenience, this data is saved to `$GIT_DIR/cvs-authors`
 each time the `-A` option is provided and read from that same
-file each time 'git cvsimport' is run.
+file each time `git cvsimport` is run.
 +
 It is not recommended to use this feature if you intend to
 export changes back to CVS again later with
-'git cvsexportcommit'.
+`git cvsexportcommit`.
 
 -R::
 	Generate a `$GIT_DIR/cvs-revisions` file containing a mapping from CVS
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index c6a926d8d2..bf53d16a7f 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -17,12 +17,12 @@ export CVS_SERVER="git cvsserver"
 pserver (/etc/inetd.conf):
 
 [verse]
-cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver git-cvsserver pserver
+cvspserver stream tcp nowait nobody /usr/bin/git-cvsserver `git-cvsserver` pserver
 
 Usage:
 
 [verse]
-'git-cvsserver' [<options>] [pserver|server] [<directory> ...]
+`git-cvsserver` [<options>] [pserver|server] [<directory> ...]
 
 OPTIONS
 -------
@@ -74,7 +74,7 @@ LIMITATIONS
 
 CVS clients cannot tag, branch or perform Git merges.
 
-'git-cvsserver' maps Git branches to CVS modules. This is very different
+`git-cvsserver` maps Git branches to CVS modules. This is very different
 from what most CVS users would expect since in CVS modules usually represent
 one or more directories.
 
@@ -132,7 +132,7 @@ Then provide your password via the pserver method, for example:
 ------
 No special setup is needed for SSH access, other than having Git tools
 in the PATH. If you have clients that do not accept the CVS_SERVER
-environment variable, you can rename 'git-cvsserver' to `cvs`.
+environment variable, you can rename `git-cvsserver` to `cvs`.
 
 Note: Newer CVS versions (>= 1.12.11) also support specifying
 CVS_SERVER directly in CVSROOT like
@@ -142,9 +142,9 @@ cvs -d ":ext;CVS_SERVER=git cvsserver:user@server/path/repo.git" co <HEAD_name>
 ------
 This has the advantage that it will be saved in your 'CVS/Root' files and
 you don't need to worry about always setting the correct environment
-variable.  SSH users restricted to 'git-shell' don't need to override the default
-with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
-'git-cvsserver' and pretends that the other end runs the real 'cvs' better.
+variable.  SSH users restricted to `git-shell` don't need to override the default
+with CVS_SERVER (and shouldn't) as `git-shell` understands `cvs` to mean
+`git-cvsserver` and pretends that the other end runs the real 'cvs' better.
 --
 2. For each repo that you want accessible from CVS you need to edit config in
    the repo and add the following section.
@@ -157,7 +157,7 @@ with CVS_SERVER (and shouldn't) as 'git-shell' understands `cvs` to mean
 	logFile=/path/to/logfile
 
 ------
-Note: you need to ensure each user that is going to invoke 'git-cvsserver' has
+Note: you need to ensure each user that is going to invoke `git-cvsserver` has
 write access to the log file and to the database (see
 <<dbbackend,Database Backend>>. If you want to offer write access over
 SSH, the users of course also need write access to the Git repository itself.
@@ -182,7 +182,7 @@ allowing access over SSH.
    automatically saving it in your 'CVS/Root' files, then you need to set them
    explicitly in your environment.  CVSROOT should be set as per normal, but the
    directory should point at the appropriate Git repo.  As above, for SSH clients
-   _not_ restricted to 'git-shell', CVS_SERVER should be set to 'git-cvsserver'.
+   _not_ restricted to `git-shell`, CVS_SERVER should be set to `git-cvsserver`.
 +
 --
 ------
@@ -210,32 +210,32 @@ allowing access over SSH.
 DATABASE BACKEND
 ----------------
 
-'git-cvsserver' uses one database per Git head (i.e. CVS module) to
+`git-cvsserver` uses one database per Git head (i.e. CVS module) to
 store information about the repository to maintain consistent
 CVS revision numbers. The database needs to be
 updated (i.e. written to) after every commit.
 
 If the commit is done directly by using `git` (as opposed to
-using 'git-cvsserver') the update will need to happen on the
-next repository access by 'git-cvsserver', independent of
+using `git-cvsserver`) the update will need to happen on the
+next repository access by `git-cvsserver`, independent of
 access method and requested operation.
 
 That means that even if you offer only read access (e.g. by using
-the pserver method), 'git-cvsserver' should have write access to
+the pserver method), `git-cvsserver` should have write access to
 the database to work reliably (otherwise you need to make sure
-that the database is up to date any time 'git-cvsserver' is executed).
+that the database is up to date any time `git-cvsserver` is executed).
 
 By default it uses SQLite databases in the Git directory, named
 `gitcvs.<module_name>.sqlite`. Note that the SQLite backend creates
 temporary files in the same directory as the database file on
 write so it might not be enough to grant the users using
-'git-cvsserver' write access to the database file without granting
+`git-cvsserver` write access to the database file without granting
 them write access to the directory, too.
 
 The database cannot be reliably regenerated in a
 consistent form after the branch it is tracking has changed.
-Example: For merged branches, 'git-cvsserver' only tracks
-one branch of development, and after a 'git merge' an
+Example: For merged branches, `git-cvsserver` only tracks
+one branch of development, and after a `git merge` an
 incrementally updated database may track a different branch
 than a database regenerated from scratch, causing inconsistent
 CVS revision numbers. `git-cvsserver` has no way of knowing which
@@ -250,7 +250,7 @@ configuration variables:
 Configuring database backend
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-'git-cvsserver' uses the Perl DBI module. Please also read
+`git-cvsserver` uses the Perl DBI module. Please also read
 its documentation if changing these variables, especially
 about `DBI->connect()`.
 
@@ -302,7 +302,7 @@ In `dbDriver` and `dbUser` you can use the following variables:
 %a::
 	access method (one of "ext" or "pserver")
 %u::
-	Name of the user running 'git-cvsserver'.
+	Name of the user running `git-cvsserver`.
 	If no name can be determined, the
 	numeric uid is used.
 
@@ -310,13 +310,13 @@ ENVIRONMENT
 -----------
 
 These variables obviate the need for command-line options in some
-circumstances, allowing easier restricted usage through git-shell.
+circumstances, allowing easier restricted usage through `git-shell`.
 
 GIT_CVSSERVER_BASE_PATH takes the place of the argument to `--base-path`.
 
 GIT_CVSSERVER_ROOT specifies a single-directory whitelist. The
 repository must still be configured to allow access through
-git-cvsserver, as described above.
+`git-cvsserver`, as described above.
 
 When these environment variables are set, the corresponding
 command-line arguments may not be used.
@@ -343,8 +343,8 @@ you will definitely want to have SSH keys setup.
 
 Alternatively, you can just use the non-standard extssh protocol that Eclipse
 offer. In that case CVS_SERVER is ignored, and you will have to replace
-the cvs utility on the server with 'git-cvsserver' or manipulate your `.bashrc`
-so that calling 'cvs' effectively calls 'git-cvsserver'.
+the cvs utility on the server with `git-cvsserver` or manipulate your `.bashrc`
+so that calling 'cvs' effectively calls `git-cvsserver`.
 
 CLIENTS KNOWN TO WORK
 ---------------------
@@ -361,12 +361,12 @@ All the operations required for normal use are supported, including
 checkout, diff, status, update, log, add, remove, commit.
 
 Most CVS command arguments that read CVS tags or revision numbers
-(typically `-r`) work, and also support any git refspec
+(typically `-r`) work, and also support any `git` refspec
 (tag, branch, commit ID, etc).
 However, CVS revision numbers for non-default branches are not well
 emulated, and cvs log does not show tags or branches at
 all.  (Non-main-branch CVS revision numbers superficially resemble CVS
-revision numbers, but they actually encode a git commit ID directly,
+revision numbers, but they actually encode a `git` commit ID directly,
 rather than represent the number of revisions since the branch point.)
 
 Note that there are two ways to checkout a particular branch.
@@ -383,9 +383,9 @@ operations against that main branch are fast.  Or alternatively,
 -r doesn't take any extra disk space, but may be significantly slower for
 many operations, like cvs update.
 
-If you want to refer to a git refspec that has characters that are
+If you want to refer to a `git` refspec that has characters that are
 not allowed by CVS, you have two options.  First, it may just work
-to supply the git refspec directly to the appropriate CVS `-r` argument;
+to supply the `git` refspec directly to the appropriate CVS `-r` argument;
 some CVS clients don't seem to do much sanity checking of the argument.
 Second, if that fails, you can use a special character escape mechanism
 that only uses characters that are valid in CVS tags.  A sequence
@@ -426,7 +426,7 @@ and `gitcvs.allBinary` to "guess".
 
 DEPENDENCIES
 ------------
-'git-cvsserver' depends on DBD::SQLite.
+`git-cvsserver` depends on DBD::SQLite.
 
 GIT
 ---
diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index 2794a2d0c1..e9cce4e468 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -8,7 +8,7 @@ git-daemon - A really simple server for Git repositories
 SYNOPSIS
 --------
 [verse]
-'git daemon' [--verbose] [--syslog] [--export-all]
+`git daemon` [--verbose] [--syslog] [--export-all]
 	     [--timeout=<n>] [--init-timeout=<n>] [--max-connections=<n>]
 	     [--strict-paths] [--base-path=<path>] [--base-path-relaxed]
 	     [--user-path | --user-path=<path>]
@@ -29,39 +29,39 @@ A really simple TCP Git daemon that normally listens on port "DEFAULT_GIT_PORT"
 aka 9418.  It waits for a connection asking for a service, and will serve
 that service if it is enabled.
 
-It verifies that the directory has the magic file "git-daemon-export-ok", and
+It verifies that the directory has the magic file `git-daemon-export-ok`, and
 it will refuse to export any Git directory that hasn't explicitly been marked
 for export this way (unless the `--export-all` parameter is specified). If you
-pass some directory paths as 'git daemon' arguments, you can further restrict
+pass some directory paths as `git daemon` arguments, you can further restrict
 the offers to a whitelist comprising of those.
 
 By default, only `upload-pack` service is enabled, which serves
-'git fetch-pack' and 'git ls-remote' clients, which are invoked
-from 'git fetch', 'git pull', and 'git clone'.
+`git fetch-pack` and `git ls-remote` clients, which are invoked
+from `git fetch`, `git pull`, and `git clone`.
 
 This is ideally suited for read-only updates, i.e., pulling from
 Git repositories.
 
-An `upload-archive` also exists to serve 'git archive'.
+An `upload-archive` also exists to serve `git archive`.
 
 OPTIONS
 -------
 --strict-paths::
 	Match paths exactly (i.e. don't allow "/foo/repo" when the real path is
 	"/foo/repo.git" or "/foo/repo/.git") and don't do user-relative paths.
-	'git daemon' will refuse to start when this option is enabled and no
+	`git daemon` will refuse to start when this option is enabled and no
 	whitelist is specified.
 
 --base-path=<path>::
 	Remap all the path requests as relative to the given path.
-	This is sort of "Git root" - if you run 'git daemon' with
+	This is sort of "Git root" - if you run `git daemon` with
 	`--base-path=/srv/git` on example.com, then if you later try to pull
-	'git://example.com/hello.git', 'git daemon' will interpret the path
+	'git://example.com/hello.git', `git daemon` will interpret the path
 	as `/srv/git/hello.git`.
 
 --base-path-relaxed::
 	If `--base-path` is enabled and repo lookup fails, with this option
-	'git daemon' will attempt to lookup without prefixing the base path.
+	`git daemon` will attempt to lookup without prefixing the base path.
 	This is useful for switching to `--base-path` usage, while still
 	allowing the old paths.
 
@@ -78,7 +78,7 @@ OPTIONS
 --export-all::
 	Allow pulling from all directories that look like Git repositories
 	(have the 'objects' and 'refs' subdirectories), even if they
-	do not have the 'git-daemon-export-ok' file.
+	do not have the `git-daemon-export-ok` file.
 
 --inetd::
 	Have the server run as an inetd service. Implies `--syslog` (may be
@@ -170,10 +170,10 @@ otherwise `stderr`.
 +
 Giving these options is an error when used with `--inetd`; use
 the facility of inet daemon to achieve the same before spawning
-'git daemon' if needed.
+`git daemon` if needed.
 +
 Like many programs that switch user id, the daemon does not reset
-environment variables such as `$HOME` when it runs git programs,
+environment variables such as `$HOME` when it runs `git` programs,
 e.g. `upload-pack` and `receive-pack`. When using this option, you
 may also want to set and export `HOME` to point at the home
 directory of `<user>` before starting the daemon, and make sure any
@@ -194,7 +194,7 @@ Git configuration files in that directory are readable by `<user>`.
 	may be overridden.
 
 --[no-]informative-errors::
-	When informative errors are turned on, git-daemon will report
+	When informative errors are turned on, `git-daemon` will report
 	more verbose errors to the client, differentiating conditions
 	like "no such repository" from "repository not exported". This
 	is more convenient for clients, but may leak information about
@@ -227,24 +227,24 @@ SERVICES
 
 These services can be globally enabled/disabled using the
 command-line options of this command.  If finer-grained
-control is desired (e.g. to allow 'git archive' to be run
+control is desired (e.g. to allow `git archive` to be run
 against only in a few selected repositories the daemon serves),
 the per-repository configuration file can be used to enable or
 disable them.
 
 upload-pack::
-	This serves 'git fetch-pack' and 'git ls-remote'
+	This serves `git fetch-pack` and `git ls-remote`
 	clients.  It is enabled by default, but a repository can
 	disable it by setting `daemon.uploadpack` configuration
 	item to `false`.
 
 upload-archive::
-	This serves 'git archive --remote'.  It is disabled by
+	This serves `git archive --remote`.  It is disabled by
 	default, but a repository can enable it by setting
 	`daemon.uploadarch` configuration item to `true`.
 
 receive-pack::
-	This serves 'git send-pack' clients, allowing anonymous
+	This serves `git send-pack` clients, allowing anonymous
 	push.  It is disabled by default, as there is _no_
 	authentication in the protocol (in other words, anybody
 	can push anything into the repository, including removal
@@ -262,8 +262,8 @@ $ grep 9418 /etc/services
 git		9418/tcp		# Git Version Control System
 ------------
 
-'git daemon' as inetd server::
-	To set up 'git daemon' as an inetd service that handles any
+`git daemon` as inetd server::
+	To set up `git daemon` as an inetd service that handles any
 	repository under the whitelisted set of directories, /pub/foo
 	and /pub/bar, place an entry like the following into
 	/etc/inetd all on one line:
@@ -275,8 +275,8 @@ git		9418/tcp		# Git Version Control System
 ------------------------------------------------
 
 
-'git daemon' as inetd server for virtual hosts::
-	To set up 'git daemon' as an inetd service that handles
+`git daemon` as inetd server for virtual hosts::
+	To set up `git daemon` as an inetd service that handles
 	repositories for different virtual hosts, `www.example.com`
 	and `www.example.org`, place an entry like the following into
 	`/etc/inetd` all on one line:
@@ -298,8 +298,8 @@ clients, a symlink from `/software` into the appropriate
 default repository could be made as well.
 
 
-'git daemon' as regular daemon for virtual hosts::
-	To set up 'git daemon' as a regular, non-inetd service that
+`git daemon` as regular daemon for virtual hosts::
+	To set up `git daemon` as a regular, non-inetd service that
 	handles repositories for multiple virtual hosts based on
 	their IP addresses, start the daemon like this:
 +
@@ -316,7 +316,7 @@ Repositories can still be accessed by hostname though, assuming
 they correspond to these IP addresses.
 
 selectively enable/disable services per repository::
-	To enable 'git archive --remote' and disable 'git fetch' against
+	To enable `git archive --remote` and disable `git fetch` against
 	a repository, have the following in the configuration file in the
 	repository (that is the file 'config' next to `HEAD`, 'refs' and
 	'objects').
@@ -330,7 +330,7 @@ selectively enable/disable services per repository::
 
 ENVIRONMENT
 -----------
-'git daemon' will set REMOTE_ADDR to the IP address of the client
+`git daemon` will set REMOTE_ADDR to the IP address of the client
 that connected to it, if the IP address is available. REMOTE_ADDR will
 be available in the environment of hooks called when
 services are performed.
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index 7d2649c477..6cfb444444 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -8,9 +8,9 @@ git-describe - Give an object a human readable name based on an available ref
 SYNOPSIS
 --------
 [verse]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
-'git describe' [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
-'git describe' <blob>
+`git describe` [--all] [--tags] [--contains] [--abbrev=<n>] [<commit-ish>...]
+`git describe` [--all] [--tags] [--contains] [--abbrev=<n>] --dirty[=<mark>]
+`git describe` <blob>
 
 DESCRIPTION
 -----------
@@ -20,7 +20,7 @@ shown.  Otherwise, it suffixes the tag name with the number of
 additional commits on top of the tagged object and the
 abbreviated object name of the most recent commit. The result
 is a "human-readable" object name which can also be used to
-identify the commit to other git commands.
+identify the commit to other `git` commands.
 
 By default (without `--all` or `--tags`) `git describe` only shows
 annotated tags.  For more information about creating annotated tags
@@ -40,8 +40,8 @@ OPTIONS
 --dirty[=<mark>]::
 --broken[=<mark>]::
 	Describe the state of the working tree.  When the working
-	tree matches `HEAD`, the output is the same as "git describe
-	HEAD".  If the working tree has local modification "-dirty"
+	tree matches `HEAD`, the output is the same as `git describe
+	HEAD`.  If the working tree has local modification "-dirty"
 	is appended to it.  If a repository is corrupt and Git
 	cannot determine if there is local modification, Git will
 	error out, unless `--broken' is given, which appends
@@ -138,14 +138,14 @@ an abbreviated object name for the commit itself ("2414721")
 at the end.
 
 The number of additional commits is the number
-of commits which would be displayed by "git log v1.0.4..parent".
+of commits which would be displayed by `git log v1.0.4..parent`.
 The hash suffix is "-g" + unambiguous abbreviation for the tip commit
 of parent (which was `2414721b194453f058079d897d13c4e377f92dc6`).
-The "g" prefix stands for "git" and is used to allow describing the version of
+The "g" prefix stands for `git` and is used to allow describing the version of
 a software depending on the SCM the software is managed with. This is useful
 in an environment where people may use different SCMs.
 
-Doing a 'git describe' on a tag-name will just show the tag name:
+Doing a `git describe` on a tag-name will just show the tag name:
 
 	[torvalds@g5 git]$ git describe v1.0.4
 	v1.0.4
@@ -175,13 +175,13 @@ be sufficient to disambiguate these commits.
 SEARCH STRATEGY
 ---------------
 
-For each commit-ish supplied, 'git describe' will first look for
+For each commit-ish supplied, `git describe` will first look for
 a tag which tags exactly that commit.  Annotated tags will always
 be preferred over lightweight tags, and tags with newer dates will
 always be preferred over tags with older dates.  If an exact match
 is found, its name will be output and searching will stop.
 
-If an exact match was not found, 'git describe' will walk back
+If an exact match was not found, `git describe` will walk back
 through the commit history to locate an ancestor commit which
 has been tagged.  The ancestor's tag will be output along with an
 abbreviation of the input commit-ish's SHA-1. If `--first-parent` was
diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index 906774f0f7..b0fb276b99 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,14 +9,14 @@ git-diff-files - Compares files in the working tree and the index
 SYNOPSIS
 --------
 [verse]
-'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
+`git diff-files` [-q] [-0|-1|-2|-3|-c|--cc] [<common diff options>] [<path>...]
 
 DESCRIPTION
 -----------
 Compares the files in the working tree and the index.  When paths
 are specified, compares only those named paths.  Otherwise all
 entries in the index are compared.  The output format is the
-same as for 'git diff-index' and 'git diff-tree'.
+same as for `git diff-index` and `git diff-tree`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-diff-index.txt b/Documentation/git-diff-index.txt
index 10e79a29aa..87db234e77 100644
--- a/Documentation/git-diff-index.txt
+++ b/Documentation/git-diff-index.txt
@@ -9,7 +9,7 @@ git-diff-index - Compare a tree to the working tree or index
 SYNOPSIS
 --------
 [verse]
-'git diff-index' [-m] [--cached] [--merge-base] [<common diff options>] <tree-ish> [<path>...]
+`git diff-index` [-m] [--cached] [--merge-base] [<common diff options>] <tree-ish> [<path>...]
 
 DESCRIPTION
 -----------
@@ -37,7 +37,7 @@ include::diff-options.txt[]
 -m::
 	By default, files recorded in the index but not checked
 	out are reported as deleted.  This flag makes
-	'git diff-index' say that all non-checked-out files are up
+	`git diff-index` say that all non-checked-out files are up
 	to date.
 
 include::diff-format.txt[]
@@ -54,7 +54,7 @@ CACHED MODE
 If `--cached` is specified, it allows you to ask:
 
 	show me the differences between `HEAD` and the current index
-	contents (the ones I'd write using 'git write-tree')
+	contents (the ones I'd write using `git write-tree`)
 
 For example, let's say that you have worked on your working directory, updated
 some files in the index and are ready to commit. You want to see exactly
@@ -66,7 +66,7 @@ object and compare it that way, and to do that, you just do
 Example: let's say I had renamed `commit.c` to `git-commit.c`, and I had
 done an `update-index` to make that effective in the index file.
 `git diff-files` wouldn't show anything at all, since the index file
-matches my working directory. But doing a 'git diff-index' does:
+matches my working directory. But doing a `git diff-index` does:
 
   torvalds@ppc970:~/git> git diff-index --cached HEAD
   -100644 blob    4161aecc6700a2eb579e842af0b7f22b98443f74        commit.c
@@ -75,7 +75,7 @@ matches my working directory. But doing a 'git diff-index' does:
 You can see easily that the above is a rename.
 
 In fact, `git diff-index --cached` *should* always be entirely equivalent to
-actually doing a 'git write-tree' and comparing that. Except this one is much
+actually doing a `git write-tree` and comparing that. Except this one is much
 nicer for the case where you just want to check where you are.
 
 So doing a `git diff-index --cached` is basically very useful when you are
@@ -86,20 +86,20 @@ NON-CACHED MODE
 ---------------
 The "non-cached" mode takes a different approach, and is potentially
 the more useful of the two in that what it does can't be emulated with
-a 'git write-tree' + 'git diff-tree'. Thus that's the default mode.
+a `git write-tree` + `git diff-tree`. Thus that's the default mode.
 The non-cached version asks the question:
 
   show me the differences between `HEAD` and the currently checked out
   tree - index contents _and_ files that aren't up to date
 
 which is obviously a very useful question too, since that tells you what
-you *could* commit. Again, the output matches the 'git diff-tree -r'
+you *could* commit. Again, the output matches the `git diff-tree -r`
 output to a tee, but with a twist.
 
 The twist is that if some file doesn't match the index, we don't have
 a backing store thing for it, and we use the magic "all-zero" sha1 to
 show that. So let's say that you have edited `kernel/sched.c`, but
-have not actually done a 'git update-index' on it yet - there is no
+have not actually done a `git update-index` on it yet - there is no
 "object" associated with the new state, and you get:
 
   torvalds@ppc970:~/v2.6/linux> git diff-index --abbrev HEAD
@@ -110,11 +110,11 @@ not up to date and may contain new stuff. The all-zero sha1 means that to
 get the real diff, you need to look at the object in the working directory
 directly rather than do an object-to-object diff.
 
-NOTE: As with other commands of this type, 'git diff-index' does not
+NOTE: As with other commands of this type, `git diff-index` does not
 actually look at the contents of the file at all. So maybe
 `kernel/sched.c` hasn't actually changed, and it's just that you
 touched it. In either case, it's a note that you need to
-'git update-index' it to make the index be in sync.
+`git update-index` it to make the index be in sync.
 
 NOTE: You can have a mixture of files show up as "has been updated"
 and "is still dirty in the working directory" together. You can always
diff --git a/Documentation/git-diff-tree.txt b/Documentation/git-diff-tree.txt
index b9225cd824..56354886a4 100644
--- a/Documentation/git-diff-tree.txt
+++ b/Documentation/git-diff-tree.txt
@@ -9,7 +9,7 @@ git-diff-tree - Compares the content and mode of blobs found via two tree object
 SYNOPSIS
 --------
 [verse]
-'git diff-tree' [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
+`git diff-tree` [--stdin] [-m] [-s] [-v] [--no-commit-id] [--pretty]
 	      [-t] [-r] [-c | --cc] [--combined-all-paths] [--root] [--merge-base]
 	      [<common diff options>] <tree-ish> [<tree-ish>] [<path>...]
 
@@ -20,7 +20,7 @@ Compares the content and mode of the blobs found via two tree objects.
 If there is only one <tree-ish> given, the commit is compared with its parents
 (see `--stdin` below).
 
-Note that 'git diff-tree' can use the tree encapsulated in a commit object.
+Note that `git diff-tree` can use the tree encapsulated in a commit object.
 
 OPTIONS
 -------
@@ -69,25 +69,25 @@ The following flags further affect the behavior when comparing
 commits (but not trees).
 
 -m::
-	By default, 'git diff-tree --stdin' does not show
+	By default, `git diff-tree --stdin` does not show
 	differences for merge commits.  With this flag, it shows
 	differences to that commit from all of its parents. See
 	also `-c`.
 
 -s::
-	By default, 'git diff-tree --stdin' shows differences,
+	By default, `git diff-tree --stdin` shows differences,
 	either in machine-readable form (without `-p`) or in patch
 	form (with `-p`).  This output can be suppressed.  It is
 	only useful with `-v` flag.
 
 -v::
-	This flag causes 'git diff-tree --stdin' to also show
+	This flag causes `git diff-tree --stdin` to also show
 	the commit message before the differences.
 
 include::pretty-options.txt[]
 
 --no-commit-id::
-	'git diff-tree' outputs a line with the commit ID when
+	`git diff-tree` outputs a line with the commit ID when
 	applicable.  This flag suppressed the commit ID output.
 
 -c::
diff --git a/Documentation/git-diff.txt b/Documentation/git-diff.txt
index 33a47958bc..7779631421 100644
--- a/Documentation/git-diff.txt
+++ b/Documentation/git-diff.txt
@@ -9,12 +9,12 @@ git-diff - Show changes between commits, commit and working tree, etc
 SYNOPSIS
 --------
 [verse]
-'git diff' [<options>] [<commit>] [--] [<path>...]
-'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
-'git diff' [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
-'git diff' [<options>] <commit>...<commit> [--] [<path>...]
-'git diff' [<options>] <blob> <blob>
-'git diff' [<options>] --no-index [--] <path> <path>
+`git diff` [<options>] [<commit>] [--] [<path>...]
+`git diff` [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]
+`git diff` [<options>] [--merge-base] <commit> [<commit>...] <commit> [--] [<path>...]
+`git diff` [<options>] <commit>...<commit> [--] [<path>...]
+`git diff` [<options>] <blob> <blob>
+`git diff` [<options>] --no-index [--] <path> <path>
 
 DESCRIPTION
 -----------
@@ -23,7 +23,7 @@ between the index and a tree, changes between two trees, changes resulting
 from a merge, changes between two blob objects, or changes between two
 files on disk.
 
-'git diff' [<options>] [--] [<path>...]::
+`git diff` [<options>] [--] [<path>...]::
 
 	This form is to view the changes you made relative to
 	the index (staging area for the next commit).  In other
@@ -31,7 +31,7 @@ files on disk.
 	further add to the index but you still haven't.  You can
 	stage these changes by using linkgit:git-add[1].
 
-'git diff' [<options>] --no-index [--] <path> <path>::
+`git diff` [<options>] --no-index [--] <path> <path>::
 
 	This form is to compare the given two paths on the
 	filesystem.  You can omit the `--no-index` option when
@@ -40,7 +40,7 @@ files on disk.
 	or when running the command outside a working tree
 	controlled by Git. This form implies `--exit-code`.
 
-'git diff' [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::
+`git diff` [<options>] --cached [--merge-base] [<commit>] [--] [<path>...]::
 
 	This form is to view the changes you staged for the next
 	commit relative to the named <commit>.  Typically you
@@ -54,7 +54,7 @@ If `--merge-base` is given, instead of using <commit>, use the merge base
 of <commit> and `HEAD`.  `git diff --merge-base A` is equivalent to
 `git diff $(git merge-base A HEAD)`.
 
-'git diff' [<options>] <commit> [--] [<path>...]::
+`git diff` [<options>] <commit> [--] [<path>...]::
 
 	This form is to view the changes you have in your
 	working tree relative to the named <commit>.  You can
@@ -62,7 +62,7 @@ of <commit> and `HEAD`.  `git diff --merge-base A` is equivalent to
 	branch name to compare with the tip of a different
 	branch.
 
-'git diff' [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
+`git diff` [<options>] [--merge-base] <commit> <commit> [--] [<path>...]::
 
 	This is to view the changes between two arbitrary
 	<commit>.
@@ -71,7 +71,7 @@ If `--merge-base` is given, use the merge base of the two commits for the
 "before" side.  `git diff --merge-base A B` is equivalent to
 `git diff $(git merge-base A B) B`.
 
-'git diff' [<options>] <commit> <commit>... <commit> [--] [<path>...]::
+`git diff` [<options>] <commit> <commit>... <commit> [--] [<path>...]::
 
 	This form is to view the results of a merge commit.  The first
 	listed <commit> must be the merge itself; the remaining two or
@@ -80,14 +80,14 @@ If `--merge-base` is given, use the merge base of the two commits for the
 	For instance, if `master` names a merge commit, `git diff master
 	master^@` gives the same combined diff as `git show master`.
 
-'git diff' [<options>] <commit>..<commit> [--] [<path>...]::
+`git diff` [<options>] <commit>..<commit> [--] [<path>...]::
 
 	This is synonymous to the earlier form (without the `..`) for
 	viewing the changes between two arbitrary <commit>.  If <commit> on
 	one side is omitted, it will have the same effect as
 	using `HEAD` instead.
 
-'git diff' [<options>] <commit>\...<commit> [--] [<path>...]::
+`git diff` [<options>] <commit>\...<commit> [--] [<path>...]::
 
 	This form is to view the changes on the branch containing
 	and up to the second <commit>, starting at a common ancestor
@@ -107,7 +107,7 @@ and the range notations (`<commit>..<commit>` and
 `<commit>...<commit>`) do not mean a range as defined in the
 "SPECIFYING RANGES" section in linkgit:gitrevisions[7].
 
-'git diff' [<options>] <blob> <blob>::
+`git diff` [<options>] <blob> <blob>::
 
 	This form is to view the differences between the raw
 	contents of two blob objects.
diff --git a/Documentation/git-difftool.txt b/Documentation/git-difftool.txt
index 143b0c49d7..b646654941 100644
--- a/Documentation/git-difftool.txt
+++ b/Documentation/git-difftool.txt
@@ -8,13 +8,13 @@ git-difftool - Show changes using common diff tools
 SYNOPSIS
 --------
 [verse]
-'git difftool' [<options>] [<commit> [<commit>]] [--] [<path>...]
+`git difftool` [<options>] [<commit> [<commit>]] [--] [<path>...]
 
 DESCRIPTION
 -----------
-'git difftool' is a Git command that allows you to compare and edit files
-between revisions using common diff tools.  'git difftool' is a frontend
-to 'git diff' and accepts the same options and arguments. See
+`git difftool` is a Git command that allows you to compare and edit files
+between revisions using common diff tools.  `git difftool` is a frontend
+to `git diff` and accepts the same options and arguments. See
 linkgit:git-diff[1].
 
 OPTIONS
@@ -48,23 +48,23 @@ OPTIONS
 	emerge, kompare, meld, and vimdiff. Run `git difftool --tool-help`
 	for the list of valid <tool> settings.
 +
-If a diff tool is not specified, 'git difftool'
+If a diff tool is not specified, `git difftool`
 will use the configuration variable `diff.tool`.  If the
-configuration variable `diff.tool` is not set, 'git difftool'
+configuration variable `diff.tool` is not set, `git difftool`
 will pick a suitable default.
 +
 You can explicitly provide a full path to the tool by setting the
 configuration variable `difftool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-`difftool.kdiff3.path`. Otherwise, 'git difftool' assumes the
+`difftool.kdiff3.path`. Otherwise, `git difftool` assumes the
 tool is available in PATH.
 +
 Instead of running one of the known diff tools,
-'git difftool' can be customized to run an alternative program
+`git difftool` can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `difftool.<tool>.cmd`.
 +
-When 'git difftool' is invoked with this tool (either through the
+When `git difftool` is invoked with this tool (either through the
 `-t` or `--tool` option or the `diff.tool` configuration variable)
 the configured command line will be invoked with the following
 variables available: `$LOCAL` is set to the name of the temporary
@@ -78,24 +78,24 @@ with custom merge tool commands and has the same value as `$MERGED`.
 	Print a list of diff tools that may be used with `--tool`.
 
 --[no-]symlinks::
-	'git difftool''s default behavior is create symlinks to the
+	`git difftool`'s default behavior is create symlinks to the
 	working tree when run in `--dir-diff` mode and the right-hand
 	side of the comparison yields the same content as the file in
 	the working tree.
 +
-Specifying `--no-symlinks` instructs 'git difftool' to create copies
+Specifying `--no-symlinks` instructs `git difftool` to create copies
 instead.  `--no-symlinks` is the default on Windows.
 
 -x <command>::
 --extcmd=<command>::
 	Specify a custom command for viewing diffs.
-	'git-difftool' ignores the configured defaults and runs
+	`git-difftool` ignores the configured defaults and runs
 	`$command $LOCAL $REMOTE` when this option is specified.
 	Additionally, `$BASE` is set in the environment.
 
 -g::
 --[no-]gui::
-	When 'git-difftool' is invoked with the `-g` or `--gui` option
+	When `git-difftool` is invoked with the `-g` or `--gui` option
 	the default diff tool will be read from the configured
 	`diff.guitool` variable instead of `diff.tool`. The `--no-gui`
 	option can be used to override this setting. If `diff.guitool`
@@ -103,19 +103,19 @@ instead.  `--no-symlinks` is the default on Windows.
 	`diff.tool`, `merge.tool` until a tool is found.
 
 --[no-]trust-exit-code::
-	'git-difftool' invokes a diff tool individually on each file.
+	`git-difftool` invokes a diff tool individually on each file.
 	Errors reported by the diff tool are ignored by default.
-	Use `--trust-exit-code` to make 'git-difftool' exit when an
+	Use `--trust-exit-code` to make `git-difftool` exit when an
 	invoked diff tool returns a non-zero exit code.
 +
-'git-difftool' will forward the exit code of the invoked tool when
+`git-difftool` will forward the exit code of the invoked tool when
 `--trust-exit-code` is used.
 
 See linkgit:git-diff[1] for the full list of supported options.
 
 CONFIG VARIABLES
 ----------------
-'git difftool' falls back to 'git mergetool' config variables when the
+`git difftool` falls back to `git mergetool` config variables when the
 difftool equivalents have not been defined.
 
 diff.tool::
diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast-export.txt
index 3a6a77abac..24b10d4ad1 100644
--- a/Documentation/git-fast-export.txt
+++ b/Documentation/git-fast-export.txt
@@ -9,23 +9,23 @@ git-fast-export - Git data exporter
 SYNOPSIS
 --------
 [verse]
-'git fast-export [<options>]' | 'git fast-import'
+`git fast-export [<options>]` | `git fast-import`
 
 DESCRIPTION
 -----------
 This program dumps the given revisions in a form suitable to be piped
-into 'git fast-import'.
+into `git fast-import`.
 
 You can use it as a human-readable bundle replacement (see
 linkgit:git-bundle[1]), or as a format that can be edited before being
-fed to 'git fast-import' in order to do history rewrites (an ability
-relied on by tools like 'git filter-repo').
+fed to `git fast-import` in order to do history rewrites (an ability
+relied on by tools like `git filter-repo`).
 
 OPTIONS
 -------
 --progress=<n>::
 	Insert 'progress' statements every <n> objects, to be shown by
-	'git fast-import' during import.
+	`git fast-import` during import.
 
 --signed-tags=(verbatim|warn|warn-strip|strip|abort)::
 	Specify how to handle signed tags.  Since any transformation
@@ -139,7 +139,7 @@ by keeping the marks the same across runs.
 --show-original-ids::
 	Add an extra directive to the output for commits and blobs,
 	`original-oid <SHA1SUM>`.  While such directives will likely be
-	ignored by importers such as git-fast-import, it may be useful
+	ignored by importers such as `git-fast-import`, it may be useful
 	for intermediary filters (e.g. for rewriting commit messages
 	which refer to older commits, or for stripping blobs by id).
 
@@ -155,8 +155,8 @@ by keeping the marks the same across runs.
 	be specified.
 
 [<git-rev-list-args>...]::
-	A list of arguments, acceptable to 'git rev-parse' and
-	'git rev-list', that specifies the specific objects and references
+	A list of arguments, acceptable to `git rev-parse` and
+	`git rev-list`, that specifies the specific objects and references
 	to export.  For example, `master~10..master` causes the
 	current `master` reference to be exported along with all objects
 	added since its 10th ancestor commit and (unless the
@@ -191,14 +191,14 @@ referenced by that revision range contains the string
 ANONYMIZING
 -----------
 
-If the `--anonymize` option is given, git will attempt to remove all
+If the `--anonymize` option is given, `git` will attempt to remove all
 identifying information from the repository while still retaining enough
 of the original tree and history patterns to reproduce some bugs. The
-goal is that a git bug which is found on a private repository will
+goal is that a `git` bug which is found on a private repository will
 persist in the anonymized repository, and the latter can be shared with
-git developers to help solve the bug.
+`git` developers to help solve the bug.
 
-With this option, git will replace all refnames, paths, blob contents,
+With this option, `git` will replace all refnames, paths, blob contents,
 commit and tag messages, names, and email addresses in the output with
 anonymized data.  Two instances of the same string will be replaced
 equivalently (e.g., two commits with the same author will have the same
@@ -210,7 +210,7 @@ the tree is retained (e.g., if you have a root tree with 10 files and 3
 trees, so will the output), but their names and the contents of the
 files will be replaced.
 
-If you think you have found a git bug, you can start by exporting an
+If you think you have found a `git` bug, you can start by exporting an
 anonymized stream of the whole repository:
 
 ---------------------------------------------------
@@ -271,7 +271,7 @@ final pathname would be `publicdir/bar.c`.
 LIMITATIONS
 -----------
 
-Since 'git fast-import' cannot tag trees, you will not be
+Since `git fast-import` cannot tag trees, you will not be
 able to export the linux.git repository completely, as it contains
 a tag referencing a tree instead of a commit.
 
diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
index ff67238633..eeac242732 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -9,14 +9,14 @@ git-fast-import - Backend for fast Git data importers
 SYNOPSIS
 --------
 [verse]
-frontend | 'git fast-import' [<options>]
+frontend | `git fast-import` [<options>]
 
 DESCRIPTION
 -----------
 This program is usually not what the end user wants to run directly.
 Most end users want to use one of the existing frontend programs,
 which parses a specific type of foreign source and feeds the contents
-stored there to 'git fast-import'.
+stored there to `git fast-import`.
 
 fast-import reads a mixed command/data stream from standard input and
 writes one or more packfiles directly into the current repository.
@@ -25,7 +25,7 @@ updated branch and tag refs, fully updating the current repository
 with the newly imported data.
 
 The fast-import backend itself can import into an empty repository (one that
-has already been initialized by 'git init') or incrementally
+has already been initialized by `git init`) or incrementally
 update an existing populated repository.  Whether or not incremental
 imports are supported from a particular foreign source depends on
 the frontend program in use.
@@ -115,7 +115,7 @@ Locations of Marks Files
 	After specifying `--relative-marks` the paths specified
 	with `--import-marks`= and `--export-marks`= are relative
 	to an internal directory in the current repository.
-	In git-fast-import this means that the paths are relative
+	In `git-fast-import` this means that the paths are relative
 	to the .git/info/fast-import directory. However, other
 	importers may use a different location.
 +
@@ -166,7 +166,7 @@ Performance and Compression Tuning
 	This information may be useful after importing projects
 	whose total object set exceeds the 4 GiB packfile limit,
 	as these commits can be used as edge points during calls
-	to 'git pack-objects'.
+	to `git pack-objects`.
 
 --max-pack-size=<n>::
 	Maximum size of each output packfile.
@@ -203,9 +203,9 @@ an ideal situation, given that most conversion tools are throw-away
 
 PARALLEL OPERATION
 ------------------
-Like 'git push' or 'git fetch', imports handled by fast-import are safe to
+Like `git push` or `git fetch`, imports handled by fast-import are safe to
 run alongside parallel `git repack -a -d` or `git gc` invocations,
-or any other Git operation (including 'git prune', as loose objects
+or any other Git operation (including `git prune`, as loose objects
 are never used by fast-import).
 
 fast-import does not lock the branch or tag refs it is actively importing.
@@ -307,7 +307,7 @@ and some sanity checks on the numeric values may also be performed.
 +
 An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
 parser is accurate, but a little on the lenient side.  It is the
-same parser used by 'git am' when applying patches
+same parser used by `git am` when applying patches
 received from email.
 +
 Some malformed strings may be accepted as valid dates.  In some of
@@ -343,7 +343,7 @@ time zone.
 This particular format is supplied as it's short to implement and
 may be useful to a process that wants to create a new commit
 right now, without needing to use a working directory or
-'git update-index'.
+`git update-index`.
 +
 If separate `author` and `committer` commands are used in a `commit`
 the timestamps may not match, as the system clock will be polled
@@ -509,7 +509,7 @@ their syntax.
 ^^^^^^^^^^
 The optional `encoding` command indicates the encoding of the commit
 message.  Most commits are UTF-8 and the encoding is omitted, but this
-allows importing commit messages into git without first reencoding them.
+allows importing commit messages into `git` without first reencoding them.
 
 `from`
 ^^^^^^
@@ -859,7 +859,7 @@ recommended, as the frontend does not (easily) have access to the
 complete set of bytes which normally goes into such a signature.
 If signing is required, create lightweight tags from within fast-import with
 `reset`, then create the annotated versions of those tags offline
-with the standard 'git tag' process.
+with the standard `git tag` process.
 
 `reset`
 ~~~~~~~
@@ -1120,7 +1120,7 @@ The <dataref> represents the blob, tree, or commit object at <path>
 and can be used in later 'get-mark', 'cat-blob', 'filemodify', or
 'ls' commands.
 
-If there is no file or subtree at that path, 'git fast-import' will
+If there is no file or subtree at that path, `git fast-import` will
 instead report
 
 ====
@@ -1183,14 +1183,14 @@ done::
 	abruptly at a convenient point in the stream can go
 	undetected.  This may occur, for example, if an import
 	front end dies in mid-operation without emitting SIGTERM
-	or SIGKILL at its subordinate git fast-import instance.
+	or SIGKILL at its subordinate `git fast-import` instance.
 
 `option`
 ~~~~~~~~
-Processes the specified option so that git fast-import behaves in a
+Processes the specified option so that `git fast-import` behaves in a
 way that suits the frontend's needs.
 Note that options specified by the frontend are overridden by any
-options the user may specify to git fast-import itself.
+options the user may specify to `git fast-import` itself.
 
 ....
     'option' SP <option> LF
@@ -1396,7 +1396,7 @@ is not `refs/heads/TAG_FIXUP`).
 
 When committing fixups, consider using `merge` to connect the
 commit(s) which are supplying file revisions to the fixup branch.
-Doing so will allow tools such as 'git blame' to track
+Doing so will allow tools such as `git blame` to track
 through the real commit history and properly annotate the source
 files.
 
@@ -1425,7 +1425,7 @@ Repacking Historical Data
 ~~~~~~~~~~~~~~~~~~~~~~~~~
 If you are repacking very old imported data (e.g. older than the
 last year), consider expending some extra CPU time and supplying
-`--window=50` (or higher) when you run 'git repack'.
+`--window=50` (or higher) when you run `git repack`.
 This will take longer, but will also produce a smaller packfile.
 You only need to expend the effort once, and everyone using your
 project will benefit from the smaller repository.
@@ -1558,7 +1558,7 @@ memory footprint (less than 2.7 MiB per active branch).
 
 SIGNALS
 -------
-Sending *SIGUSR1* to the 'git fast-import' process ends the current
+Sending *SIGUSR1* to the `git fast-import` process ends the current
 packfile early, simulating a `checkpoint` command.  The impatient
 operator can use this facility to peek at the objects and refs from an
 import in progress, at the cost of some added running time and worse
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch-pack.txt
index 1f48f89e3e..eaca893ac8 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -9,21 +9,21 @@ git-fetch-pack - Receive missing objects from another repository
 SYNOPSIS
 --------
 [verse]
-'git fetch-pack' [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag]
+`git fetch-pack` [--all] [--quiet|-q] [--keep|-k] [--thin] [--include-tag]
 	[--upload-pack=<git-upload-pack>]
 	[--depth=<n>] [--no-progress]
 	[-v] <repository> [<refs>...]
 
 DESCRIPTION
 -----------
-Usually you would want to use 'git fetch', which is a
+Usually you would want to use `git fetch`, which is a
 higher level wrapper of this command, instead.
 
-Invokes 'git-upload-pack' on a possibly remote repository
+Invokes `git-upload-pack` on a possibly remote repository
 and asks it to send objects missing from this repository, to
 update the named heads.  The list of commits available locally
 is found out by scanning the local refs/ hierarchy and sent to
-'git-upload-pack' running on the other end.
+`git-upload-pack` running on the other end.
 
 This command degenerates to download everything to complete the
 asked refs from the remote side when the local side does not
@@ -47,12 +47,12 @@ be in a separate packet, and the list must end with a flush packet.
 
 -q::
 --quiet::
-	Pass `-q` flag to 'git unpack-objects'; this makes the
+	Pass `-q` flag to `git unpack-objects`; this makes the
 	cloning process less verbose.
 
 -k::
 --keep::
-	Do not invoke 'git unpack-objects' on received data, but
+	Do not invoke `git unpack-objects` on received data, but
 	create a single packfile out of it instead, and store it
 	in the object database. If provided twice then the pack is
 	locked against repacking.
@@ -68,11 +68,11 @@ be in a separate packet, and the list must end with a flush packet.
 	otherwise determine the tags this option made available.
 
 --upload-pack=<git-upload-pack>::
-	Use this to specify the path to 'git-upload-pack' on the
+	Use this to specify the path to `git-upload-pack` on the
 	remote side, if is not found on your $PATH.
 	Installations of sshd ignores the user's environment
 	setup scripts for login shells (e.g. .bash_profile) and
-	your privately installed git may not be found on the system
+	your privately installed `git` may not be found on the system
 	default $PATH.  Another workaround suggested is to set
 	up your $PATH in ".bashrc", but this flag is for people
 	who do not want to pay the overhead for non-interactive
@@ -84,7 +84,7 @@ be in a separate packet, and the list must end with a flush packet.
 
 --depth=<n>::
 	Limit fetching to ancestor-chains not longer than n.
-	'git-upload-pack' treats the special depth 2147483647 as
+	`git-upload-pack` treats the special depth 2147483647 as
 	infinite even if there is an ancestor-chain that long.
 
 --shallow-since=<date>::
diff --git a/Documentation/git-fetch.txt b/Documentation/git-fetch.txt
index 6c3f41399f..b0b5d06aad 100644
--- a/Documentation/git-fetch.txt
+++ b/Documentation/git-fetch.txt
@@ -9,10 +9,10 @@ git-fetch - Download objects and refs from another repository
 SYNOPSIS
 --------
 [verse]
-'git fetch' [<options>] [<repository> [<refspec>...]]
-'git fetch' [<options>] <group>
-'git fetch' --multiple [<options>] [(<repository> | <group>)...]
-'git fetch' --all [<options>]
+`git fetch` [<options>] [<repository> [<refspec>...]]
+`git fetch` [<options>] <group>
+`git fetch` --multiple [<options>] [(<repository> | <group>)...]
+`git fetch` --all [<options>]
 
 
 DESCRIPTION
@@ -30,7 +30,7 @@ configuring `remote.<name>.tagOpt`.  By using a refspec that fetches tags
 explicitly, you can fetch tags that do not point into branches you
 are interested in as well.
 
-'git fetch' can fetch from either a single named repository or URL,
+`git fetch` can fetch from either a single named repository or URL,
 or from several repositories at once if <group> is given and
 there is a `remotes.<group>` entry in the configuration file.
 (See linkgit:git-config[1]).
@@ -40,7 +40,7 @@ unless there's an upstream branch configured for the current branch.
 
 The names of refs that are fetched, together with the object names
 they point at, are written to `.git/FETCH_HEAD`.  This information
-may be used by scripts or other git commands, such as linkgit:git-pull[1].
+may be used by scripts or other `git` commands, such as linkgit:git-pull[1].
 
 OPTIONS
 -------
@@ -193,7 +193,7 @@ $ git fetch <url of origin> --prune 'refs/tags/*:refs/tags/*'
 OUTPUT
 ------
 
-The output of "git fetch" depends on the transport method used; this
+The output of `git fetch` depends on the transport method used; this
 section describes the output when fetching over the Git protocol
 (either locally or via ssh) and Smart HTTP protocol.
 
diff --git a/Documentation/git-filter-branch.txt b/Documentation/git-filter-branch.txt
index 520d3df371..b21205d265 100644
--- a/Documentation/git-filter-branch.txt
+++ b/Documentation/git-filter-branch.txt
@@ -8,7 +8,7 @@ git-filter-branch - Rewrite branches
 SYNOPSIS
 --------
 [verse]
-'git filter-branch' [--setup <command>] [--subdirectory-filter <directory>]
+`git filter-branch` [--setup <command>] [--subdirectory-filter <directory>]
 	[--env-filter <command>] [--tree-filter <command>]
 	[--index-filter <command>] [--parent-filter <command>]
 	[--msg-filter <command>] [--commit-filter <command>]
@@ -18,13 +18,13 @@ SYNOPSIS
 
 WARNING
 -------
-'git filter-branch' has a plethora of pitfalls that can produce non-obvious
+`git filter-branch` has a plethora of pitfalls that can produce non-obvious
 manglings of the intended history rewrite (and can leave you with little
 time to investigate such problems since it has such abysmal performance).
 These safety and performance issues cannot be backward compatibly fixed and
 as such, its use is not recommended.  Please use an alternative history
 filtering tool such as https://github.com/newren/git-filter-repo/[git
-filter-repo].  If you still need to use 'git filter-branch', please
+filter-repo].  If you still need to use `git filter-branch`, please
 carefully read <<SAFETY>> (and <<PERFORMANCE>>) to learn about the land
 mines of filter-branch, and then vigilantly avoid as many of the hazards
 listed there as reasonably possible.
@@ -145,7 +145,7 @@ OPTIONS
 --commit-filter <command>::
 	This is the filter for performing the commit.
 	If this filter is specified, it will be called instead of the
-	'git commit-tree' command, with arguments of the form
+	`git commit-tree` command, with arguments of the form
 	"<TREE_ID> [(-p <PARENT_COMMIT_ID>)...]" and the log message on
 	stdin.  The commit id is expected on stdout.
 +
@@ -156,7 +156,7 @@ have all of them as parents.
 You can use the 'map' convenience function in this filter, and other
 convenience functions, too.  For example, calling 'skip_commit "$@"'
 will leave out the current commit (but not its changes! If you want
-that, use 'git rebase' instead).
+that, use `git rebase` instead).
 +
 You can also use the `git_commit_non_empty_tree "$@"` instead of
 `git commit-tree "$@"` if you don't wish to keep commits with a single parent
@@ -187,7 +187,7 @@ to other tags will be rewritten to point to the underlying commit.
 
 --prune-empty::
 	Some filters will generate empty commits that leave the tree untouched.
-	This option instructs git-filter-branch to remove such commits if they
+	This option instructs `git-filter-branch` to remove such commits if they
 	have exactly one or zero non-pruned parents; merge commits will
 	therefore remain intact.  This option cannot be used together with
 	`--commit-filter`, though the same effect can be achieved by using the
@@ -207,7 +207,7 @@ to other tags will be rewritten to point to the underlying commit.
 
 -f::
 --force::
-	'git filter-branch' refuses to start with an existing temporary
+	`git filter-branch` refuses to start with an existing temporary
 	directory or when there are already refs starting with
 	'refs/original/', unless forced.
 
@@ -218,10 +218,10 @@ to other tags will be rewritten to point to the underlying commit.
 	trees. If '<branch>' does not exist it will be created.
 
 <rev-list options>...::
-	Arguments for 'git rev-list'.  All positive refs included by
+	Arguments for `git rev-list`.  All positive refs included by
 	these options are rewritten.  You may also specify options
 	such as `--all`, but you must use `--` to separate them from
-	the 'git filter-branch' options. Implies <<Remap_to_ancestor>>.
+	the `git filter-branch` options. Implies <<Remap_to_ancestor>>.
 
 
 [[Remap_to_ancestor]]
@@ -257,7 +257,7 @@ However, if the file is absent from the tree of some commit,
 a simple `rm filename` will fail for that tree and commit.
 Thus you may instead want to use `rm -f filename` as the script.
 
-Using `--index-filter` with 'git rm' yields a significantly faster
+Using `--index-filter` with `git rm` yields a significantly faster
 version.  Like with using `rm filename`, `git rm --cached filename`
 will fail if the file is absent from the tree of a commit.  If you
 want to "completely forget" a file, it does not matter when it entered
@@ -341,10 +341,10 @@ as their parents instead of the merge commit.
 *NOTE* the changes introduced by the commits, and which are not reverted
 by subsequent commits, will still be in the rewritten branch. If you want
 to throw out _changes_ together with the commits, you should use the
-interactive mode of 'git rebase'.
+interactive mode of `git rebase`.
 
 You can rewrite the commit log messages using `--msg-filter`.  For
-example, 'git svn-id' strings in a repository created by 'git svn' can
+example, `git svn-id` strings in a repository created by `git svn` can
 be removed this way:
 
 -------------------------------------------------------
@@ -383,7 +383,7 @@ git filter-branch --env-filter '
 
 To restrict rewriting to only part of the history, specify a revision
 range in addition to the new branch name.  The new branch name will
-point to the top-most revision that a 'git rev-list' of this range
+point to the top-most revision that a `git rev-list` of this range
 will print.
 
 Consider this history:
@@ -422,7 +422,7 @@ git filter-branch --index-filter \
 CHECKLIST FOR SHRINKING A REPOSITORY
 ------------------------------------
 
-git-filter-branch can be used to get rid of a subset of files,
+`git-filter-branch` can be used to get rid of a subset of files,
 usually with some combination of `--index-filter` and
 `--subdirectory-filter`.  People expect the resulting repository to
 be smaller than the original, but you need a few more steps to
@@ -434,7 +434,7 @@ objects until you tell it to.  First make sure that:
   can help you find renames.
 
 * You really filtered all refs: use `--tag-name-filter cat -- --all`
-  when calling git-filter-branch.
+  when calling `git-filter-branch`.
 
 Then there are two ways to get a smaller repository.  A safer way is
 to clone, that keeps your original intact.
@@ -448,30 +448,30 @@ following points instead (in this order).  This is a very destructive
 approach, so *make a backup* or go back to cloning it.  You have been
 warned.
 
-* Remove the original refs backed up by git-filter-branch: say `git
+* Remove the original refs backed up by `git-filter-branch`: say `git
   for-each-ref --format="%(refname)" refs/original/ | xargs -n 1 git
   update-ref -d`.
 
 * Expire all reflogs with `git reflog expire --expire=now --all`.
 
 * Garbage collect all unreferenced objects with `git gc --prune=now`
-  (or if your git-gc is not new enough to support arguments to
+  (or if your `git-gc` is not new enough to support arguments to
   `--prune`, use `git repack -ad; git prune` instead).
 
 [[PERFORMANCE]]
 PERFORMANCE
 -----------
 
-The performance of git-filter-branch is glacially slow; its design makes it
+The performance of `git-filter-branch` is glacially slow; its design makes it
 impossible for a backward-compatible implementation to ever be fast:
 
-* In editing files, git-filter-branch by design checks out each and
+* In editing files, `git-filter-branch` by design checks out each and
   every commit as it existed in the original repo.  If your repo has
   `10^5` files and `10^5` commits, but each commit only modifies five
-  files, then git-filter-branch will make you do `10^10` modifications,
+  files, then `git-filter-branch` will make you do `10^10` modifications,
   despite only having (at most) `5*10^5` unique blobs.
 
-* If you try and cheat and try to make git-filter-branch only work on
+* If you try and cheat and try to make `git-filter-branch` only work on
   files modified in a commit, then two things happen
 
   ** you run into problems with deletions whenever the user is simply
@@ -490,16 +490,16 @@ impossible for a backward-compatible implementation to ever be fast:
   remove some and thus can avoid checking out each file (i.e. you can
   use --index-filter), you still are passing shell snippets for your
   filters.  This means that for every commit, you have to have a
-  prepared git repo where those filters can be run.  That's a
+  prepared `git` repo where those filters can be run.  That's a
   significant setup.
 
 * Further, several additional files are created or updated per commit
-  by git-filter-branch.  Some of these are for supporting the
-  convenience functions provided by git-filter-branch (such as map()),
+  by `git-filter-branch`.  Some of these are for supporting the
+  convenience functions provided by `git-filter-branch` (such as map()),
   while others are for keeping track of internal state (but could have
   also been accessed by user filters; one of git-filter-branch's
   regression tests does so).  This essentially amounts to using the
-  filesystem as an IPC mechanism between git-filter-branch and the
+  filesystem as an IPC mechanism between `git-filter-branch` and the
   user-provided filters.  Disks tend to be a slow IPC mechanism, and
   writing these files also effectively represents a forced
   synchronization point between separate processes that we hit with
@@ -511,46 +511,46 @@ impossible for a backward-compatible implementation to ever be fast:
   of time between operating systems, but on any platform it is very
   slow relative to invoking a function.
 
-* git-filter-branch itself is written in shell, which is kind of slow.
+* `git-filter-branch` itself is written in shell, which is kind of slow.
   This is the one performance issue that could be backward-compatibly
   fixed, but compared to the above problems that are intrinsic to the
-  design of git-filter-branch, the language of the tool itself is a
+  design of `git-filter-branch`, the language of the tool itself is a
   relatively minor issue.
 
   ** Side note: Unfortunately, people tend to fixate on the
-     written-in-shell aspect and periodically ask if git-filter-branch
+     written-in-shell aspect and periodically ask if `git-filter-branch`
      could be rewritten in another language to fix the performance
      issues.  Not only does that ignore the bigger intrinsic problems
      with the design, it'd help less than you'd expect: if
-     git-filter-branch itself were not shell, then the convenience
+     `git-filter-branch` itself were not shell, then the convenience
      functions (map(), skip_commit(), etc) and the `--setup` argument
      could no longer be executed once at the beginning of the program
      but would instead need to be prepended to every user filter (and
      thus re-executed with every commit).
 
 The https://github.com/newren/git-filter-repo/[git filter-repo] tool is
-an alternative to git-filter-branch which does not suffer from these
+an alternative to `git-filter-branch` which does not suffer from these
 performance problems or the safety problems (mentioned below). For those
-with existing tooling which relies upon git-filter-branch, 'git
-filter-repo' also provides
+with existing tooling which relies upon `git-filter-branch`, `git
+filter-repo` also provides
 https://github.com/newren/git-filter-repo/blob/master/contrib/filter-repo-demos/filter-lamely[filter-lamely],
-a drop-in git-filter-branch replacement (with a few caveats).  While
+a drop-in `git-filter-branch` replacement (with a few caveats).  While
 filter-lamely suffers from all the same safety issues as
-git-filter-branch, it at least ameliorates the performance issues a
+`git-filter-branch`, it at least ameliorates the performance issues a
 little.
 
 [[SAFETY]]
 SAFETY
 ------
 
-git-filter-branch is riddled with gotchas resulting in various ways to
+`git-filter-branch` is riddled with gotchas resulting in various ways to
 easily corrupt repos or end up with a mess worse than what you started
 with:
 
 * Someone can have a set of "working and tested filters" which they
   document or provide to a coworker, who then runs them on a different
   OS where the same commands are not working/tested (some examples in
-  the git-filter-branch manpage are also affected by this).
+  the `git-filter-branch` manpage are also affected by this).
   BSD vs. GNU userland differences can really bite.  If lucky, error
   messages are spewed.  But just as likely, the commands either don't
   do the filtering requested, or silently corrupt by making some
@@ -563,7 +563,7 @@ with:
 
 * Filenames with spaces are often mishandled by shell snippets since
   they cause problems for shell pipelines.  Not everyone is familiar
-  with find -print0, xargs -0, git-ls-files -z, etc.  Even people who
+  with `find -print0`, `xargs -0`, `git-ls-files -z`, etc.  Even people who
   are familiar with these may assume such flags are not relevant
   because someone else renamed any such files in their repo back
   before the person doing the filtering joined the project.  And
@@ -590,7 +590,7 @@ with:
   problem.)
 
 * It's far too easy to accidentally mix up old and new history.  It's
-  still possible with any tool, but git-filter-branch almost
+  still possible with any tool, but `git-filter-branch` almost
   invites it.  If lucky, the only downside is users getting frustrated
   that they don't know how to shrink their repo and remove the old
   stuff.  If unlucky, they merge old and new history and end up with
@@ -612,7 +612,7 @@ with:
      need to understand that they need to rebase their changes for all
      their branches on top of new history (or delete and reclone), but
      that's only one of multiple concerns to consider.  See the
-     "DISCUSSION" section of the git filter-repo manual page for more
+     "DISCUSSION" section of the `git filter-repo` manual page for more
      details.
 
 * Annotated tags can be accidentally converted to lightweight tags,
@@ -620,16 +620,16 @@ with:
 
   ** Someone can do a history rewrite, realize they messed up, restore
      from the backups in refs/original/, and then redo their
-     git-filter-branch command.  (The backup in refs/original/ is not a
+     `git-filter-branch` command.  (The backup in refs/original/ is not a
      real backup; it dereferences tags first.)
 
-  ** Running git-filter-branch with either `--tags` or `--all` in your
+  ** Running `git-filter-branch` with either `--tags` or `--all` in your
      <rev-list options>.  In order to retain annotated tags as
      annotated, you must use `--tag-name-filter` (and must not have
      restored from refs/original/ in a previously botched rewrite).
 
 * Any commit messages that specify an encoding will become corrupted
-  by the rewrite; git-filter-branch ignores the encoding, takes the
+  by the rewrite; `git-filter-branch` ignores the encoding, takes the
   original bytes, and feeds it to commit-tree without telling it the
   proper encoding.  (This happens whether or not `--msg-filter` is
   used.)
@@ -665,12 +665,12 @@ with:
   update authors and committers, missing taggers.
 
 * If the user provides a `--tag-name-filter` that maps multiple tags to
-  the same name, no warning or error is provided; git-filter-branch
+  the same name, no warning or error is provided; `git-filter-branch`
   simply overwrites each tag in some undocumented pre-defined order
-  resulting in only one tag at the end.  (A git-filter-branch
+  resulting in only one tag at the end.  (A `git-filter-branch`
   regression test requires this surprising behavior.)
 
-Also, the poor performance of git-filter-branch often leads to safety
+Also, the poor performance of `git-filter-branch` often leads to safety
 issues:
 
 * Coming up with the correct shell snippet to do the filtering you
@@ -681,7 +681,7 @@ issues:
   circumstances (spaces in filenames, non-ascii filenames, funny
   author names or emails, invalid timezones, presence of grafts or
   replace objects, etc.), meaning they may have to wait a long time,
-  hit an error, then restart.  The performance of git-filter-branch is
+  hit an error, then restart.  The performance of `git-filter-branch` is
   so bad that this cycle is painful, reducing the time available to
   carefully re-check (to say nothing about what it does to the
   patience of the person doing the rewrite even if they do technically
diff --git a/Documentation/git-fmt-merge-msg.txt b/Documentation/git-fmt-merge-msg.txt
index 86fb26dcea..a8e9ab914d 100644
--- a/Documentation/git-fmt-merge-msg.txt
+++ b/Documentation/git-fmt-merge-msg.txt
@@ -9,17 +9,17 @@ git-fmt-merge-msg - Produce a merge commit message
 SYNOPSIS
 --------
 [verse]
-'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log]
-'git fmt-merge-msg' [-m <message>] [--log[=<n>] | --no-log] -F <file>
+`git fmt-merge-msg` [-m <message>] [--log[=<n>] | --no-log]
+`git fmt-merge-msg` [-m <message>] [--log[=<n>] | --no-log] -F <file>
 
 DESCRIPTION
 -----------
 Takes the list of merged objects on stdin and produces a suitable
 commit message to be used for the merge commit, usually to be
-passed as the '<merge-message>' argument of 'git merge'.
+passed as the '<merge-message>' argument of `git merge`.
 
 This command is intended mostly for internal use by scripts
-automatically invoking 'git merge'.
+automatically invoking `git merge`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 64ff4a14f8..33fb379df4 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -8,7 +8,7 @@ git-for-each-ref - Output information on each ref
 SYNOPSIS
 --------
 [verse]
-'git for-each-ref' [--count=<count>] [--shell|--perl|--python|--tcl]
+`git for-each-ref` [--count=<count>] [--shell|--perl|--python|--tcl]
 		   [(--sort=<key>)...] [--format=<format>] [<pattern>...]
 		   [--points-at=<object>]
 		   [--merged[=<object>]] [--no-merged[=<object>]]
@@ -125,7 +125,7 @@ objecttype::
 	The type of the object (`blob`, `tree`, `commit`, `tag`).
 
 objectsize::
-	The size of the object (the same as 'git cat-file -s' reports).
+	The size of the object (the same as `git cat-file -s` reports).
 	Append `:disk` to get the size, in bytes, that the object takes up on
 	disk. See the note about on-disk sizes in the `CAVEATS` section below.
 objectname::
diff --git a/Documentation/git-for-each-repo.txt b/Documentation/git-for-each-repo.txt
index 94bd19da26..c2d6cd6629 100644
--- a/Documentation/git-for-each-repo.txt
+++ b/Documentation/git-for-each-repo.txt
@@ -9,7 +9,7 @@ git-for-each-repo - Run a Git command on a list of repositories
 SYNOPSIS
 --------
 [verse]
-'git for-each-repo' --config=<config> [--] <arguments>
+`git for-each-repo` --config=<config> [--] <arguments>
 
 
 DESCRIPTION
diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index fd7c6c705b..2009a048a9 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -9,7 +9,7 @@ git-format-patch - Prepare patches for e-mail submission
 SYNOPSIS
 --------
 [verse]
-'git format-patch' [-k] [(-o|--output-directory) <dir> | --stdout]
+`git format-patch` [-k] [(-o|--output-directory) <dir> | --stdout]
 		   [--no-thread | --thread[=<style>]]
 		   [(--attach|--inline)[=<boundary>] | --no-attach]
 		   [-s | --signoff]
@@ -39,7 +39,7 @@ DESCRIPTION
 Prepare each commit with its "patch" in
 one "message" per commit, formatted to resemble a UNIX mailbox.
 The output of this command is convenient for e-mail submission or
-for use with 'git am'.
+for use with `git am`.
 
 A "message" generated by the command consists of three parts:
 
@@ -176,7 +176,7 @@ The default is `--no-thread`, unless the `format.thread` configuration
 is set.  If `--thread` is specified without a style, it defaults to the
 style specified by `format.thread` if any, or else `shallow`.
 +
-Beware that the default for 'git send-email' is to thread emails
+Beware that the default for `git send-email` is to thread emails
 itself.  If you want `git format-patch` to take care of threading, you
 will want to ensure that threading is disabled for `git send-email`.
 
@@ -415,7 +415,7 @@ with configuration variables.
 DISCUSSION
 ----------
 
-The patch produced by 'git format-patch' is in UNIX mailbox format,
+The patch produced by `git format-patch` is in UNIX mailbox format,
 with a fixed "magic" time stamp to indicate that the file is output
 from format-patch rather than a real mailbox, like so:
 
@@ -444,8 +444,8 @@ can save interesting patches in a UNIX mailbox and apply them with
 linkgit:git-am[1].
 
 When a patch is part of an ongoing discussion, the patch generated by
-'git format-patch' can be tweaked to take advantage of the 'git am
---scissors' feature.  After your response to the discussion comes a
+`git format-patch` can be tweaked to take advantage of the `git am
+--scissors` feature.  After your response to the discussion comes a
 line that consists solely of "`-- >8 --`" (scissors and perforation),
 followed by the patch with unnecessary header fields removed:
 
@@ -524,11 +524,11 @@ GMail
 ~~~~~
 GMail does not have any way to turn off line wrapping in the web
 interface, so it will mangle any emails that you send.  You can however
-use "git send-email" and send your patches through the GMail SMTP server, or
+use `git send-email` and send your patches through the GMail SMTP server, or
 use any IMAP email client to connect to the google IMAP server and forward
 the emails through that.
 
-For hints on using 'git send-email' to send your patches through the
+For hints on using `git send-email` to send your patches through the
 GMail SMTP server, see the EXAMPLE section of linkgit:git-send-email[1].
 
 For hints on submission using the IMAP interface, see the EXAMPLE
@@ -551,7 +551,7 @@ Install the Toggle Word Wrap add-on that is available from
 https://addons.mozilla.org/thunderbird/addon/toggle-word-wrap/
 It adds a menu entry "Enable Word Wrap" in the composer's "Options" menu
 that you can tick off. Now you can compose the message as you otherwise do
-(cut + paste, 'git format-patch' | 'git imap-send', etc), but you have to
+(cut + paste, `git format-patch` | `git imap-send`, etc), but you have to
 insert line breaks manually in any text that you type.
 
 Approach #2 (configuration)
@@ -579,7 +579,7 @@ Toggle it to make sure it is set to `false`. Also, search for
    Toggle it to make sure it is set to `false`.
 
 After that is done, you should be able to compose email as you
-otherwise would (cut + paste, 'git format-patch' | 'git imap-send', etc),
+otherwise would (cut + paste, `git format-patch` | `git imap-send`, etc),
 and the patches will not be mangled.
 
 Approach #3 (external editor)
@@ -699,7 +699,7 @@ EXAMPLES
 --------
 
 * Extract commits between revisions R1 and R2, and apply them on top of
-  the current branch using 'git am' to cherry-pick them:
+  the current branch using `git am` to `cherry-pick` them:
 +
 ------------
 $ git format-patch -k --stdout R1..R2 | git am -3 -k
diff --git a/Documentation/git-fsck-objects.txt b/Documentation/git-fsck-objects.txt
index eec4bdb600..589bb63fdc 100644
--- a/Documentation/git-fsck-objects.txt
+++ b/Documentation/git-fsck-objects.txt
@@ -9,7 +9,7 @@ git-fsck-objects - Verifies the connectivity and validity of the objects in the
 SYNOPSIS
 --------
 [verse]
-'git fsck-objects' ...
+`git fsck-objects` ...
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-fsck.txt b/Documentation/git-fsck.txt
index d9a28e278d..048a28ee50 100644
--- a/Documentation/git-fsck.txt
+++ b/Documentation/git-fsck.txt
@@ -9,7 +9,7 @@ git-fsck - Verifies the connectivity and validity of the objects in the database
 SYNOPSIS
 --------
 [verse]
-'git fsck' [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
+`git fsck` [--tags] [--root] [--unreachable] [--cache] [--no-reflogs]
 	 [--[no-]full] [--strict] [--verbose] [--lost-found]
 	 [--[no-]dangling] [--[no-]progress] [--connectivity-only]
 	 [--[no-]name-objects] [<object>*]
@@ -23,7 +23,7 @@ OPTIONS
 <object>::
 	An object to treat as the head of an unreachability trace.
 +
-If no objects are given, 'git fsck' defaults to using the
+If no objects are given, `git fsck` defaults to using the
 index file, all SHA-1 references in `refs` namespace, and all reflogs
 (unless `--no-reflogs` is given) as heads.
 
@@ -112,7 +112,7 @@ include::config/fsck.txt[]
 DISCUSSION
 ----------
 
-git-fsck tests SHA-1 and general object sanity, and it does full tracking
+`git-fsck` tests SHA-1 and general object sanity, and it does full tracking
 of the resulting reachability and everything else. It prints out any
 corruption it finds (missing or bad objects), and if you use the
 `--unreachable` flag it will also print out objects that exist but that
@@ -124,7 +124,7 @@ Any corrupt objects you will have to find in backups or other archives
 the hopes that somebody else has the object you have corrupted).
 
 If `core.commitGraph` is true, the commit-graph file will also be inspected
-using 'git commit-graph verify'. See linkgit:git-commit-graph[1].
+using `git commit-graph verify`. See linkgit:git-commit-graph[1].
 
 Extracted Diagnostics
 ---------------------
diff --git a/Documentation/git-gc.txt b/Documentation/git-gc.txt
index 9d27c3a41e..c5c71febf5 100644
--- a/Documentation/git-gc.txt
+++ b/Documentation/git-gc.txt
@@ -9,14 +9,14 @@ git-gc - Cleanup unnecessary files and optimize the local repository
 SYNOPSIS
 --------
 [verse]
-'git gc' [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
+`git gc` [--aggressive] [--auto] [--quiet] [--prune=<date> | --no-prune] [--force] [--keep-largest-pack]
 
 DESCRIPTION
 -----------
 Runs a number of housekeeping tasks within the current repository,
 such as compressing file revisions (to reduce disk space and increase
 performance), removing unreachable objects which may have been
-created from prior invocations of 'git add', packing refs, pruning
+created from prior invocations of `git add`, packing refs, pruning
 reflog, rerere metadata or stale working trees. May also update ancillary
 indexes such as the commit-graph.
 
@@ -35,14 +35,14 @@ OPTIONS
 -------
 
 --aggressive::
-	Usually 'git gc' runs very quickly while providing good disk
+	Usually `git gc` runs very quickly while providing good disk
 	space utilization and performance.  This option will cause
-	'git gc' to more aggressively optimize the repository at the expense
+	`git gc` to more aggressively optimize the repository at the expense
 	of taking much more time.  The effects of this optimization are
 	mostly persistent. See the "AGGRESSIVE" section below for details.
 
 --auto::
-	With this option, 'git gc' checks whether any housekeeping is
+	With this option, `git gc` checks whether any housekeeping is
 	required; if not, it exits without performing any work.
 +
 See the `gc.auto` option in the "CONFIGURATION" section below for how
@@ -114,19 +114,19 @@ include::config/gc.txt[]
 NOTES
 -----
 
-'git gc' tries very hard not to delete objects that are referenced
+`git gc` tries very hard not to delete objects that are referenced
 anywhere in your repository. In particular, it will keep not only
 objects referenced by your current set of branches and tags, but also
 objects referenced by the index, remote-tracking branches, reflogs
 (which may reference commits in branches that were later amended or
 rewound), and anything else in the refs/* namespace. Note that a note
-(of the kind created by 'git notes') attached to an object does not
+(of the kind created by `git notes`) attached to an object does not
 contribute in keeping the object alive. If you are expecting some
 objects to be deleted and they aren't, check all of those locations
 and decide whether it makes sense in your case to remove those
 references.
 
-On the other hand, when 'git gc' runs concurrently with another process,
+On the other hand, when `git gc` runs concurrently with another process,
 there is a risk of it deleting an object that the other process is using
 but hasn't created a reference to. This may just cause the other process
 to fail or may corrupt the repository if the other process later adds a
@@ -147,7 +147,7 @@ seems to be low in practice).
 HOOKS
 -----
 
-The 'git gc --auto' command will run the 'pre-auto-gc' hook.  See
+The `git gc --auto` command will run the 'pre-auto-gc' hook.  See
 linkgit:githooks[5] for more information.
 
 
diff --git a/Documentation/git-get-tar-commit-id.txt b/Documentation/git-get-tar-commit-id.txt
index ac44d85b0b..7b7e41bf68 100644
--- a/Documentation/git-get-tar-commit-id.txt
+++ b/Documentation/git-get-tar-commit-id.txt
@@ -9,20 +9,20 @@ git-get-tar-commit-id - Extract commit ID from an archive created using git-arch
 SYNOPSIS
 --------
 [verse]
-'git get-tar-commit-id'
+`git get-tar-commit-id`
 
 
 DESCRIPTION
 -----------
 
-Read a tar archive created by 'git archive' from the standard input
+Read a tar archive created by `git archive` from the standard input
 and extract the commit ID stored in it.  It reads only the first
 1024 bytes of input, thus its runtime is not influenced by the size
 of the tar archive very much.
 
-If no commit ID is found, 'git get-tar-commit-id' quietly exists with a
+If no commit ID is found, `git get-tar-commit-id` quietly exists with a
 return code of 1.  This can happen if the archive had not been created
-using 'git archive' or if the first parameter of 'git archive' had been
+using `git archive` or if the first parameter of `git archive` had been
 a tree ID instead of a commit ID or tag.
 
 GIT
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 88047cefad..b10a3f6bb4 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -9,7 +9,7 @@ git-grep - Print lines matching a pattern
 SYNOPSIS
 --------
 [verse]
-'git grep' [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
+`git grep` [-a | --text] [-I] [--textconv] [-i | --ignore-case] [-w | --word-regexp]
 	   [-v | --invert-match] [-h|-H] [--full-name]
 	   [-E | --extended-regexp] [-G | --basic-regexp]
 	   [-P | --perl-regexp]
@@ -66,8 +66,8 @@ grep.fullName::
 	If set to true, enable `--full-name` option by default.
 
 grep.fallbackToNoIndex::
-	If set to true, fall back to git grep `--no-index` if git grep
-	is executed outside of a git repository.  Defaults to false.
+	If set to true, fall back to `git grep --no-index` if `git grep`
+	is executed outside of a `git` repository.  Defaults to false.
 
 
 OPTIONS
@@ -191,13 +191,13 @@ providing this option will cause it to die.
 --files-without-match::
 	Instead of showing every matched line, show only the
 	names of files that contain (or do not contain) matches.
-	For better compatibility with 'git diff', `--name-only` is a
+	For better compatibility with `git diff`, `--name-only` is a
 	synonym for `--files-with-matches`.
 
 -O[<pager>]::
 --open-files-in-pager[=<pager>]::
 	Open the matching files in the pager (not the output of 'grep').
-	If the pager happens to be "less" or "vi", and the user
+	If the pager happens to be `less` or `vi`, and the user
 	specified only one pattern, the first file is positioned at
 	the first match automatically. The `pager` argument is
 	optional; if specified, it must be stuck to the option
diff --git a/Documentation/git-gui.txt b/Documentation/git-gui.txt
index c9d7e96214..ff66c5b1d0 100644
--- a/Documentation/git-gui.txt
+++ b/Documentation/git-gui.txt
@@ -8,23 +8,23 @@ git-gui - A portable graphical interface to Git
 SYNOPSIS
 --------
 [verse]
-'git gui' [<command>] [arguments]
+`git gui` [<command>] [arguments]
 
 DESCRIPTION
 -----------
-A Tcl/Tk based graphical user interface to Git.  'git gui' focuses
+A Tcl/Tk based graphical user interface to Git.  `git gui` focuses
 on allowing users to make changes to their repository by making
 new commits, amending existing ones, creating branches, performing
 local merges, and fetching/pushing to remote repositories.
 
-Unlike 'gitk', 'git gui' focuses on commit generation
+Unlike `gitk`, `git gui` focuses on commit generation
 and single file annotation and does not show project history.
-It does however supply menu actions to start a 'gitk' session from
-within 'git gui'.
+It does however supply menu actions to start a `gitk` session from
+within `git gui`.
 
-'git gui' is known to work on all popular UNIX systems, Mac OS X,
+`git gui` is known to work on all popular UNIX systems, Mac OS X,
 and Windows (under both Cygwin and MSYS).  To the extent possible
-OS specific user interface guidelines are followed, making 'git gui'
+OS specific user interface guidelines are followed, making `git gui`
 a fairly native interface for users.
 
 COMMANDS
@@ -39,13 +39,13 @@ browser::
 	browser are opened in the blame viewer.
 
 citool::
-	Start 'git gui' and arrange to make exactly one commit before
+	Start `git gui` and arrange to make exactly one commit before
 	exiting and returning to the shell.  The interface is limited
 	to only commit actions, slightly reducing the application's
 	startup time and simplifying the menubar.
 
 version::
-	Display the currently running version of 'git gui'.
+	Display the currently running version of `git gui`.
 
 
 Examples
@@ -103,16 +103,16 @@ SEE ALSO
 --------
 linkgit:gitk[1]::
 	The Git repository browser.  Shows branches, commit history
-	and file differences.  gitk is the utility started by
+	and file differences.  `gitk` is the utility started by
 	'git gui''s Repository Visualize actions.
 
 Other
 -----
-'git gui' is actually maintained as an independent project, but stable
+`git gui` is actually maintained as an independent project, but stable
 versions are distributed as part of the Git suite for the convenience
 of end users.
 
-The official repository of the 'git gui' project can be found at:
+The official repository of the `git gui` project can be found at:
 
   https://github.com/prati0100/git-gui.git/
 
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index df9e2c58bd..15c2945345 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,8 +9,8 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
-'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
+`git hash-object` [-t <type>] [-w] [--path=<file>|--no-filters] [--stdin [--literally]] [--] <file>...
+`git hash-object` [-t <type>] [-w] --stdin-paths [--no-filters]
 
 DESCRIPTION
 -----------
@@ -54,7 +54,7 @@ OPTIONS
 
 --literally::
 	Allow `--stdin` to hash any garbage into a loose object which might not
-	otherwise pass standard object parsing or git-fsck checks. Useful for
+	otherwise pass standard object parsing or `git-fsck` checks. Useful for
 	stress-testing Git itself or reproducing characteristics of corrupt or
 	bogus objects encountered in the wild.
 
diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 392f7be6fa..2d5660f47a 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,13 +8,13 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
+`git help` [-a|--all [--[no-]verbose]] [-g|--guides]
 	   [-i|--info|-m|--man|-w|--web] [COMMAND|GUIDE]
 
 DESCRIPTION
 -----------
 
-With no options and no COMMAND or GUIDE given, the synopsis of the 'git'
+With no options and no COMMAND or GUIDE given, the synopsis of the `git`
 command and a list of the most commonly used Git commands are printed
 on the standard output.
 
@@ -29,7 +29,7 @@ guide is brought up. The 'man' program is used by default for this
 purpose, but this can be overridden by other options or configuration
 variables.
 
-If an alias is given, git shows the definition of the alias on
+If an alias is given, `git` shows the definition of the alias on
 standard output. To get the manual page for the aliased command, use
 `git COMMAND --help`.
 
@@ -38,7 +38,7 @@ former is internally converted into the latter.
 
 To display the linkgit:git[1] man page, use `git help git`.
 
-This page can be displayed with 'git help help' or `git help --help`
+This page can be displayed with `git help help` or `git help --help`
 
 OPTIONS
 -------
@@ -83,8 +83,8 @@ other display programs (see below).
 +
 The web browser can be specified using the configuration variable
 `help.browser`, or `web.browser` if the former is not set. If none of
-these config variables is set, the 'git web{litdd}browse' helper script
-(called by 'git help') will pick a suitable default. See
+these config variables is set, the `git web--browse` helper script
+(called by `git help`) will pick a suitable default. See
 linkgit:git-web{litdd}browse[1] for more information about this.
 
 CONFIGURATION VARIABLES
@@ -95,7 +95,7 @@ help.format
 
 If no command-line option is passed, the `help.format` configuration
 variable will be checked. The following values are supported for this
-variable; they make 'git help' behave as their corresponding command-
+variable; they make `git help` behave as their corresponding command-
 line option:
 
 * "man" corresponds to `-m`|`--man`,
@@ -150,7 +150,7 @@ man.<tool>.path
 You can explicitly provide a full path to your preferred man viewer by
 setting the configuration variable `man.<tool>.path`. For example, you
 can configure the absolute path to konqueror by setting
-`man.konqueror.path`. Otherwise, 'git help' assumes the tool is
+`man.konqueror.path`. Otherwise, `git help` assumes the tool is
 available in PATH.
 
 man.<tool>.cmd
@@ -185,7 +185,7 @@ the following:
 		cmd = A_PATH_TO/konqueror
 ------------------------------------------------
 
-Note about git config --global
+Note about `git config --global`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Note that all these configuration variables should probably be set
diff --git a/Documentation/git-http-backend.txt b/Documentation/git-http-backend.txt
index 558966aa83..c97c10ba09 100644
--- a/Documentation/git-http-backend.txt
+++ b/Documentation/git-http-backend.txt
@@ -8,7 +8,7 @@ git-http-backend - Server side implementation of Git over HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-backend'
+`git http-backend`
 
 DESCRIPTION
 -----------
@@ -19,15 +19,15 @@ and the backwards-compatible dumb HTTP protocol, as well as clients
 pushing using the smart HTTP protocol.
 
 It verifies that the directory has the magic file
-"git-daemon-export-ok", and it will refuse to export any Git directory
+`git-daemon-export-ok`, and it will refuse to export any Git directory
 that hasn't explicitly been marked for export this way (unless the
 `GIT_HTTP_EXPORT_ALL` environmental variable is set).
 
 By default, only the `upload-pack` service is enabled, which serves
-'git fetch-pack' and 'git ls-remote' clients, which are invoked from
-'git fetch', 'git pull', and 'git clone'.  If the client is authenticated,
-the `receive-pack` service is enabled, which serves 'git send-pack'
-clients, which is invoked from 'git push'.
+`git fetch-pack` and `git ls-remote` clients, which are invoked from
+`git fetch`, `git pull`, and `git clone`.  If the client is authenticated,
+the `receive-pack` service is enabled, which serves `git send-pack`
+clients, which is invoked from `git push`.
 
 SERVICES
 --------
@@ -43,12 +43,12 @@ http.getanyfile::
 	by setting this configuration item to `false`.
 
 http.uploadpack::
-	This serves 'git fetch-pack' and 'git ls-remote' clients.
+	This serves `git fetch-pack` and `git ls-remote` clients.
 	It is enabled by default, but a repository can disable it
 	by setting this configuration item to `false`.
 
 http.receivepack::
-	This serves 'git send-pack' clients, allowing push.  It is
+	This serves `git send-pack` clients, allowing push.  It is
 	disabled by default for anonymous users, and enabled by
 	default for users authenticated by the web server.  It can be
 	disabled by setting this item to `false`, or enabled for all
@@ -56,11 +56,11 @@ http.receivepack::
 
 URL TRANSLATION
 ---------------
-To determine the location of the repository on disk, 'git http-backend'
+To determine the location of the repository on disk, `git http-backend`
 concatenates the environment variables PATH_INFO, which is set
 automatically by the web server, and GIT_PROJECT_ROOT, which must be set
 manually in the web server configuration.  If GIT_PROJECT_ROOT is not
-set, 'git http-backend' reads PATH_TRANSLATED, which is also set
+set, `git http-backend` reads PATH_TRANSLATED, which is also set
 automatically by the web server.
 
 EXAMPLES
@@ -135,9 +135,9 @@ directive around the repository, or one of its parent directories:
 </Location>
 ----------------------------------------------------------------
 +
-To serve gitweb at the same url, use a ScriptAliasMatch to only
-those URLs that 'git http-backend' can handle, and forward the
-rest to gitweb:
+To serve `gitweb` at the same url, use a ScriptAliasMatch to only
+those URLs that `git http-backend` can handle, and forward the
+rest to `gitweb`:
 +
 ----------------------------------------------------------------
 ScriptAliasMatch \
@@ -174,7 +174,7 @@ AliasMatch ^/git/(.*/objects/pack/pack-[0-9a-f]{40}.(pack|idx))$ /var/www/git/$1
 ScriptAlias /git/ /usr/libexec/git-core/git-http-backend/
 ----------------------------------------------------------------
 +
-This can be combined with the gitweb configuration:
+This can be combined with the `gitweb` configuration:
 +
 ----------------------------------------------------------------
 SetEnv GIT_PROJECT_ROOT /var/www/git
@@ -241,7 +241,7 @@ $HTTP["url"] =~ "^/git/private" {
 
 ENVIRONMENT
 -----------
-'git http-backend' relies upon the `CGI` environment variables set
+`git http-backend` relies upon the `CGI` environment variables set
 by the invoking web server, including:
 
 * PATH_INFO (if GIT_PROJECT_ROOT is set, otherwise PATH_TRANSLATED)
@@ -252,12 +252,12 @@ by the invoking web server, including:
 * REQUEST_METHOD
 
 The `GIT_HTTP_EXPORT_ALL` environmental variable may be passed to
-'git-http-backend' to bypass the check for the "git-daemon-export-ok"
+`git-http-backend` to bypass the check for the `git-daemon-export-ok`
 file in each repository before allowing export of that repository.
 
 The `GIT_HTTP_MAX_REQUEST_BUFFER` environment variable (or the
 `http.maxRequestBuffer` config variable) may be set to change the
-largest ref negotiation request that git will handle during a fetch; any
+largest ref negotiation request that `git` will handle during a fetch; any
 fetch requiring a larger buffer will not succeed.  This value should not
 normally need to be changed, but may be helpful if you are fetching from
 a repository with an extremely large number of refs.  The value can be
@@ -266,11 +266,11 @@ specified with a unit (e.g., `100M` for 100 megabytes). The default is
 
 The backend process sets GIT_COMMITTER_NAME to '$REMOTE_USER' and
 GIT_COMMITTER_EMAIL to '$\{REMOTE_USER}@http.$\{REMOTE_ADDR\}',
-ensuring that any reflogs created by 'git-receive-pack' contain some
+ensuring that any reflogs created by `git-receive-pack` contain some
 identifying information of the remote user who performed the push.
 
 All `CGI` environment variables are available to each of the hooks
-invoked by the 'git-receive-pack'.
+invoked by the `git-receive-pack`.
 
 GIT
 ---
diff --git a/Documentation/git-http-fetch.txt b/Documentation/git-http-fetch.txt
index 969e553e4a..87028e3312 100644
--- a/Documentation/git-http-fetch.txt
+++ b/Documentation/git-http-fetch.txt
@@ -9,7 +9,7 @@ git-http-fetch - Download from a remote Git repository via HTTP
 SYNOPSIS
 --------
 [verse]
-'git http-fetch' [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
+`git http-fetch` [-c] [-t] [-a] [-d] [-v] [-w filename] [--recover] [--stdin | --packfile=<hash> | <commit>] <url>
 
 DESCRIPTION
 -----------
@@ -36,14 +36,14 @@ commit-id::
 
 --stdin::
 	Instead of a commit id on the command line (which is not expected in this
-	case), 'git http-fetch' expects lines on stdin in the format
+	case), `git http-fetch` expects lines on stdin in the format
 
 		<commit-id>['\t'<filename-as-in--w>]
 
 --packfile=<hash>::
 	For internal use only. Instead of a commit id on the command
 	line (which is not expected in
-	this case), 'git http-fetch' fetches the packfile directly at the given
+	this case), `git http-fetch` fetches the packfile directly at the given
 	URL and uses index-pack to generate corresponding .idx and .keep files.
 	The hash is used to determine the name of the temporary file and is
 	arbitrary. The output of index-pack is printed to stdout. Requires
diff --git a/Documentation/git-http-push.txt b/Documentation/git-http-push.txt
index 7ba8ea2383..85c564c412 100644
--- a/Documentation/git-http-push.txt
+++ b/Documentation/git-http-push.txt
@@ -9,7 +9,7 @@ git-http-push - Push objects over HTTP/DAV to another repository
 SYNOPSIS
 --------
 [verse]
-'git http-push' [--all] [--dry-run] [--force] [--verbose] <url> <ref> [<ref>...]
+`git http-push` [--all] [--dry-run] [--force] [--verbose] <url> <ref> [<ref>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 63cf498ce9..68b1fb19e2 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -9,12 +9,12 @@ git-imap-send - Send a collection of patches from stdin to an IMAP folder
 SYNOPSIS
 --------
 [verse]
-'git imap-send' [-v] [-q] [--[no-]curl]
+`git imap-send` [-v] [-q] [--[no-]curl]
 
 
 DESCRIPTION
 -----------
-This command uploads a mailbox generated with 'git format-patch'
+This command uploads a mailbox generated with `git format-patch`
 into an IMAP drafts folder.  This allows patches to be sent as
 other email is when using mail clients that cannot read mailbox
 files directly. The command also works with any general mailbox
diff --git a/Documentation/git-index-pack.txt b/Documentation/git-index-pack.txt
index bde1cf4a5c..fa859f759d 100644
--- a/Documentation/git-index-pack.txt
+++ b/Documentation/git-index-pack.txt
@@ -9,8 +9,8 @@ git-index-pack - Build pack index file for an existing packed archive
 SYNOPSIS
 --------
 [verse]
-'git index-pack' [-v] [-o <index-file>] [--[no-]rev-index] <pack-file>
-'git index-pack' --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
+`git index-pack` [-v] [-o <index-file>] [--[no-]rev-index] <pack-file>
+`git index-pack` --stdin [--fix-thin] [--keep] [-v] [-o <index-file>]
 		  [--[no-]rev-index] [<pack-file>]
 
 
@@ -51,7 +51,7 @@ OPTIONS
 	a default name determined from the pack content.  If
 	<pack-file> is not specified consider using `--keep` to
 	prevent a race condition between this process and
-	'git repack'.
+	`git repack`.
 
 --fix-thin::
 	Fix a "thin" pack produced by `git pack-objects --thin` (see
@@ -63,7 +63,7 @@ OPTIONS
 	Before moving the index into its final destination
 	create an empty .keep file for the associated pack file.
 	This option is usually necessary with `--stdin` to prevent a
-	simultaneous 'git repack' process from deleting
+	simultaneous `git repack` process from deleting
 	the newly constructed pack and index before refs can be
 	updated to use objects contained in the pack.
 
@@ -123,7 +123,7 @@ Once the index has been created, the hash that goes into the name of
 the pack/idx file is printed to stdout. If `--stdin` was
 also used then this is prefixed by either "pack\t", or "keep\t" if a
 new .keep file was successfully created. This is useful to remove a
-.keep file used as a lock to prevent the race with 'git repack'
+.keep file used as a lock to prevent the race with `git repack`
 mentioned above.
 
 GIT
diff --git a/Documentation/git-init-db.txt b/Documentation/git-init-db.txt
index 648a6cd78a..b62407333b 100644
--- a/Documentation/git-init-db.txt
+++ b/Documentation/git-init-db.txt
@@ -9,7 +9,7 @@ git-init-db - Creates an empty Git repository
 SYNOPSIS
 --------
 [verse]
-'git init-db' [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
+`git init-db` [-q | --quiet] [--bare] [--template=<template_directory>] [--separate-git-dir <git dir>] [--shared[=<permissions>]]
 
 
 DESCRIPTION
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 47d61fc505..2ee178a81c 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -9,7 +9,7 @@ git-init - Create an empty Git repository or reinitialize an existing one
 SYNOPSIS
 --------
 [verse]
-'git init' [-q | --quiet] [--bare] [--template=<template_directory>]
+`git init` [-q | --quiet] [--bare] [--template=<template_directory>]
 	  [--separate-git-dir <git dir>] [--object-format=<format>]
 	  [-b <branch-name> | --initial-branch=<branch-name>]
 	  [--shared[=<permissions>]] [directory]
@@ -32,9 +32,9 @@ If the object storage directory is specified via the
 are created underneath - otherwise the default `$GIT_DIR/objects`
 directory is used.
 
-Running 'git init' in an existing repository is safe. It will not
+Running `git init` in an existing repository is safe. It will not
 overwrite things that are already there. The primary reason for
-rerunning 'git init' is to pick up newly added templates (or to move
+rerunning `git init` is to pick up newly added templates (or to move
 the repository to another place if `--separate-git-dir` is given).
 
 OPTIONS
@@ -99,7 +99,7 @@ specified.
 
 'group' (or 'true')::
 
-Make the repository group-writable, (and g+sx, since the git group may be not
+Make the repository group-writable, (and g+sx, since the `git` group may be not
 the primary group of all users). This is used to loosen the permissions of an
 otherwise safe umask(2) value. Note that the umask still applies to the other
 permission bits (e.g. if umask is '0022', using 'group' will not remove read
diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index a54fe4401b..dfbd3a40ce 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -8,9 +8,9 @@ git-instaweb - Instantly browse your working repository in gitweb
 SYNOPSIS
 --------
 [verse]
-'git instaweb' [--local] [--httpd=<httpd>] [--port=<port>]
+`git instaweb` [--local] [--httpd=<httpd>] [--port=<port>]
                [--browser=<browser>]
-'git instaweb' [--start] [--stop] [--restart]
+`git instaweb` [--start] [--stop] [--restart]
 
 DESCRIPTION
 -----------
@@ -44,9 +44,9 @@ OPTIONS
 
 -b::
 --browser::
-	The web browser that should be used to view the gitweb
-	page. This will be passed to the 'git web{litdd}browse' helper
-	script along with the URL of the gitweb instance. See
+	The web browser that should be used to view the `gitweb`
+	page. This will be passed to the `git web--browse` helper
+	script along with the URL of the `gitweb` instance. See
 	linkgit:git-web{litdd}browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 1160807e0d..b687701104 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -8,8 +8,8 @@ git-interpret-trailers - Add or parse structured information in commit messages
 SYNOPSIS
 --------
 [verse]
-'git interpret-trailers' [<options>] [(--trailer <token>[(=|:)<value>])...] [<file>...]
-'git interpret-trailers' [<options>] [--parse] [<file>...]
+`git interpret-trailers` [<options>] [(--trailer <token>[(=|:)<value>])...] [<file>...]
+`git interpret-trailers` [<options>] [--parse] [<file>...]
 
 DESCRIPTION
 -----------
@@ -138,7 +138,7 @@ trailer.separators::
 	This option tells which characters are recognized as trailer
 	separators. By default only ':' is recognized as a trailer
 	separator, except that '=' is always accepted on the command
-	line for compatibility with other git commands.
+	line for compatibility with other `git` commands.
 +
 The first character given by this option will be the default character
 used when another separator is not specified in the config for this
@@ -358,8 +358,8 @@ See-also: fe3187489d69c4 (subject of related commit)
 * Configure a commit template with some trailers with empty values
   (using sed to show and keep the trailing spaces at the end of the
   trailers), then configure a commit-msg hook that uses
-  'git interpret-trailers' to remove trailers with empty values and
-  to add a 'git-version' trailer:
+  `git interpret-trailers` to remove trailers with empty values and
+  to add a `git-version` trailer:
 +
 ------------
 $ sed -e 's/ Z$/ /' >commit_template.txt <<EOF
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index b306dced1c..a6b3bc1611 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -9,7 +9,7 @@ git-log - Show commit logs
 SYNOPSIS
 --------
 [verse]
-'git log' [<options>] [<revision range>] [[--] <path>...]
+`git log` [<options>] [<revision range>] [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -133,14 +133,14 @@ EXAMPLES
 
 `git log --since="2 weeks ago" -- gitk`::
 
-	Show the changes during the last two weeks to the file 'gitk'.
+	Show the changes during the last two weeks to the file `gitk`.
 	The `--` is necessary to avoid confusion with the *branch* named
-	'gitk'
+	`gitk`
 
 `git log --name-status release..test`::
 
-	Show the commits that are in the "test" branch but not yet
-	in the "release" branch, along with the list of paths
+	Show the commits that are in the `test` branch but not yet
+	in the `release` branch, along with the list of paths
 	each commit modifies.
 
 `git log --follow builtin/rev-list.c`::
diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
index d27a33eb22..ee435024da 100644
--- a/Documentation/git-ls-files.txt
+++ b/Documentation/git-ls-files.txt
@@ -9,7 +9,7 @@ git-ls-files - Show information about files in the index and the working tree
 SYNOPSIS
 --------
 [verse]
-'git ls-files' [-z] [-t] [-v] [-f]
+`git ls-files` [-z] [-t] [-v] [-f]
 		(--[cached|deleted|others|ignored|stage|unmerged|killed|modified])*
 		(-[c|d|o|i|s|u|k|m])*
 		[--eol]
@@ -196,15 +196,15 @@ followed by the  ("attr/<eolattr>").
 
 OUTPUT
 ------
-'git ls-files' just outputs the filenames unless `--stage` is specified in
+`git ls-files` just outputs the filenames unless `--stage` is specified in
 which case it outputs:
 
         [<tag> ]<mode> <object> <stage> <file>
 
-'git ls-files --eol' will show
+`git ls-files --eol` will show
 	i/<eolinfo><SPACES>w/<eolinfo><SPACES>attr/<eolattr><SPACE*><TAB><file>
 
-'git ls-files --unmerged' and 'git ls-files --stage' can be used to examine
+`git ls-files --unmerged` and `git ls-files --stage` can be used to examine
 detailed information on unmerged paths.
 
 For an unmerged path, instead of recording a single mode/SHA-1 pair,
@@ -222,7 +222,7 @@ verbatim and the line is terminated by a NUL byte.
 EXCLUDE PATTERNS
 ----------------
 
-'git ls-files' can use a list of "exclude patterns" when
+`git ls-files` can use a list of "exclude patterns" when
 traversing the directory tree and finding files to show when the
 flags `--others` or `--ignored` are specified.  linkgit:gitignore[5]
 specifies the format of exclude patterns.
@@ -238,7 +238,7 @@ These exclude patterns come from these places, in order:
      in the same order they appear in the file.
 
   3. The command-line flag `--exclude-per-directory=<name>` specifies
-     a name of the file in each directory 'git ls-files'
+     a name of the file in each directory `git ls-files`
      examines, normally `.gitignore`.  Files in deeper
      directories take precedence.  Patterns are ordered in the
      same order they appear in the files.
diff --git a/Documentation/git-ls-remote.txt b/Documentation/git-ls-remote.txt
index dbe0c69298..cc1525f487 100644
--- a/Documentation/git-ls-remote.txt
+++ b/Documentation/git-ls-remote.txt
@@ -9,7 +9,7 @@ git-ls-remote - List references in a remote repository
 SYNOPSIS
 --------
 [verse]
-'git ls-remote' [--heads] [--tags] [--refs] [--upload-pack=<exec>]
+`git ls-remote` [--heads] [--tags] [--refs] [--upload-pack=<exec>]
 	      [-q | --quiet] [--exit-code] [--get-url] [--sort=<key>]
 	      [--symref] [<repository> [<refs>...]]
 
@@ -30,7 +30,7 @@ OPTIONS
 	both, references stored in refs/heads and refs/tags are
 	displayed.  Note that `git ls-remote -h` used without
 	anything else on the command line gives help, consistent
-	with other git subcommands.
+	with other `git` subcommands.
 
 --refs::
 	Do not show peeled tags or pseudorefs like `HEAD` in the output.
@@ -40,7 +40,7 @@ OPTIONS
 	Do not print remote URL to stderr.
 
 --upload-pack=<exec>::
-	Specify the full path of 'git-upload-pack' on the remote
+	Specify the full path of `git-upload-pack` on the remote
 	host. This allows listing references from repositories accessed via
 	SSH and where the SSH daemon does not use the PATH configured by the
 	user.
diff --git a/Documentation/git-ls-tree.txt b/Documentation/git-ls-tree.txt
index 6ed9030c1e..82c802d918 100644
--- a/Documentation/git-ls-tree.txt
+++ b/Documentation/git-ls-tree.txt
@@ -9,7 +9,7 @@ git-ls-tree - List the contents of a tree object
 SYNOPSIS
 --------
 [verse]
-'git ls-tree' [-d] [-r] [-t] [-l] [-z]
+`git ls-tree` [-d] [-r] [-t] [-l] [-z]
 	    [--name-only] [--name-status] [--full-name] [--full-tree] [--abbrev[=<n>]]
 	    <tree-ish> [<path>...]
 
@@ -25,8 +25,8 @@ in the current working directory.  Note that:
 
  - the behaviour is similar to that of "/bin/ls" in that the '<path>' is
    taken as relative to the current working directory.  E.g. when you are
-   in a directory 'sub' that has a directory 'dir', you can run 'git
-   ls-tree -r HEAD dir' to list the contents of the tree (that is
+   in a directory 'sub' that has a directory 'dir', you can run `git
+   ls-tree -r HEAD dir` to list the contents of the tree (that is
    `sub/dir` in `HEAD`).  You don't want to give a tree that is not at the
    root level (e.g. `git ls-tree -r HEAD:sub dir`) in this case, as that
    would result in asking for `sub/sub/dir` in the `HEAD` commit.
@@ -85,7 +85,7 @@ Output Format
         <mode> SP <type> SP <object> TAB <file>
 
 This output format is compatible with what `--index-info --stdin` of
-'git update-index' expects.
+`git update-index` expects.
 
 When the `-l` option is used, format changes to
 
diff --git a/Documentation/git-mailinfo.txt b/Documentation/git-mailinfo.txt
index c54feb665b..b47e92ee57 100644
--- a/Documentation/git-mailinfo.txt
+++ b/Documentation/git-mailinfo.txt
@@ -9,7 +9,7 @@ git-mailinfo - Extracts patch and authorship from a single e-mail message
 SYNOPSIS
 --------
 [verse]
-'git mailinfo' [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
+`git mailinfo` [-k|-b] [-u | --encoding=<encoding> | -n] [--[no-]scissors] <msg> <patch>
 
 
 DESCRIPTION
@@ -17,7 +17,7 @@ DESCRIPTION
 Reads a single e-mail message from the standard input, and
 writes the commit log message in <msg> file, and the patches in
 <patch> file.  The author name, e-mail and e-mail subject are
-written out to the standard output to be used by 'git am'
+written out to the standard output to be used by `git am`
 to create a commit.  It is usually not necessary to use this
 command directly.  See linkgit:git-am[1] instead.
 
@@ -28,7 +28,7 @@ OPTIONS
 	Usually the program removes email cruft from the Subject:
 	header line to extract the title line for the commit log
 	message.  This option prevents this munging, and is most
-	useful when used to read back 'git format-patch -k' output.
+	useful when used to read back `git format-patch -k` output.
 +
 Specifically, the following are removed until none of them remain:
 +
diff --git a/Documentation/git-mailsplit.txt b/Documentation/git-mailsplit.txt
index 6e357716ec..151c4f96be 100644
--- a/Documentation/git-mailsplit.txt
+++ b/Documentation/git-mailsplit.txt
@@ -8,7 +8,7 @@ git-mailsplit - Simple UNIX mbox splitter program
 SYNOPSIS
 --------
 [verse]
-'git mailsplit' [-b] [-f<nn>] [-d<prec>] [--keep-cr] [--mboxrd]
+`git mailsplit` [-b] [-f<nn>] [-d<prec>] [--keep-cr] [--mboxrd]
 		-o<directory> [--] [(<mbox>|<Maildir>)...]
 
 DESCRIPTION
diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
index 80ddd33ceb..c69b3cec4f 100644
--- a/Documentation/git-maintenance.txt
+++ b/Documentation/git-maintenance.txt
@@ -9,7 +9,7 @@ git-maintenance - Run tasks to optimize Git repository data
 SYNOPSIS
 --------
 [verse]
-'git maintenance' run [<options>]
+`git maintenance` run [<options>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2d944e0851..323bc045bf 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -9,16 +9,16 @@ git-merge-base - Find as good common ancestors as possible for a merge
 SYNOPSIS
 --------
 [verse]
-'git merge-base' [-a|--all] <commit> <commit>...
-'git merge-base' [-a|--all] --octopus <commit>...
-'git merge-base' --is-ancestor <commit> <commit>
-'git merge-base' --independent <commit>...
-'git merge-base' --fork-point <ref> [<commit>]
+`git merge-base` [-a|--all] <commit> <commit>...
+`git merge-base` [-a|--all] --octopus <commit>...
+`git merge-base` --is-ancestor <commit> <commit>
+`git merge-base` --independent <commit>...
+`git merge-base` --fork-point <ref> [<commit>]
 
 DESCRIPTION
 -----------
 
-'git merge-base' finds best common ancestor(s) between two commits to use
+`git merge-base` finds best common ancestor(s) between two commits to use
 in a three-way merge.  One common ancestor is 'better' than another common
 ancestor if the latter is an ancestor of the former.  A common ancestor
 that does not have any better common ancestor is a 'best common
@@ -43,14 +43,14 @@ from linkgit:git-show-branch[1] when used with the `--merge-base` option.
 --octopus::
 	Compute the best common ancestors of all supplied commits,
 	in preparation for an n-way merge.  This mimics the behavior
-	of 'git show-branch --merge-base'.
+	of `git show-branch --merge-base`.
 
 --independent::
 	Instead of printing merge bases, print a minimal subset of
 	the supplied commits with the same ancestors.  In other words,
 	among the commits given, list those which cannot be reached
-	from any other.  This mimics the behavior of 'git show-branch
-	--independent'.
+	from any other.  This mimics the behavior of `git show-branch
+	--independent`.
 
 --is-ancestor::
 	Check if the first <commit> is an ancestor of the second <commit>,
@@ -147,7 +147,7 @@ then
 fi
 ....
 
-In modern git, you can say this in a more direct way:
+In modern `git`, you can say this in a more direct way:
 
 ....
 if git merge-base --is-ancestor A B
diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index f856032613..427f93cd8c 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -9,22 +9,22 @@ git-merge-file - Run a three-way file merge
 SYNOPSIS
 --------
 [verse]
-'git merge-file' [-L <current-name> [-L <base-name> [-L <other-name>]]]
+`git merge-file` [-L <current-name> [-L <base-name> [-L <other-name>]]]
 	[--ours|--theirs|--union] [-p|--stdout] [-q|--quiet] [--marker-size=<n>]
 	[--[no-]diff3] <current-file> <base-file> <other-file>
 
 
 DESCRIPTION
 -----------
-'git merge-file' incorporates all changes that lead from the `<base-file>`
+`git merge-file` incorporates all changes that lead from the `<base-file>`
 to `<other-file>` into `<current-file>`. The result ordinarily goes into
-`<current-file>`. 'git merge-file' is useful for combining separate changes
+`<current-file>`. `git merge-file` is useful for combining separate changes
 to an original. Suppose `<base-file>` is the original, and both
 `<current-file>` and `<other-file>` are modifications of `<base-file>`,
-then 'git merge-file' combines both changes.
+then `git merge-file` combines both changes.
 
 A conflict occurs if both `<current-file>` and `<other-file>` have changes
-in a common segment of lines. If a conflict is found, 'git merge-file'
+in a common segment of lines. If a conflict is found, `git merge-file`
 normally outputs a warning and brackets the conflict with lines containing
 <<<<<<< and >>>>>>> markers. A typical conflict will look like this:
 
@@ -44,7 +44,7 @@ The exit value of this program is negative on error, and the number of
 conflicts otherwise (truncated to 127 if there are more than that many
 conflicts). If the merge was clean, the exit value is 0.
 
-'git merge-file' is designed to be a minimal clone of RCS 'merge'; that is, it
+`git merge-file` is designed to be a minimal clone of RCS 'merge'; that is, it
 implements all of RCS 'merge''s functionality which is needed by
 linkgit:git[1].
 
diff --git a/Documentation/git-merge-index.txt b/Documentation/git-merge-index.txt
index 9fdfe6a31b..be978144d5 100644
--- a/Documentation/git-merge-index.txt
+++ b/Documentation/git-merge-index.txt
@@ -9,7 +9,7 @@ git-merge-index - Run a merge for files needing merging
 SYNOPSIS
 --------
 [verse]
-'git merge-index' [-o] [-q] <merge-program> (-a | [--] <file>*)
+`git merge-index` [-o] [-q] <merge-program> (-a | [--] <file>*)
 
 DESCRIPTION
 -----------
@@ -37,14 +37,14 @@ OPTIONS
 	failure usually indicates conflicts during the merge). This is for
 	porcelains which might want to emit custom messages.
 
-If 'git merge-index' is called with multiple <file>s (or `-a`) then it
+If `git merge-index` is called with multiple <file>s (or `-a`) then it
 processes them in turn only stopping if merge returns a non-zero exit
 code.
 
 Typically this is run with a script calling Git's imitation of
 the 'merge' command from the RCS package.
 
-A sample script called 'git merge-one-file' is included in the
+A sample script called `git merge-one-file` is included in the
 distribution.
 
 ALERT ALERT ALERT! The Git "merge object order" is different from the
@@ -73,10 +73,10 @@ This is added AA in the branch B.
 fatal: merge program failed
 ----
 
-where the latter example shows how 'git merge-index' will stop trying to
+where the latter example shows how `git merge-index` will stop trying to
 merge once anything has returned an error (i.e., `cat` returned an error
 for the AA file, because it didn't exist in the original, and thus
-'git merge-index' didn't even try to merge the MM thing).
+`git merge-index` didn't even try to merge the MM thing).
 
 GIT
 ---
diff --git a/Documentation/git-merge-one-file.txt b/Documentation/git-merge-one-file.txt
index 04e803d5d3..a4ef1d0865 100644
--- a/Documentation/git-merge-one-file.txt
+++ b/Documentation/git-merge-one-file.txt
@@ -9,12 +9,12 @@ git-merge-one-file - The standard helper program to use with git-merge-index
 SYNOPSIS
 --------
 [verse]
-'git merge-one-file'
+`git merge-one-file`
 
 DESCRIPTION
 -----------
-This is the standard helper program to use with 'git merge-index'
-to resolve a merge after the trivial merge done with 'git read-tree -m'.
+This is the standard helper program to use with `git merge-index`
+to resolve a merge after the trivial merge done with `git read-tree -m`.
 
 GIT
 ---
diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 58731c1942..c688cb4def 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -9,13 +9,13 @@ git-merge-tree - Show three-way merge without touching index
 SYNOPSIS
 --------
 [verse]
-'git merge-tree' <base-tree> <branch1> <branch2>
+`git merge-tree` <base-tree> <branch1> <branch2>
 
 DESCRIPTION
 -----------
 Reads three tree-ish, and output trivial merge results and
 conflicting stages to the standard output.  This is similar to
-what three-way 'git read-tree -m' does, but instead of storing the
+what three-way `git read-tree -m` does, but instead of storing the
 results in the index, the command outputs the entries to the
 standard output.
 
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 58fd091d73..029c7807db 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -9,17 +9,17 @@ git-merge - Join two or more development histories together
 SYNOPSIS
 --------
 [verse]
-'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
+`git merge` [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
 	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
 	[--[no-]allow-unrelated-histories]
 	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
-'git merge' (--continue | --abort | --quit)
+`git merge` (--continue | --abort | --quit)
 
 DESCRIPTION
 -----------
 Incorporates changes from the named commits (since the time their
 histories diverged from the current branch) into the current
-branch.  This command is used by 'git pull' to incorporate changes
+branch.  This command is used by `git pull` to incorporate changes
 from another repository and can be used by hand to merge changes
 from one branch into another.
 
@@ -45,14 +45,14 @@ a log message from the user describing the changes.
 ------------
 
 The second syntax ("`git merge --abort`") can only be run after the
-merge has resulted in conflicts. 'git merge --abort' will abort the
+merge has resulted in conflicts. `git merge --abort` will abort the
 merge process and try to reconstruct the pre-merge state. However,
 if there were uncommitted changes when the merge started (and
 especially if those changes were further modified after the merge
-was started), 'git merge --abort' will in some cases be unable to
+was started), `git merge --abort` will in some cases be unable to
 reconstruct the original (pre-merge) changes. Therefore:
 
-*Warning*: Running 'git merge' with non-trivial uncommitted changes is
+*Warning*: Running `git merge` with non-trivial uncommitted changes is
 discouraged: while possible, it may leave you in a state that is hard to
 back out of in the case of a conflict.
 
@@ -70,8 +70,8 @@ include::merge-options.txt[]
 If `--log` is specified, a shortlog of the commits being merged
 will be appended to the specified message.
 +
-The 'git fmt-merge-msg' command can be
-used to give a good default for automated 'git merge'
+The `git fmt-merge-msg` command can be
+used to give a good default for automated `git merge`
 invocations. The automated message can include the branch description.
 
 -F <file>::
@@ -98,14 +98,14 @@ will be appended to the specified message.
 	present, apply it to the worktree.
 +
 If there were uncommitted worktree changes present when the merge
-started, 'git merge --abort' will in some cases be unable to
+started, `git merge --abort` will in some cases be unable to
 reconstruct these changes. It is therefore recommended to always
-commit or stash your changes before running 'git merge'.
+commit or stash your changes before running `git merge`.
 +
-'git merge --abort' is equivalent to 'git reset --merge' when
+`git merge --abort` is equivalent to `git reset --merge` when
 `MERGE_HEAD` is present unless `MERGE_AUTOSTASH` is also present in
-which case 'git merge --abort' applies the stash entry to the worktree
-whereas 'git reset --merge' will save the stashed changes in the stash
+which case `git merge --abort` applies the stash entry to the worktree
+whereas `git reset --merge` will save the stashed changes in the stash
 list.
 
 --quit::
@@ -114,8 +114,8 @@ list.
 	stash entry will be saved to the stash list.
 
 --continue::
-	After a 'git merge' stops due to conflicts you can conclude the
-	merge by running 'git merge --continue' (see "HOW TO RESOLVE
+	After a `git merge` stops due to conflicts you can conclude the
+	merge by running `git merge --continue` (see "HOW TO RESOLVE
 	CONFLICTS" section below).
 
 <commit>...::
@@ -138,25 +138,25 @@ PRE-MERGE CHECKS
 Before applying outside changes, you should get your own work in
 good shape and committed locally, so it will not be clobbered if
 there are conflicts.  See also linkgit:git-stash[1].
-'git pull' and 'git merge' will stop without doing anything when
-local uncommitted changes overlap with files that 'git pull'/'git
-merge' may need to update.
+`git pull` and `git merge` will stop without doing anything when
+local uncommitted changes overlap with files that `git pull`/`git
+merge` may need to update.
 
 To avoid recording unrelated changes in the merge commit,
-'git pull' and 'git merge' will also abort if there are any changes
+`git pull` and `git merge` will also abort if there are any changes
 registered in the index relative to the `HEAD` commit.  (Special
 narrow exceptions to this rule may exist depending on which merge
 strategy is in use, but generally, the index must match `HEAD`.)
 
-If all named commits are already ancestors of `HEAD`, 'git merge'
-will exit early with the message "Already up to date."
+If all named commits are already ancestors of `HEAD`, `git merge`
+will exit early with the message Already up to date.
 
 FAST-FORWARD MERGE
 ------------------
 
 Often the current branch head is an ancestor of the named commit.
-This is the most common case especially when invoked from 'git
-pull': you are tracking an upstream repository, you have committed
+This is the most common case especially when invoked from `git
+pull`: you are tracking an upstream repository, you have committed
 no local changes, and now you want to update to a newer upstream
 revision.  In this case, a new commit is not needed to store the
 combined history; instead, the `HEAD` (along with the index) is
@@ -296,10 +296,10 @@ After seeing a conflict, you can do two things:
 
  * Resolve the conflicts.  Git will mark the conflicts in
    the working tree.  Edit the files into shape and
-   'git add' them to the index.  Use 'git commit' or
-   'git merge --continue' to seal the deal. The latter command
+   `git add` them to the index.  Use `git commit` or
+   `git merge --continue` to seal the deal. The latter command
    checks whether there is a (interrupted) merge in progress
-   before calling 'git commit'.
+   before calling `git commit`.
 
 You can work through the conflict with a number of tools:
 
@@ -360,7 +360,7 @@ include::config/merge.txt[]
 
 branch.<name>.mergeOptions::
 	Sets default options for merging into branch <name>. The syntax and
-	supported options are the same as those of 'git merge', but option
+	supported options are the same as those of `git merge`, but option
 	values containing whitespace characters are currently not supported.
 
 SEE ALSO
diff --git a/Documentation/git-mergetool--lib.txt b/Documentation/git-mergetool--lib.txt
index 3e8f59ac0e..8177c877e2 100644
--- a/Documentation/git-mergetool--lib.txt
+++ b/Documentation/git-mergetool--lib.txt
@@ -17,11 +17,11 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 Porcelain-ish scripts and/or are writing new ones.
 
-The 'git-mergetool{litdd}lib' scriptlet is designed to be sourced (using
+The `git-mergetool--lib` scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up functions for working
 with Git merge tools.
 
-Before sourcing 'git-mergetool{litdd}lib', your script must set `TOOL_MODE`
+Before sourcing `git-mergetool--lib`, your script must set `TOOL_MODE`
 to define the operation mode for the functions listed below.
 'diff' and 'merge' are valid values.
 
diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index e587c7763a..530f8a278f 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -8,18 +8,18 @@ git-mergetool - Run merge conflict resolution tools to resolve merge conflicts
 SYNOPSIS
 --------
 [verse]
-'git mergetool' [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
+`git mergetool` [--tool=<tool>] [-y | --[no-]prompt] [<file>...]
 
 DESCRIPTION
 -----------
 
 Use `git mergetool` to run one of several merge utilities to resolve
-merge conflicts.  It is typically run after 'git merge'.
+merge conflicts.  It is typically run after `git merge`.
 
 If one or more <file> parameters are given, the merge tool program will
 be run to resolve differences on each file (skipping those without
 conflicts).  Specifying a directory will include all unresolved files in
-that path.  If no <file> names are specified, 'git mergetool' will run
+that path.  If no <file> names are specified, `git mergetool` will run
 the merge tool program on every file with merge conflicts.
 
 OPTIONS
@@ -31,23 +31,23 @@ OPTIONS
 	meld, vimdiff, and tortoisemerge. Run `git mergetool --tool-help`
 	for the list of valid <tool> settings.
 +
-If a merge resolution program is not specified, 'git mergetool'
+If a merge resolution program is not specified, `git mergetool`
 will use the configuration variable `merge.tool`.  If the
-configuration variable `merge.tool` is not set, 'git mergetool'
+configuration variable `merge.tool` is not set, `git mergetool`
 will pick a suitable default.
 +
 You can explicitly provide a full path to the tool by setting the
 configuration variable `mergetool.<tool>.path`. For example, you
 can configure the absolute path to kdiff3 by setting
-`mergetool.kdiff3.path`. Otherwise, 'git mergetool' assumes the
+`mergetool.kdiff3.path`. Otherwise, `git mergetool` assumes the
 tool is available in PATH.
 +
 Instead of running one of the known merge tool programs,
-'git mergetool' can be customized to run an alternative program
+`git mergetool` can be customized to run an alternative program
 by specifying the command line to invoke in a configuration
 variable `mergetool.<tool>.cmd`.
 +
-When 'git mergetool' is invoked with this tool (either through the
+When `git mergetool` is invoked with this tool (either through the
 `-t` or `--tool` option or the `merge.tool` configuration
 variable) the configured command line will be invoked with `$BASE`
 set to the name of a temporary file containing the common base for
@@ -61,7 +61,7 @@ merge resolution.
 If the custom merge tool correctly indicates the success of a
 merge resolution with its exit code, then the configuration
 variable `mergetool.<tool>.trustExitCode` can be set to `true`.
-Otherwise, 'git mergetool' will prompt the user to indicate the
+Otherwise, `git mergetool` will prompt the user to indicate the
 success of the resolution after the custom tool has exited.
 
 --tool-help::
@@ -81,7 +81,7 @@ success of the resolution after the custom tool has exited.
 
 -g::
 --gui::
-	When 'git-mergetool' is invoked with the `-g` or `--gui` option
+	When `git-mergetool` is invoked with the `-g` or `--gui` option
 	the default merge tool will be read from the configured
 	`merge.guitool` variable instead of `merge.tool`. If
 	`merge.guitool` is not set, we will fallback to the tool
diff --git a/Documentation/git-mktag.txt b/Documentation/git-mktag.txt
index 17a2603a60..1ba01b1a9b 100644
--- a/Documentation/git-mktag.txt
+++ b/Documentation/git-mktag.txt
@@ -9,7 +9,7 @@ git-mktag - Creates a tag object with extra validation
 SYNOPSIS
 --------
 [verse]
-'git mktag'
+`git mktag`
 
 OPTIONS
 -------
diff --git a/Documentation/git-mktree.txt b/Documentation/git-mktree.txt
index 27fe2b32e1..709e05ab6f 100644
--- a/Documentation/git-mktree.txt
+++ b/Documentation/git-mktree.txt
@@ -9,7 +9,7 @@ git-mktree - Build a tree-object from ls-tree formatted text
 SYNOPSIS
 --------
 [verse]
-'git mktree' [-z] [--missing] [--batch]
+`git mktree` [-z] [--missing] [--batch]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-multi-pack-index.txt b/Documentation/git-multi-pack-index.txt
index ffd601bc17..ff56181795 100644
--- a/Documentation/git-multi-pack-index.txt
+++ b/Documentation/git-multi-pack-index.txt
@@ -9,7 +9,7 @@ git-multi-pack-index - Write and verify multi-pack-indexes
 SYNOPSIS
 --------
 [verse]
-'git multi-pack-index' [--object-dir=<dir>] [--[no-]progress]
+`git multi-pack-index` [--object-dir=<dir>] [--[no-]progress]
 	[--preferred-pack=<pack>] <subcommand>
 
 DESCRIPTION
@@ -65,7 +65,7 @@ repack::
 	are considered. If only one pack-file is selected, then do
 	nothing. If a new pack-file is created, rewrite the
 	multi-pack-index to reference the new pack-file. A later run of
-	'git multi-pack-index expire' will delete the pack-files that
+	`git multi-pack-index expire` will delete the pack-files that
 	were part of this batch.
 +
 If `repack.packKeptObjects` is `false`, then any pack-files with an
diff --git a/Documentation/git-mv.txt b/Documentation/git-mv.txt
index ceb039a697..183e7d5770 100644
--- a/Documentation/git-mv.txt
+++ b/Documentation/git-mv.txt
@@ -9,14 +9,14 @@ git-mv - Move or rename a file, a directory, or a symlink
 SYNOPSIS
 --------
 [verse]
-'git mv' <options>... <args>...
+`git mv` <options>... <args>...
 
 DESCRIPTION
 -----------
 Move or rename a file, directory or symlink.
 
- git mv [-v] [-f] [-n] [-k] <source> <destination>
- git mv [-v] [-f] [-n] [-k] <source> ... <destination directory>
+ `git mv` [-v] [-f] [-n] [-k] <source> <destination>
+ `git mv` [-v] [-f] [-n] [-k] <source> ... <destination directory>
 
 In the first form, it renames <source>, which must exist and be either
 a file, symlink or directory, to <destination>.
@@ -58,7 +58,7 @@ Each time a superproject update moves a populated submodule (e.g. when
 switching between commits before and after the move) a stale submodule
 checkout will remain in the old location and an empty directory will
 appear in the new location. To populate the submodule again in the new
-location the user will have to run "git submodule update"
+location the user will have to run `git submodule update`
 afterwards. Removing the old directory is only safe when it uses a
 gitfile, as otherwise the history of the submodule will be deleted
 too. Both steps will be obsolete when recursive submodule update has
diff --git a/Documentation/git-name-rev.txt b/Documentation/git-name-rev.txt
index 99979fe55b..c6c1f89117 100644
--- a/Documentation/git-name-rev.txt
+++ b/Documentation/git-name-rev.txt
@@ -9,13 +9,13 @@ git-name-rev - Find symbolic names for given revs
 SYNOPSIS
 --------
 [verse]
-'git name-rev' [--tags] [--refs=<pattern>]
+`git name-rev` [--tags] [--refs=<pattern>]
 	       ( --all | --stdin | <commit-ish>... )
 
 DESCRIPTION
 -----------
 Finds symbolic names suitable for human digestion for revisions given in any
-format parsable by 'git rev-parse'.
+format parsable by `git rev-parse`.
 
 
 OPTIONS
@@ -69,7 +69,7 @@ wrote you about that fantastic commit 33db5f4d9027a10e477ccf054b2c1ab94f74c85a.
 Of course, you look into the commit, but that only tells you what happened, but
 not the context.
 
-Enter 'git name-rev':
+Enter `git name-rev`:
 
 ------------
 % git name-rev 33db5f4d9027a10e477ccf054b2c1ab94f74c85a
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index ac1d191352..8f25b07f10 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -8,18 +8,18 @@ git-notes - Add or inspect object notes
 SYNOPSIS
 --------
 [verse]
-'git notes' [list [<object>]]
-'git notes' add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' copy [-f] ( --stdin | <from-object> [<to-object>] )
-'git notes' append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
-'git notes' edit [--allow-empty] [<object>]
-'git notes' show [<object>]
-'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
-'git notes' merge --commit [-v | -q]
-'git notes' merge --abort [-v | -q]
-'git notes' remove [--ignore-missing] [--stdin] [<object>...]
-'git notes' prune [-n] [-v]
-'git notes' get-ref
+`git notes` [list [<object>]]
+`git notes` add [-f] [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+`git notes` copy [-f] ( --stdin | <from-object> [<to-object>] )
+`git notes` append [--allow-empty] [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
+`git notes` edit [--allow-empty] [<object>]
+`git notes` show [<object>]
+`git notes` merge [-v | -q] [-s <strategy> ] <notes-ref>
+`git notes` merge --commit [-v | -q]
+`git notes` merge --abort [-v | -q]
+`git notes` remove [--ignore-missing] [--stdin] [<object>...]
+`git notes` prune [-n] [-v]
+`git notes` get-ref
 
 
 DESCRIPTION
@@ -33,7 +33,7 @@ ENVIRONMENT sections below.  If this ref does not exist, it will be
 quietly created when it is first needed to store a note.
 
 A typical use of notes is to supplement a commit message without
-changing the commit itself. Notes can be shown by 'git log' along with
+changing the commit itself. Notes can be shown by `git log` along with
 the original commit message. To distinguish these notes from the
 message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
@@ -43,7 +43,7 @@ Notes can also be added to patches prepared with `git format-patch` by
 using the `--notes` option. Such notes are added as a patch commentary
 after a three dash separator line.
 
-To change which notes are shown by 'git log', see the
+To change which notes are shown by `git log`, see the
 `notes.displayRef` configuration in linkgit:git-log[1].
 
 See the `notes.rewrite.<command>` configuration for a way to carry
@@ -106,8 +106,8 @@ the "manual" resolver is used. This resolver checks out the
 conflicting notes in a special worktree (`.git/NOTES_MERGE_WORKTREE`),
 and instructs the user to manually resolve the conflicts there.
 When done, the user can either finalize the merge with
-'git notes merge --commit', or abort the merge with
-'git notes merge --abort'.
+`git notes merge --commit`, or abort the merge with
+`git notes merge --abort`.
 
 remove::
 	Remove the notes for given objects (defaults to `HEAD`). When
@@ -190,16 +190,16 @@ OPTIONS
 	information on each notes merge strategy.
 
 --commit::
-	Finalize an in-progress 'git notes merge'. Use this option
-	when you have resolved the conflicts that 'git notes merge'
+	Finalize an in-progress `git notes merge`. Use this option
+	when you have resolved the conflicts that `git notes merge`
 	stored in .git/NOTES_MERGE_WORKTREE. This amends the partial
-	merge commit created by 'git notes merge' (stored in
+	merge commit created by `git notes merge` (stored in
 	.git/NOTES_MERGE_PARTIAL) by adding the notes in
 	.git/NOTES_MERGE_WORKTREE. The notes ref stored in the
 	.git/NOTES_MERGE_REF symref is updated to the resulting commit.
 
 --abort::
-	Abort/reset an in-progress 'git notes merge', i.e. a notes merge
+	Abort/reset an in-progress `git notes merge`, i.e. a notes merge
 	with conflicts. This simply removes all files related to the
 	notes merge.
 
@@ -247,8 +247,8 @@ conflicting notes in a special work tree for resolving notes conflicts
 (`.git/NOTES_MERGE_WORKTREE`), and instructs the user to resolve the
 conflicts in that work tree.
 When done, the user can either finalize the merge with
-'git notes merge --commit', or abort the merge with
-'git notes merge --abort'.
+`git notes merge --commit`, or abort the merge with
+`git notes merge --abort`.
 
 Users may select an automated merge strategy from among the following using
 either `-s`/`--strategy` option or configuring `notes.mergeStrategy` accordingly:
@@ -292,7 +292,7 @@ Notes:
 
 In principle, a note is a regular Git blob, and any kind of
 (non-)format is accepted.  You can binary-safely create notes from
-arbitrary files using 'git hash-object':
+arbitrary files using `git hash-object`:
 
 ------------
 $ cc *.c
@@ -303,7 +303,7 @@ $ git notes --ref=built add --allow-empty -C "$blob" HEAD
 (You cannot simply use `git notes --ref=built add -F a.out HEAD`
 because that is not binary-safe.)
 Of course, it doesn't make much sense to display non-text-format notes
-with 'git log', so if you use such notes, you'll probably need to write
+with `git log`, so if you use such notes, you'll probably need to write
 some special-purpose tools to do something useful with them.
 
 
@@ -334,14 +334,14 @@ notes.displayRef::
 	Which ref (or refs, if a glob or specified more than once), in
 	addition to the default set by `core.notesRef` or
 	`GIT_NOTES_REF`, to read notes from when showing commit
-	messages with the 'git log' family of commands.
+	messages with the `git log` family of commands.
 	This setting can be overridden on the command line or by the
 	`GIT_NOTES_DISPLAY_REF` environment variable.
 	See linkgit:git-log[1].
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
-	`rebase`), if this variable is `false`, git will not copy
+	`rebase`), if this variable is `false`, `git` will not copy
 	notes from the original to the rewritten commit.  Defaults to
 	`true`.  See also "`notes.rewriteRef`" below.
 +
diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 326c553083..093f023ac5 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -9,10 +9,10 @@ git-p4 - Import from and submit to Perforce repositories
 SYNOPSIS
 --------
 [verse]
-'git p4 clone' [<sync options>] [<clone options>] <p4 depot path>...
-'git p4 sync' [<sync options>] [<p4 depot path>...]
-'git p4 rebase'
-'git p4 submit' [<submit options>] [<master branch name>]
+`git p4 clone` [<sync options>] [<clone options>] <p4 depot path>...
+`git p4 sync` [<sync options>] [<p4 depot path>...]
+`git p4 rebase`
+`git p4 submit` [<submit options>] [<master branch name>]
 
 
 DESCRIPTION
@@ -21,11 +21,11 @@ This command provides a way to interact with p4 repositories
 using Git.
 
 Create a new Git repository from an existing p4 repository using
-'git p4 clone', giving it one or more p4 depot paths.  Incorporate
-new commits from p4 changes with 'git p4 sync'.  The 'sync' command
+`git p4 clone`, giving it one or more p4 depot paths.  Incorporate
+new commits from p4 changes with `git p4 sync`.  The 'sync' command
 is also used to include new branches from other p4 depot paths.
-Submit Git changes back to p4 using 'git p4 submit'.  The command
-'git p4 rebase' does a sync plus rebases the current branch onto
+Submit Git changes back to p4 using `git p4 submit`.  The command
+`git p4 rebase` does a sync plus rebases the current branch onto
 the updated p4 remote branch.
 
 
@@ -64,7 +64,7 @@ COMMANDS
 
 Clone
 ~~~~~
-Generally, 'git p4 clone' is used to create a new Git directory
+Generally, `git p4 clone` is used to create a new Git directory
 from an existing p4 repository:
 ------------
 $ git p4 clone //depot/path/project
@@ -95,7 +95,7 @@ $ git p4 sync
 This command finds new changes in p4 and imports them as Git commits.
 
 P4 repositories can be added to an existing Git repository using
-'git p4 sync' too:
+`git p4 sync` too:
 ------------
 $ mkdir repo-git
 $ cd repo-git
@@ -108,11 +108,11 @@ This imports the specified depot into
 be used for the p4 content.
 
 If a Git repository includes branches 'refs/remotes/origin/p4', these
-will be fetched and consulted first during a 'git p4 sync'.  Since
+will be fetched and consulted first during a `git p4 sync`.  Since
 importing directly from p4 is considerably slower than pulling changes
 from a Git remote, this can be useful in a multi-developer environment.
 
-If there are multiple branches, doing 'git p4 sync' will automatically
+If there are multiple branches, doing `git p4 sync` will automatically
 use the "BRANCH DETECTION" algorithm to try to partition new changes
 into the right branch.  This can be overridden with the `--branch`
 option to specify just a single branch to update.
@@ -123,7 +123,7 @@ Rebase
 A common working pattern is to fetch the latest changes from the p4 depot
 and merge them with local uncommitted changes.  Often, the p4 repository
 is the ultimate location for all code, thus a rebase workflow makes
-sense.  This command does 'git p4 sync' followed by 'git rebase' to move
+sense.  This command does `git p4 sync` followed by `git rebase` to move
 local commits on top of updated p4 changes.
 ------------
 $ git p4 rebase
@@ -158,10 +158,10 @@ $ git p4 submit --commit <sha1..sha1>
 The upstream reference is generally 'refs/remotes/p4/master', but can
 be overridden using the `--origin=` command-line option.
 
-The p4 changes will be created as the user invoking 'git p4 submit'. The
+The p4 changes will be created as the user invoking `git p4 submit`. The
 `--preserve-user` option will cause ownership to be modified
 according to the author of the Git commit.  This option requires admin
-privileges in p4, which can be granted using 'p4 protect'.
+privileges in p4, which can be granted using `p4 protect`.
 
 To shelve changes instead of submitting, use `--shelve` and `--update-shelve`:
 
@@ -173,10 +173,10 @@ $ git p4 submit --update-shelve 1234 --update-shelve 2345
 
 Unshelve
 ~~~~~~~~
-Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
+Unshelving will take a shelved P4 changelist, and produce the equivalent `git` commit
 in the branch refs/remotes/p4-unshelved/<changelist>.
 
-The git commit is created relative to the current origin revision (`HEAD` by default).
+The `git` commit is created relative to the current origin revision (`HEAD` by default).
 A parent commit is created based on the origin, and then the unshelve commit is
 created based on that.
 
@@ -239,7 +239,7 @@ Git repository:
 
 --changesfile <file>::
 	Import exactly the p4 change numbers listed in 'file', one per
-	line.  Normally, 'git p4' inspects the current p4 repository
+	line.  Normally, `git p4` inspects the current p4 repository
 	state and detects the changes it should import.
 
 --silent::
@@ -271,9 +271,9 @@ Git repository:
 --changes-block-size <n>::
 	The internal block size to use when converting a revision
 	specifier such as '@all' into a list of specific change
-	numbers. Instead of using a single call to 'p4 changes' to
+	numbers. Instead of using a single call to `p4 changes` to
 	find the full list of changes for the conversion, there are a
-	sequence of calls to 'p4 changes -m', each of which requests
+	sequence of calls to `p4 changes -m`, each of which requests
 	one block of changes of the given size. The default block size
 	is 500, which should usually be suitable.
 
@@ -307,7 +307,7 @@ options described above.
 
 Submit options
 ~~~~~~~~~~~~~~
-These options can be used to modify 'git p4 submit' behavior.
+These options can be used to modify `git p4 submit` behavior.
 
 --origin <commit>::
 	Upstream location from which commits are identified to submit to
@@ -336,7 +336,7 @@ These options can be used to modify 'git p4 submit' behavior.
 --prepare-p4-only::
 	Apply a commit to the p4 workspace, opening, adding and deleting
 	files in p4 as for a normal submit operation.  Do not issue the
-	final "p4 submit", but instead print a message about how to
+	final `p4 submit`, but instead print a message about how to
 	submit manually or revert.  This option always stops after the
 	first (oldest) commit.  Git tags are not exported to p4.
 
@@ -370,9 +370,9 @@ These options can be used to modify 'git p4 submit' behavior.
     submitted. Can also be set with `git-p4.disableRebase`.
 
 --disable-p4sync::
-    Disable the automatic sync of p4/master from Perforce after commits have
+    Disable the automatic sync of `p4/master` from Perforce after commits have
     been submitted. Implies `--disable-rebase`. Can also be set with
-    `git-p4.disableP4Sync`. Sync with origin/master still goes ahead if possible.
+    `git-p4.disableP4Sync`. Sync with `origin/master` still goes ahead if possible.
 
 Hooks for submit
 ----------------
@@ -419,13 +419,13 @@ p4-post-changelist
 The `p4-post-changelist` hook is invoked after the submit has
 successfully occurred in P4. It takes no parameters and is meant
 primarily for notification and cannot affect the outcome of the
-git p4 submit action.
+`git p4 submit` action.
 
 
 
 Rebase options
 ~~~~~~~~~~~~~~
-These options can be used to modify 'git p4 rebase' behavior.
+These options can be used to modify `git p4 rebase` behavior.
 
 --import-labels::
 	Import p4 labels.
@@ -434,12 +434,12 @@ Unshelve options
 ~~~~~~~~~~~~~~~~
 
 --origin::
-    Sets the git refspec against which the shelved P4 changelist is compared.
+    Sets the `git` refspec against which the shelved P4 changelist is compared.
     Defaults to p4/master.
 
 DEPOT PATH SYNTAX
 -----------------
-The p4 depot path argument to 'git p4 sync' and 'git p4 clone' can
+The p4 depot path argument to `git p4 sync` and `git p4 clone` can
 be one or more space-separated p4 depot paths, with an optional
 p4 revision specifier on the end:
 
@@ -462,34 +462,34 @@ p4 revision specifier on the end:
     depot paths with the same name, the path with the most recently
     updated version of the file is the one that appears in Git.
 
-See 'p4 help revisions' for the full syntax of p4 revision specifiers.
+See `p4 help revisions` for the full syntax of p4 revision specifiers.
 
 
 CLIENT SPEC
 -----------
-The p4 client specification is maintained with the 'p4 client' command
+The p4 client specification is maintained with the `p4 client` command
 and contains among other fields, a View that specifies how the depot
 is mapped into the client repository.  The 'clone' and 'sync' commands
 can consult the client spec when given the `--use-client-spec` option or
-when the useClientSpec variable is true.  After 'git p4 clone', the
+when the useClientSpec variable is true.  After `git p4 clone`, the
 useClientSpec variable is automatically set in the repository
-configuration file.  This allows future 'git p4 submit' commands to
+configuration file.  This allows future `git p4 submit` commands to
 work properly; the submit command looks only at the variable and does
 not have a command-line option.
 
-The full syntax for a p4 view is documented in 'p4 help views'.  'git p4'
+The full syntax for a p4 view is documented in `p4 help views`.  `git p4`
 knows only a subset of the view syntax.  It understands multi-line
 mappings, overlays with '+', exclusions with '-' and double-quotes
-around whitespace.  Of the possible wildcards, 'git p4' only handles
-'...', and only when it is at the end of the path.  'git p4' will complain
+around whitespace.  Of the possible wildcards, `git p4` only handles
+'...', and only when it is at the end of the path.  `git p4` will complain
 if it encounters an unhandled wildcard.
 
 Bugs in the implementation of overlap mappings exist.  If multiple depot
 paths map through overlays to the same location in the repository,
-'git p4' can choose the wrong one.  This is hard to solve without
-dedicating a client spec just for 'git p4'.
+`git p4` can choose the wrong one.  This is hard to solve without
+dedicating a client spec just for `git p4`.
 
-The name of the client can be given to 'git p4' in multiple ways.  The
+The name of the client can be given to `git p4` in multiple ways.  The
 variable `git-p4.client` takes precedence if it exists.  Otherwise,
 normal p4 mechanisms of determining the client are used:  environment
 variable `P4CLIENT`, a file referenced by `P4CONFIG`, or the local host name.
@@ -500,13 +500,13 @@ BRANCH DETECTION
 P4 does not have the same concept of a branch as Git.  Instead,
 p4 organizes its content as a directory tree, where by convention
 different logical branches are in different locations in the tree.
-The 'p4 branch' command is used to maintain mappings between
-different areas in the tree, and indicate related content.  'git p4'
+The `p4 branch` command is used to maintain mappings between
+different areas in the tree, and indicate related content.  `git p4`
 can use these mappings to determine branch relationships.
 
 If you have a repository where all the branches of interest exist as
 subdirectories of a single depot path, you can use `--detect-branches`
-when cloning or syncing to have 'git p4' automatically find
+when cloning or syncing to have `git p4` automatically find
 subdirectories in p4, and to generate these as branches in Git.
 
 For example, if the P4 repository structure is:
@@ -515,17 +515,17 @@ For example, if the P4 repository structure is:
 //depot/branch1/...
 ----
 
-And "p4 branch -o branch1" shows a View line that looks like:
+And `p4 branch -o branch1` shows a View line that looks like:
 ----
 //depot/main/... //depot/branch1/...
 ----
 
-Then this 'git p4 clone' command:
+Then this `git p4 clone` command:
 ----
 git p4 clone --detect-branches //depot@all
 ----
 produces a separate branch in 'refs/remotes/p4/' for //depot/main,
-called 'master', and one for //depot/branch1 called 'depot/branch1'.
+called `master`, and one for //depot/branch1 called `depot/branch1`.
 
 However, it is not necessary to create branches in p4 to be able to use
 them like branches.  Because it is difficult to infer branch
@@ -546,16 +546,16 @@ git p4 clone --detect-branches //depot@all .
 
 PERFORMANCE
 -----------
-The fast-import mechanism used by 'git p4' creates one pack file for
-each invocation of 'git p4 sync'.  Normally, Git garbage compression
+The fast-import mechanism used by `git p4` creates one pack file for
+each invocation of `git p4 sync`.  Normally, Git garbage compression
 (linkgit:git-gc[1]) automatically compresses these to fewer pack files,
-but explicit invocation of 'git repack -adf' may improve performance.
+but explicit invocation of `git repack -adf` may improve performance.
 
 
 CONFIGURATION VARIABLES
 -----------------------
-The following config settings can be used to modify 'git p4' behavior.
-They all are in the 'git-p4' section.
+The following config settings can be used to modify `git p4` behavior.
+They all are in the `git-p4` section.
 
 General variables
 ~~~~~~~~~~~~~~~~~
@@ -584,7 +584,7 @@ git-p4.client::
 
 git-p4.retries::
 	Specifies the number of times to retry a p4 command (notably,
-	'p4 sync') if the network times out. The default value is 3.
+	`p4 sync`) if the network times out. The default value is 3.
 	Set the value to 0 to disable retries or if your p4 version
 	does not support retries (pre 2012.2).
 
@@ -619,7 +619,7 @@ git-p4.ignoredP4Labels::
 	unimportable labels are discovered.
 
 git-p4.importLabels::
-	Import p4 labels into git, as per `--import-labels`.
+	Import p4 labels into `git`, as per `--import-labels`.
 
 git-p4.labelImportRegexp::
 	Only p4 labels matching this regular expression will be imported. The
@@ -633,14 +633,14 @@ git-p4.useClientSpec::
 
 git-p4.pathEncoding::
 	Perforce keeps the encoding of a path as given by the originating OS.
-	Git expects paths encoded as UTF-8. Use this config to tell git-p4
+	Git expects paths encoded as UTF-8. Use this config to tell `git-p4`
 	what encoding Perforce had used for the paths. This encoding is used
 	to transcode the paths to UTF-8. As an example, Perforce on Windows
 	often uses "cp1252" to encode path names.
 
 git-p4.largeFileSystem::
 	Specify the system that is used for large (binary) files. Please note
-	that large file systems do not support the 'git p4 submit' command.
+	that large file systems do not support the `git p4 submit` command.
 	Only Git LFS is implemented right now (see https://git-lfs.github.com/
 	for more information). Download and install the Git LFS command line
 	extension to use this option and configure it like this:
@@ -687,21 +687,21 @@ Submit variables
 ~~~~~~~~~~~~~~~~
 git-p4.detectRenames::
 	Detect renames.  See linkgit:git-diff[1].  This can be true,
-	false, or a score as expected by 'git diff -M'.
+	false, or a score as expected by `git diff -M`.
 
 git-p4.detectCopies::
 	Detect copies.  See linkgit:git-diff[1].  This can be true,
-	false, or a score as expected by 'git diff -C'.
+	false, or a score as expected by `git diff -C`.
 
 git-p4.detectCopiesHarder::
 	Detect copies harder.  See linkgit:git-diff[1].  A boolean.
 
 git-p4.preserveUser::
 	On submit, re-author changes to reflect the Git author,
-	regardless of who invokes 'git p4 submit'.
+	regardless of who invokes `git p4 submit`.
 
 git-p4.allowMissingP4Users::
-	When 'preserveUser' is true, 'git p4' normally dies if it
+	When 'preserveUser' is true, `git p4` normally dies if it
 	cannot find an author in the p4 user map.  This setting
 	submits the change regardless.
 
@@ -711,24 +711,24 @@ git-p4.skipSubmitEdit::
 	step is skipped.
 
 git-p4.skipSubmitEditCheck::
-	After editing the p4 change message, 'git p4' makes sure that
+	After editing the p4 change message, `git p4` makes sure that
 	the description really was changed by looking at the file
 	modification time.  This option disables that test.
 
 git-p4.allowSubmit::
-	By default, any branch can be used as the source for a 'git p4
-	submit' operation.  This configuration variable, if set, permits only
+	By default, any branch can be used as the source for a `git p4
+	submit` operation.  This configuration variable, if set, permits only
 	the named branches to be used as submit sources.  Branch names
 	must be the short names (no "refs/heads/"), and should be
 	separated by commas (","), with no spaces.
 
 git-p4.skipUserNameCheck::
-	If the user running 'git p4 submit' does not exist in the p4
-	user map, 'git p4' exits.  This option can be used to force
+	If the user running `git p4 submit` does not exist in the p4
+	user map, `git p4` exits.  This option can be used to force
 	submission regardless.
 
 git-p4.attemptRCSCleanup::
-	If enabled, 'git p4 submit' will attempt to cleanup RCS keywords
+	If enabled, `git p4 submit` will attempt to cleanup RCS keywords
 	($Header$, etc). These would otherwise cause merge conflicts and prevent
 	the submit going ahead. This option should be considered experimental at
 	present.
@@ -754,11 +754,11 @@ IMPLEMENTATION DETAILS
 ----------------------
 * Changesets from p4 are imported using Git fast-import.
 * Cloning or syncing does not require a p4 client; file contents are
-  collected using 'p4 print'.
+  collected using `p4 print`.
 * Submitting requires a p4 client, which is not in the same location
   as the Git repository.  Patches are applied, one at a time, to
   this p4 client and submitted from there.
-* Each commit imported by 'git p4' has a line at the end of the log
+* Each commit imported by `git p4` has a line at the end of the log
   message indicating the p4 depot location and change number.  This
-  line is used by later 'git p4 sync' operations to know which p4
+  line is used by later `git p4 sync` operations to know which p4
   changes are new.
diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index a78721517b..e98e1f858b 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -9,7 +9,7 @@ git-pack-objects - Create a packed archive of objects
 SYNOPSIS
 --------
 [verse]
-'git pack-objects' [-q | --progress | --all-progress] [--all-progress-implied]
+`git pack-objects` [-q | --progress | --all-progress] [--all-progress-implied]
 	[--no-reuse-delta] [--delta-base-offset] [--non-empty]
 	[--local] [--incremental] [--window=<n>] [--depth=<n>]
 	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
@@ -39,7 +39,7 @@ archive (.pack) in the pack/ subdirectory of $GIT_OBJECT_DIRECTORY (or
 any of the directories on $GIT_ALTERNATE_OBJECT_DIRECTORIES)
 enables Git to read from the pack archive.
 
-The 'git unpack-objects' command can read the packed archive and
+The `git unpack-objects` command can read the packed archive and
 expand the objects contained in the pack into "one-file
 one-object" format; this is typically done by the smart-pull
 commands when a pack is created on-the-fly for efficient network
@@ -63,7 +63,7 @@ base-name::
 --revs::
 	Read the revision arguments from the standard input, instead of
 	individual object names.  The revision arguments are processed
-	the same way as 'git rev-list' with the `--objects` flag
+	the same way as `git rev-list` with the `--objects` flag
 	uses its `commit` arguments to build the list of objects it
 	outputs.  The objects on the resulting list are packed.
 	Besides revisions, `--not` or `--shallow <SHA-1>` lines are
@@ -236,7 +236,7 @@ self-contained. Use `git index-pack --fix-thin`
 	A packed archive can express the base object of a delta as
 	either a 20-byte object name or as an offset in the
 	stream, but ancient versions of Git don't understand the
-	latter.  By default, 'git pack-objects' only uses the
+	latter.  By default, `git pack-objects` only uses the
 	former format for better compatibility.  This option
 	allows the command to use the latter format for
 	compactness.  Depending on the average delta chain
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index f2869da572..a288be2c12 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -9,7 +9,7 @@ git-pack-redundant - Find redundant pack files
 SYNOPSIS
 --------
 [verse]
-'git pack-redundant' [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
+`git pack-redundant` [ --verbose ] [ --alt-odb ] < --all | .pack filename ... >
 
 DESCRIPTION
 -----------
@@ -17,7 +17,7 @@ This program computes which packs in your repository
 are redundant. The output is suitable for piping to
 `xargs rm` if you are in the root of the repository.
 
-'git pack-redundant' accepts a list of objects on standard input. Any objects
+`git pack-redundant` accepts a list of objects on standard input. Any objects
 given will be ignored when checking which packs are required. This makes the
 following command useful when wanting to remove packs which contain unreachable
 objects.
diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 154081f2de..7e62ff3e8d 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
 SYNOPSIS
 --------
 [verse]
-'git pack-refs' [--all] [--no-prune]
+`git pack-refs` [--all] [--no-prune]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-patch-id.txt b/Documentation/git-patch-id.txt
index fb5b194b8a..5e8747f673 100644
--- a/Documentation/git-patch-id.txt
+++ b/Documentation/git-patch-id.txt
@@ -8,7 +8,7 @@ git-patch-id - Compute unique ID for a patch
 SYNOPSIS
 --------
 [verse]
-'git patch-id' [--stable | --unstable]
+`git patch-id` [--stable | --unstable]
 
 DESCRIPTION
 -----------
@@ -21,7 +21,7 @@ have the same "patch ID" are almost guaranteed to be the same thing.
 
 IOW, you can use this thing to look for likely duplicate commits.
 
-When dealing with 'git diff-tree' output, it takes advantage of
+When dealing with `git diff-tree` output, it takes advantage of
 the fact that the patch is prefixed with the object name of the
 commit, and outputs two 40-byte hexadecimal strings.  The first
 string is the patch ID, and the second string is the commit ID.
@@ -39,19 +39,19 @@ OPTIONS
 	   as a key to index some meta-information about the change between
 	   the two trees;
 
-	 - Result is different from the value produced by git 1.9 and older
+	 - Result is different from the value produced by `git` 1.9 and older
 	   or produced when an "unstable" hash (see `--unstable` below) is
 	   configured - even when used on a diff output taken without any use
 	   of `-O<orderfile>`, thereby making existing databases storing such
 	   "unstable" or historical patch-ids unusable.
 
-	This is the default if patchid.stable is set to true.
+	This is the default if `patchid.stable` is set to true.
 
 --unstable::
 	Use an "unstable" hash as the patch ID. With this option,
 	the result produced is compatible with the patch-id value produced
-	by git 1.9 and older.  Users with pre-existing databases storing
-	patch-ids produced by git 1.9 and older (who do not deal with reordered
+	by `git` 1.9 and older.  Users with pre-existing databases storing
+	patch-ids produced by `git` 1.9 and older (who do not deal with reordered
 	patches) may want to use this option.
 
 	This is the default.
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 9fed59a317..77603fd5e2 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -9,7 +9,7 @@ git-prune-packed - Remove extra objects that are already in pack files
 SYNOPSIS
 --------
 [verse]
-'git prune-packed' [-n|--dry-run] [-q|--quiet]
+`git prune-packed` [-n|--dry-run] [-q|--quiet]
 
 
 DESCRIPTION
diff --git a/Documentation/git-prune.txt b/Documentation/git-prune.txt
index 7bad035e47..4cdd753c13 100644
--- a/Documentation/git-prune.txt
+++ b/Documentation/git-prune.txt
@@ -9,21 +9,21 @@ git-prune - Prune all unreachable objects from the object database
 SYNOPSIS
 --------
 [verse]
-'git prune' [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]
+`git prune` [-n] [-v] [--progress] [--expire <time>] [--] [<head>...]
 
 DESCRIPTION
 -----------
 
-NOTE: In most cases, users should run 'git gc', which calls
-'git prune'. See the section "NOTES", below.
+NOTE: In most cases, users should run `git gc`, which calls
+`git prune`. See the section "NOTES", below.
 
-This runs 'git fsck --unreachable' using all the refs
+This runs `git fsck --unreachable` using all the refs
 available in `refs/`, optionally with additional set of
 objects specified on the command line, and prunes all unpacked
 objects unreachable from any of these head objects from the object database.
 In addition, it
 prunes the unpacked objects that are also found in packs by
-running 'git prune-packed'.
+running `git prune-packed`.
 It also removes entries from .git/shallow that are not reachable by
 any ref.
 
@@ -70,12 +70,12 @@ $ git prune $(cd ../another && git rev-parse --all)
 NOTES
 -----
 
-In most cases, users will not need to call 'git prune' directly, but
-should instead call 'git gc', which handles pruning along with
+In most cases, users will not need to call `git prune` directly, but
+should instead call `git gc`, which handles pruning along with
 many other housekeeping tasks.
 
 For a description of which objects are considered for pruning, see
-'git fsck''s `--unreachable` option.
+`git fsck`'s `--unreachable` option.
 
 SEE ALSO
 --------
diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index e637686597..a64a137a89 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -9,7 +9,7 @@ git-pull - Fetch from and integrate with another repository or a local branch
 SYNOPSIS
 --------
 [verse]
-'git pull' [<options>] [<repository> [<refspec>...]]
+`git pull` [<options>] [<repository> [<refspec>...]]
 
 
 DESCRIPTION
@@ -19,10 +19,10 @@ Incorporates changes from a remote repository into the current
 branch.  In its default mode, `git pull` is shorthand for
 `git fetch` followed by `git merge FETCH_HEAD`.
 
-More precisely, 'git pull' runs 'git fetch' with the given
-parameters and calls 'git merge' to merge the retrieved branch
+More precisely, `git pull` runs `git fetch` with the given
+parameters and calls `git merge` to merge the retrieved branch
 heads into the current branch.
-With `--rebase`, it runs 'git rebase' instead of 'git merge'.
+With `--rebase`, it runs `git rebase` instead of `git merge`.
 
 <repository> should be the name of a remote repository as
 passed to linkgit:git-fetch[1].  <refspec> can name an
@@ -62,7 +62,7 @@ See linkgit:git-merge[1] for details, including how conflicts
 are presented and handled.
 
 In Git 1.7.0 or later, to cancel a conflicting merge, use
-`git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
+`git reset --merge`.  *Warning*: In older versions of Git, running `git pull`
 with uncommitted changes is discouraged: while possible, it leaves you
 in a state that may be hard to back out of in the case of a conflict.
 
@@ -76,13 +76,13 @@ OPTIONS
 
 -q::
 --quiet::
-	This is passed to both underlying git-fetch to squelch reporting of
-	during transfer, and underlying git-merge to squelch output during
+	This is passed to both underlying `git-fetch` to squelch reporting of
+	during transfer, and underlying `git-merge` to squelch output during
 	merging.
 
 -v::
 --verbose::
-	Pass `--verbose` to git-fetch and git-merge.
+	Pass `--verbose` to `git-fetch` and `git-merge`.
 
 --[no-]recurse-submodules[=yes|on-demand|no]::
 	This option controls if new commits of populated submodules should
@@ -232,7 +232,7 @@ $ git merge origin/next
 
 
 If you tried a pull which resulted in complex conflicts and
-would want to start over, you can recover with 'git reset'.
+would want to start over, you can recover with `git reset`.
 
 
 include::transfer-data-leaks.txt[]
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index aa5db3e6e5..842cbbaeca 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -9,7 +9,7 @@ git-push - Update remote refs along with associated objects
 SYNOPSIS
 --------
 [verse]
-'git push' [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
+`git push` [--all | --mirror | --tags] [--follow-tags] [--atomic] [-n | --dry-run] [--receive-pack=<git-receive-pack>]
 	   [--repo=<repository>] [-f | --force] [-d | --delete] [--prune] [-v | --verbose]
 	   [-u | --set-upstream] [-o <string> | --push-option=<string>]
 	   [--[no-]signed|--signed=(true|false|if-asked)]
@@ -226,7 +226,7 @@ already exists on the remote side.
 
 --receive-pack=<git-receive-pack>::
 --exec=<git-receive-pack>::
-	Path to the 'git-receive-pack' program on the remote
+	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
@@ -234,11 +234,11 @@ already exists on the remote side.
 --[no-]force-with-lease::
 --force-with-lease=<refname>::
 --force-with-lease=<refname>:<expect>::
-	Usually, "git push" refuses to update a remote ref that is
+	Usually, `git push` refuses to update a remote ref that is
 	not an ancestor of the local ref used to overwrite it.
 +
 This option overrides this restriction if the current value of the
-remote ref is the expected value.  "git push" fails otherwise.
+remote ref is the expected value.  `git push` fails otherwise.
 +
 Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
@@ -432,7 +432,7 @@ include::urls-remotes.txt[]
 OUTPUT
 ------
 
-The output of "git push" depends on the transport method used; this
+The output of `git push` depends on the transport method used; this
 section describes the output when pushing over the Git protocol (either
 locally or via ssh).
 
@@ -547,8 +547,8 @@ the other person (history from X to A), you would need to first fetch the
 history from the repository, create a history that contains changes done
 by both parties, and push the result back.
 
-You can perform "git pull", resolve potential conflicts, and "git push"
-the result.  A "git pull" will create a merge commit C between commits A
+You can perform `git pull`, resolve potential conflicts, and `git push`
+the result.  A `git pull` will create a merge commit C between commits A
 and B.
 
 ----------------
@@ -563,7 +563,7 @@ Updating A with the resulting merge commit will fast-forward and your
 push will be accepted.
 
 Alternatively, you can rebase your change between X and B on top of A,
-with "git pull --rebase", and push the result back.  The rebase will
+with `git pull --rebase`, and push the result back.  The rebase will
 create a new commit D that builds the change between X and B on top of
 A.
 
@@ -581,12 +581,12 @@ accepted.
 There is another common situation where you may encounter non-fast-forward
 rejection when you try to push, and it is possible even when you are
 pushing into a repository nobody else pushes into. After you push commit
-A yourself (in the first picture in this section), replace it with "git
-commit --amend" to produce commit B, and you try to push it out, because
+A yourself (in the first picture in this section), replace it with `git
+commit --amend` to produce commit B, and you try to push it out, because
 forgot that you have pushed A out already. In such a case, and only if
 you are certain that nobody in the meantime fetched your earlier commit A
-(and started building on top of it), you can run "git push --force" to
-overwrite it. In other words, "git push --force" is a method reserved for
+(and started building on top of it), you can run `git push --force` to
+overwrite it. In other words, `git push --force` is a method reserved for
 a case where you do mean to lose history.
 
 
diff --git a/Documentation/git-quiltimport.txt b/Documentation/git-quiltimport.txt
index edae01d55d..831bf55ed8 100644
--- a/Documentation/git-quiltimport.txt
+++ b/Documentation/git-quiltimport.txt
@@ -9,7 +9,7 @@ git-quiltimport - Applies a quilt patchset onto the current branch
 SYNOPSIS
 --------
 [verse]
-'git quiltimport' [--dry-run | -n] [--author <author>] [--patches <dir>]
+`git quiltimport` [--dry-run | -n] [--author <author>] [--patches <dir>]
 		[--series <file>] [--keep-non-patch]
 
 
@@ -57,7 +57,7 @@ or the value of the `$QUILT_SERIES` environment
 variable.
 
 --keep-non-patch::
-	Pass `-b` flag to 'git mailinfo' (see linkgit:git-mailinfo[1]).
+	Pass `-b` flag to `git mailinfo` (see linkgit:git-mailinfo[1]).
 
 GIT
 ---
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index fe350d7f40..2de9ca2d08 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -8,7 +8,7 @@ git-range-diff - Compare two commit ranges (e.g. two versions of a branch)
 SYNOPSIS
 --------
 [verse]
-'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
+`git range-diff` [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
 	[--left-only | --right-only]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
diff --git a/Documentation/git-read-tree.txt b/Documentation/git-read-tree.txt
index d22d3855d1..380f87b6e8 100644
--- a/Documentation/git-read-tree.txt
+++ b/Documentation/git-read-tree.txt
@@ -9,7 +9,7 @@ git-read-tree - Reads tree information into the index
 SYNOPSIS
 --------
 [verse]
-'git read-tree' [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
+`git read-tree` [[-m [--trivial] [--aggressive] | --reset | --prefix=<prefix>]
 		[-u [--exclude-per-directory=<gitignore>] | -i]]
 		[--index-output=<file>] [--no-sparse-checkout]
 		(--empty | <tree-ish1> [<tree-ish2> [<tree-ish3>]])
@@ -26,8 +26,8 @@ fast-forward (i.e. 2-way) merge, or a 3-way merge, with the `-m`
 flag.  When used with `-m`, the `-u` flag causes it to also update
 the files in the work tree with the result of the merge.
 
-Trivial merges are done by 'git read-tree' itself.  Only conflicting paths
-will be in unmerged state when 'git read-tree' returns.
+Trivial merges are done by `git read-tree` itself.  Only conflicting paths
+will be in unmerged state when `git read-tree` returns.
 
 OPTIONS
 -------
@@ -64,13 +64,13 @@ OPTIONS
 	Show the progress of checking files out.
 
 --trivial::
-	Restrict three-way merge by 'git read-tree' to happen
+	Restrict three-way merge by `git read-tree` to happen
 	only if there is no file-level merging required, instead
 	of resolving merge for trivial cases and leaving
 	conflicting files unresolved in the index.
 
 --aggressive::
-	Usually a three-way merge by 'git read-tree' resolves
+	Usually a three-way merge by `git read-tree` resolves
 	the merge for really trivial cases and leaves other
 	cases unresolved in the index, so that porcelains can
 	implement different merge policies.  This flag makes the
@@ -139,7 +139,7 @@ OPTIONS
 
 MERGING
 -------
-If `-m` is specified, 'git read-tree' can perform 3 kinds of
+If `-m` is specified, `git read-tree` can perform 3 kinds of
 merge, a single tree merge if only 1 tree is given, a
 fast-forward merge with 2 trees, or a 3-way merge if 3 or more trees are
 provided.
@@ -147,18 +147,18 @@ provided.
 
 Single Tree Merge
 ~~~~~~~~~~~~~~~~~
-If only 1 tree is specified, 'git read-tree' operates as if the user did not
+If only 1 tree is specified, `git read-tree` operates as if the user did not
 specify `-m`, except that if the original index has an entry for a
 given pathname, and the contents of the path match with the tree
 being read, the stat info from the index is used. (In other words, the
 index's stat()s take precedence over the merged tree's).
 
 That means that if you do a `git read-tree -m <newtree>` followed by a
-`git checkout-index -f -u -a`, the 'git checkout-index' only checks out
+`git checkout-index -f -u -a`, the `git checkout-index` only checks out
 the stuff that really changed.
 
-This is used to avoid unnecessary false hits when 'git diff-files' is
-run after 'git read-tree'.
+This is used to avoid unnecessary false hits when `git diff-files` is
+run after `git read-tree`.
 
 
 Two Tree Merge
@@ -169,7 +169,7 @@ is the head commit of the current repository, and $M is the head
 of a foreign tree, which is simply ahead of $H (i.e. we are in a
 fast-forward situation).
 
-When two trees are specified, the user is telling 'git read-tree'
+When two trees are specified, the user is telling `git read-tree`
 the following:
 
      1. The current index and work tree is derived from $H, but
@@ -226,10 +226,10 @@ refer to the presence of a path in the specified commit:
 
 In all "keep index" cases, the index entry stays as in the
 original index file.  If the entry is not up to date,
-'git read-tree' keeps the copy in the work tree intact when
+`git read-tree` keeps the copy in the work tree intact when
 operating under the `-u` flag.
 
-When this form of 'git read-tree' returns successfully, you can
+When this form of `git read-tree` returns successfully, you can
 see which of the "local changes" that you made were carried forward by running
 `git diff-index --cached $M`.  Note that this does not
 necessarily match what `git diff-index --cached $H` would have
@@ -252,7 +252,7 @@ of the path is kept as long as $H and $M are the same.
 Each "index" entry has two bits worth of "stage" state. stage 0 is the
 normal one, and is the only one you'd see in any kind of normal use.
 
-However, when you do 'git read-tree' with three trees, the "stage"
+However, when you do `git read-tree` with three trees, the "stage"
 starts out at 1.
 
 This means that you can do
@@ -268,7 +268,7 @@ branch into the current branch, we use the common ancestor tree
 as <tree1>, the current branch head as <tree2>, and the other
 branch head as <tree3>.
 
-Furthermore, 'git read-tree' has special-case logic that says: if you see
+Furthermore, `git read-tree` has special-case logic that says: if you see
 a file that matches in all respects in the following states, it
 "collapses" back to "stage0":
 
@@ -284,7 +284,7 @@ a file that matches in all respects in the following states, it
    - stage 1 and stage 3 are the same and stage 2 is different take
      stage 2 (we did something while they did nothing)
 
-The 'git write-tree' command refuses to write a nonsensical tree, and it
+The `git write-tree` command refuses to write a nonsensical tree, and it
 will complain about unmerged entries if it sees a single entry that is not
 stage 0.
 
@@ -300,7 +300,7 @@ start a 3-way merge with an index file that is already
 populated.  Here is an outline of how the algorithm works:
 
 - if a file exists in identical format in all three trees, it will
-  automatically collapse to "merged" state by 'git read-tree'.
+  automatically collapse to "merged" state by `git read-tree`.
 
 - a file that has _any_ difference what-so-ever in the three trees
   will stay as separate entries in the index. It's up to "porcelain
@@ -324,8 +324,8 @@ populated.  Here is an outline of how the algorithm works:
     matching "stage1" entry if it exists too.  .. all the normal
     trivial rules ..
 
-You would normally use 'git merge-index' with supplied
-'git merge-one-file' to do this last step.  The script updates
+You would normally use `git merge-index` with supplied
+`git merge-one-file` to do this last step.  The script updates
 the files in the working tree as it merges each path and at the
 end of a successful merge.
 
@@ -347,7 +347,7 @@ $ JC=`git rev-parse --verify "HEAD^0"`
 $ git checkout-index -f -u -a $JC
 ----------------
 
-You do random edits, without running 'git update-index'.  And then
+You do random edits, without running `git update-index`.  And then
 you notice that the tip of your "upstream" tree has advanced
 since you pulled from him:
 
@@ -373,14 +373,14 @@ your work-in-progress changes, and your work tree would be
 updated to the result of the merge.
 
 However, if you have local changes in the working tree that
-would be overwritten by this merge, 'git read-tree' will refuse
+would be overwritten by this merge, `git read-tree` will refuse
 to run to prevent your changes from being lost.
 
 In other words, there is no need to worry about what exists only
 in the working tree.  When you have local changes in a part of
 the project that is not involved in the merge, your changes do
 not interfere with the merge, and are kept intact.  When they
-*do* interfere, the merge does not even start ('git read-tree'
+*do* interfere, the merge does not even start (`git read-tree`
 complains loudly and fails without modifying anything).  In such
 a case, you can simply continue doing what you were in the
 middle of doing, and when your working tree is ready (i.e. you
@@ -394,10 +394,10 @@ SPARSE CHECKOUT
 It uses the skip-worktree bit (see linkgit:git-update-index[1]) to tell
 Git whether a file in the working directory is worth looking at.
 
-'git read-tree' and other merge-based commands ('git merge', 'git
-checkout'...) can help maintaining the skip-worktree bitmap and working
+`git read-tree` and other merge-based commands (`git merge`, `git
+checkout`...) can help maintaining the skip-worktree bitmap and working
 directory update. `$GIT_DIR/info/sparse-checkout` is used to
-define the skip-worktree reference bitmap. When 'git read-tree' needs
+define the skip-worktree reference bitmap. When `git read-tree` needs
 to update the working directory, it resets the skip-worktree bit in the index
 based on this file, which uses the same syntax as .gitignore files.
 If an entry matches a pattern in this file, skip-worktree will not be
@@ -427,8 +427,8 @@ follows:
 /*
 ----------------
 
-Then you can disable sparse checkout. Sparse checkout support in 'git
-read-tree' and similar commands is disabled by default. You need to
+Then you can disable sparse checkout. Sparse checkout support in `git
+read-tree` and similar commands is disabled by default. You need to
 turn `core.sparseCheckout` on in order to have sparse checkout
 support.
 
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 22287372f7..ddc76ca308 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -8,15 +8,15 @@ git-rebase - Reapply commits on top of another base tip
 SYNOPSIS
 --------
 [verse]
-'git rebase' [-i | --interactive] [<options>] [--exec <cmd>]
+`git rebase` [-i | --interactive] [<options>] [--exec <cmd>]
 	[--onto <newbase> | --keep-base] [<upstream> [<branch>]]
-'git rebase' [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
+`git rebase` [-i | --interactive] [<options>] [--exec <cmd>] [--onto <newbase>]
 	--root [<branch>]
-'git rebase' (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
+`git rebase` (--continue | --skip | --abort | --quit | --edit-todo | --show-current-patch)
 
 DESCRIPTION
 -----------
-If <branch> is specified, 'git rebase' will perform an automatic
+If <branch> is specified, `git rebase` will perform an automatic
 `git switch <branch>` before doing anything else.  Otherwise
 it remains on the current branch.
 
@@ -178,8 +178,8 @@ This is useful if F and G were flawed in some way, or should not be
 part of topicA.  Note that the argument to `--onto` and the <upstream>
 parameter can be any valid commit-ish.
 
-In case of conflict, 'git rebase' will stop at the first problematic commit
-and leave conflict markers in the tree.  You can use 'git diff' to locate
+In case of conflict, `git rebase` will stop at the first problematic commit
+and leave conflict markers in the tree.  You can use `git diff` to locate
 the markers (<<<<<<) and make edits to resolve the conflict.  For each
 file you edit, you need to tell Git that the conflict has been resolved,
 typically this would be done with
@@ -195,7 +195,7 @@ desired resolution, you can continue the rebasing process with
     git rebase --continue
 
 
-Alternatively, you can undo the 'git rebase' with
+Alternatively, you can undo the `git rebase` with
 
 
     git rebase --abort
@@ -221,8 +221,8 @@ leave out at most one of A and B, in which case it defaults to `HEAD`.
 --keep-base::
 	Set the starting point at which to create the new commits to the
 	merge base of <upstream> <branch>. Running
-	'git rebase --keep-base <upstream> <branch>' is equivalent to
-	running 'git rebase --onto <upstream>... <upstream>'.
+	`git rebase --keep-base <upstream> <branch>` is equivalent to
+	running `git rebase --onto <upstream>... <upstream>`.
 +
 This option is useful in the case where one is developing a feature on
 top of an upstream branch. While the feature is being worked on, the
@@ -361,10 +361,10 @@ See also INCOMPATIBLE OPTIONS below.
 -s <strategy>::
 --strategy=<strategy>::
 	Use the given merge strategy.
-	If there is no `-s` option 'git merge-recursive' is used
+	If there is no `-s` option `git merge-recursive` is used
 	instead.  This implies `--merge`.
 +
-Because 'git rebase' replays each commit from the working branch
+Because `git rebase` replays each commit from the working branch
 on top of the <upstream> branch using the given strategy, using
 the 'ours' strategy simply empties all patches from the <branch>,
 which makes little sense.
@@ -476,7 +476,7 @@ intended to modify whitespace and nothing else will be dropped, even
 if the other side had no changes that conflicted.
 
 --whitespace=<option>::
-	This flag is passed to the 'git apply' program
+	This flag is passed to the `git apply` program
 	(see linkgit:git-apply[1]) that applies the patch.
 	Implies `--apply`.
 +
@@ -756,7 +756,7 @@ commit of the rebase, not the intermediate commits nor the final
 commit.  In each case, the calling of these hooks was by accident of
 implementation rather than by design (both backends were originally
 implemented as shell scripts and happened to invoke other commands
-like 'git checkout' or 'git commit' that would call the hooks).  Both
+like `git checkout` or `git commit` that would call the hooks).  Both
 backends should have the same behavior, though it is not entirely
 clear which, if any, is correct.  We will likely make rebase stop
 calling either of these hooks in the future.
@@ -807,11 +807,11 @@ include::merge-strategies.txt[]
 NOTES
 -----
 
-You should understand the implications of using 'git rebase' on a
+You should understand the implications of using `git rebase` on a
 repository that you share.  See also RECOVERING FROM UPSTREAM REBASE
 below.
 
-When the git-rebase command is run, it will first execute a "pre-rebase"
+When the `git-rebase` command is run, it will first execute a "pre-rebase"
 hook if one exists.  You can use this hook to do sanity checks and
 reject the rebase if it isn't appropriate.  Please see the template
 pre-rebase hook script for an example.
@@ -866,12 +866,12 @@ pick fa1afe1 The oneline of the next commit
 ...
 -------------------------------------------
 
-The oneline descriptions are purely for your pleasure; 'git rebase' will
+The oneline descriptions are purely for your pleasure; `git rebase` will
 not look at them but at the commit names ("deadbee" and "fa1afe1" in this
 example), so do not delete or edit the names.
 
 By replacing the command "pick" with the command "edit", you can tell
-'git rebase' to stop after applying that commit, so that you can edit
+`git rebase` to stop after applying that commit, so that you can edit
 the files and/or the commit message, amend the commit, and continue
 rebasing.
 
@@ -900,13 +900,13 @@ commit, the message from the final one is used.  You can also use
 an editor.
 
 
-'git rebase' will stop when "pick" has been replaced with "edit" or
+`git rebase` will stop when "pick" has been replaced with "edit" or
 when a command fails due to merge errors. When you are done editing
 and/or resolving conflicts you can continue with `git rebase --continue`.
 
 For example, if you want to reorder the last 5 commits, such that what
 was `HEAD~4` becomes the new `HEAD`. To achieve that, you would call
-'git rebase' like this:
+`git rebase` like this:
 
 ----------------------
 $ git rebase -i HEAD~5
@@ -979,7 +979,7 @@ SPLITTING COMMITS
 -----------------
 
 In interactive mode, you can mark commits with the action "edit".  However,
-this does not necessarily mean that 'git rebase' expects the result of this
+this does not necessarily mean that `git rebase` expects the result of this
 edit to be exactly one commit.  Indeed, you can undo the commit, or you can
 add other commits.  This can be used to split a commit into two:
 
@@ -995,7 +995,7 @@ add other commits.  This can be used to split a commit into two:
 
 - Now add the changes to the index that you want to have in the first
   commit.  You can use `git add` (possibly interactively) or
-  'git gui' (or both) to do that.
+  `git gui` (or both) to do that.
 
 - Commit the now-current index with whatever commit message is appropriate
   now.
@@ -1006,7 +1006,7 @@ add other commits.  This can be used to split a commit into two:
 
 If you are not absolutely sure that the intermediate revisions are
 consistent (they compile, pass the testsuite, etc.) you should use
-'git stash' to stash away the not-yet-committed changes
+`git stash` to stash away the not-yet-committed changes
 after each commit, test, and amend the commit if fixes are necessary.
 
 
@@ -1082,7 +1082,7 @@ Only works if the changes (patch IDs based on the diff contents) on
 `subsystem` are literally the same before and after the rebase
 `subsystem` did.
 
-In that case, the fix is easy because 'git rebase' knows to skip
+In that case, the fix is easy because `git rebase` knows to skip
 changes that are already present in the new upstream (unless
 `--reapply-cherry-picks` is given). So if you say
 (assuming you're on `topic`)
@@ -1110,7 +1110,7 @@ NOTE: While an "easy case recovery" sometimes appears to be successful
       example, a commit that was removed via `git rebase
       --interactive` will be **resurrected**!
 
-The idea is to manually tell 'git rebase' "where the old `subsystem`
+The idea is to manually tell `git rebase` "where the old `subsystem`
 ended and your `topic` began", that is, what the old merge base
 between them was.  You will have to find a way to name the last commit
 of the old `subsystem`, for example:
diff --git a/Documentation/git-receive-pack.txt b/Documentation/git-receive-pack.txt
index e6136a0938..5fc47a9ebd 100644
--- a/Documentation/git-receive-pack.txt
+++ b/Documentation/git-receive-pack.txt
@@ -9,27 +9,27 @@ git-receive-pack - Receive what is pushed into the repository
 SYNOPSIS
 --------
 [verse]
-'git-receive-pack' <directory>
+`git-receive-pack` <directory>
 
 DESCRIPTION
 -----------
-Invoked by 'git send-pack' and updates the repository with the
+Invoked by `git send-pack` and updates the repository with the
 information fed from the remote end.
 
 This command is usually not invoked directly by the end user.
-The UI for the protocol is on the 'git send-pack' side, and the
+The UI for the protocol is on the `git send-pack` side, and the
 program pair is meant to be used to push updates to remote
 repository.  For pull operations, see linkgit:git-fetch-pack[1].
 
 The command allows for creation and fast-forwarding of sha1 refs
 (heads/tags) on the remote end (strictly speaking, it is the
-local end 'git-receive-pack' runs, but to the user who is sitting at
+local end `git-receive-pack` runs, but to the user who is sitting at
 the send-pack end, it is updating the remote.  Confused?)
 
 There are other real-world examples of using update and
 post-update hooks found in the Documentation/howto directory.
 
-'git-receive-pack' honours the `receive.denyNonFastForwards` config
+`git-receive-pack` honours the `receive.denyNonFastForwards` config
 option, which tells it if updates to a ref should be denied if they
 are not fast-forwards.
 
@@ -80,25 +80,25 @@ the following environment variables:
 	in the push certificate.  If this does not match the value
 	recorded on the "nonce" header in the push certificate, it
 	may indicate that the certificate is a valid one that is
-	being replayed from a separate "git push" session.
+	being replayed from a separate `git push` session.
 
 `GIT_PUSH_CERT_NONCE_STATUS`::
 `UNSOLICITED`;;
-	"git push --signed" sent a nonce when we did not ask it to
+	`git push --signed` sent a nonce when we did not ask it to
 	send one.
 `MISSING`;;
-	"git push --signed" did not send any nonce header.
+	`git push --signed` did not send any nonce header.
 `BAD`;;
-	"git push --signed" sent a bogus nonce.
+	`git push --signed` sent a bogus nonce.
 `OK`;;
-	"git push --signed" sent the nonce we asked it to send.
+	`git push --signed` sent the nonce we asked it to send.
 `SLOP`;;
-	"git push --signed" sent a nonce different from what we
+	`git push --signed` sent a nonce different from what we
 	asked it to send now, but in a previous session.  See
 	`GIT_PUSH_CERT_NONCE_SLOP` environment variable.
 
 `GIT_PUSH_CERT_NONCE_SLOP`::
-	"git push --signed" sent a nonce different from what we
+	`git push --signed` sent a nonce different from what we
 	asked it to send now, but in a different session whose
 	starting time is different by this many seconds from the
 	current session.  Only meaningful when
@@ -196,7 +196,7 @@ non-zero exit code will generate an error message.
 
 Note that it is possible for refname to not have sha1-new when this
 hook runs.  This can easily occur if another user modifies the ref
-after it was updated by 'git-receive-pack', but before the hook was able
+after it was updated by `git-receive-pack`, but before the hook was able
 to evaluate it.  It is recommended that hooks rely on sha1-new
 rather than the current value of refname.
 
@@ -208,7 +208,7 @@ post-update will be called with the list of refs that have been updated.
 This can be used to implement any repository wide cleanup tasks.
 
 The exit code from this hook invocation is ignored; the only thing
-left for 'git-receive-pack' to do at that point is to exit itself
+left for `git-receive-pack` to do at that point is to exit itself
 anyway.
 
 This hook can be used, for example, to run `git update-server-info`
diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
index cf1d7e0810..c33a577a00 100644
--- a/Documentation/git-reflog.txt
+++ b/Documentation/git-reflog.txt
@@ -9,7 +9,7 @@ git-reflog - Manage reflog information
 SYNOPSIS
 --------
 [verse]
-'git reflog' <subcommand> <options>
+`git reflog` <subcommand> <options>
 
 DESCRIPTION
 -----------
@@ -17,13 +17,13 @@ The command takes various subcommands, and different options
 depending on the subcommand:
 
 [verse]
-'git reflog' ['show'] [log-options] [<ref>]
-'git reflog expire' [--expire=<time>] [--expire-unreachable=<time>]
+`git reflog` ['show'] [log-options] [<ref>]
+`git reflog expire` [--expire=<time>] [--expire-unreachable=<time>]
 	[--rewrite] [--updateref] [--stale-fix]
 	[--dry-run | -n] [--verbose] [--all [--single-worktree] | <refs>...]
-'git reflog delete' [--rewrite] [--updateref]
+`git reflog delete` [--rewrite] [--updateref]
 	[--dry-run | -n] [--verbose] ref@\{specifier\}...
-'git reflog exists' <ref>
+`git reflog exists` <ref>
 
 Reference logs, or "reflogs", record when the tips of branches and
 other references were updated in the local repository. Reflogs are
@@ -112,7 +112,7 @@ Options for `expire`
 	a missing commit, tree, or blob object.
 +
 This computation involves traversing all the reachable objects, i.e. it
-has the same cost as 'git prune'.  It is primarily intended to fix
+has the same cost as `git prune`.  It is primarily intended to fix
 corruption caused by garbage collecting using older versions of Git,
 which didn't protect objects referred to by reflogs.
 
diff --git a/Documentation/git-remote-ext.txt b/Documentation/git-remote-ext.txt
index 88ea7e1cc0..fd9b621fa2 100644
--- a/Documentation/git-remote-ext.txt
+++ b/Documentation/git-remote-ext.txt
@@ -8,7 +8,7 @@ git-remote-ext - Bridge smart transport to external command.
 SYNOPSIS
 --------
 [verse]
-git remote add <nick> "ext::<command>[ <arguments>...]"
+`git remote` add <nick> "ext::<command>[ <arguments>...]"
 
 DESCRIPTION
 -----------
@@ -16,8 +16,8 @@ This remote helper uses the specified '<command>' to connect
 to a remote Git server.
 
 Data written to stdin of the specified '<command>' is assumed
-to be sent to a git:// server, git-upload-pack, git-receive-pack
-or git-upload-archive (depending on situation), and data read
+to be sent to a git:// server, `git-upload-pack`, `git-receive-pack`
+or `git-upload-archive` (depending on situation), and data read
 from stdout of <command> is assumed to be received from
 the same service.
 
@@ -36,8 +36,8 @@ The following sequences have a special meaning:
 	upload-archive) of the service Git wants to invoke.
 
 '%S'::
-	Replaced with long name (git-receive-pack,
-	git-upload-pack, or git-upload-archive) of the service
+	Replaced with long name (`git-receive-pack`,
+	`git-upload-pack`, or `git-upload-archive`) of the service
 	Git wants to invoke.
 
 '%G' (must be the first characters in an argument)::
@@ -65,7 +65,7 @@ ENVIRONMENT VARIABLES PASSED TO COMMAND
 ---------------------------------------
 
 GIT_EXT_SERVICE::
-	Set to long name (git-upload-pack, etc...) of service helper needs
+	Set to long name (`git-upload-pack`, etc...) of service helper needs
 	to invoke.
 
 GIT_EXT_SERVICE_NOPREFIX::
@@ -76,8 +76,8 @@ GIT_EXT_SERVICE_NOPREFIX::
 EXAMPLES
 --------
 This remote helper is transparently used by Git when
-you use commands such as "git fetch <URL>", "git clone <URL>",
-, "git push <URL>" or "git remote add <nick> <URL>", where <URL>
+you use commands such as `git fetch <URL>`, `git clone <URL>`,
+, `git push <URL>` or `git remote add <nick> <URL>`, where <URL>
 begins with `ext::`.  Examples:
 
 "ext::ssh -i /home/foo/.ssh/somekey user&#64;host.example %S 'foo/repo'"::
@@ -87,32 +87,32 @@ begins with `ext::`.  Examples:
 
 "ext::socat -t3600 - ABSTRACT-CONNECT:/git-server %G/somerepo"::
 	Represents repository with path /somerepo accessible over
-	git protocol at abstract namespace address /git-server.
+	`git protocol at abstract namespace address` /git-server.
 
 "ext::git-server-alias foo %G/repo"::
 	Represents a repository with path /repo accessed using the
-	helper program "git-server-alias foo".  The path to the
+	helper program `git-server-alias foo`.  The path to the
 	repository and type of request are not passed on the command
 	line but as part of the protocol stream, as usual with git://
 	protocol.
 
 "ext::git-server-alias foo %G/repo %Vfoo"::
 	Represents a repository with path /repo accessed using the
-	helper program "git-server-alias foo".  The hostname for the
+	helper program `git-server-alias foo`.  The hostname for the
 	remote server passed in the protocol stream will be "foo"
 	(this allows multiple virtual Git servers to share a
 	link-level address).
 
 "ext::git-server-alias foo %G/repo% with% spaces %Vfoo"::
 	Represents a repository with path `/repo with spaces` accessed
-	using the helper program "git-server-alias foo".  The hostname for
+	using the helper program `git-server-alias foo`.  The hostname for
 	the remote server passed in the protocol stream will be "foo"
 	(this allows multiple virtual Git servers to share a
 	link-level address).
 
 "ext::git-ssl foo.example /bar"::
 	Represents a repository accessed using the helper program
-	"git-ssl foo.example /bar".  The type of request can be
+	`git-ssl foo.example /bar`.  The type of request can be
 	determined by the helper using environment variables (see
 	above).
 
diff --git a/Documentation/git-remote-fd.txt b/Documentation/git-remote-fd.txt
index 0451ceb8a2..14868c4678 100644
--- a/Documentation/git-remote-fd.txt
+++ b/Documentation/git-remote-fd.txt
@@ -12,12 +12,12 @@ SYNOPSIS
 DESCRIPTION
 -----------
 This helper uses specified file descriptors to connect to a remote Git server.
-This is not meant for end users but for programs and scripts calling git
-fetch, push or archive.
+This is not meant for end users but for programs and scripts calling `git
+fetch`, `push` or `archive`.
 
 If only <infd> is given, it is assumed to be a bidirectional socket connected
-to remote Git server (git-upload-pack, git-receive-pack or
-git-upload-archive). If both <infd> and <outfd> are given, they are assumed
+to remote Git server (`git-upload-pack`, `git-receive-pack` or
+`git-upload-archive`). If both <infd> and <outfd> are given, they are assumed
 to be pipes connected to a remote Git server (<infd> being the inbound pipe
 and <outfd> being the outbound pipe.
 
@@ -37,14 +37,14 @@ EXAMPLES
 --------
 `git fetch fd::17 master`::
 	Fetch master, using file descriptor #17 to communicate with
-	git-upload-pack.
+	`git-upload-pack`.
 
 `git fetch fd::17/foo master`::
 	Same as above.
 
 `git push fd::7,8 master (as URL)`::
 	Push master, using file descriptor #7 to read data from
-	git-receive-pack and file descriptor #8 to write data to
+	`git-receive-pack` and file descriptor #8 to write data to
 	same service.
 
 `git push fd::7,8/bar master`::
diff --git a/Documentation/git-remote.txt b/Documentation/git-remote.txt
index a28c72a9e4..4df63cad06 100644
--- a/Documentation/git-remote.txt
+++ b/Documentation/git-remote.txt
@@ -9,19 +9,19 @@ git-remote - Manage set of tracked repositories
 SYNOPSIS
 --------
 [verse]
-'git remote' [-v | --verbose]
-'git remote add' [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <url>
-'git remote rename' <old> <new>
-'git remote remove' <name>
-'git remote set-head' <name> (-a | --auto | -d | --delete | <branch>)
-'git remote set-branches' [--add] <name> <branch>...
-'git remote get-url' [--push] [--all] <name>
-'git remote set-url' [--push] <name> <newurl> [<oldurl>]
-'git remote set-url --add' [--push] <name> <newurl>
-'git remote set-url --delete' [--push] <name> <url>
-'git remote' [-v | --verbose] 'show' [-n] <name>...
-'git remote prune' [-n | --dry-run] <name>...
-'git remote' [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
+`git remote` [-v | --verbose]
+`git remote add` [-t <branch>] [-m <master>] [-f] [--[no-]tags] [--mirror=(fetch|push)] <name> <url>
+`git remote rename` <old> <new>
+`git remote remove` <name>
+`git remote set-head` <name> (-a | --auto | -d | --delete | <branch>)
+`git remote set-branches` [--add] <name> <branch>...
+`git remote get-url` [--push] [--all] <name>
+`git remote set-url` [--push] <name> <newurl> [<oldurl>]
+`git remote set-url --add` [--push] <name> <newurl>
+`git remote set-url --delete` [--push] <name> <url>
+`git remote` [-v | --verbose] 'show' [-n] <name>...
+`git remote prune` [-n | --dry-run] <name>...
+`git remote` [-v | --verbose] 'update' [-p | --prune] [(<group> | <remote>)...]
 
 DESCRIPTION
 -----------
@@ -245,7 +245,7 @@ $ git switch -c staging staging/master
 ...
 ------------
 
-* Imitate 'git clone' but track only selected branches
+* Imitate `git clone` but track only selected branches
 +
 ------------
 $ mkdir project.git
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 98373e4f36..c99a70e426 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,7 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+`git repack` [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
 
 DESCRIPTION
 -----------
@@ -55,16 +55,16 @@ to the new separate pack will be written.
 	deleted by way of being left in the old pack and then
 	removed.  Instead, the loose unreachable objects
 	will be pruned according to normal expiry rules
-	with the next 'git gc' invocation. See linkgit:git-gc[1].
+	with the next `git gc` invocation. See linkgit:git-gc[1].
 
 -d::
 	After packing, if the newly created packs make some
 	existing packs redundant, remove the redundant packs.
-	Also run  'git prune-packed' to remove redundant
+	Also run  `git prune-packed` to remove redundant
 	loose object files.
 
 -l::
-	Pass the `--local` option to 'git pack-objects'. See
+	Pass the `--local` option to `git pack-objects`. See
 	linkgit:git-pack-objects[1].
 
 -f::
@@ -76,12 +76,12 @@ to the new separate pack will be written.
 	linkgit:git-pack-objects[1].
 
 -q::
-	Pass the `-q` option to 'git pack-objects'. See
+	Pass the `-q` option to `git pack-objects`. See
 	linkgit:git-pack-objects[1].
 
 -n::
 	Do not update the server information with
-	'git update-server-info'.  This option skips
+	`git update-server-info`.  This option skips
 	updating local catalog files needed to publish
 	this repository (or a direct copy of it)
 	over HTTP or FTP.  See linkgit:git-update-server-info[1].
@@ -195,7 +195,7 @@ Various configuration variables affect packing, see
 linkgit:git-config[1] (search for "pack" and "delta").
 
 By default, the command passes `--delta-base-offset` option to
-'git pack-objects'; this typically results in slightly smaller packs,
+`git pack-objects`; this typically results in slightly smaller packs,
 but the generated packs are incompatible with versions of Git older than
 version 1.4.4. If you need to share your repository with such ancient Git
 versions, either directly or via the dumb http protocol, then you
diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
index f271d758c3..3da7c4de90 100644
--- a/Documentation/git-replace.txt
+++ b/Documentation/git-replace.txt
@@ -8,12 +8,12 @@ git-replace - Create, list, delete refs to replace objects
 SYNOPSIS
 --------
 [verse]
-'git replace' [-f] <object> <replacement>
-'git replace' [-f] --edit <object>
-'git replace' [-f] --graft <commit> [<parent>...]
-'git replace' [-f] --convert-graft-file
-'git replace' -d <object>...
-'git replace' [--format=<format>] [-l [<pattern>]]
+`git replace` [-f] <object> <replacement>
+`git replace` [-f] --edit <object>
+`git replace` [-f] --graft <commit> [<parent>...]
+`git replace` [-f] --convert-graft-file
+`git replace` -d <object>...
+`git replace` [--format=<format>] [-l [<pattern>]]
 
 DESCRIPTION
 -----------
@@ -36,7 +36,7 @@ except those doing reachability traversal (prune, pack transfer and
 fsck).
 
 It is possible to disable use of replacement references for any
-command using the `--no-replace-objects` option just after 'git'.
+command using the `--no-replace-objects` option just after `git`.
 
 For example if commit 'foo' has been replaced by commit 'bar':
 
@@ -100,7 +100,7 @@ OPTIONS
 --list <pattern>::
 	List replace refs for objects that match the given pattern (or
 	all if no pattern is given).
-	Typing "git replace" without arguments, also lists all replace
+	Typing `git replace` without arguments, also lists all replace
 	refs.
 
 --format=<format>::
@@ -124,9 +124,9 @@ CREATING REPLACEMENT OBJECTS
 ----------------------------
 
 linkgit:git-hash-object[1], linkgit:git-rebase[1], and
-https://github.com/newren/git-filter-repo[git-filter-repo], among other git commands, can be used to
+https://github.com/newren/git-filter-repo[git-filter-repo], among other `git` commands, can be used to
 create replacement objects from existing objects. The `--edit` option
-can also be used with 'git replace' to create a replacement object by
+can also be used with `git replace` to create a replacement object by
 editing an existing object.
 
 If you want to replace many blobs, trees or commits that are part of a
@@ -142,7 +142,7 @@ replace them will not work properly. And using `git reset --hard` to
 go back to a replaced commit will move the branch to the replacement
 commit instead of the replaced commit.
 
-There may be other problems when using 'git rev-list' related to
+There may be other problems when using `git rev-list` related to
 pending objects.
 
 SEE ALSO
diff --git a/Documentation/git-request-pull.txt b/Documentation/git-request-pull.txt
index f58164aee1..e9e703a814 100644
--- a/Documentation/git-request-pull.txt
+++ b/Documentation/git-request-pull.txt
@@ -8,7 +8,7 @@ git-request-pull - Generates a summary of pending changes
 SYNOPSIS
 --------
 [verse]
-'git request-pull' [-p] <start> <url> [<end>]
+`git request-pull` [-p] <start> <url> [<end>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 25990dc40b..687b08d56c 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
+`git rerere` ['clear'|'forget' <pathspec>|'diff'|'remaining'|'status'|'gc']
 
 DESCRIPTION
 -----------
@@ -31,14 +31,14 @@ enable this command.
 COMMANDS
 --------
 
-Normally, 'git rerere' is run without arguments or user-intervention.
+Normally, `git rerere` is run without arguments or user-intervention.
 However, it has several commands that allow it to interact with
 its working state.
 
 'clear'::
 
 Reset the metadata used by rerere if a merge resolution is to be
-aborted.  Calling 'git am [--skip|--abort]' or 'git rebase [--skip|--abort]'
+aborted.  Calling `git am [--skip|--abort]` or `git rebase [--skip|--abort]`
 will automatically invoke this command.
 
 'forget' <pathspec>::
@@ -153,32 +153,32 @@ finally ready and merged into the `master` branch.  This merge
 would require you to resolve the conflict, introduced by the
 commits marked with `*`.  However, this conflict is often the
 same conflict you resolved when you created the test merge you
-blew away.  'git rerere' helps you resolve this final
+blew away.  `git rerere` helps you resolve this final
 conflicted merge using the information from your earlier hand
 resolve.
 
-Running the 'git rerere' command immediately after a conflicted
+Running the `git rerere` command immediately after a conflicted
 automerge records the conflicted working tree files, with the
 usual conflict markers `<<<<<<<`, `=======`, and `>>>>>>>` in
 them.  Later, after you are done resolving the conflicts,
-running 'git rerere' again will record the resolved state of these
+running `git rerere` again will record the resolved state of these
 files.  Suppose you did this when you created the test merge of
 `master` into the `topic` branch.
 
 Next time, after seeing the same conflicted automerge,
-running 'git rerere' will perform a three-way merge between the
+running `git rerere` will perform a three-way merge between the
 earlier conflicted automerge, the earlier manual resolution, and
 the current conflicted automerge.
 If this three-way merge resolves cleanly, the result is written
 out to your working tree file, so you do not have to manually
-resolve it.  Note that 'git rerere' leaves the index file alone,
+resolve it.  Note that `git rerere` leaves the index file alone,
 so you still need to do the final sanity checks with `git diff`
-(or `git diff -c`) and 'git add' when you are satisfied.
+(or `git diff -c`) and `git add` when you are satisfied.
 
-As a convenience measure, 'git merge' automatically invokes
-'git rerere' upon exiting with a failed automerge and 'git rerere'
+As a convenience measure, `git merge` automatically invokes
+`git rerere` upon exiting with a failed automerge and `git rerere`
 records the hand resolve when it is a new conflict, or reuses the earlier hand
-resolve when it is not.  'git commit' also invokes 'git rerere'
+resolve when it is not.  `git commit` also invokes `git rerere`
 when committing a merge result.  What this means is that you do
 not have to do anything special yourself (besides enabling
 the `rerere.enabled` config variable).
@@ -188,8 +188,8 @@ resolution is recorded, and it will be reused when you do the
 actual merge later with the updated `master` and `topic` branch, as long
 as the recorded resolution is still applicable.
 
-The information 'git rerere' records is also used when running
-'git rebase'.  After blowing away the test merge and continuing
+The information `git rerere` records is also used when running
+`git rebase`.  After blowing away the test merge and continuing
 development on the `topic` branch:
 
 ------------
@@ -208,12 +208,12 @@ you could run `git rebase master topic`, to bring yourself
 up to date before your topic is ready to be sent upstream.
 This would result in falling back to a three-way merge, and it
 would conflict the same way as the test merge you resolved earlier.
-'git rerere' will be run by 'git rebase' to help you resolve this
+`git rerere` will be run by `git rebase` to help you resolve this
 conflict.
 
-[NOTE] 'git rerere' relies on the conflict markers in the file to
+[NOTE] `git rerere` relies on the conflict markers in the file to
 detect the conflict.  If the file already contains lines that look the
-same as lines with conflict markers, 'git rerere' may fail to record a
+same as lines with conflict markers, `git rerere` may fail to record a
 conflict resolution.  To work around this, the `conflict-marker-size`
 setting in linkgit:gitattributes[5] can be used.
 
diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 4a55d1f1ac..58fe574e71 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -8,10 +8,10 @@ git-reset - Reset current `HEAD` to the specified state
 SYNOPSIS
 --------
 [verse]
-'git reset' [-q] [<tree-ish>] [--] <pathspec>...
-'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
-'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
-'git reset' [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
+`git reset` [-q] [<tree-ish>] [--] <pathspec>...
+`git reset` [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]
+`git reset` (--patch | -p) [<tree-ish>] [--] [<pathspec>...]
+`git reset` [--soft | --mixed [-N] | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
@@ -20,8 +20,8 @@ In the last form, set the current branch head (`HEAD`) to `<commit>`,
 optionally modifying index and working tree to match.
 The `<tree-ish>`/`<commit>` defaults to `HEAD` in all forms.
 
-'git reset' [-q] [<tree-ish>] [--] <pathspec>...::
-'git reset' [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
+`git reset` [-q] [<tree-ish>] [--] <pathspec>...::
+`git reset` [-q] [--pathspec-from-file=<file> [--pathspec-file-nul]] [<tree-ish>]::
 	These forms reset the index entries for all paths that match the
 	`<pathspec>` to their state at `<tree-ish>`.  (It does not affect
 	the working tree or the current branch.)
@@ -37,7 +37,7 @@ and specifying a commit with `--source`, you
 can copy the contents of a path out of a commit to the index and to the
 working tree in one go.
 
-'git reset' (--patch | -p) [<tree-ish>] [--] [<pathspec>...]::
+`git reset` (--patch | -p) [<tree-ish>] [--] [<pathspec>...]::
 	Interactively select hunks in the difference between the index
 	and `<tree-ish>` (defaults to `HEAD`).  The chosen hunks are applied
 	in reverse to the index.
@@ -46,7 +46,7 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
 you can use it to selectively reset hunks. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
-'git reset' [<mode>] [<commit>]::
+`git reset` [<mode>] [<commit>]::
 	This form resets the current branch head to `<commit>` and
 	possibly updates the index (resetting it to the tree of `<commit>`) and
 	the working tree depending on `<mode>`. If `<mode>` is omitted,
@@ -285,7 +285,7 @@ Reset a single file in the index::
 +
 Suppose you have added a file to your index, but later decide you do not
 want to add it to your commit. You can remove the file from the index
-while keeping your changes with git reset.
+while keeping your changes with `git reset`.
 +
 ------------
 $ git reset -- frotz.c                      <1>
@@ -328,7 +328,7 @@ Split a commit apart into a sequence of commits::
 +
 Suppose that you have created lots of logically separate changes and committed
 them together. Then, later you decide that it might be better to have each
-logical chunk associated with its own commit. You can use git reset to rewind
+logical chunk associated with its own commit. You can use `git reset` to rewind
 history without changing the contents of your local files, and then successively
 use `git add -p` to interactively select which hunks to include into each commit,
 using `git commit -c` to pre-populate the commit message.
@@ -369,7 +369,7 @@ $ git commit ...                            <8>
     no longer use the patch mode of `git add`, in order to select all remaining
     uncommitted changes.
 <7> Once again, check to verify that you've included what you want to. You may
-    also wish to verify that git diff doesn't show any remaining changes to be
+    also wish to verify that `git diff` doesn't show any remaining changes to be
     committed later.
 <8> And finally create the final commit.
 
diff --git a/Documentation/git-restore.txt b/Documentation/git-restore.txt
index 55bde91ef9..eb7d765e5d 100644
--- a/Documentation/git-restore.txt
+++ b/Documentation/git-restore.txt
@@ -8,9 +8,9 @@ git-restore - Restore working tree files
 SYNOPSIS
 --------
 [verse]
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
-'git restore' [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
-'git restore' (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
+`git restore` [<options>] [--source=<tree>] [--staged] [--worktree] [--] <pathspec>...
+`git restore` [<options>] [--source=<tree>] [--staged] [--worktree] --pathspec-from-file=<file> [--pathspec-file-nul]
+`git restore` (-p|--patch) [<options>] [--source=<tree>] [--staged] [--worktree] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 20bb8e8217..c1ee42057b 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -9,7 +9,7 @@ git-rev-list - Lists commit objects in reverse chronological order
 SYNOPSIS
 --------
 [verse]
-'git rev-list' [<options>] <commit>... [[--] <path>...]
+`git rev-list` [<options>] <commit>... [[--] <path>...]
 
 DESCRIPTION
 -----------
@@ -20,8 +20,8 @@ include::rev-list-description.txt[]
 'rev-list' is a very essential Git command, since it
 provides the ability to build and traverse commit ancestry graphs. For
 this reason, it has a lot of different options that enables it to be
-used by commands as different as 'git bisect' and
-'git repack'.
+used by commands as different as `git bisect` and
+`git repack`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 5f6224847e..9908f3020f 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -9,16 +9,16 @@ git-rev-parse - Pick out and massage parameters
 SYNOPSIS
 --------
 [verse]
-'git rev-parse' [<options>] <args>...
+`git rev-parse` [<options>] <args>...
 
 DESCRIPTION
 -----------
 
 Many Git porcelainish commands take mixture of flags
 (i.e. parameters that begin with a dash '-') and parameters
-meant for the underlying 'git rev-list' command they use internally
+meant for the underlying `git rev-list` command they use internally
 and flags and parameters for the other commands they use
-downstream of 'git rev-list'.  This command is used to
+downstream of `git rev-list`.  This command is used to
 distinguish between them.
 
 
@@ -31,10 +31,10 @@ Operation Modes
 Each of these options must appear first on the command line.
 
 --parseopt::
-	Use 'git rev-parse' in option parsing mode (see PARSEOPT section below).
+	Use `git rev-parse` in option parsing mode (see PARSEOPT section below).
 
 --sq-quote::
-	Use 'git rev-parse' in shell quoting mode (see SQ-QUOTE
+	Use `git rev-parse` in shell quoting mode (see SQ-QUOTE
 	section below). In contrast to the `--sq` option below, this
 	mode does only quoting. Nothing else is done to command input.
 
@@ -59,11 +59,11 @@ Options for Filtering
 
 --revs-only::
 	Do not output flags and parameters not meant for
-	'git rev-list' command.
+	`git rev-list` command.
 
 --no-revs::
 	Do not output flags and parameters meant for
-	'git rev-list' command.
+	`git rev-list` command.
 
 --flags::
 	Do not output non-flag parameters.
@@ -79,7 +79,7 @@ Options for Output
 	instead.
 
 --prefix <arg>::
-	Behave as if 'git rev-parse' was invoked from the `<arg>`
+	Behave as if `git rev-parse` was invoked from the `<arg>`
 	subdirectory of the working tree.  Any relative filenames are
 	resolved as if they are prefixed by `<arg>` and will be printed
 	in that form.
@@ -127,7 +127,7 @@ for another option.
 	properly quoted for consumption by shell.  Useful when
 	you expect your parameter to contain whitespaces and
 	newlines (e.g. when using pickaxe `-S` with
-	'git diff-{asterisk}'). In contrast to the `--sq-quote` option,
+	`git diff-*`). In contrast to the `--sq-quote` option,
 	the command input is still interpreted as usual.
 
 --short[=length]::
@@ -246,8 +246,8 @@ print a message to stderr and exit with nonzero status.
 	Resolve "$GIT_DIR/<path>" and takes other path relocation
 	variables such as $GIT_OBJECT_DIRECTORY,
 	$GIT_INDEX_FILE... into account. For example, if
-	$GIT_OBJECT_DIRECTORY is set to /foo/bar then "git rev-parse
-	--git-path objects/abc" returns /foo/bar/abc.
+	$GIT_OBJECT_DIRECTORY is set to /foo/bar then `git rev-parse
+	--git-path objects/abc` returns /foo/bar/abc.
 
 --show-toplevel::
 	Show the (by default, absolute) path of the top-level directory
@@ -306,12 +306,12 @@ Other Options
 --since=datestring::
 --after=datestring::
 	Parse the date string, and output the corresponding
-	`--max-age=` parameter for 'git rev-list'.
+	`--max-age`= parameter for `git rev-list`.
 
 --until=datestring::
 --before=datestring::
 	Parse the date string, and output the corresponding
-	`--min-age=` parameter for 'git rev-list'.
+	`--min-age`= parameter for `git rev-list`.
 
 <args>...::
 	Flags and parameters to be parsed.
@@ -322,7 +322,7 @@ include::revisions.txt[]
 PARSEOPT
 --------
 
-In `--parseopt` mode, 'git rev-parse' helps massaging options to bring to shell
+In `--parseopt` mode, `git rev-parse` helps massaging options to bring to shell
 scripts the same facilities C builtins have. It works as an option normalizer
 (e.g. splits single switches aggregate values), a bit like `getopt(1)` does.
 
@@ -337,7 +337,7 @@ below for an example.
 Input Format
 ~~~~~~~~~~~~
 
-'git rev-parse --parseopt' input format is fully text based. It has two parts,
+`git rev-parse --parseopt` input format is fully text based. It has two parts,
 separated by a line that contains only `--`. The lines before the separator
 (should be one or more) are used for the usage.
 The lines after the separator describe the options.
@@ -428,13 +428,13 @@ An option group Header
 SQ-QUOTE
 --------
 
-In `--sq-quote` mode, 'git rev-parse' echoes on the standard output a
+In `--sq-quote` mode, `git rev-parse` echoes on the standard output a
 single line suitable for `sh(1)` `eval`. This line is made by
 normalizing the arguments following `--sq-quote`. Nothing other than
 quoting the arguments is done.
 
 If you want command input to still be interpreted as usual by
-'git rev-parse' before the output is shell quoted, see the `--sq`
+`git rev-parse` before the output is shell quoted, see the `--sq`
 option.
 
 Example
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index a232db1d98..0ebe45153e 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,8 +8,8 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
-'git revert' (--continue | --skip | --abort | --quit)
+`git revert` [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
+`git revert` (--continue | --skip | --abort | --quit)
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ related patches introduce, and record some new commits that record
 them.  This requires your working tree to be clean (no modifications
 from the `HEAD` commit).
 
-Note: 'git revert' is used to record some new commits to reverse the
+Note: `git revert` is used to record some new commits to reverse the
 effect of some earlier commits (often only a faulty one).  If you want to
 throw away all uncommitted changes in your working directory, you
 should see linkgit:git-reset[1], particularly the `--hard` option.  If
@@ -43,7 +43,7 @@ OPTIONS
 
 -e::
 --edit::
-	With this option, 'git revert' will let you edit the commit
+	With this option, `git revert` will let you edit the commit
 	message prior to committing the revert. This is the default if
 	you run the command from a terminal.
 
@@ -64,7 +64,7 @@ See the link:howto/revert-a-faulty-merge.html[revert-a-faulty-merge How-To] for
 more details.
 
 --no-edit::
-	With this option, 'git revert' will not start the commit
+	With this option, `git revert` will not start the commit
 	message editor.
 
 --cleanup=<mode>::
diff --git a/Documentation/git-rm.txt b/Documentation/git-rm.txt
index 56d9b0627f..24eb799d6e 100644
--- a/Documentation/git-rm.txt
+++ b/Documentation/git-rm.txt
@@ -8,7 +8,7 @@ git-rm - Remove files from the working tree and from the index
 SYNOPSIS
 --------
 [verse]
-'git rm' [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
+`git rm` [-f | --force] [-n] [-r] [--cached] [--ignore-unmatch]
 	  [--quiet] [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	  [--] [<pathspec>...]
 
@@ -148,7 +148,7 @@ with a Git version 1.7.8 or newer) will be removed from the work
 tree, as their repository lives inside the .git directory of the
 superproject. If a submodule (or one of those nested inside it)
 still uses a .git directory, `git rm` will move the submodules
-git directory into the superprojects git directory to protect
+`git` directory into the superprojects `git` directory to protect
 the submodule's history. If it exists the `submodule.<name>` section
 in the linkgit:gitmodules[5] file will also be removed and that file
 will be staged (unless `--cached` or `-n` are used).
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index 9d9ef3d945..916bd441d4 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -9,8 +9,8 @@ git-send-email - Send a collection of patches as emails
 SYNOPSIS
 --------
 [verse]
-'git send-email' [<options>] <file|directory|rev-list options>...
-'git send-email' --dump-aliases
+`git send-email` [<options>] <file|directory|rev-list options>...
+`git send-email` --dump-aliases
 
 
 DESCRIPTION
@@ -19,7 +19,7 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to `git send-email`.
 
 The header of the email is configurable via command-line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
@@ -66,7 +66,7 @@ This option may be specified multiple times.
 	Invoke a text editor (see GIT_EDITOR in linkgit:git-var[1])
 	to edit an introductory message for the patch series.
 +
-When `--compose` is used, git send-email will use the From, Subject, and
+When `--compose` is used, `git send-email` will use the From, Subject, and
 In-Reply-To headers specified in the message. If the body of the message
 (what you type after the headers and a blank line) only contains blank
 (or Git: prefixed) lines, the summary won't be sent, but From, Subject,
@@ -82,7 +82,7 @@ See the CONFIGURATION section for `sendemail.multiEdit`.
 	neither the command-line option nor `sendemail.from` are set, then the
 	user will be prompted for the value.  The default for the prompt will be
 	the value of GIT_AUTHOR_IDENT, or GIT_COMMITTER_IDENT if that is not
-	set, as returned by "git var -l".
+	set, as returned by `git var -l`.
 
 --reply-to=<address>::
 	Specify the address where replies from recipients should go to.
@@ -175,7 +175,7 @@ Sending
 --smtp-domain=<FQDN>::
 	Specifies the Fully Qualified Domain Name (FQDN) used in the
 	HELO/EHLO command to the SMTP server.  Some servers require the
-	FQDN to match your IP address.  If not set, git send-email attempts
+	FQDN to match your IP address.  If not set, `git send-email` attempts
 	to determine your FQDN automatically.  Default is the value of
 	`sendemail.smtpDomain`.
 
@@ -204,7 +204,7 @@ Furthermore, passwords need not be specified in configuration files
 or on the command line. If a username has been specified (with
 `--smtp-user` or a `sendemail.smtpUser`), but no password has been
 specified (with `--smtp-pass` or `sendemail.smtpPass`), then
-a password is obtained using 'git-credential'.
+a password is obtained using `git-credential`.
 
 --no-smtp-auth::
 	Disable SMTP authentication. Short hand for `--smtp-auth=none`
@@ -362,7 +362,7 @@ specified, as well as 'body' if `--no-signed-off-cc` is specified.
 --[no-]thread::
 	If this is set, the In-Reply-To and References headers will be
 	added to each email sent.  Whether each mail refers to the
-	previous email (`deep` threading per 'git format-patch'
+	previous email (`deep` threading per `git format-patch`
 	wording) or to the first email (`shallow` threading) is
 	governed by "--[no-]chain-reply-to".
 +
@@ -372,8 +372,8 @@ If disabled with `--no-thread`, those headers will not be added
 default to `--thread`.
 +
 It is up to the user to ensure that no In-Reply-To header already
-exists when 'git send-email' is asked to add it (especially note that
-'git format-patch' can be configured to do the threading itself).
+exists when `git send-email` is asked to add it (especially note that
+`git format-patch` can be configured to do the threading itself).
 Failure to do so may not produce the expected result in the
 recipient's MUA.
 
@@ -404,10 +404,10 @@ have been specified, in which case default to 'compose'.
 	When an argument may be understood either as a reference or as a file name,
 	choose to understand it as a format-patch argument (`--format-patch`)
 	or as a file name (`--no-format-patch`). By default, when such a conflict
-	occurs, git send-email will fail.
+	occurs, `git send-email` will fail.
 
 --quiet::
-	Make git-send-email less verbose.  One line per email should be
+	Make `git-send-email` less verbose.  One line per email should be
 	all that is output.
 
 --[no-]validate::
@@ -483,7 +483,7 @@ EXAMPLES
 --------
 Use gmail as the smtp server
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-To use 'git send-email' to send your patches through the GMail SMTP server,
+To use `git send-email` to send your patches through the GMail SMTP server,
 edit ~/.gitconfig to specify your account settings:
 
 ----
@@ -495,7 +495,7 @@ edit ~/.gitconfig to specify your account settings:
 ----
 
 If you have multi-factor authentication set up on your Gmail account, you will
-need to generate an app-specific password for use with 'git send-email'. Visit
+need to generate an app-specific password for use with `git send-email`. Visit
 https://security.google.com/settings/security/apppasswords to create it.
 
 If you do not have multi-factor authentication set up on your Gmail account,
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index 2cd2d823b3..46f7757b9a 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -9,24 +9,24 @@ git-send-pack - Push objects over Git protocol to another repository
 SYNOPSIS
 --------
 [verse]
-'git send-pack' [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
+`git send-pack` [--all] [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
 		[--[no-]signed|--signed=(true|false|if-asked)]
 		[<host>:]<directory> [<ref>...]
 
 DESCRIPTION
 -----------
-Usually you would want to use 'git push', which is a
+Usually you would want to use `git push`, which is a
 higher-level wrapper of this command, instead. See linkgit:git-push[1].
 
-Invokes 'git-receive-pack' on a possibly remote repository, and
+Invokes `git-receive-pack` on a possibly remote repository, and
 updates it from the current repository, sending named refs.
 
 
 OPTIONS
 -------
 --receive-pack=<git-receive-pack>::
-	Path to the 'git-receive-pack' program on the remote
+	Path to the `git-receive-pack` program on the remote
 	end.  Sometimes useful when pushing to a remote
 	repository over ssh, and you do not have the program in
 	a directory on the default $PATH.
@@ -89,7 +89,7 @@ be in a separate packet, and the list must end with a flush packet.
 
 <host>::
 	A remote host to house the repository.  When this
-	part is specified, 'git-receive-pack' is invoked via
+	part is specified, `git-receive-pack` is invoked via
 	ssh.
 
 <directory>::
@@ -123,7 +123,7 @@ and the destination side (after the colon).  The ref to be
 pushed is determined by finding a match that matches the source
 side, and where it is pushed is determined by using the
 destination side. The rules used to match a ref are the same
-rules used by 'git rev-parse' to resolve a symbolic ref
+rules used by `git rev-parse` to resolve a symbolic ref
 name. See linkgit:git-rev-parse[1].
 
  - It is an error if <src> does not match exactly one of the
diff --git a/Documentation/git-sh-i18n--envsubst.txt b/Documentation/git-sh-i18n--envsubst.txt
index 2ffaf9392e..6e0c3ffdc0 100644
--- a/Documentation/git-sh-i18n--envsubst.txt
+++ b/Documentation/git-sh-i18n--envsubst.txt
@@ -22,7 +22,7 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 plumbing scripts and/or are writing new ones.
 
-'git sh-i18n{litdd}envsubst' is Git's stripped-down copy of the GNU
+`git sh-i18n--envsubst` is Git's stripped-down copy of the GNU
 `envsubst(1)` program that comes with the GNU gettext package. It's
 used internally by linkgit:git-sh-i18n[1] to interpolate the variables
 passed to the `eval_gettext` function.
diff --git a/Documentation/git-sh-i18n.txt b/Documentation/git-sh-i18n.txt
index 60cf49cb2a..23c504bbd8 100644
--- a/Documentation/git-sh-i18n.txt
+++ b/Documentation/git-sh-i18n.txt
@@ -17,7 +17,7 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 Porcelain-ish scripts and/or are writing new ones.
 
-The 'git sh-i18n scriptlet is designed to be sourced (using
+The `git-sh-i18n` scriptlet is designed to be sourced (using
 `.`) by Git's porcelain programs implemented in shell
 script. It provides wrappers for the GNU `gettext` and
 `eval_gettext` functions accessible through the `gettext.sh`
diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 8632612c31..ed33a46a77 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -17,7 +17,7 @@ This is not a command the end user would want to run.  Ever.
 This documentation is meant for people who are studying the
 Porcelain-ish scripts and/or are writing new ones.
 
-The 'git sh-setup' scriptlet is designed to be sourced (using
+The `git-sh-setup` scriptlet is designed to be sourced (using
 `.`) by other shell scripts to set up some variables pointing at
 the normal Git directories and a few helper shell functions.
 
diff --git a/Documentation/git-shell.txt b/Documentation/git-shell.txt
index 11361f33e9..5b72dc53d6 100644
--- a/Documentation/git-shell.txt
+++ b/Documentation/git-shell.txt
@@ -9,9 +9,9 @@ git-shell - Restricted login shell for Git-only SSH access
 SYNOPSIS
 --------
 [verse]
-'chsh' -s $(command -v git-shell) <user>
-'git clone' <user>`@localhost:/path/to/repo.git`
-'ssh' <user>`@localhost`
+`chsh` -s $(command -v git-shell) <user>
+`git clone` <user>`@localhost:/path/to/repo.git`
+`ssh` <user>`@localhost`
 
 DESCRIPTION
 -----------
@@ -24,18 +24,18 @@ named `git-shell-commands` in the user's home directory.
 COMMANDS
 --------
 
-'git shell' accepts the following commands after the `-c` option:
+`git shell` accepts the following commands after the `-c` option:
 
-'git receive-pack <argument>'::
-'git upload-pack <argument>'::
-'git upload-archive <argument>'::
+`git receive-pack <argument>`::
+`git upload-pack <argument>`::
+`git upload-archive <argument>`::
 	Call the corresponding server-side command to support
-	the client's 'git push', 'git fetch', or 'git archive --remote'
+	the client's `git push`, `git fetch`, or `git archive --remote`
 	request.
 'cvs server'::
 	Imitate a CVS server.  See linkgit:git-cvsserver[1].
 
-If a `~/git-shell-commands` directory is present, 'git shell' will
+If a `~/git-shell-commands` directory is present, `git shell` will
 also handle other, custom commands by running
 "`git-shell-commands/<command> <arguments>`" from the user's home
 directory.
@@ -46,7 +46,7 @@ INTERACTIVE USE
 By default, the commands above can be executed only with the `-c`
 option; the shell is not interactive.
 
-If a `~/git-shell-commands` directory is present, 'git shell'
+If a `~/git-shell-commands` directory is present, `git shell`
 can also be run interactively (with no arguments).  If a `help`
 command is present in the `git-shell-commands` directory, it is
 run to provide the user with an overview of allowed actions.  Then a
@@ -79,9 +79,9 @@ EOF
 $ chmod +x $HOME/git-shell-commands/no-interactive-login
 ----------------
 
-To enable git-cvsserver access (which should generally have the
+To enable `git-cvsserver` access (which should generally have the
 `no-interactive-login` example above as a prerequisite, as creating
-the git-shell-commands directory allows interactive logins):
+the `git-shell`-commands directory allows interactive logins):
 
 ----------------
 $ cat >$HOME/git-shell-commands/cvs <<\EOF
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index c9c7f3065c..d9226b63da 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -8,18 +8,18 @@ git-shortlog - Summarize 'git log' output
 SYNOPSIS
 --------
 [verse]
-'git shortlog' [<options>] [<revision range>] [[--] <path>...]
-git log --pretty=short | 'git shortlog' [<options>]
+`git shortlog` [<options>] [<revision range>] [[--] <path>...]
+`git log` --pretty=short | `git shortlog` [<options>]
 
 DESCRIPTION
 -----------
-Summarizes 'git log' output in a format suitable for inclusion
+Summarizes `git log` output in a format suitable for inclusion
 in release announcements. Each commit will be grouped by author and title.
 
 Additionally, "[PATCH]" will be stripped from the commit description.
 
 If no revisions are passed on the command line and either standard input
-is not a terminal or there is no current branch, 'git shortlog' will
+is not a terminal or there is no current branch, `git shortlog` will
 output a summary of the log read from standard input, without
 reference to the current repository.
 
@@ -42,7 +42,7 @@ OPTIONS
 --format[=<format>]::
 	Instead of the commit subject, use some other information to
 	describe each commit.  '<format>' can be any string accepted
-	by the `--format` option of 'git log', such as '* [%h] %s'.
+	by the `--format` option of `git log`, such as '* [%h] %s'.
 	(See the "PRETTY FORMATS" section of linkgit:git-log[1].)
 
 	Each pretty-printed commit will be rewrapped before it is shown.
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index 0ce603646f..5531c435b0 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,12 +8,12 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git show-branch' [-a|--all] [-r|--remotes] [--topo-order | --date-order]
+`git show-branch` [-a|--all] [-r|--remotes] [--topo-order | --date-order]
 		[--current] [--color[=<when>] | --no-color] [--sparse]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
 		[(<rev> | <glob>)...]
-'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
+`git show-branch` (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
 
 DESCRIPTION
 -----------
@@ -104,9 +104,9 @@ OPTIONS
 	Shows only commits that are NOT on the first branch given.
 	This helps track topic branches by hiding any commit that
 	is already in the main line of development.  When given
-	"git show-branch --topics master topic1 topic2", this
-	will show the revisions given by "git rev-list {caret}master
-	topic1 topic2"
+	`git show-branch --topics master topic1 topic2`, this
+	will show the revisions given by `git rev-list {caret}master
+	topic1 topic2`
 
 -g::
 --reflog[=<n>[,<base>]] [<ref>]::
@@ -144,8 +144,8 @@ otherwise it shows a space.  Merge commits are denoted by
 a `-` sign.  Each commit shows a short name that
 can be used as an extended SHA-1 to name that commit.
 
-The following example shows three branches, "master", "fixes"
-and "mhf":
+The following example shows three branches, `master`, `fixes`
+and `mhf`:
 
 ------------------------------------------------
 $ git show-branch master fixes mhf
@@ -167,10 +167,10 @@ $ git show-branch master fixes mhf
 ------------------------------------------------
 
 These three branches all forked from a common commit, [master],
-whose commit message is "Add \'git show-branch'".
-The "fixes" branch adds one commit "Introduce "reset type" flag to
-"git reset"". The "mhf" branch adds many other commits.
-The current branch is "master".
+whose commit message is "Add `git show-branch`".
+The `fixes` branch adds one commit "Introduce "reset type" flag to
+`git reset`". The `mhf` branch adds many other commits.
+The current branch is `master`.
 
 
 EXAMPLES
diff --git a/Documentation/git-show-index.txt b/Documentation/git-show-index.txt
index e49318a5a0..0d4b36859d 100644
--- a/Documentation/git-show-index.txt
+++ b/Documentation/git-show-index.txt
@@ -9,7 +9,7 @@ git-show-index - Show packed archive index
 SYNOPSIS
 --------
 [verse]
-'git show-index' [--object-format=<hash-algorithm>]
+`git show-index` [--object-format=<hash-algorithm>]
 
 
 DESCRIPTION
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index 9d7ba22603..28be080b96 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -8,10 +8,10 @@ git-show-ref - List references in a local repository
 SYNOPSIS
 --------
 [verse]
-'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
+`git show-ref` [-q|--quiet] [--verify] [--head] [-d|--dereference]
 	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
 	     [--heads] [--] [<pattern>...]
-'git show-ref' --exclude-existing[=<pattern>]
+`git show-ref` --exclude-existing[=<pattern>]
 
 DESCRIPTION
 -----------
@@ -75,7 +75,7 @@ OPTIONS
 
 --exclude-existing[=<pattern>]::
 
-	Make 'git show-ref' act as a filter that reads refs from stdin of the
+	Make `git show-ref` act as a filter that reads refs from stdin of the
 	form "`^(?:<anything>\s)?<refname>(?:\^{})?$`"
 	and performs the following actions on each:
 	(1) strip "{caret}{}" at the end of line if any;
@@ -142,7 +142,7 @@ When using the `--verify` flag, the command requires an exact path:
 
 will only match the exact branch called "master".
 
-If nothing matches, 'git show-ref' will return an error code of 1,
+If nothing matches, `git show-ref` will return an error code of 1,
 and in the case of verification, it will show an error message.
 
 For scripting, you can ask it to be quiet with the `--quiet` flag, which
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index b7a6f9b544..02f854940f 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -9,7 +9,7 @@ git-show - Show various types of objects
 SYNOPSIS
 --------
 [verse]
-'git show' [<options>] [<object>...]
+`git show` [<options>] [<object>...]
 
 DESCRIPTION
 -----------
@@ -17,16 +17,16 @@ Shows one or more objects (blobs, trees, tags and commits).
 
 For commits it shows the log message and textual diff. It also
 presents the merge commit in a special format as produced by
-'git diff-tree --cc'.
+`git diff-tree --cc`.
 
 For tags, it shows the tag message and the referenced objects.
 
-For trees, it shows the names (equivalent to 'git ls-tree'
-with --name-only).
+For trees, it shows the names (equivalent to `git ls-tree`
+with `--name-only`).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the 'git diff-tree' command to
+The command takes options applicable to the `git diff-tree` command to
 control how the changes the commit introduces are shown.
 
 This manual page describes only the most frequently used options.
diff --git a/Documentation/git-sparse-checkout.txt b/Documentation/git-sparse-checkout.txt
index a0eeaeb02e..efadc656e8 100644
--- a/Documentation/git-sparse-checkout.txt
+++ b/Documentation/git-sparse-checkout.txt
@@ -11,7 +11,7 @@ given by a list of patterns.
 SYNOPSIS
 --------
 [verse]
-'git sparse-checkout <subcommand> [options]'
+`git sparse-checkout <subcommand> [options]`
 
 
 DESCRIPTION
@@ -83,7 +83,7 @@ C-style quoted strings.
 'disable'::
 	Disable the `core.sparseCheckout` config setting, and restore the
 	working directory to include all files. Leaves the sparse-checkout
-	file intact so a later 'git sparse-checkout init' command may
+	file intact so a later `git sparse-checkout init` command may
 	return the working directory to the same state.
 
 SPARSE CHECKOUT
@@ -193,7 +193,7 @@ A/B/C
 
 If `core.ignoreCase=true`, then the pattern-matching algorithm will use a
 case-insensitive check. This corrects for case mismatched filenames in the
-'git sparse-checkout set' command to reflect the expected cone in the working
+`git sparse-checkout set` command to reflect the expected cone in the working
 directory.
 
 
diff --git a/Documentation/git-stage.txt b/Documentation/git-stage.txt
index 25bcda936d..523772c45a 100644
--- a/Documentation/git-stage.txt
+++ b/Documentation/git-stage.txt
@@ -9,7 +9,7 @@ git-stage - Add file contents to the staging area
 SYNOPSIS
 --------
 [verse]
-'git stage' args...
+`git stage` args...
 
 
 DESCRIPTION
diff --git a/Documentation/git-stash.txt b/Documentation/git-stash.txt
index a2b69ae00f..142e5f3751 100644
--- a/Documentation/git-stash.txt
+++ b/Documentation/git-stash.txt
@@ -8,18 +8,18 @@ git-stash - Stash the changes in a dirty working directory away
 SYNOPSIS
 --------
 [verse]
-'git stash' list [<log-options>]
-'git stash' show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
-'git stash' drop [-q|--quiet] [<stash>]
-'git stash' ( pop | apply ) [--index] [-q|--quiet] [<stash>]
-'git stash' branch <branchname> [<stash>]
-'git stash' [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
+`git stash` list [<log-options>]
+`git stash` show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]
+`git stash` drop [-q|--quiet] [<stash>]
+`git stash` ( pop | apply ) [--index] [-q|--quiet] [<stash>]
+`git stash` branch <branchname> [<stash>]
+`git stash` [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
 	     [-u|--include-untracked] [-a|--all] [-m|--message <message>]
 	     [--pathspec-from-file=<file> [--pathspec-file-nul]]
 	     [--] [<pathspec>...]]
-'git stash' clear
-'git stash' create [<message>]
-'git stash' store [-m|--message <message>] [-q|--quiet] <commit>
+`git stash` clear
+`git stash` create [<message>]
+`git stash` store [-m|--message <message>] [-q|--quiet] <commit>
 
 DESCRIPTION
 -----------
@@ -62,7 +62,7 @@ which are allowed after a double hyphen `--` for disambiguation.
 
 save [-p|--patch] [-k|--[no-]keep-index] [-u|--include-untracked] [-a|--all] [-q|--quiet] [<message>]::
 
-	This option is deprecated in favour of 'git stash push'.  It
+	This option is deprecated in favour of `git stash push`.  It
 	differs from "stash push" in that it cannot take pathspec.
 	Instead, all non-option arguments are concatenated to form the stash
 	message.
@@ -80,7 +80,7 @@ stash@{0}: WIP on submit: 6ebd0e2... Update git-stash documentation
 stash@{1}: On master: 9cc0589... Add git-stash
 ----------------------------------------------------------------
 +
-The command takes options applicable to the 'git log'
+The command takes options applicable to the `git log`
 command to control what is shown and how. See linkgit:git-log[1].
 
 show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
@@ -89,7 +89,7 @@ show [-u|--include-untracked|--only-untracked] [<diff-options>] [<stash>]::
 	stashed contents and the commit back when the stash entry was first
 	created.
 	By default, the command shows the diffstat, but it will accept any
-	format known to 'git diff' (e.g., `git stash show -p stash@{1}`
+	format known to `git diff` (e.g., `git stash show -p stash@{1}`
 	to view the second most recent entry in patch form).
 	You can use stash.showIncludeUntracked, stash.showStat, and
 	stash.showPatch config variables to change the default behavior.
@@ -144,7 +144,7 @@ create::
 
 store::
 
-	Store a given stash created via 'git stash create' (which is a
+	Store a given stash created via `git stash create` (which is a
 	dangling merge commit) in the stash ref, updating the stash
 	reflog.  This is intended to be useful for scripts.  It is
 	probably not the command you want to use; see "push" above.
@@ -310,7 +310,7 @@ $ git reset --soft HEAD^
 # ... continue hacking ...
 ----------------------------------------------------------------
 +
-You can use 'git stash' to simplify the above, like this:
+You can use `git stash` to simplify the above, like this:
 +
 ----------------------------------------------------------------
 # ... hack hack hack ...
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 0c9b68e981..2abb6d69f5 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -9,7 +9,7 @@ git-status - Show the working tree status
 SYNOPSIS
 --------
 [verse]
-'git status' [<options>...] [--] [<pathspec>...]
+`git status` [<options>...] [--] [<pathspec>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ current `HEAD` commit, paths that have differences between the working
 tree and the index file, and paths in the working tree that are not
 tracked by Git (and are not ignored by linkgit:gitignore[5]). The first
 are what you _would_ commit by running `git commit`; the second and
-third are what you _could_ commit by running 'git add' before running
+third are what you _could_ commit by running `git add` before running
 `git commit`.
 
 OPTIONS
@@ -430,7 +430,7 @@ that the summary output from the status command will be suppressed for all
 submodules when `diff.ignoreSubmodules` is set to 'all' or only for those
 submodules where `submodule.<name>.ignore=all`. To also view the summary for
 ignored submodules you can either use the `--ignore-submodules=dirty` command
-line option or the 'git submodule summary' command, which shows a similar
+line option or the `git submodule summary` command, which shows a similar
 output but does not honor these settings.
 
 BACKGROUND REFRESH
diff --git a/Documentation/git-stripspace.txt b/Documentation/git-stripspace.txt
index 2438f76da0..6397de9cb3 100644
--- a/Documentation/git-stripspace.txt
+++ b/Documentation/git-stripspace.txt
@@ -9,8 +9,8 @@ git-stripspace - Remove unnecessary whitespace
 SYNOPSIS
 --------
 [verse]
-'git stripspace' [-s | --strip-comments]
-'git stripspace' [-c | --comment-lines]
+`git stripspace` [-s | --strip-comments]
+`git stripspace` [-c | --comment-lines]
 
 DESCRIPTION
 -----------
@@ -64,7 +64,7 @@ Given the following noisy input with '$' indicating the end of a line:
 |  $
 ---------
 
-Use 'git stripspace' with no arguments to obtain:
+Use `git stripspace` with no arguments to obtain:
 
 ---------
 |A brief introduction$
@@ -78,7 +78,7 @@ Use 'git stripspace' with no arguments to obtain:
 |The end.$
 ---------
 
-Use 'git stripspace --strip-comments' to obtain:
+Use `git stripspace --strip-comments` to obtain:
 
 ---------
 |A brief introduction$
diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index e68d91a406..b97531f808 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -9,18 +9,18 @@ git-submodule - Initialize, update or inspect submodules
 SYNOPSIS
 --------
 [verse]
-'git submodule' [--quiet] [--cached]
-'git submodule' [--quiet] add [<options>] [--] <repository> [<path>]
-'git submodule' [--quiet] status [--cached] [--recursive] [--] [<path>...]
-'git submodule' [--quiet] init [--] [<path>...]
-'git submodule' [--quiet] deinit [-f|--force] (--all|[--] <path>...)
-'git submodule' [--quiet] update [<options>] [--] [<path>...]
-'git submodule' [--quiet] set-branch [<options>] [--] <path>
-'git submodule' [--quiet] set-url [--] <path> <newurl>
-'git submodule' [--quiet] summary [<options>] [--] [<path>...]
-'git submodule' [--quiet] foreach [--recursive] <command>
-'git submodule' [--quiet] sync [--recursive] [--] [<path>...]
-'git submodule' [--quiet] absorbgitdirs [--] [<path>...]
+`git submodule` [--quiet] [--cached]
+`git submodule` [--quiet] add [<options>] [--] <repository> [<path>]
+`git submodule` [--quiet] status [--cached] [--recursive] [--] [<path>...]
+`git submodule` [--quiet] init [--] [<path>...]
+`git submodule` [--quiet] deinit [-f|--force] (--all|[--] <path>...)
+`git submodule` [--quiet] update [<options>] [--] [<path>...]
+`git submodule` [--quiet] set-branch [<options>] [--] <path>
+`git submodule` [--quiet] set-url [--] <path> <newurl>
+`git submodule` [--quiet] summary [<options>] [--] [<path>...]
+`git submodule` [--quiet] foreach [--recursive] <command>
+`git submodule` [--quiet] sync [--recursive] [--] [<path>...]
+`git submodule` [--quiet] absorbgitdirs [--] [<path>...]
 
 
 DESCRIPTION
@@ -69,13 +69,13 @@ cloning the superproject. If the URL is given relative to the
 superproject's repository, the presumption is the superproject and
 submodule repositories will be kept together in the same relative
 location, and only the superproject's URL needs to be provided.
-git-submodule will correctly locate the submodule using the relative
+`git-submodule` will correctly locate the submodule using the relative
 URL in `.gitmodules`.
 
 status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
-	submodule path and the output of 'git describe' for the
+	submodule path and the output of `git describe` for the
 	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
 	not initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
@@ -247,16 +247,16 @@ If `--recursive` is specified, this command will recurse into the
 registered submodules, and sync any nested submodules within.
 
 absorbgitdirs::
-	If a git directory of a submodule is inside the submodule,
-	move the git directory of the submodule into its superproject's
-	`$GIT_DIR/modules` path and then connect the git directory and
+	If a `git` directory of a submodule is inside the submodule,
+	move the `git` directory of the submodule into its superproject's
+	`$GIT_DIR/modules` path and then connect the `git` directory and
 	its working directory by setting the `core.worktree` and adding
-	a .git file pointing to the git directory embedded in the
-	superprojects git directory.
+	a .git file pointing to the `git` directory embedded in the
+	superprojects `git` directory.
 +
 A repository that was cloned independently and later added as a submodule or
-old setups have the submodules git directory inside the submodule instead of
-embedded into the superprojects git directory.
+old setups have the submodules `git` directory inside the submodule instead of
+embedded into the superprojects `git` directory.
 +
 This command is recursive by default.
 
@@ -383,7 +383,7 @@ the submodule itself.
 
 --init::
 	This option is only valid for the update command.
-	Initialize all submodules for which "git submodule init" has not been
+	Initialize all submodules for which `git submodule init` has not been
 	called so far before updating.
 
 --name::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 91495cfa01..3097f4f1c5 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -8,15 +8,15 @@ git-svn - Bidirectional operation between a Subversion repository and Git
 SYNOPSIS
 --------
 [verse]
-'git svn' <command> [<options>] [<arguments>]
+`git svn` <command> [<options>] [<arguments>]
 
 DESCRIPTION
 -----------
-'git svn' is a simple conduit for changesets between Subversion and Git.
+`git svn` is a simple conduit for changesets between Subversion and Git.
 It provides a bidirectional flow of changes between a Subversion and a Git
 repository.
 
-'git svn' can track a standard Subversion repository,
+`git svn` can track a standard Subversion repository,
 following the common "trunk/branches/tags" layout, with the `--stdlayout` option.
 It can also follow branches and tags in any layout with the `-T`/`-t`/`-b` options
 (see options to 'init' below, and also the 'clone' command).
@@ -30,7 +30,7 @@ COMMANDS
 
 'init'::
 	Initializes an empty Git repository with additional
-	metadata directories for 'git svn'.  The Subversion URL
+	metadata directories for `git svn`.  The Subversion URL
 	may be specified as a command-line argument, or as full
 	URL arguments to `-T`/`-t`/`-b`.  Optionally, the target
 	directory to operate on can be specified as a second
@@ -109,12 +109,12 @@ your Perl's Getopt::Long is < v2.37).
 	of `--include-paths`.
 --no-minimize-url;;
 	When tracking multiple directories (using `--stdlayout`,
-	`--branches`, or `--tags` options), git svn will attempt to connect
+	`--branches`, or `--tags` options), `git svn` will attempt to connect
 	to the root (or highest allowed level) of the Subversion
 	repository.  This default allows better tracking of history if
 	entire projects are moved within a repository, but may cause
 	issues on repositories where read access restrictions are in
-	place.  Passing `--no-minimize-url` will allow git svn to
+	place.  Passing `--no-minimize-url` will allow `git svn` to
 	accept URLs as-is without attempting to connect to a higher
 	level directory.  This option is off by default when only
 	one URL/branch is tracked (it would do little good).
@@ -130,7 +130,7 @@ This automatically updates the rev_map if needed (see
 
 --localtime;;
 	Store Git commit times in the local time zone instead of UTC.  This
-	makes 'git log' (even without `--date=local`) show the same times
+	makes `git log` (even without `--date=local`) show the same times
 	that `svn log` would in the local time zone.
 +
 This doesn't interfere with interoperating with the Subversion
@@ -227,15 +227,15 @@ config key: `svn-remote.<name>.include-paths`
 	This fetches revisions from the SVN parent of the current `HEAD`
 	and rebases the current (uncommitted to SVN) work against it.
 +
-This works similarly to `svn update` or 'git pull' except that
-it preserves linear history with 'git rebase' instead of
-'git merge' for ease of dcommitting with 'git svn'.
+This works similarly to `svn update` or `git pull` except that
+it preserves linear history with `git rebase` instead of
+`git merge` for ease of dcommitting with `git svn`.
 +
-This accepts all options that 'git svn fetch' and 'git rebase'
+This accepts all options that `git svn fetch` and `git rebase`
 accept.  However, `--fetch-all` only fetches from the current
 [svn-remote], and not all [svn-remote] definitions.
 +
-Like 'git rebase'; this requires that the working tree be clean
+Like `git rebase`; this requires that the working tree be clean
 and have no uncommitted changes.
 +
 This automatically updates the rev_map if needed (see
@@ -243,7 +243,7 @@ This automatically updates the rev_map if needed (see
 
 -l;;
 --local;;
-	Do not fetch remotely; only run 'git rebase' against the
+	Do not fetch remotely; only run `git rebase` against the
 	last fetched commit from the upstream SVN.
 
 'dcommit'::
@@ -262,7 +262,7 @@ Use of 'dcommit' is preferred to 'set-tree' (below).
 	After committing, do not rebase or reset.
 --commit-url <URL>;;
 	Commit to this SVN URL (the full path).  This is intended to
-	allow existing 'git svn' repositories created with one transport
+	allow existing `git svn` repositories created with one transport
 	method (e.g. `svn://` or `http://` for anonymous read) to be
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
@@ -289,7 +289,7 @@ discouraged.
 [verse]
 config key: `svn.pushmergeinfo`
 +
-This option will cause git-svn to attempt to automatically populate the
+This option will cause `git-svn` to attempt to automatically populate the
 svn:mergeinfo property in the SVN repository when possible. Currently, this can
 only be done when dcommitting non-fast-forward merges where all parents but the
 first have already been pushed into SVN.
@@ -299,7 +299,7 @@ first have already been pushed into SVN.
 	For each patch, one may answer "yes" (accept this patch), "no" (discard this
 	patch), "all" (accept all patches), or "quit".
 +
-'git svn dcommit' returns immediately if answer is "no" or "quit", without
+`git svn dcommit` returns immediately if answer is "no" or "quit", without
 committing anything to SVN.
 
 'branch'::
@@ -312,7 +312,7 @@ committing anything to SVN.
 -t;;
 --tag;;
 	Create a tag by using the tags_subdir instead of the branches_subdir
-	specified during git svn init.
+	specified during `git svn` init.
 
 -d<path>;;
 --destination=<path>;;
@@ -387,7 +387,7 @@ NOTE: SVN itself only stores times in UTC and nothing else. The regular svn
 client converts the UTC time to the local time (or based on the TZ=
 environment). This command has the same behaviour.
 +
-Any other arguments are passed directly to 'git log'
+Any other arguments are passed directly to `git log`
 
 'blame'::
 	Show what revision and author last modified each line of a file. The
@@ -395,10 +395,10 @@ Any other arguments are passed directly to 'git log'
 	`svn blame' by default. Like the SVN blame command,
 	local uncommitted changes in the working tree are ignored;
 	the version of the file in the `HEAD` revision is annotated. Unknown
-	arguments are passed directly to 'git blame'.
+	arguments are passed directly to `git blame`.
 +
 --git-format;;
-	Produce output in the same format as 'git blame', but with
+	Produce output in the same format as `git blame`, but with
 	SVN revision numbers instead of Git commit hashes. In this mode,
 	changes that haven't been committed to SVN (including local
 	working-copy edits) are shown as revision 0.
@@ -428,7 +428,7 @@ Any other arguments are passed directly to 'git log'
 	absolutely no attempts to do patching when committing to SVN, it
 	simply overwrites files with those specified in the tree or
 	commit.  All merging is assumed to have taken place
-	independently of 'git svn' functions.
+	independently of `git svn` functions.
 
 'create-ignore'::
 	Recursively finds the svn:ignore property on directories and
@@ -445,8 +445,8 @@ Any other arguments are passed directly to 'git log'
 	Attempts to recreate empty directories that core Git cannot track
 	based on information in $GIT_DIR/svn/<refname>/unhandled.log files.
 	Empty directories are automatically recreated when using
-	"git svn clone" and "git svn rebase", so "mkdirs" is intended
-	for use after commands like "git checkout" or "git reset".
+	`git svn clone` and `git svn rebase`, so "mkdirs" is intended
+	for use after commands like `git checkout` or `git reset`.
 	(See the `svn-remote.<name>.automkdirs` config file option for
 	more information.)
 
@@ -456,8 +456,8 @@ Any other arguments are passed directly to 'git log'
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
 	URL of the target Subversion repository.  The final argument
-	(URL) may be omitted if you are working from a 'git svn'-aware
-	repository (that has been `init`-ed with 'git svn').
+	(URL) may be omitted if you are working from a `git svn`-aware
+	repository (that has been `init`-ed with `git svn`).
 	The `-r<revision>` option is required for this.
 +
 The commit message is supplied either directly with the `-m` or `-F`
@@ -525,7 +525,7 @@ This will set the property 'svn:keywords' to 'FreeBSD=%H' for the file
 +
 Only the rev_map and refs/remotes/git-svn are changed (see
 '$GIT_DIR/svn/\**/.rev_map.*' in the FILES section below for details).
-Follow 'reset' with a 'fetch' and then 'git reset' or 'git rebase' to
+Follow 'reset' with a 'fetch' and then `git reset` or `git rebase` to
 move local branches onto the new tree.
 
 -r <n>;;
@@ -558,8 +558,8 @@ git svn fetch
        r2---r3---A---B master
 ------------
 +
-Then fixup `master` with 'git rebase'.
-Do NOT use 'git merge' or your history will not be compatible with a
+Then fixup `master` with `git rebase`.
+Do NOT use `git merge` or your history will not be compatible with a
 future 'dcommit'!
 +
 [verse]
@@ -577,7 +577,7 @@ OPTIONS
 --shared[=(false|true|umask|group|all|world|everybody)]::
 --template=<template_directory>::
 	Only used with the 'init' command.
-	These are passed directly to 'git init'.
+	These are passed directly to `git init`.
 
 -r <arg>::
 --revision <arg>::
@@ -597,7 +597,7 @@ and lost.
 +
 Read a list of commits from stdin and commit them in reverse
 order.  Only the leading sha1 is read from each line, so
-'git rev-list --pretty=oneline' output can be used.
+`git rev-list --pretty=oneline` output can be used.
 
 --rmdir::
 	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
@@ -626,7 +626,7 @@ config key: `svn.edit`
 --find-copies-harder::
 	Only used with the 'dcommit', 'set-tree' and 'commit-diff' commands.
 +
-They are both passed directly to 'git diff-tree'; see
+They are both passed directly to `git diff-tree`; see
 linkgit:git-diff-tree[1] for more information.
 +
 [verse]
@@ -635,17 +635,17 @@ config key: `svn.findcopiesharder`
 
 -A<filename>::
 --authors-file=<filename>::
-	Syntax is compatible with the file used by 'git cvsimport' but
+	Syntax is compatible with the file used by `git cvsimport` but
 	an empty email address can be supplied with '<>':
 +
 ------------------------------------------------------------------------
 	loginname = Joe User <user@example.com>
 ------------------------------------------------------------------------
 +
-If this option is specified and 'git svn' encounters an SVN
-committer name that does not exist in the authors-file, 'git svn'
+If this option is specified and `git svn` encounters an SVN
+committer name that does not exist in the authors-file, `git svn`
 will abort operation. The user will then have to add the
-appropriate entry.  Re-running the previous 'git svn' command
+appropriate entry.  Re-running the previous `git svn` command
 after the authors-file is modified should continue operation.
 +
 [verse]
@@ -669,7 +669,7 @@ config key: `svn.authorsProg`
 
 -q::
 --quiet::
-	Make 'git svn' less verbose. Specify a second time to make it
+	Make `git svn` less verbose. Specify a second time to make it
 	even less verbose.
 
 -m::
@@ -681,8 +681,8 @@ config key: `svn.authorsProg`
 --preserve-merges (DEPRECATED)::
 	These are only used with the 'dcommit' and 'rebase' commands.
 +
-Passed directly to 'git rebase' when using 'dcommit' if a
-'git reset' cannot be used (see 'dcommit').
+Passed directly to `git rebase` when using 'dcommit' if a
+`git reset` cannot be used (see 'dcommit').
 
 -n::
 --dry-run::
@@ -741,7 +741,7 @@ ADVANCED OPTIONS
 	a suitable parent in the first Git commit for the branch.
 	This is especially helpful when we're tracking a directory
 	that has been moved around within the repository.  If this
-	feature is disabled, the branches created by 'git svn' will all
+	feature is disabled, the branches created by `git svn` will all
 	be linear and not share any history, meaning that there will be
 	no information on where branches were branched off or merged.
 	However, following long/convoluted histories can take a long
@@ -759,12 +759,12 @@ svn.noMetadata::
 svn-remote.<name>.noMetadata::
 	This gets rid of the 'git-svn-id:' lines at the end of every commit.
 +
-This option can only be used for one-shot imports as 'git svn'
+This option can only be used for one-shot imports as `git svn`
 will not be able to fetch again without metadata. Additionally,
-if you lose your '$GIT_DIR/svn/\**/.rev_map.*' files, 'git svn' will not
+if you lose your '$GIT_DIR/svn/\**/.rev_map.*' files, `git svn` will not
 be able to rebuild them.
 +
-The 'git svn log' command will not work on repositories using
+The `git svn log` command will not work on repositories using
 this, either.  Using this conflicts with the 'useSvmProps'
 option for (hopefully) obvious reasons.
 +
@@ -778,7 +778,7 @@ and rewriting authorship info for non-`svn.authorsFile` users.
 
 svn.useSvmProps::
 svn-remote.<name>.useSvmProps::
-	This allows 'git svn' to re-map repository URLs and UUIDs from
+	This allows `git svn` to re-map repository URLs and UUIDs from
 	mirrors created using SVN::Mirror (or svk) for metadata.
 +
 If an SVN revision has a property, "svm:headrev", it is likely
@@ -797,7 +797,7 @@ svn-remote.<name>.useSvnsyncprops::
 
 svn-remote.<name>.rewriteRoot::
 	This allows users to create repositories from alternate
-	URLs.  For example, an administrator could run 'git svn' on the
+	URLs.  For example, an administrator could run `git svn` on the
 	server locally (accessing via file://) but wish to distribute
 	the repository with a public http:// or svn:// URL in the
 	metadata so users of it will see the public URL.
@@ -823,26 +823,26 @@ svn.brokenSymlinkWorkaround::
 	broken symlinks checked into SVN by broken clients.  Set this
 	option to "false" if you track a SVN repository with many
 	empty blobs that are not symlinks.  This option may be changed
-	while 'git svn' is running and take effect on the next
-	revision fetched.  If unset, 'git svn' assumes this option to
+	while `git svn` is running and take effect on the next
+	revision fetched.  If unset, `git svn` assumes this option to
 	be "true".
 
 svn.pathnameencoding::
-	This instructs git svn to recode pathnames to a given encoding.
+	This instructs `git svn` to recode pathnames to a given encoding.
 	It can be used by windows users and by those who work in non-utf8
 	locales to avoid corrupted file names with non-ASCII characters.
 	Valid encodings are the ones supported by Perl's Encode module.
 
 svn-remote.<name>.automkdirs::
-	Normally, the "git svn clone" and "git svn rebase" commands
+	Normally, the `git svn clone` and `git svn rebase` commands
 	attempt to recreate empty directories that are in the
 	Subversion repository.  If this option is set to "false", then
-	empty directories will only be created if the "git svn mkdirs"
-	command is run explicitly.  If unset, 'git svn' assumes this
+	empty directories will only be created if the `git svn mkdirs`
+	command is run explicitly.  If unset, `git svn` assumes this
 	option to be "true".
 
 Since the noMetadata, rewriteRoot, rewriteUUID, useSvnsyncProps and useSvmProps
-options all affect the metadata generated and used by 'git svn'; they
+options all affect the metadata generated and used by `git svn`; they
 *must* be set in the configuration file before any history is imported
 and these settings should never be changed once they are set.
 
@@ -895,12 +895,12 @@ Tracking and contributing to an entire Subversion-managed project
 # of dcommit/rebase/show-ignore should be the same as above.
 ------------------------------------------------------------------------
 
-The initial 'git svn clone' can be quite time-consuming
+The initial `git svn clone` can be quite time-consuming
 (especially for large Subversion repositories). If multiple
 people (or one person with multiple machines) want to use
-'git svn' to interact with the same Subversion repository, you can
-do the initial 'git svn clone' to a repository on a server and
-have each person clone that repository with 'git clone':
+`git svn` to interact with the same Subversion repository, you can
+do the initial `git svn clone` to a repository on a server and
+have each person clone that repository with `git clone`:
 
 ------------------------------------------------------------------------
 # Do the initial import on a server
@@ -926,23 +926,23 @@ have each person clone that repository with 'git clone':
 
 REBASE VS. PULL/MERGE
 ---------------------
-Prefer to use 'git svn rebase' or 'git rebase', rather than
-'git pull' or 'git merge' to synchronize unintegrated commits with a 'git svn'
+Prefer to use `git svn rebase` or `git rebase`, rather than
+`git pull` or `git merge` to synchronize unintegrated commits with a `git svn`
 branch. Doing so will keep the history of unintegrated commits linear with
 respect to the upstream SVN repository and allow the use of the preferred
-'git svn dcommit' subcommand to push unintegrated commits back into SVN.
+`git svn dcommit` subcommand to push unintegrated commits back into SVN.
 
-Originally, 'git svn' recommended that developers pulled or merged from
-the 'git svn' branch.  This was because the author favored
+Originally, `git svn` recommended that developers pulled or merged from
+the `git svn` branch.  This was because the author favored
 `git svn set-tree B` to commit a single head rather than the
 `git svn set-tree A..B` notation to commit multiple commits. Use of
-'git pull' or 'git merge' with `git svn set-tree A..B` will cause non-linear
+`git pull` or `git merge` with `git svn set-tree A..B` will cause non-linear
 history to be flattened when committing into SVN and this can lead to merge
 commits unexpectedly reversing previous commits in SVN.
 
 MERGE TRACKING
 --------------
-While 'git svn' can track
+While `git svn` can track
 copy history (including branches and tags) for repositories adopting a
 standard layout, it cannot yet represent merge history that happened
 inside git back upstream to SVN users.  Therefore it is advised that
@@ -951,25 +951,25 @@ compatibility with SVN (see the CAVEATS section below).
 
 HANDLING OF SVN BRANCHES
 ------------------------
-If 'git svn' is configured to fetch branches (and `--follow-branches`
+If `git svn` is configured to fetch branches (and `--follow-branches`
 is in effect), it sometimes creates multiple Git branches for one
 SVN branch, where the additional branches have names of the form
 `branchname@nnn` (with nnn an SVN revision number).  These additional
-branches are created if 'git svn' cannot find a parent commit for the
+branches are created if `git svn` cannot find a parent commit for the
 first commit in an SVN branch, to connect the branch to the history of
 the other branches.
 
 Normally, the first commit in an SVN branch consists
-of a copy operation. 'git svn' will read this commit to get the SVN
+of a copy operation. `git svn` will read this commit to get the SVN
 revision the branch was created from. It will then try to find the
 Git commit that corresponds to this SVN revision, and use that as the
 parent of the branch. However, it is possible that there is no suitable
 Git commit to serve as parent.  This will happen, among other reasons,
-if the SVN branch is a copy of a revision that was not fetched by 'git
-svn' (e.g. because it is an old revision that was skipped with
+if the SVN branch is a copy of a revision that was not fetched by `git
+svn` (e.g. because it is an old revision that was skipped with
 `--revision`), or if in SVN a directory was copied that is not tracked
-by 'git svn' (such as a branch that is not tracked at all, or a
-subdirectory of a tracked branch). In these cases, 'git svn' will still
+by `git svn` (such as a branch that is not tracked at all, or a
+subdirectory of a tracked branch). In these cases, `git svn` will still
 create a Git branch, but instead of using an existing Git commit as the
 parent of the branch, it will read the SVN history of the directory the
 branch was copied from and create appropriate Git commits.  This is
@@ -987,8 +987,8 @@ single SVN revision.
 
 An example: in an SVN repository with a standard
 trunk/tags/branches layout, a directory trunk/sub is created in r.100.
-In r.200, trunk/sub is branched by copying it to branches/. 'git svn
-clone -s' will then create a branch `sub`. It will also create new Git
+In r.200, trunk/sub is branched by copying it to branches/. `git svn
+clone -s` will then create a branch `sub`. It will also create new Git
 commits for r.100 through r.199 and use these as the history of branch
 `sub`. Thus there will be two Git commits for each revision from r.100
 to r.199 (one containing trunk/, one containing trunk/sub/). Finally,
@@ -999,19 +999,19 @@ CAVEATS
 -------
 
 For the sake of simplicity and interoperating with Subversion,
-it is recommended that all 'git svn' users clone, fetch and dcommit
-directly from the SVN server, and avoid all 'git clone'/'pull'/'merge'/'push'
+it is recommended that all `git svn` users clone, fetch and dcommit
+directly from the SVN server, and avoid all `git clone`/`pull`/`merge`/`push`
 operations between Git repositories and branches.  The recommended
 method of exchanging code between Git branches and users is
-'git format-patch' and 'git am', or just 'dcommit'ing to the SVN repository.
+`git format-patch` and `git am`, or just 'dcommit'ing to the SVN repository.
 
-Running 'git merge' or 'git pull' is NOT recommended on a branch you
+Running `git merge` or `git pull` is NOT recommended on a branch you
 plan to 'dcommit' from because Subversion users cannot see any
 merges you've made.  Furthermore, if you merge or pull from a Git branch
 that is a mirror of an SVN branch, 'dcommit' may commit to the wrong
 branch.
 
-If you do merge, note the following rule: 'git svn dcommit' will
+If you do merge, note the following rule: `git svn dcommit` will
 attempt to commit on top of the SVN commit named in
 ------------------------------------------------------------------------
 git log --grep=^git-svn-id: --first-parent -1
@@ -1021,12 +1021,12 @@ you want to dcommit to is the 'first' parent of the merge.  Chaos will
 ensue otherwise, especially if the first parent is an older commit on
 the same SVN branch.
 
-'git clone' does not clone branches under the refs/remotes/ hierarchy or
-any 'git svn' metadata, or config.  So repositories created and managed with
-using 'git svn' should use 'rsync' for cloning, if cloning is to be done
+`git clone` does not clone branches under the refs/remotes/ hierarchy or
+any `git svn` metadata, or config.  So repositories created and managed with
+using `git svn` should use 'rsync' for cloning, if cloning is to be done
 at all.
 
-Since 'dcommit' uses rebase internally, any Git branches you 'git push' to
+Since 'dcommit' uses rebase internally, any Git branches you `git push` to
 before 'dcommit' on will require forcing an overwrite of the existing ref
 on the remote repository.  This is generally considered bad practice,
 see the linkgit:git-push[1] documentation for details.
@@ -1038,7 +1038,7 @@ dcommit with SVN is analogous to that.
 
 When cloning an SVN repository, if none of the options for describing
 the repository layout is used (`--trunk`, `--tags`, `--branches`,
-`--stdlayout`), 'git svn clone' will create a Git repository with
+`--stdlayout`), `git svn clone` will create a Git repository with
 completely linear history, where branches and tags appear as separate
 directories in the working copy.  While this is the easiest way to get a
 copy of a complete repository, for projects with many branches it will
@@ -1051,7 +1051,7 @@ without giving any repository layout options.  If the full history with
 branches and tags is required, the options `--trunk` / `--branches` /
 `--tags` must be used.
 
-When using multiple `--branches` or `--tags`, 'git svn' does not automatically
+When using multiple `--branches` or `--tags`, `git svn` does not automatically
 handle name collisions (for example, if two branches from different paths have
 the same name, or if a branch and a tag have the same name).  In these cases,
 use 'init' to set up your Git repository then, before your first 'fetch', edit
@@ -1076,14 +1076,14 @@ for Git to detect them.
 
 In SVN, it is possible (though discouraged) to commit changes to a tag
 (because a tag is just a directory copy, thus technically the same as a
-branch). When cloning an SVN repository, 'git svn' cannot know if such a
+branch). When cloning an SVN repository, `git svn` cannot know if such a
 commit to a tag will happen in the future. Thus it acts conservatively
 and imports all SVN tags as branches, prefixing the tag name with 'tags/'.
 
 CONFIGURATION
 -------------
 
-'git svn' stores [svn-remote] configuration information in the
+`git svn` stores [svn-remote] configuration information in the
 repository $GIT_DIR/config file.  It is similar the core Git
 [remote] sections except 'fetch' keys do not accept glob
 arguments; but they are instead handled by the 'branches'
@@ -1106,7 +1106,7 @@ Keep in mind that the `*` (asterisk) wildcard of the local ref
 however the remote wildcard may be anywhere as long as it's an
 independent path component (surrounded by `/` or EOL).   This
 type of configuration is not automatically created by 'init' and
-should be manually entered with a text-editor or using 'git config'.
+should be manually entered with a text-editor or using `git config`.
 
 Also note that only one asterisk is allowed per word. For example:
 
@@ -1148,7 +1148,7 @@ location to use using the `-d` or `--destination` flag:
 $ git svn branch -d branches/server release-2-3-0
 ------------------------------------------------------------------------
 
-Note that git-svn keeps track of the highest revision in which a branch
+Note that `git-svn` keeps track of the highest revision in which a branch
 or tag has appeared. If the subset of branches or tags is changed after
 fetching, then $GIT_DIR/svn/.metadata must be manually edited to remove
 (or reset) branches-maxRev and/or tags-maxRev as appropriate.
@@ -1162,8 +1162,8 @@ $GIT_DIR/svn/\**/.rev_map.*::
 	end of every commit (see the `svn.noMetadata` section above for
 	details).
 +
-'git svn fetch' and 'git svn rebase' automatically update the rev_map
-if it is missing or not up to date.  'git svn reset' automatically
+`git svn fetch` and `git svn rebase` automatically update the rev_map
+if it is missing or not up to date.  `git svn reset` automatically
 rewinds it.
 
 SEE ALSO
diff --git a/Documentation/git-switch.txt b/Documentation/git-switch.txt
index 5737f25cf6..da16df9efa 100644
--- a/Documentation/git-switch.txt
+++ b/Documentation/git-switch.txt
@@ -8,10 +8,10 @@ git-switch - Switch branches
 SYNOPSIS
 --------
 [verse]
-'git switch' [<options>] [--no-guess] <branch>
-'git switch' [<options>] --detach [<start-point>]
-'git switch' [<options>] (-c|-C) <new-branch> [<start-point>]
-'git switch' [<options>] --orphan <new-branch>
+`git switch` [<options>] [--no-guess] <branch>
+`git switch` [<options>] --detach [<start-point>]
+`git switch` [<options>] (-c|-C) <new-branch> [<start-point>]
+`git switch` [<options>] --orphan <new-branch>
 
 DESCRIPTION
 -----------
@@ -47,7 +47,7 @@ OPTIONS
 	from some other point.)
 +
 You can use the `@{-N}` syntax to refer to the N-th last
-branch/commit switched to using "git switch" or "git checkout"
+branch/commit switched to using `git switch` or `git checkout`
 operation. You may also specify `-` which is synonymous to `@{-1}`.
 This is often used to switch quickly between two branches, or to undo
 a branch switch by mistake.
diff --git a/Documentation/git-symbolic-ref.txt b/Documentation/git-symbolic-ref.txt
index 2cbec2d033..0c19b1e70e 100644
--- a/Documentation/git-symbolic-ref.txt
+++ b/Documentation/git-symbolic-ref.txt
@@ -8,9 +8,9 @@ git-symbolic-ref - Read, modify and delete symbolic refs
 SYNOPSIS
 --------
 [verse]
-'git symbolic-ref' [-m <reason>] <name> <ref>
-'git symbolic-ref' [-q] [--short] <name>
-'git symbolic-ref' --delete [-q] <name>
+`git symbolic-ref` [-m <reason>] <name> <ref>
+`git symbolic-ref` [-q] [--short] <name>
+`git symbolic-ref` --delete [-q] <name>
 
 DESCRIPTION
 -----------
@@ -60,7 +60,7 @@ But symbolic links are not entirely portable, so they are now
 deprecated and symbolic refs (as described above) are used by
 default.
 
-'git symbolic-ref' will exit with status 0 if the contents of the
+`git symbolic-ref` will exit with status 0 if the contents of the
 symbolic ref were printed correctly, with status 1 if the requested
 name is not a symbolic ref, or 128 if another error occurs.
 
diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
index 13a0d2abbb..6de16cec54 100644
--- a/Documentation/git-tag.txt
+++ b/Documentation/git-tag.txt
@@ -9,14 +9,14 @@ git-tag - Create, list, delete or verify a tag object signed with GPG
 SYNOPSIS
 --------
 [verse]
-'git tag' [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
+`git tag` [-a | -s | -u <keyid>] [-f] [-m <msg> | -F <file>] [-e]
 	<tagname> [<commit> | <object>]
-'git tag' -d <tagname>...
-'git tag' [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
+`git tag` -d <tagname>...
+`git tag` [-n[<num>]] -l [--contains <commit>] [--no-contains <commit>]
 	[--points-at <object>] [--column[=<options>] | --no-column]
 	[--create-reflog] [--sort=<key>] [--format=<format>]
 	[--merged <commit>] [--no-merged <commit>] [<pattern>...]
-'git tag' -v [--format=<format>] <tagname>...
+`git tag` -v [--format=<format>] <tagname>...
 
 DESCRIPTION
 -----------
@@ -50,7 +50,7 @@ tagging message, and an optional GnuPG signature. Whereas a
 object).
 
 Annotated tags are meant for release while lightweight tags are meant
-for private or temporary object labels. For this reason, some git
+for private or temporary object labels. For this reason, some `git`
 commands for naming objects (like `git describe`) will ignore
 lightweight tags by default.
 
@@ -101,7 +101,7 @@ If the tag is not annotated, the commit message is displayed instead.
 	List tags. With optional `<pattern>...`, e.g. `git tag --list
 	'v-*'`, list only the tags that match the pattern(s).
 +
-Running "git tag" without arguments also lists all tags. The pattern
+Running `git tag` without arguments also lists all tags. The pattern
 is a shell wildcard (i.e., matched using fnmatch(3)). Multiple
 patterns may be given; if any of them matches, the tag is shown.
 +
@@ -213,7 +213,7 @@ This option is only applicable when listing tags without annotation lines.
 
 CONFIGURATION
 -------------
-By default, 'git tag' in sign-with-default mode (-s) will use your
+By default, `git tag` in sign-with-default mode (-s) will use your
 committer identity (of the form `Your Name <your@email.address>`) to
 find a key.  If you want to use a different default key, you can specify
 it in the repository configuration as follows:
@@ -252,12 +252,12 @@ the old tag. In that case you can do one of two things:
 
 . The insane thing.
   You really want to call the new version "X" too, 'even though'
-  others have already seen the old one. So just use 'git tag -f'
+  others have already seen the old one. So just use `git tag -f`
   again, as if you hadn't already published the old one.
 
 However, Git does *not* (and it should not) change tags behind
 users back. So if somebody already got the old tag, doing a
-'git pull' on your tree shouldn't just make them overwrite the old
+`git pull` on your tree shouldn't just make them overwrite the old
 one.
 
 If somebody got a release tag from you, you cannot just change
@@ -309,7 +309,7 @@ private anchor point tags from the other person.
 
 Often, "please pull" messages on the mailing list just provide
 two pieces of information: a repo URL and a branch name; this
-is designed to be easily cut&pasted at the end of a 'git fetch'
+is designed to be easily cut&pasted at the end of a `git fetch`
 command line:
 
 ------------
@@ -363,7 +363,7 @@ If you have imported some changes from another VCS and would like
 to add tags for major releases of your work, it is useful to be able
 to specify the date to embed inside of the tag object; such data in
 the tag object affects, for example, the ordering of tags in the
-gitweb interface.
+`gitweb` interface.
 
 To set the date used in future tag objects, set the environment
 variable GIT_COMMITTER_DATE (see the later discussion of possible
diff --git a/Documentation/git-unpack-file.txt b/Documentation/git-unpack-file.txt
index e9f148a00d..85c5f120e5 100644
--- a/Documentation/git-unpack-file.txt
+++ b/Documentation/git-unpack-file.txt
@@ -10,7 +10,7 @@ git-unpack-file - Creates a temporary file with a blob's contents
 SYNOPSIS
 --------
 [verse]
-'git unpack-file' <blob>
+`git unpack-file` <blob>
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-unpack-objects.txt b/Documentation/git-unpack-objects.txt
index b3de50d710..ad10299337 100644
--- a/Documentation/git-unpack-objects.txt
+++ b/Documentation/git-unpack-objects.txt
@@ -9,7 +9,7 @@ git-unpack-objects - Unpack objects from a packed archive
 SYNOPSIS
 --------
 [verse]
-'git unpack-objects' [-n] [-q] [-r] [--strict]
+`git unpack-objects` [-n] [-q] [-r] [--strict]
 
 
 DESCRIPTION
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 4eae32e711..ec501232ad 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -9,7 +9,7 @@ git-update-index - Register file contents in the working tree to the index
 SYNOPSIS
 --------
 [verse]
-'git update-index'
+`git update-index`
 	     [--add] [--remove | --force-remove] [--replace]
 	     [--refresh] [-q] [--unmerged] [--ignore-missing]
 	     [(--cacheinfo <mode>,<object>,<file>)...]
@@ -36,7 +36,7 @@ any 'unmerged' or 'needs updating' state is cleared.
 See also linkgit:git-add[1] for a more user-friendly way to do some of
 the most common operations on the index.
 
-The way 'git update-index' handles files it is told about can be modified
+The way `git update-index` handles files it is told about can be modified
 using the various options:
 
 OPTIONS
@@ -58,7 +58,7 @@ OPTIONS
 -q::
         Quiet.  If `--refresh` finds that the index needs an update, the
         default behavior is to error out.  This option makes
-	'git update-index' continue anyway.
+	`git update-index` continue anyway.
 
 --ignore-submodules::
 	Do not try to update submodules.  This option is only respected
@@ -66,7 +66,7 @@ OPTIONS
 
 --unmerged::
         If `--refresh` finds unmerged changes in the index, the default
-	behavior is to error out.  This option makes 'git update-index'
+	behavior is to error out.  This option makes `git update-index`
         continue anyway.
 
 --ignore-missing::
@@ -126,7 +126,7 @@ you will need to handle the situation manually.
 
 -g::
 --again::
-	Runs 'git update-index' itself on the paths whose index
+	Runs `git update-index` itself on the paths whose index
 	entries are different from those from the `HEAD` commit.
 
 --unresolve::
@@ -144,7 +144,7 @@ you will need to handle the situation manually.
 
 --replace::
 	By default, when a file `path` exists in the index,
-	'git update-index' refuses an attempt to add `path/file`.
+	`git update-index` refuses an attempt to add `path/file`.
 	Similarly if a file `path/file` exists, a file `path`
 	cannot be added.  With `--replace` flag, existing entries
 	that conflict with the entry being added are
@@ -241,7 +241,7 @@ up to date for mode/content changes. But what it *does* do is to
 can refresh the index for a file that hasn't been changed but where
 the stat entry is out of date.
 
-For example, you'd want to do this after doing a 'git read-tree', to link
+For example, you'd want to do this after doing a `git read-tree`, to link
 up the stat index details with the proper files.
 
 USING --CACHEINFO OR --INFO-ONLY
@@ -280,7 +280,7 @@ This format is to stuff `git ls-tree` output into the index.
     . mode         SP sha1 SP stage TAB path
 +
 This format is to put higher order stages into the
-index file and matches 'git ls-files --stage' output.
+index file and matches `git ls-files --stage` output.
 
     . mode         SP sha1          TAB path
 +
@@ -344,8 +344,8 @@ have the "assume unchanged" bit set, use `git ls-files -v`
 The command looks at `core.ignorestat` configuration variable.  When
 this is true, paths updated with `git update-index paths...` and
 paths updated with other Git commands that update both index and
-working tree (e.g. 'git apply --index', 'git checkout-index -u',
-and 'git read-tree -u') are automatically marked as "assume
+working tree (e.g. `git apply --index`, `git checkout-index -u`,
+and `git read-tree -u`) are automatically marked as "assume
 unchanged".  Note that "assume unchanged" bit is *not* set if
 `git update-index --refresh` finds the working tree file matches
 the index (use `git update-index --really-refresh` if you want
@@ -468,8 +468,8 @@ the index.
 
 Before 2.17, the untracked cache had a bug where replacing a directory
 with a symlink to another directory could cause it to incorrectly show
-files tracked by git as untracked. See the "status: add a failing test
-showing a core.untrackedCache bug" commit to git.git. A workaround for
+files tracked by `git` as untracked. See the "status: add a failing test
+showing a `core.untrackedCache` bug" commit to git.git. A workaround for
 that is (and this might work for other undiscovered bugs in the
 future):
 
@@ -480,27 +480,27 @@ $ git -c core.untrackedCache=false status
 This bug has also been shown to affect non-symlink cases of replacing
 a directory with a file when it comes to the internal structures of
 the untracked cache, but no case has been reported where this resulted in
-wrong "git status" output.
+wrong `git status` output.
 
-There are also cases where existing indexes written by git versions
+There are also cases where existing indexes written by `git` versions
 before 2.17 will reference directories that don't exist anymore,
 potentially causing many "could not open directory" warnings to be
-printed on "git status". These are new warnings for existing issues
+printed on `git status`. These are new warnings for existing issues
 that were previously silently discarded.
 
-As with the bug described above the solution is to one-off do a "git
-status" run with `core.untrackedCache=false` to flush out the leftover
+As with the bug described above the solution is to one-off do a `git
+status` run with `core.untrackedCache=false` to flush out the leftover
 bad data.
 
 FILE SYSTEM MONITOR
 -------------------
 
-This feature is intended to speed up git operations for repos that have
+This feature is intended to speed up `git` operations for repos that have
 large working directories.
 
-It enables git to work together with a file system monitor (see the
+It enables `git` to work together with a file system monitor (see the
 "fsmonitor-watchman" section of linkgit:githooks[5]) that can
-inform it as to what files have been modified. This enables git to avoid
+inform it as to what files have been modified. This enables `git` to avoid
 having to lstat() every file to find modified files.
 
 When used in conjunction with the untracked cache, it can further improve
@@ -529,7 +529,7 @@ unreliable, this should be set to 'false' (see linkgit:git-config[1]).
 This causes the command to ignore differences in file modes recorded
 in the index and the file mode on the filesystem if they differ only on
 executable bit.   On such an unfortunate filesystem, you may
-need to use 'git update-index --chmod='.
+need to use `git update-index --chmod=`.
 
 Quite similarly, if `core.symlinks` configuration variable is set
 to 'false' (see linkgit:git-config[1]), symbolic links are checked out
diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
index f8aeea4cb4..3ad7771676 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
 SYNOPSIS
 --------
 [verse]
-'git update-ref' [-m <reason>] [--no-deref] (-d <ref> [<oldvalue>] | [--create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
+`git update-ref` [-m <reason>] [--no-deref] (-d <ref> [<oldvalue>] | [--create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-update-server-info.txt b/Documentation/git-update-server-info.txt
index 969bb2e15f..8dbb1a6172 100644
--- a/Documentation/git-update-server-info.txt
+++ b/Documentation/git-update-server-info.txt
@@ -9,7 +9,7 @@ git-update-server-info - Update auxiliary info file to help dumb servers
 SYNOPSIS
 --------
 [verse]
-'git update-server-info'
+`git update-server-info`
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-upload-archive.txt b/Documentation/git-upload-archive.txt
index fba0f1c1b2..36f7901adb 100644
--- a/Documentation/git-upload-archive.txt
+++ b/Documentation/git-upload-archive.txt
@@ -9,15 +9,15 @@ git-upload-archive - Send archive back to git-archive
 SYNOPSIS
 --------
 [verse]
-'git upload-archive' <directory>
+`git upload-archive` <directory>
 
 DESCRIPTION
 -----------
-Invoked by 'git archive --remote' and sends a generated archive to the
+Invoked by `git archive --remote` and sends a generated archive to the
 other end over the Git protocol.
 
 This command is usually not invoked directly by the end user.  The UI
-for the protocol is on the 'git archive' side, and the program pair
+for the protocol is on the `git archive` side, and the program pair
 is meant to be used to get an archive from a remote repository.
 
 SECURITY
@@ -43,7 +43,7 @@ but easier-to-check set of rules:
 
 Note that rule 3 disallows many cases that do not have any privacy
 implications. These rules are subject to change in future versions of
-git, and the server accessed by `git archive --remote` may or may not
+`git`, and the server accessed by `git archive --remote` may or may not
 follow these exact rules.
 
 If the config option `uploadArchive.allowUnreachable` is true, these
diff --git a/Documentation/git-upload-pack.txt b/Documentation/git-upload-pack.txt
index 9822c1eb1a..f4b9dab02e 100644
--- a/Documentation/git-upload-pack.txt
+++ b/Documentation/git-upload-pack.txt
@@ -9,18 +9,18 @@ git-upload-pack - Send objects packed back to git-fetch-pack
 SYNOPSIS
 --------
 [verse]
-'git-upload-pack' [--[no-]strict] [--timeout=<n>] [--stateless-rpc]
+`git-upload-pack` [--[no-]strict] [--timeout=<n>] [--stateless-rpc]
 		  [--advertise-refs] <directory>
 
 DESCRIPTION
 -----------
-Invoked by 'git fetch-pack', learns what
+Invoked by `git fetch-pack`, learns what
 objects the other side is missing, and sends them after packing.
 
 This command is usually not invoked directly by the end user.
-The UI for the protocol is on the 'git fetch-pack' side, and the
+The UI for the protocol is on the `git fetch-pack` side, and the
 program pair is meant to be used to pull updates from a remote
-repository.  For push operations, see 'git send-pack'.
+repository.  For push operations, see `git send-pack`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 6072f936ab..3e356129cd 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -9,7 +9,7 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [verse]
-'git var' ( -l | <variable> )
+`git var` ( -l | <variable> )
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-verify-commit.txt b/Documentation/git-verify-commit.txt
index 92097f6673..87ed1cae5d 100644
--- a/Documentation/git-verify-commit.txt
+++ b/Documentation/git-verify-commit.txt
@@ -8,11 +8,11 @@ git-verify-commit - Check the GPG signature of commits
 SYNOPSIS
 --------
 [verse]
-'git verify-commit' <commit>...
+`git verify-commit` <commit>...
 
 DESCRIPTION
 -----------
-Validates the GPG signature created by 'git commit -S'.
+Validates the GPG signature created by `git commit -S`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index e1e537fcfb..8163a86940 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -9,13 +9,13 @@ git-verify-pack - Validate packed Git archive files
 SYNOPSIS
 --------
 [verse]
-'git verify-pack' [-v|--verbose] [-s|--stat-only] [--] <pack>.idx ...
+`git verify-pack` [-v|--verbose] [-s|--stat-only] [--] <pack>.idx ...
 
 
 DESCRIPTION
 -----------
 Reads given idx file for packed Git archive created with the
-'git pack-objects' command and verifies idx file and the
+`git pack-objects` command and verifies idx file and the
 corresponding pack file.
 
 OPTIONS
diff --git a/Documentation/git-verify-tag.txt b/Documentation/git-verify-tag.txt
index 0b8075dad9..343e209fc5 100644
--- a/Documentation/git-verify-tag.txt
+++ b/Documentation/git-verify-tag.txt
@@ -8,11 +8,11 @@ git-verify-tag - Check the GPG signature of tags
 SYNOPSIS
 --------
 [verse]
-'git verify-tag' [--format=<format>] <tag>...
+`git verify-tag` [--format=<format>] <tag>...
 
 DESCRIPTION
 -----------
-Validates the gpg signature created by 'git tag'.
+Validates the gpg signature created by `git tag`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-web--browse.txt b/Documentation/git-web--browse.txt
index 6fbe8d5583..0e788b1208 100644
--- a/Documentation/git-web--browse.txt
+++ b/Documentation/git-web--browse.txt
@@ -8,7 +8,7 @@ git-web--browse - Git helper script to launch a web browser
 SYNOPSIS
 --------
 [verse]
-'git web{litdd}browse' [<options>] <url|file>...
+`git web--browse` [<options>] <url|file>...
 
 DESCRIPTION
 -----------
@@ -71,7 +71,7 @@ browser.<tool>.path
 You can explicitly provide a full path to your preferred browser by
 setting the configuration variable `browser.<tool>.path`. For example,
 you can configure the absolute path to firefox by setting
-`browser.firefox.path`. Otherwise, 'git web{litdd}browse' assumes the tool
+`browser.firefox.path`. Otherwise, `git web--browse` assumes the tool
 is available in PATH.
 
 browser.<tool>.cmd
@@ -80,7 +80,7 @@ browser.<tool>.cmd
 When the browser, specified by options or configuration variables, is
 not among the supported ones, then the corresponding
 `browser.<tool>.cmd` configuration variable will be looked up. If this
-variable exists then 'git web{litdd}browse' will treat the specified tool
+variable exists then `git web--browse` will treat the specified tool
 as a custom command and will use a shell eval to run the command with
 the URLs passed as arguments.
 
@@ -106,7 +106,7 @@ the following:
 		cmd = A_PATH_TO/konqueror
 ------------------------------------------------
 
-Note about git-config --global
+Note about `git-config --global`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Note that these configuration variables should probably be set using
diff --git a/Documentation/git-whatchanged.txt b/Documentation/git-whatchanged.txt
index 798a43965b..5557c288f4 100644
--- a/Documentation/git-whatchanged.txt
+++ b/Documentation/git-whatchanged.txt
@@ -9,7 +9,7 @@ git-whatchanged - Show logs with difference each commit introduces
 SYNOPSIS
 --------
 [verse]
-'git whatchanged' <option>...
+`git whatchanged` <option>...
 
 DESCRIPTION
 -----------
@@ -34,9 +34,9 @@ Examples
 
 `git whatchanged --since="2 weeks ago" -- gitk`::
 
-	Show the changes during the last two weeks to the file 'gitk'.
+	Show the changes during the last two weeks to the file `gitk`.
 	The `--` is necessary to avoid confusion with the *branch* named
-	'gitk'
+	`gitk`
 
 GIT
 ---
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index 35bb1bb120..95fa3b673c 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -9,21 +9,21 @@ git-worktree - Manage multiple working trees
 SYNOPSIS
 --------
 [verse]
-'git worktree add' [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
-'git worktree list' [--porcelain]
-'git worktree lock' [--reason <string>] <worktree>
-'git worktree move' <worktree> <new-path>
-'git worktree prune' [-n] [-v] [--expire <expire>]
-'git worktree remove' [-f] <worktree>
-'git worktree repair' [<path>...]
-'git worktree unlock' <worktree>
+`git worktree add` [-f] [--detach] [--checkout] [--lock] [-b <new-branch>] <path> [<commit-ish>]
+`git worktree list` [--porcelain]
+`git worktree lock` [--reason <string>] <worktree>
+`git worktree move` <worktree> <new-path>
+`git worktree prune` [-n] [-v] [--expire <expire>]
+`git worktree remove` [-f] <worktree>
+`git worktree repair` [<path>...]
+`git worktree unlock` <worktree>
 
 DESCRIPTION
 -----------
 
 Manage multiple working trees attached to the same repository.
 
-A git repository can support multiple working trees, allowing you to check
+A `git` repository can support multiple working trees, allowing you to check
 out more than one branch at a time.  With `git worktree add` a new working
 tree is associated with the repository.  This new working tree is called a
 "linked working tree" as opposed to the "main working tree" prepared by
diff --git a/Documentation/git-write-tree.txt b/Documentation/git-write-tree.txt
index f22041a9dc..295a8715cb 100644
--- a/Documentation/git-write-tree.txt
+++ b/Documentation/git-write-tree.txt
@@ -9,7 +9,7 @@ git-write-tree - Create a tree object from the current index
 SYNOPSIS
 --------
 [verse]
-'git write-tree' [--missing-ok] [--prefix=<prefix>/]
+`git write-tree` [--missing-ok] [--prefix=<prefix>/]
 
 DESCRIPTION
 -----------
@@ -18,17 +18,17 @@ tree object is printed to standard output.
 
 The index must be in a fully merged state.
 
-Conceptually, 'git write-tree' sync()s the current index contents
+Conceptually, `git write-tree` sync()s the current index contents
 into a set of tree files.
 In order to have that match what is actually in your directory right
-now, you need to have done a 'git update-index' phase before you did the
-'git write-tree'.
+now, you need to have done a `git update-index` phase before you did the
+`git write-tree`.
 
 
 OPTIONS
 -------
 --missing-ok::
-	Normally 'git write-tree' ensures that the objects referenced by the
+	Normally `git write-tree` ensures that the objects referenced by the
 	directory exist in the object database.  This option disables this
 	check.
 
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6aafa3a15c..6486abdd4d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -9,7 +9,7 @@ git - the stupid content tracker
 SYNOPSIS
 --------
 [verse]
-'git' [--version] [--help] [-C <path>] [-c <name>=<value>]
+`git` [--version] [--help] [-C <path>] [-c <name>=<value>]
     [--exec-path[=<path>]] [--html-path] [--man-path] [--info-path]
     [-p|--paginate|-P|--no-pager] [--no-replace-objects] [--bare]
     [--git-dir=<path>] [--work-tree=<path>] [--namespace=<name>]
@@ -29,7 +29,7 @@ in-depth introduction.
 
 After you mastered the basic concepts, you can come back to this
 page to learn what commands Git offers.  You can learn more about
-individual Git commands with "git help command".  linkgit:gitcli[7]
+individual Git commands with `git help command`.  linkgit:gitcli[7]
 manual page gives you an overview of the command-line command syntax.
 
 A formatted and hyperlinked copy of the latest Git documentation
@@ -40,7 +40,7 @@ or https://git-scm.com/docs.
 OPTIONS
 -------
 --version::
-	Prints the Git suite version that the 'git' program came from.
+	Prints the Git suite version that the `git` program came from.
 
 --help::
 	Prints the synopsis and a list of the most commonly used
@@ -54,7 +54,7 @@ because `git --help ...` is converted internally into `git
 help ...`.
 
 -C <path>::
-	Run as if git was started in '<path>' instead of the current working
+	Run as if `git` was started in '<path>' instead of the current working
 	directory.  When multiple `-C` options are given, each subsequent
 	non-absolute `-C <path>` is interpreted relative to the preceding `-C
 	<path>`.  If '<path>' is present but empty, e.g. `-C ""`, then the
@@ -72,7 +72,7 @@ example the following invocations are equivalent:
 	Pass a configuration parameter to the command. The value
 	given will override values from configuration files.
 	The <name> is expected in the same format as listed by
-	'git config' (subkeys separated by dots).
+	`git config` (subkeys separated by dots).
 +
 Note that omitting the `=` in `git -c foo.bar ...` is allowed and sets
 `foo.bar` to the boolean true value (just like `[foo]bar` would in a
@@ -91,7 +91,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	to avoid ambiguity with `<name>` containing one.
 +
 This is useful for cases where you want to pass transitory
-configuration options to git, but are doing so on OS's where
+configuration options to `git`, but are doing so on OS's where
 other processes might be able to read your cmdline
 (e.g. `/proc/self/cmdline`), but not your environ
 (e.g. `/proc/self/environ`). That behavior is the default on
@@ -105,7 +105,7 @@ sensitive information can be part of the key.
 --exec-path[=<path>]::
 	Path to wherever your core Git programs are installed.
 	This can also be controlled by setting the GIT_EXEC_PATH
-	environment variable. If no path is given, 'git' will print
+	environment variable. If no path is given, `git` will print
 	the current setting and then exit.
 
 --html-path::
@@ -147,7 +147,7 @@ should tell Git where the top-level of the working tree is,
 with the `--work-tree=<path>` option (or `GIT_WORK_TREE`
 environment variable)
 +
-If you just want to run git as if it was started in `<path>` then use
+If you just want to run `git` as if it was started in `<path>` then use
 `git -C <path>`.
 
 --work-tree=<path>::
@@ -207,7 +207,7 @@ If you just want to run git as if it was started in `<path>` then use
 	option and may change or be removed in the future. Supported
 	groups are: builtins, parseopt (builtin commands that use
 	parse-options), main (all commands in libexec directory),
-	others (all other commands in `$PATH` that have git- prefix),
+	others (all other commands in `$PATH` that have `git`- prefix),
 	list-<category> (see categories in command-list.txt),
 	nohelpers (exclude helper commands), alias and config
 	(retrieve command list from config variable `completion.commands`)
@@ -588,7 +588,7 @@ where:
 	<old|new>-mode:: are the octal representation of the file modes.
 +
 The file parameters can point at the user's working file
-(e.g. `new-file` in "git-diff-files"), `/dev/null` (e.g. `old-file`
+(e.g. `new-file` in `git-diff-files`), `/dev/null` (e.g. `old-file`
 when a new file is added), or a temporary file (e.g. `old-file` in the
 index).  `GIT_EXTERNAL_DIFF` should not worry about unlinking the
 temporary file --- it is removed when `GIT_EXTERNAL_DIFF` exits.
@@ -636,8 +636,8 @@ other
 
 `GIT_SSH`::
 `GIT_SSH_COMMAND`::
-	If either of these environment variables is set then 'git fetch'
-	and 'git push' will use the specified command instead of 'ssh'
+	If either of these environment variables is set then `git fetch`
+	and `git push` will use the specified command instead of 'ssh'
 	when they need to connect to a remote system.
 	The command-line parameters passed to the configured command are
 	determined by the ssh variant.  See `ssh.variant` option in
@@ -667,7 +667,7 @@ for further details.
 	option in linkgit:git-config[1].
 
 `GIT_TERMINAL_PROMPT`::
-	If this environment variable is set to `0`, git will not prompt
+	If this environment variable is set to `0`, `git` will not prompt
 	on the terminal (e.g., when asking for HTTP authentication).
 
 `GIT_CONFIG_NOSYSTEM`::
@@ -680,8 +680,8 @@ for further details.
 
 `GIT_FLUSH`::
 	If this environment variable is set to "1", then commands such
-	as 'git blame' (in incremental mode), 'git rev-list', 'git log',
-	'git check-attr' and 'git check-ignore' will
+	as `git blame` (in incremental mode), `git rev-list`, `git log`,
+	`git check-attr` and `git check-ignore` will
 	force a flush of the output stream after each record have been
 	flushed. If this
 	variable is set to "0", the output of these commands will be done
@@ -760,7 +760,7 @@ of clones and fetches.
 
 `GIT_TRACE_CURL`::
 	Enables a curl full trace dump of all incoming and outgoing data,
-	including descriptive information, of the git transport protocol.
+	including descriptive information, of the `git` transport protocol.
 	This is similar to doing curl `--trace-ascii` on the command line.
 	See `GIT_TRACE` for available trace output options.
 
@@ -855,7 +855,7 @@ for full details.
 `GIT_REF_PARANOIA`::
 	If set to `1`, include broken or badly named refs when iterating
 	over lists of refs. In a normal, non-corrupted repository, this
-	does nothing. However, enabling it may help git to detect and
+	does nothing. However, enabling it may help `git` to detect and
 	abort some operations in the presence of broken refs. Git sets
 	this variable automatically when performing destructive
 	operations like linkgit:git-prune[1]. You should not need to set
@@ -876,7 +876,7 @@ for full details.
 	Set to 0 to prevent protocols used by fetch/push/clone which are
 	configured to the `user` state.  This is useful to restrict recursive
 	submodule initialization from an untrusted repository or for programs
-	which feed potentially-untrusted URLS to git commands.  See
+	which feed potentially-untrusted URLS to `git` commands.  See
 	linkgit:git-config[1] for more details.
 
 `GIT_PROTOCOL`::
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index f77d8487bd..2ce7365ec6 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -112,10 +112,10 @@ Checking-out and checking-in
 
 These attributes affect how the contents stored in the
 repository are copied to the working tree files when commands
-such as 'git switch', 'git checkout'  and 'git merge' run.
+such as `git switch`, `git checkout`  and `git merge` run.
 They also affect how
 Git stores the contents you prepare in the working tree in the
-repository upon 'git add' and 'git commit'.
+repository upon `git add` and `git commit`.
 
 `text`
 ^^^^^^
@@ -247,8 +247,8 @@ $ git status        # Show files that will be normalized
 $ git commit -m "Introduce end-of-line normalization"
 -------------------------------------------------
 
-If any files that should not be normalized show up in 'git status',
-unset their `text` attribute before running 'git add -u'.
+If any files that should not be normalized show up in `git status`,
+unset their `text` attribute before running `git add -u`.
 
 ------------------------
 manual.pdf	-text
@@ -269,16 +269,16 @@ an irreversible conversion.  The safety triggers to prevent such
 a conversion done to the files in the work tree, but there are a
 few exceptions.  Even though...
 
-- 'git add' itself does not touch the files in the work tree, the
+- `git add` itself does not touch the files in the work tree, the
   next checkout would, so the safety triggers;
 
-- 'git apply' to update a text file with a patch does touch the files
+- `git apply` to update a text file with a patch does touch the files
   in the work tree, but the operation is about text files and CRLF
   conversion is about fixing the line ending inconsistencies, so the
   safety does not trigger;
 
-- 'git diff' itself does not touch the files in the work tree, it is
-  often run to inspect the changes you intend to next 'git add'.  To
+- `git diff` itself does not touch the files in the work tree, it is
+  often run to inspect the changes you intend to next `git add`.  To
   catch potential problems early, safety triggers.
 
 
@@ -288,7 +288,7 @@ few exceptions.  Even though...
 Git recognizes files encoded in ASCII or one of its supersets (e.g.
 UTF-8, ISO-8859-1, ...) as text files. Files encoded in certain other
 encodings (e.g. UTF-16) are interpreted as binary and consequently
-built-in Git text processing tools (e.g. 'git diff') as well as most Git
+built-in Git text processing tools (e.g. `git diff`) as well as most Git
 web front ends do not visualize the contents of these files by default.
 
 In these cases you can tell Git the encoding of a file in the working
@@ -331,7 +331,7 @@ That operation will fail and cause an error.
   default.
 
 - Reencoding content requires resources that might slow down certain
-  Git operations (e.g 'git checkout' or 'git add').
+  Git operations (e.g `git checkout` or `git add`).
 
 Use the `working-tree-encoding` attribute only if you cannot store a file
 in UTF-8 encoding and if you want Git to be able to process the content
@@ -497,7 +497,7 @@ command. This is achieved by using the long-running process protocol
 
 When Git encounters the first file that needs to be cleaned or smudged,
 it starts the filter and performs the handshake. In the handshake, the
-welcome message sent by Git is "git-filter-client", only version 2 is
+welcome message sent by Git is `git-filter-client`, only version 2 is
 supported, and the supported capabilities are "clean", "smudge", and
 "delay".
 
diff --git a/Documentation/gitcore-tutorial.txt b/Documentation/gitcore-tutorial.txt
index d1d81cbe15..aa11b4562b 100644
--- a/Documentation/gitcore-tutorial.txt
+++ b/Documentation/gitcore-tutorial.txt
@@ -50,9 +50,9 @@ one for a totally new project, or an existing working tree that you want
 to import into Git.
 
 For our first example, we're going to start a totally new repository from
-scratch, with no pre-existing files, and we'll call it 'git-tutorial'.
+scratch, with no pre-existing files, and we'll call it `git-tutorial`.
 To start up, create a subdirectory for it, change into that
-subdirectory, and initialize the Git infrastructure with 'git init':
+subdirectory, and initialize the Git infrastructure with `git init`:
 
 ------------------------------------------------
 $ mkdir git-tutorial
@@ -147,7 +147,7 @@ but to actually check in your hard work, you will have to go through two steps:
  - commit that index file as an object.
 
 The first step is trivial: when you want to tell Git about any changes
-to your working tree, you use the 'git update-index' program. That
+to your working tree, you use the `git update-index` program. That
 program normally just takes a list of filenames you want to update, but
 to avoid trivial mistakes, it refuses to add new entries to the index
 (or remove existing ones) unless you explicitly tell it that you're
@@ -181,14 +181,14 @@ and see two files:
 which correspond with the objects with names of `557db...` and
 `f24c7...` respectively.
 
-If you want to, you can use 'git cat-file' to look at those objects, but
+If you want to, you can use `git cat-file` to look at those objects, but
 you'll have to use the object name, not the filename of the object:
 
 ----------------
 $ git cat-file -t 557db03de997c86a4a028e1ebd3a1ceb225be238
 ----------------
 
-where the `-t` tells 'git cat-file' to tell you what the "type" of the
+where the `-t` tells `git cat-file` to tell you what the "type" of the
 object is. Git will tell you that you have a "blob" object (i.e., just a
 regular file), and you can see the contents with
 
@@ -213,7 +213,7 @@ hexadecimal digits in most places.
 Anyway, as we mentioned previously, you normally never actually take a
 look at the objects themselves, and typing long 40-character hex
 names is not something you'd normally want to do. The above digression
-was just to show that 'git update-index' did something magical, and
+was just to show that `git update-index` did something magical, and
 actually saved away the contents of your files into the Git object
 database.
 
@@ -236,7 +236,7 @@ $ echo "It's a new day for git" >>hello
 
 and you can now, since you told Git about the previous state of `hello`, ask
 Git what has changed in the tree compared to your old index, using the
-'git diff-files' command:
+`git diff-files` command:
 
 ------------
 $ git diff-files
@@ -247,7 +247,7 @@ version of a 'diff', but that internal version really just tells you
 that it has noticed that "hello" has been modified, and that the old object
 contents it had have been replaced with something else.
 
-To make it readable, we can tell 'git diff-files' to output the
+To make it readable, we can tell `git diff-files` to output the
 differences as a patch, using the `-p` flag:
 
 ------------
@@ -263,7 +263,7 @@ index 557db03..263414f 100644
 
 i.e. the diff of the change we caused by adding another line to `hello`.
 
-In other words, 'git diff-files' always shows us the difference between
+In other words, `git diff-files` always shows us the difference between
 what is recorded in the index, and what is currently in the working
 tree. That's very useful.
 
@@ -291,7 +291,7 @@ that in two phases: creating a 'tree' object, and committing that 'tree'
 object as a 'commit' object together with an explanation of what the
 tree was all about, along with information of how we came to that state.
 
-Creating a tree object is trivial, and is done with 'git write-tree'.
+Creating a tree object is trivial, and is done with `git write-tree`.
 There are no options or other input: `git write-tree` will take the
 current index state, and write an object that describes that whole
 index. In other words, we're now tying together all the different
@@ -315,23 +315,23 @@ is not a "blob" object, but a "tree" object (you can also use
 `git cat-file` to actually output the raw object contents, but you'll see
 mainly a binary mess, so that's less interesting).
 
-However -- normally you'd never use 'git write-tree' on its own, because
+However -- normally you'd never use `git write-tree` on its own, because
 normally you always commit a tree into a commit object using the
-'git commit-tree' command. In fact, it's easier to not actually use
-'git write-tree' on its own at all, but to just pass its result in as an
-argument to 'git commit-tree'.
+`git commit-tree` command. In fact, it's easier to not actually use
+`git write-tree` on its own at all, but to just pass its result in as an
+argument to `git commit-tree`.
 
-'git commit-tree' normally takes several arguments -- it wants to know
+`git commit-tree` normally takes several arguments -- it wants to know
 what the 'parent' of a commit was, but since this is the first commit
 ever in this new repository, and it has no parents, we only need to pass in
-the object name of the tree. However, 'git commit-tree' also wants to get a
+the object name of the tree. However, `git commit-tree` also wants to get a
 commit message on its standard input, and it will write out the resulting
 object name for the commit to its standard output.
 
 And this is where we create the `.git/refs/heads/master` file
 which is pointed at by `HEAD`. This file is supposed to contain
 the reference to the top-of-tree of the `master` branch, and since
-that's exactly what 'git commit-tree' spits out, we can do this
+that's exactly what `git commit-tree` spits out, we can do this
 all with a sequence of simple shell commands:
 
 ------------------------------------------------
@@ -353,11 +353,11 @@ instead, and it would have done the above magic scripting for you.
 Making a change
 ---------------
 
-Remember how we did the 'git update-index' on file `hello` and then we
+Remember how we did the `git update-index` on file `hello` and then we
 changed `hello` afterward, and could compare the new state of `hello` with the
 state we saved in the index file?
 
-Further, remember how I said that 'git write-tree' writes the contents
+Further, remember how I said that `git write-tree` writes the contents
 of the *index* file to the tree, and thus what we just committed was in
 fact the *original* contents of the file `hello`, not the new ones. We did
 that on purpose, to show the difference between the index state, and the
@@ -368,12 +368,12 @@ As before, if we do `git diff-files -p` in our git-tutorial project,
 we'll still see the same difference we saw last time: the index file
 hasn't changed by the act of committing anything. However, now that we
 have committed something, we can also learn to use a new command:
-'git diff-index'.
+`git diff-index`.
 
-Unlike 'git diff-files', which showed the difference between the index
-file and the working tree, 'git diff-index' shows the differences
+Unlike `git diff-files`, which showed the difference between the index
+file and the working tree, `git diff-index` shows the differences
 between a committed *tree* and either the index file or the working
-tree. In other words, 'git diff-index' wants a tree to be diffed
+tree. In other words, `git diff-index` wants a tree to be diffed
 against, and before we did the commit, we couldn't do that, because we
 didn't have anything to diff against.
 
@@ -383,7 +383,7 @@ But now we can do
 $ git diff-index -p HEAD
 ----------------
 
-(where `-p` has the same meaning as it did in 'git diff-files'), and it
+(where `-p` has the same meaning as it did in `git diff-files`), and it
 will show us the same difference, but for a totally different reason.
 Now we're comparing the working tree not against the index file,
 but against the tree we just wrote. It just so happens that those two
@@ -398,7 +398,7 @@ $ git diff HEAD
 
 which ends up doing the above for you.
 
-In other words, 'git diff-index' normally compares a tree against the
+In other words, `git diff-index` normally compares a tree against the
 working tree, but when given the `--cached` flag, it is told to
 instead compare against just the index cache contents, and ignore the
 current working tree state entirely. Since we just wrote the index
@@ -407,7 +407,7 @@ an empty set of differences, and that's exactly what it does.
 
 [NOTE]
 ================
-'git diff-index' really always uses the index for its
+`git diff-index` really always uses the index for its
 comparisons, and saying that it compares a tree against the working
 tree is thus not strictly accurate. In particular, the list of
 files to compare (the "meta-data") *always* comes from the index file,
@@ -436,11 +436,11 @@ $ git update-index hello
 (note how we didn't need the `--add` flag this time, since Git knew
 about the file already).
 
-Note what happens to the different 'git diff-{asterisk}' versions here.
+Note what happens to the different `git diff-*` versions here.
 After we've updated `hello` in the index, `git diff-files -p` now shows no
 differences, but `git diff-index -p HEAD` still *does* show that the
 current state is different from the state we committed. In fact, now
-'git diff-index' shows the same difference whether we use the `--cached`
+`git diff-index` shows the same difference whether we use the `--cached`
 flag or not, since now the index is coherent with the working tree.
 
 Now, since we've updated `hello` in the index, we can commit the new
@@ -476,9 +476,9 @@ Inspecting Changes
 
 While creating changes is useful, it's even more useful if you can tell
 later what changed. The most useful command for this is another of the
-'diff' family, namely 'git diff-tree'.
+'diff' family, namely `git diff-tree`.
 
-'git diff-tree' can be given two arbitrary trees, and it will tell you the
+`git diff-tree` can be given two arbitrary trees, and it will tell you the
 differences between them. Perhaps even more commonly, though, you can
 give it just a single commit object, and it will figure out the parent
 of that commit itself, and show the difference directly. Thus, to get
@@ -526,14 +526,14 @@ various 'diff-{asterisk}' commands compare things.
                     +-----------+
 ============
 
-More interestingly, you can also give 'git diff-tree' the `--pretty` flag,
+More interestingly, you can also give `git diff-tree` the `--pretty` flag,
 which tells it to also show the commit message and author and date of the
 commit, and you can tell it to show a whole series of diffs.
 Alternatively, you can tell it to be "silent", and not show the diffs at
 all, but just show the actual commit message.
 
-In fact, together with the 'git rev-list' program (which generates a
-list of revisions), 'git diff-tree' ends up being a veritable fount of
+In fact, together with the `git rev-list` program (which generates a
+list of revisions), `git diff-tree` ends up being a veritable fount of
 changes.  You can emulate `git log`, `git log -p`, etc. with a trivial
 script that pipes the output of `git rev-list` to `git diff-tree --stdin`,
 which was exactly how early versions of `git log` were implemented.
@@ -570,7 +570,7 @@ pointer to the state you want to tag, but also a small tag name and
 message, along with optionally a PGP signature that says that yes,
 you really did
 that tag. You create these annotated tags with either the `-a` or
-`-s` flag to 'git tag':
+`-s` flag to `git tag`:
 
 ----------------
 $ git tag -s <tagname>
@@ -617,7 +617,7 @@ and it will be gone. There's no external repository, and there's no
 history outside the project you created.
 
  - if you want to move or duplicate a Git repository, you can do so. There
-   is 'git clone' command, but if all you want to do is just to
+   is `git clone` command, but if all you want to do is just to
    create a copy of your repository (with all the full history that
    went along with it), you can do so with a regular
    `cp -a git-tutorial new-git-tutorial`.
@@ -641,7 +641,7 @@ When copying a remote repository, you'll want to at a minimum update the
 index cache when you do this, and especially with other peoples'
 repositories you often want to make sure that the index cache is in some
 known state (you don't know *what* they've done and not yet checked in),
-so usually you'll precede the 'git update-index' with a
+so usually you'll precede the `git update-index` with a
 
 ----------------
 $ git read-tree --reset HEAD
@@ -649,7 +649,7 @@ $ git update-index --refresh
 ----------------
 
 which will force a total index re-build from the tree pointed to by `HEAD`.
-It resets the index contents to `HEAD`, and then the 'git update-index'
+It resets the index contents to `HEAD`, and then the `git update-index`
 makes sure to match up all index entries with the checked-out files.
 If the original repository had uncommitted changes in its
 working tree, `git update-index --refresh` notices them and
@@ -663,9 +663,9 @@ $ git reset
 
 and in fact a lot of the common Git command combinations can be scripted
 with the `git xyz` interfaces.  You can learn things by just looking
-at what the various git scripts do.  For example, `git reset` used to be
-the above two lines implemented in 'git reset', but some things like
-'git status' and 'git commit' are slightly more complex scripts around
+at what the various `git` scripts do.  For example, `git reset` used to be
+the above two lines implemented in `git reset`, but some things like
+`git status` and `git commit` are slightly more complex scripts around
 the basic Git commands.
 
 Many (most?) public remote repositories will not contain any of
@@ -704,7 +704,7 @@ where the `-u` flag means that you want the checkout to keep the index
 up to date (so that you don't have to refresh it afterward), and the
 `-a` flag means "check out all files" (if you have a stale copy or an
 older version of a checked out tree you may also need to add the `-f`
-flag first, to tell 'git checkout-index' to *force* overwriting of any old
+flag first, to tell `git checkout-index` to *force* overwriting of any old
 files).
 
 Again, this can all be simplified with
@@ -751,7 +751,7 @@ to it.
 ================================================
 If you make the decision to start your new branch at some
 other point in the history than the current `HEAD`, you can do so by
-just telling 'git switch' what the base of the checkout would be.
+just telling `git switch` what the base of the checkout would be.
 In other words, if you have an earlier tag or branch, you'd just do
 
 ------------
@@ -794,7 +794,7 @@ $ git branch <branchname> [startingpoint]
 
 which will simply _create_ the branch, but will not do anything further.
 You can then later -- once you decide that you want to actually develop
-on that branch -- switch to that branch with a regular 'git switch'
+on that branch -- switch to that branch with a regular `git switch`
 with the branchname as the argument.
 
 
@@ -853,10 +853,10 @@ means: normally it will just show you your current `HEAD`) and their
 histories. You can also see exactly how they came to be from a common
 source.
 
-Anyway, let's exit 'gitk' (`^Q` or the File menu), and decide that we want
+Anyway, let's exit `gitk` (`^Q` or the File menu), and decide that we want
 to merge the work we did on the `mybranch` branch into the `master`
 branch (which is currently our `HEAD` too). To do that, there's a nice
-script called 'git merge', which wants to know which branches you want
+script called `git merge`, which wants to know which branches you want
 to resolve and what the merge is all about:
 
 ------------
@@ -900,7 +900,7 @@ $ git commit -i hello
 
 which will very loudly warn you that you're now committing a merge
 (which is correct, so never mind), and you can write a small merge
-message about your adventures in 'git merge'-land.
+message about your adventures in `git merge`-land.
 
 After you're done, start up `gitk --all` to see graphically what the
 history looks like. Notice that `mybranch` still exists, and you can
@@ -941,21 +941,21 @@ branch head.  Please see linkgit:gitrevisions[7] if you want to
 see more complex cases.
 
 [NOTE]
-Without the `--more=1` option, 'git show-branch' would not output the
+Without the `--more=1` option, `git show-branch` would not output the
 '[master^]' commit, as '[mybranch]' commit is a common ancestor of
 both `master` and `mybranch` tips.  Please see linkgit:git-show-branch[1]
 for details.
 
 [NOTE]
 If there were more commits on the `master` branch after the merge, the
-merge commit itself would not be shown by 'git show-branch' by
+merge commit itself would not be shown by `git show-branch` by
 default.  You would need to provide `--sparse` option to make the
 merge commit visible in this case.
 
 Now, let's pretend you are the one who did all the work in
 `mybranch`, and the fruit of your hard work has finally been merged
 to the `master` branch. Let's go back to `mybranch`, and run
-'git merge' to get the "upstream changes" back to your branch.
+`git merge` to get the "upstream changes" back to your branch.
 
 ------------
 $ git switch mybranch
@@ -997,12 +997,12 @@ Merging external work
 It's usually much more common that you merge with somebody else than
 merging with your own branches, so it's worth pointing out that Git
 makes that very easy too, and in fact, it's not that different from
-doing a 'git merge'. In fact, a remote merge ends up being nothing
+doing a `git merge`. In fact, a remote merge ends up being nothing
 more than "fetch the work from a remote repository into a temporary tag"
-followed by a 'git merge'.
+followed by a `git merge`.
 
 Fetching from a remote repository is done by, unsurprisingly,
-'git fetch':
+`git fetch`:
 
 ----------------
 $ git fetch <remote-repository>
@@ -1055,7 +1055,7 @@ The 'commit walkers' are sometimes also called 'dumb
 transports', because they do not require any Git aware smart
 server like Git Native transport does.  Any stock HTTP server
 that does not even support directory index would suffice.  But
-you must prepare your repository with 'git update-server-info'
+you must prepare your repository with `git update-server-info`
 to help dumb transport downloaders.
 
 Once you fetch from the remote repository, you `merge` that
@@ -1075,7 +1075,7 @@ argument.
 [NOTE]
 You could do without using any branches at all, by
 keeping as many local repositories as you would like to have
-branches, and merging between them with 'git pull', just like
+branches, and merging between them with `git pull`, just like
 you merge between branches. The advantage of this approach is
 that it lets you keep a set of files for each `branch` checked
 out and you may find it easier to switch back and forth if you
@@ -1092,7 +1092,7 @@ like this:
 $ git config remote.linus.url http://www.kernel.org/pub/scm/git/git.git/
 ------------------------------------------------
 
-and use the "linus" keyword with 'git pull' instead of the full URL.
+and use the "linus" keyword with `git pull` instead of the full URL.
 
 Examples.
 
@@ -1128,7 +1128,7 @@ $ git show-branch --more=2 master mybranch
 +* [master^] Some fun.
 ------------
 
-Remember, before running 'git merge', our `master` head was at
+Remember, before running `git merge`, our `master` head was at
 "Some fun." commit, while our `mybranch` head was at "Some
 work." commit.
 
@@ -1154,7 +1154,7 @@ Now we are ready to experiment with the merge by hand.
 
 `git merge` command, when merging two branches, uses 3-way merge
 algorithm.  First, it finds the common ancestor between them.
-The command it uses is 'git merge-base':
+The command it uses is `git merge-base`:
 
 ------------
 $ mb=$(git merge-base HEAD mybranch)
@@ -1178,7 +1178,7 @@ this:
 $ git read-tree -m -u $mb HEAD mybranch
 ------------
 
-This is the same 'git read-tree' command we have already seen,
+This is the same `git read-tree` command we have already seen,
 but it takes three trees, unlike previous examples.  This reads
 the contents of each tree into different 'stage' in the index
 file (the first tree goes to stage 1, the second to stage 2,
@@ -1219,8 +1219,8 @@ $ git ls-files --unmerged
 
 The next step of merging is to merge these three versions of the
 file, using 3-way merge.  This is done by giving
-'git merge-one-file' command as one of the arguments to
-'git merge-index' command:
+`git merge-one-file` command as one of the arguments to
+`git merge-index` command:
 
 ------------
 $ git merge-index git-merge-one-file hello
@@ -1229,7 +1229,7 @@ ERROR: Merge conflict in hello
 fatal: merge program failed
 ------------
 
-'git merge-one-file' script is called with parameters to
+`git merge-one-file` script is called with parameters to
 describe those three versions, and is responsible to leave the
 merge results in the working tree.
 It is a fairly straightforward shell script, and
@@ -1248,9 +1248,9 @@ $ git ls-files --stage
 ------------
 
 This is the state of the index file and the working file after
-'git merge' returns control back to you, leaving the conflicting
+`git merge` returns control back to you, leaving the conflicting
 merge for you to resolve.  Notice that the path `hello` is still
-unmerged, and what you see with 'git diff' at this point is
+unmerged, and what you see with `git diff` at this point is
 differences since stage 2 (i.e. your version).
 
 
@@ -1278,7 +1278,7 @@ how Git repositories at `kernel.org` are managed.
 Publishing the changes from your local (private) repository to
 your remote (public) repository requires a write privilege on
 the remote machine. You need to have an SSH account there to
-run a single command, 'git-receive-pack'.
+run a single command, `git-receive-pack`.
 
 First, you need to create an empty repository on the remote
 machine that will house your public repository. This empty
@@ -1287,8 +1287,8 @@ into it later. Obviously, this repository creation needs to be
 done only once.
 
 [NOTE]
-'git push' uses a pair of commands,
-'git send-pack' on your local machine, and 'git-receive-pack'
+`git push` uses a pair of commands,
+`git send-pack` on your local machine, and `git-receive-pack`
 on the remote machine. The communication between the two over
 the network internally uses an SSH connection.
 
@@ -1303,7 +1303,7 @@ $ mkdir my-git.git
 ------------
 
 Then, make that directory into a Git repository by running
-'git init', but this time, since its name is not the usual
+`git init`, but this time, since its name is not the usual
 `.git`, we do things slightly differently:
 
 ------------
@@ -1312,7 +1312,7 @@ $ GIT_DIR=my-git.git git init
 
 Make sure this directory is available for others you want your
 changes to be pulled via the transport of your choice. Also
-you need to make sure that you have the 'git-receive-pack'
+you need to make sure that you have the `git-receive-pack`
 program on the `$PATH`.
 
 [NOTE]
@@ -1320,7 +1320,7 @@ Many installations of sshd do not invoke your shell as the login
 shell when you directly run programs; what this means is that if
 your login shell is 'bash', only `.bashrc` is read and not
 `.bash_profile`. As a workaround, make sure `.bashrc` sets up
-`$PATH` so that you can run 'git-receive-pack' program.
+`$PATH` so that you can run `git-receive-pack` program.
 
 [NOTE]
 If you plan to publish this repository to be accessed over http,
@@ -1366,7 +1366,7 @@ $ git repack
 
 will do it for you. If you followed the tutorial examples, you
 would have accumulated about 17 objects in `.git/objects/??/`
-directories by now. 'git repack' tells you how many objects it
+directories by now. `git repack` tells you how many objects it
 packed, and stores the packed file in the `.git/objects/pack`
 directory.
 
@@ -1379,7 +1379,7 @@ them together. The former holds all the data from the objects
 in the pack, and the latter holds the index for random
 access.
 
-If you are paranoid, running 'git verify-pack' command would
+If you are paranoid, running `git verify-pack` command would
 detect if you have a corrupt pack, but do not worry too much.
 Our programs are always perfect ;-).
 
@@ -1446,17 +1446,17 @@ If other people are pulling from your repository over dumb
 transport protocols (HTTP), you need to keep this repository
 'dumb transport friendly'.  After `git init`,
 `$GIT_DIR/hooks/post-update.sample` copied from the standard templates
-would contain a call to 'git update-server-info'
+would contain a call to `git update-server-info`
 but you need to manually enable the hook with
 `mv post-update.sample post-update`.  This makes sure
-'git update-server-info' keeps the necessary files up to date.
+`git update-server-info` keeps the necessary files up to date.
 
 3. Push into the public repository from your primary
    repository.
 
-4. 'git repack' the public repository. This establishes a big
+4. `git repack` the public repository. This establishes a big
    pack that contains the initial set of objects as the
-   baseline, and possibly 'git prune' if the transport
+   baseline, and possibly `git prune` if the transport
    used for pulling from your repository supports packed
    repositories.
 
@@ -1470,14 +1470,14 @@ You can repack this private repository whenever you feel like.
 6. Push your changes to the public repository, and announce it
    to the public.
 
-7. Every once in a while, 'git repack' the public repository.
+7. Every once in a while, `git repack` the public repository.
    Go back to step 5. and continue working.
 
 
 A recommended work cycle for a "subsystem maintainer" who works
 on that project and has an own "public repository" goes like this:
 
-1. Prepare your work repository, by running 'git clone' on the public
+1. Prepare your work repository, by running `git clone` on the public
    repository of the "project lead". The URL used for the
    initial cloning is stored in the `remote.origin.url`
    configuration variable.
@@ -1492,7 +1492,7 @@ on that project and has an own "public repository" goes like this:
    point at the repository you are borrowing from.
 
 4. Push into the public repository from your primary
-   repository. Run 'git repack', and possibly 'git prune' if the
+   repository. Run `git repack`, and possibly `git prune` if the
    transport used for pulling from your repository supports
    packed repositories.
 
@@ -1509,7 +1509,7 @@ like.
    "project lead" and possibly your "sub-subsystem
    maintainers" to pull from it.
 
-7. Every once in a while, 'git repack' the public repository.
+7. Every once in a while, `git repack` the public repository.
    Go back to step 5. and continue working.
 
 
@@ -1517,7 +1517,7 @@ A recommended work cycle for an "individual developer" who does
 not have a "public" repository is somewhat different. It goes
 like this:
 
-1. Prepare your work repository, by 'git clone' the public
+1. Prepare your work repository, by `git clone` the public
    repository of the "project lead" (or a "subsystem
    maintainer", if you work on a subsystem). The URL used for
    the initial cloning is stored in the `remote.origin.url`
@@ -1615,8 +1615,8 @@ $ git reset --hard master~2
 ------------
 
 You can make sure `git show-branch` matches the state before
-those two 'git merge' you just did.  Then, instead of running
-two 'git merge' commands in a row, you would merge these two
+those two `git merge` you just did.  Then, instead of running
+two `git merge` commands in a row, you would merge these two
 branch heads (this is known as 'making an Octopus'):
 
 ------------
diff --git a/Documentation/gitcredentials.txt b/Documentation/gitcredentials.txt
index dffbdfbd0b..a11e72ca4c 100644
--- a/Documentation/gitcredentials.txt
+++ b/Documentation/gitcredentials.txt
@@ -8,8 +8,8 @@ gitcredentials - Providing usernames and passwords to Git
 SYNOPSIS
 --------
 ------------------
-git config credential.https://example.com.username myusername
-git config credential.helper "$helper $options"
+`git config` credential.https://example.com.username myusername
+`git config` credential.helper "$helper $options"
 ------------------
 
 DESCRIPTION
@@ -206,7 +206,7 @@ these rules:
   2. Otherwise, if the helper string begins with an absolute path, the
      verbatim helper string becomes the command.
 
-  3. Otherwise, the string "git credential-" is prepended to the helper
+  3. Otherwise, the string `git credential-` is prepended to the helper
      string, and the result becomes the command.
 
 The resulting command then has an "operation" argument appended to it
@@ -240,7 +240,7 @@ Here are some example specifications:
 
 Generally speaking, rule (3) above is the simplest for users to specify.
 Authors of credential helpers should make an effort to assist their
-users by naming their program "git-credential-$NAME", and putting it in
+users by naming their program `git-credential-$NAME`, and putting it in
 the `$PATH` or `$GIT_EXEC_PATH` during installation, which will allow a
 user to enable it with `git config credential.helper $NAME`.
 
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 1cd1283d0f..4d4a70ae4b 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -8,7 +8,7 @@ gitcvs-migration - Git for CVS users
 SYNOPSIS
 --------
 [verse]
-'git cvsimport' *
+`git cvsimport` *
 
 DESCRIPTION
 -----------
@@ -43,30 +43,30 @@ $ git pull origin
 
 which merges in any work that others might have done since the clone
 operation.  If there are uncommitted changes in your working tree, commit
-them first before running git pull.
+them first before running `git pull`.
 
 [NOTE]
 ================================
 The 'pull' command knows where to get updates from because of certain
-configuration variables that were set by the first 'git clone'
+configuration variables that were set by the first `git clone`
 command; see `git config -l` and the linkgit:git-config[1] man
 page for details.
 ================================
 
 You can update the shared repository with your changes by first committing
-your changes, and then using the 'git push' command:
+your changes, and then using the `git push` command:
 
 ------------------------------------------------
 $ git push origin master
 ------------------------------------------------
 
 to "push" those commits to the shared repository.  If someone else has
-updated the repository more recently, 'git push', like 'cvs commit', will
+updated the repository more recently, `git push`, like 'cvs commit', will
 complain, in which case you must pull any changes before attempting the
 push again.
 
-In the 'git push' command above we specify the name of the remote branch
-to update (`master`).  If we leave that out, 'git push' tries to update
+In the `git push` command above we specify the name of the remote branch
+to update (`master`).  If we leave that out, `git push` tries to update
 any branches in the remote repository that have the same name as a branch
 in the local repository.  So the last 'push' can be done with either of:
 
diff --git a/Documentation/gitdiffcore.txt b/Documentation/gitdiffcore.txt
index fbc458c3e5..2a157dba2f 100644
--- a/Documentation/gitdiffcore.txt
+++ b/Documentation/gitdiffcore.txt
@@ -8,12 +8,12 @@ gitdiffcore - Tweaking diff output
 SYNOPSIS
 --------
 [verse]
-'git diff' *
+`git diff` *
 
 DESCRIPTION
 -----------
 
-The diff commands 'git diff-index', 'git diff-files', and 'git diff-tree'
+The diff commands `git diff-index`, `git diff-files`, and `git diff-tree`
 can be told to manipulate differences they find in
 unconventional ways before showing 'diff' output.  The manipulation
 is collectively called "diffcore transformation".  This short note
@@ -24,18 +24,18 @@ that is easier to understand than the conventional kind.
 The chain of operation
 ----------------------
 
-The 'git diff-{asterisk}' family works by first comparing two sets of
+The `git diff-*` family works by first comparing two sets of
 files:
 
- - 'git diff-index' compares contents of a "tree" object and the
+ - `git diff-index` compares contents of a "tree" object and the
    working directory (when `--cached` flag is not used) or a
    "tree" object and the index file (when `--cached` flag is
    used);
 
- - 'git diff-files' compares contents of the index file and the
+ - `git diff-files` compares contents of the index file and the
    working directory;
 
- - 'git diff-tree' compares contents of two "tree" objects;
+ - `git diff-tree` compares contents of two "tree" objects;
 
 In all of these cases, the commands themselves first optionally limit
 the two sets of files by any pathspecs given on their command-lines,
@@ -76,12 +76,12 @@ into another list.  There are currently 5 such transformations:
 - diffcore-order
 - diffcore-rotate
 
-These are applied in sequence.  The set of filepairs 'git diff-{asterisk}'
+These are applied in sequence.  The set of filepairs `git diff-*`
 commands find are used as the input to diffcore-break, and
 the output from diffcore-break is used as the input to the
 next transformation.  The final result is then passed to the
 output routine and generates either diff-raw format (see Output
-format sections of the manual for 'git diff-{asterisk}' commands) or
+format sections of the manual for `git diff-*` commands) or
 diff-patch format.
 
 
@@ -89,7 +89,7 @@ diffcore-break: For Splitting Up Complete Rewrites
 --------------------------------------------------
 
 The second transformation in the chain is diffcore-break, and is
-controlled by the `-B` option to the 'git diff-{asterisk}' commands.  This is
+controlled by the `-B` option to the `git diff-*` commands.  This is
 used to detect a filepair that represents "complete rewrite" and
 break such filepair into two filepairs that represent delete and
 create.  E.g.  If the input contained this filepair:
@@ -125,7 +125,7 @@ diffcore-rename: For Detecting Renames and Copies
 
 This transformation is used to detect renames and copies, and is
 controlled by the `-M` option (to detect renames) and the `-C` option
-(to detect copies as well) to the 'git diff-{asterisk}' commands.  If the
+(to detect copies as well) to the `git diff-*` commands.  If the
 input contained these filepairs:
 
 ------------------------------------------------
@@ -190,11 +190,11 @@ throughout the directory hierarchy after exact rename detection, this
 preliminary step may be skipped for those files.
 
 Note.  When the `-C` option is used with `--find-copies-harder`
-option, 'git diff-{asterisk}' commands feed unmodified filepairs to
+option, `git diff-*` commands feed unmodified filepairs to
 diffcore mechanism as well as modified ones.  This lets the copy
 detector consider unmodified files as copy source candidates at
 the expense of making it slower.  Without `--find-copies-harder`,
-'git diff-{asterisk}' commands can detect copies only if the file that was
+`git diff-*` commands can detect copies only if the file that was
 copied happened to have been modified in the same changeset.
 
 
@@ -278,7 +278,7 @@ diffcore-order: For Sorting the Output Based on Filenames
 
 This is used to reorder the filepairs according to the user's
 (or project's) taste, and is controlled by the `-O` option to the
-'git diff-{asterisk}' commands.
+`git diff-*` commands.
 
 This takes a text file each of whose lines is a shell glob
 pattern.  Filepairs that match a glob pattern on an earlier line
@@ -305,10 +305,10 @@ filepairs so that the filepair for the given pathname comes first,
 optionally discarding the paths that come before it.  This is used
 to implement the `--skip-to` and the `--rotate-to` options.  It is
 an error when the specified pathname is not in the set of filepairs,
-but it is not useful to error out when used with "git log" family of
+but it is not useful to error out when used with `git log` family of
 commands, because it is unreasonable to expect that a given path
-would be modified by each and every commit shown by the "git log"
-command.  For this reason, when used with "git log", the filepair
+would be modified by each and every commit shown by the `git log`
+command.  For this reason, when used with `git log`, the filepair
 that sorts the same as, or the first one that sorts after, the given
 pathname is where the output starts.
 
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 03c9e5e8d5..770e29d34f 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -363,7 +363,7 @@ $ grep 9418 /etc/services
 git		9418/tcp		# Git Version Control System
 ------------
 
-Run git-daemon to serve /pub/scm from inetd.::
+Run `git-daemon` to serve /pub/scm from inetd.::
 +
 ------------
 $ grep git /etc/inetd.conf
@@ -373,7 +373,7 @@ git	stream	tcp	nowait	nobody \
 +
 The actual configuration line should be on one line.
 
-Run git-daemon to serve /pub/scm from xinetd.::
+Run `git-daemon` to serve /pub/scm from xinetd.::
 +
 ------------
 $ cat /etc/xinetd.d/git-daemon
@@ -396,7 +396,7 @@ service git
 Check your xinetd(8) documentation and setup, this is from a Fedora system.
 Others might be different.
 
-Give push/pull only access to developers using git-over-ssh.::
+Give push/pull only access to developers using `git-over-ssh`.::
 
 e.g. those using:
 `$ git push/pull ssh://host.xz/pub/scm/project`
@@ -442,7 +442,7 @@ refs/heads/doc-update	bob
 refs/tags/v[0-9]*	david
 ------------
 +
-<1> place the developers into the same git group.
+<1> place the developers into the same `git` group.
 <2> and make the shared repository writable by the group.
 <3> use update-hook example by Carl from Documentation/howto/
 for branch policy control.
diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
index afdaeab850..92e8106af4 100644
--- a/Documentation/gitfaq.txt
+++ b/Documentation/gitfaq.txt
@@ -349,7 +349,7 @@ See the following entry for information about normalizing line endings as well,
 and see linkgit:gitattributes[5] for more information about attribute files.
 
 [[windows-diff-control-m]]
-I'm on Windows and git diff shows my files as having a `^M` at the end.::
+I'm on Windows and `git diff` shows my files as having a `^M` at the end.::
 	By default, Git expects files to be stored with Unix line endings.  As such,
 	the carriage return (`^M`) that is part of a Windows line ending is shown
 	because it is considered to be trailing whitespace.  Git defaults to showing
diff --git a/Documentation/githooks.txt b/Documentation/githooks.txt
index 5e87987882..8cee030fbd 100644
--- a/Documentation/githooks.txt
+++ b/Documentation/githooks.txt
@@ -321,11 +321,11 @@ does not know the entire set of branches, so it would end up
 firing one e-mail per ref when used naively, though.  The
 <<post-receive,'post-receive'>> hook is more suited to that.
 
-In an environment that restricts the users' access only to git
+In an environment that restricts the users' access only to `git`
 commands over the wire, this hook can be used to implement access
 control without relying on filesystem ownership and group
 membership. See linkgit:git-shell[1] for how you might use the login
-shell to restrict the user's access to only git commands.
+shell to restrict the user's access to only `git` commands.
 
 Both standard output and standard error output are forwarded to
 `git send-pack` on the other end, so you can simply `echo` messages
@@ -617,10 +617,10 @@ Git will limit what files it checks for changes as well as which
 directories are checked for untracked files based on the path names
 given.
 
-An optimized way to tell git "all files have changed" is to return
+An optimized way to tell `git` "all files have changed" is to return
 the filename `/`.
 
-The exit status determines whether git will use the data from the
+The exit status determines whether `git` will use the data from the
 hook to limit its search.  On error, it will fall back to verifying
 all files and folders.
 
@@ -666,7 +666,7 @@ This hook is invoked by `git-p4 submit`.
 The `p4-post-changelist` hook is invoked after the submit has
 successfully occurred in P4. It takes no parameters and is meant
 primarily for notification and cannot affect the outcome of the
-git p4 submit action.
+`git p4 submit` action.
 
 Run `git-p4 submit --help` for details.
 
diff --git a/Documentation/gitignore.txt b/Documentation/gitignore.txt
index 5751603b13..379db07326 100644
--- a/Documentation/gitignore.txt
+++ b/Documentation/gitignore.txt
@@ -61,10 +61,10 @@ be used.
    empty, $HOME/.config/git/ignore is used instead.
 
 The underlying Git plumbing tools, such as
-'git ls-files' and 'git read-tree', read
+`git ls-files` and `git read-tree`, read
 `gitignore` patterns specified by command-line options, or from
 files specified by command-line options.  Higher-level Git
-tools, such as 'git status' and 'git add',
+tools, such as `git status` and `git add`,
 use patterns from the sources specified above.
 
 PATTERN FORMAT
@@ -147,7 +147,7 @@ The purpose of gitignore files is to ensure that certain files
 not tracked by Git remain untracked.
 
 To stop tracking a file that is currently tracked, use
-'git rm --cached'.
+`git rm --cached`.
 
 EXAMPLES
 --------
diff --git a/Documentation/gitk.txt b/Documentation/gitk.txt
index 29bd307bb9..41eb7a6577 100644
--- a/Documentation/gitk.txt
+++ b/Documentation/gitk.txt
@@ -8,7 +8,7 @@ gitk - The Git repository browser
 SYNOPSIS
 --------
 [verse]
-'gitk' [<options>] [<revision range>] [--] [<path>...]
+`gitk` [<options>] [<revision range>] [--] [<path>...]
 
 DESCRIPTION
 -----------
@@ -19,13 +19,13 @@ the files in the trees of each revision.
 OPTIONS
 -------
 
-To control which revisions to show, gitk supports most options
-applicable to the 'git rev-list' command.  It also supports a few
-options applicable to the 'git diff-*' commands to control how the
+To control which revisions to show, `gitk` supports most options
+applicable to the `git rev-list` command.  It also supports a few
+options applicable to the `git diff-*` commands to control how the
 changes each commit introduces are shown.  Finally, it supports some
-gitk-specific options.
+`gitk`-specific options.
 
-gitk generally only understands options with arguments in the
+`gitk` generally only understands options with arguments in the
 'sticked' form (see linkgit:gitcli[7]) due to limitations in the
 command-line parser.
 
@@ -115,12 +115,12 @@ include::line-range-options.txt[]
 	avoid ambiguity with respect to revision names use `--` to separate the paths
 	from any preceding options.
 
-gitk-specific options
+`gitk`-specific options
 ~~~~~~~~~~~~~~~~~~~~~
 
 --argscmd=<command>::
 
-	Command to be run each time gitk has to determine the revision
+	Command to be run each time `gitk` has to determine the revision
 	range to show.  The command is expected to print on its
 	standard output a list of additional revisions to be shown,
 	one per line.  Use this instead of explicitly specifying a
@@ -141,9 +141,9 @@ gitk v2.6.12.. include/scsi drivers/scsi::
 
 gitk --since="2 weeks ago" \-- gitk::
 
-	Show the changes during the last two weeks to the file 'gitk'.
+	Show the changes during the last two weeks to the file `gitk`.
 	The `--` is necessary to avoid confusion with the *branch* named
-	'gitk'
+	`gitk`
 
 gitk --max-count=100 --all \-- Makefile::
 
@@ -166,11 +166,11 @@ History
 Gitk was the first graphical repository browser. It's written in
 tcl/tk.
 
-'gitk' is actually maintained as an independent project, but stable
+`gitk` is actually maintained as an independent project, but stable
 versions are distributed as part of the Git suite for the convenience
 of end users.
 
-gitk-git/ comes from Paul Mackerras's gitk project:
+gitk-git/ comes from Paul Mackerras's `gitk` project:
 
 	git://ozlabs.org/~paulus/gitk
 
diff --git a/Documentation/gitmodules.txt b/Documentation/gitmodules.txt
index 8e333dde1b..2c1e847076 100644
--- a/Documentation/gitmodules.txt
+++ b/Documentation/gitmodules.txt
@@ -20,7 +20,7 @@ of linkgit:git-config[1].
 The file contains one subsection per submodule, and the subsection value
 is the name of the submodule. The name is set to the path where the
 submodule has been added unless it was customized with the `--name`
-option of 'git submodule add'. Each submodule section also contains the
+option of `git submodule add`. Each submodule section also contains the
 following required keys:
 
 submodule.<name>.path::
diff --git a/Documentation/gitnamespaces.txt b/Documentation/gitnamespaces.txt
index 29bac9e1bf..6a273464a4 100644
--- a/Documentation/gitnamespaces.txt
+++ b/Documentation/gitnamespaces.txt
@@ -8,8 +8,8 @@ gitnamespaces - Git namespaces
 SYNOPSIS
 --------
 [verse]
-GIT_NAMESPACE=<namespace> 'git upload-pack'
-GIT_NAMESPACE=<namespace> 'git receive-pack'
+GIT_NAMESPACE=<namespace> `git upload-pack`
+GIT_NAMESPACE=<namespace> `git receive-pack`
 
 
 DESCRIPTION
@@ -46,8 +46,8 @@ which could otherwise generate directory/file conflicts within the `refs`
 directory.
 
 linkgit:git-upload-pack[1] and linkgit:git-receive-pack[1] rewrite the
-names of refs as specified by `GIT_NAMESPACE`.  git-upload-pack and
-git-receive-pack will ignore all references outside the specified
+names of refs as specified by `GIT_NAMESPACE`.  `git-upload-pack` and
+`git-receive-pack` will ignore all references outside the specified
 namespace.
 
 The smart HTTP server, linkgit:git-http-backend[1], will pass
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitremote-helpers.txt
index f5ac7ae7ca..6e75d45382 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -8,7 +8,7 @@ gitremote-helpers - Helper programs to interact with remote repositories
 SYNOPSIS
 --------
 [verse]
-'git remote-<transport>' <repository> [<URL>]
+`git remote-<transport>` <repository> [<URL>]
 
 DESCRIPTION
 -----------
@@ -31,8 +31,8 @@ transport objects between the object database and the remote repository,
 and update the local object store.
 
 Git comes with a "curl" family of remote helpers, that handle various
-transport protocols, such as 'git-remote-http', 'git-remote-https',
-'git-remote-ftp' and 'git-remote-ftps'. They implement the capabilities
+transport protocols, such as `git-remote-http`, `git-remote-https`,
+`git-remote-ftp` and `git-remote-ftps`. They implement the capabilities
 'fetch', 'option', and 'push'.
 
 INVOCATION
@@ -49,20 +49,20 @@ which directory to invoke auxiliary Git commands.
 
 When Git encounters a URL of the form '<transport>://<address>', where
 '<transport>' is a protocol that it cannot handle natively, it
-automatically invokes 'git remote-<transport>' with the full URL as
+automatically invokes `git remote-<transport>` with the full URL as
 the second argument. If such a URL is encountered directly on the
 command line, the first argument is the same as the second, and if it
 is encountered in a configured remote, the first argument is the name
 of that remote.
 
 A URL of the form '<transport>::<address>' explicitly instructs Git to
-invoke 'git remote-<transport>' with '<address>' as the second
+invoke `git remote-<transport>` with '<address>' as the second
 argument. If such a URL is encountered directly on the command line,
 the first argument is '<address>', and if it is encountered in a
 configured remote, the first argument is the name of that remote.
 
 Additionally, when a configured remote has `remote.<name>.vcs` set to
-'<transport>', Git explicitly invokes 'git remote-<transport>' with
+'<transport>', Git explicitly invokes `git remote-<transport>` with
 '<name>' as the first argument. If set, the second argument is
 `remote.<name>.url`; otherwise, the second argument is omitted.
 
@@ -95,8 +95,8 @@ must provide.
 Capabilities for Pushing
 ^^^^^^^^^^^^^^^^^^^^^^^^
 'connect'::
-	Can attempt to connect to 'git receive-pack' (for pushing),
-	'git upload-pack', etc for communication using
+	Can attempt to connect to `git receive-pack` (for pushing),
+	`git upload-pack`, etc for communication using
 	git's native packfile protocol. This
 	requires a bidirectional, full-duplex connection.
 +
@@ -129,7 +129,7 @@ When choosing between 'push' and 'export', Git prefers 'push'.
 Other frontends may have some other order of preference.
 
 'no-private-update'::
-	When using the 'refspec' capability, git normally updates the
+	When using the 'refspec' capability, `git` normally updates the
 	private ref on successful push. This update is disabled when
 	the remote-helper declares the capability 'no-private-update'.
 
@@ -137,8 +137,8 @@ Other frontends may have some other order of preference.
 Capabilities for Fetching
 ^^^^^^^^^^^^^^^^^^^^^^^^^
 'connect'::
-	Can try to connect to 'git upload-pack' (for fetching),
-	'git receive-pack', etc for communication using the
+	Can try to connect to `git upload-pack` (for fetching),
+	`git receive-pack`, etc for communication using the
 	Git's native packfile protocol. This
 	requires a bidirectional, full-duplex connection.
 +
@@ -372,15 +372,15 @@ Supported if the helper has the "import" capability.
 
 'export'::
 	Instructs the remote helper that any subsequent input is
-	part of a fast-import stream (generated by 'git fast-export')
+	part of a fast-import stream (generated by `git fast-export`)
 	containing objects which should be pushed to the remote.
 +
 Especially useful for interoperability with a foreign versioning
 system.
 +
 The 'export-marks' and 'import-marks' capabilities, if specified,
-affect this command in so far as they are passed on to 'git
-fast-export', which then will load/store a table of marks for
+affect this command in so far as they are passed on to `git
+fast-export`, which then will load/store a table of marks for
 local objects. This can be used to implement for incremental
 operations.
 +
@@ -388,8 +388,8 @@ Supported if the helper has the "export" capability.
 
 'connect' <service>::
 	Connects to given service. Standard input and standard output
-	of helper are connected to specified service (git prefix is
-	included in service name so e.g. fetching uses 'git-upload-pack'
+	of helper are connected to specified service (`git` prefix is
+	included in service name so e.g. fetching uses `git-upload-pack`
 	as service) on remote side. Valid replies to this command are
 	empty line (connection established), 'fallback' (no smart
 	transport support, fall back to dumb transports) and just
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index e174a28360..39cfebccf3 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -72,7 +72,7 @@ objects/info/packs::
 	are available in this object store.  Whenever a pack is
 	added or removed, `git update-server-info` should be run
 	to keep this file up to date if the repository is
-	published for dumb transports.  'git repack' does this
+	published for dumb transports.  `git repack` does this
 	by default.
 
 objects/info/alternates::
@@ -93,7 +93,7 @@ objects/info/http-alternates::
 
 refs::
 	References are stored in subdirectories of this
-	directory.  The 'git prune' command knows to preserve
+	directory.  The `git prune` command knows to preserve
 	objects reachable from refs found in this directory and
 	its subdirectories.
 	This directory is ignored (except refs/bisect,
@@ -152,7 +152,7 @@ config.worktree::
 
 branches::
 	A slightly deprecated way to store shorthands to be used
-	to specify a URL to 'git fetch', 'git pull' and 'git push'.
+	to specify a URL to `git fetch`, `git pull` and `git push`.
 	A file can be stored as `branches/<name>` and then
 	'name' can be given to these commands in place of
 	'repository' argument.  See the REMOTES section in
@@ -165,7 +165,7 @@ branches::
 hooks::
 	Hooks are customization scripts used by various Git
 	commands.  A handful of sample hooks are installed when
-	'git init' is run, but all of them are disabled by
+	`git init` is run, but all of them are disabled by
 	default.  To enable, the `.sample` suffix has to be
 	removed from the filename by renaming.
 	Read linkgit:githooks[5] for more details about
@@ -195,10 +195,10 @@ info/refs::
 	This file helps dumb transports discover what refs are
 	available in this repository.  If the repository is
 	published for dumb transports, this file should be
-	regenerated by 'git update-server-info' every time a tag
+	regenerated by `git update-server-info` every time a tag
 	or branch is created or modified.  This is normally done
 	from the `hooks/update` hook, which is run by the
-	'git-receive-pack' command when you 'git push' into the
+	`git-receive-pack` command when you `git push` into the
 	repository.
 
 info/grafts::
@@ -216,8 +216,8 @@ for a more flexible and robust system to do the same thing.
 info/exclude::
 	This file, by convention among Porcelains, stores the
 	exclude pattern list. `.gitignore` is the per-directory
-	ignore file.  'git status', 'git add', 'git rm' and
-	'git clean' look at it but the core Git commands do not look
+	ignore file.  `git status`, `git add`, `git rm` and
+	`git clean` look at it but the core Git commands do not look
 	at it.  See also: linkgit:gitignore[5].
 
 info/attributes::
@@ -230,8 +230,8 @@ info/sparse-checkout::
 
 remotes::
 	Stores shorthands for URL and default refnames for use
-	when interacting with remote repositories via 'git fetch',
-	'git pull' and 'git push' commands.  See the REMOTES section
+	when interacting with remote repositories via `git fetch`,
+	`git pull` and `git push` commands.  See the REMOTES section
 	in linkgit:git-fetch[1] for details.  This mechanism is legacy
 	and not likely to be found in modern repositories. This
 	directory is ignored if $GIT_COMMON_DIR is set and
@@ -264,7 +264,7 @@ commondir::
 	incomplete without the repository pointed by "commondir".
 
 modules::
-	Contains the git-repositories of the submodules.
+	Contains the `git`-repositories of the submodules.
 
 worktrees::
 	Contains administrative data for linked
diff --git a/Documentation/gittutorial-2.txt b/Documentation/gittutorial-2.txt
index 2b3cba8ae3..65bc1453d6 100644
--- a/Documentation/gittutorial-2.txt
+++ b/Documentation/gittutorial-2.txt
@@ -261,7 +261,7 @@ index a042389..513feba 100644
 +hello world, again
 ------------------------------------------------
 
-So 'git diff' is comparing against something other than the head.
+So `git diff` is comparing against something other than the head.
 The thing that it's comparing against is actually the index file,
 which is stored in .git/index in a binary format, but whose contents
 we can examine with ls-files:
@@ -276,9 +276,9 @@ hello world!
 hello world, again
 ------------------------------------------------
 
-So what our 'git add' did was store a new blob and then put
+So what our `git add` did was store a new blob and then put
 a reference to it in the index file.  If we modify the file again,
-we'll see that the new modifications are reflected in the 'git diff'
+we'll see that the new modifications are reflected in the `git diff`
 output:
 
 ------------------------------------------------
@@ -293,7 +293,7 @@ index 513feba..ba3da7b 100644
 +again?
 ------------------------------------------------
 
-With the right arguments, 'git diff' can also show us the difference
+With the right arguments, `git diff` can also show us the difference
 between the working directory and the last commit, or between the
 index and the last commit:
 
@@ -317,7 +317,7 @@ index a042389..513feba 100644
 +hello world, again
 ------------------------------------------------
 
-At any time, we can create a new commit using 'git commit' (without
+At any time, we can create a new commit using `git commit` (without
 the `-a` option), and verify that the state committed only includes the
 changes stored in the index file, not the additional change that is
 still only in our working tree:
@@ -335,11 +335,11 @@ index 513feba..ba3da7b 100644
 +again?
 ------------------------------------------------
 
-So by default 'git commit' uses the index to create the commit, not
+So by default `git commit` uses the index to create the commit, not
 the working tree; the `-a` option to commit tells it to first update
 the index with all changes in the working tree.
 
-Finally, it's worth looking at the effect of 'git add' on the index
+Finally, it's worth looking at the effect of `git add` on the index
 file:
 
 ------------------------------------------------
@@ -347,7 +347,7 @@ $ echo "goodbye, world" >closing.txt
 $ git add closing.txt
 ------------------------------------------------
 
-The effect of the 'git add' was to add one entry to the index file:
+The effect of the `git add` was to add one entry to the index file:
 
 ------------------------------------------------
 $ git ls-files --stage
@@ -385,8 +385,8 @@ Changes not staged for commit:
 Since the current state of closing.txt is cached in the index file,
 it is listed as "Changes to be committed".  Since file.txt has
 changes in the working directory that aren't reflected in the index,
-it is marked "changed but not updated".  At this point, running "git
-commit" would create a commit that added closing.txt (with its new
+it is marked "changed but not updated".  At this point, running `git
+commit` would create a commit that added closing.txt (with its new
 contents), but that didn't modify file.txt.
 
 Also, note that a bare `git diff` shows the changes to file.txt, but
@@ -403,7 +403,7 @@ What next?
 ----------
 
 At this point you should know everything necessary to read the man
-pages for any of the git commands; one good place to start would be
+pages for any of the `git` commands; one good place to start would be
 with the commands mentioned in linkgit:giteveryday[7].  You
 should be able to find any unknown jargon in linkgit:gitglossary[7].
 
diff --git a/Documentation/gittutorial.txt b/Documentation/gittutorial.txt
index 089a89f776..da3b218e22 100644
--- a/Documentation/gittutorial.txt
+++ b/Documentation/gittutorial.txt
@@ -68,7 +68,7 @@ You've now initialized the working directory--you may notice a new
 directory created, named ".git".
 
 Next, tell Git to take a snapshot of the contents of all files under the
-current directory (note the '.'), with 'git add':
+current directory (note the '.'), with `git add`:
 
 ------------------------------------------------
 $ git add .
@@ -76,7 +76,7 @@ $ git add .
 
 This snapshot is now stored in a temporary staging area which Git calls
 the "index".  You can permanently store the contents of the index in the
-repository with 'git commit':
+repository with `git commit`:
 
 ------------------------------------------------
 $ git commit
@@ -95,15 +95,15 @@ $ git add file1 file2 file3
 ------------------------------------------------
 
 You are now ready to commit.  You can see what is about to be committed
-using 'git diff' with the `--cached` option:
+using `git diff` with the `--cached` option:
 
 ------------------------------------------------
 $ git diff --cached
 ------------------------------------------------
 
-(Without `--cached`, 'git diff' will show you any changes that
+(Without `--cached`, `git diff` will show you any changes that
 you've made but not yet added to the index.)  You can also get a brief
-summary of the situation with 'git status':
+summary of the situation with `git status`:
 
 ------------------------------------------------
 $ git status
@@ -128,7 +128,7 @@ $ git commit
 This will again prompt you for a message describing the change, and then
 record a new version of the project.
 
-Alternatively, instead of running 'git add' beforehand, you can use
+Alternatively, instead of running `git add` beforehand, you can use
 
 ------------------------------------------------
 $ git commit -a
@@ -151,7 +151,7 @@ Git tracks content not files
 
 Many revision control systems provide an `add` command that tells the
 system to start tracking changes to a new file.  Git's `add` command
-does something simpler and more powerful: 'git add' is used both for new
+does something simpler and more powerful: `git add` is used both for new
 and newly modified files, and in both cases it takes a snapshot of the
 given files and stages that content in the index, ready for inclusion in
 the next commit.
@@ -349,7 +349,7 @@ she can issue the following command:
 $ gitk HEAD..FETCH_HEAD
 ------------------------------------------------
 
-This uses the same two-dot range notation we saw earlier with 'git log'.
+This uses the same two-dot range notation we saw earlier with `git log`.
 
 Alice may want to view what both of them did since they forked.
 She can use three-dot form instead of the two-dot form:
@@ -361,8 +361,8 @@ $ gitk HEAD...FETCH_HEAD
 This means "show everything that is reachable from either one, but
 exclude anything that is reachable from both of them".
 
-Please note that these range notation can be used with both gitk
-and "git log".
+Please note that these range notation can be used with both `gitk`
+and `git log`.
 
 After inspecting what Bob did, if there is nothing urgent, Alice may
 decide to continue working without pulling from Bob.  If Bob's history
@@ -380,7 +380,7 @@ alice$ git remote add bob /home/bob/myrepo
 ------------------------------------------------
 
 With this, Alice can perform the first part of the "pull" operation
-alone using the 'git fetch' command without merging them with her own
+alone using the `git fetch` command without merging them with her own
 branch, using:
 
 -------------------------------------
@@ -388,7 +388,7 @@ alice$ git fetch bob
 -------------------------------------
 
 Unlike the longhand form, when Alice fetches from Bob using a
-remote repository shorthand set up with 'git remote', what was
+remote repository shorthand set up with `git remote`, what was
 fetched is stored in a remote-tracking branch, in this case
 `bob/master`.  So after this:
 
@@ -413,7 +413,7 @@ branch', like this:
 alice$ git pull . remotes/bob/master
 -------------------------------------
 
-Note that git pull always merges into the current branch,
+Note that `git pull` always merges into the current branch,
 regardless of what else is given on the command line.
 
 Later, Bob can update his repo with Alice's latest changes using
@@ -432,7 +432,7 @@ bob$ git config --get remote.origin.url
 /home/alice/project
 -------------------------------------
 
-(The complete configuration created by 'git clone' is visible using
+(The complete configuration created by `git clone` is visible using
 `git config -l`, and the linkgit:git-config[1] man page
 explains the meaning of each option.)
 
@@ -462,8 +462,8 @@ Exploring history
 -----------------
 
 Git history is represented as a series of interrelated commits.  We
-have already seen that the 'git log' command can list those commits.
-Note that first line of each git log entry also gives a name for the
+have already seen that the `git log` command can list those commits.
+Note that first line of each `git log` entry also gives a name for the
 commit:
 
 -------------------------------------
@@ -475,7 +475,7 @@ Date:   Tue May 16 17:18:22 2006 -0700
     merge-base: Clarify the comments on post processing.
 -------------------------------------
 
-We can give this name to 'git show' to see the details about this
+We can give this name to `git show` to see the details about this
 commit.
 
 -------------------------------------
@@ -533,13 +533,13 @@ $ git reset --hard HEAD^ # reset your current branch and working
 Be careful with that last command: in addition to losing any changes
 in the working directory, it will also remove all later commits from
 this branch.  If this branch is the only branch containing those
-commits, they will be lost.  Also, don't use 'git reset' on a
+commits, they will be lost.  Also, don't use `git reset` on a
 publicly-visible branch that other developers pull from, as it will
 force needless merges on other developers to clean up the history.
-If you need to undo changes that you have pushed, use 'git revert'
+If you need to undo changes that you have pushed, use `git revert`
 instead.
 
-The 'git grep' command can search for strings in any version of your
+The `git grep` command can search for strings in any version of your
 project, so
 
 -------------------------------------
@@ -548,7 +548,7 @@ $ git grep "hello" v2.5
 
 searches for all occurrences of "hello" in v2.5.
 
-If you leave out the commit name, 'git grep' will search any of the
+If you leave out the commit name, `git grep` will search any of the
 files it manages in your current directory.  So
 
 -------------------------------------
@@ -558,7 +558,7 @@ $ git grep "hello"
 is a quick way to search just the files that are tracked by Git.
 
 Many Git commands also take sets of commits, which can be specified
-in a number of ways.  Here are some examples with 'git log':
+in a number of ways.  Here are some examples with `git log`:
 
 -------------------------------------
 $ git log v2.5..v2.6            # commits between v2.5 and v2.6
@@ -568,7 +568,7 @@ $ git log v2.5.. Makefile       # commits since v2.5 which modify
 				# Makefile
 -------------------------------------
 
-You can also give 'git log' a "range" of commits where the first is not
+You can also give `git log` a "range" of commits where the first is not
 necessarily an ancestor of the second; for example, if the tips of
 the branches `stable` and `master` diverged from a common
 commit some time ago, then
@@ -587,13 +587,13 @@ $ git log master..stable
 will show the list of commits made on the `stable` branch but not
 the `master` branch.
 
-The 'git log' command has a weakness: it must present commits in a
+The `git log` command has a weakness: it must present commits in a
 list.  When the history has lines of development that diverged and
-then merged back together, the order in which 'git log' presents
+then merged back together, the order in which `git log` presents
 those commits is meaningless.
 
 Most projects with multiple contributors (such as the Linux kernel,
-or Git itself) have frequent merges, and 'gitk' does a better job of
+or Git itself) have frequent merges, and `gitk` does a better job of
 visualizing their history.  For example,
 
 -------------------------------------
@@ -613,7 +613,7 @@ of the file:
 $ git diff v2.5:Makefile HEAD:Makefile.in
 -------------------------------------
 
-You can also use 'git show' to see any such file:
+You can also use `git show` to see any such file:
 
 -------------------------------------
 $ git show v2.5:Makefile
@@ -643,7 +643,7 @@ If you don't want to continue with that right away, a few other
 digressions that may be interesting at this point are:
 
   * linkgit:git-format-patch[1], linkgit:git-am[1]: These convert
-    series of git commits into emailed patches, and vice versa,
+    series of `git` commits into emailed patches, and vice versa,
     useful for projects such as the Linux kernel which rely heavily
     on emailed patches.
 
diff --git a/Documentation/gitweb.conf.txt b/Documentation/gitweb.conf.txt
index 181c543a64..5c74907da9 100644
--- a/Documentation/gitweb.conf.txt
+++ b/Documentation/gitweb.conf.txt
@@ -12,7 +12,7 @@ SYNOPSIS
 DESCRIPTION
 -----------
 
-The gitweb CGI script for viewing Git repositories over the web uses a
+The `gitweb` CGI script for viewing Git repositories over the web uses a
 perl script fragment as its configuration file.  You can set variables
 using "`our $variable = value`"; text from a "#" character until the
 end of a line is ignored.  See *perlsyn*(1) for details.
@@ -28,17 +28,17 @@ our $site_name = 'Example.org >> Repos';
 
 
 The configuration file is used to override the default settings that
-were built into gitweb at the time the 'gitweb.cgi' script was generated.
+were built into `gitweb` at the time the 'gitweb.cgi' script was generated.
 
-While one could just alter the configuration settings in the gitweb
+While one could just alter the configuration settings in the `gitweb`
 CGI itself, those changes would be lost upon upgrade.  Configuration
 settings might also be placed into a file in the same directory as the
 CGI script with the default name 'gitweb_config.perl' -- allowing
-one to have multiple gitweb instances with different configurations by
+one to have multiple `gitweb` instances with different configurations by
 the use of symlinks.
 
 Note that some configuration can be controlled on per-repository rather than
-gitweb-wide basis: see "Per-repository gitweb configuration" subsection on
+`gitweb`-wide basis: see "Per-repository `gitweb` configuration" subsection on
 linkgit:gitweb[1] manpage.
 
 
@@ -53,7 +53,7 @@ following order:
    `/etc/gitweb-common.conf`),
 
  * either per-instance configuration file (defaults to 'gitweb_config.perl'
-   in the same directory as the installed gitweb), or if it does not exists
+   in the same directory as the installed `gitweb`), or if it does not exists
    then fallback system-wide configuration file (defaults to `/etc/gitweb.conf`).
 
 Values obtained in later configuration files override values obtained earlier
@@ -65,7 +65,7 @@ are defined at compile time using build-time Makefile configuration
 variables, respectively `GITWEB_CONFIG_COMMON`, `GITWEB_CONFIG_SYSTEM`
 and `GITWEB_CONFIG`.
 
-You can also override locations of gitweb configuration files during
+You can also override locations of `gitweb` configuration files during
 runtime by setting the following environment variables:
 `GITWEB_CONFIG_COMMON`, `GITWEB_CONFIG_SYSTEM` and `GITWEB_CONFIG`
 to a non-empty value.
@@ -73,13 +73,13 @@ to a non-empty value.
 
 The syntax of the configuration files is that of Perl, since these files are
 handled by sourcing them as fragments of Perl code (the language that
-gitweb itself is written in). Variables are typically set using the
+`gitweb` itself is written in). Variables are typically set using the
 `our` qualifier (as in "`our $variable = <value>;`") to avoid syntax
-errors if a new version of gitweb no longer uses a variable and therefore
+errors if a new version of `gitweb` no longer uses a variable and therefore
 stops declaring it.
 
 You can include other configuration file using read_config_file()
-subroutine.  For example, one might want to put gitweb configuration
+subroutine.  For example, one might want to put `gitweb` configuration
 related to access control for viewing repositories via Gitolite (one
 of Git repository management tools) in a separate file, e.g. in
 `/etc/gitweb-gitolite.conf`.  To include it, put
@@ -88,31 +88,31 @@ of Git repository management tools) in a separate file, e.g. in
 read_config_file("/etc/gitweb-gitolite.conf");
 --------------------------------------------------
 
-somewhere in gitweb configuration file used, e.g. in per-installation
-gitweb configuration file.  Note that read_config_file() checks itself
+somewhere in `gitweb` configuration file used, e.g. in per-installation
+`gitweb` configuration file.  Note that read_config_file() checks itself
 that the file it reads exists, and does nothing if it is not found.
 It also handles errors in included file.
 
 
 The default configuration with no configuration file at all may work
 perfectly well for some installations.  Still, a configuration file is
-useful for customizing or tweaking the behavior of gitweb in many ways, and
+useful for customizing or tweaking the behavior of `gitweb` in many ways, and
 some optional features will not be present unless explicitly enabled using
-the configurable `%features` variable (see also "Configuring gitweb
+the configurable `%features` variable (see also "Configuring `gitweb`
 features" section below).
 
 
 CONFIGURATION VARIABLES
 -----------------------
 Some configuration variables have their default values (embedded in the CGI
-script) set during building gitweb -- if that is the case, this fact is put
+script) set during building `gitweb` -- if that is the case, this fact is put
 in their description.  See gitweb's 'INSTALL' file for instructions on building
-and installing gitweb.
+and installing `gitweb`.
 
 
 Location of repositories
 ~~~~~~~~~~~~~~~~~~~~~~~~
-The configuration variables described below control how gitweb finds
+The configuration variables described below control how `gitweb` finds
 Git repositories, and how repositories are displayed and accessed.
 
 See also "Repositories" and later subsections in linkgit:gitweb[1] manpage.
@@ -121,10 +121,10 @@ $projectroot::
 	Absolute filesystem path which will be prepended to project path;
 	the path to repository is `$projectroot/$project`.  Set to
 	`$GITWEB_PROJECTROOT` during installation.  This variable has to be
-	set correctly for gitweb to find repositories.
+	set correctly for `gitweb` to find repositories.
 +
 For example, if `$projectroot` is set to "/srv/git" by putting the following
-in gitweb config file:
+in `gitweb` config file:
 +
 ----------------------------------------------------------------------------
 our $projectroot = "/srv/git";
@@ -156,11 +156,11 @@ having the following format
 -----------------------------------------------------------------------------
 +
 The default value of this variable is determined by the `GITWEB_LIST`
-makefile variable at installation time.  If this variable is empty, gitweb
+makefile variable at installation time.  If this variable is empty, `gitweb`
 will fall back to scanning the `$projectroot` directory for repositories.
 
 $project_maxdepth::
-	If `$projects_list` variable is unset, gitweb will recursively
+	If `$projects_list` variable is unset, `gitweb` will recursively
 	scan filesystem for Git repositories.  The `$project_maxdepth`
 	is used to limit traversing depth, relative to `$projectroot`
 	(starting point); it means that directories which are further
@@ -177,8 +177,8 @@ configuration variable `GITWEB_PROJECT_MAXDEPTH`, which defaults to
 $export_ok::
 	Show repository only if this file exists (in repository).  Only
 	effective if this variable evaluates to true.  Can be set when
-	building gitweb by setting `GITWEB_EXPORT_OK`.  This path is
-	relative to `GIT_DIR`.  git-daemon[1] uses 'git-daemon-export-ok',
+	building `gitweb` by setting `GITWEB_EXPORT_OK`.  This path is
+	relative to `GIT_DIR`.  `git-daemon`[1] uses `git-daemon-export-ok`,
 	unless started with `--export-all`.  By default this variable is
 	not set, which means that this feature is turned off.
 
@@ -186,7 +186,7 @@ $export_auth_hook::
 	Function used to determine which repositories should be shown.
 	This subroutine should take one parameter, the full path to
 	a project, and if it returns true, that project will be included
-	in the projects list and can be accessed through gitweb as long
+	in the projects list and can be accessed through `gitweb` as long
 	as it fulfills the other requirements described by $export_ok,
 	$projects_list, and $projects_maxdepth.  Example:
 +
@@ -210,7 +210,7 @@ $strict_export::
 	This for example makes `$export_ok` file decide if repository is
 	available and not only if it is shown.  If `$projects_list` points to
 	file with list of project, only those repositories listed would be
-	available for gitweb.  Can be set during building gitweb via
+	available for `gitweb`.  Can be set during building `gitweb` via
 	`GITWEB_STRICT_EXPORT`.  By default this variable is not set, which
 	means that you can directly access those repositories that are hidden
 	from projects list page (e.g. the are not listed in the $projects_list
@@ -219,17 +219,17 @@ $strict_export::
 
 Finding files
 ~~~~~~~~~~~~~
-The following configuration variables tell gitweb where to find files.
+The following configuration variables tell `gitweb` where to find files.
 The values of these variables are paths on the filesystem.
 
 $GIT::
-	Core git executable to use.  By default set to `$GIT_BINDIR/git`, which
+	Core `git` executable to use.  By default set to `$GIT_BINDIR/git`, which
 	in turn is by default set to `$(bindir)/git`.  If you use Git installed
 	from a binary package, you should usually set this to "/usr/bin/git".
-	This can just be "git" if your web server has a sensible PATH; from
-	security point of view it is better to use absolute path to git binary.
+	This can just be `git` if your web server has a sensible PATH; from
+	security point of view it is better to use absolute path to `git` binary.
 	If you have multiple Git versions installed it can be used to choose
-	which one to use.  Must be (correctly) set for gitweb to be able to
+	which one to use.  Must be (correctly) set for `gitweb` to be able to
 	work.
 
 $mimetypes_file::
@@ -245,7 +245,7 @@ $highlight_bin::
 	http://www.andre-simon.de[] due to assumptions about parameters and output).
 	By default set to 'highlight'; set it to full path to highlight
 	executable if it is not installed on your web server's PATH.
-	Note that 'highlight' feature must be set for gitweb to actually
+	Note that 'highlight' feature must be set for `gitweb` to actually
 	use syntax highlighting.
 +
 *NOTE*: for a file to be highlighted, its syntax type must be detected
@@ -265,7 +265,7 @@ the highlight documentation and the default config at
 +
 For example if repositories you are hosting use "phtml" extension for
 PHP files, and you want to have correct syntax-highlighting for those
-files, you can add the following to gitweb configuration:
+files, you can add the following to `gitweb` configuration:
 +
 ---------------------------------------------------------
 our %highlight_ext;
@@ -275,7 +275,7 @@ $highlight_ext{'phtml'} = 'php';
 
 Links and their targets
 ~~~~~~~~~~~~~~~~~~~~~~~
-The configuration variables described below configure some of gitweb links:
+The configuration variables described below configure some of `gitweb` links:
 their target and their look (text or image), and where to find page
 prerequisites (stylesheet, favicon, images, scripts).  Usually they are left
 at their default values, with the possible exception of `@stylesheets`
@@ -285,32 +285,32 @@ variable.
 	List of URIs of stylesheets (relative to the base URI of a page). You
 	might specify more than one stylesheet, for example to use "gitweb.css"
 	as base with site specific modifications in a separate stylesheet
-	to make it easier to upgrade gitweb.  For example, you can add
+	to make it easier to upgrade `gitweb`.  For example, you can add
 	a `site` stylesheet by putting
 +
 ----------------------------------------------------------------------------
 push @stylesheets, "gitweb-site.css";
 ----------------------------------------------------------------------------
 +
-in the gitweb config file.  Those values that are relative paths are
-relative to base URI of gitweb.
+in the `gitweb` config file.  Those values that are relative paths are
+relative to base URI of `gitweb`.
 +
 This list should contain the URI of gitweb's standard stylesheet.  The default
-URI of gitweb stylesheet can be set at build time using the `GITWEB_CSS`
+URI of `gitweb` stylesheet can be set at build time using the `GITWEB_CSS`
 makefile variable.  Its default value is `static/gitweb.css`
 (or `static/gitweb.min.css` if the `CSSMIN` variable is defined,
 i.e. if CSS minifier is used during build).
 +
 *Note*: there is also a legacy `$stylesheet` configuration variable, which was
-used by older gitweb.  If `$stylesheet` variable is defined, only CSS stylesheet
-given by this variable is used by gitweb.
+used by older `gitweb`.  If `$stylesheet` variable is defined, only CSS stylesheet
+given by this variable is used by `gitweb`.
 
 $logo::
 	Points to the location where you put 'git-logo.png' on your web
 	server, or to be more the generic URI of logo, 72x27 size).  This image
-	is displayed in the top right corner of each gitweb page and used as
-	a logo for the Atom feed.  Relative to the base URI of gitweb (as a path).
-	Can be adjusted when building gitweb using `GITWEB_LOGO` variable
+	is displayed in the top right corner of each `gitweb` page and used as
+	a logo for the Atom feed.  Relative to the base URI of `gitweb` (as a path).
+	Can be adjusted when building `gitweb` using `GITWEB_LOGO` variable
 	By default set to `static/git-logo.png`.
 
 $favicon::
@@ -318,14 +318,14 @@ $favicon::
 	server, or to be more the generic URI of favicon, which will be served
 	as "image/png" type.  Web browsers that support favicons (website icons)
 	may display them in the browser's URL bar and next to the site name in
-	bookmarks.  Relative to the base URI of gitweb.  Can be adjusted at
+	bookmarks.  Relative to the base URI of `gitweb`.  Can be adjusted at
 	build time using `GITWEB_FAVICON` variable.
 	By default set to `static/git-favicon.png`.
 
 $javascript::
 	Points to the location where you put 'gitweb.js' on your web server,
-	or to be more generic the URI of JavaScript code used by gitweb.
-	Relative to the base URI of gitweb.  Can be set at build time using
+	or to be more generic the URI of JavaScript code used by `gitweb`.
+	Relative to the base URI of `gitweb`.  Can be set at build time using
 	the `GITWEB_JS` build-time configuration variable.
 +
 The default value is either `static/gitweb.js`, or `static/gitweb.min.js` if
@@ -341,7 +341,7 @@ $home_link::
 
 $home_link_str::
 	Label for the "home link" at the top of all pages, leading to `$home_link`
-	(usually the main gitweb page, which contains the projects list).  It is
+	(usually the main `gitweb` page, which contains the projects list).  It is
 	used as the first component of gitweb's "breadcrumb trail":
 	`<home link> / <project> / <action>`.  Can be set at build time using
 	the `GITWEB_HOME_LINK_STR` variable.  By default it is set to "projects",
@@ -351,8 +351,8 @@ $home_link_str::
 
 @extra_breadcrumbs::
 	Additional links to be added to the start of the breadcrumb trail before
-	the home link, to pages that are logically "above" the gitweb projects
-	list, such as the organization and department which host the gitweb
+	the home link, to pages that are logically "above" the `gitweb` projects
+	list, such as the organization and department which host the `gitweb`
 	server. Each element of the list is a reference to an array, in which
 	element 0 is the link text (equivalent to `$home_link_str`) and element
 	1 is the target URL (equivalent to `$home_link`).
@@ -377,17 +377,17 @@ $logo_label::
 
 Changing gitweb's look
 ~~~~~~~~~~~~~~~~~~~~~~
-You can adjust how pages generated by gitweb look using the variables described
+You can adjust how pages generated by `gitweb` look using the variables described
 below.  You can change the site name, add common headers and footers for all
-pages, and add a description of this gitweb installation on its main page
+pages, and add a description of this `gitweb` installation on its main page
 (which is the projects list page), etc.
 
 $site_name::
 	Name of your site or organization, to appear in page titles.  Set it
 	to something descriptive for clearer bookmarks etc.  If this variable
-	is not set or is, then gitweb uses the value of the `SERVER_NAME`
+	is not set or is, then `gitweb` uses the value of the `SERVER_NAME`
 	`CGI` environment variable, setting site name to "$SERVER_NAME Git",
-	or "Untitled Git" if this variable is not set (e.g. if running gitweb
+	or "Untitled Git" if this variable is not set (e.g. if running `gitweb`
 	as standalone script).
 +
 Can be set using the `GITWEB_SITENAME` at build time.  Unset by default.
@@ -411,7 +411,7 @@ $site_footer::
 
 $home_text::
 	Name of a HTML file which, if it exists, is included on the
-	gitweb projects overview page ("projects_list" view).  Relative to
+	`gitweb` projects overview page ("projects_list" view).  Relative to
 	the directory containing the gitweb.cgi script.  Default value
 	can be adjusted during build time using `GITWEB_HOMETEXT` variable.
 	By default set to 'indextext.html'.
@@ -437,7 +437,7 @@ Default value is "project".  Unknown value means unsorted.
 
 Changing gitweb's behavior
 ~~~~~~~~~~~~~~~~~~~~~~~~~~
-These configuration variables control _internal_ gitweb behavior.
+These configuration variables control _internal_ `gitweb` behavior.
 
 $default_blob_plain_mimetype::
 	Default mimetype for the blob_plain (raw) view, if mimetype checking
@@ -445,7 +445,7 @@ $default_blob_plain_mimetype::
 	Gitweb guesses mimetype of a file to display based on extension
 	of its filename, using `$mimetypes_file` (if set and file exists)
 	and `/etc/mime.types` files (see *mime.types*(5) manpage; only
-	filename extension rules are supported by gitweb).
+	filename extension rules are supported by `gitweb`).
 
 $default_text_plain_charset::
 	Default charset for text files. If this is not set, the web server
@@ -458,7 +458,7 @@ $fallback_encoding::
 	man page for a list. The default is "latin1", aka. "iso-8859-1".
 
 @diff_opts::
-	Rename detection options for git-diff and git-diff-tree. The default is
+	Rename detection options for `git-diff` and `git-diff-tree`. The default is
 	`('-M')`; set it to `('-C')` or `('-C', '-C')` to also detect copies,
 	or set it to `()` i.e. empty list if you don't want to have renames
 	detection.
@@ -472,9 +472,9 @@ involve file copies `('-C')` or criss-cross renames `('-B')`.
 Some optional features and policies
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 Most of features are configured via `%feature` hash; however some of extra
-gitweb features can be turned on and configured using variables described
-below.  This list beside configuration variables that control how gitweb
-looks does contain variables configuring administrative side of gitweb
+`gitweb` features can be turned on and configured using variables described
+below.  This list beside configuration variables that control how `gitweb`
+looks does contain variables configuring administrative side of `gitweb`
 (e.g. cross-site scripting prevention; admittedly this as side effect
 affects how "summary" pages look like, or load limiting).
 
@@ -493,7 +493,7 @@ composed from `@git_base_url_list` elements and project name.
 +
 You can setup one single value (single entry/item in this list) at build
 time by setting the `GITWEB_BASE_URL` build-time configuration variable.
-By default it is set to (), i.e. an empty list.  This means that gitweb
+By default it is set to (), i.e. an empty list.  This means that `gitweb`
 would not try to create project URL (to fetch) from project name.
 
 $projects_list_group_categories::
@@ -510,16 +510,16 @@ $project_list_default_category::
 	is true.  By default set to "" (empty string).
 
 $prevent_xss::
-	If true, some gitweb features are disabled to prevent content in
+	If true, some `gitweb` features are disabled to prevent content in
 	repositories from launching cross-site scripting (XSS) attacks.  Set this
 	to true if you don't trust the content of your repositories.
 	False by default (set to 0).
 
 $maxload::
-	Used to set the maximum load that we will still respond to gitweb queries.
-	If the server load exceeds this value then gitweb will return
+	Used to set the maximum load that we will still respond to `gitweb` queries.
+	If the server load exceeds this value then `gitweb` will return
 	"503 Service Unavailable" error.  The server load is taken to be 0
-	if gitweb cannot determine its value.  Currently it works only on Linux,
+	if `gitweb` cannot determine its value.  Currently it works only on Linux,
 	where it uses `/proc/loadavg`; the load there is the number of active
 	tasks on the system -- processes that are actually running -- averaged
 	over the last minute.
@@ -537,7 +537,7 @@ $omit_owner::
 $per_request_config::
 	If this is set to code reference, it will be run once for each request.
 	You can set parts of configuration that change per session this way.
-	For example, one might use the following code in a gitweb configuration
+	For example, one might use the following code in a `gitweb` configuration
 	file
 +
 --------------------------------------------------------------------------------
@@ -547,8 +547,8 @@ our $per_request_config = sub {
 --------------------------------------------------------------------------------
 +
 If `$per_request_config` is not a code reference, it is interpreted as boolean
-value.  If it is true gitweb will process config files once per request,
-and if it is false gitweb will process config files only once, each time it
+value.  If it is true `gitweb` will process config files once per request,
+and if it is false `gitweb` will process config files only once, each time it
 is executed.  True by default (set to 1).
 +
 *NOTE*: `$my_url`, `$my_uri`, and `$base_url` are overwritten with their default
@@ -556,50 +556,50 @@ values before every request, so if you want to change them, be sure to set
 this variable to true or a code reference effecting the desired changes.
 +
 This variable matters only when using persistent web environments that
-serve multiple requests using single gitweb instance, like mod_perl,
+serve multiple requests using single `gitweb` instance, like mod_perl,
 FastCGI or Plackup.
 
 
 Other variables
 ~~~~~~~~~~~~~~~
 Usually you should not need to change (adjust) any of configuration
-variables described below; they should be automatically set by gitweb to
+variables described below; they should be automatically set by `gitweb` to
 correct value.
 
 
 $version::
 	Gitweb version, set automatically when creating gitweb.cgi from
 	gitweb.perl. You might want to modify it if you are running modified
-	gitweb, for example
+	`gitweb`, for example
 +
 ---------------------------------------------------
 our $version .= " with caching";
 ---------------------------------------------------
 +
-if you run modified version of gitweb with caching support.  This variable
+if you run modified version of `gitweb` with caching support.  This variable
 is purely informational, used e.g. in the "generator" meta header in HTML
 header.
 
 $my_url::
 $my_uri::
-	Full URL and absolute URL of the gitweb script;
-	in earlier versions of gitweb you might have need to set those
+	Full URL and absolute URL of the `gitweb` script;
+	in earlier versions of `gitweb` you might have need to set those
 	variables, but now there should be no need to do it.  See
 	`$per_request_config` if you need to set them still.
 
 $base_url::
-	Base URL for relative URLs in pages generated by gitweb,
+	Base URL for relative URLs in pages generated by `gitweb`,
 	(e.g. `$logo`, `$favicon`, `@stylesheets` if they are relative URLs),
 	needed and used '<base href="$base_url">' only for URLs with nonempty
-	PATH_INFO.  Usually gitweb sets its value correctly,
+	PATH_INFO.  Usually `gitweb` sets its value correctly,
 	and there is no need to set this variable, e.g. to $my_uri or "/".
 	See `$per_request_config` if you need to override it anyway.
 
 
 CONFIGURING GITWEB FEATURES
 ---------------------------
-Many gitweb features can be enabled (or disabled) and configured using the
-`%feature` hash.  Names of gitweb features are keys of this hash.
+Many `gitweb` features can be enabled (or disabled) and configured using the
+`%feature` hash.  Names of `gitweb` features are keys of this hash.
 
 Each `%feature` hash element is a hash reference and has the following
 structure:
@@ -653,12 +653,12 @@ sub::
 	if this field is not present then per-repository override for
 	given feature is not supported.
 +
-You wouldn't need to ever change it in gitweb config file.
+You wouldn't need to ever change it in `gitweb` config file.
 
 
 Features in `%feature`
 ~~~~~~~~~~~~~~~~~~~~~~
-The gitweb features that are configurable via `%feature` hash are listed
+The `gitweb` features that are configurable via `%feature` hash are listed
 below.  This should be a complete list, but ultimately the authoritative
 and complete list is in gitweb.cgi source code, with features described
 in the comments.
@@ -680,7 +680,7 @@ snapshot::
 The value of \'default' is a list of names of snapshot formats,
 defined in `%known_snapshot_formats` hash, that you wish to offer.
 Supported formats include "tgz", "tbz2", "txz" (gzip/bzip2/xz
-compressed tar archive) and "zip"; please consult gitweb sources for
+compressed tar archive) and "zip"; please consult `gitweb` sources for
 a definitive list.  By default only "tgz" is offered.
 +
 This feature can be configured on a per-repository basis via
@@ -782,7 +782,7 @@ search::
 Project specific override is not supported.
 
 forks::
-	If this feature is enabled, gitweb considers projects in
+	If this feature is enabled, `gitweb` considers projects in
 	subdirectories of project root (basename) to be forks of existing
 	projects.  For each project +$projname.git+, projects in the
 	+$projname/+ directory and its subdirectories will not be
@@ -799,15 +799,15 @@ Project specific override is not supported.
 
 actions::
 	Insert custom links to the action bar of all project pages.  This
-	allows you to link to third-party scripts integrating into gitweb.
+	allows you to link to third-party scripts integrating into `gitweb`.
 +
 The "default" value consists of a list of triplets in the form
 `("<label>", "<link>", "<position>")` where "position" is the label
 after which to insert the link, "link" is a format string where `%n`
 expands to the project name, `%f` to the project path within the
 filesystem (i.e. "$projectroot/$project"), `%h` to the current hash
-(\'h' gitweb parameter) and `%b` to the current hash base
-(\'hb' gitweb parameter); `%%` expands to \'%'.
+(\'h' `gitweb` parameter) and `%b` to the current hash base
+(\'hb' `gitweb` parameter); `%%` expands to \'%'.
 +
 For example, at the time this page was written, the http://repo.or.cz[]
 Git hosting site set it to the following to enable graphical log
@@ -833,7 +833,7 @@ Project specific override is not supported.
 
 javascript-timezone::
 	Enable and configure the ability to change a common time zone for dates
-	in gitweb output via JavaScript.  Dates in gitweb output include
+	in `gitweb` output via JavaScript.  Dates in `gitweb` output include
 	authordate and committerdate in "commit", "commitdiff" and "log"
 	views, and taggerdate in "tag" view.  Enabled by default.
 +
@@ -843,7 +843,7 @@ where to store selected time zone, and a CSS class used to mark up
 dates for manipulation.  If you want to turn this feature off, set "default"
 to empty list: `[]`.
 +
-Typical gitweb config files will only change starting (default) time zone,
+Typical `gitweb` config files will only change starting (default) time zone,
 and leave other elements at their default values:
 +
 ---------------------------------------------------------------------------
@@ -854,7 +854,7 @@ The example configuration presented here is guaranteed to be backwards
 and forward compatible.
 +
 Time zone values can be "local" (for local time zone that browser uses), "utc"
-(what gitweb uses when JavaScript or this feature is disabled), or numerical
+(what `gitweb` uses when JavaScript or this feature is disabled), or numerical
 time zones in the form of "+/-HHMM", such as "+0200".
 +
 Project specific override is not supported.
@@ -883,7 +883,7 @@ space separated list of refs. An example:
 	extraBranchRefs = sandbox wip other
 --------------------------------------------------------------------------------
 +
-The gitweb.extraBranchRefs is actually a multi-valued configuration
+The `gitweb.extraBranchRefs` is actually a multi-valued configuration
 variable, so following example is also correct and the result is the
 same as of the snippet above:
 +
@@ -893,7 +893,7 @@ same as of the snippet above:
 	extraBranchRefs = wip other
 --------------------------------------------------------------------------------
 +
-It is an error to specify a ref that does not pass "git check-ref-format"
+It is an error to specify a ref that does not pass `git check-ref-format`
 scrutiny. Duplicated values are filtered.
 
 
@@ -919,7 +919,7 @@ If you allow overriding for the snapshot feature, you can specify which
 snapshot formats are globally disabled. You can also add any command-line
 options you want (such as setting the compression level). For instance, you
 can disable Zip compressed snapshots and set *gzip*(1) to run at level 6 by
-adding the following lines to your gitweb configuration file:
+adding the following lines to your `gitweb` configuration file:
 
 	$known_snapshot_formats{'zip'}{'disabled'} = 1;
 	$known_snapshot_formats{'tgz'}{'compressor'} = ['gzip','-6'];
diff --git a/Documentation/gitweb.txt b/Documentation/gitweb.txt
index ee6e6a30fd..1feb9c2b08 100644
--- a/Documentation/gitweb.txt
+++ b/Documentation/gitweb.txt
@@ -7,9 +7,9 @@ gitweb - Git web interface (web frontend to Git repositories)
 
 SYNOPSIS
 --------
-To get started with gitweb, run linkgit:git-instaweb[1] from a Git repository.
+To get started with `gitweb`, run linkgit:git-instaweb[1] from a Git repository.
 This would configure and start your web server, and run web browser pointing to
-gitweb.
+`gitweb`.
 
 
 DESCRIPTION
@@ -28,8 +28,8 @@ Gitweb provides a web interface to Git repositories.  Its features include:
   revisions one at a time, viewing the history of the repository.
 * Finding commits which commit messages matches given search term.
 
-See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for gitweb source code,
-browsed using gitweb itself.
+See http://repo.or.cz/w/git.git/tree/HEAD:/gitweb/[] for `gitweb` source code,
+browsed using `gitweb` itself.
 
 
 CONFIGURATION
@@ -51,22 +51,22 @@ our $projectroot = '/path/to/parent/directory';
 -----------------------------------------------------------------------
 
 The default value for `$projectroot` is `/pub/git`.  You can change it during
-building gitweb via `GITWEB_PROJECTROOT` build configuration variable.
+building `gitweb` via `GITWEB_PROJECTROOT` build configuration variable.
 
 By default all Git repositories under `$projectroot` are visible and available
 to gitweb.  The list of projects is generated by default by scanning the
 `$projectroot` directory for Git repositories (for object databases to be
-more exact; gitweb is not interested in a working area, and is best suited
+more exact; `gitweb` is not interested in a working area, and is best suited
 to showing "bare" repositories).
 
-The name of the repository in gitweb is the path to its `$GIT_DIR` (its object
+The name of the repository in `gitweb` is the path to its `$GIT_DIR` (its object
 database) relative to `$projectroot`.  Therefore the repository $repo can be
 found at "$projectroot/$repo".
 
 
 Projects list file format
 ~~~~~~~~~~~~~~~~~~~~~~~~~
-Instead of having gitweb find repositories by scanning filesystem
+Instead of having `gitweb` find repositories by scanning filesystem
 starting from $projectroot, you can provide a pre-generated list of
 visible projects by setting `$projects_list` to point to a plain text
 file with a list of projects (with some additional info).
@@ -113,13 +113,13 @@ By default this file controls only which projects are *visible* on projects
 list page (note that entries that do not point to correctly recognized Git
 repositories won't be displayed by gitweb).  Even if a project is not
 visible on projects list page, you can view it nevertheless by hand-crafting
-a gitweb URL.  By setting `$strict_export` configuration variable (see
+a `gitweb` URL.  By setting `$strict_export` configuration variable (see
 linkgit:gitweb.conf[5]) to true value you can allow viewing only of
 repositories also shown on the overview page (i.e. only projects explicitly
 listed in projects list file will be accessible).
 
 
-Generating projects list using gitweb
+Generating projects list using `gitweb`
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 We assume that GITWEB_CONFIG has its default Makefile value, namely
@@ -131,7 +131,7 @@ $projects_list = $projectroot;
 
 Then create the following script to get list of project in the format
 suitable for GITWEB_LIST build configuration variable (or
-`$projects_list` variable in gitweb config):
+`$projects_list` variable in `gitweb` config):
 
 ----------------------------------------------------------------------------
 #!/bin/sh
@@ -153,18 +153,18 @@ filename.
 Controlling access to Git repositories
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 By default all Git repositories under `$projectroot` are visible and
-available to gitweb.  You can however configure how gitweb controls access
+available to gitweb.  You can however configure how `gitweb` controls access
 to repositories.
 
 * As described in "Projects list file format" section, you can control which
 projects are *visible* by selectively including repositories in projects
-list file, and setting `$projects_list` gitweb configuration variable to
+list file, and setting `$projects_list` `gitweb` configuration variable to
 point to it.  With `$strict_export` set, projects list file can be used to
 control which repositories are *available* as well.
 
-* You can configure gitweb to only list and allow viewing of the explicitly
-exported repositories, via `$export_ok` variable in gitweb config file; see
-linkgit:gitweb.conf[5] manpage.  If it evaluates to true, gitweb shows
+* You can configure `gitweb` to only list and allow viewing of the explicitly
+exported repositories, via `$export_ok` variable in `gitweb` config file; see
+linkgit:gitweb.conf[5] manpage.  If it evaluates to true, `gitweb` shows
 repositories only if this file named by `$export_ok` exists in its object
 database (if directory has the magic file named `$export_ok`).
 +
@@ -176,7 +176,7 @@ is used) allows pulling only for those repositories that have
 our $export_ok = "git-daemon-export-ok";
 --------------------------------------------------------------------------
 +
-makes gitweb show and allow access only to those repositories that can be
+makes `gitweb` show and allow access only to those repositories that can be
 fetched from via `git://` protocol.
 
 * Finally, it is possible to specify an arbitrary perl subroutine that will
@@ -202,16 +202,16 @@ $export_auth_hook = sub {
 --------------------------------------------------------------------------
 
 
-Per-repository gitweb configuration
+Per-repository `gitweb` configuration
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-You can configure individual repositories shown in gitweb by creating file
+You can configure individual repositories shown in `gitweb` by creating file
 in the `GIT_DIR` of Git repository, or by setting some repo configuration
 variable (in `GIT_DIR/config`, see linkgit:git-config[1]).
 
 You can use the following files in repository:
 
 README.html::
-	A html file (HTML fragment) which is included on the gitweb project
+	A html file (HTML fragment) which is included on the `gitweb` project
 	"summary" page inside `<div>` block element. You can use it for longer
 	description of a project, to provide links (for example to project's
 	homepage), etc. This is recognized only if XSS prevention is off
@@ -251,7 +251,7 @@ cloneurl (or multiple-valued `gitweb.url`)::
 	takes precedence.
 +
 This is per-repository enhancement / version of global prefix-based
-`@git_base_url_list` gitweb configuration variable (see
+`@git_base_url_list` `gitweb` configuration variable (see
 linkgit:gitweb.conf[5]).
 
 gitweb.owner::
@@ -267,13 +267,13 @@ value from this file for given repository.
 
 various `gitweb.*` config variables (in config)::
 	Read description of `%feature` hash for detailed list, and descriptions.
-	See also "Configuring gitweb features" section in linkgit:gitweb.conf[5]
+	See also "Configuring `gitweb` features" section in linkgit:gitweb.conf[5]
 
 
 ACTIONS, AND URLS
 -----------------
 Gitweb can use path_info (component) based URLs, or it can pass all necessary
-information via query parameters.  The typical gitweb URLs are broken down in to
+information via query parameters.  The typical `gitweb` URLs are broken down in to
 five components:
 
 -----------------------------------------------------------------------
@@ -301,7 +301,7 @@ arguments::
 	Any arguments that control the behaviour of the action.
 
 Some actions require or allow to specify two revisions, and sometimes even two
-pathnames.  In most general form such path_info (component) based gitweb URL
+pathnames.  In most general form such path_info (component) based `gitweb` URL
 looks like this:
 
 -----------------------------------------------------------------------
@@ -311,7 +311,7 @@ looks like this:
 
 Each action is implemented as a subroutine, and must be present in %actions
 hash.  Some actions are disabled by default, and must be turned on via feature
-mechanism.  For example to enable 'blame' view add the following to gitweb
+mechanism.  For example to enable 'blame' view add the following to `gitweb`
 configuration file:
 
 -----------------------------------------------------------------------
@@ -398,7 +398,7 @@ WEBSERVER CONFIGURATION
 -----------------------
 This section explains how to configure some common webservers to run gitweb. In
 all cases, `/path/to/gitweb` in the examples is the directory you ran installed
-gitweb in, and contains `gitweb_config.perl`.
+`gitweb` in, and contains `gitweb_config.perl`.
 
 If you've configured a web server that isn't listed here for gitweb, please send
 in the instructions so they can be included in a future release.
@@ -406,7 +406,7 @@ in the instructions so they can be included in a future release.
 Apache as CGI
 ~~~~~~~~~~~~~
 Apache must be configured to support CGI scripts in the directory in
-which gitweb is installed.  Let's assume that it is `/var/www/cgi-bin`
+which `gitweb` is installed.  Let's assume that it is `/var/www/cgi-bin`
 directory.
 
 -----------------------------------------------------------------------
@@ -430,7 +430,7 @@ You can use mod_perl with gitweb.  You must install Apache::Registry
 (for mod_perl 1.x) or ModPerl::Registry (for mod_perl 2.x) to enable
 this support.
 
-Assuming that gitweb is installed to `/var/www/perl`, the following
+Assuming that `gitweb` is installed to `/var/www/perl`, the following
 Apache configuration (for mod_perl 2.x) is suitable.
 
 -----------------------------------------------------------------------
@@ -454,7 +454,7 @@ With that configuration the full path to browse repositories would be:
 Apache with FastCGI
 ~~~~~~~~~~~~~~~~~~~
 Gitweb works with Apache and FastCGI.  First you need to rename, copy
-or symlink gitweb.cgi to gitweb.fcgi.  Let's assume that gitweb is
+or symlink gitweb.cgi to gitweb.fcgi.  Let's assume that `gitweb` is
 installed in `/usr/share/gitweb` directory.  The following Apache
 configuration is suitable (UNTESTED!)
 
@@ -478,9 +478,9 @@ ADVANCED WEB SERVER SETUP
 All of those examples use request rewriting, and need `mod_rewrite`
 (or equivalent; examples below are written for Apache).
 
-Single URL for gitweb and for fetching
+Single URL for `gitweb` and for fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-If you want to have one URL for both gitweb and your `http://`
+If you want to have one URL for both `gitweb` and your `http://`
 repositories, you can configure Apache like this:
 
 -----------------------------------------------------------------------
@@ -503,11 +503,11 @@ repositories, you can configure Apache like this:
 
 The above configuration expects your public repositories to live under
 `/pub/git` and will serve them as `http://git.domain.org/dir-under-pub-git`,
-both as clonable Git URL and as browseable gitweb interface.  If you then
+both as clonable Git URL and as browseable `gitweb` interface.  If you then
 start your linkgit:git-daemon[1] with `--base-path=/pub/git --export-all`
 then you can even use the `git://` URL with exactly the same path.
 
-Setting the environment variable `GITWEB_CONFIG` will tell gitweb to use the
+Setting the environment variable `GITWEB_CONFIG` will tell `gitweb` to use the
 named file (i.e. in this example `/etc/gitweb.conf`) as a configuration for
 gitweb.  You don't really need it in above example; it is required only if
 your configuration file is in different place than built-in (during
@@ -516,7 +516,7 @@ linkgit:gitweb.conf[5] for details, especially information about precedence
 rules.
 
 If you use the rewrite rules from the example you *might* also need
-something like the following in your gitweb configuration file
+something like the following in your `gitweb` configuration file
 (`/etc/gitweb.conf` following example):
 ----------------------------------------------------------------------------
 @stylesheets = ("/some/absolute/path/gitweb.css");
@@ -524,14 +524,14 @@ $my_uri    = "/";
 $home_link = "/";
 $per_request_config = 1;
 ----------------------------------------------------------------------------
-Nowadays though gitweb should create HTML base tag when needed (to set base
+Nowadays though `gitweb` should create HTML base tag when needed (to set base
 URI for relative links), so it should work automatically.
 
 
 Webserver configuration with multiple projects' root
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
-If you want to use gitweb with several project roots you can edit your
-Apache virtual host and gitweb configuration files in the following way.
+If you want to use `gitweb` with several project roots you can edit your
+Apache virtual host and `gitweb` configuration files in the following way.
 
 The virtual host configuration (in Apache configuration file) should look
 like this:
@@ -572,9 +572,9 @@ like this:
 </VirtualHost>
 --------------------------------------------------------------------------
 
-Here actual project root is passed to gitweb via `GITWEB_PROJECT_ROOT`
+Here actual project root is passed to `gitweb` via `GITWEB_PROJECT_ROOT`
 environment variable from a web server, so you need to put the following
-line in gitweb configuration file (`/etc/gitweb.conf` in above example):
+line in `gitweb` configuration file (`/etc/gitweb.conf` in above example):
 --------------------------------------------------------------------------
 $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
 --------------------------------------------------------------------------
@@ -583,7 +583,7 @@ $projectroot = $ENV{'GITWEB_PROJECTROOT'} || "/pub/git";
 referenced by `$per_request_config`;
 
 These configurations enable two things. First, each unix user (`<user>`) of
-the server will be able to browse through gitweb Git repositories found in
+the server will be able to browse through `gitweb` Git repositories found in
 `~/public_git/` with the following url:
 
   http://git.example.org/~<user>/
@@ -603,11 +603,11 @@ the third and the fourth.
 
 PATH_INFO usage
 ~~~~~~~~~~~~~~~
-If you enable PATH_INFO usage in gitweb by putting
+If you enable PATH_INFO usage in `gitweb` by putting
 ----------------------------------------------------------------------------
 $feature{'pathinfo'}{'default'} = [1];
 ----------------------------------------------------------------------------
-in your gitweb configuration file, it is possible to set up your server so
+in your `gitweb` configuration file, it is possible to set up your server so
 that it consumes and produces URLs in the form
 
   http://git.example.com/project.git/shortlog/sometag
@@ -637,12 +637,12 @@ complementary static files (stylesheet, favicon, JavaScript):
 </VirtualHost>
 ----------------------------------------------------------------------------
 The rewrite rule guarantees that existing static files will be properly
-served, whereas any other URL will be passed to gitweb as PATH_INFO
+served, whereas any other URL will be passed to `gitweb` as PATH_INFO
 parameter.
 
 *Notice* that in this case you don't need special settings for
 `@stylesheets`, `$my_uri` and `$home_link`, but you lose "dumb client"
-access to your project .git dirs (described in "Single URL for gitweb and
+access to your project .git dirs (described in "Single URL for `gitweb` and
 for fetching" section).  A possible workaround for the latter is the
 following: in your project root dir (e.g. `/pub/git`) have the projects
 named *without* a .git extension (e.g. `/pub/git/project` instead of
@@ -677,7 +677,7 @@ cloned), while
 
   http://git.example.com/project
 
-will provide human-friendly gitweb access.
+will provide human-friendly `gitweb` access.
 
 This solution is not 100% bulletproof, in the sense that if some project has
 a named ref (branch, tag) starting with `git/`, then paths such as
diff --git a/Documentation/gitworkflows.txt b/Documentation/gitworkflows.txt
index 07344bf85a..fca6becf21 100644
--- a/Documentation/gitworkflows.txt
+++ b/Documentation/gitworkflows.txt
@@ -360,7 +360,7 @@ There are three main tools that can be used for this:
 
 * linkgit:git-pull[1] that does fetch and merge in one go.
 
-Note the last point.  Do 'not' use 'git pull' unless you actually want
+Note the last point.  Do 'not' use `git pull` unless you actually want
 to merge the remote branch.
 
 Getting changes out is easy:
@@ -397,7 +397,7 @@ Please pull from
     <url> <branch>
 -------------------------------------
 
-In that case, 'git pull' can do the fetch and merge in one go, as
+In that case, `git pull` can do the fetch and merge in one go, as
 follows.
 
 .Push/pull: Merging remote topics
@@ -449,7 +449,7 @@ problem.
 
 If you receive such a patch series (as maintainer, or perhaps as a
 reader of the mailing list it was sent to), save the mails to files,
-create a new topic branch and use 'git am' to import the commits:
+create a new topic branch and use `git am` to import the commits:
 
 .format-patch/am: Importing patches
 [caption="Recipe: "]
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 5d719b4140..8fef8db89d 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -53,7 +53,7 @@
 	In <<def_SCM,SCM>> jargon, "cherry pick" means to choose a subset of
 	changes out of a series of changes (typically commits) and record them
 	as a new series of changes on top of a different codebase. In Git, this is
-	performed by the "git cherry-pick" command to extract the change introduced
+	performed by the `git cherry-pick` command to extract the change introduced
 	by an existing <<def_commit,commit>> and to record it based on the tip
 	of the current <<def_branch,branch>> as a new commit.
 
@@ -308,8 +308,8 @@ This commit is referred to as a "merge commit", or sometimes just a
 [[def_pathspec]]pathspec::
 	Pattern used to limit paths in Git commands.
 +
-Pathspecs are used on the command line of "git ls-files", "git
-ls-tree", "git add", "git grep", "git diff", "git checkout",
+Pathspecs are used on the command line of `git ls-files`, `git
+ls-tree`, `git add`, `git grep`, `git diff`, `git checkout`,
 and many other commands to
 limit the scope of operations to some subset of the tree or
 worktree.  See the documentation of each command for whether
@@ -454,7 +454,7 @@ exclude;;
 [[def_pseudoref]]pseudoref::
 	Pseudorefs are a class of files under `$GIT_DIR` which behave
 	like refs for the purposes of rev-parse, but which are treated
-	specially by git.  Pseudorefs both have names that are all-caps,
+	specially by `git`.  Pseudorefs both have names that are all-caps,
 	and always start with a line consisting of a
 	<<def_SHA1,SHA-1>> followed by whitespace.  So, `HEAD` is not a
 	pseudoref, because it is sometimes a symbolic ref.  They might
diff --git a/Documentation/i18n.txt b/Documentation/i18n.txt
index 6c6baeeeb7..a6ef7155b8 100644
--- a/Documentation/i18n.txt
+++ b/Documentation/i18n.txt
@@ -34,7 +34,7 @@ project find it more convenient to use legacy encodings, Git
 does not forbid it.  However, there are a few things to keep in
 mind.
 
-. 'git commit' and 'git commit-tree' issues
+. `git commit` and `git commit-tree` issues
   a warning if the commit log message given to it does not look
   like a valid UTF-8 string, unless you explicitly say your
   project uses a legacy encoding.  The way to say this is to
@@ -50,7 +50,7 @@ of `i18n.commitEncoding` in its `encoding` header.  This is to
 help other people who look at them later.  Lack of this header
 implies that the commit log message is encoded in UTF-8.
 
-. 'git log', 'git show', 'git blame' and friends look at the
+. `git log`, `git show`, `git blame` and friends look at the
   `encoding` header of a commit object, and try to re-code the
   log message into UTF-8 unless otherwise specified.  You can
   specify the desired output encoding with
diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index bf43c33d27..6f6f31874b 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -112,8 +112,8 @@ With `--squash`, `--commit` is not allowed, and will fail.
 	Use the given merge strategy; can be supplied more than
 	once to specify them in the order they should be tried.
 	If there is no `-s` option, a built-in list of strategies
-	is used instead ('git merge-recursive' when merging a single
-	head, 'git merge-octopus' otherwise).
+	is used instead (`git merge-recursive` when merging a single
+	head, `git merge-octopus` otherwise).
 
 -X <option>::
 --strategy-option=<option>::
diff --git a/Documentation/pull-fetch-param.txt b/Documentation/pull-fetch-param.txt
index bbf418e48c..b062400072 100644
--- a/Documentation/pull-fetch-param.txt
+++ b/Documentation/pull-fetch-param.txt
@@ -58,7 +58,7 @@ namespace it's being fetched to, the type of object being fetched, and
 whether the update is considered to be a fast-forward. Generally, the
 same rules apply for fetching as when pushing, see the `<refspec>...`
 section of linkgit:git-push[1] for what those are. Exceptions to those
-rules particular to 'git fetch' are noted below.
+rules particular to `git fetch` are noted below.
 +
 Until Git version 2.20, and unlike when pushing with
 linkgit:git-push[1], any updates to `refs/tags/*` would be accepted
@@ -100,15 +100,15 @@ ifdef::git-pull[]
 +
 [NOTE]
 There is a difference between listing multiple <refspec>
-directly on 'git pull' command line and having multiple
+directly on `git pull` command line and having multiple
 `remote.<repository>.fetch` entries in your configuration
 for a <repository> and running a
-'git pull' command without any explicit <refspec> parameters.
+`git pull` command without any explicit <refspec> parameters.
 <refspec>s listed explicitly on the command line are always
 merged into the current branch after fetching.  In other words,
-if you list more than one remote ref, 'git pull' will create
+if you list more than one remote ref, `git pull` will create
 an Octopus merge.  On the other hand, if you do not list any
-explicit <refspec> parameter on the command line, 'git pull'
+explicit <refspec> parameter on the command line, `git pull`
 will fetch all the <refspec>s it finds in the
 `remote.<repository>.fetch` configuration and merge
 only the first <refspec> found into the current branch.
diff --git a/Documentation/revisions.txt b/Documentation/revisions.txt
index 33f30b62eb..f1bb9d0877 100644
--- a/Documentation/revisions.txt
+++ b/Documentation/revisions.txt
@@ -7,7 +7,7 @@ syntax.  Here are various ways to spell object names.  The
 ones listed near the end of this list name trees and
 blobs contained in a commit.
 
-NOTE: This document shows the "raw" syntax as seen by git. The shell
+NOTE: This document shows the "raw" syntax as seen by `git`. The shell
 and other UIs might require additional quoting to protect special
 characters and to avoid word splitting.
 
diff --git a/Documentation/urls-remotes.txt b/Documentation/urls-remotes.txt
index bd184cd653..25f89fa09a 100644
--- a/Documentation/urls-remotes.txt
+++ b/Documentation/urls-remotes.txt
@@ -11,7 +11,7 @@ of a URL as `<repository>` argument:
 * a file in the `$GIT_DIR/branches` directory.
 
 All of these also allow you to omit the refspec from the command line
-because they each contain a refspec which git will use by default.
+because they each contain a refspec which `git` will use by default.
 
 Named remote in configuration file
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
@@ -52,8 +52,8 @@ following format:
 
 ------------
 
-`Push:` lines are used by 'git push' and
-`Pull:` lines are used by 'git pull' and 'git fetch'.
+`Push:` lines are used by `git push` and
+`Pull:` lines are used by `git pull` and `git fetch`.
 Multiple `Push:` and `Pull:` lines may
 be specified for additional branch mappings.
 
@@ -72,18 +72,18 @@ This file should have the following format:
 
 `<url>` is required; `#<head>` is optional.
 
-Depending on the operation, git will use one of the following
+Depending on the operation, `git` will use one of the following
 refspecs, if you don't provide one on the command line.
 `<branch>` is the name of this file in `$GIT_DIR/branches` and
 `<head>` defaults to `master`.
 
-git fetch uses:
+`git fetch` uses:
 
 ------------
 	refs/heads/<head>:refs/heads/<branch>
 ------------
 
-git push uses:
+`git push` uses:
 
 ------------
 	HEAD:refs/heads/<head>
diff --git a/Documentation/urls.txt b/Documentation/urls.txt
index c50ddd3120..68ab4fbcc3 100644
--- a/Documentation/urls.txt
+++ b/Documentation/urls.txt
@@ -53,7 +53,7 @@ These two syntaxes are mostly equivalent, except the former implies
 `--local` option.
 endif::git-clone[]
 
-'git clone', 'git fetch' and 'git pull', but not 'git push', will also
+`git clone`, `git fetch` and `git pull`, but not `git push`, will also
 accept a suitable bundle file. See linkgit:git-bundle[1].
 
 When Git doesn't know how to handle a certain transport protocol, it
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 82b20b80df..4459d74ec2 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -6,7 +6,7 @@ This manual is designed to be readable by someone with basic UNIX
 command-line skills, but no previous knowledge of Git.
 
 <<repositories-and-branches>> and <<exploring-git-history>> explain how
-to fetch and study a project using git--read these chapters to learn how
+to fetch and study a project using `git`--read these chapters to learn how
 to build and test a particular version of a software project, search for
 regressions, and so on.
 
@@ -212,7 +212,7 @@ each parent representing the most recent commit on one of the lines
 of development leading to that point.
 
 The best way to see how this works is using the linkgit:gitk[1]
-command; running gitk now on a Git repository and looking for merge
+command; running `gitk` now on a Git repository and looking for merge
 commits will help understand how Git organizes history.
 
 In the following, we say that commit X is "reachable" from commit Y
@@ -313,7 +313,7 @@ do so (now or later) by using `-c` with the switch command again. Example:
 ------------------------------------------------
 
 The `HEAD` then refers to the SHA-1 of the commit instead of to a branch,
-and git branch shows that you are no longer on a branch:
+and `git branch` shows that you are no longer on a branch:
 
 ------------------------------------------------
 $ cat .git/HEAD
@@ -401,7 +401,7 @@ references with the same shorthand name, see the "SPECIFYING
 REVISIONS" section of linkgit:gitrevisions[7].
 
 [[Updating-a-repository-With-git-fetch]]
-=== Updating a repository with git fetch
+=== Updating a repository with `git fetch`
 
 After you clone a repository and commit a few changes of your own, you
 may wish to check the original repository for updates.
@@ -663,7 +663,7 @@ commits since v2.5 which touch the `Makefile` or any file under `fs`:
 $ git log v2.5.. Makefile fs/
 -------------------------------------------------
 
-You can also ask git log to show patches:
+You can also ask `git log` to show patches:
 
 -------------------------------------------------
 $ git log -p
@@ -672,7 +672,7 @@ $ git log -p
 See the `--pretty` option in the linkgit:git-log[1] man page for more
 display options.
 
-Note that git log starts with the most recent commit and works
+Note that `git log` starts with the most recent commit and works
 backwards through the parents; however, since Git history can contain
 multiple independent lines of development, the particular order that
 commits are listed in may be somewhat arbitrary.
@@ -1214,7 +1214,7 @@ you resolve the conflicts manually, you can update the index
 with the contents and run Git commit, as you normally would when
 creating a new file.
 
-If you examine the resulting commit using gitk, you will see that it
+If you examine the resulting commit using `gitk`, you will see that it
 has two parents, one pointing to the top of the current branch, and
 one to the top of the other branch.
 
@@ -1668,7 +1668,7 @@ dangling objects can arise in other situations.
 == Sharing development with others
 
 [[getting-updates-With-git-pull]]
-=== Getting updates with git pull
+=== Getting updates with `git pull`
 
 After you clone a repository and commit a few changes of your own, you
 may wish to check the original repository for updates and merge them
@@ -1857,7 +1857,7 @@ $ git clone --bare ~/proj proj.git
 $ touch proj.git/git-daemon-export-ok
 -------------------------------------------------
 
-The resulting directory proj.git contains a "bare" git repository--it is
+The resulting directory proj.git contains a "bare" `git` repository--it is
 just the contents of the `.git` directory, without any files checked out
 around it.
 
@@ -1879,7 +1879,7 @@ repository>>", below.
 Otherwise, all you need to do is start linkgit:git-daemon[1]; it will
 listen on port 9418.  By default, it will allow access to any directory
 that looks like a Git directory and contains the magic file
-git-daemon-export-ok.  Passing some directory paths as `git daemon`
+`git-daemon-export-ok`.  Passing some directory paths as `git daemon`
 arguments will further restrict the exports to those paths.
 
 You can also run `git daemon` as an inetd service; see the
@@ -1887,7 +1887,7 @@ linkgit:git-daemon[1] man page for details.  (See especially the
 examples section.)
 
 [[exporting-via-http]]
-==== Exporting a git repository via HTTP
+==== Exporting a `git` repository via HTTP
 
 The Git protocol gives better performance and reliability, but on a
 host with a web server set up, HTTP exports may be simpler to set up.
@@ -2064,13 +2064,13 @@ advantages over the central shared repository:
 [[setting-up-gitweb]]
 ==== Allowing web browsing of a repository
 
-The gitweb cgi script provides users an easy way to browse your
+The `gitweb` cgi script provides users an easy way to browse your
 project's revisions, file contents and logs without having to install
 Git. Features like RSS/Atom feeds and blame/annotation details may
 optionally be enabled.
 
 The linkgit:git-instaweb[1] command provides a simple way to start
-browsing the repository using gitweb. The default server when using
+browsing the repository using `gitweb`. The default server when using
 instaweb is lighttpd.
 
 See the file gitweb/INSTALL in the Git source tree and
@@ -2438,7 +2438,7 @@ use them, and then explain some of the problems that can arise because
 you are rewriting history.
 
 [[using-git-rebase]]
-=== Keeping a patch series up to date using git rebase
+=== Keeping a patch series up to date using `git rebase`
 
 Suppose that you create a branch `mywork` on a remote-tracking branch
 `origin`, and create some commits on top of it:
@@ -3132,7 +3132,7 @@ to a "pack file", which stores a group of objects in an efficient
 compressed format; the details of how pack files are formatted can be
 found in link:technical/pack-format.html[pack format].
 
-To put the loose objects into a pack, just run git repack:
+To put the loose objects into a pack, just run `git repack`:
 
 ------------------------------------------------
 $ git repack
-- 
2.31.1.133.g84d06cdc06

