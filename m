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
	by dcvr.yhbt.net (Postfix) with ESMTP id 185961F4C0
	for <e@80x24.org>; Tue, 29 Oct 2019 10:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726757AbfJ2KAz (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Oct 2019 06:00:55 -0400
Received: from mail-wm1-f54.google.com ([209.85.128.54]:36895 "EHLO
        mail-wm1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726342AbfJ2KAy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Oct 2019 06:00:54 -0400
Received: by mail-wm1-f54.google.com with SMTP id q130so1692757wme.2
        for <git@vger.kernel.org>; Tue, 29 Oct 2019 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=12WZXDvSSSFUqF+tPHhMpooqo/fLyKCbw1DKsKakPTE=;
        b=Q9XGrqy+mfsGTSo+JUxfLPZjZZ5QkUiWlGOn/ISerB/r4+jxYOGKfx2n/5Y+a12NIJ
         DwJiJHWr8dAkNzo9eTKIcf7qdus/nAaLaW2a2A0aPKxjq9/UheP58CKWrd4MtnscDFAC
         TQJib0670N4USbZsXiiAZAjAnBuNZ9EXemmWW0Svvhlee8M54SJ99jJxatKqdHYUXMah
         UQjlFAmUaNChQJLIV75ZQ64qDwFqCfATWHXKKd90GR+WuA2beWosIKrbTpDMPMqG6QOw
         +UcQYo26obfCzPiNuL9wQWuup6nYW0/1DAo7p2D/Li1FFzEO/51yb/bc3XoG9JVE8oL/
         JYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=12WZXDvSSSFUqF+tPHhMpooqo/fLyKCbw1DKsKakPTE=;
        b=A1nb0C5uHj4XRHJhxjy6g5QckjBHLGdkU9GrUfwUYbUSU68DbXf4XZZy27aOuLdig0
         ekcYT49eK25ndjYZj5u6+IAxTA8eWyJzk5gH7jXy+rutCtfITaHlz8P2dZ58BOVVwuaU
         q+Y49pNIm02fg6wQXpgE71YH7+sf18eiOeasnW1JNdf2Btj5eX1qqVZej+YHM3nQwNgt
         EhPo0tlrgH9P+IP1Ghvo6q6LfDTqfafJus/Uqh8VtJgi3MwHvVlwvgs2WpFA24Czz1fW
         ehBLtovE/pqnn/eAnmyVURuy5mjnN3fwSlugXpYkNkNMoDGWz7zWDXd7/GsumlW+lI1I
         UDUQ==
X-Gm-Message-State: APjAAAW1RBw04zvJbtRenPxphP5tTt8JoHEE/vOcxPKCj9uBgaaAYN6r
        8CIrCgBX3UX937Pp4UNlTU+eGnX3
X-Google-Smtp-Source: APXvYqwfskp/slbRr430h94OJD6CzhwEO1mjrcjz0Ekntxp/Pcw7QW2EAXed0++7H+0aLZvKsPGHfg==
X-Received: by 2002:a1c:49d5:: with SMTP id w204mr3331589wma.111.1572343252560;
        Tue, 29 Oct 2019 03:00:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p18sm2558212wmi.42.2019.10.29.03.00.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Oct 2019 03:00:52 -0700 (PDT)
Message-Id: <e16f5b25e9763d31a2c2a9cc8e425e92e9db8275.1572343246.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.git.1572343246.gitgitgadget@gmail.com>
References: <pull.434.git.1572343246.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 29 Oct 2019 10:00:42 +0000
Subject: [PATCH 06/10] remote: move doc to remote.h and refspec.h
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

Move the documentation from Documentation/technical/api-remote.txt to
remote.h and refspec.h as it's easier for the developers to find the usage
information beside the code instead of looking for it in another doc file.

N.B. The doc for both push and fetch members of the remote struct aren't
moved because they are out of date, as the members were changed from arrays
of rspecs to struct refspec 2 years ago.

Also documentation/technical/api-remote.txt is removed because the
information it has is now redundant and it'll be hard to keep it up to
date and synchronized with the documentation in the header file.

Signed-off-by: Heba Waly <heba.waly@gmail.com>
---
 Documentation/technical/api-remote.txt | 127 -------------------------
 refspec.h                              |  16 ++++
 remote.h                               |  57 ++++++++++-
 3 files changed, 70 insertions(+), 130 deletions(-)
 delete mode 100644 Documentation/technical/api-remote.txt

diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
deleted file mode 100644
index f10941b2e8..0000000000
--- a/Documentation/technical/api-remote.txt
+++ /dev/null
@@ -1,127 +0,0 @@
-Remotes configuration API
-=========================
-
-The API in remote.h gives access to the configuration related to
-remotes. It handles all three configuration mechanisms historically
-and currently used by Git, and presents the information in a uniform
-fashion. Note that the code also handles plain URLs without any
-configuration, giving them just the default information.
-
-struct remote
--------------
-
-`name`::
-
-	The user's nickname for the remote
-
-`url`::
-
-	An array of all of the url_nr URLs configured for the remote
-
-`pushurl`::
-
-	An array of all of the pushurl_nr push URLs configured for the remote
-
-`push`::
-
-	 An array of refspecs configured for pushing, with
-	 push_refspec being the literal strings, and push_refspec_nr
-	 being the quantity.
-
-`fetch`::
-
-	An array of refspecs configured for fetching, with
-	fetch_refspec being the literal strings, and fetch_refspec_nr
-	being the quantity.
-
-`fetch_tags`::
-
-	The setting for whether to fetch tags (as a separate rule from
-	the configured refspecs); -1 means never to fetch tags, 0
-	means to auto-follow tags based on the default heuristic, 1
-	means to always auto-follow tags, and 2 means to fetch all
-	tags.
-
-`receivepack`, `uploadpack`::
-
-	The configured helper programs to run on the remote side, for
-	Git-native protocols.
-
-`http_proxy`::
-
-	The proxy to use for curl (http, https, ftp, etc.) URLs.
-
-`http_proxy_authmethod`::
-
-	The method used for authenticating against `http_proxy`.
-
-struct remotes can be found by name with remote_get(), and iterated
-through with for_each_remote(). remote_get(NULL) will return the
-default remote, given the current branch and configuration.
-
-struct refspec
---------------
-
-A struct refspec holds the parsed interpretation of a refspec.  If it
-will force updates (starts with a '+'), force is true.  If it is a
-pattern (sides end with '*') pattern is true.  src and dest are the
-two sides (including '*' characters if present); if there is only one
-side, it is src, and dst is NULL; if sides exist but are empty (i.e.,
-the refspec either starts or ends with ':'), the corresponding side is
-"".
-
-An array of strings can be parsed into an array of struct refspecs
-using parse_fetch_refspec() or parse_push_refspec().
-
-remote_find_tracking(), given a remote and a struct refspec with
-either src or dst filled out, will fill out the other such that the
-result is in the "fetch" specification for the remote (note that this
-evaluates patterns and returns a single result).
-
-struct branch
--------------
-
-Note that this may end up moving to branch.h
-
-struct branch holds the configuration for a branch. It can be looked
-up with branch_get(name) for "refs/heads/{name}", or with
-branch_get(NULL) for HEAD.
-
-It contains:
-
-`name`::
-
-	The short name of the branch.
-
-`refname`::
-
-	The full path for the branch ref.
-
-`remote_name`::
-
-	The name of the remote listed in the configuration.
-
-`merge_name`::
-
-	An array of the "merge" lines in the configuration.
-
-`merge`::
-
-	An array of the struct refspecs used for the merge lines. That
-	is, merge[i]->dst is a local tracking ref which should be
-	merged into this branch by default.
-
-`merge_nr`::
-
-	The number of merge configurations
-
-branch_has_merge_config() returns true if the given branch has merge
-configuration given.
-
-Other stuff
------------
-
-There is other stuff in remote.h that is related, in general, to the
-process of interacting with remotes.
-
-(Daniel Barkalow)
diff --git a/refspec.h b/refspec.h
index 9b6e64a824..3f2bd4aaa5 100644
--- a/refspec.h
+++ b/refspec.h
@@ -20,6 +20,22 @@ struct refspec_item {
 #define REFSPEC_INIT_FETCH { .fetch = REFSPEC_FETCH }
 #define REFSPEC_INIT_PUSH { .fetch = REFSPEC_PUSH }
 
+/**
+ * A struct refspec holds the parsed interpretation of a refspec.  If it will
+ * force updates (starts with a '+'), force is true.  If it is a pattern
+ * (sides end with '*') pattern is true.  src and dest are the two sides
+ * (including '*' characters if present); if there is only one side, it is src,
+ * and dst is NULL; if sides exist but are empty (i.e., the refspec either
+ * starts or ends with ':'), the corresponding side is "".
+ *
+ * An array of strings can be parsed into an array of struct refspecs using
+ * parse_fetch_refspec() or parse_push_refspec().
+ *
+ * remote_find_tracking(), given a remote and a struct refspec with either src
+ * or dst filled out, will fill out the other such that the result is in the
+ * "fetch" specification for the remote (note that this evaluates patterns and
+ * returns a single result).
+ */
 struct refspec {
 	struct refspec_item *items;
 	int alloc;
diff --git a/remote.h b/remote.h
index 0e1d2b245b..2277426199 100644
--- a/remote.h
+++ b/remote.h
@@ -6,6 +6,14 @@
 #include "hashmap.h"
 #include "refspec.h"
 
+/**
+ * The API gives access to the configuration related to remotes. It handles
+ * all three configuration mechanisms historically and currently used by Git,
+ * and presents the information in a uniform fashion. Note that the code also
+ * handles plain URLs without any configuration, giving them just the default
+ * information.
+ */
+
 enum {
 	REMOTE_UNCONFIGURED = 0,
 	REMOTE_CONFIG,
@@ -16,16 +24,22 @@ enum {
 struct remote {
 	struct hashmap_entry ent;
 
+	/* The user's nickname for the remote */
 	const char *name;
+
 	int origin, configured_in_repo;
 
 	const char *foreign_vcs;
 
+	/* An array of all of the url_nr URLs configured for the remote */
 	const char **url;
+
 	int url_nr;
 	int url_alloc;
 
+	/* An array of all of the pushurl_nr push URLs configured for the remote */
 	const char **pushurl;
+
 	int pushurl_nr;
 	int pushurl_alloc;
 
@@ -34,32 +48,47 @@ struct remote {
 	struct refspec fetch;
 
 	/*
+	 * The setting for whether to fetch tags (as a separate rule from the
+	 * configured refspecs);
 	 * -1 to never fetch tags
 	 * 0 to auto-follow tags on heuristic (default)
 	 * 1 to always auto-follow tags
 	 * 2 to always fetch tags
 	 */
 	int fetch_tags;
+
 	int skip_default_update;
 	int mirror;
 	int prune;
 	int prune_tags;
 
+	/**
+	 * The configured helper programs to run on the remote side, for
+	 * Git-native protocols.
+	 */
 	const char *receivepack;
 	const char *uploadpack;
 
-	/*
-	 * for curl remotes only
-	 */
+	/* The proxy to use for curl (http, https, ftp, etc.) URLs. */
 	char *http_proxy;
+
+	/* The method used for authenticating against `http_proxy`. */
 	char *http_proxy_authmethod;
 };
 
+/**
+ * struct remotes can be found by name with remote_get().
+ * remote_get(NULL) will return the default remote, given the current branch
+ * and configuration.
+ */
 struct remote *remote_get(const char *name);
+
 struct remote *pushremote_get(const char *name);
 int remote_is_configured(struct remote *remote, int in_repo);
 
 typedef int each_remote_fn(struct remote *remote, void *priv);
+
+/* iterate through struct remotes */
 int for_each_remote(each_remote_fn fn, void *priv);
 
 int remote_has_url(struct remote *remote, const char *url);
@@ -194,16 +223,36 @@ struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
  */
 int remote_find_tracking(struct remote *remote, struct refspec_item *refspec);
 
+/**
+ * struct branch holds the configuration for a branch. It can be looked up with
+ * branch_get(name) for "refs/heads/{name}", or with branch_get(NULL) for HEAD.
+ */
 struct branch {
+
+    /* The short name of the branch. */
 	const char *name;
+
+	/* The full path for the branch ref. */
 	const char *refname;
 
+	/* The name of the remote listed in the configuration. */
 	const char *remote_name;
+
 	const char *pushremote_name;
 
+	/* An array of the "merge" lines in the configuration. */
 	const char **merge_name;
+
+	/**
+	 * An array of the struct refspecs used for the merge lines. That is,
+	 * merge[i]->dst is a local tracking ref which should be merged into this
+	 * branch by default.
+	 */
 	struct refspec_item **merge;
+
+	/* The number of merge configurations */
 	int merge_nr;
+
 	int merge_alloc;
 
 	const char *push_tracking_ref;
@@ -215,7 +264,9 @@ const char *pushremote_for_branch(struct branch *branch, int *explicit);
 const char *remote_ref_for_branch(struct branch *branch, int for_push,
 				  int *explicit);
 
+/* returns true if the given branch has merge configuration given. */
 int branch_has_merge_config(struct branch *branch);
+
 int branch_merge_matches(struct branch *, int n, const char *);
 
 /**
-- 
gitgitgadget

