Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 93A001F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfA2OTd (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:33 -0500
Received: from mail-ed1-f48.google.com ([209.85.208.48]:33088 "EHLO
        mail-ed1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728041AbfA2OTb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:31 -0500
Received: by mail-ed1-f48.google.com with SMTP id p6so16156877eds.0
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RJiBb8F0ZIhkEzjeNE5PJ80Os/lj+Z9pFBzCKAm8HF8=;
        b=J+wM78PXA8I+3aOobRUPExpWb/QvX+7dCxq58/q9B3qEkZeFpxMMOpE7G3aaXRuKr9
         fqjB41UWcRicypTvizH0m4u29K+pZiJMBnDYBj27up+jPcyRNqG83RqXE6hcKcWTChRf
         E2pTfPSEcmhPu6wGGpBOnVMS7bcDFZBvZbqddKZjkcO8esDgyKqubkgddwlaeeaG5Rdb
         29CR6crWYKBqTlXcI6wLFH7iwY938rqLvMi1y5DzKdlFh0WBB7eixB1TG7+FwLlblwI5
         eeyBXaZUd8yWGs99iUq6IJouhmEoMvmSjWHAZPN7gAdzi9zJXNBm64VNmSM3+cgip7Iq
         AlIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RJiBb8F0ZIhkEzjeNE5PJ80Os/lj+Z9pFBzCKAm8HF8=;
        b=n0ob6o695aoh8tW3mF3PGg9LmKDrPLO/YQQ5V54rbESfXDRE9xTU8FqOuSXAFxotbI
         cNSPPoxjZ42jt39i5eMWWyP+vAz4jdiHdknypIvQfLZBUclCPBYukNTCqDq7pjN+kHMw
         oiC1MvfKDZRxghVE+98/iJx9R184tb+GgcdaCn8RhGXRBIOfXdOrfpvCHCm7h7gAVPPH
         Y0adJGOW59fpTfo390z315fgYBHd+fxABcXRxyXfg/hfYf0aIdXggqxBGKdW6IBAh3Eu
         LP3wGXUWKaXrtamG/g5JEI/NM6MPdqR2npTERlOpW1rYB53hp+QQYA8y/PKdpIqto018
         F4TA==
X-Gm-Message-State: AJcUukeZHIzqDiBoMHKtVKnF6MBlOapRdifgbOGqaMqsIOqDI9X2KxMN
        Pzfl0N/O8g1q5bomWdKEybsBnNCj
X-Google-Smtp-Source: ALg8bN6OK/1BqZXsGAhaLfqNOpqU7ALxl+cXIfDzcpoH5Ct273kLbOGaCaQ6IvD9QenWlnhaMBnzvQ==
X-Received: by 2002:a50:d085:: with SMTP id v5mr25451516edd.61.1548771569448;
        Tue, 29 Jan 2019 06:19:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b46sm14859665edc.57.2019.01.29.06.19.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:28 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:28 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:07 GMT
Message-Id: <4c78085af7b41dc66a2757dfad9dd1ab329cff5b.1548771561.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 08/21] ci/lib.sh: add support for Azure Pipelines
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

This patch introduces a conditional arm that defines some environment
variables and a function that displays the URL given the job id (to
identify previous runs for known-good trees).

Because Azure Pipeline's macOS agents already have git-lfs and gettext
installed, we can leave `BREW_INSTALL_PACKAGES` empty (unlike in
Travis' case).

Note: this patch does not introduce an Azure Pipelines definition yet;
That is left for the next patch.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh                 | 25 +++++++++++++++++++++++++
 ci/print-test-failures.sh |  5 +++++
 2 files changed, 30 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 32a28fd209..5505776876 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -102,6 +102,31 @@ then
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
 	export MAKEFLAGS="--jobs=2"
+elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
+then
+	CI_TYPE=azure-pipelines
+	# We are running in Azure Pipelines
+	CI_BRANCH="$BUILD_SOURCEBRANCH"
+	CI_COMMIT="$BUILD_SOURCEVERSION"
+	CI_JOB_ID="$BUILD_BUILDID"
+	CI_JOB_NUMBER="$BUILD_BUILDNUMBER"
+	CI_OS_NAME="$(echo "$AGENT_OS" | tr A-Z a-z)"
+	test darwin != "$CI_OS_NAME" || CI_OS_NAME=osx
+	CI_REPO_SLUG="$(expr "$BUILD_REPOSITORY_URI" : '.*/\([^/]*/[^/]*\)$')"
+	CC="${CC:-gcc}"
+
+	# use a subdirectory of the cache dir (because the file share is shared
+	# among *all* phases)
+	cache_dir="$HOME/test-cache/$SYSTEM_PHASENAME"
+
+	url_for_job_id () {
+		echo "$SYSTEM_TASKDEFINITIONSURI$SYSTEM_TEAMPROJECT/_build/results?buildId=$1"
+	}
+
+	BREW_INSTALL_PACKAGES=
+	export GIT_PROVE_OPTS="--timer --jobs 10 --state=failed,slow,save"
+	export GIT_TEST_OPTS="--verbose-log -x --write-junit-xml"
+	export MAKEFLAGS="--jobs=10"
 else
 	echo "Could not identify CI type" >&2
 	exit 1
diff --git a/ci/print-test-failures.sh b/ci/print-test-failures.sh
index cf321b474d..e688a26f0d 100755
--- a/ci/print-test-failures.sh
+++ b/ci/print-test-failures.sh
@@ -41,6 +41,11 @@ do
 		case "$CI_TYPE" in
 		travis)
 			;;
+		azure-pipelines)
+			mkdir -p failed-test-artifacts
+			mv "$trash_dir" failed-test-artifacts
+			continue
+			;;
 		*)
 			echo "Unhandled CI type: $CI_TYPE" >&2
 			exit 1
-- 
gitgitgadget

