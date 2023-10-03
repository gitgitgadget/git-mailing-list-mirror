Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7961E75435
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:28:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239501AbjJCI2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239445AbjJCI2B (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:28:01 -0400
Received: from mail.smrk.net (mail.smrk.net [45.76.87.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CDDDAC
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:27:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smrk.net; s=20221002;
        t=1696321268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=VFYWe73yPEYfaKBIbuy3JAR7/6HOGfG/bfr21FUNXbc=;
        b=fvbr+B503S6AcZ4S+UjKFd4a+Uxy/VDDyxT5ZaeBLd/YaQs2RkkAttnJstFdLcfvh7gV6S
        JEgUOsIRpDovysMdbQfx9xKX+ldliW+zBZA60Fi7h5lZJYqiLRFhGEARjui0Z5BkRKDut/
        iil5YPa876AD07xnZ+fY1A4GBbc+dwStijpEbd/8ozFLtEnyu7aA7+7Bi8mjrpGA1NWFYv
        v+97ZnEnXUUu6t7/6mZtDurJxXHRDv6ANpMbQFbaBrhlwU36opVQlfx7ffkzaRls0WpLtW
        t5TDXfUnT+gunkzI6ZreH8T5x2bJt0+BpmhxJBwXQY2yZX2uwsfEOLJsE93Y1w==
Received: from localhost (<unknown> [192.168.5.2])
        by smrk (OpenSMTPD) with ESMTPSA id 5c630ee9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 3 Oct 2023 10:21:08 +0200 (CEST)
From:   =?UTF-8?q?=C5=A0t=C4=9Bp=C3=A1n=20N=C4=9Bmec?= <stepnem@smrk.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/5] Fix some typos, grammar or wording issues in the documentation
Date:   Tue,  3 Oct 2023 10:21:03 +0200
Message-ID: <20231003082107.3002173-1-stepnem@smrk.net>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Štěpán Němec <stepnem@smrk.net>
---
 Documentation/SubmittingPatches  | 10 +++++-----
 Documentation/diff-options.txt   |  2 +-
 Documentation/git-branch.txt     |  2 +-
 Documentation/git-range-diff.txt |  2 +-
 Documentation/git.txt            |  2 +-
 Documentation/gitattributes.txt  |  2 +-
 Documentation/giteveryday.txt    |  2 +-
 contrib/README                   |  4 ++--
 strbuf.h                         |  8 ++++----
 t/README                         | 30 ++++++++++++++----------------
 10 files changed, 31 insertions(+), 33 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 973d7a81d449..1259549cd488 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -393,8 +393,8 @@ mailing list{security-ml}, instead of the public mailing list.
 
 Learn to use format-patch and send-email if possible.  These commands
 are optimized for the workflow of sending patches, avoiding many ways
-your existing e-mail client that is optimized for "multipart/*" mime
-type e-mails to corrupt and render your patches unusable.
+your existing e-mail client (often optimized for "multipart/*" MIME
+type e-mails) might render your patches unusable.
 
 People on the Git mailing list need to be able to read and
 comment on the changes you are submitting.  It is important for
@@ -515,8 +515,8 @@ repositories.
 
 	git://git.ozlabs.org/~paulus/gitk
 
-   Those who are interested in improve gitk can volunteer to help Paul
-   in maintaining it cf. <YntxL/fTplFm8lr6@cleo>.
+   Those who are interested in improving gitk can volunteer to help Paul
+   maintain it, cf. <YntxL/fTplFm8lr6@cleo>.
 
 - `po/` comes from the localization coordinator, Jiang Xin:
 
@@ -556,7 +556,7 @@ help you find out who they are.
 
 In any time between the (2)-(3) cycle, the maintainer may pick it up
 from the list and queue it to `seen`, in order to make it easier for
-people play with it without having to pick up and apply the patch to
+people to play with it without having to pick up and apply the patch to
 their trees themselves.
 
 [[patch-status]]
diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 35fae7c87c8a..ee256ec077be 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -301,7 +301,7 @@ ifndef::git-format-patch[]
 
 -z::
 ifdef::git-log[]
-	Separate the commits with NULs instead of with new newlines.
+	Separate the commits with NULs instead of newlines.
 +
 Also, when `--raw` or `--numstat` has been given, do not munge
 pathnames and use NULs as output field terminators.
diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d207da9101a5..4395aa935438 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -324,7 +324,7 @@ superproject's "origin/main", but tracks the submodule's "origin/main".
 	multiple times, in which case the last key becomes the primary
 	key. The keys supported are the same as those in `git
 	for-each-ref`. Sort order defaults to the value configured for the
-	`branch.sort` variable if exists, or to sorting based on the
+	`branch.sort` variable if it exists, or to sorting based on the
 	full refname (including `refs/...` prefix). This lists
 	detached HEAD (if present) first, then local branches and
 	finally remote-tracking branches. See linkgit:git-config[1].
diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 0b393715d707..6c728dbe44b2 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -166,7 +166,7 @@ A typical output of `git range-diff` would look like this:
 
 In this example, there are 3 old and 3 new commits, where the developer
 removed the 3rd, added a new one before the first two, and modified the
-commit message of the 2nd commit as well its diff.
+commit message of the 2nd commit as well as its diff.
 
 When the output goes to a terminal, it is color-coded by default, just
 like regular `git diff`'s output. In addition, the first line (adding a
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 11228956cd5e..b246dc86c3f3 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -96,7 +96,7 @@ foo.bar= ...`) sets `foo.bar` to the empty string which `git config
 	to avoid ambiguity with `<name>` containing one.
 +
 This is useful for cases where you want to pass transitory
-configuration options to git, but are doing so on OS's where
+configuration options to git, but are doing so on OSes where
 other processes might be able to read your cmdline
 (e.g. `/proc/self/cmdline`), but not your environ
 (e.g. `/proc/self/environ`). That behavior is the default on
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 6deb89a29677..7cdc68f54a5c 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -1151,7 +1151,7 @@ will be stored via placeholder `%P`.
 ^^^^^^^^^^^^^^^^^^^^^^
 
 This attribute controls the length of conflict markers left in
-the work tree file during a conflicted merge.  Only setting to
+the work tree file during a conflicted merge.  Only setting
 the value to a positive integer has any meaningful effect.
 
 For example, this line in `.gitattributes` can be used to tell the merge
diff --git a/Documentation/giteveryday.txt b/Documentation/giteveryday.txt
index faba2ef0881c..f74a33fb35b9 100644
--- a/Documentation/giteveryday.txt
+++ b/Documentation/giteveryday.txt
@@ -229,7 +229,7 @@ without a formal "merging". Or longhand +
   git am -3 -k`
 
 An alternate participant submission mechanism is using the
-`git request-pull` or pull-request mechanisms (e.g as used on
+`git request-pull` or pull-request mechanisms (e.g. as used on
 GitHub (www.github.com) to notify your upstream of your
 contribution.
 
diff --git a/contrib/README b/contrib/README
index 05f291c1f1d3..d3a327d04074 100644
--- a/contrib/README
+++ b/contrib/README
@@ -24,14 +24,14 @@ lesser degree various foreign SCM interfaces, so you know the
 drill.
 
 I expect that things that start their life in the contrib/ area
-to graduate out of contrib/ once they mature, either by becoming
+graduate out of contrib/ once they mature, either by becoming
 projects on their own, or moving to the toplevel directory.  On
 the other hand, I expect I'll be proposing removal of disused
 and inactive ones from time to time.
 
 If you have new things to add to this area, please first propose
 it on the git mailing list, and after a list discussion proves
-there are some general interests (it does not have to be a
+there is general interest (it does not have to be a
 list-wide consensus for a tool targeted to a relatively narrow
 audience -- for example I do not work with projects whose
 upstream is svn, so I have no use for git-svn myself, but it is
diff --git a/strbuf.h b/strbuf.h
index fd43c46433a4..e959caca876a 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -12,9 +12,9 @@
 struct string_list;
 
 /**
- * strbuf's are meant to be used with all the usual C string and memory
+ * strbufs are meant to be used with all the usual C string and memory
  * APIs. Given that the length of the buffer is known, it's often better to
- * use the mem* functions than a str* one (memchr vs. strchr e.g.).
+ * use the mem* functions than a str* one (e.g., memchr vs. strchr).
  * Though, one has to be careful about the fact that str* functions often
  * stop on NULs and that strbufs may have embedded NULs.
  *
@@ -24,7 +24,7 @@ struct string_list;
  * strbufs have some invariants that are very important to keep in mind:
  *
  *  - The `buf` member is never NULL, so it can be used in any usual C
- *    string operations safely. strbuf's _have_ to be initialized either by
+ *    string operations safely. strbufs _have_ to be initialized either by
  *    `strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
  *
  *    Do *not* assume anything on what `buf` really is (e.g. if it is
@@ -37,7 +37,7 @@ struct string_list;
  *
  *  - The `buf` member is a byte array that has at least `len + 1` bytes
  *    allocated. The extra byte is used to store a `'\0'`, allowing the
- *    `buf` member to be a valid C-string. Every strbuf function ensure this
+ *    `buf` member to be a valid C-string. All strbuf functions ensure this
  *    invariant is preserved.
  *
  *    NOTE: It is OK to "play" with the buffer directly if you work it this
diff --git a/t/README b/t/README
index 61080859899b..a3e87385d065 100644
--- a/t/README
+++ b/t/README
@@ -262,8 +262,8 @@ The argument for --run, <test-selector>, is a list of description
 substrings or globs or individual test numbers or ranges with an
 optional negation prefix (of '!') that define what tests in a test
 suite to include (or exclude, if negated) in the run.  A range is two
-numbers separated with a dash and matches a range of tests with both
-ends been included.  You may omit the first or the second number to
+numbers separated with a dash and matches an inclusive range of tests
+to run.  You may omit the first or the second number to
 mean "from the first test" or "up to the very last test" respectively.
 
 The argument to --run is split on commas into separate strings,
@@ -274,10 +274,10 @@ text that you want to match includes a comma, use the glob character
 on all tests that match either the glob *rebase* or the glob
 *merge?cherry-pick*.
 
-If --run starts with an unprefixed number or range the initial
-set of tests to run is empty. If the first item starts with '!'
+If --run starts with an unprefixed number or range, the initial
+set of tests to run is empty.  If the first item starts with '!',
 all the tests are added to the initial set.  After initial set is
-determined every test number or range is added or excluded from
+determined, every test number or range is added or excluded from
 the set one by one, from left to right.
 
 For example, to run only tests up to a specific test (21), one
@@ -579,11 +579,10 @@ This test harness library does the following things:
 
 Recommended style
 -----------------
-Here are some recommented styles when writing test case.
 
- - Keep test title the same line with test helper function itself.
+ - Keep test titles and helper function invocations on the same line.
 
-   Take test_expect_success helper for example, write it like:
+   For example, with test_expect_success, write it like:
 
   test_expect_success 'test title' '
       ... test body ...
@@ -595,10 +594,9 @@ Here are some recommented styles when writing test case.
       'test title' \
       '... test body ...'
 
+ - End the line with an opening single quote.
 
- - End the line with a single quote.
-
- - Indent the body of here-document, and use "<<-" instead of "<<"
+ - Indent here-document bodies, and use "<<-" instead of "<<"
    to strip leading TABs used for indentation:
 
   test_expect_success 'test something' '
@@ -624,7 +622,7 @@ Here are some recommented styles when writing test case.
   '
 
  - Quote or escape the EOF delimiter that begins a here-document if
-   there is no parameter and other expansion in it, to signal readers
+   there is no parameter or other expansion in it, to signal readers
    that they can skim it more casually:
 
   cmd <<-\EOF
@@ -638,7 +636,7 @@ Do's & don'ts
 Here are a few examples of things you probably should and shouldn't do
 when writing tests.
 
-Here are the "do's:"
+The "do's:"
 
  - Put all code inside test_expect_success and other assertions.
 
@@ -1237,8 +1235,8 @@ and it knows that the object ID of an empty tree is a certain
 because the things the very basic core test tries to achieve is
 to serve as a basis for people who are changing the Git internals
 drastically.  For these people, after making certain changes,
-not seeing failures from the basic test _is_ a failure.  And
-such drastic changes to the core Git that even changes these
+not seeing failures from the basic test _is_ a failure.  Any
+Git core changes so drastic that they change even these
 otherwise supposedly stable object IDs should be accompanied by
 an update to t0000-basic.sh.
 
@@ -1248,7 +1246,7 @@ knowledge of the core Git internals.  If all the test scripts
 hardcoded the object IDs like t0000-basic.sh does, that defeats
 the purpose of t0000-basic.sh, which is to isolate that level of
 validation in one place.  Your test also ends up needing
-updating when such a change to the internal happens, so do _not_
+an update whenever the internals change, so do _not_
 do it and leave the low level of validation to t0000-basic.sh.
 
 Test coverage
-- 
2.42.0

