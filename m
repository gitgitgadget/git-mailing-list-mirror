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
	by dcvr.yhbt.net (Postfix) with ESMTP id 40FE91F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727423AbfKOLLh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:37 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:35032 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726983AbfKOLLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:32 -0500
Received: by mail-wm1-f66.google.com with SMTP id 8so9960726wmo.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=J/ThBdvJZK/nfVxzRu1Ff9lOYtwZG13DRAmbmWz3qtE=;
        b=vdRhko+M/Ff6UPl+vj4QZFopU8PbhdQ6XR7Sm1/fPUNDkOeONjFgC0lXUG+4JopQfy
         e71XoS/RebJ03ztbNgPQWRLWgfMUgnSOlhvkcxm0NujrZk2OgK3ELx1Zc/oFCRxsBdOf
         lV2+6B/AgBCCN7QqD9NjZlGQIiSelxfWImwCH6t5s2JvPYNc/efBRmOtyQ9ZKw2Go71W
         SMfv2prBSpHf2k+Q93syws8FxMpr8xMfrgy/ctLo/p3hJTuwcWplBrQyi8isxzDWONJk
         +nP++vsNrtGh9FDbXY6TDrehsneaBpBuLkF7b0fmiIz16oS4/i3Z2rYU/pPJg6nkVyxV
         X2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=J/ThBdvJZK/nfVxzRu1Ff9lOYtwZG13DRAmbmWz3qtE=;
        b=mArdfSjddp8dh8xTAGHl/nE3Xs4reSDycyUtmbq3Wb4OZSEVz5NsWV8skyX1EoFXxL
         ug3zqb7pjIgemNRAL7xx4EDlyC5LUx8dagEZs4mV17x32NH9Ful0ELtmL4XgMO22bfuD
         BPTMLQ4zoo1LFJrL3wCuWkOW5JIgpCB2ubqk3W5XDE7GAMkgDVWFsVo3EOTOyO+WxS7G
         X5HV87U4+hANRLvnnLXC/DAhiwrqhjNU0JIKjGPKEeHDSuNeaG2uPrSyaZ7hRtpuePF0
         MHYCCt6SOtJfMafBqkVINka5YCOD40UrNt3rgT+HAOdRxQ2HJteccF93oBX9tNIN0n7P
         KDPQ==
X-Gm-Message-State: APjAAAVHHGRzjBej6VW1IPJu2s+LZQYTZxo4oGT4aUqZTevlhT8Hmw2D
        fCChEKgjgSFrvMqiRYRNxLwHgP2R
X-Google-Smtp-Source: APXvYqyM6oXWJDcGpA34VGiHJIQIdW0Zkm3uTbOk7qK2UV6mwGih0sKNjta6zDlWjHmS/hA3BX1zjg==
X-Received: by 2002:a05:600c:cf:: with SMTP id u15mr10534775wmm.60.1573816288835;
        Fri, 15 Nov 2019 03:11:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm10354301wrq.51.2019.11.15.03.11.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:28 -0800 (PST)
Message-Id: <ccc6fb45580e1c07b143d1a55d9518c13ac3c032.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:20 +0000
Subject: [PATCH v7 9/9] built-in add -i: implement the `help` command
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
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
index 170a5800e3..d6cb98cd40 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -508,6 +508,26 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
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
@@ -561,6 +581,7 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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
