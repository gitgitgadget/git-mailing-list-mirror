Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C2A38FB2
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 23:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kWmSlWw9"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8F144B5
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 15:58:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-32d9d8284abso861988f8f.3
        for <git@vger.kernel.org>; Thu, 09 Nov 2023 15:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699574278; x=1700179078; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=oOi+ZD+ED14jKVPwjnQk8eKTgj/YQsEIxoXgQifJ9gM=;
        b=kWmSlWw9qdCvNn0e80Hw5u06VI8WirW+iVpb0VTs3CFCc+Bbxn7tnsv8Mnmjn0ecXP
         g+QmmxWqq3S90HTzaWkzEW91DFoaWRbAz+Sqs8CDRdSbRByN7AEE2q5hYuqShuQaiDsH
         xjnmMqgy+bHHPRnK1BsowKGEEovTsiVSAS9HNpicQv4EC/NgA6tYuMhBvzepVKSrsYLJ
         Z8nRJcC3Er25Y3B6DzK4/aRbi29vzBJoYaitvUS4CZTIvHoskghpqwoATZpngHDEpysU
         703kf4djDdgd/skcpDbdiN0rVCUqnrh8WgjGDzLVJTpbRmWrVwSdjpkez/E2WZ5EYCLg
         t7Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699574278; x=1700179078;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oOi+ZD+ED14jKVPwjnQk8eKTgj/YQsEIxoXgQifJ9gM=;
        b=QwY3MqBIQkxD8//dX3QHoCUkZ/qPKuhOnI+LnWd2p75ZRvSIFtxAOrHAaSG1J4C3R4
         ZqDQBy0ZNFDj5VFX9Mhhtte2/xU8LFytBfQ402rRmJeOJlXxO6miWjFwV6cG2Ff6P+8J
         zk/3HsyYDqxRSpSWTrVoz17yAkn5/pH0O9LFkrDHklA3tfCmb4hJux/0Uc0cnwSWWxqB
         Ti+1NRBCSqu1Bi++6NFAB96gMdOQy81Ack4q17uT797aQ9d4ncJpG4fwMICHsiUnNUDl
         vv4yGGP4W/jGM/O/fFxbUvcG6rgE4rOamEJuJv8ItfKVFpO8nsFrNxv/sWDOnAMjopdX
         bgvQ==
X-Gm-Message-State: AOJu0Yywwge/n+3Hc/F7HE7Y3Fx8cO+IMtwMeNB+3y8TCTn6voz+VmBl
	0FlsS4CzIHh7i9J3/znkZSqfHlKP4Bs=
X-Google-Smtp-Source: AGHT+IFf66wEEOM0vlxYT3ThC2vkrkFgMXmGnMZUz58wFUwzaSeSxEcGCJLND+rj3nrgWt0cB+9aKw==
X-Received: by 2002:a05:6000:1c1b:b0:32d:9d66:5742 with SMTP id ba27-20020a0560001c1b00b0032d9d665742mr6788866wrb.10.1699574278349;
        Thu, 09 Nov 2023 15:57:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e18-20020adfe7d2000000b0032d8034724esm719554wrn.94.2023.11.09.15.57.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 15:57:58 -0800 (PST)
Message-ID: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Nov 2023 23:57:57 +0000
Subject: [PATCH] glossary: add definitions for dereference & peel
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: ps@pks.im,
    Victoria Dye <vdye@github.com>,
    Victoria Dye <vdye@github.com>

From: Victoria Dye <vdye@github.com>

Add 'gitglossary' definitions for "dereference" (as it used for both symrefs
and objects) and "peel". These terms are used in options and documentation
throughout Git, but they are not clearly defined anywhere and the behavior
they refer to depends heavily on context. Provide explicit definitions to
clarify existing documentation to users and help contributors to use the
most appropriate terminology possible in their additions to Git.

Update other definitions in the glossary that use the term "dereference" to
link to 'def_dereference'.

