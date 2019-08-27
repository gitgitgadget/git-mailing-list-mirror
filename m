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
	by dcvr.yhbt.net (Postfix) with ESMTP id 520011F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729960AbfH0M6F (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:05 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39296 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729916AbfH0M6C (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so2915852wmg.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4lHPngCpOBZoIfXJc8hQeYD3AiiGaRcngpUiY0erUUI=;
        b=itE+/t4xNugjJ92t0Q/hF4HodcFfbO8CH0Ej0sLS1RQbv+6v7cQIfF3Hl7OgUgJdB7
         quJ9so0/TRRGYe166kqWRn5Og+7yEP8EvSqA2OA2iiFTLP5dmU0/MvocISW5Zb+m8uG4
         T64OPfoxIySQ9jTazNUHr+c79J8Y9//kRQa4+pTm6udiJnzpOq11F3Zsf+pFygfOehny
         5MJKB0Oi6RlPL3BLwCtzqkgmkG80hXNBMbHuPb8ExoyodWcPACEJDjuoL8bYAFbGiucI
         aS6RyXzI+CUPjctTU/KpfSrMP+9otHHS01anxQxz6o0lUNVuaOfXR/6uACe0biC3Os21
         lEKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=4lHPngCpOBZoIfXJc8hQeYD3AiiGaRcngpUiY0erUUI=;
        b=LPjboasFB5L4Q50chLqGSoEjOeZd8MifX6Yl17tp51/d3Y3fQMd2hQUgeQo1Z5ASe1
         bp+SQQBMtq7VExJX/hR221SL5vZkWy20LcwMheGoKlRN49djxE59Z0YUJwHc7G5kviVu
         Dohn7Wvit6r6U1TmiQdX40LUG4QfX+wglJ2FQodXfbUry8zyZn/SDm7pAMJWlBh5BVgF
         /xDqlpf7uQ6fFywwr8PgI0CUvP1Ys1CoL+2B1ZPuBPjrErXFuzzO7Df2OWxDfMMZqOgI
         OfcmvL67aR45tMAxNh7wntnYjehBJKPq0KOV8d5+LloYdGPdOUyu34raBJYnZyShILto
         t2ag==
X-Gm-Message-State: APjAAAVYuavxYtXWdBWPQVVEcQSmlrerymZ409MzbCLQISdP4pyGH3Uj
        QTEESLALWXtkW9hP9Uot/UBINFq1wQc=
X-Google-Smtp-Source: APXvYqyjsFYIkqWKXMxtyxK5rwO1bFFURauoXheL8wBKcodFPdZIRHSpaJO7ATQCHmU0v8GrQqlnuQ==
X-Received: by 2002:a1c:356:: with SMTP id 83mr29306998wmd.40.1566910680897;
        Tue, 27 Aug 2019 05:58:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e14sm2272436wme.35.2019.08.27.05.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:58:00 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:58:00 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:50 GMT
Message-Id: <74f73e26b4de4bb7873079811d1251a938c58522.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 09/11] built-in add -i: support `?` (prompt help)
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

With this change, we print out the same colored help text that the
Perl-based `git add -i` prints in the main loop when question mark is
entered.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/add-interactive.c b/add-interactive.c
index 12a4c2adb8..710317e599 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -11,6 +11,7 @@ struct add_i_state {
 	struct repository *r;
 	int use_color;
 	char header_color[COLOR_MAXLEN];
+	char help_color[COLOR_MAXLEN];
 };
 
 static void init_color(struct repository *r, struct add_i_state *s,
@@ -43,6 +44,7 @@ static int init_add_i_state(struct repository *r, struct add_i_state *s)
 	s->use_color = want_color(s->use_color);
 
 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
+	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
 
 	return 0;
 }
@@ -104,6 +106,7 @@ struct list_and_choose_options {
 	struct list_options list_opts;
 
 	const char *prompt;
+	void (*print_help)(struct add_i_state *s);
 };
 
 #define LIST_AND_CHOOSE_ERROR (-1)
@@ -144,6 +147,11 @@ static ssize_t list_and_choose(struct prefix_item **items, size_t nr,
 		if (!input.len)
 			break;
 
+		if (!strcmp(input.buf, "?")) {
+			opts->print_help(s);
+			continue;
+		}
+
 		p = input.buf;
 		for (;;) {
 			size_t sep = strcspn(p, " \t\r\n,");
@@ -431,12 +439,24 @@ struct command_item {
 		       struct file_list *files, struct list_options *opts);
 };
 
+static void command_prompt_help(struct add_i_state *s)
+{
+	const char *help_color = s->help_color;
+	color_fprintf_ln(stdout, help_color, "%s", _("Prompt help:"));
+	color_fprintf_ln(stdout, help_color, "1          - %s",
+			 _("select a numbered item"));
+	color_fprintf_ln(stdout, help_color, "foo        - %s",
+			 _("select item based on unique prefix"));
+	color_fprintf_ln(stdout, help_color, "           - %s",
+			 _("(empty) select nothing"));
+}
+
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
 	struct add_i_state s = { NULL };
 	struct list_and_choose_options main_loop_opts = {
 		{ 4, N_("*** Commands ***"), print_command_item, NULL },
-		N_("What now")
+		N_("What now"), command_prompt_help
 	};
 	struct command_item
 		status = { { "status" }, run_status };
-- 
gitgitgadget

