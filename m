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
	by dcvr.yhbt.net (Postfix) with ESMTP id 64FEF1F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbfKOLL3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33819 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727364AbfKOLL3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id e6so10560097wrw.1
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jBLpxwEloPohTLVDDwzYSFq2IDDM6UR3DSZQ9J7LtE8=;
        b=nFVfNM0A2OvbaEQ/r6HrcUNcvW13TYUXwHQF6Cn4f/9f3J7272CGeSSDsI7+t3WdNS
         faBXqvM8+yJCoz8xMeSB6SlCykqk8hfpmFEx3Gnb4HXajCO/wQgj7v1gN4dYuBHdiNU4
         zZ5GX8+P4sW9AeOHyfZOqBjYeNz9rugSVy94WgHqkyeZPt3jp0zczx1V0skKNWJOFdpr
         oncaXC7V5NpN5eeEAk0NmIgIpstYmx9UOKiTeQSTHjFpa/kviY2hDItSU0I6qU4IB5tc
         hafArC+UMgQXR8B2joX7LIdJ6V+uqgENivFBecfcyA+T5+HkhJhINIiAx9K80DaL4qLZ
         jDtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jBLpxwEloPohTLVDDwzYSFq2IDDM6UR3DSZQ9J7LtE8=;
        b=nDHBEI0E5JcZDaspatfICLS3chAe8KNYNV26hlY5v6pNx7ELfNLWhoyq6kKpYnewqz
         i6fzgpBo4ASpsoSZuYz8SsEpvNnlPGgGTmLxaCpyvjJPtmPMeLJYlX3Z8rPB54vMNOMo
         1J//hZ+riqzsEdwQ275V1o8BaPe80y1K19/W8gNHlGx3PCG2Kovuk7uP+tcoOUg5u0O/
         LgtLl88CKYf3yR2NtlW6ICOWHLGv+Bo0skhx7IYWwv/kRLFmlt16mRxb5GJWK9CHzqdh
         6Ivb58Ouz7Wi6z+8p5av57GkCu1pIGDqdWSySTic70rysDrED/K3R2bJ65FK2xSokv/f
         gllQ==
X-Gm-Message-State: APjAAAV5AWi52juKtxBNlfmGjumgy1jyE80oUaABRtgxFAdojupm+9K+
        nZeDZ35JbpKUcy4j07XPtO72O+os
X-Google-Smtp-Source: APXvYqxevGz7MeBhYQP9mitdELXZ6+gYBhx7RhqSnsiQY52Nt4iblDYumOiGws18BEfQ/xKVPhWuaw==
X-Received: by 2002:adf:ecca:: with SMTP id s10mr14965799wro.22.1573816287415;
        Fri, 15 Nov 2019 03:11:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y6sm11031970wrn.21.2019.11.15.03.11.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:26 -0800 (PST)
Message-Id: <d7d447026cd5f00c0b7054da5dcc6334ea8be2b0.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:18 +0000
Subject: [PATCH v7 7/9] built-in add -i: support `?` (prompt help)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
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
index c5d95d4796..0a03b9017d 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -11,6 +11,7 @@ struct add_i_state {
 	struct repository *r;
 	int use_color;
 	char header_color[COLOR_MAXLEN];
+	char help_color[COLOR_MAXLEN];
 };
 
 static void init_color(struct repository *r, struct add_i_state *s,
@@ -43,6 +44,7 @@ static void init_add_i_state(struct add_i_state *s, struct repository *r)
 	s->use_color = want_color(s->use_color);
 
 	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
+	init_color(r, s, "help", s->help_color, GIT_COLOR_BOLD_RED);
 }
 
 /*
@@ -210,6 +212,7 @@ struct list_and_choose_options {
 	struct list_options list_opts;
 
 	const char *prompt;
+	void (*print_help)(struct add_i_state *s);
 };
 
 #define LIST_AND_CHOOSE_ERROR (-1)
@@ -250,6 +253,11 @@ static ssize_t list_and_choose(struct add_i_state *s,
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
@@ -515,12 +523,24 @@ static void print_command_item(int i, struct string_list_item *item,
 		       item->string + util->prefix_length);
 }
 
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
 	struct {
 		const char *string;
-- 
gitgitgadget

