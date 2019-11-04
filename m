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
	by dcvr.yhbt.net (Postfix) with ESMTP id 45B641F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbfKDMPp (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:45 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37741 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728713AbfKDMPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:41 -0500
Received: by mail-wr1-f67.google.com with SMTP id t1so10867439wrv.4
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=jkoX4BSraB5J7HguuB4qp/jaTlS4oYRdTv4MEN5DTlQ=;
        b=GI364TdtXdtK+8JkS7SyCUpRyAUAFSzFWFlpY1jyZhZ5jhNuMftkCrn3eYRSBrvPws
         HRTJcZwySKR63JmYM/H03s3IN3RenDOcWn0CIqnRP/sTPR0HEa4OwlGEjdncyRUB3nil
         a0Oy9gVbg4rZd7vUnixu8EkPO19ypbh8QuvkExzju7/3RvitaSDoEOGW0SadzA9O150g
         XTxCJfn4GDj/l/RiuTE2vAxBhEnDdmuQp3ob3RAU+Hbf559cdVnMljTBIMAoYFLSumh/
         ZZfj2sEb1+s2RlTx1emhuWMpmRnsTajFDeLuXWKYc7URa24iLe3dW6Bi+Fd7hN08/o4J
         Smgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=jkoX4BSraB5J7HguuB4qp/jaTlS4oYRdTv4MEN5DTlQ=;
        b=EI1LRPBSBoZVjerTt0PbUqqvPcb0ENtYh/gMxzF22Y7V5rulaj2ae5lFU6RFh2CUJv
         cpelg9iPslTTKYEkXPUmx5zDRyZiQ74AlS+7JEdiF9GGna2uWvE9cf+W7i/G1VnCfdLU
         c9/x+yRp6a/tUwKOOKqCz/J4IfiMJoQ+AA4mrqTVbIDUe025qyMGzV8eEDJAZIhMrbB0
         hUkuh2Iwl3LU1xnkDeCly8/UzrZfWD8TsPnBcrWXuGC6vHvAIEASFLD67TajVm6gD7BJ
         XC31fM5mOWIGD/1rAW3lIxL1EjdA5qOycYfzhDpfA35PiiUNxUUd0431xrhSLY+mgYj0
         wCSA==
X-Gm-Message-State: APjAAAWdXHQYKeYHUES/xjngcLBWVpA9MRT5QX43wS2iM/Lc6aKFm6l5
        qqQOeFIjhCmMcbKgJQvpPqtEMLKT
X-Google-Smtp-Source: APXvYqxprdnNMmprjomYOJXRCFIgbKM3Mq7XziPGoqL03mMG8Q6f2VBIbijePSXfSkwemV34W5eROw==
X-Received: by 2002:a5d:4585:: with SMTP id p5mr1957122wrq.134.1572869739425;
        Mon, 04 Nov 2019 04:15:39 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm17629384wmy.2.2019.11.04.04.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:39 -0800 (PST)
Message-Id: <85e508ef119658c154da35482095a4f0f15adc80.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:29 +0000
Subject: [PATCH v5 9/9] built-in add -i: implement the `help` command
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Slavica=20=C4=90uki=C4=87?= <slawica92@hotmail.com>

This imitates the code to show the help text from the Perl script
`git-add--interactive.perl` in the built-in version.

To make sure that it renders exactly like the Perl version of `git add
-i`, we also add a test case for that to `t3701-add-interactive.sh`.

Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c          | 21 +++++++++++++++++++++
 t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
 2 files changed, 46 insertions(+)

diff --git a/add-interactive.c b/add-interactive.c
index 64d84ba1dc..4e5241e865 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -506,6 +506,26 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+static int run_help(struct add_i_state *s, const struct pathspec *unused_ps,
+		    struct string_list *unused_files,
+		    struct list_options *unused_opts)
+{
+	color_fprintf_ln(stdout, s->help_color, "status        - %s",
+			 _("show paths with changes"));
+	color_fprintf_ln(stdout, s->help_color, "update        - %s",
+			 _("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, s->help_color, "revert        - %s",
+			 _("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, s->help_color, "patch         - %s",
+			 _("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, s->help_color, "diff          - %s",
+			 _("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, s->help_color, "add untracked - %s",
+			 _("add contents of untracked files to the staged set of changes"));
+
+	return 0;
+}
+
 typedef int (*command_t)(struct add_i_state *s, const struct pathspec *ps,
 			 struct string_list *files,
 			 struct list_options *opts);
@@ -559,6 +579,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		command_t command;
 	} command_list[] = {
 		{ "status", run_status },
+		{ "help", run_help },
 	};
 	struct prefix_item_list commands = PREFIX_ITEM_LIST_INIT;
 
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index d50e165ca8..d4f9386621 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -647,4 +647,29 @@ test_expect_success 'checkout -p works with pathological context lines' '
 	test_write_lines a b a b a a b a b a >expect &&
 	test_cmp expect a
 '
+
+test_expect_success 'show help from add--helper' '
+	git reset --hard &&
+	cat >expect <<-EOF &&
+
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>> <BOLD;RED>status        - show paths with changes<RESET>
+	<BOLD;RED>update        - add working tree state to the staged set of changes<RESET>
+	<BOLD;RED>revert        - revert staged set of changes back to the HEAD version<RESET>
+	<BOLD;RED>patch         - pick hunks and update selectively<RESET>
+	<BOLD;RED>diff          - view diff between HEAD and index<RESET>
+	<BOLD;RED>add untracked - add contents of untracked files to the staged set of changes<RESET>
+	<BOLD>*** Commands ***<RESET>
+	  1: <BOLD;BLUE>s<RESET>tatus	  2: <BOLD;BLUE>u<RESET>pdate	  3: <BOLD;BLUE>r<RESET>evert	  4: <BOLD;BLUE>a<RESET>dd untracked
+	  5: <BOLD;BLUE>p<RESET>atch	  6: <BOLD;BLUE>d<RESET>iff	  7: <BOLD;BLUE>q<RESET>uit	  8: <BOLD;BLUE>h<RESET>elp
+	<BOLD;BLUE>What now<RESET>>$SP
+	Bye.
+	EOF
+	test_write_lines h | GIT_PAGER_IN_USE=true TERM=vt100 git add -i >actual.colored &&
+	test_decode_color <actual.colored >actual &&
+	test_i18ncmp expect actual
+'
+
 test_done
-- 
gitgitgadget
