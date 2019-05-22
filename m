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
	by dcvr.yhbt.net (Postfix) with ESMTP id D3ACA20380
	for <e@80x24.org>; Wed, 22 May 2019 19:53:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732171AbfEVTxg (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 May 2019 15:53:36 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37805 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731083AbfEVTxd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 May 2019 15:53:33 -0400
Received: by mail-ed1-f68.google.com with SMTP id w37so5509039edw.4
        for <git@vger.kernel.org>; Wed, 22 May 2019 12:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C9sLuY2YCBwkoZIRW3SqUKunyIZfhsYOcMsOQgvfxEs=;
        b=Jwjr1kLmrv9o2p91de/EEg+xSa71dM91cyxn4J3sxKMr4iOTp/qcl5DroKtcesw+SX
         I14Hy+erVXWfk7l6G7ggPAJaNwJMtPEIHhaiwxLve7wbzTa+/TidqWTdvse6HQE50moP
         eRk8Wxx9Dw/anUdV8yjQtZFToXqON59e4kr9vzlXuXMVMmZ+hva7wSdwAVwV20SiI8Zb
         k4cvdJzEC3yKiPhg9EcnnEXvmgbxCBC33vCbRFz5zK5O5pLwMjldfkQbD13WrmHxw4ni
         D2UEVuLJp9WUy60lYCESHamtpTSm3ijyWQxASkqx0azMxYPrvrX0DX2thzNkTL/m4y5t
         ldRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C9sLuY2YCBwkoZIRW3SqUKunyIZfhsYOcMsOQgvfxEs=;
        b=PWmJC8mIE4zl8AxI07kHh3E0bxwKhEHDQ6n3P1x04a+liTGIKZMHO9TApXAqRcdkVQ
         WldHAMEhEHQ2LDnnYhVEO/5+WYZF2JkDapbnBRAVZucPT1HyY+8srxfm5l2qNKzHeSrE
         FiBBG8VvRWkBX/YHjYnRm1jE116EvAaJitePucIy6/d09q3oQtq0Us9zYGb9HnaGaiPo
         Nnn6+6XJxveu8nA0j/i1voK4a5KCY7BVgxij6suSlpTW/9FllDCD/C6jA/a7wgMCwWok
         oEIBDTkr638jcSHKDaC5cGRZWbgq5/bkAlGEH3TdlRpHzYT+cf7PD57cj2B6jmf5De74
         Kzkw==
X-Gm-Message-State: APjAAAUWRGNTCSPkwo6Fv6hLnV7d+nmf/uNXR5mt6GY0yEoPZjkQqepO
        DQuam9vhIdpvWXOc3OuO1fqKN+ru
X-Google-Smtp-Source: APXvYqyJDq/4zp9kx6HXxotK7/uUiGmcb0NGcuxaGQGvcW7r5p935aWGAH/tPb9mZ6KwAZRAgJTwXw==
X-Received: by 2002:aa7:da8f:: with SMTP id q15mr90718216eds.54.1558554811314;
        Wed, 22 May 2019 12:53:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p8sm1663264eju.5.2019.05.22.12.53.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 May 2019 12:53:30 -0700 (PDT)
Date:   Wed, 22 May 2019 12:53:30 -0700 (PDT)
X-Google-Original-Date: Wed, 22 May 2019 19:53:20 GMT
Message-Id: <72fc0a1f17e006fa4de4dd56209364d7430b02d9.1558554800.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v2.git.gitgitgadget@gmail.com>
References: <pull.184.git.gitgitgadget@gmail.com>
        <pull.184.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 11/11] commit-graph: expire commit-graph files
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, git@jeffhostetler.com,
        jrnieder@google.com, steadmon@google.com,
        Junio C Hamano <gitster@pobox.com>,
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
 commit-graph.c                           | 71 ++++++++++++++++++++++++
 t/t5323-split-commit-graph.sh            |  2 +-
 3 files changed, 87 insertions(+), 1 deletion(-)

diff --git a/Documentation/technical/commit-graph.txt b/Documentation/technical/commit-graph.txt
index b6fe8b2321..4ecec54148 100644
--- a/Documentation/technical/commit-graph.txt
+++ b/Documentation/technical/commit-graph.txt
@@ -267,6 +267,21 @@ The merge strategy values (2 for the size multiple, 64,000 for the maximum
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
index 0d8b942e2b..69c4f83c2a 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -739,6 +739,8 @@ struct write_commit_graph_context {
 	unsigned append:1,
 		 report_progress:1,
 		 split:1;
+
+	time_t expire_window;
 };
 
 static void write_graph_chunk_fanout(struct hashfile *f,
@@ -1629,6 +1631,70 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
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
+	time_t expire_time = time(NULL) - ctx->expire_window;
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
+
+	}
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1741,6 +1807,11 @@ int write_commit_graph(const char *obj_dir,
 
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
index ed5cac8617..6215efcac5 100755
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
