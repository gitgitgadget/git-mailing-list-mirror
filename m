Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 35A1F1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:04:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbeGUW7J (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 18:59:09 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33703 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728101AbeGUW7J (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 18:59:09 -0400
Received: by mail-pg1-f193.google.com with SMTP id r5-v6so9549510pgv.0
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 15:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fPwIMj6lHa+4eqUDLIwqr9Fk+ABBF2QZ5TRUvVFQn0k=;
        b=Y4ALSrxovEftRPdpKxBzsS7cgfdM+B1kE1UZpWLFaRBkUCCF/JhZIY55U5t/HdQuQy
         rWglbNY+sE5lYtBuSy2cPWqzdhQoqKM715ECNkKFn6GhL8r1+UNc2HOU8VVs76Me7iAU
         xRs48oTfr17OHKWUR5YQGmAeR9f+C4G6n1g7IWXq+SovuMgdr7J0Y37vAFwxHiyFDWDT
         jB9z/sfG25z2yPkbJaa7QZv9Ji4zRb9YlEt0PRa1dBKlDFohcn6dmp/uvWEss/fmCls1
         C3qYnqLZxh9HA3FXpQhtsJeZ9FqpbmaSLgzzqD9KUOUA6/Wnha+N/gwJnyrNvacKnzGq
         2cRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fPwIMj6lHa+4eqUDLIwqr9Fk+ABBF2QZ5TRUvVFQn0k=;
        b=U5nTpKXnLdssB6MVBALZHTVyoTEcJ6azfn9DjDsPbk4yFh162GFSrGGADeF7NNlX5R
         p5D8/SIljnHrPGR+QIqZ/0/mQgpJVlDfaip63VfDkr9A5NZXxxP/JO10lLMLvMAUhHG/
         FJuEaz4Jc+8HBG/sZA85/pH9bbV78dsmva3ZX7BHQ6V5/MGcNXjO0rbmz+1Q5ApYtIDJ
         ToL+PjEmZwkppuWWRBdHd3lEKI8D6NTSwB3OfJj/CYvcfyoiHfJsMJLvaPBsKoBOTo9u
         tNBolF6AaNqejazQ6+13Rq4fEPdwbmBBskk9vG8Gk2Wvwec4IessBjLu6HIx3EiKnEaj
         wA5w==
X-Gm-Message-State: AOUpUlEaS7f+5rwOrpigL/izkBHgXYZ1QWipcMQ5+F1e3Nsp2Y8lmy8I
        JT68T9Ksgd37tYzs9ZdiaReuMlel
X-Google-Smtp-Source: AAOMgpeyCvlfinss6K8VHZNMhNeEWVuJUKU5QRDscscVmSITlfQPwI/nyn+4ZoCsslzHfmc/CaqG4A==
X-Received: by 2002:a63:df04:: with SMTP id u4-v6mr6826070pgg.434.1532210692683;
        Sat, 21 Jul 2018 15:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id a20-v6sm3749028pfc.14.2018.07.21.15.04.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 15:04:51 -0700 (PDT)
Date:   Sat, 21 Jul 2018 15:04:51 -0700 (PDT)
X-Google-Original-Date: Sat, 21 Jul 2018 22:04:26 GMT
Message-Id: <94afaeaf224563effda7b3c0b8939567302d2ba1.1532210683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v4.git.gitgitgadget@gmail.com>
References: <pull.1.v3.git.gitgitgadget@gmail.com>
        <pull.1.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 05/21] range-diff: also show the diff between patches
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
 builtin/range-diff.c | 25 ++++++++++++++++++++++---
 range-diff.c         | 34 +++++++++++++++++++++++++++++++---
 range-diff.h         |  4 +++-
 3 files changed, 56 insertions(+), 7 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 3881da246..093202117 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "range-diff.h"
+#include "config.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -13,16 +14,33 @@ NULL
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
-			     builtin_range_diff_usage, 0);
+			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
+
+	for (i = j = 0; i < argc; ) {
+		int c = diff_opt_parse(&diffopt, argv + i, argc - i, prefix);
+
+		if (!c)
+			argv[j++] = argv[i++];
+		else
+			i += c;
+	}
+	argc = j;
+	diff_setup_done(&diffopt);
 
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
@@ -57,7 +75,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
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

