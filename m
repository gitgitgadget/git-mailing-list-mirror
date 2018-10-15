Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C2F51F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726576AbeJOR4h (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:37 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46635 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:37 -0400
Received: by mail-pf1-f196.google.com with SMTP id r64-v6so9423946pfb.13
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HYRUrkv2eVVl+KJvYm7lRGxV6IZq3rh3x1uBk2xE/NA=;
        b=GaqVkKj2VwZ7GvrNobSdix5e+Goao8SOkJpmsOPG+2LKqUJy6orneGRquKovq4xA8T
         NkofzKp6c/W3e4DCAGG7IrUZgTs4n/gPnKP2fxZV+xETfil3+Zvnf5OcwjqzHlwy/UR6
         83uZMNn3kd+QkU9f0gTucDlx1ghRvMAX8pfVPugkNcrNTfgscuQVF3nLwrwbWFk8yRUz
         fo1ndqnL513EVKS/Y74LZKEqsiHHXfz09TFVpTdXJhlECe3O+H1Firz5VWdd50d4WtXi
         E1pkjqgaQ7DNP5kSquo8brN7axdzULMOSOrKibQTn/8G3SQyvqsWmZfG9oQVMTe2w5um
         nv4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HYRUrkv2eVVl+KJvYm7lRGxV6IZq3rh3x1uBk2xE/NA=;
        b=o+Q2C96Ua0B5S6LcuAINLGL9QNSlYSgW8puDm0oIxtVwKwqProBdNFPK4BUD7ZFcYT
         E+0dFmgIfu63R4eYgjYPsP+PphqGH05GYKxegn8+WrkM9/g7eojif+B17H0/qAMC12M+
         TwhOWSl+PohSTIKsQG+OoyZmHVqZml4aJejyVYM9B9jk1RLf7GqNFBD42JfV19ZyVioo
         8J+ov3dxHirqFtUJnNjukMx+69kJmcnEQmNyCjzsnFw7y4baE/67RC4jwozrLdS+vjQY
         8jOmlf46f2zZvnmUrDtpn+u6YRLhXOE4gg0BUElCm6Q/F1BrlJqZ64HDTkGFVeNyQ+BX
         omDA==
X-Gm-Message-State: ABuFfojCnGQJwHnIO7OXnFaBFndi4d6r7kLDPD6nHEhSynWqTML8P9MO
        0g97tPBD1i+sUZmCiY6fLDlWq3ta
X-Google-Smtp-Source: ACcGV62kvCc7Jz5GJsvfaWVBmVA42Ae0vumWtkTx830x18x+Bin4RJNxq4Y7bBL/iY0buT3GRQChkw==
X-Received: by 2002:a62:b50a:: with SMTP id y10-v6mr16794619pfe.199.1539598321790;
        Mon, 15 Oct 2018 03:12:01 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v38-v6sm15859380pgn.57.2018.10.15.03.12.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:00 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:00 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:44 GMT
Message-Id: <815152e0f57d545ae2fae7429c16e5be497746be.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 02/13] ci/lib.sh: encapsulate Travis-specific things
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
 ci/lib.sh                  | 44 +++++++++++++++++++++++++++-----------
 ci/print-test-failures.sh  |  2 +-
 ci/test-documentation.sh   |  1 +
 4 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index 961064658e..63fa37f68f 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -28,7 +28,8 @@ osx-clang|osx-gcc)
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
index 06970f7213..8532555b4e 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -1,5 +1,26 @@
 # Library of functions shared by all CI scripts
 
+if test true = "$TRAVIS"
+then
+	# We are running within Travis CI
+	CI_BRANCH="$TRAVIS_BRANCH"
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
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
@@ -13,10 +34,10 @@ skip_branch_tip_with_tag () {
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
@@ -25,7 +46,7 @@ skip_branch_tip_with_tag () {
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
-	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
 	mv "$good_trees_file".tmp "$good_trees_file"
@@ -35,7 +56,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
+	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
 		# Continue the build job.
@@ -45,18 +66,18 @@ skip_good_tree () {
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
@@ -81,7 +102,6 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
-cache_dir="$HOME/travis-cache"
 good_trees_file="$cache_dir/good-trees"
 
 mkdir -p "$cache_dir"
@@ -91,13 +111,11 @@ skip_good_tree
 
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

