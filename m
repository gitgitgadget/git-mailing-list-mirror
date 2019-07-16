Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D295F1F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388005AbfGPO6w (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:52 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:36752 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387994AbfGPO6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:47 -0400
Received: by mail-wr1-f67.google.com with SMTP id n4so21358734wrs.3
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/vrdwaYMIwjQJadcnnwXePUyP9n70TLg2CWxh6QvDuQ=;
        b=lBE5PD27JuXGDfkfSft+HAHPHrEdkmZCgaMYgPy6ux/cL7RGTLlRW9v5zpO0/Rn9+5
         BWueld4XESGt5qO9r3sZbBeykp6Na2AjF3oqiCxG65z8EOTMdY2HvSdBFlfFFJA10T96
         n6xqL/0hgmIbNrbGwntx6hf7ht4bdAjMr0+WB0RpxIZPPlziuaLyTiz1IQ20+ofcmKsF
         GjsSwuiESMRl6oZGzyc4b6OKSOB5VuvWjhlNAy6thfP5BjYi5YyGhvg4QN2WnNGE87OP
         sEfKCDQfku9ly/p6DA1sfxKTzDCrQfJWYpzYUpEgF2DuYJozNCK/lZk3eXaeZRP1IzWT
         kYVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/vrdwaYMIwjQJadcnnwXePUyP9n70TLg2CWxh6QvDuQ=;
        b=LXgT3pQF7kCzMhubXZRKXzwp/L1aX240UzCtoBuJW7O+spgbYLkJCJDtqIJzUY1zii
         Ub1/zn1JdKgjNf5ZFPuHjhRvD4sFXGnfXMokI7JEE4QZS4NX3HHy8faYvEnKQOaL8TSo
         XujEQjeVlOZXHBEaQhdmIy2P1/464DKH+oGrdCwHSMOWCRwEaReylUs5syrG4Qf4/HgV
         HzBlnB9FXp3KV1VB9Zrn4e9cBZj4FSxuncYItdTb7cOdmU2FLUjKsqpLeo9MLSS+KG7e
         UJvBTOkBiTAPcM69IHFWsFs9p5H9kornWTk5k+td0heQgG6XyI/aHUiFzfoXagPlAjGD
         EZPw==
X-Gm-Message-State: APjAAAWbw1FYVSHQnxE/pzLF7VUrJ8bzp5Ig2BDRIddOSMNA7u9w+GGS
        GqCLCMVaQqBCoZL1xGcOit/NXv5w
X-Google-Smtp-Source: APXvYqyI69qS+RUdbFOc7bpoMFsIqQJoRv0tmmpLiiVKmrsFx1cURXiM/purmtw6/4aQ+qub1B+cbw==
X-Received: by 2002:a5d:498a:: with SMTP id r10mr36840117wrq.28.1563289125489;
        Tue, 16 Jul 2019 07:58:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q1sm17347132wmq.25.2019.07.16.07.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:45 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:45 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:35 GMT
Message-Id: <db70c6475d85dd77385d773274fa390fa7ed08c0.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/11] built-in add -i: implement the `help` command
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This imitates the code to show the help text from the Perl script
`git-add--interactive.perl` in the built-in version.

To make sure that it renders exactly like the Perl version of `git add
-i`, we also add a test case for that to `t3701-add-interactive.sh`.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c          | 27 +++++++++++++++++++++++++--
 t/t3701-add-interactive.sh | 25 +++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 538658dfa7..c431c72e3f 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -428,6 +428,27 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+static int run_help(struct add_i_state *s, const struct pathspec *ps,
+		    struct file_list *files, struct list_options *opts)
+{
+	const char *help_color = s->help_color;
+
+	color_fprintf_ln(stdout, help_color, "status        - %s",
+			 _("show paths with changes"));
+	color_fprintf_ln(stdout, help_color, "update        - %s",
+			 _("add working tree state to the staged set of changes"));
+	color_fprintf_ln(stdout, help_color, "revert        - %s",
+			 _("revert staged set of changes back to the HEAD version"));
+	color_fprintf_ln(stdout, help_color, "patch         - %s",
+			 _("pick hunks and update selectively"));
+	color_fprintf_ln(stdout, help_color, "diff          - %s",
+			 _("view diff between HEAD and index"));
+	color_fprintf_ln(stdout, help_color, "add untracked - %s",
+			 _("add contents of untracked files to the staged set of changes"));
+
+	return 0;
+}
+
 struct print_command_item_data {
 	const char *color, *reset;
 };
@@ -473,9 +494,11 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 		N_("What now"), command_prompt_help
 	};
 	struct command_item
-		status = { { "status" }, run_status };
+		status = { { "status" }, run_status },
+		help = { { "help" }, run_help };
 	struct command_item *commands[] = {
-		&status
+		&status,
+		&help
 	};
 
 	struct print_file_item_data print_file_item_data = {
diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
index 69991a3168..cf67756b85 100755
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
