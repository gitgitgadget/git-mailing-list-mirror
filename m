Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81ACF1F62E
	for <e@80x24.org>; Wed, 16 Jan 2019 13:36:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393209AbfAPNgS (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Jan 2019 08:36:18 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:34910 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390475AbfAPNgQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Jan 2019 08:36:16 -0500
Received: by mail-ed1-f65.google.com with SMTP id x30so5448242edx.2
        for <git@vger.kernel.org>; Wed, 16 Jan 2019 05:36:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z0RGshkWSxccEvuS6Pf5xHIjQIPy7RZBuis9Ougj0l0=;
        b=GjD0Gnl3yprnoFdd0kHNE8I6FTWgho7dv0eI7fcVgT/g8vEIa7aBlE3JyC8RCp+GAZ
         FnToYsM2bwT/PkuOj4+9IK4VT34s6FUIsIFhGcVqWlgxnV3PCGM8IrZJ3+D+tFEE2U5q
         csBmsisp3qiC2D0UJ10wTcvLeUIS0yMF7paO+yLMMICiawXkENJ5MH6Ufqq44FiqR961
         /Y7OcH+uJ1tNWDm+YZ8YSRYIskfCNuAAnt3HfEFw/CR7hD0nT4jORHv84FsoiGIUAiQo
         a5yoZ12PJmiXHmVjOmWKV6K2E7YHcwO4ZJmefIJ4WwiqSME7qM6zY5cnacsVRD752FMp
         xDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z0RGshkWSxccEvuS6Pf5xHIjQIPy7RZBuis9Ougj0l0=;
        b=OLK4Dm+YxnNnQXaqLq+aLNvgI8g0ZvuvkoxCfE0lXOnWK5oMQ2WLexZ4iEcvFNKRzt
         9kOC0T0ggb6aHAQDuyzDraWBaPbvDdV29gDKxzpo2hEeSbmXUf5nLxdBSD76le5WHojb
         x4+rLBT6L+bBmmfzEsHShXRV32/hVv2NXs4hKf5EblH3NoPgQtf6wUXhPTaK40y4BExe
         hfa38+DkhjYBR/Mwh0A4xMZkJnSJXnyB2kU/5HTifO27sxyRPLguKCklkwui9Ilu+uQA
         BmAw9OfX+R+WTz1tMlaRZAKQFNMA6R+aYwpcjQijkyDqfez5VqKI03srOUYrqATNSd/R
         QX1Q==
X-Gm-Message-State: AJcUukdkxe51TQtH3hFe66M9DCbNeFueqaGN4v40pKeCcvej8HrbtUF2
        kH0XgM7phN8Db0a0jbFWTGBslRtG
X-Google-Smtp-Source: ALg8bN5q0KBg3QJ/w5YHHGT0HWy6q3UAW73QRDvHtjvOUR4Zu0iwUoRufyCzLkZhIYr4n6G+ue6rTw==
X-Received: by 2002:a50:b0a4:: with SMTP id j33mr7091915edd.267.1547645774242;
        Wed, 16 Jan 2019 05:36:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v12-v6sm3028009ejk.58.2019.01.16.05.36.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 16 Jan 2019 05:36:13 -0800 (PST)
Date:   Wed, 16 Jan 2019 05:36:13 -0800 (PST)
X-Google-Original-Date: Wed, 16 Jan 2019 13:35:51 GMT
Message-Id: <06fa564386307146762d4b30259d8636fc0ac268.1547645770.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v3.git.gitgitgadget@gmail.com>
References: <pull.31.v2.git.gitgitgadget@gmail.com>
        <pull.31.v3.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v3 03/21] ci/lib.sh: encapsulate Travis-specific things
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

The upcoming patches will allow building git.git via Azure Pipelines
(i.e. Azure DevOps' Continuous Integration), where variable names and
URLs look a bit different than in Travis CI.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh |  3 ++-
 ci/lib.sh                  | 47 +++++++++++++++++++++++++-------------
 ci/print-test-failures.sh  |  2 +-
 ci/test-documentation.sh   |  1 +
 4 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index fe65144152..bcdcc71592 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -37,7 +37,8 @@ osx-clang|osx-gcc)
 	brew update --quiet
 	# Uncomment this if you want to run perf tests:
 	# brew install gnu-time
-	brew install git-lfs gettext
+	test -z "$BREW_INSTALL_PACKAGES" ||
+	brew install $BREW_INSTALL_PACKAGES
 	brew link --force gettext
 	brew install caskroom/cask/perforce
 	;;
