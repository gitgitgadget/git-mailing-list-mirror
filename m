Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B7B71F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbeJOR4l (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:41 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:40107 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbeJOR4l (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:41 -0400
Received: by mail-pg1-f175.google.com with SMTP id n31-v6so8936909pgm.7
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JZVxgyN5sZUoXAxIQHhjlagC+s+gaWu0xi40fYlv55g=;
        b=KQYzVVo1ZT4TEH0LIIcKwCtWTDnBSSRxEHE8SY+iAg82x7kDm0SGZeqV1nKRFqQDNg
         x8IfMGE+fvU84YqlP/oGxi0J2oigrOHhoUKUSReiw3AELjDdYi8Obeej5Q6bGIlthqtr
         F+U2NjT6wSo/tWNAnjPFSavGfuLNfSgMCcqgQyGmnqhXSnIPiKOF9FOAIjRhxkjlb64/
         KtI+zCKcefKTkYjF+A8TE/B0aEzNgkXufsYi7zFhHi5nYQ5kEemLM4BIac3GoSWqfdZy
         fzpiRM/LIMX8mhSJ+BtvaZA/A30nzS4GRz/DanU+90XeHNkTD29Z3oq2TiT4G7+A7rnt
         mstA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JZVxgyN5sZUoXAxIQHhjlagC+s+gaWu0xi40fYlv55g=;
        b=dJ3sh6KILoDeL4Wt5kNwJXchFbCJQeS/+bYoAbaBGJNsdCWF15ZCo8c2aEBbQDwFr2
         0hTueoMLYzs2bSt2LWD6jXbSIMgg5XGzb539kKPr4K8ICjQRqK+M2ooArV0n/z/rNPGV
         M307N6KREzoYdTYB9fwRYAVdJkl658ixvpfXRF3+Lb5dX778+3DdyPz51qyllBQD5RZ6
         a02GvRNsmg70mhpSKaBFnBITfZpNS0ksvb3s8BpYIz/betMNY5t6J8Ok/uT/IwFlDyIB
         2NDioj5Qb7U+RZEly5qkCkq9j0Iv/2nUXjfngF9WWyrDIw0IVu/x7APAfgE2u5ydQOrC
         kV5A==
X-Gm-Message-State: ABuFfohTm/+JuM3zNvJQmJGHpg+Zzc5J5IlBUf7GwlXMGqDorY1WYlMW
        1mZSAAt6ibhpmAvmgiueeCK4ykmz
X-Google-Smtp-Source: ACcGV63mMs1IuqjWoL+ZTP5rviJuBfD9RArytL71W3hgmEmAkX9QYUAkTNIfV4npRtN8xsIWey9UOg==
X-Received: by 2002:a63:1411:: with SMTP id u17-v6mr15185679pgl.247.1539598326259;
        Mon, 15 Oct 2018 03:12:06 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id v84-v6sm14856242pfk.12.2018.10.15.03.12.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:05 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:05 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:47 GMT
Message-Id: <486d1d25183fc7b0de599a0791ed41a87cc176cb.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 05/13] ci/lib.sh: add support for Azure Pipelines
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/ci/lib.sh b/ci/lib.sh
index 8532555b4e..584abcd529 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -19,6 +19,29 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+elif test -n "$SYSTEM_TASKDEFINITIONSURI"
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

