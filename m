Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D01F1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 18:37:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728363AbfHMShv (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 14:37:51 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:41328 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfHMShs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 14:37:48 -0400
Received: by mail-wr1-f65.google.com with SMTP id j16so6426635wrr.8
        for <git@vger.kernel.org>; Tue, 13 Aug 2019 11:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N6z300RhInSC49KM19NE4JGb7aeVYFMXTYCaPKom+s8=;
        b=Dp0XMGX6UBMfuT4qpwK2zPdAN/6rTTzROeABkUWhjJcEQ4+Hwzla/zZLrGmIhnAOjP
         8VUBOCbDAPL38vESJhAoJZGEnaEeRjPt+JgU89XD0Zi0T7hTtaW7jLZhKe7A4EsoI8As
         kuuM6SpzATZBGdNvrkfBFWN1lkrZ6IKpWtZxVJLVD2iQFvgGRi7CYQmHm62fqbDC73az
         kX9KDfE9OL7kmMIzJfRmhez7380amaU9OH+NzZvHS0j8bRcwcd5Ln59CgdWSz+3N20GY
         iWOgY+xCgRRP2ouepLBVP2n/UUhLBPxrUBplhTLQdb1akkC/ABPfgaZAYOzIQm7D9PZ4
         dRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N6z300RhInSC49KM19NE4JGb7aeVYFMXTYCaPKom+s8=;
        b=oN3HRVPrna3bFhpudz/4Sw/6HIEfWUlWjrqMw6G1ia64QfsZAlBVs9pVJT7pZlTaBS
         tHY0mgfdeeX1I9+kM+lXsqYCzrYAtrMZW1/zTtsZdseqxQXZPt3/KN07qDkGFm1lv5oE
         kPoBhQHH6YOBH9gfH+9VKrxEoMBkml5gBatzh7Y/wNEBOPEL6A1HU+cLSiltEUZX6eDj
         +sv/u4W4mPj0AbBdm4i4gjhFzpb52G2dm4AliSloCNLBfMYcDE/S0lWtGHzRQKE7YV5d
         +B8fpQ/uuMQdv2jsxy3E+10bPkBzXMdwMwG680wyt8uB2qfcxWJufu+AVQbUpBd2Z0zb
         FQVw==
X-Gm-Message-State: APjAAAWhQLsj/JQbltEry9WemVh/EW3DpqKQnnZzu4AqwEaxSaF4NKGj
        7YbZEMnZ21KgS4igermHn8mwVl45
X-Google-Smtp-Source: APXvYqxIQBcWXFSXOTnVMSzrztvUQvrnJ7iu5EWpLDRITHbDhdx6ANGJKyfpwEGDTj5bf4HmanWY1w==
X-Received: by 2002:a05:6000:152:: with SMTP id r18mr39558416wrx.41.1565721466184;
        Tue, 13 Aug 2019 11:37:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o7sm1940865wmc.36.2019.08.13.11.37.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Aug 2019 11:37:45 -0700 (PDT)
Date:   Tue, 13 Aug 2019 11:37:45 -0700 (PDT)
X-Google-Original-Date: Tue, 13 Aug 2019 18:37:38 GMT
Message-Id: <651e2d526b2a3f6c63c64cfe1f049eef94d39c07.1565721461.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.292.v4.git.gitgitgadget@gmail.com>
References: <pull.292.v3.git.gitgitgadget@gmail.com>
        <pull.292.v4.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 3/6] commit-graph: turn on commit-graph by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net, jnareb@gmail.com,
        pclouds@gmail.com, carenas@gmail.com, avarab@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The commit-graph feature has seen a lot of activity in the past
year or so since it was introduced. The feature is a critical
performance enhancement for medium- to large-sized repos, and
does not significantly hurt small repos.

Change the defaults for core.commitGraph and gc.writeCommitGraph
to true so users benefit from this feature by default.

There are several places in the test suite where the environment
variable GIT_TEST_COMMIT_GRAPH is disabled to avoid reading a
commit-graph, if it exists. The config option overrides the
environment, so swap these. Some GIT_TEST_COMMIT_GRAPH assignments
remain, and those are to avoid writing a commit-graph when a new
commit is created.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt       | 2 +-
 Documentation/config/gc.txt         | 2 +-
 repo-settings.c                     | 4 ++++
 t/t0410-partial-clone.sh            | 2 +-
 t/t5307-pack-missing-commit.sh      | 4 ++--
 t/t5324-split-commit-graph.sh       | 2 ++
 t/t6011-rev-list-with-bad-commit.sh | 2 +-
 7 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 75538d27e7..e66d79fd76 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -577,7 +577,7 @@ the `GIT_NOTES_REF` environment variable.  See linkgit:git-notes[1].
 
 core.commitGraph::
 	If true, then git will read the commit-graph file (if it exists)
-	to parse the graph structure of commits. Defaults to false. See
+	to parse the graph structure of commits. Defaults to true. See
 	linkgit:git-commit-graph[1] for more information.
 
 core.useReplaceRefs::
