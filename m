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
	by dcvr.yhbt.net (Postfix) with ESMTP id 99D271F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbfGPO6t (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:49 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55718 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387982AbfGPO6p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:45 -0400
Received: by mail-wm1-f65.google.com with SMTP id a15so18979206wmj.5
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KLaHCurmDEpycqJuX/zXDe7I4xK0ZhGBA3VdBWaQFsc=;
        b=KKGCwriPKqqCQqpaIrxEtyC2p8+uxgpFB9Ug/ALdD3W6EQyOhHntVntLxGQYwpLhar
         exdJeaxUK0EVqDqOvkU168l84ZOtR4HnLTBZVebVLnVzvHTD5M/YNaw+LG0cMvbj4Kbk
         5V8DIyEK/HEX+eBNNWZP1mtzV9hA5VWAt3KOjcxUxGwrpMxBw+rqEez0TZdWQP/NP5qP
         OVRIDKb+wI1IXEv6KbCslA4pJkWViQMbUl6sPFFR5+rmN1g0Emj8LN6XooJQCwBs6CGB
         mK3xFMMsOzDFNv/QG6NETQv7AOj3PLISuInq2Q4RWP2xx6mmaAd5dnlCO42FY7C4dWL4
         W3Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KLaHCurmDEpycqJuX/zXDe7I4xK0ZhGBA3VdBWaQFsc=;
        b=XRHJns5zaq880ZtWu0iqBsiRL4lqLHaJXkLWSbe2c7HdkUTnkAByPjbbMrCMNyIkJH
         ClnQyGHaeCmm5N8uNkC8++PZc1bar6LIOu4htJa1+vpbpdI2TE6B87jJHLJoRuI0vnk0
         9AZ7Iy4Sa26ohzHc/q57/gemKVvcuE4MYDJZbmuTsGaoV8Smwh6ChH2t0bDCq+IV/ZYQ
         YMROXhRxd6LEbzqh7EH6iIkz2gY7/OTyQo3MNrTHP9OpqInUddeYH11Mp4UNHs54xViu
         1DXbS7F02HBGrUPczD+olgZufJzXa21CALP77R5kk8johLyxXdop/gYXo42ODx38M+j7
         XcWw==
X-Gm-Message-State: APjAAAXSUHQpsKgVNOIQOD555Im9WGxo3Krf+GRCIjv2Rrs6rPWPd1oG
        YfKXOe9bSbX33FKdzZJlqRbso8aL
X-Google-Smtp-Source: APXvYqx/asbuOzIlX3Zf9TxcxHmqN9fiIjvFpHMQmQOkajqVrRdduvs5qZaou5D5MwDDRGH6lJBDvA==
X-Received: by 2002:a1c:411:: with SMTP id 17mr28901693wme.74.1563289124133;
        Tue, 16 Jul 2019 07:58:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c6sm19405822wma.25.2019.07.16.07.58.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:43 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:43 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:33 GMT
Message-Id: <d8c012fce83218a72de485ee6855bf80240d3964.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 09/11] built-in add -i: support `?` (prompt help)
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

