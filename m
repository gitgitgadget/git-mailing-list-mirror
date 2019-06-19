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
	by dcvr.yhbt.net (Postfix) with ESMTP id 341F31F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:12:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729825AbfFSPME (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:12:04 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38871 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbfFSPME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:12:04 -0400
Received: by mail-ed1-f66.google.com with SMTP id r12so25544599edo.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 08:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lBDvmsfvXuc1xRqhVHIKBC8K9oz/ym1Kupjw3jlREGc=;
        b=q+12exgOjTmIInTlu+VhJUbJXqGv+GXlOuWruuChaq0qPaIBk5KbUYmNMlHMarNLeY
         ACl/9EtWsiUAQ3eUgt6jUWSJgOm1ParNb3oRweco+Y6mqCFbEIYjlo9wLHekIMvh6W4y
         qHoF3nVCuZ6qX/d9fYtWevqOwt7tCVSelAUxJf9neZX3j3luBzUOST2Dx+SKmMiv3hH3
         Yc+SbZVtVkGhKR4rH4slyjZ54TxAYCpLAI/dPeZj+D6QKq54T7uyAWcN5KG5EJCkFday
         65IZFcpOdnKzp/fOUiu+/Z+LYKkGMRaBJT0srInW3iIJJeg8LasDGFh/VZ7aQtRONlTx
         nqNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lBDvmsfvXuc1xRqhVHIKBC8K9oz/ym1Kupjw3jlREGc=;
        b=p10ZyIbSUiRMGjxf8x83lbHXOCf1WR1tTAtgwuZj0T1W/tORxM1H0VDE2rOAigjnHc
         8Y63HlTORiWN+67al7e4cRf2kc2ltJcG3Fj1INinGcVFj3c7yZAxYQfzhjnSbFjLB5j/
         9hn+pVd2JZ+knr8sT7YwHQ/6qepaAAjFl52TAg0BoAqa6H9BHLsncz+QgqEhncwlsr04
         CwPDHR7ilQ2sW0nQB+umhAA9QXsDQQDjIofqK9xvqOWaX/SEmUzyrcfkmyf3rQ4BtXeR
         f/Xlu2Jg+wWg9jzQd8WB8eIpxhE8ybQzlf40kBncZI1V/fkxV9BtXjaG4hebrQxdvLz8
         utXg==
X-Gm-Message-State: APjAAAUKQWKqVVrgr7yovgepKcPF42WKZU70myQ2NPr8iOYuvnsSpfoS
        2a3e8bn741aQ9VPa2QgP5aPOBWeQ
X-Google-Smtp-Source: APXvYqz9pTkCVnLTCGvd+wvLDL6tN5oGxvzahcP83s1bc0jUcIDMAPdT8/iAzAa95Naz/VI65l+T0w==
X-Received: by 2002:a17:906:5048:: with SMTP id e8mr106133279ejk.91.1560957121736;
        Wed, 19 Jun 2019 08:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p5sm555551ejn.46.2019.06.19.08.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:12:01 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:12:01 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 15:11:57 GMT
Message-Id: <02c89415fe11f14a65f2e6ee94e9d0de5a727e33.1560957119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.v2.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
        <pull.254.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 2/3] repo-settings: use index.version=4 by default
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, peff@peff.net,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

If a repo is large, it likely has many paths in its working directory.
This means the index could be compressed using version 4. Set this as
a default when core.featureAdoptionRate is at least three.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt  |  3 +++
 Documentation/config/index.txt |  2 ++
 read-cache.c                   | 12 +++++++-----
 repo-settings.c                |  6 ++++++
 repo-settings.h                |  1 +
 5 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 6a9f707815..d16503a9d7 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -620,3 +620,6 @@ not modify the user-facing output of porcelain commands.
 +
 * `gc.writeCommitGraph=true` eneables writing commit-graph files during
 `git gc`.
++
+* `index.version=4` uses prefix-compression to reduce the size of the
+.git/index file.
diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index f181503041..98a88c30be 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -24,3 +24,5 @@ index.threads::
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
+	If `core.featureAdoptionRate` is at least three, then the
+	default value is 4.
diff --git a/read-cache.c b/read-cache.c
index 22e7b9944e..7fab8ff748 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -25,6 +25,7 @@
 #include "fsmonitor.h"
 #include "thread-utils.h"
 #include "progress.h"
+#include "repo-settings.h"
 
 /* Mask for the name length in ce_flags in the on-disk index */
 
@@ -1599,16 +1600,17 @@ struct cache_entry *refresh_cache_entry(struct index_state *istate,
 
 #define INDEX_FORMAT_DEFAULT 3
 
-static unsigned int get_index_format_default(void)
+static unsigned int get_index_format_default(struct repository *r)
 {
 	char *envversion = getenv("GIT_INDEX_VERSION");
 	char *endp;
-	int value;
 	unsigned int version = INDEX_FORMAT_DEFAULT;
 
 	if (!envversion) {
-		if (!git_config_get_int("index.version", &value))
-			version = value;
+		prepare_repo_settings(r);
+
+		if (r->settings->index_version >= 0)
+			version = r->settings->index_version;
 		if (version < INDEX_FORMAT_LB || INDEX_FORMAT_UB < version) {
 			warning(_("index.version set, but the value is invalid.\n"
 				  "Using version %i"), INDEX_FORMAT_DEFAULT);
@@ -2765,7 +2767,7 @@ static int do_write_index(struct index_state *istate, struct tempfile *tempfile,
 	}
 
 	if (!istate->version) {
-		istate->version = get_index_format_default();
+		istate->version = get_index_format_default(the_repository);
 		if (git_env_bool("GIT_TEST_SPLIT_INDEX", 0))
 			init_split_index(istate);
 	}
diff --git a/repo-settings.c b/repo-settings.c
index f7fc2a1959..5753153a84 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -14,6 +14,7 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		if (rate >= 3) {
 			UPDATE_DEFAULT(rs->core_commit_graph, 1);
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
+			UPDATE_DEFAULT(rs->index_version, 4);
 		}
 		return 0;
 	}
@@ -25,6 +26,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->gc_write_commit_graph = git_config_bool(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "index.version")) {
+		rs->index_version = git_config_int(key, value);
+		return 0;
+	}
 
 	return 1;
 }
@@ -39,6 +44,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings->core_commit_graph = -1;
 	r->settings->gc_write_commit_graph = -1;
+	r->settings->index_version = -1;
 
 	repo_config(r, git_repo_config, r->settings);
 }
diff --git a/repo-settings.h b/repo-settings.h
index 11d08648e1..9b8104042e 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -4,6 +4,7 @@
 struct repo_settings {
 	char core_commit_graph;
 	char gc_write_commit_graph;
+	int index_version;
 };
 
 struct repository;
-- 
gitgitgadget

