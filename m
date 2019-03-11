Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 983DF20248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728394AbfCKT5k (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:57:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42186 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729142AbfCKT5i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:57:38 -0400
Received: by mail-ed1-f67.google.com with SMTP id j89so323775edb.9
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 12:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4DJ0Ejxc4eibebzMN0+GbYCUS1mPnr+WLph8m7lNW4Y=;
        b=iqz0HZJE2Zyi+9cwT3m3F2+gAtXT6t/lXTdVVLDDPV4zU5gM6ZyrvUngBEkzvxhzUj
         +lIBZvzEQfxIwqOwog4LdyrvBHyHG4Zl2tUKWvlHtraF/Bx6YM6uLbbyns6nag80ieSZ
         6Hn2J4f+8MTwjqedxUH9SkhEeTN7jY7r4Mnyyyrsftp/MIQg9bSXiaxQk0WEL+z8ZMcK
         QIwbkWXNvrSEFelT/KSqQhSyi46YewNXfRCYyTGeP2qIw0wii55y0vayvUnvIxjVmNG9
         /xdN9k17eIRvaeW7gkYVzN9J7I05ZZf9Wu4JYJxRLoGKoNa5FSFGcHtfJsImKhe2xBX6
         F+bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4DJ0Ejxc4eibebzMN0+GbYCUS1mPnr+WLph8m7lNW4Y=;
        b=VgzRoKMdmnboPpaEtTj2tcgfTyb/xnBaKNXLcm5+lLJzDun5ZrT1NwlmrpPwTBPCPu
         mtvdPKo3uDnfLmTSDcD72S3WynTIna2ULJ+ov6oZSkuPrKl8AWBGz1+QZW2CPtvMJPvH
         31SKkGLk8IecTV5Abn9Esked5FIX2uqZUHsiYuY473tiokhwD3kzX17cBxp2pYhmMDmQ
         8+XmJbDfacvGye0ewzg23wdVL5q8EDVGsXevWBSwT6Z6ow7B3gXQITNOz4PCFdPYSaW4
         O1LVVUI+JsjVErXUB9kSzmP2zQMgs+MupwFvap3LDN4etXmmL1aHPZoQDQhk9yJcU1xr
         p50g==
X-Gm-Message-State: APjAAAWuRim5st0vWyYyJMbs44Xp37j82rQSeodbLyrRefH/2QvKhBgy
        3MnLJxS9DoNBcSsT0ihbrI/8VaAh
X-Google-Smtp-Source: APXvYqzNhtaNvQrT3JEyhYX8+LK0vPNvy2ywYfKknaez/UqVxMY1lLRtEsVLkVIUc+C7pbCEkuQXZg==
X-Received: by 2002:a17:906:5583:: with SMTP id y3mr22955881ejp.42.1552334256503;
        Mon, 11 Mar 2019 12:57:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s3sm5010529edm.78.2019.03.11.12.57.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Mar 2019 12:57:35 -0700 (PDT)
Date:   Mon, 11 Mar 2019 12:57:35 -0700 (PDT)
X-Google-Original-Date: Mon, 11 Mar 2019 19:57:34 GMT
Message-Id: <f6990f28c028e04c5d237878d7fbb2160dd7dac9.1552334254.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.158.v2.git.gitgitgadget@gmail.com>
References: <pull.158.git.gitgitgadget@gmail.com>
        <pull.158.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 1/1] rebase: deprecate --preserve-merges
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We have something much better now: --rebase-merges (which is a
complete re-design --preserve-merges, with a lot of issues fixed such as
the inability to reorder commits with --preserve-merges).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config/branch.txt |  6 +++---
 Documentation/config/pull.txt   |  6 +++---
 Documentation/git-rebase.txt    | 23 ++++++++++++-----------
 builtin/rebase.c                |  8 ++++++--
 4 files changed, 24 insertions(+), 19 deletions(-)

diff --git a/Documentation/config/branch.txt b/Documentation/config/branch.txt
index 019d60ede2..8f4b3faadd 100644
--- a/Documentation/config/branch.txt
+++ b/Documentation/config/branch.txt
@@ -85,9 +85,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When preserve, also pass `--preserve-merges` along to 'git rebase'
-so that locally committed merge commits will not be flattened
-by running 'git pull'.
+When `preserve` (deprecated in favor of `merges`), also pass
+`--preserve-merges` along to 'git rebase' so that locally committed merge
+commits will not be flattened by running 'git pull'.
 +
 When the value is `interactive`, the rebase is run in interactive mode.
 +
