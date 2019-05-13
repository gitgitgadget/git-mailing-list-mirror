Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	UNWANTED_LANGUAGE_BODY shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 160251F461
	for <e@80x24.org>; Mon, 13 May 2019 17:28:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731734AbfEMR2G (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:28:06 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:41819 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731680AbfEMR2E (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:28:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id m4so18674585edd.8
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tmPfGYqL+lfGw92CHugkAF+zx/YMo+COjgbZPSOyQWE=;
        b=Lyl50dyBHCjmSjF5Tc9vnyDtLLLYWPDurNyVo6EJwYn4O7JUdq9KZdp/xACLPW5Ry/
         W2xhXZAWGh6yhxZPxsEaRSCIXlM44ZLy9OHp4QnIEMKzkQHWKdNzBrpMo3KsY+rj39UE
         0JXEvS9JSG6L8l4JeUb65sPoJokt8UtveOEFd86gYXH+5tpHrOuNYFeLUnnoLAHrCHN3
         Wqo/sCO1Urio+OSYnrE3gpBXeJo8Tt3/Y8wdb7PmKnLSFU/Mz914LI1O+2YE1qVFijZC
         hrXOK0mWZ7P12YvVlTsxPk0eYVzy+K6+ogguvM3wQSsCd8jzgNVBXw8Ja1L2Vargw1bM
         C0gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tmPfGYqL+lfGw92CHugkAF+zx/YMo+COjgbZPSOyQWE=;
        b=gfw0XL6N/zj1zbD7MUymHYaMO7UHt1y4XLPncpHAiB9IwbYCQKI37jSSSOpMLbtBVz
         k8FIiFjODHPoN5M9r5GqQqt85TIh5TuWhT7/m6D5pYJ5HTee/bJ0RWrPwDqHmN7eKuhy
         slKtzAWryBhfmb4MeFDFjZ0N6vOBeE5jnosPmPy0/EC2oHaFCo4IKWKg5pZYcdmsuuJN
         8KCTY3UhZSvIYtCCrrBU8fvOMcIXKfH+iJVb/iAT1ior7ZK4wlgunDLiruCWhSkzN1Pq
         SPc24x7chOhEFDB+//fVEOlrsJdfRLpenqJIexKskguPXVHxAIvWxA7QRhHtVQbsL1Ku
         fk3A==
X-Gm-Message-State: APjAAAUdTUIMyy07WSF7WbFA3gs9YvKxaLLiQ4e6EFYVX3MV/rAsdKS4
        CTyF3+dXvGapHA4tQEtLXs0iqjRp
X-Google-Smtp-Source: APXvYqwmqgRkMM9RJRz6hOe6bRChGm8dqq8yNyuykk9zqKVC7boRjhul/eGJqbWbA+biRH8yhG6dGQ==
X-Received: by 2002:a05:6402:54a:: with SMTP id i10mr31108064edx.162.1557768481867;
        Mon, 13 May 2019 10:28:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i2sm1006117edg.81.2019.05.13.10.28.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:28:01 -0700 (PDT)
Date:   Mon, 13 May 2019 10:28:01 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:50 GMT
Message-Id: <36edef85e625ac6b84a10f8ce5738b7ef5902ebc.1557768472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 10/11] built-in add -i: use color in the main loop
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
index 1435c12be9..538658dfa7 100644
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
@@ -420,15 +428,21 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
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
 
@@ -453,8 +467,9 @@ static void command_prompt_help(struct add_i_state *s)
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
@@ -477,6 +492,18 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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

