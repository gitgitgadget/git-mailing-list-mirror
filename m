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
	by dcvr.yhbt.net (Postfix) with ESMTP id 121461F462
	for <e@80x24.org>; Mon,  3 Jun 2019 20:18:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbfFCUS0 (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Jun 2019 16:18:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42564 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726076AbfFCUSX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jun 2019 16:18:23 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so2551688edq.9
        for <git@vger.kernel.org>; Mon, 03 Jun 2019 13:18:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ZqE9Y0MToTDxE4zj4OT/70tMs7Z9xCLDMQuJTXCJOKY=;
        b=gV6W+QTPHRmakclAZ9tobZFJcikNj9g/xgUueHa8a2Z4m37hOW+hB4yQ28ZWvkQr23
         x/0Xf2u440obeNxwbiDjih4IFY4Aq8kSWfA255mNqomFe2tuEOuNvE26nxcITYnVw/zd
         ZiI0w0TPs3m2vlCcUYoPYpjQ/dOguWDafq4jeapakySQSA3ncbaKba0QY/LiNi8d2SjJ
         60/06KHmYY6Ma8gB4d51EbgYrY0TdgMDQZMp+qcFWay89/AR6JeUkgvZDkn1rVj+ryWt
         iy3aZSabE3VenbE5ACEowkiSPTxDHF7JJIxx/vkQS3U/6abUJ3H+LAE/2+mIQurFNf9n
         1Gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ZqE9Y0MToTDxE4zj4OT/70tMs7Z9xCLDMQuJTXCJOKY=;
        b=TDgHEWPk5snfhKEW5X/vQ3bQxUBq78NxQuKdlCtaWUwv+Lvp0BJVlhleM3pU4dVLA2
         yHmMCtB+SHxqMNxy7DIZzVCh3sLYinYb0gIJB5JUd1za1/zE4YjaKV6OpdHEsUSF+YBe
         od4ra5BPRt5molRTnTAvcHYlta9U5kEJM6X0QPw5nQ0nbvZbJIP7tjUrmtQ8IV6/S2h4
         6pcxEotIzibnl3w3SX44CpfJ8z13xsvRJ9qLoyqPjd5JgQdL85/DW442otwkHfTn6dh+
         L0RvqD5YwRhCMMWlBtlZ5Dwyn3Yxq0bhYcUrXpI7aC8k2s8IDRmtg+3vUFXvzXdczAkW
         sDeg==
X-Gm-Message-State: APjAAAXAyEi0c8A41oXaOEMAnth0BDrycQ3w7KlxwYgbNyvC8VuFCHEV
        IFFwCsxUcZuqv2b4vNiai2cNu6WV
X-Google-Smtp-Source: APXvYqzsgGcXTBnsEdB12BtobFsZVbrAPPeiaLLmLYtVWKzQf7BU+3AdbgIaw+QF4XGRPti7fBNndQ==
X-Received: by 2002:a50:ade3:: with SMTP id b32mr31253226edd.297.1559593101246;
        Mon, 03 Jun 2019 13:18:21 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d11sm4232871eda.45.2019.06.03.13.18.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Jun 2019 13:18:20 -0700 (PDT)
Date:   Mon, 03 Jun 2019 13:18:20 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Jun 2019 20:18:09 GMT
Message-Id: <f3ea4e3f270939b9fca69aa4fd4da8fc8559057c.1559593097.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 03/11] repo-settings: pack.useSparse=true
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

If a repo is large, then it probably has a very large working
directory. In this case, a typical developer's edits usually impact
many fewer paths than the full path set. The sparse treewalk
algorithm is optimized for this case, speeding up 'git push' calls.

Use pack.useSparse=true when core.size=large.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt | 4 ++++
 Documentation/config/pack.txt | 3 ++-
 builtin/pack-objects.c        | 9 +++++----
 repo-settings.c               | 6 ++++++
 repo-settings.h               | 1 +
 5 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index ea64f675fa..df357f5af5 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -616,3 +616,7 @@ core.size::
 +
 * `index.version=4` uses prefix-compression to reduce the size of the
 .git/index file.
++
+* `pack.useSparse=true` uses the sparse tree-walk algorithm, which is
+optimized for enumerating objects during linkgit:git-push[1] from a
+client machine.
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 9cdcfa7324..e6f44de104 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -112,7 +112,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames.
+	commits contain certain types of direct renames. Defaults to
+	false, unless `core.size=large`.
 
 pack.writeBitmaps (deprecated)::
 	This is a deprecated synonym for `repack.writeBitmaps`.
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 41d7fc5983..f26b3f2892 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -34,6 +34,7 @@
 #include "dir.h"
 #include "midx.h"
 #include "trace2.h"
+#include "repo-settings.h"
 
 #define IN_PACK(obj) oe_in_pack(&to_pack, obj)
 #define SIZE(obj) oe_size(&to_pack, obj)
@@ -2707,10 +2708,6 @@ static int git_pack_config(const char *k, const char *v, void *cb)
 		use_bitmap_index_default = git_config_bool(k, v);
 		return 0;
 	}
-	if (!strcmp(k, "pack.usesparse")) {
-		sparse = git_config_bool(k, v);
-		return 0;
-	}
 	if (!strcmp(k, "pack.threads")) {
 		delta_search_threads = git_config_int(k, v);
 		if (delta_search_threads < 0)
@@ -3330,6 +3327,10 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 	read_replace_refs = 0;
 
 	sparse = git_env_bool("GIT_TEST_PACK_SPARSE", 0);
+	prepare_repo_settings(the_repository);
+	if (!sparse && the_repository->settings->pack_use_sparse != -1)
+		sparse = the_repository->settings->pack_use_sparse;
+
 	reset_pack_idx_option(&pack_idx_opts);
 	git_config(git_pack_config, NULL);
 
diff --git a/repo-settings.c b/repo-settings.c
index 7e6e65d60c..026ab9c1a0 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -14,6 +14,7 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		if (!strcmp(value, "large")) {
 			UPDATE_DEFAULT(rs->core_commit_graph, 1);
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
+			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
 			UPDATE_DEFAULT(rs->index_version, 4);
 		}
 		return 0;
@@ -26,6 +27,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 		rs->gc_write_commit_graph = git_config_bool(key, value);
 		return 0;
 	}
+	if (!strcmp(key, "pack.usesparse")) {
+		rs->pack_use_sparse = git_config_bool(key, value);
+		return 0;
+	}
 	if (!strcmp(key, "index.version")) {
 		rs->index_version = git_config_int(key, value);
 		return 0;
@@ -44,6 +49,7 @@ void prepare_repo_settings(struct repository *r)
 	/* Defaults */
 	r->settings->core_commit_graph = -1;
 	r->settings->gc_write_commit_graph = -1;
+	r->settings->pack_use_sparse = -1;
 	r->settings->index_version = -1;
 
 	repo_config(r, git_repo_config, r->settings);
diff --git a/repo-settings.h b/repo-settings.h
index 9b8104042e..b50228f992 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -4,6 +4,7 @@
 struct repo_settings {
 	char core_commit_graph;
 	char gc_write_commit_graph;
+	char pack_use_sparse;
 	int index_version;
 };
 
-- 
gitgitgadget

