Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F1751FADF
	for <e@80x24.org>; Sun, 14 Jan 2018 17:38:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751846AbeANRiN (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jan 2018 12:38:13 -0500
Received: from mail-pl0-f66.google.com ([209.85.160.66]:37583 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751766AbeANRiM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jan 2018 12:38:12 -0500
Received: by mail-pl0-f66.google.com with SMTP id s3so2105583plp.4
        for <git@vger.kernel.org>; Sun, 14 Jan 2018 09:38:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mevuGS1YS0JmsCWs5NoWAA5bL8hgFPSH2ClMokPmGik=;
        b=jKQhr5hxufPRAiDNllXhKuk5KeIlmI0QIA36tAi2q6A+Sviw/cWFJ1Bh26f1KolGuh
         Mw2NowePRqpV77jUsjMgVoQ78wLhxy9lJEclVwfM4KCuyzGj9t+TqdvxC4OkrLHFAG1m
         OEoWBxPB/Ultz42rNzlRCRkOivl6H+Qt0Nty7PmIlU6Ds5FR/1sPtE/+ZVEdKmd9JQh0
         q8mjyhE19LjhfzkEskEcrgtU/qfb9exEXvmQMleGWx0DY5xDdntImvrS44FMpQ0sxreX
         bB3aBnoZ36+RS2GGrJSBjCrnXV3pn/VwqBQ8XLdzfBX6fN8nkhk3PxgUL4Ddo9CM33vK
         4THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mevuGS1YS0JmsCWs5NoWAA5bL8hgFPSH2ClMokPmGik=;
        b=KsF8XOKK+ZRDljWOXUQS2o8Xw+8fFuMTUngzoZSTeab8Zhq4xIFSdOYv7HTiIhy54W
         V7mrRT/76eY1FmJlslgiqqXW9sZ2PdHLPGqOVTFBf5piFIWOvMbX6d2JIZEyyk0h+eH/
         BzKeLcC7A7L2Q+C0oj1eQyFifA30sdX31uTfftVJ8Sz32772PC8Uio/gWxcPjGr8mxkG
         G0on85ks3hY9YB7jWwBBa1Ps0KV3j+yWm6M/ZqtbhuTS2mwtHJIS9F72UOFjz/swvyc6
         yqnCgBghZs+86DrCPHpuXtdXQtu6v0U23bLgM9PAplsig3NlrNTTB95c6a59cc+VR2Hk
         VsUA==
X-Gm-Message-State: AKGB3mJ+cXvEHM1JiRn/XMCYfXM0I/dk6kHYN1j5zu7BrEz7oSXniu+/
        c33Dsw9wFpVjBr+4JmkI/xJo6tmF
X-Google-Smtp-Source: ACJfBotAhQuE3DUJVzjCrBUdK+gkCpWWPu76fp0BwTf13F74A7YvkGX/VVg66yQQA9NWmwLDb+Yn5Q==
X-Received: by 10.124.22.131 with SMTP id v3mr27681473ply.52.1515951491394;
        Sun, 14 Jan 2018 09:38:11 -0800 (PST)
Received: from localhost.localdomain ([117.246.211.130])
        by smtp.gmail.com with ESMTPSA id k90sm20252054pfk.171.2018.01.14.09.38.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 14 Jan 2018 09:38:10 -0800 (PST)
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
To:     Git mailing list <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Jon Forrest <nobozo@gmail.com>
Subject: [PATCH v3 0/2]  Doc/submodules: a few updates
Date:   Sun, 14 Jan 2018 23:07:35 +0530
Message-Id: <20180114173737.13012-1-kaartic.sivaraam@gmail.com>
X-Mailer: git-send-email 2.16.0.rc1.281.g969645f98
In-Reply-To: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
References: <20180110064959.5491-1-kaartic.sivaraam@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Quoting from v1,

    These are just a few improvements that I thought would make the documentation
    related to submodules a little better in various way such as readability,
    consistency etc., These were things I noticed while reading thise documents.

Changes since v2:

   - Made some changes suggested by Stefan.
   - A few more that caught my eyes.

Inter diff between v2 and v3:

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index 801d291ca..71c5618e8 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -70,8 +70,8 @@ status [--cached] [--recursive] [--] [<path>...]::
 	Show the status of the submodules. This will print the SHA-1 of the
 	currently checked out commit for each submodule, along with the
 	submodule path and the output of 'git describe' for the
-	SHA-1. Each SHA-1 will be prefixed with `-` if the submodule is not
-	initialized, `+` if the currently checked out submodule commit
+	SHA-1. Each SHA-1 will possibly be prefixed with `-` if the submodule is
+	not initialized, `+` if the currently checked out submodule commit
 	does not match the SHA-1 found in the index of the containing
 	repository and `U` if the submodule has merge conflicts.
 +
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index ce2369c2d..47bbc62e8 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -101,7 +101,7 @@ remotes are configured in the submodule as usual in the `$GIT_DIR/config`
 file.
 
  * The configuration file `$GIT_DIR/config` in the superproject.
-   Git only recurses into active submodules (see 'ACTIVE SUBMODULES'
+   Git only recurses into active submodules (see "ACTIVE SUBMODULES"
    section below).
 +
 If the submodule is not yet initialized, then the configuration
@@ -164,52 +164,59 @@ from another repository.
 To completely remove a submodule, manually delete
 `$GIT_DIR/modules/<name>/`.
 
-Active submodules
+ACTIVE SUBMODULES
 -----------------
 
 A submodule is considered active,
 
-  (a) if `submodule.<name>.active` is set
+  (a) if `submodule.<name>.active` is set to `true`
      or
-  (b) if the submodules path matches the pathspec in `submodule.active`
+  (b) if the submodule's path matches the pathspec in `submodule.active`
      or
   (c) if `submodule.<name>.url` is set.
 
+and these are evaluated in this order.
+
 For example:
 
-    [submodule "foo"]
-        active = false
-        url = https://example.org/foo
-    [submodule "bar"]
-        active = true
-        url = https://example.org/bar
-    [submodule "baz"]
-        url = https://example.org/baz
+  [submodule "foo"]
+    active = false
+    url = https://example.org/foo
+  [submodule "bar"]
+    active = true
+    url = https://example.org/bar
+  [submodule "baz"]
+    url = https://example.org/baz
 
-In the above config only the submodule bar and baz are active,
-bar due to (a) and baz due to (c).
+In the above config only the submodule 'bar' and 'baz' are active,
+'bar' due to (a) and 'baz' due to (c). 'foo' is inactive because
+(a) takes precedence over (c).
 
-Note that '(c)' is a historical artefact and will be ignored if the
-pathspec set in (b) excludes the submodule. For example:
+Note that (c) is a historical artefact and will be ignored if the
+(a) and (b) specify that the submodule is not active. In other words,
+if we have an `submodule.<name>.active` set to `false` or if the
+submodule's path is excluded in the pathspec in `submodule.active`, the
+url doesn't matter whether it is present or not. This is illustrated in
+the example that follows.
 
-    [submodule "foo"]
-        active = true
-        url = https://example.org/foo
-    [submodule "bar"]
-        url = https://example.org/bar
-    [submodule "baz"]
-        url = https://example.org/baz
-    [submodule "bob"]
-        ignore = true
-    [submodule]
-        active = b*
-        active = (:exclude) baz
+  [submodule "foo"]
+    active = true
+    url = https://example.org/foo
+  [submodule "bar"]
+    url = https://example.org/bar
+  [submodule "baz"]
+    url = https://example.org/baz
+  [submodule "bob"]
+    ignore = true
+  [submodule]
+    active = b*
+    active = :(exclude) baz
 
-In here all submodules except baz (foo, bar, bob) are active.
+In here all submodules except 'baz' (foo, bar, bob) are active.
 'foo' due to its own active flag and all the others due to the
 submodule active pathspec, which specifies that any submodule
-starting with 'b' except 'baz' are also active, no matter if
-the .url field is present.
+starting with 'b' except 'baz' are also active, regardless of the
+presence of the .url field.
 
 Workflow for a third party library
 ----------------------------------



Kaartic Sivaraam (2):
  Doc/gitsubmodules: make some changes to improve readability and syntax
  Doc/git-submodule: improve readability and grammar of a sentence

 Documentation/git-submodule.txt |  16 +++----
 Documentation/gitsubmodules.txt | 100 +++++++++++++++++++++++++++++++---------
 2 files changed, 87 insertions(+), 29 deletions(-)

-- 
2.16.0.rc1.281.g969645f98

