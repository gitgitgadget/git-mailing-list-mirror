Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2EA561F462
	for <e@80x24.org>; Thu,  6 Jun 2019 14:15:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728772AbfFFOPn (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 10:15:43 -0400
Received: from mail-ed1-f43.google.com ([209.85.208.43]:44883 "EHLO
        mail-ed1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728284AbfFFOPk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 10:15:40 -0400
Received: by mail-ed1-f43.google.com with SMTP id k8so1477847edr.11
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 07:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KvLOYOZ/d0Zd5E4eyx+HpvWOdpjd6kxZgN+arkIiYH0=;
        b=MVNSAXZY8gE+6Z0WZ5kRSSSWQyW1D26KS4EifymJvnnxuKRwSjNkV65O4Ita87J9z9
         /pl5bB7b7p9OabR6XugVyNspnsHoO9wkfyA5W/r6LaIR7osbaGOlxxMpTgVoXlV4u2uD
         s8Ghm9uFYc7zYao4oxi7M502yPek4z88xqmR4FHsaGQRUK/PCnWU7+rbSD1yZxaNjpPO
         EtjIz8m8ndDqnsYGN/MTtk9TaxWU6lGxBUevPWjST8wWkqLDud2d49KMmn0mtWjz9+UH
         RLeIqZ/735X9CAEakaddEqoHRdANGkPPKJcjb7XGmVkJLxmGL11sTUcbFEeA+U+6125M
         D01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KvLOYOZ/d0Zd5E4eyx+HpvWOdpjd6kxZgN+arkIiYH0=;
        b=oz4ZjiVS/SvNrASmWMNcAnDwlHiuqpTgbEcGHwYemLpZaNBTAJ3pbmMJf2Q+rQWO6H
         /fNIkP3Pzk8lhIpS/KqdO+P8pOgAISgc371UXsxTb/IWXcs9O0bJ14zeWN0wfDvhGELi
         Sd3HiOTYV77WIy/sFHSoICJ8fPkdM0bzQrsJcI01xpdVd8FaMemthbyI1S77t46IJ8fk
         hel70ZsOl/8jOyr8Y8PzCkEYm7MQSj0Jg8SewQcddIsG9iloyxSnTNcu7z9I39qUZwkx
         uGwqKBKEXZ5s4MUFAO1t150e22m1zrPDohj9vXtPi4FWGzVxbrXF9QFeIvuEmQhbXT+X
         UgFw==
X-Gm-Message-State: APjAAAWqAeft6WZQ0vlT94YEry1uYPUy7IQxyeCpDWNIsu9c44Wi1qY5
        I0GDYA7q+XktNZ0koPmK0Ly1QTVD
X-Google-Smtp-Source: APXvYqxhV/fuuWSA76cTo5RGj5beRedDvklUZ1Ib5K/CYFWcJ8fVy1rAQ6NAnG4Ed/Lr1PHk9bfDKg==
X-Received: by 2002:a17:906:491b:: with SMTP id b27mr42047012ejq.234.1559830538947;
        Thu, 06 Jun 2019 07:15:38 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cd8sm97457ejb.25.2019.06.06.07.15.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Jun 2019 07:15:38 -0700 (PDT)
Date:   Thu, 06 Jun 2019 07:15:38 -0700 (PDT)
X-Google-Original-Date: Thu, 06 Jun 2019 14:15:24 GMT
Message-Id: <b5aeeed909c1f02086b7be1149d92ca1f961e358.1559830527.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v4.git.gitgitgadget@gmail.com>
References: <pull.184.v3.git.gitgitgadget@gmail.com>
        <pull.184.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 11/14] commit-graph: expire commit-graph files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        johannes.schindelin@gmx.de, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

As we merge commit-graph files in a commit-graph chain, we should clean
up the files that are no longer used.

This change introduces an 'expiry_window' value to the context, which is
always zero (for now). We then check the modified time of each
graph-{hash}.graph file in the $OBJDIR/info/commit-graphs folder and
unlink the files that are older than the expiry_window.

Since this is always zero, this immediately clears all unused graph
files. We will update the value to match a config setting in a future
change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/technical/commit-graph.txt | 15 +++++
 commit-graph.c                           | 79 +++++++++++++++++++++++-
 t/t5323-split-commit-graph.sh            |  2 +-
 3 files changed, 94 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index 473032e476..aed4350a59 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -266,6 +266,21 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
 number of commits) could be extracted into config settings for full
 flexibility.
 
