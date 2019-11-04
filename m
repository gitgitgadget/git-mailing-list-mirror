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
	by dcvr.yhbt.net (Postfix) with ESMTP id F17401F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfKDMPn (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:43 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33864 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728619AbfKDMPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:41 -0500
Received: by mail-wr1-f65.google.com with SMTP id e6so14957465wrw.1
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=fIjZABpx2ohEMwxZDJXzfAERtcrwofElrO0Wc6s98eY=;
        b=QR6dNGKdLf9wlUpJfXGpQRjnFJXZh8Ypm7sjlouEI193gw9fwl5MsKAF7uYCzIiXns
         DDM+XCJbMlYJtmYRrgNQQ900nj1jd3YR5gyJCfF5N/JOLezSlugBgb3OYU/f6Xpln0lt
         /keCKsy8Im1mQuHEaFD6vL1UdIp/pe7C1F+aXF+YsLs+7OB6VWZRV/GYkhZ06jtU7hCu
         JJmjvQaPay5cOd6M83Wpdno5cptWJh0LClXUeO/JToWa3mTBvXXg6oeOD2+j+mC6eoBo
         /QIWBoGl83V2+FeI/FpVs5JgtBnVbbpwOp9LlOMHl1qoJCLAwExhQPk+4ZLlYAX7Ipei
         Uv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=fIjZABpx2ohEMwxZDJXzfAERtcrwofElrO0Wc6s98eY=;
        b=fSDqEAJlO/WmUWV4/GsojEkMc58A9BSiOHhrjmI4KCUFF49aHiFhqk0pv8Rui9fuAm
         pFksPpN68m9r5fTIxy8SacL363RB9Omt2KLrp9aWNoDYy649yBVbIcVczXt/DCjDw0jL
         lyT+/9VxRxN+3yTuP3sTUwRU3KrrUWPxqox0+NG8yXW+a7WCZahbq6lW9OiO/m4r9g4e
         CCLx4mzvGBCgrvOglBbtzHmILSaWr/yAkrBIrsjsQb/NlPq6dd6JG++OoUhf7bRott6x
         0GwkdnQVevUAF7K1iCeY6TQkHPZ/ACM3oWU49yutpfki9F2lT2/VplG+Xb1xxapbQxFS
         Byag==
X-Gm-Message-State: APjAAAWaz8wssLWq0gMIzxo7lMEK1RsEYF5mw+Fi8l2YDqJIaIb5EOaf
        +zlMR6MBT2MeLYw00QunwlijUi9t
X-Google-Smtp-Source: APXvYqyFf7PWEeeWUQ7DgI6KPPkvWnsWlxTUL/WJ6fz7K0tDQ1BIYeRXm6VZ459nZEUBkgIXzKnp/g==
X-Received: by 2002:adf:c50a:: with SMTP id q10mr15369560wrf.374.1572869738739;
        Mon, 04 Nov 2019 04:15:38 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s13sm15782953wmc.28.2019.11.04.04.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:38 -0800 (PST)
Message-Id: <3d0b172a7f863fe079b77589a6410b228dcaba96.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:28 +0000
Subject: [PATCH v5 8/9] built-in add -i: use color in the main loop
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

The error messages as well as the unique prefixes are colored in `git
add -i` by default; We need to do the same in the built-in version.

Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index d96e18fce5..64d84ba1dc 100644
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
@@ -281,7 +288,8 @@ static ssize_t list_and_choose(struct add_i_state *s,
 				index = find_unique(p, items);
 
 			if (index < 0 || index >= items->items.nr)
-				printf(_("Huh (%s)?\n"), p);
+				color_fprintf_ln(stdout, s->error_color,
+						 _("Huh (%s)?"), p);
 			else {
 				res = index;
 				break;
@@ -507,18 +515,23 @@ struct command_item {
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
@@ -536,8 +549,9 @@ static void command_prompt_help(struct add_i_state *s)
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
@@ -568,6 +582,15 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 
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