Signed-off-by: Victoria Dye <vdye@github.com>
---
    glossary: add definitions for dereference & peel
    
    As promised in [1], this patch adds definitions for "peel" and
    "dereference" in the glossary, based on how they're currently used
    throughout Git. As a result, the definitions are somewhat broad
    (although I did my best to explicitly describe the different contexts in
    which they're used). My hope is that this will at least reduce confusion
    around this terminology. These definitions can also serve as a starting
    point if, in the future, another contributor wants to deprecate certain
    usages of these terms to make them less ambiguous.
    
     * Victoria
    
    [1]
    https://lore.kernel.org/git/21dfe606-39f5-4154-aaa4-695e5f6f784d@github.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1610%2Fvdye%2Fvdye%2Fglossary-peel-dereference-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1610/vdye/vdye/glossary-peel-dereference-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1610

 Documentation/glossary-content.txt | 50 +++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 65c89e7b3eb..41dd5721def 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -98,9 +98,8 @@ to point at the new commit.
 	revision.
 
 [[def_commit-ish]]commit-ish (also committish)::
-	A <<def_commit_object,commit object>> or an
-	<<def_object,object>> that can be recursively dereferenced to
-	a commit object.
+	A <<def_commit_object,commit object>> or an <<def_object,object>> that
+	can be recursively <<def_dereference,dereferenced>> to a commit object.
 	The following are all commit-ishes:
 	a commit object,
 	a <<def_tag_object,tag object>> that points to a commit
@@ -125,6 +124,24 @@ to point at the new commit.
 	dangling object has no references to it from any
 	reference or <<def_object,object>> in the <<def_repository,repository>>.
 
+[[def_dereference]]dereference::
+	Referring to a <<def_symref,symbolic ref>>: the action of accessing the
+	<<def_ref,reference>> pointed at by a symbolic ref. Recursive
+	dereferencing involves repeating the aforementioned process on the
+	resulting ref until a non-symbolic reference is found.
++
+Referring to a <<def_tag_object,tag object>>: the action of accessing the
+<<def_object,object>> a tag points at. Tags are recursively dereferenced by
+repeating the operation on the result object until the result has either a
+specified <<def_object_type,object type>> (where applicable) or any non-"tag"
+object type.
++
+Referring to a <<def_commit_object,commit object>>: the action of accessing
+the commit's tree object. Commits cannot be dereferenced recursively.
++
+Unless otherwise specified, "dereferencing" as it used in the context of Git
+commands or protocols is implicitly recursive.
+
 [[def_detached_HEAD]]detached HEAD::
 	Normally the <<def_HEAD,HEAD>> stores the name of a
 	<<def_branch,branch>>, and commands that operate on the
@@ -444,6 +461,12 @@ exclude;;
 	of the logical predecessor(s) in the line of development, i.e. its
 	parents.
 
+[[def_peel]]peel::
+	Synonym for object <<def_dereference,dereference>>. Most commonly used
+	in the context of tags, where it refers to the process of recursively
+	dereferencing a <<def_tag_object,tag object>> until the result object's
+	<<def_object_type,type>> is something other than "tag".
+
 [[def_pickaxe]]pickaxe::
 	The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore
 	routines that help select changes that add or delete a given text
@@ -620,12 +643,11 @@ The most notable example is `HEAD`.
 	copies of) commit objects of the contained submodules.
 
 [[def_symref]]symref::
-	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>>
-	id itself, it is of the format 'ref: refs/some/thing' and when
-	referenced, it recursively dereferences to this reference.
-	'<<def_HEAD,HEAD>>' is a prime example of a symref. Symbolic
-	references are manipulated with the linkgit:git-symbolic-ref[1]
-	command.
+	Symbolic reference: instead of containing the <<def_SHA1,SHA-1>> id
+	itself, it is of the format 'ref: refs/some/thing' and when referenced,
+	it recursively <<def_dereference,dereferences>> to this reference.
+	'<<def_HEAD,HEAD>>' is a prime example of a symref. Symbolic references
+	are manipulated with the linkgit:git-symbolic-ref[1] command.
 
 [[def_tag]]tag::
 	A <<def_ref,ref>> under `refs/tags/` namespace that points to an
@@ -661,11 +683,11 @@ The most notable example is `HEAD`.
 	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
 
 [[def_tree-ish]]tree-ish (also treeish)::
-	A <<def_tree_object,tree object>> or an <<def_object,object>>
-	that can be recursively dereferenced to a tree object.
-	Dereferencing a <<def_commit_object,commit object>> yields the
-	tree object corresponding to the <<def_revision,revision>>'s
-	top <<def_directory,directory>>.
+	A <<def_tree_object,tree object>> or an <<def_object,object>> that can
+	be recursively <<def_dereference,dereferenced>> to a tree object.
+	Dereferencing a <<def_commit_object,commit object>> yields the tree
+	object corresponding to the <<def_revision,revision>>'s top
+	<<def_directory,directory>>.
 	The following are all tree-ishes:
 	a <<def_commit-ish,commit-ish>>,
 	a tree object,

base-commit: dadef801b365989099a9929e995589e455c51fed
-- 
gitgitgadget
