Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.5 required=3.0 tests=AWL,BAYES_00,
	DATE_IN_PAST_96_XX,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE65A1F660
	for <e@80x24.org>; Tue,  3 Jul 2018 11:26:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753213AbeGCL0V (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 07:26:21 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:39554 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753164AbeGCL0R (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 07:26:17 -0400
Received: by mail-pf0-f193.google.com with SMTP id s21-v6so878114pfm.6
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 04:26:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=LiwOXKS5GrJObBAIucgO2K8ULP/2dkEwLXKTmSdXyH4=;
        b=hyuPBwKaTxfSox39sOzk6Qr2UMvBlrs6+WhtfSzt88fsEd2VnBrZY77hT38/X+fFh0
         1+yxI9T+nntjC/hkDxLTuGUGAyijwab0F3cW+O8dwzwD4WXv/ZZdL9kAZBBpN/tIYAIR
         59Ra7Kc2AnMLaz93XsFxcZEe6WMuyuaLQPdwgwC+T7MogrPGBGd76ZQJcPRRIswFx82t
         WsYH/7xH6iDXJjpUWdV26T/e3dcg612H0vSGZbV7AvJUMz81rDOxbvQ6oISSOPPYLMZU
         29buRroex7/RZAKmQeb44x4bSa+SRO832zYGm5rQbUBv4Qkxvi9gPEJ4Aot+dIblO4hy
         eYFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=LiwOXKS5GrJObBAIucgO2K8ULP/2dkEwLXKTmSdXyH4=;
        b=oIuERTyMeQsQfMqXNA6moidpgkYu694aWeEryqEvx9IO3TsqMhNrcWwr2oysYq+TSV
         KbB9VJrqZBU5iuBkShIL1TFcYhWoSq1lVRnBm/wMQ6II1Ipv5qB8EE4RbmFYxEcx2Hxb
         Zid4kP/Fo2tpXRTCLCatYUbow3JavBGMB76DWHcUPb25XtFK0loN+rJqnMNIl6QbDPI/
         Xmk/Gr/8vQ69zaTTaO9G7808Q1KJbeKMaFMoZ431ooHC12Xtjz2CgoJO/e0KVvxcyL/0
         lrbHUsd86Pvc5OnZD5swv5yW9jD0WJfacYIAm0E8L1kuViJd26ne9d0lBdCR4z+N0iZ5
         6tUg==
X-Gm-Message-State: APt69E2iY2zA8jWW0oSj+DpNB0Jwo7gWKjGdvWjESYe3U3zjAkgitZuv
        IUVhm42XByZIFAwxb3pjIVTGJw==
X-Google-Smtp-Source: ADUXVKLEE0SiBJcn8U5EYLCbNrUVp327mrRz74t82tx+VQCzKg2n+wvwDNpIILYgc0LRpr0qeuWD0Q==
X-Received: by 2002:a63:9a01:: with SMTP id o1-v6mr25021780pge.439.1530617176686;
        Tue, 03 Jul 2018 04:26:16 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.139.188])
        by smtp.gmail.com with ESMTPSA id c8-v6sm1766105pgu.19.2018.07.03.04.26.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Jul 2018 04:26:15 -0700 (PDT)
Message-Id: <935cad180184787301975f18f56add409aa445f5.1530617166.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v3.git.gitgitgadget@gmail.com>
References: <cover.1525448066.git.johannes.schindelin@gmx.de>
        <pull.1.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 6 May 2018 17:26:19 +0200
Subject: [PATCH v3 05/20] range-diff: also show the diff between patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

Just like tbdiff, we now show the diff between matching patches. This is
a "diff of two diffs", so it can be a bit daunting to read for the
beginner.

An alternative would be to display an interdiff, i.e. the hypothetical
diff which is the result of first reverting the old diff and then
applying the new diff.

Especially when rebasing often, an interdiff is often not feasible,
though: if the old diff cannot be applied in reverse (due to a moving
upstream), an interdiff can simply not be inferred.

This commit brings `range-diff` closer to feature parity with regard
to tbdiff.

To make `git range-diff` respect e.g. color.diff.* settings, we have
to adjust git_branch_config() accordingly.

