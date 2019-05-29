Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 438641F462
	for <e@80x24.org>; Wed, 29 May 2019 20:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfE2UST (ORCPT <rfc822;e@80x24.org>);
        Wed, 29 May 2019 16:18:19 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:45754 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726038AbfE2UST (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 May 2019 16:18:19 -0400
Received: by mail-qt1-f202.google.com with SMTP id g14so2973313qta.12
        for <git@vger.kernel.org>; Wed, 29 May 2019 13:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:subject:from:to:cc;
        bh=MKBWDzhD5SZMbo2FuNm/0MIB6QloxYsuTSbcvXs+aH8=;
        b=rDkmTixD6OqNEYBXWd40q1e6GKODF74PkBjQu5HNj8RZpWfP0eDFVP4G7g33wp4tLp
         ZbjYbEa1xpX+yvFWiH5Cj9Grqxdo96ACmsCf5WGz5YI8oNsvrSI35ge0rOYrPkdNu3Jl
         H98DY31hXqGBHns1z7yvjEcepySqFB4YsIuv0AZzI1sRds0kKWzG5VyWZG1mWhrGDK1K
         yDyA1X6Sd44qhRn0sDmq21CLw3MFVAFZU5dZSQyOmPVlsEhojqkTrezq9mKnNr2ZlZhs
         zqLr3qAY6gJubsLqOj0eceWSYOmggAYB6xrFt6aFkMJnP6UUCNkNYveid+AvI0zYEa1Q
         FDfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version:subject
         :from:to:cc;
        bh=MKBWDzhD5SZMbo2FuNm/0MIB6QloxYsuTSbcvXs+aH8=;
        b=rpYQQnO7W/Kq3+pTVhBKxNxHVn/IMADKMhegDN55X5cNEJ4WR+xNmekNi5QN8RY7t2
         Hm+wWVVKs7AlZ6FuWxuWe9yJA+V5JBiu+0z1j6beN/AoM88JLW9lB1aunJ/qHC+nPqUT
         4ggldx3OFvv7ZymeoVmZ98VMJxVi92I4cfPDVwqHUhhKxZuQrFZwwZpNFp+HUg+zW6BY
         Yp/Q6zh3GBX8C1QZ0t7+0eLP6D8VbZSOLy8wVYBOYE05OA7B2+HWiYrARUZyqXQm7a9B
         scQbjW9X4yVN6RDL+q+qmiEuJ5kZdIN3d24GPVOTDmpN+4Q/S//b7E0rW8BfA2qDLEx8
         n/zQ==
X-Gm-Message-State: APjAAAUEW0cMbtj4rAlggTIBfK/6iyAC0gxAAv1oBQ3QA4RmeSL/LnQu
        wYGLXf3b6nWv5yJ1jLq1ZPdHm5epwfqin1fzuZHjCXYdKK69MotIu6mqDV17/hWuHXa8gh3q4wX
        aipc51zTFiefyFOIa4qXYhD7LSATIf5/I6v8pcVtXlpaIPSVNV6Yc42ob/pH3mCi7xcXXh6EVeg
        ==
X-Google-Smtp-Source: APXvYqwm9SJmx5sAvlLj1nB7zEhGEXVhqsIRaaesiT6cFgYTraOBj5MVp7SQTNwOAiQqRUvCVDw52nereYEMraPwNRc=
X-Received: by 2002:a37:7a05:: with SMTP id v5mr3653283qkc.74.1559161097714;
 Wed, 29 May 2019 13:18:17 -0700 (PDT)
Date:   Wed, 29 May 2019 13:18:09 -0700
In-Reply-To: <20190517190359.21676-1-emilyshaffer@google.com>
Message-Id: <20190529201809.169065-1-emilyshaffer@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.22.0.rc1.257.g3120a18244-goog
Subject: [PATCH] doc: add some nit fixes to MyFirstContribution
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A trial run-through of the tutorial revealed a few typos and missing
commands in the tutorial itself. This commit fixes typos, clarifies
which lines to keep or modify in some places, and adds a section on
putting the git-psuh binary into the gitignore.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---
This patch is based on next, as the doc hasn't made it to master yet.

- Missing `cd git` after cloning the repo
- Documented how to add git-psuh to the gitignore
- Documented the need to leave prior printfs in place during the
  tutorial
- Typos: missing ;, stray newline
- Missing `git add builtin/psuh.c` in a couple of places; this could
  also have been done by adding the filename to the end of the commit
  call, but I don't think that's a good habit (as opposed to staging all
  changes, inspecting the wt state, and then committing). Open for
  debate.

Big thanks to Christian for the trial run and review.

 - Emily

 Documentation/MyFirstContribution.txt | 31 +++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/Documentation/MyFirstContribution.txt b/Documentation/MyFirstContribution.txt
index 274df8575b..895b7cfd4f 100644
--- a/Documentation/MyFirstContribution.txt
+++ b/Documentation/MyFirstContribution.txt
@@ -35,6 +35,7 @@ the mirror on GitHub.
 
 ----
 $ git clone https://github.com/git/git git
+$ cd git
 ----
 
 [[identify-problem]]
@@ -164,8 +165,28 @@ $ ./bin-wrappers/git psuh
 
 Check it out! You've got a command! Nice work! Let's commit this.
 
+`git status` reveals modified `Makefile`, `builtin.h`, and `git.c` as well as
+untracked `builtin/psuh.c` and `git-psuh`. First, let's take care of the binary,
+which should be ignored. Open `.gitignore` in your editor, find `/git-push`, and
+add an entry for your new command in alphabetical order:
+
+----
+...
+/git-prune-packed
+/git-psuh
+/git-pull
+/git-push
+/git-quiltimport
+/git-range-diff
+...
+----
+
+Checking `git status` again should show that `git-psuh` has been removed from
+the untracked list and `.gitignore` has been added to the modified list. Now we
+can stage and commit:
+
 ----
-$ git add Makefile builtin.h builtin/psuh.c git.c
+$ git add Makefile builtin.h builtin/psuh.c git.c .gitignore
 $ git commit -s
 ----
 
@@ -211,7 +232,8 @@ on the reference implementation linked at the top of this document.
 It's probably useful to do at least something besides printing out a string.
 Let's start by having a look at everything we get.
 
-Modify your `cmd_psuh` implementation to dump the args you're passed:
+Modify your `cmd_psuh` implementation to dump the args you're passed, keeping
+existing `printf()` calls in place:
 
 ----
 	int i;
@@ -243,7 +265,7 @@ function body:
 
 ...
 
-	git_config(git_default_config, NULL)
+	git_config(git_default_config, NULL);
 	if (git_config_get_string_const("user.name", &cfg_name) > 0)
 		printf(_("No name is found in config\n"));
 	else
@@ -315,6 +337,7 @@ Run it again. Check it out - here's the (verbose) name of your current branch!
 Let's commit this as well.
 
 ----
+$ git add builtin/psuh.c
 $ git commit -sm "psuh: print the current branch"
 ----
 
@@ -366,6 +389,7 @@ see the subject line of the most recent commit in `origin/master` that you know
 about. Neat! Let's commit that as well.
 
 ----
+$ git add builtin/psuh.c
 $ git commit -sm "psuh: display the top of origin/master"
 ----
 
@@ -418,7 +442,6 @@ OUTPUT
 ------
 ...
 
-
 GIT
 ---
 Part of the linkgit:git[1] suite
-- 
2.22.0.rc1.257.g3120a18244-goog

