Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D36E41F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727122AbfKMMlU (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:41:20 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45228 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbfKMMlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:17 -0500
Received: by mail-wr1-f68.google.com with SMTP id z10so2161143wrs.12
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 04:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=SLSLERb7FwFIpJnZS+6b/KR3EsGAx05ogZeZUg2uv1s=;
        b=qBPYdDJuXgnCokzdbKfEHplCzLucK909kVbTHTXNL88/1B43WLyCH62/WdoQs2XpB9
         9LQA2Bct4ykwRzE0b57xvyF6WQmkyOuizuY7t7HbEsv9rflKy+0k00VDUBZGGnXqLazV
         1ptdT99zOcK7Ds0ArofNF+hMQk8vOhS9qCVwpqzwHwQKomdDhhs9/0z/yyF5YPBajmv5
         d/JJjDjOs5NzckFdjQoeK5QDtgQJbbKX5jjNsU6/lbvJRt5zC5WNKzuUoN+9GK21XXUS
         X5O51ZllYKmnAemB3VnILmFL+bfYkHKh8BuiHAryCIbZFF7jH023+CpwqKtjcZ5UBxSJ
         eRoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=SLSLERb7FwFIpJnZS+6b/KR3EsGAx05ogZeZUg2uv1s=;
        b=S/VWj1g4TYx4XSGmRwhSTystPkAUek4b3V8csKMYeM2ovNydJduekV3YDfLuOd5ROA
         yESmsp8C5zPnW87Excz7fmpURmWkq2xZsL1sVLXsE8zOerGrkEU2T8CHlyxJZ7/VRFk1
         uqUQyBy870k91DETnWNkEThH4KjlLU9wLuO6Zh0brGcbz88R7SFm2newxsy5fyPlUZ/m
         o14I9SWL1C47GfZpDW0dvXtijDxmPTZRmTxrOBm2hVlaWB1tXsGrU5FdWsr3VxTPh4h6
         rwC+AnpPhwJ+hZdHi0ait4Qng/zmcuDXLGlAajFL2/eaUg0F2F5Kq8NtUGXVYrjEIbIk
         wpcg==
X-Gm-Message-State: APjAAAX1Akl5j9Q9mVwpDwAEHGU1ej1ykuqcaZgmTQOKiZZZliHkgglf
        AOycKA/gyQegUetGrxYueoCgSf6y
X-Google-Smtp-Source: APXvYqwu1xE/4yZhNi/ZVjxqt7nvXuGqMmtDNcf0pbW6fqM9B5nsSFLjBDxki8HZ84WGkwqceZXkXw==
X-Received: by 2002:adf:9c81:: with SMTP id d1mr2567846wre.144.1573648875003;
        Wed, 13 Nov 2019 04:41:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 65sm3618254wrs.9.2019.11.13.04.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 04:41:14 -0800 (PST)
Message-Id: <7fda76255a82dbc92dc7861d51767ef275422788.1573648866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:41:05 +0000
Subject: [PATCH v6 9/9] built-in add -i: implement the `help` command
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
index 8f5531c86c..5d89863bab 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -507,6 +507,26 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
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
@@ -560,6 +580,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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
