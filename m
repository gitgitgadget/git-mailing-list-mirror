Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DA3C1FADF
	for <e@80x24.org>; Wed, 10 Jan 2018 06:50:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753520AbeAJGue (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Jan 2018 01:50:34 -0500
Received: from mail-pg0-f50.google.com ([74.125.83.50]:46745 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753299AbeAJGuc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Jan 2018 01:50:32 -0500
Received: by mail-pg0-f50.google.com with SMTP id r2so10118291pgq.13
        for <git@vger.kernel.org>; Tue, 09 Jan 2018 22:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uvhLsBy1PMDIly2JnzUY80WXFqudkHhrdHYGm1Ga7UI=;
        b=pnirZC5AVzvNk5RrpERzFTbSXNnUHqYIhg1xnbvIQycnV5uF7Pr+xKuFMHaK5EK+Tc
         1psR2JQ7BtYy+0PGU4DztblmvpGLTffr01dmfhM7rHACtBCSxGGf2Xo+w4NtYhc2Bx0L
         S3dPAyVLPLyCCe2/AGK0+D6XvuRJTc9SN1RUwxRfXx6tduEDC+/gnLJZ+trC9JgpqBT0
         ZXLsPA/lxtmuzjjjsNEDoixQOQyJrORkkqDjnqsduf7wy0qi0BXm41XGWayTChDpwf45
         23RpML/Yk2AqEIi1Eqzk4JmBrnVaa8V2IEDkWZQpV2xkcUFhP7iIHqvf+WmOVhiUl7oN
         d2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uvhLsBy1PMDIly2JnzUY80WXFqudkHhrdHYGm1Ga7UI=;
        b=IjRQa1ZxFr0JKh6k4r2ZUXe6cbhEdgotEve/YkuPrKOJpU0VCoUBLVdiTJeppxNX0S
         yft3NIjZxZgJPBMbPJSzkCXGl0Q8xVQlAgwSl600mUM2mnLDj6xE2K5/MRzVrEDGic11
         Vec8PV1oalLyKCJSFcubly42jkZ5V3EGM45RaULJitW7JhO7jGEpdN4IqRswKWX/bZWs
         MXlbBksLp3tr12zzNiUG4QbNHK/vJBQhnBF4SW44R9sl4rZbamF2g4kgsBKkXtnrm9Yi
         3kvUPH/lIhIPNQYYZ3pWfgkeC+bhhBRdkQSZBAB+/2Zz6x3vvmiVPHeJoKSM07Hddi06
         8Hmg==
X-Gm-Message-State: AKGB3mKf0KNeraUc8FyysUCcL+b3Rj5j6tPEootv9eQjjdUOK3F1oWRa
        sWhLXXTFwIP6jd8bCW6LJFnvkb49
X-Google-Smtp-Source: ACJfBotttm+ZWJufUwnv/KEDN+IwM2NMFJDx1U7/6NqiqCe7iDKtQsOt2R2YNBxL3kvhWo6SxwYO+Q==
X-Received: by 10.98.182.4 with SMTP id j4mr15977483pff.220.1515567031559;
        Tue, 09 Jan 2018 22:50:31 -0800 (PST)
Received: from unique-pc.sce.com ([117.209.247.76])
        by smtp.gmail.com with ESMTPSA id b69sm22407237pfk.128.2018.01.09.22.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Jan 2018 22:50:30 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Cc:     Jon Forrest <nobozo@gmail.com>
Subject: [PATCH v2 1/2] Doc/gitsubmodules: make some changes to improve readability and syntax
Date:   Wed, 10 Jan 2018 12:19:58 +0530
Message-Id: <20180110064959.5491-2-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc0.223.g4a4ac8367
In-Reply-To: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
References: <20180106184614.20115-1-kaartic.sivaraam@gmail.com>
 <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

* Only mention porcelain commands in examples

* Split a sentence for better readability

* Add missing apostrophes

* Clearly specify the advantages of using submodules

* Avoid abbreviations

* Use "Git" consistently

* Improve readability of certain lines

* Clarify when a submodule is considered active

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
---
 Documentation/gitsubmodules.txt | 93 +++++++++++++++++++++++++++++++----------
 1 file changed, 72 insertions(+), 21 deletions(-)

diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 46cf120f6..ce2369c2d 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -36,8 +36,8 @@ The `gitlink` entry contains the object name of the commit that the
 superproject expects the submodule’s working directory to be at.
 
 The section `submodule.foo.*` in the `.gitmodules` file gives additional
-hints to Gits porcelain layer such as where to obtain the submodule via
-the `submodule.foo.url` setting.
+hints to Git's porcelain layer. For example, the `submodule.foo.url`
+setting specifies where to obtain the submodule.
 
 Submodules can be used for at least two different use cases:
 
@@ -51,18 +51,21 @@ Submodules can be used for at least two different use cases:
 
 2. Splitting a (logically single) project into multiple
    repositories and tying them back together. This can be used to
-   overcome current limitations of Gits implementation to have
+   overcome current limitations of Git's implementation to have
    finer grained access:
 
-    * Size of the git repository:
+    * Size of the Git repository:
       In its current form Git scales up poorly for large repositories containing
       content that is not compressed by delta computation between trees.
-      However you can also use submodules to e.g. hold large binary assets
-      and these repositories are then shallowly cloned such that you do not
+      For example, you can use submodules to hold large binary assets
+      and these repositories can be shallowly cloned such that you do not
       have a large history locally.
     * Transfer size:
       In its current form Git requires the whole working tree present. It
       does not allow partial trees to be transferred in fetch or clone.
+      If the project you work on consists of multiple repositories tied
+      together as submodules in a superproject, you can avoid fetching the
+      working trees of the repositories you are not interested in.
     * Access control:
       By restricting user access to submodules, this can be used to implement
       read/write policies for different users.
@@ -73,9 +76,10 @@ The configuration of submodules
 Submodule operations can be configured using the following mechanisms
 (from highest to lowest precedence):
 
- * The command line for those commands that support taking submodule specs.
-   Most commands have a boolean flag '--recurse-submodules' whether to
-   recurse into submodules. Examples are `ls-files` or `checkout`.
+ * The command line for those commands that support taking submodules
+   as part of their pathspecs. Most commands have a boolean flag
+   `--recurse-submodules` which specify whether to recurse into submodules.
+   Examples are `grep` and `checkout`.
    Some commands take enums, such as `fetch` and `push`, where you can
    specify how submodules are affected.
 
@@ -87,8 +91,8 @@ Submodule operations can be configured using the following mechanisms
 For example an effect from the submodule's `.gitignore` file
 would be observed when you run `git status --ignore-submodules=none` in
 the superproject. This collects information from the submodule's working
-directory by running `status` in the submodule, which does pay attention
-to its `.gitignore` file.
+directory by running `status` in the submodule while paying attention
+to the `.gitignore` file of the submodule.
 +
 The submodule's `$GIT_DIR/config` file would come into play when running
 `git push --recurse-submodules=check` in the superproject, as this would
@@ -97,20 +101,20 @@ remotes are configured in the submodule as usual in the `$GIT_DIR/config`
 file.
 
  * The configuration file `$GIT_DIR/config` in the superproject.
-   Typical configuration at this place is controlling if a submodule
-   is recursed into at all via the `active` flag for example.
+   Git only recurses into active submodules (see 'ACTIVE SUBMODULES'
+   section below).
 +
 If the submodule is not yet initialized, then the configuration
-inside the submodule does not exist yet, so configuration where to
+inside the submodule does not exist yet, so where to
 obtain the submodule from is configured here for example.
 
- * the `.gitmodules` file inside the superproject. Additionally to the
-   required mapping between submodule's name and path, a project usually
+ * The `.gitmodules` file inside the superproject. A project usually
    uses this file to suggest defaults for the upstream collection
-   of repositories.
+   of repositories for the mapping that is required between a
+   submodule's name and its path.
 +
-This file mainly serves as the mapping between name and path in
-the superproject, such that the submodule's git directory can be
+This file mainly serves as the mapping between the name and path of submodules
+in the superproject, such that the submodule's Git directory can be
 located.
 +
 If the submodule has never been initialized, this is the only place
@@ -137,8 +141,8 @@ directory is automatically moved to `$GIT_DIR/modules/<name>/`
 of the superproject.
 
  * Deinitialized submodule: A `gitlink`, and a `.gitmodules` entry,
-but no submodule working directory. The submodule’s git directory
-may be there as after deinitializing the git directory is kept around.
+but no submodule working directory. The submodule’s Git directory
+may be there as after deinitializing the Git directory is kept around.
 The directory which is supposed to be the working directory is empty instead.
 +
 A submodule can be deinitialized by running `git submodule deinit`.
@@ -160,6 +164,53 @@ from another repository.
 To completely remove a submodule, manually delete
 `$GIT_DIR/modules/<name>/`.
 
+Active submodules
+-----------------
+
+A submodule is considered active,
+
+  (a) if `submodule.<name>.active` is set
+     or
+  (b) if the submodules path matches the pathspec in `submodule.active`
+     or
+  (c) if `submodule.<name>.url` is set.
+
+For example:
+
+    [submodule "foo"]
+        active = false
+        url = https://example.org/foo
+    [submodule "bar"]
+        active = true
+        url = https://example.org/bar
+    [submodule "baz"]
+        url = https://example.org/baz
+
+In the above config only the submodule bar and baz are active,
+bar due to (a) and baz due to (c).
+
+Note that '(c)' is a historical artefact and will be ignored if the
+pathspec set in (b) excludes the submodule. For example:
+
+    [submodule "foo"]
+        active = true
+        url = https://example.org/foo
+    [submodule "bar"]
+        url = https://example.org/bar
+    [submodule "baz"]
+        url = https://example.org/baz
+    [submodule "bob"]
+        ignore = true
+    [submodule]
+        active = b*
+        active = (:exclude) baz
+
+In here all submodules except baz (foo, bar, bob) are active.
+'foo' due to its own active flag and all the others due to the
+submodule active pathspec, which specifies that any submodule
+starting with 'b' except 'baz' are also active, no matter if
+the .url field is present.
+
 Workflow for a third party library
 ----------------------------------
 
-- 
2.16.0.rc0.223.g4a4ac8367

