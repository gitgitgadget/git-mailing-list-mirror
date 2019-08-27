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
	by dcvr.yhbt.net (Postfix) with ESMTP id DA21A1F461
	for <e@80x24.org>; Tue, 27 Aug 2019 12:58:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729919AbfH0M6C (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 08:58:02 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39288 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbfH0M6B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 08:58:01 -0400
Received: by mail-wm1-f65.google.com with SMTP id i63so2915658wmg.4
        for <git@vger.kernel.org>; Tue, 27 Aug 2019 05:57:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=gTgvDKX2gGOcJL+yrNvDiMNo7ZrmoA65OM4l2VLC7yw=;
        b=lsNWe7HV8pMxuGg/YO7UgQiXNx5ceVD0kwWH6beOdIF3KhRFMyGRdXjrejVOqPDKqt
         YQdRjWu85JEsmmyQw7BoMiuPIZsUw+yHR5Igywmt66L1w5YhhUNKcmyXbphkQFTILuuS
         HNEHrEH4Lt56Bn0SG7uclQPHyGo7+YGTDOJSYV1lCvx3e25yOCpY3onA9H/Fkl3EbTOY
         zvx7Nh4ZCReGOsO9jTohCiM02yWwM8SMuqcl1g7KL0nNGHugPuaFsloSa4EQT3BgiFtQ
         ZmuxDAveUJDyULYZKZ6YUPVrzDCk7s/SLkaGAOV2oRuAnz9RSNPhdvgSe786X2p2mQIj
         TzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=gTgvDKX2gGOcJL+yrNvDiMNo7ZrmoA65OM4l2VLC7yw=;
        b=HEmGsVZznNDTas0sSm0mrAERuAyCIZ0zsOVuWeZL8MWjgX0EIQVSFMJ3eDPklmOB5A
         JG5sj0k6bWNc05tBkbyAb0/FeSb+CEPVOaLYugi3Ls5IYZUnRVZypHt0GXMWLOaAKsJi
         i++Devj5ceDQmRHUZHqwf0em5vL3RJpm1JsDRveC6TbsuXiptfQlKekIRYUc4m2bBdat
         s4AU1E/rGbOPYCe4PRdEDhCFUcw8jo32WHmquJaKMF1o2k7rLjJ1lEz8FluxUwmW6/qh
         S5A31+q2wZhuKq/g8SMrpYSUvWVhIY8gRzhxfwpoyCRqy7n3z41LZ5qfbI2088b9K97p
         /vxg==
X-Gm-Message-State: APjAAAXQ5SxYnT+c9HaNHta5115Z3bB/2kHvHjy0ZN6425clBS6Djx2B
        LVJNZUA+KskDZ3sOox9yQ26Tonze8No=
X-Google-Smtp-Source: APXvYqyp5xEZQTFBRirTwKL0a1Q1LeE3MWRaHNzogkizKwBg6RMJbTg7H1iJusJQJ1nQPygfVVEvvw==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr29151726wml.105.1566910677816;
        Tue, 27 Aug 2019 05:57:57 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o9sm12853343wrj.17.2019.08.27.05.57.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Aug 2019 05:57:57 -0700 (PDT)
Date:   Tue, 27 Aug 2019 05:57:57 -0700 (PDT)
X-Google-Original-Date: Tue, 27 Aug 2019 12:57:46 GMT
Message-Id: <24737a09f7d2f82a6d19bdfff846af32c4fb0aa4.1566910672.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.170.v4.git.gitgitgadget@gmail.com>
References: <pull.170.v3.git.gitgitgadget@gmail.com>
        <pull.170.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 05/11] built-in add -i: color the header in the `status`
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
index 427abe505e..f5577a80d3 100644
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
@@ -227,16 +271,16 @@ static void print_file_item(int i, struct item *item,
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
@@ -244,6 +288,7 @@ static int run_status(struct repository *r, const struct pathspec *ps,
 
 int run_add_i(struct repository *r, const struct pathspec *ps)
 {
+	struct add_i_state s = { NULL };
 	struct print_file_item_data print_file_item_data = {
 		"%12s %12s %s", STRBUF_INIT, STRBUF_INIT, STRBUF_INIT
 	};
@@ -254,13 +299,16 @@ int run_add_i(struct repository *r, const struct pathspec *ps)
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

