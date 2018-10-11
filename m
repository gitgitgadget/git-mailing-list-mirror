Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADFA21F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 23:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbeJLGiw (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 02:38:52 -0400
Received: from mail-pg1-f202.google.com ([209.85.215.202]:47972 "EHLO
        mail-pg1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbeJLGiv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 02:38:51 -0400
Received: by mail-pg1-f202.google.com with SMTP id o18-v6so7705636pgv.14
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 16:09:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=N7I3RshLHncvzvT/7pE5SY78VtV4e6nwiGDO9nhApx4=;
        b=dJLPSrLr6QZhNR9JDphGoQ9koDbwcb7VdKt7pKqnykh2djq+Rgr31z1QkVb0KmzBFS
         t/zIGN4fIsFKXIALUVaPDN0D2q8LgGJxjYGkWRSop+NJcxK85joZXLQt3pjnupP0o0iN
         mZJxQa90dYtYdGuCZmvTtPUsi9cg8PTNktK1evbrorsmEOpb0c5oZolpyHQePhnjNZSP
         xt6JoHUqRKYbpn6fieBFePnPr6rBVzEob2RCAkVpqZtRLBK2ditNMcZdT4TR6qOnKC2T
         hzov8lrty2L+WTa7z//0Jg8O8Pd0+MjKYe/PtXbQKFGu0HfOWTsaHr58ERzK39z9kC8A
         Mm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=N7I3RshLHncvzvT/7pE5SY78VtV4e6nwiGDO9nhApx4=;
        b=X4+u1tXYNyICqxbCDe/FS+wouyxjw4I8nFXdawfqVwTMbMDa9NuHpVVC+kb0EwFHZt
         rmxAFiL/oSNKcy/CKrjVl6k3/Q424+EmxGREU35YVgDedKXliF2BLnyQXUGNEARwYdnX
         QS8n6ujnrNYW9Js8+oJQ4LWZBfERvd26XCgqAd2rWjjjZQkZ53UvkeiYNRhotJE5AkGi
         dUqyrPGsX/p69tFSRFMi/PH5i2lkgLmmd2rnQDsUIM4eBhESz/GBsknDDaNswgcO8C8k
         nsQqiBRzkaTxoJJVwRv8LveJv1tASmqvweKX8UAiYgaEeR9sIpmvjBfpDXfYLBzjCAqg
         L35g==
X-Gm-Message-State: ABuFfojIh0Jitzw79fdvKLTedumCH9giNDuaxOcgzpuC4lSiDlKwUuD2
        zaIM0w0p8qZiAbEa+/uRUiXIJ7k6JU3VAVAFI5LNGP6nkeUVqlvtP0bOE70YjwgH3ZqbTNOvSMr
        +9CGYr5UxZ9J7O9m4m5Ea2uwYz1TheCPlQbzNeDtQGm3QFMYk0ZMY9L07j0s=
X-Google-Smtp-Source: ACcGV609kbxrJlQhaUsYpS2xJ7Q/TkNJmq6EHmXT/aWsTTJmeU+uPYjSgYikqEt4uiHaQEvfJJ4s7WboRZxJ
X-Received: by 2002:a62:c6c8:: with SMTP id x69-v6mr2066358pfk.43.1539299362717;
 Thu, 11 Oct 2018 16:09:22 -0700 (PDT)
Date:   Thu, 11 Oct 2018 16:09:01 -0700
In-Reply-To: <cover.1539298957.git.matvore@google.com>
Message-Id: <a1ddae16bae563dd904555661e2e916536f388d8.1539298957.git.matvore@google.com>
Mime-Version: 1.0
References: <cover.1539298957.git.matvore@google.com>
X-Mailer: git-send-email 2.19.1.331.ge82ca0e54c-goog
Subject: [RFC PATCH 2/3] Documentation/git-rev-list: s/<commit>/<object>/
From:   Matthew DeVore <matvore@google.com>
To:     git@vger.kernel.org
Cc:     Matthew DeVore <matvore@google.com>, sbeller@google.com,
        git@jeffhostetler.com, jeffhost@microsoft.com, peff@peff.net,
        stefanbeller@gmail.com, jonathantanmy@google.com,
        gitster@pobox.com, pclouds@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-rev-list has a mode where it works on the granularity of trees and
blobs, rather than commits only. When discussing this mode in
documenation, it can get awkward to refer to the list of arguments that
may include blobs and trees as <commit>. It is especially awkward in a
follow-up patch, so prepare for that patch by renaming the argument.

In addition to simply renaming the argument, also reword documentation
in some places such that we include non-commit objects in our
terminology. In other words, s/commit/object/ in any prose where the
context obviously applies to trees and blobs in a non-pathological way.

Signed-off-by: Matthew DeVore <matvore@google.com>
---
 Documentation/git-rev-list.txt     | 21 ++++++++++++---------
 Documentation/rev-list-options.txt | 16 ++++++++--------
 builtin/rev-list.c                 |  2 +-
 3 files changed, 21 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 88609ff43..b3357932c 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -60,20 +60,23 @@ SYNOPSIS
 	     [ --no-walk ] [ --do-walk ]
 	     [ --count ]
 	     [ --use-bitmap-index ]
-	     <commit>... [ \-- <paths>... ]
+	     <object>... [ \-- <paths>... ]
 
 DESCRIPTION
 -----------
 
-List commits that are reachable by following the `parent` links from the
-given commit(s), but exclude commits that are reachable from the one(s)
-given with a '{caret}' in front of them.  The output is given in reverse
-chronological order by default.
+List objects that are reachable by following references from the given
+object(s), but exclude objects that are reachable from the one(s) given
+with a '{caret}' in front of them.
 
-You can think of this as a set operation.  Commits given on the command
-line form a set of commits that are reachable from any of them, and then
-commits reachable from any of the ones given with '{caret}' in front are
-subtracted from that set.  The remaining commits are what comes out in the
+By default, only commit objects are shown, and the commits are shown in
+reverse chronological order. The '--object' flag causes non-commit objects
+to also be shown.
+
+You can think of this as a set operation.  Objects given on the command
+line form a set of objects that are reachable from any of them, and then
+objects reachable from any of the ones given with '{caret}' in front are
+subtracted from that set.  The remaining objects are what come out in the
 command's output.  Various other options and paths parameters can be used
 to further limit the result.
 
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 5f1672913..c2c1c40e6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -139,29 +139,29 @@ parents) and `--max-parents=-1` (negative numbers denote no upper limit).
 
 --all::
 	Pretend as if all the refs in `refs/`, along with `HEAD`, are
-	listed on the command line as '<commit>'.
+	listed on the command line as '<object>'.
 
 --branches[=<pattern>]::
 	Pretend as if all the refs in `refs/heads` are listed
-	on the command line as '<commit>'. If '<pattern>' is given, limit
+	on the command line as '<object>'. If '<pattern>' is given, limit
 	branches to ones matching given shell glob. If pattern lacks '?',
 	'{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
 --tags[=<pattern>]::
 	Pretend as if all the refs in `refs/tags` are listed
-	on the command line as '<commit>'. If '<pattern>' is given, limit
+	on the command line as '<object>'. If '<pattern>' is given, limit
 	tags to ones matching given shell glob. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
 --remotes[=<pattern>]::
 	Pretend as if all the refs in `refs/remotes` are listed
-	on the command line as '<commit>'. If '<pattern>' is given, limit
+	on the command line as '<object>'. If '<pattern>' is given, limit
 	remote-tracking branches to ones matching given shell glob.
 	If pattern lacks '?', '{asterisk}', or '[', '/{asterisk}' at the end is implied.
 
 --glob=<glob-pattern>::
 	Pretend as if all the refs matching shell glob '<glob-pattern>'
-	are listed on the command line as '<commit>'. Leading 'refs/',
+	are listed on the command line as '<object>'. Leading 'refs/',
 	is automatically prepended if missing. If pattern lacks '?', '{asterisk}',
 	or '[', '/{asterisk}' at the end is implied.
 
@@ -182,7 +182,7 @@ explicitly.
 
 --reflog::
 	Pretend as if all objects mentioned by reflogs are listed on the
-	command line as `<commit>`.
+	command line as `<object>`.
 
 --single-worktree::
 	By default, all working trees will be examined by the
@@ -205,9 +205,9 @@ ifndef::git-rev-list[]
 endif::git-rev-list[]
 
 --stdin::
-	In addition to the '<commit>' listed on the command
+	In addition to the '<object>' listed on the command
 	line, read them from the standard input. If a `--` separator is
-	seen, stop reading commits and start reading paths to limit the
+	seen, stop reading objects and start reading paths to limit the
 	result.
 
 ifdef::git-rev-list[]
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 49d6deed7..9817e6747 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -21,7 +21,7 @@
 #include "object-store.h"
 
 static const char rev_list_usage[] =
-"git rev-list [OPTION] <commit-id>... [ -- paths... ]\n"
+"git rev-list [OPTION] <object-id>... [ -- paths... ]\n"
 "  limiting output:\n"
 "    --max-count=<n>\n"
 "    --max-age=<epoch>\n"
-- 
2.19.1.331.ge82ca0e54c-goog

