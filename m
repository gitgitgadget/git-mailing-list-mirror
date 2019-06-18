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
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7F61F462
	for <e@80x24.org>; Tue, 18 Jun 2019 18:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730360AbfFRSOo (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Jun 2019 14:14:44 -0400
Received: from mail-ed1-f54.google.com ([209.85.208.54]:39781 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730321AbfFRSOe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jun 2019 14:14:34 -0400
Received: by mail-ed1-f54.google.com with SMTP id m10so23056774edv.6
        for <git@vger.kernel.org>; Tue, 18 Jun 2019 11:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Zi3PWgQh4Yel01JBwcIo1iiajFepJZx54c9jKkLbQZg=;
        b=loMI0q0epjIddOoUUZxBdhEyTROdaR06riDQh8uPw/PM28S82djv+2K9MVDQXEslLh
         nJhdHerQpTOitppIPmCjGUC59hzLmdSpPUAzTxNhAayQe0DHSECQnijd0IgY9Mk8q2Df
         VcoSyH3TO+88TMnz40cFVqMlRV++TAQNv6xHt7fOZDId4v0sBU4wCmV9JjdmVqt9pVO/
         MGgAJ1KtiKk9vsUnttXs/rRvMCYy9yUPOwL9r/J+mPgpppTZab/3JjODaYWuCpq54wyF
         pUikcNn42Cmn8vcDrb+rYfqL0bsQJgivelfgYDkWtMXnZcqR5WnxPrpYkQ6UvZDSr9XH
         h8Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Zi3PWgQh4Yel01JBwcIo1iiajFepJZx54c9jKkLbQZg=;
        b=RU4xC2TtHxtWXCYvrE+5ywWwkx2Ky3OLhcAhzIk43i+IBMwAg0PjfrfuEu17EEcyBn
         sF5hlfOtH7X/kOBcPDtvIU9/mpN3SRO7QntsrTeqqZZ1e6Ku72OWccEn1j5rQUUevnEQ
         nrvSqYtBk80fPp8fDJKdQgO67aDXAU4yaqHaq3/wdLibzdk+BfHK2xM6V2UEQwfy+JGg
         XPrHHbcfUp6Sv/WS5WCr7c6J8kj/NlGlr4DfectJbNjkThoJpIx0qFOcxtR6XNjoBVU1
         qWlBovQkAlsmu2yXuyBEhGZXxSGnACttNbrql9rnVK/RU0enCz29VZKttVMp19ZAPbCg
         SMHg==
X-Gm-Message-State: APjAAAX9inrY9ITp8sY4m4d6BAGeQ15r5qzVzv5Jf7VEqSS1JnUFPesJ
        0PuhY+Mx9K03JwxnW7c1Dd4EXVdj
X-Google-Smtp-Source: APXvYqyyxKuh5P/dCv447RwYHwZ/dbjdo5AIe2+TvfBYxYye949KqspB1APJLZF3u0PZArzQWtTAbw==
X-Received: by 2002:a17:906:4e8f:: with SMTP id v15mr70100974eju.47.1560881671815;
        Tue, 18 Jun 2019 11:14:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i26sm661999eja.14.2019.06.18.11.14.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 11:14:31 -0700 (PDT)
Date:   Tue, 18 Jun 2019 11:14:31 -0700 (PDT)
X-Google-Original-Date: Tue, 18 Jun 2019 18:14:13 GMT
Message-Id: <2d2977b7df8214cace865cfebc95e1b83fd5f2cb.1560881661.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.184.v6.git.gitgitgadget@gmail.com>
References: <pull.184.v5.git.gitgitgadget@gmail.com>
        <pull.184.v6.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 11/18] commit-graph: expire commit-graph files
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
index fba705bc51..0cc2ceb349 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -1652,6 +1652,70 @@ static void merge_commit_graphs(struct write_commit_graph_context *ctx)
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
@@ -1764,6 +1828,11 @@ int write_commit_graph(const char *obj_dir,
 
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

