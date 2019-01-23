Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F5591F453
	for <e@80x24.org>; Wed, 23 Jan 2019 14:40:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbfAWOkR (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 09:40:17 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:43375 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726354AbfAWOkR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 09:40:17 -0500
Received: by mail-ed1-f66.google.com with SMTP id f9so1862650eds.10
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 06:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JRloxJWyjmBVigttLX7WyMhlPzKiV+c4cwHlZMGyXTE=;
        b=PMRaZaPtGd2gs7CMvCNu/1z6NBdi9CL6fit/pmi584pBqkuj5DtpdvG7G6R/5fE7l5
         517cPd4IudM1Z7F6zpBCL1K+JTKLvbhDz3jBpi8aDfDomlw4RJ1Fffe5eHBAjiinQSh3
         kBUJCgYGxbZoA350J7NcOK1D78HUaA+SrSKW7PhOFZO4+W3eGc/nTyBE2j16RcgUd0ft
         oOME5VyZGQW9bjtOfhshPpKzWNeVzcCuBsjYVTYUTizjoxAx6967VxtLwUMFGbt88x/k
         /2t8S5+4aKK1aDxdLejF5t8ByaPnLF22LylkJjzfjKLryPuHh35uZoImpGAjSNDlbDH/
         2/Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JRloxJWyjmBVigttLX7WyMhlPzKiV+c4cwHlZMGyXTE=;
        b=UlP24ehqmuzyNEtrKDI9kpEc3atj89+ubus78dLWTQAu352FUGs+SsOLpTNWRLg4Kn
         z41ApZWTMCbsAptHPa8Qk1LhNf3m9nOv2CywIKQUztOPH6q1lQvjHaxfCMEE4QBR/Dzm
         tqHnvXBXkTg+iEtne+cJAhpBN420xZ6kTfsjlg9z7w0qxun1yMQ5S9vZuygHXWzJjYuS
         mDwaZcXy75yeu2a3/yC/ftX1AzGSP3u4Tr5TsewmL30E2oTtadRvG3jtfhCWusqXi4pW
         Kz14gyswtUsAZ87OdJ+G2SQY7CCZHZQy3Fu0m7T4yRSYhKluX2RgLA0DJhgWEr/2HYww
         BzCg==
X-Gm-Message-State: AJcUukfaqjTK2hlMCCvaRlPfoN+9MKloPBVShC1vKXKdEqOomdgtoHkq
        VF2OR8Eiw4HMno0hRNf75ooHJ9AM
X-Google-Smtp-Source: ALg8bN6M7rUV2dDC9v0Gf0JL8fa7LfWO/ZmYzDlTMqATNzWbbSqaRngYyEbKaz11jJ0OX2A+zGNhWQ==
X-Received: by 2002:a17:906:8249:: with SMTP id f9mr2790200ejx.134.1548254414905;
        Wed, 23 Jan 2019 06:40:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c29sm10373289eda.75.2019.01.23.06.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 06:40:14 -0800 (PST)
Date:   Wed, 23 Jan 2019 06:40:14 -0800 (PST)
X-Google-Original-Date: Wed, 23 Jan 2019 14:39:52 GMT
Message-Id: <6ed2f2a35c394987be2bebd2364915c4daed888d.1548254412.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v4.git.gitgitgadget@gmail.com>
References: <pull.31.v3.git.gitgitgadget@gmail.com>
        <pull.31.v4.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v4 01/21] travis: fix skipping tagged releases
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

When building a PR, TRAVIS_BRANCH refers to the *target branch*.
Therefore, if a PR targets `master`, and `master` happened to be tagged,
we skipped the build by mistake.

Fix this by using TRAVIS_PULL_REQUEST_BRANCH (i.e. the *source branch*)
when available, falling back to TRAVIS_BRANCH (i.e. for CI builds, also
known as "push builds").

Let's give it a new variable name, too: CI_BRANCH (as it is different
from TRAVIS_BRANCH). This also prepares for the upcoming patches which
will make our ci/* code a bit more independent from Travis and open it
to other CI systems (in particular to Azure Pipelines).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib-travisci.sh | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/ci/lib-travisci.sh b/ci/lib-travisci.sh
index 69dff4d1ec..c26bb6a274 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -1,22 +1,25 @@
 # Library of functions shared by all CI scripts
 
+# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
+# want here. We want the source branch instead.
+CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+
 skip_branch_tip_with_tag () {
 	# Sometimes, a branch is pushed at the same time the tag that points
 	# at the same commit as the tip of the branch is pushed, and building
 	# both at the same time is a waste.
 	#
-	# Travis gives a tagname e.g. v2.14.0 in $TRAVIS_BRANCH when
-	# the build is triggered by a push to a tag.  Let's see if
-	# $TRAVIS_BRANCH is exactly at a tag, and if so, if it is
-	# different from $TRAVIS_BRANCH.  That way, we can tell if
-	# we are building the tip of a branch that is tagged and
-	# we can skip the build because we won't be skipping a build
-	# of a tag.
-
-	if TAG=$(git describe --exact-match "$TRAVIS_BRANCH" 2>/dev/null) &&
-		test "$TAG" != "$TRAVIS_BRANCH"
+	# When the build is triggered by a push to a tag, $CI_BRANCH will
+	# have that tagname, e.g. v2.14.0.  Let's see if $CI_BRANCH is
+	# exactly at a tag, and if so, if it is different from $CI_BRANCH.
+	# That way, we can tell if we are building the tip of a branch that
+	# is tagged and we can skip the build because we won't be skipping a
+	# build of a tag.
+
+	if TAG=$(git describe --exact-match "$CI_BRANCH" 2>/dev/null) &&
+		test "$TAG" != "$CI_BRANCH"
 	then
-		echo "$(tput setaf 2)Tip of $TRAVIS_BRANCH is exactly at $TAG$(tput sgr0)"
+		echo "$(tput setaf 2)Tip of $CI_BRANCH is exactly at $TAG$(tput sgr0)"
 		exit 0
 	fi
 }
-- 
gitgitgadget

