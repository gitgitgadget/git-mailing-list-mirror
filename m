Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DCB3D3A0
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 23:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDZPgyCo"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6DBD71
	for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:17:55 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4083740f92dso40727385e9.3
        for <git@vger.kernel.org>; Mon, 13 Nov 2023 15:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699917473; x=1700522273; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uMPA565J2Qxa5GkeiAEsD00kNWRBtw+At5Azh2Ejmz4=;
        b=HDZPgyCopBXDj3+5JjIyiDjz9oOjKU7Luo/nE3EShg5FefwRXwdAv4yG7zdexwxWFf
         N7MHX2MZ9rZTcsX1Rd5UWO43/u3OhPF0lZEU1ntsTjReoD45JIAJ4xAwCWX8Q4GFoHlY
         Z05aPUR9YMn+ZzJtBegrO6hOUNmDFD/3YAPgZun2x5dEKXuCTu2PvcbTFp+iYnO9c4DZ
         nGNad/hEuaz+CBroOkIbRfwoVCobouK0CYV2063F/s8Lo22/+N9Cr+zZ87OUmbUiR1kA
         hvICUXIBD8FCBX/+sHBQVGav0o/vL97tWGINNkfNRkTyqPBywQTJ3wKe0gzIOztl+MOG
         iGGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699917473; x=1700522273;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uMPA565J2Qxa5GkeiAEsD00kNWRBtw+At5Azh2Ejmz4=;
        b=bsLJlAI2zDcjM1HZEjJKYKCRufYV1WZMErHK5VlEV72teE+4a8rrQVj7k4YS1jhHs4
         tSsRFk9ABlb5m1MbrMsHjqWdAt3SS4/JPiUzXMbaR31LYOcGE8YyfS1SBznYnbjrgVZr
         AiPBtWgusLxSZ6GZ45XaJzJUhRo3EypkGK8YAHMZKC5q0+2KmZS/V/Ew9ubr1v7piUTs
         fjQmEM3HbfQUlpJl04sLcnJnYC1Cz3tsp/lQCLdAPXIuitbW9xBb6YLPnfrvUWPSq+tW
         v1hMvdoarbHVIE+WdFtcE6OPBDi0nDp0PQXPr9ehNzNRS4nBY3V42rS12NtCRGxNiz3A
         8/4Q==
X-Gm-Message-State: AOJu0Yyz0+/o3HJlGsU7+3O0AZ3svRweQVLm94f3L+hn/TYf52Mxlw+0
	tT4wTLXp7XXwdF5rXsLjqnx/GDINUEw=
X-Google-Smtp-Source: AGHT+IEljgUit/t9aVzX0wDGkk83sK6UNRqwWM/g6R/gmAm/Lk0hqJEjg1luS4NfIl6ZufbeHtlYew==
X-Received: by 2002:a05:600c:4703:b0:408:febf:831f with SMTP id v3-20020a05600c470300b00408febf831fmr5648756wmo.28.1699917472964;
        Mon, 13 Nov 2023 15:17:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r21-20020a05600c35d500b00407efbc4361sm15243621wmq.9.2023.11.13.15.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 15:17:52 -0800 (PST)
Message-ID: <pull.1610.v2.git.1699917471769.gitgitgadget@gmail.com>
In-Reply-To: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
References: <pull.1610.git.1699574277143.gitgitgadget@gmail.com>
From: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 13 Nov 2023 23:17:51 +0000
Subject: [PATCH v2] glossary: add definitions for dereference & peel
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
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
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
    
    
    Changes since V1
    ================
    
     * Removed references to "peeling" a commit; the updated definition
       discusses "peeling" only in the context of tags.
     * Added a cross-link from "dereference" to "peel" (one already existed
       for "peel" to "dereference").

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1610%2Fvdye%2Fvdye%2Fglossary-peel-dereference-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1610/vdye/vdye/glossary-peel-dereference-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1610

Range-diff vs v1:

 1:  e40fc3e5e04 ! 1:  4d9e0d7fc81 glossary: add definitions for dereference & peel
     @@ Documentation/glossary-content.txt: to point at the new commit.
      +<<def_object,object>> a tag points at. Tags are recursively dereferenced by
      +repeating the operation on the result object until the result has either a
      +specified <<def_object_type,object type>> (where applicable) or any non-"tag"
     -+object type.
     ++object type. A synonym for "recursive dereference" in the context of tags is
     ++"<<def_peel,peel>>".
      ++
      +Referring to a <<def_commit_object,commit object>>: the action of accessing
      +the commit's tree object. Commits cannot be dereferenced recursively.
     @@ Documentation/glossary-content.txt: exclude;;
       	parents.
       
      +[[def_peel]]peel::
     -+	Synonym for object <<def_dereference,dereference>>. Most commonly used
     -+	in the context of tags, where it refers to the process of recursively
     -+	dereferencing a <<def_tag_object,tag object>> until the result object's
     -+	<<def_object_type,type>> is something other than "tag".
     ++	The action of recursively <<def_dereference,dereferencing>> a
     ++	<<def_tag_object,tag object>>.
      +
       [[def_pickaxe]]pickaxe::
       	The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore


 Documentation/glossary-content.txt | 49 +++++++++++++++++++++---------
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 65c89e7b3eb..59d8ab85721 100644
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
@@ -125,6 +124,25 @@ to point at the new commit.
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
+object type. A synonym for "recursive dereference" in the context of tags is
+"<<def_peel,peel>>".
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
@@ -444,6 +462,10 @@ exclude;;
 	of the logical predecessor(s) in the line of development, i.e. its
 	parents.
 
+[[def_peel]]peel::
+	The action of recursively <<def_dereference,dereferencing>> a
+	<<def_tag_object,tag object>>.
+
 [[def_pickaxe]]pickaxe::
 	The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore
 	routines that help select changes that add or delete a given text
@@ -620,12 +642,11 @@ The most notable example is `HEAD`.
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
@@ -661,11 +682,11 @@ The most notable example is `HEAD`.
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
