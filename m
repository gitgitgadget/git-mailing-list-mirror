Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4FF1202BB
	for <e@80x24.org>; Thu, 14 Mar 2019 11:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727286AbfCNLZI (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Mar 2019 07:25:08 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40652 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbfCNLZH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Mar 2019 07:25:07 -0400
Received: by mail-ed1-f68.google.com with SMTP id r23so4267114edm.7
        for <git@vger.kernel.org>; Thu, 14 Mar 2019 04:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qxBbwpZtFh52JXVvfU/nmTSvIHgnFZm+hFSiGVY2MSs=;
        b=XJVe+3izz5UV95ezkft0/2qczcfAfeIl/wmtc56tZqBu+81qMEMsxRlNCVLfJRINGh
         +TasJfr6bdwFqR6u2PXZWbPuHzy04RMY0ohZnbtObKGQ0vyZbuxmgm656a1wCHM9GXq9
         sRKXjCiTM8C7aO9nO1sqkKbjYy+0W+UL1A327gGsH05lo3KDLBWkXRomRIIwuz0fVvPV
         XJYv+U1gW/H/o5M5iFWKOWCN1mi87pKfuXoGGeroGoPSxay2CGdhMWg/Z8tTpLBpBJh7
         mWyiwAc1HykCvaQp3Tn5cFAO8b4ilY0OgsCpNbjmCWiQkNyZe2sANUduTWHambgx86dv
         Vwog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qxBbwpZtFh52JXVvfU/nmTSvIHgnFZm+hFSiGVY2MSs=;
        b=egnlfVsRZ5BeI3+mUUU6n8sDwLt++iYuRSkGiqUZNN4qAV9l3pRZ6upWC9xkljBJdL
         bQOh2xb/LfqT4S88A0Tf2D/tDrkwfCGAKI54aNcPQqKUC1yXo8jCQGwXhORKWYzModaE
         6lryb5I+uj0DfJR6h/xeBFv1t9tv008NzbeiEu8WGjMAn1Q24RH2da6DP32EjjnYMJqS
         mE3PQ1NL8X8oOzpLUA1h1CNAyjrIgQvLLT6oOhgzMJQhT4wccfa2nVSQEAN6ZBt2akd+
         X73q+fvXvosqxLOZljMgiw2fo5hReoo9DNglBGlEGxxpQHAiqKZqy/7rXx0s5FUg1XNe
         V26w==
X-Gm-Message-State: APjAAAXnQpig7HgIP1fge34mNeKaqKdz7RYNNxWTgVgKZudIV1zObfI2
        MfxZUMKM1jVBqtjnQBpSsDxoW9vz
X-Google-Smtp-Source: APXvYqzdDJN8Fk6SFZnXX5h5byNHY6ZolCKLHEx2VjCa4uZF5VZ66h3ScuJcVgIPqdNGe8CVT0wTzg==
X-Received: by 2002:a17:906:4c82:: with SMTP id q2mr455472eju.215.1552562705643;
        Thu, 14 Mar 2019 04:25:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d17sm1024672ejm.35.2019.03.14.04.25.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 04:25:04 -0700 (PDT)
Date:   Thu, 14 Mar 2019 04:25:04 -0700 (PDT)
X-Google-Original-Date: Thu, 14 Mar 2019 11:25:01 GMT
Message-Id: <8cca9f800c2ce269a2ae644e4c15dc4115d3b0e2.1552562701.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.163.v2.git.gitgitgadget@gmail.com>
References: <pull.163.git.gitgitgadget@gmail.com>
        <pull.163.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] difftool: allow running outside Git worktrees with
 --no-index
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

As far as this developer can tell, the conversion from a Perl script to
a built-in caused the regression in the difftool that it no longer runs
outside of a Git worktree (with `--no-index`, of course).

It is a bit embarrassing that it took over two years after retiring the
Perl version to discover this regression, but at least we now know, and
can do something, about it.

This fixes https://github.com/git-for-windows/git/issues/2123

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/difftool.c  | 13 ++++++++++---
 git.c               |  2 +-
 t/t7800-difftool.sh | 10 ++++++++++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/builtin/difftool.c b/builtin/difftool.c
index 31eece0c8d..4fff1e83f9 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -690,7 +690,7 @@ static int run_file_diff(int prompt, const char *prefix,
 int cmd_difftool(int argc, const char **argv, const char *prefix)
 {
 	int use_gui_tool = 0, dir_diff = 0, prompt = -1, symlinks = 0,
-	    tool_help = 0;
+	    tool_help = 0, no_index = 0;
 	static char *difftool_cmd = NULL, *extcmd = NULL;
 	struct option builtin_difftool_options[] = {
 		OPT_BOOL('g', "gui", &use_gui_tool,
@@ -714,6 +714,7 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 			    "tool returns a non - zero exit code")),
 		OPT_STRING('x', "extcmd", &extcmd, N_("command"),
 			   N_("specify a custom command for viewing diffs")),
+		OPT_ARGUMENT("no-index", &no_index, N_("passed to `diff`")),
 		OPT_END()
 	};
 
@@ -727,8 +728,14 @@ int cmd_difftool(int argc, const char **argv, const char *prefix)
 	if (tool_help)
 		return print_tool_help();
 
-	setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
-	setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+	if (!no_index && !startup_info->have_repository)
+		die(_("difftool requires worktree or --no-index"));
+
+	if (!no_index){
+		setup_work_tree();
+		setenv(GIT_DIR_ENVIRONMENT, absolute_path(get_git_dir()), 1);
+		setenv(GIT_WORK_TREE_ENVIRONMENT, absolute_path(get_git_work_tree()), 1);
+	}
 
 	if (use_gui_tool && diff_gui_tool && *diff_gui_tool)
 		setenv("GIT_DIFF_TOOL", diff_gui_tool, 1);
diff --git a/git.c b/git.c
index 2014aab6b8..46365ed86a 100644
--- a/git.c
+++ b/git.c
@@ -491,7 +491,7 @@ static struct cmd_struct commands[] = {
 	{ "diff-files", cmd_diff_files, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "diff-index", cmd_diff_index, RUN_SETUP | NO_PARSEOPT },
 	{ "diff-tree", cmd_diff_tree, RUN_SETUP | NO_PARSEOPT },
-	{ "difftool", cmd_difftool, RUN_SETUP | NEED_WORK_TREE },
+	{ "difftool", cmd_difftool, RUN_SETUP_GENTLY },
 	{ "fast-export", cmd_fast_export, RUN_SETUP },
 	{ "fetch", cmd_fetch, RUN_SETUP },
 	{ "fetch-pack", cmd_fetch_pack, RUN_SETUP | NO_PARSEOPT },
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index bb9a7f4ff9..480dd0633f 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -705,4 +705,14 @@ test_expect_success SYMLINKS 'difftool --dir-diff handles modified symlinks' '
 	test_cmp expect actual
 '
 
+test_expect_success 'outside worktree' '
+	echo 1 >1 &&
+	echo 2 >2 &&
+	test_expect_code 1 nongit git \
+		-c diff.tool=echo -c difftool.echo.cmd="echo \$LOCAL \$REMOTE" \
+		difftool --no-prompt --no-index ../1 ../2 >actual &&
+	echo "../1 ../2" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