+## Deleting graph-{hash} files
+
+After a new tip file is written, some `graph-{hash}` files may no longer
+be part of a chain. It is important to remove these files from disk, eventually.
+The main reason to delay removal is that another process could read the
+`commit-graph-chain` file before it is rewritten, but then look for the
+`graph-{hash}` files after they are deleted.
+
+To allow holding old split commit-graphs for a while after they are unreferenced,
+we update the modified times of the files when they become unreferenced. Then,
+we scan the `$OBJDIR/info/commit-graphs/` directory for `graph-{hash}`
+files whose modified times are older than a given expiry window. This window
+defaults to zero, but can be changed using command-line arguments or a config
+setting.
+
 ## Chains across multiple object directories
 
 In a repo with alternates, we look for the `commit-graph-chain` file starting
diff --git a/commit-graph.c b/commit-graph.c
index 39d986bb29..6409e5ed8d 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -500,9 +500,18 @@ int generation_numbers_enabled(struct repository *r)
 	return !!first_generation;
 }
 
+static void close_commit_graph_one(struct commit_graph *g)
+{
+	if (!g)
+		return;
+
+	close_commit_graph_one(g->base_graph);
+	free_commit_graph(g);
+}
+
 void close_commit_graph(struct repository *r)
 {
-	free_commit_graph(r->objects->commit_graph);
+	close_commit_graph_one(r->objects->commit_graph);
 	r->objects->commit_graph = NULL;
 }
 
@@ -1641,6 +1650,69 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
 	deduplicate_commits(ctx);
 }
 
+static void mark_commit_graphs(struct write_commit_graph_context *ctx)
+{
+	uint32_t i;
+	time_t now = time(NULL);
+
+	for (i = ctx->num_commit_graphs_after - 1; i < ctx->num_commit_graphs_before; i++) {
+		struct stat st;
+		struct utimbuf updated_time;
+
+		stat(ctx->commit_graph_filenames_before[i], &st);
+
+		updated_time.actime = st.st_atime;
+		updated_time.modtime = now;
+		utime(ctx->commit_graph_filenames_before[i], &updated_time);
+	}
+}
+
+static void expire_commit_graphs(struct write_commit_graph_context *ctx)
+{
+	struct strbuf path = STRBUF_INIT;
+	DIR *dir;
+	struct dirent *de;
+	size_t dirnamelen;
+	time_t expire_time = time(NULL);
+
+	strbuf_addstr(&path, ctx->obj_dir);
+	strbuf_addstr(&path, "/info/commit-graphs");
+	dir = opendir(path.buf);
+
+	if (!dir) {
+		strbuf_release(&path);
+		return;
+	}
+
+	strbuf_addch(&path, '/');
+	dirnamelen = path.len;
+	while ((de = readdir(dir)) != NULL) {
+		struct stat st;
+		uint32_t i, found = 0;
+
+		strbuf_setlen(&path, dirnamelen);
+		strbuf_addstr(&path, de->d_name);
+
+		stat(path.buf, &st);
+
+		if (st.st_mtime > expire_time)
+			continue;
+		if (path.len < 6 || strcmp(path.buf + path.len - 6, ".graph"))
+			continue;
+
+		for (i = 0; i < ctx->num_commit_graphs_after; i++) {
+			if (!strcmp(ctx->commit_graph_filenames_after[i],
+				    path.buf)) {
+				found = 1;
+				break;
+			}
+		}
+
+		if (!found)
+			unlink(path.buf);
+	}
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1753,6 +1825,11 @@ int write_commit_graph(const char *obj_dir,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->split) {
+		mark_commit_graphs(ctx);
+		expire_commit_graphs(ctx);
+	}
+
 cleanup:
 	free(ctx->graph_name);
 	free(ctx->commits.list);
diff --git a/t/t5323-split-commit-graph.sh b/t/t5323-split-commit-graph.sh
index cd4d5f05b6..c6bb685eb9 100755
--- a/t/t5323-split-commit-graph.sh
+++ b/t/t5323-split-commit-graph.sh
@@ -141,7 +141,7 @@ test_expect_success 'add one commit, write a merged graph' '
 	test_path_is_file $graphdir/commit-graph-chain &&
 	test_line_count = 2 $graphdir/commit-graph-chain &&
 	ls $graphdir/graph-*.graph >graph-files &&
-	test_line_count = 4 graph-files &&
+	test_line_count = 2 graph-files &&
 	verify_chain_files_exist $graphdir
 '
 
-- 
gitgitgadget

