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
	by dcvr.yhbt.net (Postfix) with ESMTP id 56F1D1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729971AbfH0M6G (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:06 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:54491 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfH0M6E (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:04 -0400
Received: by mail-wm1-f67.google.com with SMTP id p74so2979987wme.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6ED/rVKnKuuq7jmLirz2DCfUlaGHF0yH6WNO+b8BtLo=;
        b=ZgSQyV0gh+dS4ZD4L/10VUSgjgnjluVIVgSgioXNFNUOiHe5U5Dz18TlpUAU+nfHqD
         WNA+8NjX2DGqSiMPmCzgVQMjwTdWRv0Jt/W4xYJxkMWex4gAV2deWb3Be6uuuBr0c8eB
         ilBjBEgGqFedyFxvVG0KJTkDjkNsWujc0uCnG0i7plsjRq8kWxIe4PmbRUh8kFuDPFvn
         OPoFqdnTuwv+JN8k/GeL3sYXhTvBUGkXlk6p6R2JAilCO4Kvxtnft6stlDmIjXJCpdVI
         +Dua1TYmp2QLavK7IbhWplEOEvTdPJMqYt8E5NV1bw6NP4Zjvy/C7YoD2qLkL3USPWTd
         0yRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6ED/rVKnKuuq7jmLirz2DCfUlaGHF0yH6WNO+b8BtLo=;
        b=Bvo1x5KQj9HO5qkzMIky7WY5odHOCxWrM8StFKuPcGT1BWmLF0sOqpHEWF5a6k557m
         DxdBr8KtIuG2MucnCUX7Yk/zAz1ZVbn1BHt70E7eO8AJs8/LCixt9uWzQIMRgsvgZ+NW
         9ubgwP2stQ187R4QLrz3kg6zdRveFptX1pjAwjdnS9vlbZvSEj7pnzS7NPujVY/c84Q+
         g5Ao0dtyRI9DnbJsPwFcTlUHyhzzwFabpd1QREPkYyxs3z3KPZnLxX/CKEUe0xfyG+1n
         H4JPttQPjxaGa31abnDx7FyMllmnBUyUlPy9Hm/7T8H8CHGQmmD7bNmy898BGlipCvmA
         QHxQ==
X-Gm-Message-State: APjAAAXwwGgUdRDado7rLGbmI/nQ3lNZvjF9zXeNByvnlXLEWZN/DzXD
        jri80Evai8VlOMvFo+kJxabqXe0PY8w=
X-Google-Smtp-Source: APXvYqwiJ2iPCy1b0A1GfI7JYtZ95zEnOWLXW/SkKUcnheLh0g8m5h6MMm4vjRIX7ZgS0H3YdUEvXQ==
X-Received: by 2002:a1c:7dc8:: with SMTP id y191mr29048725wmc.78.1566910681582;
        Tue, 27 Aug 2019 05:58:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm2216847wmc.24.2019.08.27.05.58.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:58:01 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:58:01 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:51 GMT
Message-Id: <88001009bc00b10856141cb689d31400a68b7df3.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 10/11] built-in add -i: use color in the main loop
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Slavica Djukic <slawica92@hotmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Slavica Djukic <slawica92@hotmail.com>

The error messages as well as the unique prefixes are colored in `git
add -i` by default; We need to do the same in the built-in version.

Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 710317e599..a343195a67 100644
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
@@ -45,6 +48,9 @@ static int init_add_i_state(struct repository *r, struct add_i_state *s)
 
 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
 	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s, "prompt", s->prompt_color, GIT_COLOR_BOLD_BLUE);
+	init_color(r, s, "error", s->error_color, GIT_COLOR_BOLD_RED);
+	init_color(r, s, "reset", s->reset_color, GIT_COLOR_RESET);
 
 	return 0;
 }
@@ -134,7 +140,8 @@ static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 
 		list(items, nr, s, &opts->list_opts);
 
-		printf("%s%s", opts->prompt, "> ");
+		color_fprintf(stdout, s->prompt_color, "%s", opts->prompt);
+		fputs("> ", stdout);
 		fflush(stdout);
 
 		if (strbuf_getline(&input, stdin) == EOF) {
@@ -175,7 +182,8 @@ static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 				index = find_unique(p, items, nr);
 
 			if (index < 0 || index >= nr)
-				printf(_("Huh (%s)?\n"), p);
+				color_fprintf_ln(stdout, s->error_color,
+						 _("Huh (%s)?"), p);
 			else {
 				res = index;
 				break;
@@ -421,15 +429,21 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	return 0;
 }
 
+struct print_command_item_data {
+	const char *color, *reset;
+};
+
 static void print_command_item(int i, struct prefix_item *item,
 			       void *print_command_item_data)
 {
+	struct print_command_item_data *d = print_command_item_data;
+
 	if (!item->prefix_length ||
 	    !is_valid_prefix(item->name, item->prefix_length))
 		printf(" %2d: %s", i + 1, item->name);
 	else
-		printf(" %3d: [%.*s]%s", i + 1,
-		       (int)item->prefix_length, item->name,
+		printf(" %2d: %s%.*s%s%s", i + 1,
+		       d->color, (int)item->prefix_length, item->name, d->reset,
 		       item->name + item->prefix_length);
 }
 
@@ -454,8 +468,9 @@ static void command_prompt_help(struct add_i_state *s)
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
 	struct add_i_state s = { NULL };
+	struct print_command_item_data data;
 	struct list_and_choose_options main_loop_opts = {
-		{ 4, N_("*** Commands ***"), print_command_item, NULL },
+		{ 4, N_("*** Commands ***"), print_command_item, &data },
 		N_("What now"), command_prompt_help
 	};
 	struct command_item
@@ -478,6 +493,18 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	if (init_add_i_state(r, &s))
 		return error("could not parse `add -i` config");
 
+	/*
+	 * When color was asked for, use the prompt color for
+	 * highlighting, otherwise use square brackets.
+	 */
+	if (s.use_color) {
+		data.color = s.prompt_color;
+		data.reset = s.reset_color;
+	} else {
+		data.color = "[";
+		data.reset = "]";
+	}
+
 	strbuf_addstr(&header, "      ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
-- 
gitgitgadget

