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
	by dcvr.yhbt.net (Postfix) with ESMTP id C8C031F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:41:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726190AbfKMMlu (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:41:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:47083 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726543AbfKMMlR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:17 -0500
Received: by mail-wr1-f67.google.com with SMTP id b3so2158125wrs.13
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 04:41:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=3T4G+IMUFXYTETxqLqM5zLBjlH8NeV+OLl6xL2Gw01Y=;
        b=bTU/Af6cpTvcAE4DyBDDY69RlfQXRWqc0BqyxUP9NZ2AurBWsPd/YfxFgM61139KGd
         N66Sl7asBtZEyaMofXxxV9V5R7cXdpr8AJEYbWPjL8nDtt0315QVKQzOR12Iqqm/s9cu
         B4KufqMTkbuqLcqxjHlHKAuJutrzFLFiWS0IL2AZ2QtI5PC9AZ2xzgAfrs6u/5UhKWiS
         aUms8D//SkmvU64ELfGaJNjalvGH4KaBMZBXzWSUfXBw7cLUUP7J6LXdwgdYB7QRu8T0
         q3Jor/mLX0DNcLb8jP3AneZEEJNF6cp4b1EpoP8LslKocHsPrkKMAWo5/SR3ka0WWmh5
         GVLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=3T4G+IMUFXYTETxqLqM5zLBjlH8NeV+OLl6xL2Gw01Y=;
        b=UAer0tPNv2qlMM2F95QchzmRNkpzGZ78bxB7/G+TrzyTdTvPfTLSJvhpHCgYn8/P37
         Qh+5zYtvgQxjoABx+icPua8DpTAFLGZawqyjRN1bZqvrDHH7aboJZ4p7LOObaL72LRId
         uPUwEMz8EteCo0dcB0WWAWOFuAXZQlOSZpm3So8808b9qr8kxPR9XLfXwqoyS//dndPr
         iuVYHTpxoe11C/8T0dQTo7wyxG8D8vrWnIvoeQbnhCOfXQJ9TbigoYpt9Pred6Wb8Ne9
         8KSBOqeDXQ2Dvfa4s2Sus1IVGtFFpeR3uAOPyOwAVFFs0nU/TL0CwtXQMx7A95+aSbgo
         er+Q==
X-Gm-Message-State: APjAAAWkBDg8JhGmxUZu2ow4u2c3s6cShPi3sSeggISFHzNd7IA4djR6
        cTdXKNXxK2Is7Zl9Fmn1GkhvIU3J
X-Google-Smtp-Source: APXvYqxazDjjfirRe0j/VkFV+zQBZ3VUq/TZSPUdT+7C/gt7sF0JKMeqn3Cl3xozJtHCeKwa8GXOAA==
X-Received: by 2002:adf:ec89:: with SMTP id z9mr2611954wrn.153.1573648874222;
        Wed, 13 Nov 2019 04:41:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q5sm1891983wmc.27.2019.11.13.04.41.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 04:41:13 -0800 (PST)
Message-Id: <eafeedc49b5dfc414577813804571e48ae6b1e92.1573648866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:41:04 +0000
Subject: [PATCH v6 8/9] built-in add -i: use color in the main loop
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
index 8d3829fe68..8f5531c86c 100644
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
@@ -282,7 +289,8 @@ static ssize_t list_and_choose(struct add_i_state *s,
 				index = find_unique(p, items);
 
 			if (index < 0 || index >= items->items.nr)
-				printf(_("Huh (%s)?\n"), p);
+				color_fprintf_ln(stdout, s->error_color,
+						 _("Huh (%s)?"), p);
 			else {
 				res = index;
 				break;
@@ -508,18 +516,23 @@ struct command_item {
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
@@ -537,8 +550,9 @@ static void command_prompt_help(struct add_i_state *s)
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
@@ -569,6 +583,15 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 
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

