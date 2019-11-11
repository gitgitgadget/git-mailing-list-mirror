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
	by dcvr.yhbt.net (Postfix) with ESMTP id 53CB31F454
	for <e@80x24.org>; Mon, 11 Nov 2019 21:28:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727316AbfKKV2T (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Nov 2019 16:28:19 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:38209 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727221AbfKKV2Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Nov 2019 16:28:16 -0500
Received: by mail-wr1-f54.google.com with SMTP id i12so9339711wro.5
        for <git@vger.kernel.org>; Mon, 11 Nov 2019 13:28:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r6Mh1Be2zNVsUjhOd1OYeSKrqpkEVebtDayD8sp2b+I=;
        b=c3jV/B0uX+zbSqu1GBgv/bs2hPzl3GtB1h0k3qSGZeBr3jXESEwIjHECaf9BiBd16x
         ToRW2Zvd6zps2gmVcoXpIvhCapIavDdZM3UZlMhY69ZujgQadginxR8p1pM0qbSwS5ax
         M19TFrAk41oRMVrKAteP3w07jN2N0ZMG5IAgP6s0tt5yBKradzypgOju4hpgC3+uHMnm
         pjG6kKC0ZTrR8naho/H6G2Khmd6/clPIwPv0AQMPSSL6YVXREsE6tB6GBu7EbaL9YOeF
         QPCFezIOYlqtzyJ4tIj3Lnjy9GUUER1Mx9wRPbJC3WKeS+hRYT0YDWcxAi7X85xYwK1E
         AlBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r6Mh1Be2zNVsUjhOd1OYeSKrqpkEVebtDayD8sp2b+I=;
        b=rv9AbH9QshEYv3toG6nWNbMxV+KGB5nNKiyO8az95WSDSuiYYu+1ym1y1U7+B3TFJO
         Mpf0zmDV0o8AbpdvH5sLYYJ8a//dyxUGgFmCEnCq/ps1Sc1DUk3xoAcJ2eDkixwcGGCY
         dxa+9VOsYGrdDlKPMFsXYltbpoEhWZg5PdkTBWPkfrcWYL6xoVWBuUquM6YUlIWVPKzr
         WQnrNrV3PFMAe45y7OJJtrhODSyVSjJ18esRsTdM+ttrjOKohLSy66oCU0U6+i+mj72N
         qXMUi9ZWqsh1RMBkPS7ex02FTCETJkexZoSArbf7rgQveNjtyPses8RcoUNaWLXsx2JG
         MYxA==
X-Gm-Message-State: APjAAAV0U0Qhewl3Ti6+IS0l3xmuwzKcMNdmF3zqakcZn0VQMMVsRV7N
        r23+xjmHVZRDPqobx+wd03pd2haN
X-Google-Smtp-Source: APXvYqz0FMpMzf3ZivagSr8Ou2MYtbytnYWYUTm90xhUsMc0FTDH54RSsGbGeKsdypHGPzYaoG+F0w==
X-Received: by 2002:a05:6000:49:: with SMTP id k9mr22788035wrx.43.1573507691271;
        Mon, 11 Nov 2019 13:28:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5sm482024wmk.48.2019.11.11.13.28.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Nov 2019 13:28:10 -0800 (PST)
Message-Id: <52ba4275140423c97455302eb3e14d983e5b57df.1573507684.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
References: <pull.434.v2.git.1573034387.gitgitgadget@gmail.com>
        <pull.434.v3.git.1573507684.gitgitgadget@gmail.com>
From:   "Heba Waly via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 Nov 2019 21:27:49 +0000
Subject: [PATCH v3 06/21] remote: move doc to remote.h and refspec.h
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
index 0e1d2b245b..b134cc21be 100644
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
+	/* The short name of the branch. */
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

