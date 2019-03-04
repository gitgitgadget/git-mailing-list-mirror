Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53AEC20248
	for <e@80x24.org>; Mon,  4 Mar 2019 12:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726165AbfCDMIq (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Mar 2019 07:08:46 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:44454 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbfCDMIq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Mar 2019 07:08:46 -0500
Received: by mail-pg1-f196.google.com with SMTP id j3so2972408pgm.11
        for <git@vger.kernel.org>; Mon, 04 Mar 2019 04:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xXGbtLitvwidcCi1yUnM/5LXK96U1a8hTCVWITKW1cQ=;
        b=f659qT3KaRCNcEVRhYpw8Ud0V8I9UyHvgQHlHA7lZ7ks+bWwcKc259rKSlCAoYOzDs
         g7Jo8nKOwlL+0//U37Qt6YSwrqdOKOqO8sAn3iNuPtajuomYGTPU90COzKd+0f4MTg8m
         mgvFxVmfztqSMR32N03vSRuLiN48K1LCfVeIYxa0LVFLUI/8w6c4YrKfKsqIomqDTbJf
         0RSaIcWbN2YBRkf1VTC9mGVJkgFsl1N7h4cJv/m0ap6uibDAxYQ4M8VOgZWF+mLYQRjJ
         g8U1yiF7wjYBa8WdZotpFcHMW9vqSsaPzN0zWiz/C3RxJ/SKEkH4apQTKs5RPgVUFoti
         gO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xXGbtLitvwidcCi1yUnM/5LXK96U1a8hTCVWITKW1cQ=;
        b=GPK1X84nhIC5/Tbadnv9+aPLq7oPQmzXcrkTGS6cuESlJyciWtKoG3GeI3T9uxLpsW
         bKljXj27PlO+vFQ5QnCwu01mw6daOAOvLmy3bJIYVKKyeOzXQr3FH5y3GgeIVH3cWqR7
         5uKeuDz/UNfpyfguX40ygk+GY9hl+aAIf/3OyS1wSABFrPTt7j7UUOR1WCo/2l1tn0Ek
         lL+EuRL40WYe4bxNI2gY8NRjtfERsy7ooVCghXhAhk/I7IgHdZ+LdvOt9JCKl6U2ZohK
         B/PL3T4l86jH6vHAKAm2IitNc8LQPXB4zqUPhGVuZMjVA/LBY4qlaj69JaGhbz/xD2QD
         qDzA==
X-Gm-Message-State: APjAAAXAKrUDxWM4LlkBhoUZ8vCFeyD4HJamD6bpzaAQXzgPsf1lEv0f
        caNTbL8PL5EuFeljBeidpW0=
X-Google-Smtp-Source: APXvYqyMTxgxwzAfPjGezIOcVnMTSCeS+To3UXRdr+ALupSYProJO8DqPnCdvQIzA0UefdZjAV0l2Q==
X-Received: by 2002:a65:60d8:: with SMTP id r24mr18153916pgv.6.1551701324771;
        Mon, 04 Mar 2019 04:08:44 -0800 (PST)
Received: from ar135.iitr.ernet.in ([103.37.201.80])
        by smtp.gmail.com with ESMTPSA id b138sm18791686pfb.48.2019.03.04.04.08.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Mar 2019 04:08:43 -0800 (PST)
From:   Rohit Ashiwal <rohit.ashiwal265@gmail.com>
To:     rohit.ashiwal265@gmail.com
Cc:     Johannes.Schindelin@gmx.de, christian.couder@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, t.gummerer@gmail.com
Subject: [GSoC][PATCH v3 2/3] t3600: modernize style
Date:   Mon,  4 Mar 2019 17:38:00 +0530
Message-Id: <20190304120801.28763-3-rohit.ashiwal265@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
References: <20190303122842.30380-1-rohit.ashiwal265@gmail.com>
 <20190304120801.28763-1-rohit.ashiwal265@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The tests in `t3600-rm.sh` were written  long time ago, and has a lot of
style violations, including the mixed use of tabs and spaces, not having
the title  and the  opening quote of the body on  the first line of  the
tests, and other  shell script  style violations. Update it to match the
CodingGuidelines.

Signed-off-by: Rohit Ashiwal <rohit.ashiwal265@gmail.com>
---
 t/t3600-rm.sh | 207 ++++++++++++++++++++++++++------------------------
 1 file changed, 107 insertions(+), 100 deletions(-)

diff --git a/t/t3600-rm.sh b/t/t3600-rm.sh
index 04e5d42bd3..8b03897a65 100755
--- a/t/t3600-rm.sh
+++ b/t/t3600-rm.sh
@@ -8,91 +8,92 @@ test_description='Test of the various options to git rm.'
 . ./test-lib.sh
 
 # Setup some files to be removed, some with funny characters
-test_expect_success \
-    'Initialize test directory' \
-    "touch -- foo bar baz 'space embedded' -q &&
-     git add -- foo bar baz 'space embedded' -q &&
-     git commit -m 'add normal files'"
+test_expect_success 'Initialize test directory' '
+	touch -- foo bar baz "space embedded" -q &&
+	git add -- foo bar baz "space embedded" -q &&
+	git commit -m "add normal files"
+'
 
-if test_have_prereq !FUNNYNAMES; then
+if test_have_prereq !FUNNYNAMES
+then
 	say 'Your filesystem does not allow tabs in filenames.'
 fi
 
-test_expect_success FUNNYNAMES 'add files with funny names' "
-     touch -- 'tab	embedded' 'newline
-embedded' &&
-     git add -- 'tab	embedded' 'newline
-embedded' &&
-     git commit -m 'add files with tabs and newlines'
-"
-
-test_expect_success \
-    'Pre-check that foo exists and is in index before git rm foo' \
-    '[ -f foo ] && git ls-files --error-unmatch foo'
-
-test_expect_success \
-    'Test that git rm foo succeeds' \
-    'git rm --cached foo'
-
-test_expect_success \
-    'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content >foo &&
-     git add foo &&
-     git rm --cached foo'
-
-test_expect_success \
-    'Test that git rm --cached foo succeeds if the index matches the file' \
-    'echo content >foo &&
-     git add foo &&
-     git commit -m foo &&
-     echo "other content" >foo &&
-     git rm --cached foo'
-
-test_expect_success \
-    'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
-     echo content >foo &&
-     git add foo &&
-     git commit -m foo --allow-empty &&
-     echo "other content" >foo &&
-     git add foo &&
-     echo "yet another content" >foo &&
-     test_must_fail git rm --cached foo
-'
-
-test_expect_success \
-    'Test that git rm --cached -f foo works in case where --cached only did not' \
-    'echo content >foo &&
-     git add foo &&
-     git commit -m foo --allow-empty &&
-     echo "other content" >foo &&
-     git add foo &&
-     echo "yet another content" >foo &&
-     git rm --cached -f foo'
-
-test_expect_success \
-    'Post-check that foo exists but is not in index after git rm foo' \
-    '[ -f foo ] && test_must_fail git ls-files --error-unmatch foo'
-
-test_expect_success \
-    'Pre-check that bar exists and is in index before "git rm bar"' \
-    '[ -f bar ] && git ls-files --error-unmatch bar'
-
-test_expect_success \
-    'Test that "git rm bar" succeeds' \
-    'git rm bar'
-
-test_expect_success \
-    'Post-check that bar does not exist and is not in index after "git rm -f bar"' \
-    '! [ -f bar ] && test_must_fail git ls-files --error-unmatch bar'
-
-test_expect_success \
-    'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' \
-    'git rm -- -q'
-
-test_expect_success FUNNYNAMES \
-    "Test that \"git rm -f\" succeeds with embedded space, tab, or newline characters." \
-    "git rm -f 'space embedded' 'tab	embedded' 'newline
-embedded'"
+test_expect_success FUNNYNAMES 'add files with funny names' '
+	touch -- "tab	embedded" "newline${LF}embedded" &&
+	git add -- "tab	embedded" "newline${LF}embedded" &&
+	git commit -m "add files with tabs and newlines"
+'
+
+test_expect_success 'Pre-check that foo exists and is in index before git rm foo' '
+	test -f foo &&
+	git ls-files --error-unmatch foo
+'
+
+test_expect_success 'Test that git rm foo succeeds' '
+	git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached foo succeeds if the index matches the file' '
+	echo content >foo &&
+	git add foo &&
+	git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached foo succeeds if the index matches the file' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo &&
+	echo "other content" >foo &&
+	git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached foo fails if the index matches neither the file nor HEAD' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo --allow-empty &&
+	echo "other content" >foo &&
+	git add foo &&
+	echo "yet another content" >foo &&
+	test_must_fail git rm --cached foo
+'
+
+test_expect_success 'Test that git rm --cached -f foo works in case where --cached only did not' '
+	echo content >foo &&
+	git add foo &&
+	git commit -m foo --allow-empty &&
+	echo "other content" >foo &&
+	git add foo &&
+	echo "yet another content" >foo &&
+	git rm --cached -f foo
+'
+
+test_expect_success 'Post-check that foo exists but is not in index after git rm foo' '
+	test -f foo &&
+	test_must_fail git ls-files --error-unmatch foo
+'
+
+test_expect_success 'Pre-check that bar exists and is in index before "git rm bar"' '
+	test -f bar &&
+	git ls-files --error-unmatch bar
+'
+
+test_expect_success 'Test that "git rm bar" succeeds' '
+	git rm bar
+'
+
+test_expect_success 'Post-check that bar does not exist and is not in index after "git rm -f bar"' '
+	! test -f bar &&
+	test_must_fail git ls-files --error-unmatch bar
+'
+
+test_expect_success 'Test that "git rm -- -q" succeeds (remove a file that looks like an option)' '
+	git rm -- -q
+'
+
+test_expect_success FUNNYNAMES 'Test that "git rm -f" succeeds with embedded space, tab, or newline characters.' '
+	git rm -f "space embedded" "tab	embedded" "newline${LF}embedded"
+'
 
 test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 	test_when_finished "chmod 775 ." &&
@@ -100,9 +101,9 @@ test_expect_success SANITY 'Test that "git rm -f" fails if its rm fails' '
 	test_must_fail git rm -f baz
 '
 
-test_expect_success \
-    'When the rm in "git rm -f" fails, it should not remove the file from the index' \
-    'git ls-files --error-unmatch baz'
+test_expect_success 'When the rm in "git rm -f" fails, it should not remove the file from the index' '
+	git ls-files --error-unmatch baz
+'
 
 test_expect_success 'Remove nonexistent file with --ignore-unmatch' '
 	git rm --ignore-unmatch nonexistent
@@ -217,23 +218,25 @@ test_expect_success 'Remove nonexistent file returns nonzero exit status' '
 
 test_expect_success 'Call "rm" from outside the work tree' '
 	mkdir repo &&
-	(cd repo &&
-	 git init &&
-	 echo something >somefile &&
-	 git add somefile &&
-	 git commit -m "add a file" &&
-	 (cd .. &&
-	  git --git-dir=repo/.git --work-tree=repo rm somefile) &&
-	test_must_fail git ls-files --error-unmatch somefile)
+	(
+		cd repo &&
+		git init &&
+		echo something >somefile &&
+		git add somefile &&
+		git commit -m "add a file" &&
+		(
+			cd .. &&
+			git --git-dir=repo/.git --work-tree=repo rm somefile
+		) &&
+		test_must_fail git ls-files --error-unmatch somefile
+	)
 '
 
 test_expect_success 'refresh index before checking if it is up-to-date' '
-
 	git reset --hard &&
 	test-tool chmtime -86400 frotz/nitfol &&
 	git rm frotz/nitfol &&
 	test ! -f frotz/nitfol
-
 '
 
 test_expect_success 'choking "git rm" should not let it die with cruft' '
@@ -242,8 +245,8 @@ test_expect_success 'choking "git rm" should not let it die with cruft' '
 	i=0 &&
 	while test $i -lt 12000
 	do
-	    echo "100644 1234567890123456789012345678901234567890 0	some-file-$i"
-	    i=$(( $i + 1 ))
+		echo "100644 1234567890123456789012345678901234567890 0	some-file-$i"
+		i=$(( $i + 1 ))
 	done | git update-index --index-info &&
 	git rm -n "some-file-*" | : &&
 	test_path_is_missing .git/index.lock
@@ -545,7 +548,8 @@ test_expect_success 'rm of a conflicted populated submodule with a .git director
 	git checkout conflict1 &&
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
+	(
+		cd submod &&
 		rm .git &&
 		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
@@ -579,7 +583,8 @@ test_expect_success 'rm of a populated submodule with a .git directory migrates
 	git checkout -f master &&
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
+	(
+		cd submod &&
 		rm .git &&
 		cp -R ../.git/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree &&
@@ -600,7 +605,8 @@ EOF
 test_expect_success 'setup subsubmodule' '
 	git reset --hard &&
 	git submodule update &&
-	(cd submod &&
+	(
+		cd submod &&
 		git update-index --add --cacheinfo 160000 $(git rev-parse HEAD) subsubmod &&
 		git config -f .gitmodules submodule.sub.url ../. &&
 		git config -f .gitmodules submodule.sub.path subsubmod &&
@@ -667,7 +673,8 @@ test_expect_success 'rm of a populated nested submodule with nested untracked fi
 test_expect_success "rm absorbs submodule's nested .git directory" '
 	git reset --hard &&
 	git submodule update --recursive &&
-	(cd submod/subsubmod &&
+	(
+		cd submod/subsubmod &&
 		rm .git &&
 		mv ../../.git/modules/sub/modules/sub .git &&
 		GIT_WORK_TREE=. git config --unset core.worktree
-- 
Rohit
