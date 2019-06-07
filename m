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
	by dcvr.yhbt.net (Postfix) with ESMTP id A57CE1F609
	for <e@80x24.org>; Fri,  7 Jun 2019 18:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731926AbfFGSip (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jun 2019 14:38:45 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:34857 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731889AbfFGSic (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jun 2019 14:38:32 -0400
Received: by mail-ed1-f68.google.com with SMTP id p26so289215edr.2
        for <git@vger.kernel.org>; Fri, 07 Jun 2019 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5AJn0j0ugsD4MHIvV7IydD9JHiObXzr46oP8SMYIqZ8=;
        b=n4ZP2PHrZ71G8qMykI3wEvdP1WsNqwff60CNdG8uR6X+cvXEIzvUc9xCrPW3zyXjXX
         8jE797mj2JWsJdr1Eh1Bah18Otxiu/Nibrhv/Im7E3f2P1NCTG0us0qsEPvJuD6yPPXC
         gJ6eagy4JBEa3jFTy8R9d5wKNNosQCKhOgXp3GFpllnWeWY8lIG3OtSifo2YABvaoesg
         gAPeLXcWe15oqmsng2OrCR/F0ozO5fup5ien+O0AGI+9fuvHDjUj5f5IxNgZAISozL72
         TaBfU8XqePNKTOHiFYVUZWt4TBvFtEhXiUPABbb07zY2KouYUNb8nyf2MKBz16WZsDPQ
         JK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5AJn0j0ugsD4MHIvV7IydD9JHiObXzr46oP8SMYIqZ8=;
        b=Fp2zvS8yimdJ4WsAWf7swGfhpjcY78vq+8InsNFuiJpug7+qU7jK/vbbzYr/C8MagF
         ovFhp6aMN13TUEZCU9bjY+tWKx/m21BCHCpNCCDrE8py/Zfn8fhTTrbKgk+qbiarkaye
         BK0CIg2obqDNeztAad0SFtnD0g9apsVY5N8PBu/Tp8avaU20rf84pzBi0+suXV/xTGhP
         T4zmRDK2VYFPVtsnNB1nwE+0+MBNHo0NB/FTK9DFA+Z51bZYYh1jViu2EZA8vxEbinP7
         6Sq/W9isrAI17ya56PEN2ybNfi8kon+HxV6fMCbgT5L9qTDn67b8Jnh9PehiX8XJhVSU
         Xy4Q==
X-Gm-Message-State: APjAAAURdkCokvn2c4HYO+1mKMbp7Atwb/6t7JCjP4kLNkIdLF6DfzdI
        vzCllTRaASLe4xbQxWJkcXZml7Mg
X-Google-Smtp-Source: APXvYqxFiDBKzOVMJcuwiNJumr3mPkpG6CqL5JbkfZZoQKFYalf5rw9EYRKQMKZ4ZaTlB5ZAnn8+JQ==
X-Received: by 2002:a50:8b9d:: with SMTP id m29mr23506515edm.248.1559932709705;
        Fri, 07 Jun 2019 11:38:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c12sm703916edt.38.2019.06.07.11.38.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Jun 2019 11:38:29 -0700 (PDT)
Date:   Fri, 07 Jun 2019 11:38:29 -0700 (PDT)
X-Google-Original-Date: Fri, 07 Jun 2019 18:38:14 GMT
Message-Id: <554880e3d7ea157d79a606f0e45124b77fd24ab4.1559932699.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v5.git.gitgitgadget@gmail.com>
References: <pull.184.v4.git.gitgitgadget@gmail.com>
        <pull.184.v5.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 11/16] commit-graph: expire commit-graph files
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
 t/t5324-split-commit-graph.sh            |  2 +-
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
index 22b167d9eb..779a628c95 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1650,6 +1650,70 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
 	sort_and_scan_merged_commits(ctx);
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
@@ -1762,6 +1826,11 @@ int write_commit_graph(const char *obj_dir,
 
 	res = write_commit_graph_file(ctx);
 
+	if (ctx->split) {
+		mark_commit_graphs(ctx);
+		expire_commit_graphs(ctx);
+	}
+
 cleanup:
 	free(ctx->graph_name);
 	free(ctx->commits.list);
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 46f0832f68..76068ee407 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
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

