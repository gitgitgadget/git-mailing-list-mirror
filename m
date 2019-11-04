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
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AE021F454
	for <e@80x24.org>; Mon,  4 Nov 2019 12:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbfKDMPi (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Nov 2019 07:15:38 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:43098 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfKDMPh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Nov 2019 07:15:37 -0500
Received: by mail-wr1-f67.google.com with SMTP id n1so16797108wra.10
        for <git@vger.kernel.org>; Mon, 04 Nov 2019 04:15:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=sdshgj6d0JnATjGjpeuLigTFqXl39TQNKLV3UwDcNBo=;
        b=KtFQKzLVdzkPI79fxe3T013nce14LPQBg4FoaTkOAwSZ+/R02+6GsBoaW+MH/j3X9u
         ZHGnVMEoThJJiCjtkU5+A+EDan4P8bpqSD2mOoAVg9YA+8mNlcqRvWiY4ZJy85zI7wZ/
         vdDcCwq9J16HhpXA/lA1RZk7V+8VNpbNV/EhjXM5tBavyjcFMfQpu5H7ZALucZl1IbGG
         mkdoidW/9uGtQiyrvK5p1BH+AlPHOm0lLo91zIRrXMZyAB4CcsWn1P6CBqpA1TNKHBxv
         6+6ynHVpIRBPQderjxAjAwi0x/A4Qr4vyPwyNP6pFWiZQWibOlVCni6WPnBoFWpAlbCW
         wkkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=sdshgj6d0JnATjGjpeuLigTFqXl39TQNKLV3UwDcNBo=;
        b=RuHqfdcUWeiu3ifHnIelnBnQWZnVlAhXDpaY1914HrqvxvBSSGInXlIajvgvLFxnhy
         grp15J18W9OrM8aWnj4hZ4wQk9LxtEE3axmpToUYld7fwyNMpMz6bQH/XuoSPN3IEY6X
         WAnbg9sduLzBFql40ecDPHcb1aiPqRJi4MBGP9lKjxEdBty3eqf4IEdkCHeEMHvXBWpy
         38W0lllb4+IJPClQIVax0LqRbOubcinzKUNMQwMcuVxXuYrLWyLXm7rHgEyZ/hqwf19Q
         GOLe3lQoGMXvFYyhA8jQ5z79o7Zacqt3zZl/dze3//DpJcXoTU+eG6wcWewlSr7Tv30k
         72Lg==
X-Gm-Message-State: APjAAAUdf9tgVUtMjbYmUoFV6vWmRFyOiEQr5bbtPk4pAPJ42zDmUFWs
        4nfC2W9RqMNHb0f4eMPffg/BjJyz
X-Google-Smtp-Source: APXvYqzgd8ivK/eNrWueRSUBx4imrXhIXGJq/ceqOX4ZPoz2gnTEtxDEA71Xrk7P672RkFr55/NX0Q==
X-Received: by 2002:adf:e286:: with SMTP id v6mr17808181wri.241.1572869735447;
        Mon, 04 Nov 2019 04:15:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y2sm17629165wmy.2.2019.11.04.04.15.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Nov 2019 04:15:34 -0800 (PST)
Message-Id: <e405f071100e1f538207819233565b5845e70708.1572869730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
References: <pull.170.v4.git.gitgitgadget@gmail.com>
        <pull.170.v5.git.1572869729.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Slavica=20=C4=90uki=C4=87?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Mon, 04 Nov 2019 12:15:24 +0000
Subject: [PATCH v5 4/9] built-in add -i: color the header in the `status`
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

