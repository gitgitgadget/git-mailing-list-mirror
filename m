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
	by dcvr.yhbt.net (Postfix) with ESMTP id A94E91F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfJ2KAy (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:54 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42211 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbfJ2KAx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:53 -0400
Received: by mail-wr1-f68.google.com with SMTP id a15so622755wrf.9
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=maRAJuup5abJ1hJXrBJ5YMG/weYvOZoneGLFTTC2A8E=;
        b=siwJhSBuoexoIVXAicEMGhpgHIfnOku9+4YkQq4Ga1H51rqC9P4kHrTgbiKXCEJ0OU
         IbIASrmW6nnKqOF6C+oDnfDrQLTrS8w9lurLfiFnulVReEMzaGVnI2ak4sOo0GqYL/He
         2D3UnmG53u/HmKaAnfrcE3w4K8hOsoWn+nGnLkihE10XCPS/BIJ8JoN/rqlekXtn1C/K
         pYjCqj+BPtvbdqzuiLDWEM0TlC+6tsxQPjobPGA1Kaxg41oE/RKB/tt4SzDNH2HAbcIo
         gYmkrvaT4IFUxvEBkRzoqK0ypIy61wTrCQWJQ8po7h6p9LR8H9y7rhvyM4OocfJNfsw2
         3LKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=maRAJuup5abJ1hJXrBJ5YMG/weYvOZoneGLFTTC2A8E=;
        b=SprlxZhZdwErRt3COZmGtoU0eZDGBoE1KPo5h3RqxrOsjEr0x3HpkXWcIEl7cJRkzr
         w8uy+Pu3uCUIEsgc/NXMgzi02nM/58VIDvPLH1PhCzfE12bznybImN+7tJu8/pHl2NDp
         t56foG0GD4fOl7vZ7Rl8JcOxnXp9QpH9injc+dc/d/4aoiK2NwItchh6FmFnG4Udxh1R
         ODAneq8CPmiJjtwNbGWoQ3k/FGn2Sh+6JdDi/3si4XzvznfLqEBYU30dOPohTWjsmmYM
         G6pqmNWkwQ/G64Z4IOd1as+gPCzjh+uxOdq6vGyHfaIjEuGsPhNGyCPuwjE0TP0anKLZ
         CkZw==
X-Gm-Message-State: APjAAAVGiGIobQK5aYhNHtOXDLEABXEV0FMKMGuMFrZMalLRi9HVtmbt
        HE0AAB5alsmagLMwkUNOQYQckVIJ
X-Google-Smtp-Source: APXvYqz0i+pjNZ4G9kWxTAUfGbaK5OT7B7f52PiSdCOxs9XLAgDUHeUlXs63b7yIC3BtDdpuWvBBQA==
X-Received: by 2002:adf:fcc7:: with SMTP id f7mr19462767wrs.345.1572343250563;
        Tue, 29 Oct 2019 03:00:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 11sm1657747wmb.34.2019.10.29.03.00.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:50 -0700 (PDT)
Message-Id: <dabfe5e60baee8fa4c5ff72a832348125fa410b6.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:39 +0000
Subject: [PATCH 03/10] graph: move doc to graph.h and graph.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-history-graph.txt to
graph.h and graph.c as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

The graph library was already well documented, so few comments were added to
both graph.h and graph.c

Also documentation/technical/api-history-graph.txt is removed because
the information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-history-graph.txt | 173 ------------------
 graph.c                                       |   1 +
 graph.h                                       | 121 ++++++++++++
 3 files changed, 122 insertions(+), 173 deletions(-)
 delete mode 100644 Documentation/technical/api-history-graph.txt

diff --git a/Documentation/technical/api-history-graph.txt b/Documentation/technical/api-history-graph.txt
deleted file mode 100644
index d0d1707c8c..0000000000
--- a/Documentation/technical/api-history-graph.txt
+++ /dev/null
@@ -1,173 +0,0 @@
-history graph API
-=================
-
-The graph API is used to draw a text-based representation of the commit
-history.  The API generates the graph in a line-by-line fashion.
-
-Functions
----------
-
-Core functions:
-
-* `graph_init()` creates a new `struct git_graph`
-
-* `graph_update()` moves the graph to a new commit.
-
-* `graph_next_line()` outputs the next line of the graph into a strbuf.  It
-  does not add a terminating newline.
-
-* `graph_padding_line()` outputs a line of vertical padding in the graph.  It
-  is similar to `graph_next_line()`, but is guaranteed to never print the line
-  containing the current commit.  Where `graph_next_line()` would print the
-  commit line next, `graph_padding_line()` prints a line that simply extends
-  all branch lines downwards one row, leaving their positions unchanged.
-
-* `graph_is_commit_finished()` determines if the graph has output all lines
-  necessary for the current commit.  If `graph_update()` is called before all
-  lines for the current commit have been printed, the next call to
-  `graph_next_line()` will output an ellipsis, to indicate that a portion of
-  the graph was omitted.
-
-The following utility functions are wrappers around `graph_next_line()` and
-`graph_is_commit_finished()`.  They always print the output to stdout.
-They can all be called with a NULL graph argument, in which case no graph
-output will be printed.
-
-* `graph_show_commit()` calls `graph_next_line()` and
-  `graph_is_commit_finished()` until one of them return non-zero.  This prints
-  all graph lines up to, and including, the line containing this commit.
-  Output is printed to stdout.  The last line printed does not contain a
-  terminating newline.
-
-* `graph_show_oneline()` calls `graph_next_line()` and prints the result to
-  stdout.  The line printed does not contain a terminating newline.
-
-* `graph_show_padding()` calls `graph_padding_line()` and prints the result to
-  stdout.  The line printed does not contain a terminating newline.
-
-* `graph_show_remainder()` calls `graph_next_line()` until
-  `graph_is_commit_finished()` returns non-zero.  Output is printed to stdout.
-  The last line printed does not contain a terminating newline.  Returns 1 if
-  output was printed, and 0 if no output was necessary.
-
-* `graph_show_strbuf()` prints the specified strbuf to stdout, prefixing all
-  lines but the first with a graph line.  The caller is responsible for
-  ensuring graph output for the first line has already been printed to stdout.
-  (This can be done with `graph_show_commit()` or `graph_show_oneline()`.)  If
-  a NULL graph is supplied, the strbuf is printed as-is.
-
-* `graph_show_commit_msg()` is similar to `graph_show_strbuf()`, but it also
-  prints the remainder of the graph, if more lines are needed after the strbuf
-  ends.  It is better than directly calling `graph_show_strbuf()` followed by
-  `graph_show_remainder()` since it properly handles buffers that do not end in
-  a terminating newline.  The output printed by `graph_show_commit_msg()` will
-  end in a newline if and only if the strbuf ends in a newline.
-
-Data structure
---------------
-`struct git_graph` is an opaque data type used to store the current graph
-state.
-
-Calling sequence
-----------------
-
-* Create a `struct git_graph` by calling `graph_init()`.  When using the
-  revision walking API, this is done automatically by `setup_revisions()` if
-  the '--graph' option is supplied.
-
-* Use the revision walking API to walk through a group of contiguous commits.
-  The `get_revision()` function automatically calls `graph_update()` each time
-  it is invoked.
-
-* For each commit, call `graph_next_line()` repeatedly, until
-  `graph_is_commit_finished()` returns non-zero.  Each call to
-  `graph_next_line()` will output a single line of the graph.  The resulting
-  lines will not contain any newlines.  `graph_next_line()` returns 1 if the
-  resulting line contains the current commit, or 0 if this is merely a line
-  needed to adjust the graph before or after the current commit.  This return
-  value can be used to determine where to print the commit summary information
-  alongside the graph output.
-
-Limitations
------------
-
-* `graph_update()` must be called with commits in topological order.  It should
-  not be called on a commit if it has already been invoked with an ancestor of
-  that commit, or the graph output will be incorrect.
-
-* `graph_update()` must be called on a contiguous group of commits.  If
-  `graph_update()` is called on a particular commit, it should later be called
-  on all parents of that commit.  Parents must not be skipped, or the graph
-  output will appear incorrect.
-+
-`graph_update()` may be used on a pruned set of commits only if the parent list
-has been rewritten so as to include only ancestors from the pruned set.
-
-* The graph API does not currently support reverse commit ordering.  In
-  order to implement reverse ordering, the graphing API needs an
-  (efficient) mechanism to find the children of a commit.
-
-Sample usage
-------------
-
-------------
-struct commit *commit;
-struct git_graph *graph = graph_init(opts);
-
-while ((commit = get_revision(opts)) != NULL) {
-	while (!graph_is_commit_finished(graph))
-	{
-		struct strbuf sb;
-		int is_commit_line;
-
-		strbuf_init(&sb, 0);
-		is_commit_line = graph_next_line(graph, &sb);
-		fputs(sb.buf, stdout);
-
-		if (is_commit_line)
-			log_tree_commit(opts, commit);
-		else
-			putchar(opts->diffopt.line_termination);
-	}
-}
-------------
-
-Sample output
--------------
-
-The following is an example of the output from the graph API.  This output does
-not include any commit summary information--callers are responsible for
-outputting that information, if desired.
-
-------------
-*
-*
-*
-|\
-* |
-| | *
-| \ \
-|  \ \
-*-. \ \
-|\ \ \ \
-| | * | |
-| | | | | *
-| | | | | *
-| | | | | *
-| | | | | |\
-| | | | | | *
-| * | | | | |
-| | | | | *  \
-| | | | | |\  |
-| | | | * | | |
-| | | | * | | |
-* | | | | | | |
-| |/ / / / / /
-|/| / / / / /
-* | | | | | |
-|/ / / / / /
-* | | | | |
-| | | | | *
-| | | | |/
-| | | | *
-------------
diff --git a/graph.c b/graph.c
index f53135485f..eab3af1dc7 100644
--- a/graph.c
+++ b/graph.c
@@ -34,6 +34,7 @@ static void graph_padding_line(struct git_graph *graph, struct strbuf *sb);
  * handle directly. It is assumed that this is the same file handle as the
  * file specified by the graph diff options. This is necessary so that
  * graph_show_strbuf can be called even with a NULL graph.
+ * If a NULL graph is supplied, the strbuf is printed as-is.
  */
 static void graph_show_strbuf(struct git_graph *graph,
 			      FILE *file,
diff --git a/graph.h b/graph.h
index af623390b6..8313e293c7 100644
--- a/graph.h
+++ b/graph.h
@@ -2,6 +2,103 @@
 #define GRAPH_H
 #include "diff.h"
 
+/**
+ * The graph API is used to draw a text-based representation of the commit
+ * history. The API generates the graph in a line-by-line fashion.
+ *
+ * Calling sequence
+ * ----------------
+ *
+ * - Create a `struct git_graph` by calling `graph_init()`.  When using the
+ *   revision walking API, this is done automatically by `setup_revisions()` if
+ *   the '--graph' option is supplied.
+ *
+ * - Use the revision walking API to walk through a group of contiguous commits.
+ *   The `get_revision()` function automatically calls `graph_update()` each time
+ *   it is invoked.
+ *
+ * - For each commit, call `graph_next_line()` repeatedly, until
+ *   `graph_is_commit_finished()` returns non-zero.  Each call to
+ *   `graph_next_line()` will output a single line of the graph.  The resulting
+ *   lines will not contain any newlines.  `graph_next_line()` returns 1 if the
+ *   resulting line contains the current commit, or 0 if this is merely a line
+ *   needed to adjust the graph before or after the current commit.  This return
+ *   value can be used to determine where to print the commit summary information
+ *   alongside the graph output.
+ *
+ * Limitations
+ * -----------
+ * - Check the graph_update() function for its limitations.
+ *
+ * - The graph API does not currently support reverse commit ordering.  In
+ *   order to implement reverse ordering, the graphing API needs an
+ *   (efficient) mechanism to find the children of a commit.
+ *
+ * Sample usage
+ * ------------
+ *
+ * ------------
+ * struct commit *commit;
+ * struct git_graph *graph = graph_init(opts);
+ *
+ * while ((commit = get_revision(opts)) != NULL) {
+ * 	while (!graph_is_commit_finished(graph))
+ * 	{
+ * 		struct strbuf sb;
+ * 		int is_commit_line;
+ *
+ * 		strbuf_init(&sb, 0);
+ * 		is_commit_line = graph_next_line(graph, &sb);
+ * 		fputs(sb.buf, stdout);
+ *
+ * 		if (is_commit_line)
+ * 			log_tree_commit(opts, commit);
+ * 		else
+ * 			putchar(opts->diffopt.line_termination);
+ * 	}
+ * }
+ * ------------
+ * Sample output
+ * -------------
+ *
+ * The following is an example of the output from the graph API.  This output does
+ * not include any commit summary information--callers are responsible for
+ * outputting that information, if desired.
+ * ------------
+ * *
+ * *
+ * *
+ * |\
+ * * |
+ * | | *
+ * | \ \
+ * |  \ \
+ * *-. \ \
+ * |\ \ \ \
+ * | | * | |
+ * | | | | | *
+ * | | | | | *
+ * | | | | | *
+ * | | | | | |\
+ * | | | | | | *
+ * | * | | | | |
+ * | | | | | *  \
+ * | | | | | |\  |
+ * | | | | * | | |
+ * | | | | * | | |
+ * * | | | | | | |
+ * | |/ / / / / /
+ * |/| / / / / /
+ * * | | | | | |
+ * |/ / / / / /
+ * * | | | | |
+ * | | | | | *
+ * | | | | |/
+ * | | | | *
+ * ------------
+ *
+ */
+
 /* A graph is a pointer to this opaque structure */
 struct git_graph;
 
@@ -50,6 +147,21 @@ struct git_graph *graph_init(struct rev_info *opt);
  * If graph_update() is called before graph_is_commit_finished() returns 1,
  * the next call to graph_next_line() will output an ellipsis ("...")
  * to indicate that a portion of the graph is missing.
+ *
+ * Limitations:
+ * -----------
+ *
+ * - `graph_update()` must be called with commits in topological order.  It should
+ *   not be called on a commit if it has already been invoked with an ancestor of
+ *   that commit, or the graph output will be incorrect.
+ *
+ * - `graph_update()` must be called on a contiguous group of commits.  If
+ *   `graph_update()` is called on a particular commit, it should later be called
+ *   on all parents of that commit.  Parents must not be skipped, or the graph
+ *   output will appear incorrect.
+ *
+ * - `graph_update()` may be used on a pruned set of commits only if the parent list
+ *   has been rewritten so as to include only ancestors from the pruned set.
  */
 void graph_update(struct git_graph *graph, struct commit *commit);
 
@@ -62,6 +174,10 @@ void graph_update(struct git_graph *graph, struct commit *commit);
  * for this commit.  If 0 is returned, graph_next_line() may still be
  * called without calling graph_update(), and it will merely output
  * appropriate "vertical padding" in the graph.
+ *
+ * If `graph_update()` is called before all lines for the current commit have
+ * been printed, the next call to `graph_next_line()` will output an ellipsis,
+ * to indicate that a portion of the graph was omitted.
  */
 int graph_is_commit_finished(struct git_graph const *graph);
 
@@ -112,6 +228,7 @@ void graph_show_padding(struct git_graph *graph);
 /*
  * If the graph is non-NULL, print the rest of the history graph for this
  * commit to stdout.  Does not print a terminating newline on the last line.
+ * Returns 1 if output was printed, and 0 if no output was necessary.
  */
 int graph_show_remainder(struct git_graph *graph);
 
@@ -121,6 +238,10 @@ int graph_show_remainder(struct git_graph *graph);
  * This is similar to graph_show_strbuf(), but it always prints the
  * remainder of the graph.
  *
+ * It is better than directly calling `graph_show_strbuf()` followed by
+ * `graph_show_remainder()` since it properly handles buffers that do not end in
+ * a terminating newline.
+ *
  * If the strbuf ends with a newline, the output printed by
  * graph_show_commit_msg() will end with a newline.  If the strbuf is
  * missing a terminating newline (including if it is empty), the output
-- 
gitgitgadget

