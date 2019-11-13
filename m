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
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A931F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 12:41:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfKMMlQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Nov 2019 07:41:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36574 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbfKMMlP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Nov 2019 07:41:15 -0500
Received: by mail-wm1-f66.google.com with SMTP id c22so1849478wmd.1
        for <git@vger.kernel.org>; Wed, 13 Nov 2019 04:41:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=sdshgj6d0JnATjGjpeuLigTFqXl39TQNKLV3UwDcNBo=;
        b=kIxrI8QE7mkd5+mzU9RCHCqWBF+l5H/pqXGAXj2uR3/9LDrpXuvsdRrPFStapDK/Ro
         8jKYo7tFV84kB/3YYl87m6bUZDmgyCrGz09tKBxfe4D+IfcKPYb3H07zRjjzf3AVbKCv
         z9qJLM9oczeDf45mP/FZlFO/93vyI/lZ9gv2JiVUQkEKvQ+BOyaGsNA+84+94ufVmnDt
         RkCNdIMYMxsEQbOJZJf1oEZdtE81noNF27forG9c8oj9sr5Ud1TTo1s1fQs/F3hLzeVJ
         WfCO5KBJ7+32TPatXqaiU3v32ZnVE/xocPxfdJzfm9qJ5BA+CJHPwYZrhVDlWIsVbPSE
         FF+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=sdshgj6d0JnATjGjpeuLigTFqXl39TQNKLV3UwDcNBo=;
        b=RpsJFm2BcsOmjys9TM92B9/9tMIfxmX2QhPdH3byaMmL323dIEdImQ0dn6+dqZfl8u
         VG8BQMNqxnpJ609cIgqLI0GQn4HubRtgIQiaHp0Jqp9YmOvKKLaxLY57pqRncFz0cWxk
         /a4q5oOQTykl0KwN7jryO236H9D0iCO1Px1wklxTnU5cYs6yajKK6bNe5rwb4wlr1p1c
         t8FGLNwlNc8JEV6csdnbI4DIfXMTHVLE4vlTZ5moII9W2xeyEbi5rPmzaQMZ0FGvwgqr
         jA750t7sRRf3tizTGW4WUAHwPIY/9/44Duo1QZFeIKoEoG9Ci6fyI/5svldYecAwjP+S
         RNOQ==
X-Gm-Message-State: APjAAAVooe2Rm5sDySvKO5EGindOwqm5ZtQ+aTThE3Dd3KVUQc2fuMFJ
        0WmWLhi9I1A5OkHcAv7KFNpuFJUX
X-Google-Smtp-Source: APXvYqz6rb8LE/y/g1XY6JYH9v6gWlKRkYRtcb/t0F1Hl2QAVrMNau1NjOYKu+9W8yC3RJ0rKxAoQQ==
X-Received: by 2002:a1c:f705:: with SMTP id v5mr2505624wmh.82.1573648870995;
        Wed, 13 Nov 2019 04:41:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m3sm3141034wrb.67.2019.11.13.04.41.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 04:41:10 -0800 (PST)
Message-Id: <d61cf9daeb7e265715a0bd5b922fa124c65ead81.1573648866.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
References: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
        <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Wed, 13 Nov 2019 12:41:00 +0000
Subject: [PATCH v6 4/9] built-in add -i: color the header in the `status`
 command
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

For simplicity, we only implemented the `status` command without colors.
This patch starts adding color, matching what the Perl script
`git-add--interactive.perl` does.

Original-Patch-By: Daniel Ferreira <bnmvco@gmail.com>
Signed-off-by: Slavica Đukić <slawica92@hotmail.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 add-interactive.c | 41 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 37 insertions(+), 4 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index aa35184d87..174e07ce83 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -1,5 +1,7 @@
 #include "cache.h"
 #include "add-interactive.h"
+#include "color.h"
+#include "config.h"
 #include "diffcore.h"
 #include "revision.h"
 #include "refs.h"
@@ -7,11 +9,40 @@
 
 struct add_i_state {
 	struct repository *r;
+	int use_color;
+	char header_color[COLOR_MAXLEN];
 };
 
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
 static void init_add_i_state(struct add_i_state *s, struct repository *r)
 {
-       s->r = r;
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
 }
 
 struct list_options {
@@ -20,7 +51,8 @@ struct list_options {
 	void *print_item_data;
 };
 
-static void list(struct string_list *list, struct list_options *opts)
+static void list(struct add_i_state *s, struct string_list *list,
+		 struct list_options *opts)
 {
 	int i;
 
@@ -28,7 +60,8 @@ static void list(struct string_list *list, struct list_options *opts)
 		return;
 
 	if (opts->header)
-		printf("%s\n", opts->header);
+		color_fprintf_ln(stdout, s->header_color,
+				 "%s", opts->header);
 
 	for (i = 0; i < list->nr; i++) {
 		opts->print_item(i, list->items + i, opts->print_item_data);
@@ -213,7 +246,7 @@ static int run_status(struct add_i_state *s, const struct pathspec *ps,
 	if (get_modified_files(s->r, files, ps) < 0)
 		return -1;
 
-	list(files, opts);
+	list(s, files, opts);
 	putchar('\n');
 
 	return 0;
-- 
gitgitgadget