diff --git a/Documentation/config/pull.txt b/Documentation/config/pull.txt
index bb23a9947d..b87cab31b3 100644
--- a/Documentation/config/pull.txt
+++ b/Documentation/config/pull.txt
@@ -18,9 +18,9 @@ When `merges`, pass the `--rebase-merges` option to 'git rebase'
 so that the local merge commits are included in the rebase (see
 linkgit:git-rebase[1] for details).
 +
-When preserve, also pass `--preserve-merges` along to 'git rebase'
-so that locally committed merge commits will not be flattened
-by running 'git pull'.
+When `preserve` (deprecated in favor of `merges`), also pass
+`--preserve-merges` along to 'git rebase' so that locally committed merge
+commits will not be flattened by running 'git pull'.
 +
 When the value is `interactive`, the rebase is run in interactive mode.
 +
diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index 6363d674b7..44e00329e1 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -415,9 +415,9 @@ i.e. commits that would be excluded by linkgit:git-log[1]'s
 the `rebase-cousins` mode is turned on, such commits are instead rebased
 onto `<upstream>` (or `<onto>`, if specified).
 +
-The `--rebase-merges` mode is similar in spirit to `--preserve-merges`, but
-in contrast to that option works well in interactive rebases: commits can be
-reordered, inserted and dropped at will.
+The `--rebase-merges` mode is similar in spirit to the deprecated
+`--preserve-merges`, but in contrast to that option works well in interactive
+rebases: commits can be reordered, inserted and dropped at will.
 +
 It is currently only possible to recreate the merge commits using the
 `recursive` merge strategy; Different merge strategies can be used only via
@@ -427,9 +427,10 @@ See also REBASING MERGES and INCOMPATIBLE OPTIONS below.
 
 -p::
 --preserve-merges::
-	Recreate merge commits instead of flattening the history by replaying
-	commits a merge commit introduces. Merge conflict resolutions or manual
-	amendments to merge commits are not preserved.
+	[DEPRECATED: use `--rebase-merges` instead] Recreate merge commits
+	instead of flattening the history by replaying commits a merge commit
+	introduces. Merge conflict resolutions or manual amendments to merge
+	commits are not preserved.
 +
 This uses the `--interactive` machinery internally, but combining it
 with the `--interactive` option explicitly is generally not a good
@@ -1020,11 +1021,11 @@ merge cmake
 
 BUGS
 ----
-The todo list presented by `--preserve-merges --interactive` does not
-represent the topology of the revision graph.  Editing commits and
-rewording their commit messages should work fine, but attempts to
-reorder commits tend to produce counterintuitive results. Use
-`--rebase-merges` in such scenarios instead.
+The todo list presented by the deprecated `--preserve-merges --interactive`
+does not represent the topology of the revision graph (use `--rebase-merges`
+instead).  Editing commits and rewording their commit messages should work
+fine, but attempts to reorder commits tend to produce counterintuitive results.
+Use `--rebase-merges` in such scenarios instead.
 
 For example, an attempt to rearrange
 ------------
diff --git a/builtin/rebase.c b/builtin/rebase.c
index 52114cbf0d..21ac10f739 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -1100,8 +1100,8 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 			PARSE_OPT_NOARG | PARSE_OPT_NONEG,
 			parse_opt_interactive },
 		OPT_SET_INT('p', "preserve-merges", &options.type,
-			    N_("try to recreate merges instead of ignoring "
-			       "them"), REBASE_PRESERVE_MERGES),
+			    N_("(DEPRECATED) try to recreate merges instead of "
+			       "ignoring them"), REBASE_PRESERVE_MERGES),
 		OPT_BOOL(0, "rerere-autoupdate",
 			 &options.allow_rerere_autoupdate,
 			 N_("allow rerere to update index with resolved "
@@ -1212,6 +1212,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_rebase_usage,
 				   builtin_rebase_options);
 
+	if (options.type == REBASE_PRESERVE_MERGES)
+		warning(_("git rebase --preserve-merges is deprecated. "
+			  "Use --rebase-merges instead."));
+
 	if (action != NO_ACTION && !in_progress)
 		die(_("No rebase in progress?"));
 	setenv(GIT_REFLOG_ACTION_ENVIRONMENT, "rebase", 0);
-- 
gitgitgadget
