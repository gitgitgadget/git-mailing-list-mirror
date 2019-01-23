Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B35431F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726997AbfAWOkn (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:43 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:44521 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727136AbfAWOkW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:22 -0500
Received: by mail-ed1-f44.google.com with SMTP id y56so1854989edd.11
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Euzt0m1wqeilLrDM6dfdK5D57Sibiv935ElLJjIpVQo=;
        b=r53iiX9w/EWT7Gz8N4xymlU28IJ6lxy8X0wgSH+LxqNNKGbo61S7CJl4qjkDLOCZRU
         CnzFGr5KAnBZUcAC2hXmpZm56H8aT2/2eWMzhu7BrivGu7G4/7eo5JYgn/OGEKouiKni
         H68E+2MyXGPjXoiI9R+nyaGNHBS4lrBAhaguED0C7ob30LYJFAp3YQwLlKZYq4UUP0at
         jVgk3RupXbROcm2i5o+uwjgwjTjADLC4o5yhgh47v2RDix8Rd3AAQWFFv50qN8i+3KHL
         iyH7+B3DlUyOkbCCpkHVN+CKC9qFVq+hREScuTJXCFm7yh5kAjrmaqWtLVJXjuSAIeUL
         mC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Euzt0m1wqeilLrDM6dfdK5D57Sibiv935ElLJjIpVQo=;
        b=lwheCTP46AbxUzNIykgAmyD0rq1oV2b8LoaeCbpTzPhym+jq9MK7e6P0f3dLHPgfgj
         62/u2ORHZesbR7bPh9a/bwQSb76dAMg7Z6y15dxFKOyrHkmZ3mK8lVx2C27x+Z0qa1cf
         ozJFAWlyVEOnlQVo7o1RFM+iP1/EbXz4RMmsRDKzrGogmROYLlwlrPGiGrMLY49GeqxW
         GxQpJn2y568+Xu9A17BKv4Rv9IyGOjHiI3KrToX38VK0KAKmzT+rLVT1OXkd32C5qXVo
         k4T3N8An5MX+VxQyy5C4cCPXygjZyZ2q9QFcrfm6VxDiJcjLEcWH/OTjq6vYCvJ6boLV
         4buQ==
X-Gm-Message-State: AJcUukfhEr1Ek/XXa5qOXgfpPV44K4CbLW1bHTlNeLfBxt8PTTgLfPLt
        jFT5Eg9E60fSY/ZDpGKLBH07uqvV
X-Google-Smtp-Source: ALg8bN6WkkOFLWo/A17o2I0A/W5NuVH3N7qk8ZcE3kcQY92XXRbNCAWT15ibhDzLUvmhRcXtIpmz1w==
X-Received: by 2002:a17:906:14cc:: with SMTP id y12mr2751440ejc.144.1548254420671;
        Wed, 23 Jan 2019 06:40:20 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l18sm10013642edq.87.2019.01.23.06.40.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:20 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:20 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:59 GMT
Message-Id: <178dc9b789caef8e2402ab518bb5ca36da2c32ad.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 08/21] ci/lib.sh: add support for Azure Pipelines
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

For example, we do not have to install the git-lfs and gettext packages
on Azure Pipelines' macOS agents: they are already installed, and trying
to install them again would result in an error.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 4456dbbcb0..a9eb4f4eae 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -20,6 +20,29 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+elif test -n "$SYSTEM_COLLECTIONURI" || test -n "$SYSTEM_TASKDEFINITIONSURI"
+then
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
+	export GIT_TEST_OPTS="--quiet --write-junit-xml"
 fi
 
 skip_branch_tip_with_tag () {
-- 
gitgitgadget

