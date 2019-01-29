Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4A0B01F453
	for <e@80x24.org>; Tue, 29 Jan 2019 14:19:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfA2OTZ (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 09:19:25 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:46171 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726374AbfA2OTZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Jan 2019 09:19:25 -0500
Received: by mail-ed1-f68.google.com with SMTP id o10so16041743edt.13
        for <git@vger.kernel.org>; Tue, 29 Jan 2019 06:19:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OI68Im74sbgIpA2rOJGuaYfRquVrHtJVPXrcFiPB1sA=;
        b=hsbHn7wUayiXFkelw6B6PI8DTE5It9+9eoRNALUpCgyELx4MoFcOXuLxyBmAbEoHAy
         9AuSSwkBiZDkhQNn6pZ8WGc3WmFbbFIzA4MZGP7dzM1iyO7W3HEyeTOiL3GcPDgr18nF
         u/Ppt/9ZFzXhHqWYDznyqIpqXvb23eTs7a5GCdGmDb8OXRPy5IZM7qcG1OqTM2HqJAhR
         +i/nGh/qN/C19eFtH3POYzECFzM8Z129ruI6VSs01NVj1Q5ej2NMyKCsShOL0zfe3LC0
         iO5W4lfDahI+pb5i1ZtgkrovprvdTP/MbUgaKgqUUvMotOovTZU9R1jrIqHCphhGToB+
         BBMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OI68Im74sbgIpA2rOJGuaYfRquVrHtJVPXrcFiPB1sA=;
        b=LjZXWfxM11BnrZPSk/NxaAIGxJABekHXYKfLF7Q+JyS6JdBjSFQ+MwWykp3NokOnCp
         CM+mEyUQX0VNybqA99SNqOlZcG2JYjj3KSTQfnlpK5bFf+a0x9ysTqB3WKKgBBA4qjmK
         /kAt5g5+T2TsSf4ghl+vjcHOAC+SjufFS56H9c8Y85Ucukz3nKugSenQljX5+tWVw9b7
         tMPb7w7PMJXoQxPHaPpBvjhYOM7VSTHbbieA1RqbN5GFcNaycUK9Vx9NDpTFVNSpmkOo
         HMn1f3nArIUJc6RNKXOdPxqQ8YwPPX7Zvd80IH4FUkdxYlC4R5f97/ucgMmwjZ5+fnHP
         TYNg==
X-Gm-Message-State: AJcUukewBgvhYjBBTc8rSdys2DQbQNGrbDfuV7ueMp9TM7WfsS8KkQ1e
        nO0y/ukd+9C5jsv0F5nodaWWsFBw
X-Google-Smtp-Source: ALg8bN6tBWbfRD2axzjIaInidKAAhRnyWz814lMdGKMihYECZ9E3HU5Z+xMrDDpRfgmSoodqXEcJ7Q==
X-Received: by 2002:a17:906:a44:: with SMTP id x4-v6mr22545899ejf.177.1548771563167;
        Tue, 29 Jan 2019 06:19:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h51sm15434010edh.17.2019.01.29.06.19.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 06:19:22 -0800 (PST)
Date:   Tue, 29 Jan 2019 06:19:22 -0800 (PST)
X-Google-Original-Date: Tue, 29 Jan 2019 14:19:00 GMT
Message-Id: <f553fd4fb37c26e04b404b0819d3f7bcd51cd4f2.1548771560.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v6.git.gitgitgadget@gmail.com>
References: <pull.31.v5.git.gitgitgadget@gmail.com>
        <pull.31.v6.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v6 01/21] travis: fix skipping tagged releases
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
index 69dff4d1ec..9c6ddeb374 100755
--- a/ci/lib-travisci.sh
+++ b/ci/lib-travisci.sh
@@ -5,18 +5,17 @@ skip_branch_tip_with_tag () {
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
@@ -81,6 +80,10 @@ check_unignored_build_artifacts ()
 # and installing dependencies.
 set -ex
 
+# When building a PR, TRAVIS_BRANCH refers to the *target* branch. Not what we
+# want here. We want the source branch instead.
+CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
+
 cache_dir="$HOME/travis-cache"
 good_trees_file="$cache_dir/good-trees"
 
-- 
gitgitgadget

