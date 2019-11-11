Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E75BB1F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727433AbfKKV2d (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:33 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:38211 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727338AbfKKV2X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:23 -0500
Received: by mail-wr1-f42.google.com with SMTP id i12so9340075wro.5
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mPeoWAcBb00eGe8EIY/HsjteDgVd3vEwluZm6lyqWhE=;
        b=cSdB+PkBNPfdd5grp5Bpy7OFCfT70SgI3vQwV4bFWHnX1IGciq+8bKvnxmhAw+4pav
         cvj6GSKWXl2yro7UJvNpHZ4dluXhxV23AKBJ74OGyfAdwaUf8QRRNrECX23q8wfyDYjZ
         FAS1spsmtmPHOU3tD0pGSr1CXZNQz74rNCERk3vSt/v+/9G7SirLlvtzYTq/kE2AKKcQ
         xUkTYsbxwL15mcQFkDl+i7fSCvekf+ckdqn9pgQ0dVLdDeJzAlpJPIdL0eYyPOAIqdE9
         1TST53kM1qVeqmzPrjK9NFyawk8c3MYQ8rc2xU0dItfMX+y97hNe+CyxFgDR98mPi+RO
         PnfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=mPeoWAcBb00eGe8EIY/HsjteDgVd3vEwluZm6lyqWhE=;
        b=awC/K9uwY+yBSGjp4MnXN0pPUiAxN55ySNJSUpg97R/Ktw/W/oZURyobct93ZfJJI7
         NAmSuXJ4zaRGRfexcM8s7xvztZJeV/pKgzG0oxM2ozJvAKciktK1i/ex/QvmYFt8kp8A
         02fo5b2v+DuFOsPDtEmI0/rhQcANk9ZkdmbpD5+EAQ/2fWuNgBbTbZfa15B2NiVOwP3H
         DTKOnF1yzZmQqcNEfv4UAIvTGVFJUhmFmCJjcAB7kwS5TFNfBp6Z7l/X4jPLBLM1v7k3
         O+/odrJsGFZz1mZ7nqkv3Id/lv/HRVgyLcwKTdzIgpoKkIeAzGrItcUK5MEDsAnTwyh7
         ib3A==
X-Gm-Message-State: APjAAAXmHED2EiLb67OnX9dbOkG+m7ymDyynDWGT3d8qAyjL5rKtpD5l
        47v+f4x5hoP9GlCoB+0xm2/UcA15
X-Google-Smtp-Source: APXvYqy7xYbIT3oztrqceAMEX9bRQDqOW1dkqropqGItHVy1mLRarRatBRofGOPDjAGBl99oKvU+ww==
X-Received: by 2002:adf:f607:: with SMTP id t7mr19460167wrp.390.1573507700959;
        Mon, 11 Nov 2019 13:28:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x7sm44014105wrg.63.2019.11.11.13.28.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:20 -0800 (PST)
Message-Id: <9f34f3177dd1e44c1e73e035a91fbeb4a7f45d35.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:28:02 +0000
Subject: [PATCH v3 19/21] submodule-config: move doc to submodule-config.h
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

