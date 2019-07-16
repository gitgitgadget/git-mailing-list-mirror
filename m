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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BC121F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388001AbfGPO6w (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:52 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:33813 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387911AbfGPO6r (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:47 -0400
Received: by mail-wr1-f68.google.com with SMTP id 31so21355383wrm.1
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=tmPfGYqL+lfGw92CHugkAF+zx/YMo+COjgbZPSOyQWE=;
        b=O/3qmCtjUBgNIBNPYaVXKwf7fGEc96g2PdjObOxmUTrvjE/3hUgj3SipY6MmSrCAu1
         p8Ua0nPeSn4rc5RpxBsYnX7Ze1ahCzUEtEcWeTGytl7V4aqtL1j9UYuHgiIKhdsyIFKv
         nvrt/F9ArU3Mv4cgbzamgX7dwgYsuictobMnqnU5tOiJkH9BbFhTNSNwU+LjHssnQWWx
         NflfAxNJzGGd67cXlp5bwhK0iC8NnFoU85bRSEuFwdbDge35Dj24WG5/0T+B+JRtlLaL
         scfJkwRLloV3fjfOEvrUDBUJejK6zvsUG3Ja587E7ofH+SGLugJMsXqI61A+r9oYpK7m
         OjwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=tmPfGYqL+lfGw92CHugkAF+zx/YMo+COjgbZPSOyQWE=;
        b=QlFqgq0YftmpfPkEaUvTzib5IlZfCXxvHVFozOHgQZn+DXvByqj+ldmhjBZgcOiv2d
         +hGRnYt3chl2vaGod+iMO4jXP+YLyYoEpfFFb5tSV7niJu+si+jo6AhiVqiER/gAAn9L
         NnmXCLWr0nXgJ7UtLDwXYIxu5MJ9slKUKdjMwuLfp2nkE+xy3MI6rqBQteJJycy290fL
         qIaDcKTDvwTk4LtB/CkDoSnifufYByLG1/VwcIhyTxbkS505flmuQCSR0ip7e9uTW1ao
         zBtPjzguFg54/QdnA0XQRMikE6LhgJXRMtWi77+IxGgk2qYPJyOkqa7UpEAw/Gs5bHDg
         J0DA==
X-Gm-Message-State: APjAAAVgHIXgM8UQNsAY+L1Jeuol+ZPw59YB8oxEXDbDgtaRqUeRgfNy
        ROtbcVPpLSFT8s7wAbORP0dENnC3
X-Google-Smtp-Source: APXvYqwjTJSFBIgWA6InTXXek+16M0IWC+r/+Ic8LVBQy9IZj4vPQcaPNn42oNVZil3/lNXA0SGCTQ==
X-Received: by 2002:a5d:62c1:: with SMTP id o1mr29875833wrv.293.1563289124779;
        Tue, 16 Jul 2019 07:58:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm18708327wmf.43.2019.07.16.07.58.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:44 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:44 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:34 GMT
Message-Id: <8121a3ca1bae0189ef720dfca455c2feb5d40e0d.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Slavica Djukic via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 10/11] built-in add -i: use color in the main loop
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

