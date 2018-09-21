Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FD461F453
	for <e@80x24.org>; Fri, 21 Sep 2018 23:58:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391591AbeIVFuF (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Sep 2018 01:50:05 -0400
Received: from mail-io1-f73.google.com ([209.85.166.73]:52214 "EHLO
        mail-io1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725756AbeIVFuF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Sep 2018 01:50:05 -0400
Received: by mail-io1-f73.google.com with SMTP id w23-v6so25937714iob.18
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 16:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dp/gQb+cOETqqpUIphj8PxMrSxutV/Se0SEeg9C7ReU=;
        b=cGLSiX6dfoGyEITfHH2hGflTpsV54abZ3BwAUJk+SE8G40wua7noEG1dzk616DM85K
         iUZBrgvcfOpdiBxJ83ZoNdbqfuCQuIYT9QOLdtT33Nrex6kR+Ogyxh04o9D3K+PK8zSH
         MgmpV/iUi8fS6roMwIF37soUntog+Jf+zmJCMlkV44pS1o1rtqrqF8tSuJOrUcsv3l9t
         Djf1dkSNvYzE7/n3FqOwyAYO8+TrjV7V74HqLZqWa+6Ve+oyLor9o9j8+iajPihbvR4L
         4/xNFBR5YOpfeKp4DGGmYv1HXKO2toR8G+iD1DruLYKiBJHC11WJN5Zgjo2CKno+ErSE
         ISMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dp/gQb+cOETqqpUIphj8PxMrSxutV/Se0SEeg9C7ReU=;
        b=ftnZ63sl2wla3xgRIgN5YIe1WLEWmULAv9Q5C6Qt9vN+hYSIL4obMVOseNcPwwJJyF
         XfJwT0OvOe5HNhSOxKShVtQJhfJTUzK0/aIMTeJl92/NgdVfRcP7FsGGVlQWAkqqQm+1
         V1rzrvn6/8mriIfuS+2iLUQWhFdJHK4kZsIrEfin9KmXBeoR9AKxcNE6iB+HOLYcQ5dF
         5LeUvnfJm2E5UvdG3Ql+r99Z2K+43AlDr+865Ugu0v4NXGIImRDjPlkdLA1s9WVG3enO
         oBstDgN52Rppddnj8djgTGY2yyUIaGJ//nlezzIAj/9do9IVAsJmNlq2P/CB++bGgqMD
         OUEQ==
X-Gm-Message-State: APzg51BxNBCrGUXOrR5eo7e31yvlm5tnSO3K/W8SB1B19DzImDmGKiil
        1zPWyU8GpwKXVxq3h+7W23I0g++61DmSWaZLQ/IEw1fmqvO/OYmEguLZ5VMUGl4v8HsJaBIV3SZ
        X3G/sMQ7IGDOddr8dN4IqOd9qHvEDE59Fue41IzfoI8wS1J2wyjq3yysJcsCj
X-Google-Smtp-Source: ANB0VdYWC8NWt95IwUld9SkZ76G7r/+b4kRCcFvsSZr+3HvS9imD8dMYsx0zbotEzm/EG+AxOsLtyhuPonhU
X-Received: by 2002:a24:328e:: with SMTP id j136-v6mr8225ita.26.1537574332030;
 Fri, 21 Sep 2018 16:58:52 -0700 (PDT)
Date:   Fri, 21 Sep 2018 16:58:31 -0700
In-Reply-To: <20180921235833.99045-1-sbeller@google.com>
Message-Id: <20180921235833.99045-2-sbeller@google.com>
Mime-Version: 1.0
References: <20180921235833.99045-1-sbeller@google.com>
X-Mailer: git-send-email 2.19.0.444.g18242da7ef-goog
Subject: [PATCH 1/3] t7001: reformat to newer style
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The old formatting style is a real hindrance of getting people up to speed
contributing as they use existing code as an example and follow that style.
So let's get rid of the old style and reformat it in our current style.

Reported-by: Derrick Stolee <stolee@gmail.com>
Reported-by: Jeff Hostetler <git@jeffhostetler.com>
Signed-off-by: Stefan Beller <sbeller@google.com>
---
 t/t7001-mv.sh | 268 +++++++++++++++++++++++++-------------------------
 1 file changed, 134 insertions(+), 134 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 36b50d0b4c1..2251d24735c 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -3,74 +3,74 @@
 test_description='git mv in subdirs'
 . ./test-lib.sh
 
-test_expect_success \
-    'prepare reference tree' \
-    'mkdir path0 path1 &&
-     cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
-     git add path0/COPYING &&
-     git commit -m add -a'
+test_expect_success 'prepare reference tree' '
+	mkdir path0 path1 &&
+	cp "$TEST_DIRECTORY"/../COPYING path0/COPYING &&
+	git add path0/COPYING &&
+	git commit -m add -a
+'
 
-test_expect_success \
-    'moving the file out of subdirectory' \
-    'cd path0 && git mv COPYING ../path1/COPYING'
+test_expect_success 'moving the file out of subdirectory' '
+	cd path0 && git mv COPYING ../path1/COPYING
+'
 
 # in path0 currently
-test_expect_success \
-    'commiting the change' \
-    'cd .. && git commit -m move-out -a'
+test_expect_success 'commiting the change' '
+	cd .. && git commit -m move-out -a
+'
 
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-    grep "^R100..*path0/COPYING..*path1/COPYING" actual'
+test_expect_success 'checking the commit' '
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path0/COPYING..*path1/COPYING" actual
+'
 
-test_expect_success \
-    'moving the file back into subdirectory' \
-    'cd path0 && git mv ../path1/COPYING COPYING'
+test_expect_success 'moving the file back into subdirectory' '
+	cd path0 && git mv ../path1/COPYING COPYING
+'
 
 # in path0 currently
-test_expect_success \
-    'commiting the change' \
-    'cd .. && git commit -m move-in -a'
-
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-    grep "^R100..*path1/COPYING..*path0/COPYING" actual'
-
-test_expect_success \
-    'mv --dry-run does not move file' \
-    'git mv -n path0/COPYING MOVED &&
-     test -f path0/COPYING &&
-     test ! -f MOVED'
-
-test_expect_success \
-    'checking -k on non-existing file' \
-    'git mv -k idontexist path0'
-
-test_expect_success \
-    'checking -k on untracked file' \
-    'touch untracked1 &&
-     git mv -k untracked1 path0 &&
-     test -f untracked1 &&
-     test ! -f path0/untracked1'
-
-test_expect_success \
-    'checking -k on multiple untracked files' \
-    'touch untracked2 &&
-     git mv -k untracked1 untracked2 path0 &&
-     test -f untracked1 &&
-     test -f untracked2 &&
-     test ! -f path0/untracked1 &&
-     test ! -f path0/untracked2'
-
-test_expect_success \
-    'checking -f on untracked file with existing target' \
-    'touch path0/untracked1 &&
-     test_must_fail git mv -f untracked1 path0 &&
-     test ! -f .git/index.lock &&
-     test -f untracked1 &&
-     test -f path0/untracked1'
+test_expect_success 'commiting the change' '
+	cd .. && git commit -m move-in -a
+'
+
+test_expect_success 'checking the commit' '
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path1/COPYING..*path0/COPYING" actual
+'
+
+test_expect_success 'mv --dry-run does not move file' '
+	git mv -n path0/COPYING MOVED &&
+	test -f path0/COPYING &&
+	test ! -f MOVED
+'
+
+test_expect_success 'checking -k on non-existing file' '
+	git mv -k idontexist path0
+'
+
+test_expect_success 'checking -k on untracked file' '
+	touch untracked1 &&
+	git mv -k untracked1 path0 &&
+	test -f untracked1 &&
+	test ! -f path0/untracked1
+'
+
+test_expect_success 'checking -k on multiple untracked files' '
+	touch untracked2 &&
+	git mv -k untracked1 untracked2 path0 &&
+	test -f untracked1 &&
+	test -f untracked2 &&
+	test ! -f path0/untracked1 &&
+	test ! -f path0/untracked2
+'
+
+test_expect_success 'checking -f on untracked file with existing target' '
+	touch path0/untracked1 &&
+	test_must_fail git mv -f untracked1 path0 &&
+	test ! -f .git/index.lock &&
+	test -f untracked1 &&
+	test -f path0/untracked1
+'
 
 # clean up the mess in case bad things happen
 rm -f idontexist untracked1 untracked2 \
@@ -78,79 +78,79 @@ rm -f idontexist untracked1 untracked2 \
      .git/index.lock
 rmdir path1
 
-test_expect_success \
-    'moving to absent target with trailing slash' \
-    'test_must_fail git mv path0/COPYING no-such-dir/ &&
-     test_must_fail git mv path0/COPYING no-such-dir// &&
-     git mv path0/ no-such-dir/ &&
-     test_path_is_dir no-such-dir'
-
-test_expect_success \
-    'clean up' \
-    'git reset --hard'
-
-test_expect_success \
-    'moving to existing untracked target with trailing slash' \
-    'mkdir path1 &&
-     git mv path0/ path1/ &&
-     test_path_is_dir path1/path0/'
-
-test_expect_success \
-    'moving to existing tracked target with trailing slash' \
-    'mkdir path2 &&
-     >path2/file && git add path2/file &&
-     git mv path1/path0/ path2/ &&
-     test_path_is_dir path2/path0/'
-
-test_expect_success \
-    'clean up' \
-    'git reset --hard'
-
-test_expect_success \
-    'adding another file' \
-    'cp "$TEST_DIRECTORY"/../README.md path0/README &&
-     git add path0/README &&
-     git commit -m add2 -a'
-
-test_expect_success \
-    'moving whole subdirectory' \
-    'git mv path0 path2'
-
-test_expect_success \
-    'commiting the change' \
-    'git commit -m dir-move -a'
-
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
-     grep "^R100..*path0/README..*path2/README" actual'
-
-test_expect_success \
-    'succeed when source is a prefix of destination' \
-    'git mv path2/COPYING path2/COPYING-renamed'
-
-test_expect_success \
-    'moving whole subdirectory into subdirectory' \
-    'git mv path2 path1'
-
-test_expect_success \
-    'commiting the change' \
-    'git commit -m dir-move -a'
-
-test_expect_success \
-    'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
-     grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
-     grep "^R100..*path2/README..*path1/path2/README" actual'
-
-test_expect_success \
-    'do not move directory over existing directory' \
-    'mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0'
-
-test_expect_success \
-    'move into "."' \
-    'git mv path1/path2/ .'
+test_expect_success 'moving to absent target with trailing slash' '
+	test_must_fail git mv path0/COPYING no-such-dir/ &&
+	test_must_fail git mv path0/COPYING no-such-dir// &&
+	git mv path0/ no-such-dir/ &&
+	test_path_is_dir no-such-dir
+'
+
+test_expect_success 'clean up' '
+	git reset --hard
+'
+
+test_expect_success 'moving to existing untracked target with trailing slash' '
+	mkdir path1 &&
+	git mv path0/ path1/ &&
+	test_path_is_dir path1/path0/
+'
+
+test_expect_success 'moving to existing tracked target with trailing slash' '
+	mkdir path2 &&
+	>path2/file && git add path2/file &&
+	git mv path1/path0/ path2/ &&
+	test_path_is_dir path2/path0/
+'
+
+test_expect_success 'clean up' '
+	git reset --hard
+'
+
+test_expect_success 'adding another file' '
+	cp "$TEST_DIRECTORY"/../README.md path0/README &&
+	git add path0/README &&
+	git commit -m add2 -a
+'
+
+test_expect_success 'moving whole subdirectory' '
+	git mv path0 path2
+'
+
+test_expect_success 'commiting the change' '
+	git commit -m dir-move -a
+'
+
+test_expect_success 'checking the commit' '
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
+	grep "^R100..*path0/README..*path2/README" actual
+'
+
+test_expect_success 'succeed when source is a prefix of destination' '
+	git mv path2/COPYING path2/COPYING-renamed
+'
+
+test_expect_success 'moving whole subdirectory into subdirectory' '
+	git mv path2 path1
+'
+
+test_expect_success 'commiting the change' '
+	git commit -m dir-move -a
+'
+
+test_expect_success 'checking the commit' '
+	git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+	grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
+	grep "^R100..*path2/README..*path1/path2/README" actual
+'
+
+test_expect_success 'do not move directory over existing directory' '
+	mkdir path0 && mkdir path0/path2 && test_must_fail git mv path2 path0
+'
+
+test_expect_success 'move into "."' '
+	git mv path1/path2/ .
+'
 
 test_expect_success "Michael Cassar's test case" '
 	rm -fr .git papers partA &&
-- 
2.19.0.444.g18242da7ef-goog

