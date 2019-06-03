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
	by dcvr.yhbt.net (Postfix) with ESMTP id F23D91F462
	for <e@80x24.org>; Mon,  3 Jun 2019 16:04:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729358AbfFCQEE (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 12:04:04 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:39834 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729254AbfFCQED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 12:04:03 -0400
Received: by mail-wr1-f47.google.com with SMTP id x4so12691254wrt.6
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 09:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WU53fQYzV83Z0/Enc4TFpRxIQTbn1c80CUCVfaTQzv0=;
        b=psn9gy6v7KIOhIGmezdH4vbai50SykoGlpe6kYdfzu6J2IFjrMEUKqV2nng5zJXD55
         Z01wFnCz7hr7K3CRrL/eJQX6PUcd83Aro1fGLyXVuO+E647p0bMAkMaKLqBw5/sl7stP
         IXLe8k1ehrceAfmt3NQw6WWLC7ojTG24z5uolFWYlKns6fmpHrR0JUQaJLNrWW41DDhZ
         0o/lP2/37jOLONiYZvxFUehaIsTXIaH77zND0t3WEqEi9YfIpA5WUcy9PSmQN0SUf2wC
         mgdg63Dr7iAc4YGMwulcTyxGc7G/r6VfmCMSVCvWEwL+db491WiVnD7SSOv2Y7PwnP51
         DGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WU53fQYzV83Z0/Enc4TFpRxIQTbn1c80CUCVfaTQzv0=;
        b=f6EXJTi5Cy94JE7ca5M5h4iuEbvC2hxn4GaoGa+PzDF32Wiv4U/oahPsKxwMp74eXF
         d0Ns5TVSSuUT8AO9hyLl2GjI+6FYTkrqS4oJy7qf/M3Zef3gqvFCwtUm8u95miWRoFc6
         gBp14HzbRAhWB3lzqNrS6OI+rXaIMyWWwj/DbzU5h8EPsxuaYzWUA6WhAdVXTzWkK6BF
         7zqbZkfgn/nP1d3b2gFXM24Y6r+xOwTHdC0bU3j4roSsZ0By9lYgSk2ZfbuK2OxnyoJi
         SnBzaToOgCbk85d+mbQq00ZGw77mKaFVlL/MD/EWcMI9uJICFqC7k9LEOOc7yjq/lrBc
         6nqg==
X-Gm-Message-State: APjAAAVjht4tZcPlyCSLgl8GtkQSI492K9bY73j7BbArcwpMAxMk8ePj
        t8yyZzjhSWhhpg/sGZkYFWQJTJKA
X-Google-Smtp-Source: APXvYqy2IWGfMYoP4j2C/yih+zXyJXR+5H1vgbby4HwpuTRFMzgSBlQknBJFSkPAomwd3Y2IzcLx2g==
X-Received: by 2002:a5d:4950:: with SMTP id r16mr1023533wrs.136.1559577839967;
        Mon, 03 Jun 2019 09:03:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g185sm14477013wmf.30.2019.06.03.09.03.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 09:03:59 -0700 (PDT)
Date:   Mon, 03 Jun 2019 09:03:59 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 16:03:43 GMT
Message-Id: <18d612be9e68a4f406a3c4c3f597024cd973097e.1559577826.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v3.git.gitgitgadget@gmail.com>
References: <pull.184.v2.git.gitgitgadget@gmail.com>
        <pull.184.v3.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 11/14] commit-graph: expire commit-graph files
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
 Documentation/technical/commit-graph.txt | 15 ++++++
 commit-graph.c                           | 69 ++++++++++++++++++++++++
 t/t5323-split-commit-graph.sh            |  2 +-
 3 files changed, 85 insertions(+), 1 deletion(-)

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
index 0b7c186a5d..4cbced7ff4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1637,6 +1637,70 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
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
+
+	}
+}
+
 int write_commit_graph(const char *obj_dir,
 		       struct string_list *pack_indexes,
 		       struct string_list *commit_hex,
@@ -1749,6 +1813,11 @@ int write_commit_graph(const char *obj_dir,
 
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
index fad27dc6e3..ae45329651 100755
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

