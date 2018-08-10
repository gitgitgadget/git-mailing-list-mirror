Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6BF1B1F404
	for <e@80x24.org>; Fri, 10 Aug 2018 22:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727196AbeHKAqU (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:46:20 -0400
Received: from mail-pl0-f43.google.com ([209.85.160.43]:41371 "EHLO
        mail-pl0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbeHKAqT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:46:19 -0400
Received: by mail-pl0-f43.google.com with SMTP id w19-v6so4571308ply.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 15:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/ChyEXnngtcIF6XtHHRnYGg4vUqGmZ7FEfkiFCGH16c=;
        b=HwumedU0vxniYZkWrgDB3PkzvYTKc/6bh1jme2H08X+ZSf/CkGjf6lSs96wnfwaTAU
         KVEod8OyWWp1QzTF7OttEymid7j6h3ydHz4xB16/IepHTH7eveLK/PvKb3kBGsEdhDjm
         7lOkooYgaoL4bC3VOO0pT0GP6etkarTD3c/SMuqCfmkC7ltpDDe8W7H2oolbiB2X7dSf
         4zVKrZARzBGEX+ZNq/mnEcF3zLPJWd5eB6qw/fKPzgQUahJ5vUy7uc+kV05vpGdiJjuC
         nkqBxXXRjmEnVFz+STep+U5ApWHdbBMUiyfTUeMJBNdMIxHGMOe5/G3xR5s48ag8DC/6
         sk0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/ChyEXnngtcIF6XtHHRnYGg4vUqGmZ7FEfkiFCGH16c=;
        b=FjhkDDtD/htsaGZVCekB2QFEMMw7GZ6eFp++dUOEbeaVdy8q9ehlweyz86sDThJDo/
         WtX3pOYsF4EqVltFlGObYSVAHB4mVZoqYWgFx9UMzmcbkPJGIHv13fe2fK2HJsaobrIH
         DBdv2hK59jch0hcK0cXcvSjOwMfoWCVs7+CDvnupvD0oUuWjPITXCsyef4FArxFHXXY0
         rYm3HFOrMUyNRzp2NlEjMkz++sN4AxyuJXOSXbCz+7NP2hl9yfXWU0zcspADHPDrJZqC
         C8rBUwVR1NUiP3FYvWAZ8gXKMnWg9wJ2FtC/4V59DhpRqYPEaEQXrtqXsDFo2G3zqBdO
         lkxg==
X-Gm-Message-State: AOUpUlFe69OgUZLk4xFhSftfNPh6AvhCpgK/760H1kqJY+Ayg9qS+78b
        /xNcnccrjkI0tI6346Xr3L39y0nn
X-Google-Smtp-Source: AA+uWPzbuPF7zzA9680NxaZLia8rark+SSDC97o84GNZeFSZoK2WjUyrHE+iY0b+rQHSO3cGct+tOw==
X-Received: by 2002:a17:902:262:: with SMTP id 89-v6mr7591866plc.221.1533939273760;
        Fri, 10 Aug 2018 15:14:33 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id d9-v6sm16979989pfb.86.2018.08.10.15.14.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 15:14:32 -0700 (PDT)
Date:   Fri, 10 Aug 2018 15:14:32 -0700 (PDT)
X-Google-Original-Date: Fri, 10 Aug 2018 22:14:07 GMT
Message-Id: <9e1e660077d41c479ae46eb07371204c01dff4cd.1533939264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1.v5.git.gitgitgadget@gmail.com>
References: <pull.1.v4.git.gitgitgadget@gmail.com>
        <pull.1.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 05/21] range-diff: also show the diff between patches
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
 builtin/range-diff.c | 29 +++++++++++++++++++++++++++--
 range-diff.c         | 34 +++++++++++++++++++++++++++++++---
 range-diff.h         |  4 +++-
 3 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 94c1f362c..19192ab31 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -2,6 +2,7 @@
 #include "builtin.h"
 #include "parse-options.h"
 #include "range-diff.h"
+#include "config.h"
 
 static const char * const builtin_range_diff_usage[] = {
 N_("git range-diff [<options>] <old-base>..<old-tip> <new-base>..<new-tip>"),
@@ -13,15 +14,38 @@ NULL
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
+	argc = j;
+	diff_setup_done(&diffopt);
+
+	/* Make sure that there are no unparsed options */
+	argc = parse_options(argc, argv, NULL,
+			     options + ARRAY_SIZE(options) - 1, /* OPT_END */
 			     builtin_range_diff_usage, 0);
 
 	if (argc == 2) {
@@ -59,7 +83,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
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

