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
	by dcvr.yhbt.net (Postfix) with ESMTP id 599121F454
	for <e@80x24.org>; Wed,  6 Nov 2019 10:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731776AbfKFKAF (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 05:00:05 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:40399 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731697AbfKFKAE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 05:00:04 -0500
Received: by mail-wm1-f51.google.com with SMTP id f3so2555707wmc.5
        for <git@vger.kernel.org>; Wed, 06 Nov 2019 02:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mPeoWAcBb00eGe8EIY/HsjteDgVd3vEwluZm6lyqWhE=;
        b=XVoNVhZmrLL3hTbpZ2fGLl7KlxNBCy+iu9eLAlsS8AfbISa8m2O98UW6Yj4a9hMYJk
         NdqkHVpsbEIAfEOaxiXfV1oYO4Dez7avRAheCJ1QIoyEZJvMFupq5fu0+0HTJNjbi8fB
         yTKFc27QvV9EiCNl57OxkRQwZt8gRMRiOUjOaX9Jbx1vfaD33Jc9LMCG4JlSHLVqM/We
         RbtqgU5v+qOdXmADkdpq+dRZKSEUL3DZCOo/sVRFsFDhefEq/c/uOzpcdr3vvoMz1fIy
         LpQm0VjelDkweRdZD1npqX2CPpTExfzxfr/nrHqEP+2uqyXJ6tarQID3Q8CSZ1L3SxGd
         cMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mPeoWAcBb00eGe8EIY/HsjteDgVd3vEwluZm6lyqWhE=;
        b=M3K42DKm7ImqjjqtXgM4yHkg9tkCBCTcCyyupowXDhkLTRsoA/cfcpVqGHj7ba1eXB
         c3p6kuTNxqnWbjjo9aKPEDBH1k60aDiGOxSt8Z3arQJtbj9jhDC6ZToHmMxROW0/bWkK
         VOeLYSPSDoapfszdAyMboB2V2Sxe8/HK34PiVVHZuLU67onX7pHbLLxp8WGAnIkAE1P3
         OOlf2SAb0zU3uE4INtkpuKYgnNW9MokZ3HoCHsOzctyD4mHqJCF1qKsU6RNQ1YhFIq1G
         1JfwFstbqkE2y8qm6rwNTp8MuFVRvVEjZmICq8c7VjM6GhTWjRmOMTXNnX7koFbsP+oA
         d0PQ==
X-Gm-Message-State: APjAAAV/FfSbOq3PyZX+7XyGAc2mWxSYTGMU5RHr+cCfa11aPJaWNbSL
        /SKyRAhdiZAM9qSIyK9kDEghZP30
X-Google-Smtp-Source: APXvYqzgAmYWEJ6DLcufRY6V5XtK0Owu0PHaYz4c0ozrX8BZpNcvbGqizMzktHN8X1yZeXaZ5oKGCA==
X-Received: by 2002:a7b:c747:: with SMTP id w7mr1719929wmk.62.1573034402194;
        Wed, 06 Nov 2019 02:00:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v184sm2566830wme.31.2019.11.06.02.00.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Nov 2019 02:00:01 -0800 (PST)
Message-Id: <7fa5cdf83ff7bc4811e30d0a0e038a27154a8809.1573034387.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
        <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 06 Nov 2019 09:59:46 +0000
Subject: [PATCH v2 19/20] submodule-config: move doc to submodule-config.h
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Heba Waly <heba.waly@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Heba Waly <heba.waly@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Heba Waly <heba.waly@gmail.com>

Move the documentation from Documentation/technical/api-submodule-config.txt
to submodule-config.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

Documentation/technical/api-submodule-config.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

The documentation of parse_submodule_config_option() is discarded as the
function was removed 2 years ago.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 .../technical/api-submodule-config.txt        | 66 -------------------
 submodule-config.h                            | 38 ++++++++++-
 2 files changed, 37 insertions(+), 67 deletions(-)
 delete mode 100644 Documentation/technical/api-submodule-config.txt

diff --git a/Documentation/technical/api-submodule-config.txt b/Documentation/technical/api-submodule-config.txt
deleted file mode 100644
index fb06089393..0000000000
--- a/Documentation/technical/api-submodule-config.txt
+++ /dev/null
@@ -1,66 +0,0 @@
-submodule config cache API
-==========================
-
-The submodule config cache API allows to read submodule
-configurations/information from specified revisions. Internally
-information is lazily read into a cache that is used to avoid
-unnecessary parsing of the same .gitmodules files. Lookups can be done by
-submodule path or name.
-
-Usage
------
-
-To initialize the cache with configurations from the worktree the caller
-typically first calls `gitmodules_config()` to read values from the
-worktree .gitmodules and then to overlay the local git config values
-`parse_submodule_config_option()` from the config parsing
-infrastructure.
-
-The caller can look up information about submodules by using the
-`submodule_from_path()` or `submodule_from_name()` functions. They return
-a `struct submodule` which contains the values. The API automatically
-initializes and allocates the needed infrastructure on-demand. If the
-caller does only want to lookup values from revisions the initialization
-can be skipped.
-
-If the internal cache might grow too big or when the caller is done with
-the API, all internally cached values can be freed with submodule_free().
-
-Data Structures
----------------
-
-`struct submodule`::
-
-	This structure is used to return the information about one
-	submodule for a certain revision. It is returned by the lookup
-	functions.
-
-Functions
----------
-
-`void submodule_free(struct repository *r)`::
-
-	Use these to free the internally cached values.
-
-`int parse_submodule_config_option(const char *var, const char *value)`::
-
-	Can be passed to the config parsing infrastructure to parse
-	local (worktree) submodule configurations.
-
-`const struct submodule *submodule_from_path(const unsigned char *treeish_name, const char *path)`::
-
-	Given a tree-ish in the superproject and a path, return the
-	submodule that is bound at the path in the named tree.
-
-`const struct submodule *submodule_from_name(const unsigned char *treeish_name, const char *name)`::
-
-	The same as above but lookup by name.
-
-Whenever a submodule configuration is parsed in `parse_submodule_config_option`
-via e.g. `gitmodules_config()`, it will overwrite the null_sha1 entry.
-So in the normal case, when HEAD:.gitmodules is parsed first and then overlayed
-with the repository configuration, the null_sha1 entry contains the local
-configuration of a submodule (e.g. consolidated values from local git
-configuration and the .gitmodules file in the worktree).
-
-For an example usage see test-submodule-config.c.
diff --git a/submodule-config.h b/submodule-config.h
index 1b4e2da658..42918b55e8 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -7,9 +7,31 @@
 #include "submodule.h"
 #include "strbuf.h"
 
+/**
+ * The submodule config cache API allows to read submodule
+ * configurations/information from specified revisions. Internally
+ * information is lazily read into a cache that is used to avoid
+ * unnecessary parsing of the same .gitmodules files. Lookups can be done by
+ * submodule path or name.
+ *
+ * Usage
+ * -----
+ *
+ * The caller can look up information about submodules by using the
+ * `submodule_from_path()` or `submodule_from_name()` functions. They return
+ * a `struct submodule` which contains the values. The API automatically
+ * initializes and allocates the needed infrastructure on-demand. If the
+ * caller does only want to lookup values from revisions the initialization
+ * can be skipped.
+ *
+ * If the internal cache might grow too big or when the caller is done with
+ * the API, all internally cached values can be freed with submodule_free().
+ *
+ */
+
 /*
  * Submodule entry containing the information about a certain submodule
- * in a certain revision.
+ * in a certain revision. It is returned by the lookup functions.
  */
 struct submodule {
 	const char *path;
@@ -41,13 +63,27 @@ int parse_update_recurse_submodules_arg(const char *opt, const char *arg);
 int parse_push_recurse_submodules_arg(const char *opt, const char *arg);
 void repo_read_gitmodules(struct repository *repo);
 void gitmodules_config_oid(const struct object_id *commit_oid);
+
+/**
+ * Same as submodule_from_path but lookup by name.
+ */
 const struct submodule *submodule_from_name(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *name);
+
+/**
+ * Given a tree-ish in the superproject and a path, return the submodule that
+ * is bound at the path in the named tree.
+ */
 const struct submodule *submodule_from_path(struct repository *r,
 					    const struct object_id *commit_or_tree,
 					    const char *path);
+
+/**
+ * Use these to free the internally cached values.
+ */
 void submodule_free(struct repository *r);
+
 int print_config_from_gitmodules(struct repository *repo, const char *key);
 int config_set_in_gitmodules_file_gently(const char *key, const char *value);
 
-- 
gitgitgadget