diff --git a/ci/lib.sh b/ci/lib.sh
index d9d4f1a9d7..bfc406a63b 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,8 +1,26 @@
 # Library of functions shared by all CI scripts
 
-# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
-# want here. We want the source branch instead.
-TRAVIS_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+if test true = "$TRAVIS"
+then
+	# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not
+	# what we want here. We want the source branch instead.
+	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+	CI_COMMIT="$TRAVIS_COMMIT"
+	CI_JOB_ID="$TRAVIS_JOB_ID"
+	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
+	CI_OS_NAME="$TRAVIS_OS_NAME"
+	CI_REPO_SLUG="$TRAVIS_REPO_SLUG"
+
+	cache_dir="$HOME/travis-cache"
+
+	url_for_job_id () {
+		echo "https://travis-ci.org/$CI_REPO_SLUG/jobs/$1"
+	}
+
+	BREW_INSTALL_PACKAGES="git-lfs gettext"
+	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
+	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+fi
 
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
@@ -17,10 +35,10 @@ skip_branch_tip_with_tag () {
 	# we can skip the build because we won't be skipping a build
 	# of a tag.
 
-	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
-		test "$TAG" != "$TRAVIS_BRANCH"
+	if TAG=$(git describe --exact-match "$CI_BRANCH" 2>/dev/null) &&
+		test "$TAG" != "$CI_BRANCH"
 	then
-		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
+		echo "$(tput setaf 2)Tip of $CI_BRANCH is exactly at $TAG$(tput sgr0)"
 		exit 0
 	fi
 }
@@ -29,7 +47,7 @@ skip_branch_tip_with_tag () {
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
-	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
 	mv "$good_trees_file".tmp "$good_trees_file"
@@ -39,7 +57,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
+	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
 		# Continue the build job.
@@ -49,18 +67,18 @@ skip_good_tree () {
 	echo "$good_tree_info" | {
 		read tree prev_good_commit prev_good_job_number prev_good_job_id
 
-		if test "$TRAVIS_JOB_ID" = "$prev_good_job_id"
+		if test "$CI_JOB_ID" = "$prev_good_job_id"
 		then
 			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
+			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit has already been built and tested successfully by this build job.
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		else
 			cat <<-EOF
-			$(tput setaf 2)Skipping build job for commit $TRAVIS_COMMIT.$(tput sgr0)
+			$(tput setaf 2)Skipping build job for commit $CI_COMMIT.$(tput sgr0)
 			This commit's tree has already been built and tested successfully in build job $prev_good_job_number for commit $prev_good_commit.
-			The log of that build job is available at https://travis-ci.org/$TRAVIS_REPO_SLUG/jobs/$prev_good_job_id
+			The log of that build job is available at $(url_for_job_id $prev_good_job_id)
 			To force a re-build delete the branch's cache and then hit 'Restart job'.
 			EOF
 		fi
@@ -85,7 +103,6 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
-cache_dir="$HOME/travis-cache"
 good_trees_file="$cache_dir/good-trees"
 
 mkdir -p "$cache_dir"
@@ -95,13 +112,11 @@ skip_good_tree
 
 if test -z "$jobname"
 then
-	jobname="$TRAVIS_OS_NAME-$CC"
+	jobname="$CI_OS_NAME-$CC"
 fi
 
 export DEVELOPER=1
 export DEFAULT_TEST_TARGET=prove
-export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
-export GIT_TEST_OPTS="--verbose-log -x --immediate"
 export GIT_TEST_CLONE_2GB=YesPlease
 if [ "$jobname" = linux-gcc ]; then
 	export CC=gcc-8
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index 7aef39a2fd..d2045b63a6 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -69,7 +69,7 @@ do
 	fi
 done
 
-if [ $combined_trash_size -gt 0 ]
+if [ -n "$TRAVIS_JOB_ID" -a $combined_trash_size -gt 0 ]
 then
 	echo "------------------------------------------------------------------------"
 	echo "Trash directories embedded in this log can be extracted by running:"
diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index d3cdbac73f..7d0beb2832 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -5,6 +5,7 @@
 
 . ${0%/*}/lib.sh
 
+test -n "$ALREADY_HAVE_ASCIIDOCTOR" ||
 gem install asciidoctor
 
 make check-builtins
-- 
gitgitgadget

