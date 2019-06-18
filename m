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
	by dcvr.yhbt.net (Postfix) with ESMTP id B6BC91F609
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbfFRSOk (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:36245 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730317AbfFRSOj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:39 -0400
Received: by mail-ed1-f67.google.com with SMTP id k21so23051045edq.3
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=s6hwus4MFxwpAFme33TMV55sc7MIbiMaLJuR5KcNYmI=;
        b=ZDNq5uU2uzLp9D7KKpu9sg+txDTqJ6tWtKcO5B2pjTXJF+blME8ipAbh0a38hcjbBK
         0L5ptISb7ZteSNmBqZIujAWtDoHbOrpRCJGvMkHQlXpsXrLcsD8/45RHUlqHmIaFVwKU
         rLYa/AMbbFg1Urx9EcxkIufprWcB09wE9XB2Wyr0x3JlrloRvnJ6kkeiBH/GeVITWYvU
         5ZBFc10ZJLy5XoD4z8d/XuXnSyzPCt8FCHrqVJ51AiRSTR1mec7BSkJ+OhlN6szvjwbK
         Wc2qRE8rJUupAqj1z9HS1z77AKXpnwCGiSXHzrQGqvY0JHOj3PFPOGbeZI+AFpj2wIHL
         PcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=s6hwus4MFxwpAFme33TMV55sc7MIbiMaLJuR5KcNYmI=;
        b=lFBpO6TZOtkE4Ne7ZsOChqz2r77ptwnrlKQRsAjKdvm8Z9H/wlCqSDf7czzcAhCtO3
         yhADFIo6dPWKQgxzAK/vmBU6K4DjhJRHkX3w/C9eRMl7jz8f0S5OoCz7KKs3sKl4wIjC
         00cONaiY3EPsxDtsOSL92Rvc8/qP9xmihJeewWkbs3x3YPp8yFy7bZMLJgKBf6L487zP
         JLelL0zmQ6ya/SRIsiPZ2Du3RMcmsFHZ6ubs/Vmyvlvc+Ev8ryFllglJ+mYMKCHTyrcA
         CwzWBxEPCdbwIXBBslRz1xK1itviprAHV7ig+pBX4+CQjMvPZ1MaoBYD9DhD2gXK3gl0
         X+Sw==
X-Gm-Message-State: APjAAAVBT4I51yCkwoHzGlS4cYpSllpH3cYG0BiPOXyc6tgllW/LKsIR
        iR1/iWlGrVUmh92zXRkpnsDThcug
X-Google-Smtp-Source: APXvYqxrrf6Z6vDlQQW3YGEJJp/bF/fsqkzSQzwHEpRvPWNsTu9EqrH3pu0Df0s2/GXgVA+HQ6dA+w==
X-Received: by 2002:a50:addc:: with SMTP id b28mr30971818edd.174.1560881676545;
        Tue, 18 Jun 2019 11:14:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y11sm5031166edj.96.2019.06.18.11.14.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:36 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:36 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:19 GMT
Message-Id: <fba62e7a42df630653092265999fb4a6e5aab81d.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 17/18] commit-graph: normalize commit-graph filenames
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, philipoakley@iee.org,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When writing commit-graph files, we append path data to an
object directory, which may be specified by the user via the
'--object-dir' option. If the user supplies a trailing slash,
or some other alternative path format, the resulting path may
be usable for writing to the correct location. However, when
expiring graph files from the <obj-dir>/info/commit-graphs
directory during a write, we need to compare paths with exact
string matches.

Normalize the commit-graph filenames to avoid ambiguity. This
creates extra allocations, but this is a constant multiple of
the number of commit-graph files, which should be a number in
the single digits.