Note: while we now parse diff options such as --color, the effect is not
yet the same as in tbdiff, where also the commit pairs would be colored.
This is left for a later commit.

Note also: while tbdiff accepts the `--no-patches` option to suppress
these diffs between patches, we prefer the `-s` option that is
automatically supported via our use of diff_opt_parse().

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 25 +++++++++++++++++++++----
 range-diff.c         | 34 +++++++++++++++++++++++++++++++---
 range-diff.h         |  4 +++-
 3 files changed, 55 insertions(+), 8 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index c37a72100..5f12bbfa9 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "range-diff.h"
+#include "config.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -13,16 +14,31 @@ NULL
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = 60;
+	struct diff_options diffopt = { NULL };
 	struct option options[] = {
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_END()
 	};
-	int res = 0;
+	int i, j, res = 0;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
-	argc = parse_options(argc, argv, NULL, options, builtin_range_diff_usage,
-			     0);
+	git_config(git_diff_ui_config, NULL);
+
+	diff_setup(&diffopt);
+	diffopt.output_format = DIFF_FORMAT_PATCH;
+
+	argc = parse_options(argc, argv, NULL, options,
+			builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	for (i = j = 0; i < argc; i++) {
+		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+
+		if (!c)
+			argv[j++] = argv[i];
+	}
+	argc = j;
+	diff_setup_done(&diffopt);
 
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
@@ -57,7 +73,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_range_diff_usage, options);
 	}
 
-	res = show_range_diff(range1.buf, range2.buf, creation_factor);
+	res = show_range_diff(range1.buf, range2.buf, creation_factor,
+			      &diffopt);
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
diff --git a/range-diff.c b/range-diff.c
index e71cf0ba7..530f2fc32 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -6,6 +6,7 @@
 #include "hashmap.h"
 #include "xdiff-interface.h"
 #include "linear-assignment.h"
+#include "diffcore.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -254,7 +255,31 @@ static const char *short_oid(struct patch_util *util)
 	return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
 }
 
-static void output(struct string_list *a, struct string_list *b)
+static struct diff_filespec *get_filespec(const char *name, const char *p)
+{
+	struct diff_filespec *spec = alloc_filespec(name);
+
+	fill_filespec(spec, &null_oid, 0, 0644);
+	spec->data = (char *)p;
+	spec->size = strlen(p);
+	spec->should_munmap = 0;
+	spec->is_stdin = 1;
+
+	return spec;
+}
+
+static void patch_diff(const char *a, const char *b,
+			      struct diff_options *diffopt)
+{
+	diff_queue(&diff_queued_diff,
+		   get_filespec("a", a), get_filespec("b", b));
+
+	diffcore_std(diffopt);
+	diff_flush(diffopt);
+}
+
+static void output(struct string_list *a, struct string_list *b,
+		   struct diff_options *diffopt)
 {
 	int i = 0, j = 0;
 
@@ -296,6 +321,9 @@ static void output(struct string_list *a, struct string_list *b)
 			printf("%d: %s ! %d: %s\n",
 			       b_util->matching + 1, short_oid(a_util),
 			       j + 1, short_oid(b_util));
+			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
+				patch_diff(a->items[b_util->matching].string,
+					   b->items[j].string, diffopt);
 			a_util->shown = 1;
 			j++;
 		}
@@ -303,7 +331,7 @@ static void output(struct string_list *a, struct string_list *b)
 }
 
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor)
+		    int creation_factor, struct diff_options *diffopt)
 {
 	int res = 0;
 
@@ -318,7 +346,7 @@ int show_range_diff(const char *range1, const char *range2,
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2, creation_factor);
-		output(&branch1, &branch2);
+		output(&branch1, &branch2, diffopt);
 	}
 
 	string_list_clear(&branch1, 1);
diff --git a/range-diff.h b/range-diff.h
index dd30449c4..aea9d43f3 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -1,7 +1,9 @@
 #ifndef BRANCH_DIFF_H
 #define BRANCH_DIFF_H
 
+#include "diff.h"
+
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor);
+		    int creation_factor, struct diff_options *diffopt);
 
 #endif
-- 
gitgitgadget

