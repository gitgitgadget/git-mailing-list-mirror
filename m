Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8150D1F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbfA0X05 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:39138 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfA0X0y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:54 -0500
Received: by mail-ed1-f67.google.com with SMTP id b14so11593559edt.6
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RELDQxxtpPecLmfvF8MO2ybLT3oALQRfzq+V9+mgang=;
        b=HGvt2y2/fe7UZE/U2hABDe/wh4pPEOuDu74JbKiKOfIjP4VXRY0w2IjO7amA4ibyfg
         kJMHGPDkPHRSGYTwvCYKVGUg+BLnwrx2tuavgZ6FRfLPNmKC7qBCsWdWwkIQVlwHbBh/
         WLA50t7G+IbGz0El/EZMLALQu7boEXQDikX8J+oYnCU9x0s78LbbDU+P/0evXZKAYfpl
         jaxojEbcJOygrKD1goDz/2HcuntO1hICYYwrfktf/4jKKADlPHUBcx7/QJwIZ+ePpm9M
         ujQTHPMW08DB02LLCyRFMySRmiPzoHqTkStnp3qlyG9mQeloRPrYzhx46KT4vZUYL3I4
         99QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RELDQxxtpPecLmfvF8MO2ybLT3oALQRfzq+V9+mgang=;
        b=Uxtw+DlByawLxt7sFcDV4PFcvymgTTaFgBg9zY461VVT4sP1uerPKVFHNsqA3uHdEO
         eAgvEqH7Lc3nhwRObc3N/o7CGCjC9pX/H7ceaDN0IHAszwj9HRZa22zK1lG+nXMiB8h9
         ZoFj4CUa8ERxqGs+tM7mQx8sCoHUNqyD8sG0HsDyl1c8HDQ1nf4TIYjYxtLB3b0dUwhh
         8uMin+sajJjkUcacuzeIb3bO0esg2C0eadd73gBfGrqrUKITRsr8gKhpnGalF4trZKEn
         HzKWGVZzSnkmbaLoXVHhXxGcfQo9PxiLrofeTmHmGZ5xIQrgSW/3A01hdB+Hth03hhA9
         Vjfg==
X-Gm-Message-State: AJcUukd6vSk36chpQTFvpx929czjxGs+i4MM8PoDPEWRbRiI+k41okXS
        7ou8SPLXq4QPFhcvu/01xxUAtFxo
X-Google-Smtp-Source: ALg8bN7z6dZO/+3/baX9iBsQ3qhR9oTIxEgduKL3HA5iSw1+bLb5bQp9TS6apPtynxnsoDLqMP1hrA==
X-Received: by 2002:a50:875d:: with SMTP id 29mr19838798edv.100.1548631611844;
        Sun, 27 Jan 2019 15:26:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 97sm13503904edq.45.2019.01.27.15.26.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:51 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:51 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:29 GMT
Message-Id: <7c16d31b46258ad00768c6125d0c6ad64d341c15.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 03/21] ci/lib.sh: encapsulate Travis-specific things
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

Also, the configurations of the available agents are different. For
example, Travis' and Azure Pipelines' macOS agents are set up
differently, so that on Travis, we have to install the git-lfs and
gettext Homebrew packages, and on Azure Pipelines we do not need to.
Likewise, Azure Pipelines' Ubuntu agents already have asciidoctor
installed.

Finally, on Azure Pipelines the natural way is not to base64-encode tar
files of the trash directories of failed tests, but to publish build
artifacts instead. Therefore, that code to log those base64-encoded tar
files is guarded to be Travis-specific.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/install-dependencies.sh |  3 ++-
 ci/lib.sh                  | 45 +++++++++++++++++++++++++++-----------
 ci/print-test-failures.sh  |  8 +++++++
 ci/test-documentation.sh   |  1 +
 4 files changed, 43 insertions(+), 14 deletions(-)

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
index 9c6ddeb374..3f286d86a6 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -24,7 +24,7 @@ skip_branch_tip_with_tag () {
 # job if we encounter the same tree again and can provide a useful info
 # message.
 save_good_tree () {
-	echo "$(git rev-parse $TRAVIS_COMMIT^{tree}) $TRAVIS_COMMIT $TRAVIS_JOB_NUMBER $TRAVIS_JOB_ID" >>"$good_trees_file"
+	echo "$(git rev-parse $CI_COMMIT^{tree}) $CI_COMMIT $CI_JOB_NUMBER $CI_JOB_ID" >>"$good_trees_file"
 	# limit the file size
 	tail -1000 "$good_trees_file" >"$good_trees_file".tmp
 	mv "$good_trees_file".tmp "$good_trees_file"
@@ -34,7 +34,7 @@ save_good_tree () {
 # successfully before (e.g. because the branch got rebased, changing only
 # the commit messages).
 skip_good_tree () {
-	if ! good_tree_info="$(grep "^$(git rev-parse $TRAVIS_COMMIT^{tree}) " "$good_trees_file")"
+	if ! good_tree_info="$(grep "^$(git rev-parse $CI_COMMIT^{tree}) " "$good_trees_file")"
 	then
 		# Haven't seen this tree yet, or no cached good trees file yet.
 		# Continue the build job.
@@ -44,18 +44,18 @@ skip_good_tree () {
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
@@ -80,11 +80,32 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
-# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
-# want here. We want the source branch instead.
-CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+if test true = "$TRAVIS"
+then
+	CI_TYPE=travis
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
+else
+	echo "Could not identify CI type" >&2
+	exit 1
+fi
 
-cache_dir="$HOME/travis-cache"
 good_trees_file="$cache_dir/good-trees"
 
 mkdir -p "$cache_dir"
@@ -94,13 +115,11 @@ skip_good_tree
 
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
index 7aef39a2fd..cf321b474d 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -38,6 +38,14 @@ do
 		test_name="${TEST_EXIT%.exit}"
 		test_name="${test_name##*/}"
 		trash_dir="trash directory.$test_name"
+		case "$CI_TYPE" in
+		travis)
+			;;
+		*)
+			echo "Unhandled CI type: $CI_TYPE" >&2
+			exit 1
+			;;
+		esac
 		trash_tgz_b64="trash.$test_name.base64"
 		if [ -d "$trash_dir" ]
 		then
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

