Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3CE561F597
	for <e@80x24.org>; Wed, 18 Jul 2018 15:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731249AbeGRPyG (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 11:54:06 -0400
Received: from mail-pl0-f65.google.com ([209.85.160.65]:36701 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730998AbeGRPyG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 11:54:06 -0400
Received: by mail-pl0-f65.google.com with SMTP id e11-v6so2184240plb.3
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 08:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc:cc;
        bh=RjWZ4p7tl6PazGY3MlGRWm9XspdkFtLW0oPONJ5Ts40=;
        b=Yfzipc3ahB/4pfIHFi8KfURalkNZrgql9l/YqRK1R0thszeorWmvcoXqpGYdPd+CCd
         REgL9FeZtMem/ngivj3asVE2Bz34B2E4eythpCBStKjghy7NVoPdT0sZmMWDRCKr4peK
         TLzZhWcxDpWXBP7vy2OP5TvQaPnsvLnr6KhMN8PweC6x01LUHVUIy0EIWI/2PHonMYMm
         Az4jAkMtAYr+VaacjROMrfudWkxCCu6WsphKnyOHjx7LeWK1lKA58dYQyJmgBa+EIkuE
         fAK+5Fv04cCAntbAe2xTrYV3Cy+gr29TL18Ok3+U0K7BlAArKJ+EmHtFEUq4QfGUe5/P
         pX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc:cc;
        bh=RjWZ4p7tl6PazGY3MlGRWm9XspdkFtLW0oPONJ5Ts40=;
        b=Juh+bqxCBG3HoEeczHpxpMhNo/csDCWSn1Xvz5ptUOPcNhJvRczXn/uR6b00RoAHeL
         Dh09Xb0g/oXxSP9ZFScqtfKFoSU/K+kxvuFeDm0+cpsAsJ7OFYeC0WZld8Ub7mjlRlxT
         zEgeHu6Uk/zCZPOom9kIH5Jk/j8RN9WArv6dJEeJskDeA+Q55sfVaSjlwV8drkhg7ykS
         AYSm/Gkyp4KMKOiJkB6444O89ixWzlVXmJY9HdWeI+5Fe6EdFVrZCACW9eFXodagrfhL
         BoNUq+1x+75WmppUYG3/Vp8ylmyew9dX6HyAcpkWuerZvdS28i3EgJwnc/2K7sfAIPhi
         7tcg==
X-Gm-Message-State: AOUpUlE8sPGzjY4jNbV6p4u6WF3ZuDTi50tcK831XQyO6Ee1kDyf8zEn
        NDlZobZ3tJ5z/RAhaYeeSDmw8ZYD
X-Google-Smtp-Source: AAOMgpfKzKL56A2QUMXoz34oVX6k5gRlghfyxSWy4A+YOWO4jqiar0OwJGO6YN6Qq592Ab25zeIypg==
X-Received: by 2002:a17:902:b594:: with SMTP id a20-v6mr6378900pls.140.1531926943838;
        Wed, 18 Jul 2018 08:15:43 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id n86-v6sm5720672pfj.68.2018.07.18.08.15.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Jul 2018 08:15:43 -0700 (PDT)
Date:   Wed, 18 Jul 2018 08:15:43 -0700 (PDT)
X-Google-Original-Date: Wed, 18 Jul 2018 15:15:29 GMT
Message-Id: <94dd91ac35006ebee3c8808af1fce4ad69975234.1531926932.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.11.git.gitgitgadget@gmail.com>
References: <pull.11.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 6/8] commit-graph: not compatible with grafts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     jnareb@gmail.com, Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Augment commit_graph_compatible(r) to return false when the given
repository r has commit grafts or is a shallow clone. Test that in these
situations we ignore existing commit-graph files and we do not write new
commit-graph files.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 commit-graph.c          |  6 ++++++
 commit.c                |  2 +-
 commit.h                |  1 +
 t/t5318-commit-graph.sh | 36 ++++++++++++++++++++++++++++++++++++
 4 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/commit-graph.c b/commit-graph.c
index 711099858..5097c7c12 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -60,6 +60,12 @@ static struct commit_graph *alloc_commit_graph(void)
 
 static int commit_graph_compatible(struct repository *r)
 {
+	prepare_commit_graft(r);
+	if (r->parsed_objects && r->parsed_objects->grafts_nr)
+		return 0;
+	if (is_repository_shallow(r))
+		return 0;
+
 	prepare_replace_object(r);
 	if (hashmap_get_size(&r->objects->replace_map->map))
 		return 0;
diff --git a/commit.c b/commit.c
index 39b80bd21..609adaf8a 100644
--- a/commit.c
+++ b/commit.c
@@ -209,7 +209,7 @@ static int read_graft_file(struct repository *r, const char *graft_file)
 	return 0;
 }
 
-static void prepare_commit_graft(struct repository *r)
+void prepare_commit_graft(struct repository *r)
 {
 	char *graft_file;
 
diff --git a/commit.h b/commit.h
index da0db36eb..5459e279f 100644
--- a/commit.h
+++ b/commit.h
@@ -202,6 +202,7 @@ typedef int (*each_commit_graft_fn)(const struct commit_graft *, void *);
 
 struct commit_graft *read_graft_line(struct strbuf *line);
 int register_commit_graft(struct repository *r, struct commit_graft *, int);
+void prepare_commit_graft(struct repository *r);
 struct commit_graft *lookup_commit_graft(struct repository *r, const struct object_id *oid);
 
 extern struct commit_list *get_merge_bases(struct commit *rev1, struct commit *rev2);
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index c90626f5d..1d9f49af5 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -281,6 +281,42 @@ test_expect_success 'replace-objects invalidates commit-graph' '
 	)
 '
 
+test_expect_success 'commit grafts invalidate commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	test_when_finished rm -rf graft &&
+	git clone full graft &&
+	(
+		cd graft &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph &&
+		git replace --graft HEAD~1 HEAD~3 &&
+		git -c core.commitGraph=false log >expect &&
+		git -c core.commitGraph=true log >actual &&
+		test_cmp expect actual &&
+		git commit-graph write --reachable &&
+		git -c core.commitGraph=false --no-replace-objects log >expect &&
+		git -c core.commitGraph=true --no-replace-objects log >actual &&
+		test_cmp expect actual &&
+		rm -rf .git/objects/info/commit-graph &&
+		git commit-graph write --reachable &&
+		test_path_is_missing .git/objects/info/commit-graph
+	)
+'
+
+test_expect_success 'replace-objects invalidates commit-graph' '
+	cd "$TRASH_DIRECTORY" &&
+	test_when_finished rm -rf shallow &&
+	git clone --depth 2 "file://$TRASH_DIRECTORY/full" shallow &&
+	(
+		cd shallow &&
+		git commit-graph write --reachable &&
+		test_path_is_missing .git/objects/info/commit-graph &&
+		git fetch origin --unshallow &&
+		git commit-graph write --reachable &&
+		test_path_is_file .git/objects/info/commit-graph
+	)
+'
+
 # the verify tests below expect the commit-graph to contain
 # exactly the commits reachable from the commits/8 branch.
 # If the file changes the set of commits in the list, then the
-- 
gitgitgadget