Further normalize the object directory in the context. Due to
a comparison between g->obj_dir and ctx->obj_dir in
split_graph_merge_strategy(), a trailing slash would prevent
any merging of layers within the same object directory. The
check is there to ensure we do not merge across alternates.
Update the tests to include a case with this trailing slash
problem.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c                | 30 +++++++++++++++++++++++-------
 t/t5324-split-commit-graph.sh |  7 ++++++-
 2 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index 3599ae664d..c91e6f0fb8 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -43,15 +43,23 @@
 
 char *get_commit_graph_filename(const char *obj_dir)
 {
-	return xstrfmt("%s/info/commit-graph", obj_dir);
+	char *filename = xstrfmt("%s/info/commit-graph", obj_dir);
+	char *normalized = xmalloc(strlen(filename) + 1);
+	normalize_path_copy(normalized, filename);
+	free(filename);
+	return normalized;
 }
 
 static char *get_split_graph_filename(const char *obj_dir,
 				      const char *oid_hex)
 {
-	return xstrfmt("%s/info/commit-graphs/graph-%s.graph",
-		       obj_dir,
-		       oid_hex);
+	char *filename = xstrfmt("%s/info/commit-graphs/graph-%s.graph",
+				 obj_dir,
+				 oid_hex);
+	char *normalized = xmalloc(strlen(filename) + 1);
+	normalize_path_copy(normalized, filename);
+	free(filename);
+	return normalized;
 }
 
 static char *get_chain_filename(const char *obj_dir)
@@ -746,7 +754,7 @@ struct packed_oid_list {
 
 struct write_commit_graph_context {
 	struct repository *r;
-	const char *obj_dir;
+	char *obj_dir;
 	char *graph_name;
 	struct packed_oid_list oids;
 	struct packed_commit_list commits;
@@ -1729,7 +1737,6 @@ static void expire_commit_graphs(struct write_commit_graph_context *ctx)
 
 		if (!found)
 			unlink(path.buf);
-
 	}
 }
 
@@ -1741,6 +1748,7 @@ int write_commit_graph(const char *obj_dir,
 {
 	struct write_commit_graph_context *ctx;
 	uint32_t i, count_distinct = 0;
+	size_t len;
 	int res = 0;
 
 	if (!commit_graph_compatible(the_repository))
@@ -1748,7 +1756,14 @@ int write_commit_graph(const char *obj_dir,
 
 	ctx = xcalloc(1, sizeof(struct write_commit_graph_context));
 	ctx->r = the_repository;
-	ctx->obj_dir = obj_dir;
+
+	/* normalize object dir with no trailing slash */
+	ctx->obj_dir = xmallocz(strlen(obj_dir) + 1);
+	normalize_path_copy(ctx->obj_dir, obj_dir);
+	len = strlen(ctx->obj_dir);
+	if (len && ctx->obj_dir[len - 1] == '/')
+		ctx->obj_dir[len - 1] = 0;
+
 	ctx->append = flags & COMMIT_GRAPH_APPEND ? 1 : 0;
 	ctx->report_progress = flags & COMMIT_GRAPH_PROGRESS ? 1 : 0;
 	ctx->split = flags & COMMIT_GRAPH_SPLIT ? 1 : 0;
@@ -1856,6 +1871,7 @@ int write_commit_graph(const char *obj_dir,
 	free(ctx->graph_name);
 	free(ctx->commits.list);
 	free(ctx->oids.list);
+	free(ctx->obj_dir);
 
 	if (ctx->commit_graph_filenames_after) {
 		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 130f2baf44..fc0d00751c 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -163,7 +163,12 @@ test_expect_success 'create fork and chain across alternate' '
 		test_line_count = 1 graph-files &&
 		git -c core.commitGraph=true  rev-list HEAD >expect &&
 		git -c core.commitGraph=false rev-list HEAD >actual &&
-		test_cmp expect actual
+		test_cmp expect actual &&
+		test_commit 14 &&
+		git commit-graph write --reachable --split --object-dir=.git/objects/ &&
+		test_line_count = 3 $graphdir/commit-graph-chain &&
+		ls $graphdir/graph-*.graph >graph-files &&
+		test_line_count = 1 graph-files
 	)
 '
 
-- 
gitgitgadget

