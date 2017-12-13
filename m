Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E51831F407
	for <e@80x24.org>; Wed, 13 Dec 2017 18:28:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753323AbdLMS2J (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 13:28:09 -0500
Received: from mail-it0-f67.google.com ([209.85.214.67]:36351 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753011AbdLMS2I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 13:28:08 -0500
Received: by mail-it0-f67.google.com with SMTP id d16so5021308itj.1
        for <git@vger.kernel.org>; Wed, 13 Dec 2017 10:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fcN1tXgr4dCEvPLbaXYRaQbf5qaC2mI9CwSkNT7v7fo=;
        b=IJAGO8Yz5va7i8pG9PjDoHKDbnW1sVziabGvD54OtXwxqZjCfwdwuQR1Fq0WAuO1o1
         dM+aeYahrg/oVDBiqxDBKMsdzV/BQiu5eSHz2uD7oiGHhyvkGSe2t84RYrOlokucyJ47
         X6qBIaxsDWOWvqxyNDcRTFtxoDZe/i1dRixUUGmD4Wag8NX+BiyZWjc7hR9TGY9DnypD
         Z+jRQdZLDuFKOXZszqkSlHnuUGohXJz5c/3YR2LgQB1tth6y1Qso/+WxOajmdmrdmZ0Q
         hHzHKkM/E+HrJUzcDVFwO9et4GLO6ZrZjvqhqzuE4No9SwUnfE5nLrYQk0qwU/XVTUq5
         rBsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fcN1tXgr4dCEvPLbaXYRaQbf5qaC2mI9CwSkNT7v7fo=;
        b=nLvh21R+0qpWzDILDGvOH1ZXzuMvI4pPhGLmKbmwhKPZeD3DwzbUOOw/NXvptz9RFv
         VKbCz6YAG/VGcPF8mw5WgTd3Jckco7H0C1ZgzUPhq1YoLoKAYSwz8BEI1q5StFp8lUlp
         SCIxJrDYae1HeGcl/H2iYjVyfIqgj4jaueEgT/a4jRNU3AIr5J3kn27cG83vfwP0ZANb
         UQzeJ1VJCvHBA4v+xq5w95twa9iVNdmW+nVzjp8NEqKX3cDf2+u54qOgc8qA+ckQBLNd
         ahJjssHCD8BgWkGxdCmtQWygNBYpujP51CL2o4bs8MspGqTfWFzlVB36G1kbjl9rFQ/4
         RESg==
X-Gm-Message-State: AKGB3mLA09Nqn6uk6rA5bNhCK2eQAvuniboe0I4pyflKGiyrhvYIFyu5
        UwXUUkHudxOvdfIWmj5WlKNaJFZh2ps=
X-Google-Smtp-Source: ACJfBov7bxABbAcvj0Tp03mtMw6XpFAcG+aLiZ6G3rHPnv8UOcolUkNJKI4i3XyrTJaGJLJm0+SUYA==
X-Received: by 10.36.164.13 with SMTP id z13mr4239511ite.115.1513189687301;
        Wed, 13 Dec 2017 10:28:07 -0800 (PST)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id u132sm1275455itf.37.2017.12.13.10.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 13 Dec 2017 10:28:06 -0800 (PST)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sunshine@sunshineco.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH] path: document path functions
Date:   Wed, 13 Dec 2017 10:28:02 -0800
Message-Id: <20171213182802.114615-1-bmwill@google.com>
X-Mailer: git-send-email 2.15.1.504.g5279b80103-goog
In-Reply-To: <20171212005221.GD177995@google.com>
References: <20171212005221.GD177995@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brandon Williams <bmwill@google.com>
---

As promised here is an update to the documentation for the path generating
functions.

 path.h | 133 ++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 112 insertions(+), 21 deletions(-)

diff --git a/path.h b/path.h
index 9541620c7..1ccd0373c 100644
--- a/path.h
+++ b/path.h
@@ -4,53 +4,144 @@
 struct repository;
 
 /*
- * Return a statically allocated filename, either generically (mkpath), in
- * the repository directory (git_path), or in a submodule's repository
- * directory (git_path_submodule). In all cases, note that the result
- * may be overwritten by another call to _any_ of the functions. Consider
- * using the safer "dup" or "strbuf" formats below (in some cases, the
- * unsafe versions have already been removed).
+ * The result to all functions which return statically allocated memory may be
+ * overwritten by another call to _any_ one of these functions. Consider using
+ * the safer variants which operate on strbufs or return allocated memory.
  */
-extern const char *mkpath(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
-extern const char *git_common_path(const char *fmt, ...) __attribute__((format (printf, 1, 2)));
 
+/*
+ * Return a statically allocated path.
+ */
+extern const char *mkpath(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+
+/*
+ * Return a path.
+ */
+extern char *mkpathdup(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+
+/*
+ * Construct a path and place the result in the provided buffer `buf`.
+ */
 extern char *mksnpath(char *buf, size_t n, const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
-extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
+
+/*
+ * The `git_common_path` family of functions will construct a path into a
+ * repository's common git directory, which is shared by all worktrees.
+ */
+
+/*
+ * Constructs a path into the common git directory of repository `repo` and
+ * append it in the provided buffer `sb`.
+ */
 extern void strbuf_git_common_path(struct strbuf *sb,
 				   const struct repository *repo,
 				   const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
-extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
-extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
-				     const char *fmt, ...)
-	__attribute__((format (printf, 3, 4)));
-extern char *git_pathdup(const char *fmt, ...)
-	__attribute__((format (printf, 1, 2)));
-extern char *mkpathdup(const char *fmt, ...)
+
+/*
+ * Return a statically allocated path into the main repository's
+ * (the_repository) common git directory.
+ */
+extern const char *git_common_path(const char *fmt, ...)
 	__attribute__((format (printf, 1, 2)));
-extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
-	__attribute__((format (printf, 2, 3)));
 
+
+/*
+ * The `git_path` family of functions will construct a path into a repository's
+ * git directory.
+ *
+ * These functions will perform adjustments to the resultant path to account
+ * for special paths which are either considered common among worktrees (e.g.
+ * paths into the object directory) or have been explicitly set via an
+ * environment variable or config (e.g. path to the index file).
+ *
+ * For an exhaustive list of the adjustments made look at `common_list` and
+ * `adjust_git_path` in path.c.
+ */
+
+/*
+ * Return a path into the git directory of repository `repo`.
+ */
 extern char *repo_git_path(const struct repository *repo,
 			   const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+
+/*
+ * Construct a path into the git directory of repository `repo` and append it
+ * to the provided buffer `sb`.
+ */
 extern void strbuf_repo_git_path(struct strbuf *sb,
 				 const struct repository *repo,
 				 const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
+/*
+ * Return a statically allocated path into the main repository's
+ * (the_repository) git directory.
+ */
+extern const char *git_path(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+
+/*
+ * Return a path into the main repository's (the_repository) git directory.
+ */
+extern char *git_pathdup(const char *fmt, ...)
+	__attribute__((format (printf, 1, 2)));
+
+/*
+ * Construct a path into the main repository's (the_repository) git directory
+ * and place it in the provided buffer `buf`, the contents of the buffer will
+ * be overridden.
+ */
+extern char *git_path_buf(struct strbuf *buf, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
+/*
+ * Construct a path into the main repository's (the_repository) git directory
+ * and append it to the provided buffer `sb`.
+ */
+extern void strbuf_git_path(struct strbuf *sb, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
+/*
+ * Return a path into the worktree of repository `repo`.
+ *
+ * If the repository doesn't have a worktree NULL is returned.
+ */
 extern char *repo_worktree_path(const struct repository *repo,
 				const char *fmt, ...)
 	__attribute__((format (printf, 2, 3)));
+
+/*
+ * Construct a path into the worktree of repository `repo` and append it
+ * to the provided buffer `sb`.
+ *
+ * If the repository doesn't have a worktree nothing will be appended to `sb`.
+ */
 extern void strbuf_repo_worktree_path(struct strbuf *sb,
 				      const struct repository *repo,
 				      const char *fmt, ...)
 	__attribute__((format (printf, 3, 4)));
 
+/*
+ * Return a path into a submodule's git directory located at `path`.  `path`
+ * must only reference a submodule of the main repository (the_repository).
+ */
+extern char *git_pathdup_submodule(const char *path, const char *fmt, ...)
+	__attribute__((format (printf, 2, 3)));
+
+/*
+ * Construct a path into a submodule's git directory located at `path` and
+ * append it to the provided buffer `sb`.  `path` must only reference a
+ * submodule of the main repository (the_repository).
+ */
+extern int strbuf_git_path_submodule(struct strbuf *sb, const char *path,
+				     const char *fmt, ...)
+	__attribute__((format (printf, 3, 4)));
+
 extern void report_linked_checkout_garbage(void);
 
 /*
-- 
2.15.1.504.g5279b80103-goog

