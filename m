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
	by dcvr.yhbt.net (Postfix) with ESMTP id 005481F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfFCUS1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:27 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:44201 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbfFCUS0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:26 -0400
Received: by mail-ed1-f68.google.com with SMTP id b8so28575655edm.11
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ERzgBFMryQ9pX1KTeFZQbZ6xFwBz7r66RQsT/2tpUOY=;
        b=Qr6ZRKVThmcdY+39LlhaLcVIPrGur1tpL45KsI/qTZSbE+UCh7i5tPUm+1siNnIAeZ
         6ScGivXpzb2VcQBUxix1kJrN8Cu2/T9+k7mhHTxoNEzCTtFlP48WsIguljW/EzAcew8I
         CqkjzPYbNqQzfiSfYjhh71fwTz1Ezz1hi8hZu+OSAn1m5Y0pGWTbYA4YueCFtiNDH15F
         vZNCo2vmWgQQKWNeqzhOHWNBzntwkvxWyACBR4BhOQqCe1iRVPKKUZr0QqSxNMct3zgV
         adtJ08Qk8e26GaVGVPkXalBZCqvKF6eVWlHI+iaye2wOWLkVdYf74P1H+fjZG1cKAdNY
         +jNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ERzgBFMryQ9pX1KTeFZQbZ6xFwBz7r66RQsT/2tpUOY=;
        b=iqO4nNaxT8DqiRtbUcfMiVXxuiCyjsYCO2olZiGxmQHe2ewcJ9IVKH8Rc0Eym/5igq
         jdCszcnTemKULwHnbuG2OiMXN0OyKN7cy3D2VPSx6tCCPLd/dAYr1PFD3PEgpU1PkpEP
         dxSXkuP1HNNVbFR+ndTs1Ddi0u3k3D3Wyb5ZQXmG9wClZFcYUj3NpI4X5leUm2jxqhde
         J6tUoqnc/vBNLhUOoICu+vfTbn8xwhqr+bbfqV5TakzD127PzlVV1I8qGa6W54ujXr45
         4rguv5ZVw4ncX2f1qQVDWpGVS2uXHMuNzh310tsUdTAPSH56KFRUtxpn3t9+NbX7PXUW
         aDrA==
X-Gm-Message-State: APjAAAXAl2XDtkOL1b/x6SuNaCPK8+OUL0S/P1gu2vFm+Lt2P3L2Jbgx
        fHZgltSmbeEJvyNXbVsPhIk9ru32
X-Google-Smtp-Source: APXvYqwN/JxNuxboLSOFIZUSClSvdrM1hKzqwp8RnOw2nmeD7EwudhsRPZ5c7b0k+SvHhi+1/5xAjA==
X-Received: by 2002:a17:906:d8bb:: with SMTP id qc27mr25495150ejb.206.1559593104138;
        Mon, 03 Jun 2019 13:18:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm2758132eja.77.2019.06.03.13.18.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:23 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:23 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:13 GMT
Message-Id: <936fae31b712f5cce52258619b07d35356903bc6.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 07/11] repo-settings: status.aheadBehind=false
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

When a repo has many active developers, the commit history can grow
very quickly. This can lead remote branches from being very far from
their local copies.

Set stats.aheadBehind=false by default when core.size=large, so all
'git status' calls have an implied '--no-ahead-behind' argument.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt   |  3 +++
 Documentation/config/status.txt |  3 ++-
 builtin/commit.c                | 12 ++++++------
 repo-settings.c                 |  6 ++++++
 repo-settings.h                 |  1 +
 5 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index df357f5af5..6bed956a08 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -620,3 +620,6 @@ core.size::
 * `pack.useSparse=true` uses the sparse tree-walk algorithm, which is
 optimized for enumerating objects during linkgit:git-push[1] from a
 client machine.
++
+* `status.aheadBehind=false` enables `--no-ahead-behind` by default during
+linkgit:git-status[1] calls, saving time in a fast-moving commit history.
diff --git a/Documentation/config/status.txt b/Documentation/config/status.txt
index 0fc704ab80..3e39019810 100644
--- a/Documentation/config/status.txt
+++ b/Documentation/config/status.txt
@@ -15,7 +15,8 @@ status.branch::
 status.aheadBehind::
 	Set to true to enable `--ahead-behind` and false to enable
 	`--no-ahead-behind` by default in linkgit:git-status[1] for
-	non-porcelain status formats.  Defaults to true.
+	non-porcelain status formats.  Defaults to true, unless
+	`core.size=large`.
 
 status.displayCommentPrefix::
 	If set to true, linkgit:git-status[1] will insert a comment
diff --git a/builtin/commit.c b/builtin/commit.c
index 79cb238d87..246a802167 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -36,6 +36,7 @@
 #include "help.h"
 #include "commit-reach.h"
 #include "commit-graph.h"
+#include "repo-settings.h"
 
 static const char * const builtin_commit_usage[] = {
 	N_("git commit [<options>] [--] <pathspec>..."),
@@ -1117,8 +1118,11 @@ static void finalize_deferred_config(struct wt_status *s)
 	 * in particular), we inherit _FULL for backwards compatibility.
 	 */
 	if (use_deferred_config &&
-	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
-		s->ahead_behind_flags = status_deferred_config.ahead_behind;
+	    s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED) {
+		prepare_repo_settings(the_repository);
+		if (the_repository->settings->status_ahead_behind != -1)
+			s->ahead_behind_flags = the_repository->settings->status_ahead_behind;
+	}
 
 	if (s->ahead_behind_flags == AHEAD_BEHIND_UNSPECIFIED)
 		s->ahead_behind_flags = AHEAD_BEHIND_FULL;
@@ -1259,10 +1263,6 @@ static int git_status_config(const char *k, const char *v, void *cb)
 		status_deferred_config.show_branch = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "status.aheadbehind")) {
-		status_deferred_config.ahead_behind = git_config_bool(k, v);
-		return 0;
-	}
 	if (!strcmp(k, "status.showstash")) {
 		s->show_stash = git_config_bool(k, v);
 		return 0;
diff --git a/repo-settings.c b/repo-settings.c
index 026ab9c1a0..b3d4b50b72 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -15,6 +15,7 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 			UPDATE_DEFAULT(rs->core_commit_graph, 1);
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
 			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
+			UPDATE_DEFAULT(rs->status_ahead_behind, 1);
 			UPDATE_DEFAULT(rs->index_version, 4);
 		}
 		return 0;
@@ -31,6 +32,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->pack_use_sparse = git_config_bool(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "status.aheadbehind")) {
+		rs->status_ahead_behind = git_config_bool(key, value);
+		return 0;
+	}
 	if (!strcmp(key, "index.version")) {
 		rs->index_version = git_config_int(key, value);
 		return 0;
@@ -50,6 +55,7 @@ void prepare_repo_settings(struct repository *r)
 	r->settings->core_commit_graph = -1;
 	r->settings->gc_write_commit_graph = -1;
 	r->settings->pack_use_sparse = -1;
+	r->settings->status_ahead_behind = -1;
 	r->settings->index_version = -1;
 
 	repo_config(r, git_repo_config, r->settings);
diff --git a/repo-settings.h b/repo-settings.h
index b50228f992..cc358a083a 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -5,6 +5,7 @@ struct repo_settings {
 	char core_commit_graph;
 	char gc_write_commit_graph;
 	char pack_use_sparse;
+	char status_ahead_behind;
 	int index_version;
 };
 
-- 
gitgitgadget

