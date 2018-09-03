Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C7FD1F404
	for <e@80x24.org>; Mon,  3 Sep 2018 21:10:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727455AbeIDBch (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 21:32:37 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:41667 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbeIDBcg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 21:32:36 -0400
Received: by mail-pf1-f194.google.com with SMTP id h79-v6so614358pfk.8
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 14:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dfC9kncIVTFnuBvb4VMLC8xiJIL9eosMJt/P7Y+YrZw=;
        b=SpEtwXFbIREAhVZH+TZrN9+bDkuYnByAwXLxQCz2BS2UTGBmKPKhgf1SqLCaQJwbQ8
         jEFEHUVXO/eozoiOvPoGPVZ6Q39jWHoaxFktlQ6ZAO4yhhKskkXn7dx3EgJGBRAlXfQZ
         jXzEx6++Ryo9wLkr5RmbHsQ8M2qgFfzebZNMA+ziOKOr8PofSpBO+8+XE++ToORYIGin
         WxD42xvre7uRW0w0X05+vbcRQ/xh67swczshCjJvnzpI2xS6q6xsvxBJLqTT4nvRJ4Z9
         SRWvpaQpqE1PtnZEnc3c6Ie7z0Kah732boZOjQnwLUKBQ9/kY9432M133csqXoEvOuwU
         HITw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dfC9kncIVTFnuBvb4VMLC8xiJIL9eosMJt/P7Y+YrZw=;
        b=dsYZTJrWYB5MC/GzDaeVeZeFRejlalBBEIOUVTujVGefeToMb14SBdwhyjLtB/1dYa
         0LbTzzN1oWOjX7+wd0Kran9tPyMzuMNCis6fAcSlYGA1JNhZ2ToWDZ61gOgwVd5UmV8e
         9JhGiWw4L/eKYzhh3TTg91yKwMR5lFvkvT5Dt/swXYyJPqjn5DOFJk7/TmeqnfSCeLyh
         JFmwy5xkDB3LqZ+5+Goij5YKFL8cZGnCt4TbSvuqOEC+NSLrgEaUlwv62puBQYwzUNy/
         kSV/Gt5La5M2x1wR9J2dem+QUXoisUgu2uquDt2v2tCWtY8LuFxIbR39BwMzpvBSEzlE
         hXEg==
X-Gm-Message-State: APzg51CqgfSiROQxPBOhVoLj7YI+pxXu1QZCzfkk/Q7CI5dNIBzaa/Ll
        /HxpMODTtyzzXHAYBx9wxWGKoj4t
X-Google-Smtp-Source: ANB0VdZ1jnUf7hN/8BVDuWS9WavG5SFtG+pZrn0jOl8rfbJYt6bWZuGA/P9CAHGmLqML2feKx/QbNg==
X-Received: by 2002:a65:6499:: with SMTP id e25-v6mr26928128pgv.224.1536009036708;
        Mon, 03 Sep 2018 14:10:36 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.142.204])
        by smtp.gmail.com with ESMTPSA id k23-v6sm21257796pgl.42.2018.09.03.14.10.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 14:10:35 -0700 (PDT)
Date:   Mon, 03 Sep 2018 14:10:35 -0700 (PDT)
X-Google-Original-Date: Mon, 03 Sep 2018 21:10:22 GMT
Message-Id: <127dfcfb09d3830fca92249cc56eaf68f5c55936.1536009027.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 5/9] ci/lib.sh: add support for VSTS CI
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
index 657ff88672..f2f6d70c72 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -19,6 +19,29 @@ then
 	BREW_INSTALL_PACKAGES="git-lfs gettext"
 	export GIT_PROVE_OPTS="--timer --jobs 3 --state=failed,slow,save"
 	export GIT_TEST_OPTS="--verbose-log -x --immediate"
+elif test -n "$SYSTEM_TASKDEFINITIONSURI"
+then
+	# We are running in VSTS CI
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
+	cache_dir="$HOME/vsts-cache/$SYSTEM_PHASENAME"
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

