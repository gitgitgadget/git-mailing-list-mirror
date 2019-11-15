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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A9441F5A2
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727418AbfKOLLh (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:37 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:35029 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727405AbfKOLLc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:32 -0500
Received: by mail-wm1-f67.google.com with SMTP id 8so9960678wmo.0
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=ZzD7HLCe9ogUhhI8uAm1ka3xBsd9+mk/T6bC4qKaApk=;
        b=s0JagqcdxzjUUpBY30NzbvIa8bx6EyaWrHDQgrvtx9QBwyPo0iQ/2gC2DnqkrNQkkS
         lSJFXgLkTf8O4X3rYv5xDBW3HUbflq8gvIUD3C5pawfw7mqVJKs1v0DWm4mPhJmBHSC3
         Eebp/BKpfq+e60YQUe8UUUaYwYDVkzEHzj+FJO40ZrzuhXh9ZfmOBLOG7PtmqMEPl4Iq
         hSzzzp2RBnCWMvj55yEyh+CxODUBpfpdsSvql6KdYz1Ac4YCskoLEqfwfDpUV57h82hn
         dPw4ehyuRTAc1Sm+0YOw5o+3WZmzYY/eLZdY6eCZtoe6jeBgz5HznNF13W8p9hXD7cRi
         reZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=ZzD7HLCe9ogUhhI8uAm1ka3xBsd9+mk/T6bC4qKaApk=;
        b=OwfJDq5062kypqJNnyXuJOBEEZKkgJcCJhBlvBpdCTBsKIy25PGt8+oo9HDu29KtOA
         WVWD5NSKbayjmOq32lbB4VU13DisXxSbOtnCknDrEuRr2e4rXGgyj+J3nQHLQgPrQzrv
         GfjXXRGPpcx0SMOQPqrUtamjvZxTHYd2s5sqhg+vwWERnX6joP2kre+wJr45HVuZbPe1
         z4HSZP/FQLhwIFi6A98GzKJa6gdGUQogB/1OwKHQX42ZDbQ+ZI3pQ6nKaW21Vo+wLvYM
         l4vGXtgankeQeTfBSNdeqY7AvVxINkYCHQpRwzPUVIgFowRm9RRnJqJnqjpgkJhcH7k9
         MKXA==
X-Gm-Message-State: APjAAAVKJanSHjOG5rVbb37xkRAVYoPc6fTXbbqBbFQ24fk+E2cqc7Wu
        ptc0Z0JoKidvStJJvJ7Cj50xPR1Y
X-Google-Smtp-Source: APXvYqzFZGdr3uIF/vHqE6xHoT2zx0K9R9cVPORCyF2Ql+2S8/LMWHUOdDxKZE0wqNOZX0rcsvMAhQ==
X-Received: by 2002:a05:600c:299:: with SMTP id 25mr14692902wmk.50.1573816288128;
        Fri, 15 Nov 2019 03:11:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a11sm9818384wmh.40.2019.11.15.03.11.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:27 -0800 (PST)
Message-Id: <bcf4aa7c5e2e64f1c6a57d4a5860474818de7b79.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:19 +0000
Subject: [PATCH v7 8/9] built-in add -i: use color in the main loop
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

The error messages as well as the unique prefixes are colored in `git
add -i` by default; We need to do the same in the built-in version.

Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 0a03b9017d..170a5800e3 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -12,6 +12,9 @@ struct add_i_state {
 	int use_color;
 	char header_color[COLOR_MAXLEN];
 	char help_color[COLOR_MAXLEN];
+	char prompt_color[COLOR_MAXLEN];
+	char error_color[COLOR_MAXLEN];
+	char reset_color[COLOR_MAXLEN];
 };
 
 static void init_color(struct repository *r, struct add_i_state *s,
@@ -45,6 +48,9 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 
 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
 	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
+	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
 }
 
 /*
@@ -240,7 +246,8 @@ static ssize_t list_and_choose(struct add_i_state *s,
 
 		list(s, &items->items, &opts->list_opts);
 
-		printf("%s%s", opts->prompt, "> ");
+		color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
+		fputs("> ", stdout);
 		fflush(stdout);
 
 		if (strbuf_getline(&input, stdin) == EOF) {
@@ -283,7 +290,8 @@ static ssize_t list_and_choose(struct add_i_state *s,
 				index = find_unique(p, items);
 
 			if (index < 0 || index >= items->items.nr)
-				printf(_("Huh (%s)?\n"), p);
+				color_fprintf_ln(stdout, s->error_color,
+						 _("Huh (%s)?"), p);
 			else {
 				res = index;
 				break;
@@ -509,18 +517,23 @@ struct command_item {
 	command_t command;
 };
 
+struct print_command_item_data {
+	const char *color, *reset;
+};
+
 static void print_command_item(int i, struct string_list_item *item,
 			       void *print_command_item_data)
 {
+	struct print_command_item_data *d = print_command_item_data;
 	struct command_item *util = item->util;
 
 	if (!util->prefix_length ||
 	    !is_valid_prefix(item->string, util->prefix_length))
 		printf(" %2d: %s", i + 1, item->string);
 	else
-		printf(" %2d: [%.*s]%s", i + 1,
-		       (int)util->prefix_length, item->string,
-		       item->string + util->prefix_length);
+		printf(" %2d: %s%.*s%s%s", i + 1,
+		       d->color, (int)util->prefix_length, item->string,
+		       d->reset, item->string + util->prefix_length);
 }
 
 static void command_prompt_help(struct add_i_state *s)
@@ -538,8 +551,9 @@ static void command_prompt_help(struct add_i_state *s)
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
 	struct add_i_state s = { NULL };
+	struct print_command_item_data data = { "[", "]" };
 	struct list_and_choose_options main_loop_opts = {
-		{ 4, N_("*** Commands ***"), print_command_item, NULL },
+		{ 4, N_("*** Commands ***"), print_command_item, &data },
 		N_("What now"), command_prompt_help
 	};
 	struct {
@@ -570,6 +584,15 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 
 	init_add_i_state(&s, r);
 
+	/*
+	 * When color was asked for, use the prompt color for
+	 * highlighting, otherwise use square brackets.
+	 */
+	if (s.use_color) {
+		data.color = s.prompt_color;
+		data.reset = s.reset_color;
+	}
+
 	strbuf_addstr(&header, "      ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
-- 
gitgitgadget

