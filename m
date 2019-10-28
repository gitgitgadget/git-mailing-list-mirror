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
	by dcvr.yhbt.net (Postfix) with ESMTP id D611E1F4C0
	for <e@80x24.org>; Mon, 28 Oct 2019 23:42:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbfJ1Xmd (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Oct 2019 19:42:33 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38509 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725879AbfJ1Xmc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Oct 2019 19:42:32 -0400
Received: by mail-wr1-f68.google.com with SMTP id v9so11679256wrq.5
        for <git@vger.kernel.org>; Mon, 28 Oct 2019 16:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=VQzp1r5t5xfRYKmHzAmxZ6YVq1DFmoxB0RkkiEWciNk=;
        b=QOICIOFmlkMRQup8qrSiNUb0FzaeNd+hF3TDY3mtYsgUZHGH6Xy/myd3+9u9XsUYOb
         8t3sLD4bgY1QwG3r3omWD0HQEcyPObwgKt6Ux2ujfwhGtOTb9v0sCKrnvZ0xYQIMP8k3
         IUfEGEXJ3m40GUl1wrF+y+EGnWzc77GyP8da1Ud7mCRvn2PHyLqIiQxm93IAjZ79A4wt
         qE/JmD8iS4wnNYRPNCPmxWGIn5U8Ai0W3XbZANeK6/4rC26SutqUSo/GPj6oEejIyPEu
         vkbEXwfjHXLwBtkyznjYhzaIQ6QPKU96lX0ZXORw2w6h74Pagz1VMOYI7MqKMdw2JKBl
         8GRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=VQzp1r5t5xfRYKmHzAmxZ6YVq1DFmoxB0RkkiEWciNk=;
        b=hvsMGUGjLnRxXyyM85P8X/56dIc8e/P2N2UFuiqZM0/UOHi0Q0cmm0NT/REftW+b40
         ZNqT34yHeLFWdtdOoM7c3/E+QZPXQ1jZRtATfkKs7kHp2BA3FGNlEILQVcplATHRJqm9
         F8N6uqWkSeoE5saiciyZqKkqp/dN4YFa+jZeW2EXy2btnFPoG4Zoc2lJmo6wlrWVKQ11
         pTRmhqeBJUcV08S/eIM6PJ3s3V0uU9R701Dh/KjYKMhujIzqNvD03TYZaybg5qMVEnK+
         Ux6Nd7sDBR1h7C+Ua5ZlSlJb0rdFOJi/oX4HERTTOqTsYvGNRebm++OyqQfVMnnyvpP5
         TNmA==
X-Gm-Message-State: APjAAAWpzVj1UkalwRdwmU6ZYESEuQiVMCc6i/g0DQ/TW01aNaFZXYYe
        pQ/1wgavib5AKdjFqaYrOqBgwiYd
X-Google-Smtp-Source: APXvYqwrxXZb/07+AAJ+DnjPHt+TNm6qMRwO0xXVUGPKZqbpeWkocgMbDmdnPolimw1S15vH4RPoeQ==
X-Received: by 2002:adf:d18b:: with SMTP id v11mr647489wrc.308.1572306150775;
        Mon, 28 Oct 2019 16:42:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h124sm1254879wmf.30.2019.10.28.16.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Oct 2019 16:42:30 -0700 (PDT)
Message-Id: <8c088194f604eac3a6b00c48a7fddfdf807571fc.1572306149.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.425.git.1572306149.gitgitgadget@gmail.com>
References: <pull.425.git.1572306149.gitgitgadget@gmail.com>
From:   "george espinoza via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 28 Oct 2019 23:42:29 +0000
Subject: [PATCH 1/1] [Outreachy] merge-ours: include parse-options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     George Espinoza <gespinoz2019@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        george espinoza <gespinoz2019@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: george espinoza <gespinoz2019@gmail.com>

Teach this command which currently handles its own argv to use
parse-options instead because parse-options helps make sure we handle
user input like -h in a standardized way across the project.
Also deleted the NO_PARSEOPT flag from git.c to coincide with
the conversion of the structure in this command since merge-ours
now uses parse-options and needed to update git.c accordingly.

Signed-off-by: george espinoza <gespinoz2019@gmail.com>
---
 builtin/merge-ours.c | 14 ++++++++++----
 git.c                |  2 +-
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/merge-ours.c b/builtin/merge-ours.c
index 4594507420..fb3674a384 100644
--- a/builtin/merge-ours.c
+++ b/builtin/merge-ours.c
@@ -11,14 +11,20 @@
 #include "git-compat-util.h"
 #include "builtin.h"
 #include "diff.h"
+#include "parse-options.h"
 
-static const char builtin_merge_ours_usage[] =
-	"git merge-ours <base>... -- HEAD <remote>...";
+static const char * const merge_ours_usage[] = {
+	N_("git merge-ours [<base>...] -- <head> <merge-head>..."),
+	NULL,
+};
 
 int cmd_merge_ours(int argc, const char **argv, const char *prefix)
 {
-	if (argc == 2 && !strcmp(argv[1], "-h"))
-		usage(builtin_merge_ours_usage);
+	struct option options[] = {
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, merge_ours_usage, 0);
 
 	/*
 	 * The contents of the current index becomes the tree we
diff --git a/git.c b/git.c
index ce6ab0ece2..6aee0e9477 100644
--- a/git.c
+++ b/git.c
@@ -527,7 +527,7 @@ static struct cmd_struct commands[] = {
 	{ "merge-base", cmd_merge_base, RUN_SETUP },
 	{ "merge-file", cmd_merge_file, RUN_SETUP_GENTLY },
 	{ "merge-index", cmd_merge_index, RUN_SETUP | NO_PARSEOPT },
-	{ "merge-ours", cmd_merge_ours, RUN_SETUP | NO_PARSEOPT },
+	{ "merge-ours", cmd_merge_ours, RUN_SETUP },
 	{ "merge-recursive", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-ours", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
 	{ "merge-recursive-theirs", cmd_merge_recursive, RUN_SETUP | NEED_WORK_TREE | NO_PARSEOPT },
-- 
gitgitgadget
