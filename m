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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B6131F461
	for <e@80x24.org>; Tue, 16 Jul 2019 14:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387980AbfGPO6o (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Jul 2019 10:58:44 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38132 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387944AbfGPO6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Jul 2019 10:58:43 -0400
Received: by mail-wr1-f68.google.com with SMTP id g17so21324314wrr.5
        for <git@vger.kernel.org>; Tue, 16 Jul 2019 07:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fq8JyL/8QrjGUewxn4JGjB/dR3S9hr5kcLA1dQyWxH0=;
        b=ex+d2UT6geeUHW4lzJeQT6inqYoLx+9wVWfC6Es6BGxD+gTNOBNdi/QbxqvxO7SyFF
         rCTiZbpzXMdshpLCcLLSLSfdeCLkcp/E6t1/JdNe16MpOZX869yVxiW4l/KTwSeBFXdl
         eb9+ExJFJXKx03aRuSdlhq8rdUyh+ZaExvkZUxDvXI9GpaF2pAHM9OvbkX+GskBLfPL6
         Efk18my6xjDrk0US8/mIxALAzSeknVLGaZB9MZfJm+1qQm+j8OMw06RGECXKeaS5dX7L
         Io3IeE8zmdP3ic0I5Y85JfRwlakkJJ0TXeRQNuskT3qx2o6Nrswc1Td6nv0o4RNh6573
         xcrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fq8JyL/8QrjGUewxn4JGjB/dR3S9hr5kcLA1dQyWxH0=;
        b=kxOHE0jHWR4qUMA3oZ6ElVmu65PjW/9/I5z6lDArIV9dWuN/+5m6A3zLXv9GeCWa5W
         Ng+Q5wPrtPiMfRQSOnGh3p2b0TsXSBTtmpvPWR2WAza+0jeFuk9LoGKbvBvlQgyuQAr3
         kr/K6baF77jOYxT2TjNKYOO1ROzV0VfwvsudgNOt0o7gvLwfVfwep333qNNd4w9B+DaA
         D2VWblog/7lrSm6RNZthge+cNInbPCiuux80v0YBklD0kK258DJwUo4d/lreoTK1Kj7M
         p5RGXWByMixuGPem/H9ANj3lkw0TxQK1Lnt9Xw1Spr2xFVNM5yjmHR3ljP8i7tJg0E/+
         NlBQ==
X-Gm-Message-State: APjAAAWggJRxsUlstcmJ0jSuwDP0CNnnV9/Ko/hcqG1d/SmnNs6w6KGP
        VqhtWbepmxOJQEzj+j/tk6X2XsNu
X-Google-Smtp-Source: APXvYqwoQLMjItm3nrerL5UvaV2ua6CMza5kiTQMbeG9XlMv1B/uDdWiXqVv1Gp6MUbowQIzfXjtXg==
X-Received: by 2002:a05:6000:100f:: with SMTP id a15mr17057496wrx.325.1563289121113;
        Tue, 16 Jul 2019 07:58:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s10sm25503301wmf.8.2019.07.16.07.58.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 16 Jul 2019 07:58:40 -0700 (PDT)
Date:   Tue, 16 Jul 2019 07:58:40 -0700 (PDT)
X-Google-Original-Date: Tue, 16 Jul 2019 14:58:29 GMT
Message-Id: <15f18f5b3ebe77a79886dbcdb7a900647be943dd.1563289115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v3.git.gitgitgadget@gmail.com>
References: <pull.170.v2.git.gitgitgadget@gmail.com>
        <pull.170.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 05/11] built-in add -i: color the header in the `status`
 command
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

For simplicity, we only implemented the `status` command without colors.
This patch starts adding color, matching what the Perl script
`git-add--interactive.perl` does.

Original-Patch-By: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Djukic <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 60 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 54 insertions(+), 6 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 2dbf29dee2..6c2fca12c1 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,9 +1,51 @@
 #include "cache.h"
 #include "add-interactive.h"
+#include "color.h"
+#include "config.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
 
+struct add_i_state {
+	struct repository *r;
+	int use_color;
+	char header_color[COLOR_MAXLEN];
+};
+
+static void init_color(struct repository *r, struct add_i_state *s,
+		       const char *slot_name, char *dst,
+		       const char *default_color)
+{
+	char *key = xstrfmt("color.interactive.%s", slot_name);
+	const char *value;
+
+	if (!s->use_color)
+		dst[0] = '\0';
+	else if (repo_config_get_value(r, key, &value) ||
+		 color_parse(value, dst))
+		strlcpy(dst, default_color, COLOR_MAXLEN);
+
+	free(key);
+}
+
+static int init_add_i_state(struct repository *r, struct add_i_state *s)
+{
+	const char *value;
+
+	s->r = r;
+
+	if (repo_config_get_value(r, "color.interactive", &value))
+		s->use_color = -1;
+	else
+		s->use_color =
+			git_config_colorbool("color.interactive", value);
+	s->use_color = want_color(s->use_color);
+
+	init_color(r, s, "header", s->header_color, GIT_COLOR_BOLD);
+
+	return 0;
+}
+
 struct item {
 	const char *name;
 };
@@ -14,7 +56,8 @@ struct list_options {
 	void *print_item_data;
 };
 
-static void list(struct item **list, size_t nr, struct list_options *opts)
+static void list(struct item **list, size_t nr,
+		 struct add_i_state *s, struct list_options *opts)
 {
 	int i;
 
@@ -22,7 +65,8 @@ static void list(struct item **list, size_t nr, struct list_options *opts)
 		return;
 
 	if (opts->header)
-		printf("%s\n", opts->header);
+		color_fprintf_ln(stdout, s->header_color,
+				 "%s", opts->header);
 
 	for (i = 0; i < nr; i++) {
 		opts->print_item(i, list[i], opts->print_item_data);
@@ -226,16 +270,16 @@ static void print_file_item(int i, struct item *item,
 	printf(" %2d: %s", i + 1, d->buf.buf);
 }
 
-static int run_status(struct repository *r, const struct pathspec *ps,
+static int run_status(struct add_i_state *s, const struct pathspec *ps,
 		      struct file_list *files, struct list_options *opts)
 {
 	reset_file_list(files);
 
-	if (get_modified_files(r, files, ps) < 0)
+	if (get_modified_files(s->r, files, ps) < 0)
 		return -1;
 
 	if (files->nr)
-		list((struct item **)files->file, files->nr, opts);
+		list((struct item **)files->file, files->nr, s, opts);
 	putchar('\n');
 
 	return 0;
@@ -243,6 +287,7 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
+	struct add_i_state s = { NULL };
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
@@ -253,13 +298,16 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
 	struct file_list files = { NULL };
 	int res = 0;
 
+	if (init_add_i_state(r, &s))
+		return error("could not parse `add -i` config");
+
 	strbuf_addstr(&header, "      ");
 	strbuf_addf(&header, print_file_item_data.modified_fmt,
 		    _("staged"), _("unstaged"), _("path"));
 	opts.header = header.buf;
 
 	repo_refresh_and_write_index(r, REFRESH_QUIET, 1);
-	if (run_status(r, ps, &files, &opts) < 0)
+	if (run_status(&s, ps, &files, &opts) < 0)
 		res = -1;
 
 	release_file_list(&files);
-- 
gitgitgadget

