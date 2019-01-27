Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2B4461F453
	for <e@80x24.org>; Sun, 27 Jan 2019 23:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbfA0X0w (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 18:26:52 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:38148 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbfA0X0w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 18:26:52 -0500
Received: by mail-ed1-f68.google.com with SMTP id h50so11588667ede.5
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 15:26:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=OI68Im74sbgIpA2rOJGuaYfRquVrHtJVPXrcFiPB1sA=;
        b=uofSOiQIwvt8SOPTIcQUBY8BOk9cczh4uU5HOx3rwNjwuFsfxewCIB8lMMSdjWwZXY
         ubiStitpkKfF/vhmxEe13/OsRdvfRFI+6tsNgDCuygxcFhAFhQgzOem2CqlWjRTXqEYh
         2MuI6NqIfBZB7r+sHT9MuZoTUAHKdxlNjpAPDqeTgkxvR0/dgT5gbcLTUBcqXAFHhTdq
         vNlNM3cucBuv/u30ldaA1UXHh4Gkppeh2wJxgDvneUwYcr+oBFJo/ySrWtkYgk5XjOaB
         p6BVsGlRhWWaHCfXK8q6NYyB/IwMCmMxk7UXb79pFYFK6xACZhwgG3EF2GE9XUQRO5L3
         dZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=OI68Im74sbgIpA2rOJGuaYfRquVrHtJVPXrcFiPB1sA=;
        b=k0AlvnKfyjOza841ZDpWd6dCn7KofnQm0Op0/5PcLbRAwQw54zFx2FgLqV+Q1AsYV+
         a5MgPIw4Muu/kTQlnJ+KD49szvZhSyhtCycvrM6xc74YWUapRXTg/IulJLbTH8GR48qB
         tCvlVn8CqX4WBwe+XwRuLd9iaUvpE8mNrmBUrTPKQBxiBZ1v5WhWzvkf05v2+YHyDvB3
         R8ydJAcxbvKjFKwAL+FG6CgTFgoPpGedod52SybKdEUeM9iZ4rsO1rlpgvDvxYPOkIj2
         IaAaZd9Bn0052igBtF4JNl3qTi/jfXD0kC8o1kZhplXPiRGKs/IgrupqenIIl8JH5tal
         QUHg==
X-Gm-Message-State: AJcUukdUx5Y3QX1Kugz9ebm5auMbrUrX99XMtde/kkeuH9A9jPAgvvBR
        vqr1B8N3D3E32T6z071MLAPngQvt
X-Google-Smtp-Source: ALg8bN6zT3gmFmujztWABGMkvp63pMQG0Sdpgg09kd9dsXOSVaEOZHhXWp9SK0RLH3bgXDNgqqR4Dg==
X-Received: by 2002:a50:880d:: with SMTP id b13mr19025494edb.68.1548631609856;
        Sun, 27 Jan 2019 15:26:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay20sm1179536ejb.32.2019.01.27.15.26.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 15:26:49 -0800 (PST)
Date:   Sun, 27 Jan 2019 15:26:49 -0800 (PST)
X-Google-Original-Date: Sun, 27 Jan 2019 23:26:27 GMT
Message-Id: <f553fd4fb37c26e04b404b0819d3f7bcd51cd4f2.1548631607.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v5.git.gitgitgadget@gmail.com>
References: <pull.31.v4.git.gitgitgadget@gmail.com>
        <pull.31.v5.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v5 01/21] travis: fix skipping tagged releases
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

