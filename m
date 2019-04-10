Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B3120248
	for <e@80x24.org>; Wed, 10 Apr 2019 17:38:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbfDJRiI (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Apr 2019 13:38:08 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:36664 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729660AbfDJRiC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Apr 2019 13:38:02 -0400
Received: by mail-ed1-f65.google.com with SMTP id u57so2151679edm.3
        for <git@vger.kernel.org>; Wed, 10 Apr 2019 10:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=DtjJwGlqWAmz2GQrgZaQ3BoKO9TUM2pqgcQ4qFfHgU4=;
        b=TBwa9gUOF6LtDyXhhUqekuxVI0vlf2EK39KcXPJX+qhFwdT8kDRkY9BX/DRUodjKqv
         JmaUgwbAUn8fd8GIdL73qyxl4nLAdY2mApHTZGI0Jz3AiuUQJTFoVrXP0iioWNHyM0/h
         lNgsZcvOLzfJ17RQuPRzaltRpyHThLueuTrpY+RXelxuEQ2WBHUJ8zQS4VltuQ0O8+2s
         VtQctEPU4kW0YotmyrUQhTUcei7E5gtzuOD7Q0i3Q9TH18b7uIzJWFJrV5knwhyKTVnE
         brxHFyll8Ac43jtHe6cMC1/8L7scKWvOXrWCRluKNTNXdCXr3O9t78qdsmo6Pyp7BAZ4
         uY3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=DtjJwGlqWAmz2GQrgZaQ3BoKO9TUM2pqgcQ4qFfHgU4=;
        b=HopR/4VpikEMNNGcyUe2mi0uyxzJEQzjFfrl9R/TlSgD1nNbCygqnBJUJA33DZI1e6
         jswFIdPlN6pQHkLeYq7inWl3+VvFT+bZsDX9Jd8SW86ErzgVRR/Lh6l7KVvAIG7lzwuc
         +cKIpA2PUFvL3v7bo/RFDHmNIvIDBjwaeNe3m2AJmccx0t7Yk9e2eOJhi1NVvvRqgfE3
         4uwW5DGJOEtVv9xVZ8mfdU/wUROoPxjWNTN935MLpQUVUoUI13w9l9D3i2U2YQXA3acu
         kCQAXWoIVRFuswnAQ9l+TCKWs84QZ8q/hJcEbxkKrRmZLkanLFZwtzru1sH8TVrStI7z
         BsdA==
X-Gm-Message-State: APjAAAWotI04X7WYRrKVc/CGWFmJEeWT1IG7vZiDxi9bK/Rsmx6niH/L
        c7MIot1DIG2fftpduFBjJGsaxKOT
X-Google-Smtp-Source: APXvYqy4AHajVaCAemCWpsc2xUT22FnPeunQAtq4meIJtO/0MYrho6pLVMMOZ6nX6OlF9fNJs6BHkA==
X-Received: by 2002:a17:906:4c45:: with SMTP id d5mr4623296ejw.133.1554917879868;
        Wed, 10 Apr 2019 10:37:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 10sm1119144ejn.37.2019.04.10.10.37.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 10:37:59 -0700 (PDT)
Date:   Wed, 10 Apr 2019 10:37:59 -0700 (PDT)
X-Google-Original-Date: Wed, 10 Apr 2019 17:37:48 GMT
Message-Id: <481e3316d5a2486dbfef32fca9e096a8eb9a64ee.1554917868.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 11/11] built-in add -i: implement the `help` command
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

This imitates the code to show the help text from the Perl script
`git-add--interactive.perl` in the built-in version.

To make sure that it renders exactly like the Perl version of `git add
-i`, we also add a test case for that to `t3701-add-interactive.sh`.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c          | 27 +++++++++++++++++++++++++--
 t/t3701-add-interactive.sh | 24 ++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index a1550d9b9f..a6baf57e20 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -439,6 +439,27 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 	return 0;
 }
 
+static int run_help(struct repository *r, const struct pathspec *ps,
+		    struct file_list *files, struct list_options *opts)
+{
+	const char *help_color = get_add_i_color(COLOR_HELP);
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
@@ -490,9 +511,11 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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
index 65dfbc033a..91aaef2932 100755
--- a/t/t3701-add-interactive.sh
+++ b/t/t3701-add-interactive.sh
@@ -639,4 +639,28 @@ test_expect_success 'add -p patch editing works with pathological context lines'
 	test_cmp expected-2 actual
 '
 
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
