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
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F0C81F462
	for <e@80x24.org>; Wed, 19 Jun 2019 15:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729849AbfFSPMF (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 11:12:05 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:43815 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbfFSPME (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 11:12:04 -0400
Received: by mail-ed1-f67.google.com with SMTP id e3so27665062edr.10
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 08:12:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FBBXXrUbVdYM5d2F7cYkrXdMykCz4f6l2mVoneSu73A=;
        b=MDTt+AbOWMMJrGaqcQfR7u3pqrj5ME5e6D0ZyZJMltq375P4YEmucvKQiyEdalV9jR
         OBYemEEUxEjFLYj2wNdMsBYR2hmdqUCOEd/TK4B39uUS11F3uY9T8E7/k56OXWLSjgV2
         5kab4Xmdt6R7vaTAq755OYrZUGIOSk/n1tukgPQh3CjvkF92Dg0m/fg1/dewsO+H3Oeo
         dJvE0eJpA6VxGn7oE/Dx0CjBcAI79hvCNzlzwb/fJi9kSI7lGErD8ACuD72OhTMrXW0e
         hg2ahJsUp3bclK+wkZrNPBzR1TbM2GouPcuw3J1+cgE2YyEzMFRb5nt2qrilTbytANEU
         FL4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FBBXXrUbVdYM5d2F7cYkrXdMykCz4f6l2mVoneSu73A=;
        b=Flb08siivijKSOQd6XA+npjIP3YZZMBKyWaH13lA5TZOTscuFh5Z6EHcfNmh/VbwK4
         RJtoQw76IUOF+zvSN7fdN9/srheU2Hm5z4BMu3tZENOIcNXnZ9zxfOjGwjcvwPAF+afN
         +Ye74t6JkUZybvNWALHYMW4iFIwaMCcXT+EODSE0qH0pAIQ2eo8RG8EMEUgwkz2n6U/M
         8DMAPV8UyI3qMn2f2xtY/CESzDE32yuvWdwY0SGBQ0pcXOceSb5mb69HCBpdvQKwuO5z
         g8SZsjj8c/8cRbpkfDO1oxh/FMf23J7ODcwn4S+Ux7vBJrySHT4CrCx/QRCIv7V6eJ+4
         U5gw==
X-Gm-Message-State: APjAAAXRKcJVbF5dYMx+2DrNqFvx4Z3X6eN9ilksrg0cp6fqqh9X0fcE
        BQeZlPxbwLJ512BO+nO9xEdcfyTd
X-Google-Smtp-Source: APXvYqymSfX+9ZsU5nJCeGZiCJs45yb5vBKPbpUh2i9XRv/8Q2i9Jw3ogKYAAisK+hgcTIe1aL+soQ==
X-Received: by 2002:a50:a511:: with SMTP id y17mr113399280edb.259.1560957122461;
        Wed, 19 Jun 2019 08:12:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm330548eji.51.2019.06.19.08.12.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 08:12:02 -0700 (PDT)
Date:   Wed, 19 Jun 2019 08:12:02 -0700 (PDT)
X-Google-Original-Date: Wed, 19 Jun 2019 15:11:58 GMT
Message-Id: <5bba9062f417e71d5dbb4192421b61cdde311c81.1560957119.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.254.v2.git.gitgitgadget@gmail.com>
References: <pull.254.git.gitgitgadget@gmail.com>
        <pull.254.v2.git.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 3/3] repo-settings: pack.useSparse=true
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

If a repo is large, then it probably has a very large working
directory. In this case, a typical developer's edits usually impact
many fewer paths than the full path set. The sparse treewalk
algorithm is optimized for this case, speeding up 'git push' calls.

Use pack.useSparse=true when core.featureAdoptionRate is at least
five. This is the first setting where the feature has only been
out for a single major version. This could be moved to the "at
least three" category after another major version.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/config/core.txt | 9 +++++++++
 Documentation/config/pack.txt | 3 ++-
 builtin/pack-objects.c        | 9 +++++----
 repo-settings.c               | 8 ++++++++
 repo-settings.h               | 1 +
 5 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index d16503a9d7..77fdd02660 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -623,3 +623,12 @@ not modify the user-facing output of porcelain commands.
 +
 * `index.version=4` uses prefix-compression to reduce the size of the
 .git/index file.
++
+If the value is at least 5, then all of the defaults above are included,
+plus the defaults below. These represent new features that present
+significant performance benefits, but may not have been released for
+multiple major versions.
++
+* `pack.useSparse=true` uses the sparse tree-walk algorithm, which is
+optimized for enumerating objects during linkgit:git-push[1] from a
+client machine.
diff --git a/Documentation/config/pack.txt b/Documentation/config/pack.txt
index 9cdcfa7324..9c4f8ea9ff 100644
--- a/Documentation/config/pack.txt
+++ b/Documentation/config/pack.txt
@@ -112,7 +112,8 @@ pack.useSparse::
 	objects. This can have significant performance benefits when
 	computing a pack to send a small change. However, it is possible
 	that extra objects are added to the pack-file if the included
-	commits contain certain types of direct renames.
+	commits contain certain types of direct renames. Defaults to
+	false, unless `core.featureAdoptionRate` is at least five.
 
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
index 5753153a84..c700edc286 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -16,6 +16,9 @@ static int git_repo_config(const char *key, const char *value, void *cb)
 			UPDATE_DEFAULT(rs->gc_write_commit_graph, 1);
 			UPDATE_DEFAULT(rs->index_version, 4);
 		}
+		if (rate >= 5) {
+			UPDATE_DEFAULT(rs->pack_use_sparse, 1);
+		}
 		return 0;
 	}
 	if (!strcmp(key, "core.commitgraph")) {
@@ -26,6 +29,10 @@ static int git_repo_config(const char *key, const char *value, void *cb)
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
@@ -44,6 +51,7 @@ void prepare_repo_settings(struct repository *r)
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