diff --git a/Documentation/config/gc.txt b/Documentation/config/gc.txt
index 02b92b18b5..00ea0a678e 100644
--- a/Documentation/config/gc.txt
+++ b/Documentation/config/gc.txt
@@ -63,7 +63,7 @@ gc.writeCommitGraph::
 	If true, then gc will rewrite the commit-graph file when
 	linkgit:git-gc[1] is run. When using `git gc --auto`
 	the commit-graph will be updated if housekeeping is
-	required. Default is false. See linkgit:git-commit-graph[1]
+	required. Default is true. See linkgit:git-commit-graph[1]
 	for details.
 
 gc.logExpiry::
diff --git a/repo-settings.c b/repo-settings.c
index 309577f6bc..d00b675687 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -2,6 +2,8 @@
 #include "config.h"
 #include "repository.h"
 
+#define UPDATE_DEFAULT_BOOL(s,v) do { if (s == -1) { s = v; } } while(0)
+
 void prepare_repo_settings(struct repository *r)
 {
 	int value;
@@ -16,6 +18,8 @@ void prepare_repo_settings(struct repository *r)
 		r->settings.core_commit_graph = value;
 	if (!repo_config_get_bool(r, "gc.writecommitgraph", &value))
 		r->settings.gc_write_commit_graph = value;
+	UPDATE_DEFAULT_BOOL(r->settings.core_commit_graph, 1);
+	UPDATE_DEFAULT_BOOL(r->settings.gc_write_commit_graph, 1);
 
 	if (!repo_config_get_bool(r, "index.version", &value))
 		r->settings.index_version = value;
diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
index 5bd892f2f7..181ffa44e9 100755
--- a/t/t0410-partial-clone.sh
+++ b/t/t0410-partial-clone.sh
@@ -234,7 +234,7 @@ test_expect_success 'rev-list stops traversal at missing and promised commit' '
 
 	git -C repo config core.repositoryformatversion 1 &&
 	git -C repo config extensions.partialclone "arbitrary string" &&
-	GIT_TEST_COMMIT_GRAPH=0 git -C repo rev-list --exclude-promisor-objects --objects bar >out &&
+	GIT_TEST_COMMIT_GRAPH=0 git -C repo -c core.commitGraph=false rev-list --exclude-promisor-objects --objects bar >out &&
 	grep $(git -C repo rev-parse bar) out &&
 	! grep $FOO out
 '
diff --git a/t/t5307-pack-missing-commit.sh b/t/t5307-pack-missing-commit.sh
index dacb440b27..f4338abb78 100755
--- a/t/t5307-pack-missing-commit.sh
+++ b/t/t5307-pack-missing-commit.sh
@@ -24,11 +24,11 @@ test_expect_success 'check corruption' '
 '
 
 test_expect_success 'rev-list notices corruption (1)' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list HEAD
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git -c core.commitGraph=false rev-list HEAD
 '
 
 test_expect_success 'rev-list notices corruption (2)' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --objects HEAD
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git -c core.commitGraph=false rev-list --objects HEAD
 '
 
 test_expect_success 'pack-objects notices corruption' '
diff --git a/t/t5324-split-commit-graph.sh b/t/t5324-split-commit-graph.sh
index 03f45a1ed9..19aa40de15 100755
--- a/t/t5324-split-commit-graph.sh
+++ b/t/t5324-split-commit-graph.sh
@@ -8,6 +8,7 @@ GIT_TEST_COMMIT_GRAPH=0
 test_expect_success 'setup repo' '
 	git init &&
 	git config core.commitGraph true &&
+	git config gc.writeCommitGraph false &&
 	infodir=".git/objects/info" &&
 	graphdir="$infodir/commit-graphs" &&
 	test_oid_init
@@ -332,6 +333,7 @@ test_expect_success 'split across alternate where alternate is not split' '
 	git clone --no-hardlinks . alt-split &&
 	(
 		cd alt-split &&
+		rm -f .git/objects/info/commit-graph &&
 		echo "$(pwd)"/../.git/objects >.git/objects/info/alternates &&
 		test_commit 18 &&
 		git commit-graph write --reachable --split &&
diff --git a/t/t6011-rev-list-with-bad-commit.sh b/t/t6011-rev-list-with-bad-commit.sh
index 545b461e51..bad02cf5b8 100755
--- a/t/t6011-rev-list-with-bad-commit.sh
+++ b/t/t6011-rev-list-with-bad-commit.sh
@@ -42,7 +42,7 @@ test_expect_success 'corrupt second commit object' \
    '
 
 test_expect_success 'rev-list should fail' '
-	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git rev-list --all > /dev/null
+	test_must_fail env GIT_TEST_COMMIT_GRAPH=0 git -c core.commitGraph=false rev-list --all > /dev/null
 '
 
 test_expect_success 'git repack _MUST_ fail' \
-- 
gitgitgadget

