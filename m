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
	by dcvr.yhbt.net (Postfix) with ESMTP id 227A51F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728807AbfKDMPm (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:42 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:55449 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727998AbfKDMPj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:39 -0500
Received: by mail-wm1-f67.google.com with SMTP id m17so7131663wmi.5
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=F4n1id0vdhNeuIF3K+W90lr/L83cbu1tHsoETPVfkxY=;
        b=Xk7M2aJQ/DLU4DNT3fq7T/Hdk2GNm74SIbUkaSd7QYYVGQuwo8pFzH/wDL9kg4aNLX
         AytLc/7CMHmH55+PQtFTXFtt0/7eddcT5ovSuh7JwWFEd7cZ6ViTA5R7iuieGHy/uNru
         E22tfTnJmdp+aWauAdxPw7Qry8uYYbM3RJtKzWMMxW/FBDDvasia9G9lMwKXdKUkdbVy
         j1LEB1tY8hRLwbW98wsS/zWvkliiMpWq8+abXt/RKMsBHGyCUtBQFS77HjOYaElYTx0a
         lMJWsz2XT/Yz0jhiM+D4plH6So0rsUQo3JjyeCybvfau3nHwgL3chyTs6fNRH3cNV98y
         VPcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=F4n1id0vdhNeuIF3K+W90lr/L83cbu1tHsoETPVfkxY=;
        b=iEuVdlg8T0uL4LawYvsInkOkgb+1zh+Czn00tJWJNb1CQxWX1k9ACbr54w+t3tJPXl
         cXo7q0ZZUkH9j3iUkXkOXk5bSn3uV1WHbPitLY0VxguDmHsR/9dZcWGWDe/fOTkxlA6d
         l6YMing3dyzBdKhbqWhFHNa+42TzkyrPRanuKmRmL0Ytv0nHPP4jQFnP+dTS9H6P0hBt
         N8vOqHRLKNrpc8Zi9XD0iBOhnmvDfufxvkbx/wYXrAYT2JUsgkpiJHhEtl3gOERc8FJ4
         8XOhqTCcrS3/cZxVMBCLD0wumT84DfamiPRRweqUGrcPdsoUAONq8ElvAWlEUWlzYnPY
         NCBA==
X-Gm-Message-State: APjAAAUy/RaPPsIaAwCkdg6dTC3BOWxnJ9Zt4aUC7gumMhHs1rkhvYK9
        M7zirdgehP4hC7rh1BDFq0CHO43P
X-Google-Smtp-Source: APXvYqwSr3LAjV7qLpHcT1wirW/15qWgXd3BHMAwzqDdxmSSD0dL3It9xJSJ4PTTouNVeLgsZUF9Wg==
X-Received: by 2002:a1c:ca:: with SMTP id 193mr14227084wma.103.1572869737884;
        Mon, 04 Nov 2019 04:15:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm17445468wrw.10.2019.11.04.04.15.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:37 -0800 (PST)
Message-Id: <77ad5f333a7f72135ed084dc2d0cf20d372302c8.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:27 +0000
Subject: [PATCH v5 7/9] built-in add -i: support `?` (prompt help)
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff Hostetler <git@jeffhostetler.com>, Jeff King <peff@peff.net>,
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
index eb559555ad..d96e18fce5 100644
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
@@ -513,12 +521,24 @@ static void print_command_item(int i, struct string_list_item *item,
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

