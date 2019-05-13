Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9E17C1F461
	for <e@80x24.org>; Mon, 13 May 2019 17:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbfEMR2O (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 May 2019 13:28:14 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45676 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731723AbfEMR2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 May 2019 13:28:02 -0400
Received: by mail-ed1-f66.google.com with SMTP id g57so18673447edc.12
        for <git@vger.kernel.org>; Mon, 13 May 2019 10:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KLaHCurmDEpycqJuX/zXDe7I4xK0ZhGBA3VdBWaQFsc=;
        b=CAvOxuUm0KYD7OzXEMzYMqRbkBaEpCKR24l9QdgyuMRbjPecdA1U8dW2k7ApJxq+Qw
         LbXQ7C47/bDM8XD1Kpf5fdrfrF2lGTmzascBr6DouGmYA5fAzyfQe2Wspvc7eU1o4FaB
         CMXijZaUVZj1N43b11GcEgy3R/vrrZJvW79qyOwp4bOtzA85MUTu3ErtFhGrEDjict/f
         6pDN315D/GBFIk5Jzov5MpPhJT/SFcLjvn3YOMJ8F3qhFuHzPMWMyguumhbV4qvVRDKG
         eSYUhCaSXCUafT+WM2hNlQYtGhcAoSOTKVKciKhVOYUh4IKghCmTnWHsdKpsh5OUqr7V
         fo9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KLaHCurmDEpycqJuX/zXDe7I4xK0ZhGBA3VdBWaQFsc=;
        b=dYZK/3XoTTvwCvLjqWThRMcIbecElSbZeguDbhKBIXqzAY8VM/XHsy1Aq5SCE3D9il
         V3NNDLWaZJRC/mezvs445iRR5hy3bIHDAS+qhucnvfITkxUNVflGMsYT+pIDbN/cskpY
         057DpuXx7XCSvK2rEtGSNM40YVAARfMHwYZRxd+GUjEwpW+XHRxiZOeab8v3IxqRfeeQ
         8TBjW1GRiqs4d2sIC3MhtGvCZZ9CJ0HX68G/7NyGItYGbC2AlrfXHa82EOB/dJ0GLPAZ
         ZXvmjoUKBSbgzBxmBfNj1jqIeCUlrvdx75XNjrWBpd5OV0LzYMCoX1/c7atrmycwTsp8
         u1uQ==
X-Gm-Message-State: APjAAAWZv93061zEdxjXSVH0n8WKAXGfCvcuKmtbgKwJBaJU+l2nKwBY
        i+WhCdf9Tr05OQlC6+xXsY9/Pr2H
X-Google-Smtp-Source: APXvYqwPuXDTvDxOGevPTPl/63kM+RRWEZFz0jJC8SePk5ilGYT+qqvXgjAndgaq6YkyAvIpegO4SA==
X-Received: by 2002:a17:906:4cd2:: with SMTP id q18mr23464858ejt.205.1557768481085;
        Mon, 13 May 2019 10:28:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v35sm3936534edc.4.2019.05.13.10.28.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 May 2019 10:28:00 -0700 (PDT)
Date:   Mon, 13 May 2019 10:28:00 -0700 (PDT)
X-Google-Original-Date: Mon, 13 May 2019 17:27:49 GMT
Message-Id: <7378af60ad48bc7a6b8597cff06bedba757b20e3.1557768472.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v2.git.gitgitgadget@gmail.com>
References: <pull.170.git.gitgitgadget@gmail.com>
        <pull.170.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 09/11] built-in add -i: support `?` (prompt help)
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
index 7ff87bae1b..1435c12be9 100644
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
@@ -430,12 +438,24 @@ struct command_item {
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

