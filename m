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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A1391F4B5
	for <e@80x24.org>; Fri, 15 Nov 2019 11:11:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbfKOLL2 (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Nov 2019 06:11:28 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55920 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727325AbfKOLL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Nov 2019 06:11:27 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so9256163wmb.5
        for <git@vger.kernel.org>; Fri, 15 Nov 2019 03:11:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=sdshgj6d0JnATjGjpeuLigTFqXl39TQNKLV3UwDcNBo=;
        b=XTVwviQ0B66IIcBIlLwF+S0etl8h7DP/jb7okElCt159XB7OKmAf46GFarzAlvPEHl
         hl+Z3Vww2R/hZo7HJclWJ40/OwuRdks396JaCFbznx+LEuE0gFy0dR8IslOVvzIffw7u
         c48GrA6VPdGM700lLZ3jyBV6GasT0zFRONkcwvgrcqlq9sp7CikkzQ6XsWkwQ6lffF02
         22WNOFw1/WSPZHM1HIG9YtwGdBJ4an0/E2tjtLd0yIHw2KetlPLtOCbVtihT92hxmf98
         esrY9R9GCGkoMZoODsN/U5pGV1YZsO0ftbIodAaE9AsUBl3bgrlpWZt+0YoC5KW26c8B
         y86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=sdshgj6d0JnATjGjpeuLigTFqXl39TQNKLV3UwDcNBo=;
        b=UIpeJBu1IIZiWYnWcp1722pKWfg++c4afQtB7Njl7eBHPl2csFfHKnxx22ifWBDAkk
         ncI4qv3PLIWFYuIVz1BDt6guFkPpUfy+U10nNzdBWrUL7AbRS3Ry//Kbvy93WtKy7hbC
         AGeyxjAzKWYAb+8QfijOHOrE4ZgYVSXI41u1siIgJCHbB+pSfnRc1xFTxIK3BsLrxvYh
         LGNUV/CFdgpMXHPf7VX+nhxjlOMURoYxMuTG5Gh0JZa/znRzvhGAFLHeIzJRdQqQ6ZkQ
         VBg0Se/GwqhFZhk0/LtO8Bbi9dIcrBSQeb6OjaZoW5K/kA50K3fzKY1EWOe3el66/PQY
         +4ng==
X-Gm-Message-State: APjAAAWkt98G5rpMTGcOtSyMcCAKXOP9U+tunnUK18flmwzLkaYwQy3u
        4mN64hk955NWSHfaz94qA9bmnF4I
X-Google-Smtp-Source: APXvYqxpSU1qKF0/yWgpOzJK4g2Z/7YXfXwFGQYKr3UvJb4dxQd1bDSNEZ5Qp5Oy1J/2FLrPFZd8+A==
X-Received: by 2002:a1c:808d:: with SMTP id b135mr13283026wmd.175.1573816285197;
        Fri, 15 Nov 2019 03:11:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm10797071wrw.10.2019.11.15.03.11.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Nov 2019 03:11:24 -0800 (PST)
Message-Id: <d61cf9daeb7e265715a0bd5b922fa124c65ead81.1573816280.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
References: <pull.170.v6.git.1573648866.gitgitgadget@gmail.com>
        <pull.170.v7.git.1573816280.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Fri, 15 Nov 2019 11:11:15 +0000
Subject: [PATCH v7 4/9] built-in add -i: color the header in the `status`
 command
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     "Jeff Hostetler <git@jeffhostetler.com>, Jeff King" <peff@peff.net>,
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

