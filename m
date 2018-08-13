Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDD621F404
	for <e@80x24.org>; Mon, 13 Aug 2018 11:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728848AbeHMOPB (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 10:15:01 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:38854 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbeHMOPB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 10:15:01 -0400
Received: by mail-pf1-f196.google.com with SMTP id x17-v6so7530857pfh.5
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 04:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xomYHqyc4Bpp4vuadk8X8V1m8GZKva/ZVyqJo+rOXY8=;
        b=Uxzz+jyEJQWzS4SIjzXL68bsi3dv40WSQAjBdSB5XWDKl1uBqKFOabmWg9zvU5qUmE
         ah+sS1huSeu6wms4xg/4rhbW38PV8FofUyOm7rRg7+nOvgQKoqrKJNh7xweLJQkDAb0w
         peg58IKlGEWpzM15OWdTqhn/Z9/fkNb2dboLeHdrvUiunUUGPn9+HYlOoDilcXf1XS/4
         2eupBtqNnKdWlyeyTPPgy242224vV7DwnE/xYlJnac/ddBrfzs9W+f9HLNPT53Yw9L0b
         ej+eKjSSFrNvKYs++HvOEpDOLWP03e4EcCK97k5x0S6VUtgVJ87DSgni1A69E0KC4NFf
         pc9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=xomYHqyc4Bpp4vuadk8X8V1m8GZKva/ZVyqJo+rOXY8=;
        b=VunmYo/dYY6PolZTIAbHuWHA7krEw/f7KkKKHn7U8wCi+4wFxvdGXYRWZ6Yio3zrra
         k3VPOZzq1VbkTP9gNhCXUWjszuGh+DOXw/vnBY94JNSJ1xv3y76iU9fiMs86Zni+EWDA
         4inIxwIwftAct86IwYBQSmKxG/M/9KuJlp+NiWmLpNBWWYp3WGu1WNs7NJqyAgZMPvuW
         WILciTOSVeE/35hVwncl3bpD07+Pzc03Nisz63lOg+NERvwgvdavwTINTHrNo5/BJGDg
         8Wdi0tTh0QFWWJY004/kmXYQgH4fXDKy3SEpRB9INZp+FJSFq+ez2rRRmrGC7iP47UX0
         B3BQ==
X-Gm-Message-State: AOUpUlFZqH2h9licb49/eVxm2Qq/ATinOgavKINMrRsQLp9C5LwPlZrl
        yNDcN5xdIRd/74eHNkhgLAzVFeNB
X-Google-Smtp-Source: AA+uWPy5CR1UA5BQc6Hs2LhvGmr81Cbul4HzG8KUW2mPtx5qo98ghLMxObYWjpAI2uZVymdK7aO69g==
X-Received: by 2002:a62:c90a:: with SMTP id k10-v6mr18333272pfg.180.1534159988053;
        Mon, 13 Aug 2018 04:33:08 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id i192-v6sm24112467pfe.188.2018.08.13.04.33.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 04:33:07 -0700 (PDT)
Date:   Mon, 13 Aug 2018 04:33:07 -0700 (PDT)
X-Google-Original-Date: Mon, 13 Aug 2018 11:32:40 GMT
Message-Id: <8515d2f75c5439bcc38ea1a9f5a57b89cd8945d7.1534159977.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v6.git.gitgitgadget@gmail.com>
References: <pull.1.v5.git.gitgitgadget@gmail.com>
        <pull.1.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 05/21] range-diff: also show the diff between patches
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
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

Especially when rebasing frequently, an interdiff is often not feasible,
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
these diffs between patches, we prefer the `-s` (or `--no-patch`) option
that is automatically supported via our use of diff_opt_parse().

And finally note: to support diff options, we have to call
`parse_options()` such that it keeps unknown options, and then loop over
those and let `diff_opt_parse()` handle them. After that loop, we have
to call `parse_options()` again, to make sure that no unknown options
are left.

Helped-by: Thomas Gummerer <t.gummerer@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/range-diff.c | 31 +++++++++++++++++++++++++++++--
 range-diff.c         | 34 +++++++++++++++++++++++++++++++---
 range-diff.h         |  4 +++-
 3 files changed, 63 insertions(+), 6 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 94c1f362c..3b06ed944 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "range-diff.h"
+#include "config.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -13,15 +14,40 @@ NULL
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
 
+	git_config(git_diff_ui_config, NULL);
+
+	diff_setup(&diffopt);
+	diffopt.output_format = DIFF_FORMAT_PATCH;
+
 	argc = parse_options(argc, argv, NULL, options,
+			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN |
+			     PARSE_OPT_KEEP_DASHDASH | PARSE_OPT_KEEP_ARGV0);
+
+	for (i = j = 1; i < argc && strcmp("--", argv[i]); ) {
+		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+
+		if (!c)
+			argv[j++] = argv[i++];
+		else
+			i += c;
+	}
+	while (i < argc)
+		argv[j++] = argv[i++];
+	argc = j;
+	diff_setup_done(&diffopt);
+
+	/* Make sure that there are no unparsed options */
+	argc = parse_options(argc, argv, NULL,
+			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
 			     builtin_range_diff_usage, 0);
 
 	if (argc == 2) {
@@ -59,7 +85,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		usage_with_options(builtin_range_diff_usage, options);
 	}
 
-	res = show_range_diff(range1.buf, range2.buf, creation_factor);
+	res = show_range_diff(range1.buf, range2.buf, creation_factor,
+			      &diffopt);
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
diff --git a/range-diff.c b/range-diff.c
index 2d94200d3..71883a4b7 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -6,6 +6,7 @@
 #include "hashmap.h"
 #include "xdiff-interface.h"
 #include "linear-assignment.h"
+#include "diffcore.h"
 
 struct patch_util {
 	/* For the search for an exact match */
@@ -258,7 +259,31 @@ static const char *short_oid(struct patch_util *util)
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
 
@@ -300,6 +325,9 @@ static void output(struct string_list *a, struct string_list *b)
 			printf("%d: %s ! %d: %s\n",
 			       b_util->matching + 1, short_oid(a_util),
 			       j + 1, short_oid(b_util));
+			if (!(diffopt->output_format & DIFF_FORMAT_NO_OUTPUT))
+				patch_diff(a->items[b_util->matching].string,
+					   b->items[j].string, diffopt);
 			a_util->shown = 1;
 			j++;
 		}
@@ -307,7 +335,7 @@ static void output(struct string_list *a, struct string_list *b)
 }
 
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor)
+		    int creation_factor, struct diff_options *diffopt)
 {
 	int res = 0;
 
@@ -322,7 +350,7 @@ int show_range_diff(const char *range1, const char *range2,
 	if (!res) {
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2, creation_factor);
-		output(&branch1, &branch2);
+		output(&branch1, &branch2, diffopt);
 	}
 
 	string_list_clear(&branch1, 1);
diff --git a/range-diff.h b/range-diff.h
index 7b6eef303..2407d46a3 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -1,7 +1,9 @@
 #ifndef RANGE_DIFF_H
 #define RANGE_DIFF_H
 
+#include "diff.h"
+
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor);
+		    int creation_factor, struct diff_options *diffopt);
 
 #endif
-- 
gitgitgadget

