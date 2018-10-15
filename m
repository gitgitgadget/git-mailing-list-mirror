Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608101F453
	for <e@80x24.org>; Mon, 15 Oct 2018 10:12:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726915AbeJOR4x (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 13:56:53 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42124 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726868AbeJOR4x (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 13:56:53 -0400
Received: by mail-pf1-f194.google.com with SMTP id f26-v6so9427975pfn.9
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 03:12:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=uVPhXeh89yk5WHqhnJElovYyBG2HPAq9b4dHJaQ+mjM=;
        b=f9eJptoyW9M+JJkkq2na20LqBFS4snNhqmKDUtUlRA1bAfUj+m3ZZMKzjnyEJ2JeFM
         l3YnkBE8LmgXYtWsl2W5QR3nIfHeoQqACO1szFh+KBtJ4d9pUmBTgcC0rCUjVkHnRTJm
         J+ZGhSbei6yxZhr6IO2yGb6clzvlJO2ldTJACJIQ50tax+kgoe/tVjk0kwWZhTvqmO4+
         28QV84WXrboqdnu7qVLH5pxT/glp6smDcgpYrOkOYLqYg3Qokgk4hpOO2Bkf2e0s2DVK
         xhCfPo13TRFtR6YhmisybGe1M/larPzKASKD8kH8SnMCMMrkwnvAv7/oH497EKn7clkW
         5dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=uVPhXeh89yk5WHqhnJElovYyBG2HPAq9b4dHJaQ+mjM=;
        b=kV3hKB1nctnJGbpGZUxxE+wk5yDnwpNXne8IhdwKoAwpOxSt6nzC/7wKUzIDMm3cOD
         6S4jkKvf9F6JW7yUPLxRlY7VkoZkAwee7m9Y22JwFuVhOwSm4MH8YL/Qv3wI5nCyY9kb
         iDNOLM0mWX1l6ytTDiF1+UYk56FGS3pB9iWtGw87TfVGinAGfMldoFQVONdLoXODbc2A
         qR/Sh/9cUtLa3D12lI6Wa8gOAE2BWu8j8zarVQbHXRaxvxE+Q6yyFePBUJwJ273UkiiO
         JMegZ/TruLWiXt2nboAASOpHqAUwpD1x4BIuQ1BU/yJvAuvnc+jmtdE9VETbBjLgQKnB
         3sEQ==
X-Gm-Message-State: ABuFfogFvABMRlI/pqV2IwYx3SctgplOAZk0BCuHE9cHUXP0m9/CThOO
        I84cZBoB/zZz+Vknqw4VaLvA7qHY
X-Google-Smtp-Source: ACcGV637DehbJEFyBYyZJfKZoTvrvpJqNb5LHDaeeIFCD7k0yEovN3VewkouBz4uKte2O6VpZEf4Sg==
X-Received: by 2002:a62:c68e:: with SMTP id x14-v6mr9124937pfk.151.1539598337849;
        Mon, 15 Oct 2018 03:12:17 -0700 (PDT)
Received: from [127.0.0.1] ([40.112.137.127])
        by smtp.gmail.com with ESMTPSA id d18-v6sm11506807pgd.86.2018.10.15.03.12.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 03:12:17 -0700 (PDT)
Date:   Mon, 15 Oct 2018 03:12:17 -0700 (PDT)
X-Google-Original-Date: Mon, 15 Oct 2018 10:11:55 GMT
Message-Id: <0a53f371350146ecd01b44f0f42da447d7573689.1539598316.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.31.v2.git.gitgitgadget@gmail.com>
References: <pull.31.git.gitgitgadget@gmail.com>
        <pull.31.v2.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH v2 13/13] travis: fix skipping tagged releases
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

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 ci/lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/lib.sh b/ci/lib.sh
index 584abcd529..e1858ae609 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -3,7 +3,7 @@
 if test true = "$TRAVIS"
 then
 	# We are running within Travis CI
-	CI_BRANCH="$TRAVIS_BRANCH"
+	CI_BRANCH="${TRAVIS_PULL_REQUEST_BRANCH:-$TRAVIS_BRANCH}"
 	CI_COMMIT="$TRAVIS_COMMIT"
 	CI_JOB_ID="$TRAVIS_JOB_ID"
 	CI_JOB_NUMBER="$TRAVIS_JOB_NUMBER"
-- 
gitgitgadget
