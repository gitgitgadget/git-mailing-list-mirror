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
	by dcvr.yhbt.net (Postfix) with ESMTP id 2CD321F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbfFCUS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:26 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45076 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726685AbfFCUSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:23 -0400
Received: by mail-ed1-f66.google.com with SMTP id f20so28558697edt.12
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jsy8sX9BKSrzPQtmLrNXXGnWG38hAkMUnkOubuKiEVs=;
        b=NF22jSFmBxTuNeHgyBqq5auX6HrW9cBQ3Fqnw8GcxKHCz+ToBpGxoMjG8PlsIG6svZ
         R2CZDphKDHZVpqeAc83KOkSUrnMMUAjriqHdMiXCOVd44rLzW5Z8SgkLABpGVWfPhJ6x
         ytZUixHZOmSkXlEvPMERDzGj6GJSLVYLlwO7g5yJ35K3CFEULsG10RDK16maukv9M1V3
         ShR7ouXhr3vN5bsS407R4BNEFFIu763ZlvrEOLJVILP65IXlEM/Zi2Cxj5a3hw/A7ARN
         uKxKBP6jVBIwuWJiThul1wQS3CmyRjKT3Y5J5ap8ppj6tHgF0hS+T4LohhsxTC1qn97e
         bMIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jsy8sX9BKSrzPQtmLrNXXGnWG38hAkMUnkOubuKiEVs=;
        b=IWmeVSAs0V+hmqiGuJ2tHoaaQygl9p3bVYqF3Bj4Vw4dAxkX6fuzYtO5eqPprXUxM8
         m4lKFOefmyB9gL2WLB0D2EPfbvM/QeKRhiwak6SGVPqpdVAuSq5aAwR3dnzShVvh+ddl
         gwAsV1ABoMxCqeHCQHqPG+fYZrqDe+3Wg3h6c4T46JNppEUm9haxUGfqFofyHmv1X/bt
         lnu9PlwRDxjK2JFP8fniSrthphYfD7V3XxyZ/YeGceS8hsB4Pm27FaDDqSvZFSgGXULl
         HpLyE/4wki4tIMYxd5DHA2n1QeEVNb5a+Kca6dmpsn6Hx5ULJu+7C/cqpVVeuIOLqAYF
         VFRQ==
X-Gm-Message-State: APjAAAUHyOXTNT3Uov/CQFAz4ztXlI86F/uiYQ+X8urAA8gTC6uWkFAp
        pimwKumeACfWOHRHOYeg0wwAkHXn
X-Google-Smtp-Source: APXvYqxsNBt3gwbMZjIIKXemJO+mGRA9SIBaoZCFIyiWDInAQjEcRPmyMRWB0XnXC8QiLWTHKAzxrQ==
X-Received: by 2002:a50:926d:: with SMTP id j42mr12385745eda.237.1559593100511;
        Mon, 03 Jun 2019 13:18:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r14sm2797198ejb.54.2019.06.03.13.18.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:20 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:20 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:08 GMT
Message-Id: <d5f5d7453c8135cf0c1186447de4323d31d4eca8.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 02/11] repo-settings: use index.version=4 by default
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

If a repo is large, it likely has many paths in its working directory.
This means the index could be compressed using version 4. Set this as
a default when core.size=large.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt  |  3 +++
 Documentation/config/index.txt |  1 +
 read-cache.c                   | 12 +++++++-----
 repo-settings.c                |  6 ++++++
 repo-settings.h                |  1 +
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 1a188db620..ea64f675fa 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -613,3 +613,6 @@ core.size::
 +
 * `gc.writeCommitGraph=true` eneables writing commit-graph files during
 `git gc`.
++
+* `index.version=4` uses prefix-compression to reduce the size of the
+.git/index file.
diff --git a/Documentation/config/index.txt b/Documentation/config/index.txt
index f181503041..d4b56925c4 100644
--- a/Documentation/config/index.txt
+++ b/Documentation/config/index.txt
@@ -24,3 +24,4 @@ index.threads::
 index.version::
 	Specify the version with which new index files should be
 	initialized.  This does not affect existing repositories.
+	If `core.size=large`, then the default value is 4.
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
index 6f5e18d92e..7e6e65d60c 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -14,6 +14,7 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		if (!strcmp(value, "large")) {
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

