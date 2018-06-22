Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E09471F516
	for <e@80x24.org>; Fri, 22 Jun 2018 06:50:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750987AbeFVGun (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Jun 2018 02:50:43 -0400
Received: from mail-lf0-f42.google.com ([209.85.215.42]:40877 "EHLO
        mail-lf0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750886AbeFVGum (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jun 2018 02:50:42 -0400
Received: by mail-lf0-f42.google.com with SMTP id q11-v6so7607770lfc.7
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 23:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VIzLuRBvp1hqx1PsehD6AUpATAQdL+oAQyq9ITV0sQ4=;
        b=Vw5z1W/G31vzh18+3zFnQAW2hJfp5J9EiKZ0F7+EPLBoAAJtDLkGPjwdKQHpUb2L8o
         4zIlHrDeIpcBDntVFLr+rTlWjpVAxG+weFjhjvyCSBQ6YyCLMgCqn8AispXbM+5XqTBa
         rWfcVWPPFS/k5nxUxqEfyKe4tCpF4ELnlFl2+PIoEzg5/Mt2c58Ivx2D2wnPV1fnY/0H
         aZ7dEvhObaYQogfsQGXGrkjgm+xnakr9DKt6HWxeZ8JzLwghanXslyrSRu8WB+lqjoiC
         od4jdU9iA9dLy6iiZswCiSpw/MPeISa5nwfSGfEVQow04+gIIRGAQP/UKwE9Auu6wuFW
         ygHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=VIzLuRBvp1hqx1PsehD6AUpATAQdL+oAQyq9ITV0sQ4=;
        b=elBpg+N39/fXIM2tSafruF1EpsXE834jZurqLECLH8akjw5QiMM5eFWtLk1/LjXHYW
         XlPAbVqrwjBTo4cXDCHBTMCqNUBbbV8tuanVHApgaJ0NuFWjbzpTKsXO7ucv90+cJQrv
         3wrIOYu4z3s7NHrWMUNHecyn9CuqSrcnIf3INssXy5yzgu00rlJQQQ71x0rOu2XsStc/
         EfVsA7tHWeRyfCYXnvSMx4aJr4bkvhBkTPKF0Yf5G2uYb0Z7tdgnEVMEdV6ZJiD+m+xV
         I4paubUAZhfk6d1ka4Kh9GSb4FSSFKOmDyAaOe8034Nx3a8q5YRn7PZzP9cLA99MIT8o
         vSWQ==
X-Gm-Message-State: APt69E335P+samzl4m2iRqbZ3BurY780g4yWBqSPMFHxQ/QdVFJ4YXeL
        uubTM9ty/iLq6GFpEzJaPN5SkASU
X-Google-Smtp-Source: ADUXVKKLy32lgAjjRuYi1ckPVqOLe1QIIwYXzJQATvAIM+YcH77ysP8BB5CnqzBP+suCALQTsRCr/w==
X-Received: by 2002:a19:d744:: with SMTP id o65-v6mr252486lfg.124.1529650239903;
        Thu, 21 Jun 2018 23:50:39 -0700 (PDT)
Received: from uncleman.localhost.localhost (dyt4cht5bhf30mvk75vpt-4.rev.dnainternet.fi. [2001:14bb:430:2343:2131:2fe5:451b:cc59])
        by smtp.gmail.com with ESMTPSA id n6-v6sm1184975ljh.77.2018.06.21.23.50.38
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jun 2018 23:50:39 -0700 (PDT)
From:   =?UTF-8?q?Ville=20Skytt=C3=A4?= <ville.skytta@iki.fi>
To:     git@vger.kernel.org
Subject: [PATCH] Documentation: Spelling and grammar fixes
Date:   Fri, 22 Jun 2018 09:50:37 +0300
Message-Id: <20180622065037.27155-1-ville.skytta@iki.fi>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ville Skyttä <ville.skytta@iki.fi>
---
 Documentation/SubmittingPatches                   | 4 ++--
 Documentation/config.txt                          | 2 +-
 Documentation/git-bisect-lk2009.txt               | 2 +-
 Documentation/git-imap-send.txt                   | 4 ++--
 Documentation/git-notes.txt                       | 2 +-
 Documentation/git-status.txt                      | 2 +-
 Documentation/git-svn.txt                         | 2 +-
 Documentation/giteveryday.txt                     | 2 +-
 Documentation/gitsubmodules.txt                   | 2 +-
 Documentation/glossary-content.txt                | 2 +-
 Documentation/technical/api-directory-listing.txt | 2 +-
 Documentation/technical/api-gitattributes.txt     | 2 +-
 Documentation/technical/commit-graph-format.txt   | 2 +-
 13 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 248854440..b44fd51f2 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -298,7 +298,7 @@ smaller project it is a good discipline to follow it.
 
 The sign-off is a simple line at the end of the explanation for
 the patch, which certifies that you wrote it or otherwise have
-the right to pass it on as a open-source patch.  The rules are
+the right to pass it on as an open-source patch.  The rules are
 pretty simple: if you can certify the below D-C-O:
 
 [[dco]]
@@ -403,7 +403,7 @@ don't demand).  +git log -p {litdd} _$area_you_are_modifying_+ would
 help you find out who they are.
 
 . You get comments and suggestions for improvements.  You may
-  even get them in a "on top of your change" patch form.
+  even get them in an "on top of your change" patch form.
 
 . Polish, refine, and re-send to the list and the people who
   spend their time to improve your patch.  Go back to step (2).
diff --git a/Documentation/config.txt b/Documentation/config.txt
index ab641bf5a..98ffbd208 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -354,7 +354,7 @@ advice.*::
 		Advice on what to do when you've accidentally added one
 		git repo inside of another.
 	ignoredHook::
-		Advice shown if an hook is ignored because the hook is not
+		Advice shown if a hook is ignored because the hook is not
 		set as executable.
 	waitingForEditor::
 		Print a message to the terminal whenever Git is waiting for
diff --git a/Documentation/git-bisect-lk2009.txt b/Documentation/git-bisect-lk2009.txt
index 78479b003..0f9ef2f25 100644
--- a/Documentation/git-bisect-lk2009.txt
+++ b/Documentation/git-bisect-lk2009.txt
@@ -1103,7 +1103,7 @@ _____________
 Combining test suites, git bisect and other systems together
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
-We have seen that test suites an git bisect are very powerful when
+We have seen that test suites and git bisect are very powerful when
 used together. It can be even more powerful if you can combine them
 with other systems.
 
diff --git a/Documentation/git-imap-send.txt b/Documentation/git-imap-send.txt
index 032613c42..7b157441e 100644
--- a/Documentation/git-imap-send.txt
+++ b/Documentation/git-imap-send.txt
@@ -68,8 +68,8 @@ imap.tunnel::
 	to the server. Required when imap.host is not set.
 
 imap.host::
-	A URL identifying the server. Use a `imap://` prefix for non-secure
-	connections and a `imaps://` prefix for secure connections.
+	A URL identifying the server. Use an `imap://` prefix for non-secure
+	connections and an `imaps://` prefix for secure connections.
 	Ignored when imap.tunnel is set, but required otherwise.
 
 imap.user::
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index e8dec1b3c..df2b64dbb 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -199,7 +199,7 @@ OPTIONS
 	.git/NOTES_MERGE_REF symref is updated to the resulting commit.
 
 --abort::
-	Abort/reset a in-progress 'git notes merge', i.e. a notes merge
+	Abort/reset an in-progress 'git notes merge', i.e. a notes merge
 	with conflicts. This simply removes all files related to the
 	notes merge.
 
diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index c4467ffb9..d9f422d56 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -106,7 +106,7 @@ It is optional: it defaults to 'traditional'.
 The possible options are:
 +
 	- 'traditional' - Shows ignored files and directories, unless
-			  --untracked-files=all is specifed, in which case
+			  --untracked-files=all is specified, in which case
 			  individual files in ignored directories are
 			  displayed.
 	- 'no'	        - Show no ignored files.
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 7ea24fc94..b99029520 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -452,7 +452,7 @@ Any other arguments are passed directly to 'git log'
 
 'commit-diff'::
 	Commits the diff of two tree-ish arguments from the
-	command-line.  This command does not rely on being inside an `git svn
+	command-line.  This command does not rely on being inside a `git svn
 	init`-ed repository.  This command takes three arguments, (a) the
 	original tree to diff against, (b) the new tree result, (c) the
 	URL of the target Subversion repository.  The final argument
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index 10c8ff93c..9f2528fc8 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -244,7 +244,7 @@ commands in addition to the ones needed by participants.
 
 This section can also be used by those who respond to `git
 request-pull` or pull-request on GitHub (www.github.com) to
-integrate the work of others into their history. An sub-area
+integrate the work of others into their history. A sub-area
 lieutenant for a repository will act both as a participant and
 as an integrator.
 
diff --git a/Documentation/gitsubmodules.txt b/Documentation/gitsubmodules.txt
index 3b9faabdb..504c5f1a8 100644
--- a/Documentation/gitsubmodules.txt
+++ b/Documentation/gitsubmodules.txt
@@ -194,7 +194,7 @@ In the above config only the submodule 'bar' and 'baz' are active,
 
 Note that (c) is a historical artefact and will be ignored if the
 (a) and (b) specify that the submodule is not active. In other words,
-if we have an `submodule.<name>.active` set to `false` or if the
+if we have a `submodule.<name>.active` set to `false` or if the
 submodule's path is excluded in the pathspec in `submodule.active`, the
 url doesn't matter whether it is present or not. This is illustrated in
 the example that follows.
diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
index 6c2d23dc4..0d2aa48c6 100644
--- a/Documentation/glossary-content.txt
+++ b/Documentation/glossary-content.txt
@@ -334,7 +334,7 @@ The optional colon that terminates the "magic signature" can be
 omitted if the pattern begins with a character that does not belong to
 "magic signature" symbol set and is not a colon.
 +
-In the long form, the leading colon `:` is followed by a open
+In the long form, the leading colon `:` is followed by an open
 parenthesis `(`, a comma-separated list of zero or more "magic words",
 and a close parentheses `)`, and the remainder is the pattern to match
 against the path.
diff --git a/Documentation/technical/api-directory-listing.txt b/Documentation/technical/api-directory-listing.txt
index 4f44ca24f..5abb8e8b1 100644
--- a/Documentation/technical/api-directory-listing.txt
+++ b/Documentation/technical/api-directory-listing.txt
@@ -54,7 +54,7 @@ The notable options are:
 	this case, the contents are returned as individual entries.
 +
 If this is set, files and directories that explicitly match an ignore
-pattern are reported. Implicity ignored directories (directories that
+pattern are reported. Implicitly ignored directories (directories that
 do not match an ignore pattern, but whose contents are all ignored)
 are not reported, instead all of the contents are reported.
 
diff --git a/Documentation/technical/api-gitattributes.txt b/Documentation/technical/api-gitattributes.txt
index e7cbb7c13..45f0df600 100644
--- a/Documentation/technical/api-gitattributes.txt
+++ b/Documentation/technical/api-gitattributes.txt
@@ -146,7 +146,7 @@ To get the values of all attributes associated with a file:
 
 * Iterate over the `attr_check.items[]` array to examine
   the attribute names and values.  The name of the attribute
-  described by a  `attr_check.items[]` object can be retrieved via
+  described by an `attr_check.items[]` object can be retrieved via
   `git_attr_name(check->items[i].attr)`.  (Please note that no items
   will be returned for unset attributes, so `ATTR_UNSET()` will return
   false for all returned `attr_check.items[]` objects.)
diff --git a/Documentation/technical/commit-graph-format.txt b/Documentation/technical/commit-graph-format.txt
index ad6af8105..2c965d594 100644
--- a/Documentation/technical/commit-graph-format.txt
+++ b/Documentation/technical/commit-graph-format.txt
@@ -18,7 +18,7 @@ metadata, including:
   the graph file.
 
 These positional references are stored as unsigned 32-bit integers
-corresponding to the array position withing the list of commit OIDs. We
+corresponding to the array position within the list of commit OIDs. We
 use the most-significant bit for special purposes, so we can store at most
 (1 << 31) - 1 (around 2 billion) commits.
 
-- 
2.14.1

