Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642B51F4C0
	for <e@80x24.org>; Fri, 18 Oct 2019 22:10:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390924AbfJRWK6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Oct 2019 18:10:58 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46379 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390879AbfJRWK5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Oct 2019 18:10:57 -0400
Received: by mail-pg1-f194.google.com with SMTP id e15so4060336pgu.13
        for <git@vger.kernel.org>; Fri, 18 Oct 2019 15:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=erkiYgyZVZjHdJVDwgrPyczAgjqKYZih12Jmuwj7u5M=;
        b=m7moutVCwVhy2qefMQdy+uiM4mq/HYT25ridoIBTYweE1C9iZ436zPHVwddhtQoCQx
         th6xXtQ/6fc5cM/bNk9Gg9pu63Z4Sxf/oFh3wUNS8Yg5adjSGGfI4oRwAgW1bXbP5K6U
         qJIPHGT3ghAaoEbb6iSZeo+eUCvgyz3GzrJMFaq/H5pMWiNFbob4lF30rY+K25aRzKx2
         4WczgXDFrb3ZVd4JHD0kyS5wThhKVNw2aVZXz+krbEZzXsZ6ESq2YBfhAOZ76RymGAxt
         RMwfdXMmsKOGMlKzxkE9CW26U2aITMewd0eGzPrtJvqdY1Svbo8QyedQ43AQxMecUFqY
         IUaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=erkiYgyZVZjHdJVDwgrPyczAgjqKYZih12Jmuwj7u5M=;
        b=nY/0fhhvcvG6iOFLlNNFzblgT/LUzdsk54LtzhAwYxnM0kIBVM5idwH3M1RnIWaGBa
         4H38v20dW0eGPjJFfrDvrZY1KelzwaXUHevlBbBS2h2o2ubuH2IzV3bvPrgPfpKS0w3H
         o6NLqSWsYNU6pk3okksKTL2kkhJy7+z5uqst00/Zs+jdyON+p9dJsoRNCqtnGr+/fCMd
         3OL5b2aEp/Js6qgnHzOOtlWDTQH00vkD+hJg1GDDv93mbSmv/WdSavadU8BS9bj7eoe1
         EtmiPC/pH3WBkpd5OFLNGoBTnP2s5gkGs1IR6mcHBcYaEmypVFRkFyRapBX0kIXZOyVv
         E2qw==
X-Gm-Message-State: APjAAAX5zixtZR37Xa1/0mCZ2nSvj9yQI0QAwGXTOSW93uZStEzZFbfS
        hJyLReElF2BXUPtDLRNolgllKwCA
X-Google-Smtp-Source: APXvYqxx7qt1Tf1d8MVJcNCWjuEBqwSyeFp0oXyTSdBnGFhALoY5XfYIyBn+Ci3TlYJCnOHyY0RmQw==
X-Received: by 2002:aa7:838f:: with SMTP id u15mr8873497pfm.13.1571436655435;
        Fri, 18 Oct 2019 15:10:55 -0700 (PDT)
Received: from generichostname ([204.14.239.54])
        by smtp.gmail.com with ESMTPSA id b5sm8134514pfp.38.2019.10.18.15.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2019 15:10:54 -0700 (PDT)
Date:   Fri, 18 Oct 2019 15:10:52 -0700
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 14/15] t5520: remove redundant lines in test cases
Message-ID: <5aac40a029a95f0a72415f80b546310a3940f053.1571435195.git.liu.denton@gmail.com>
References: <cover.1571354136.git.liu.denton@gmail.com>
 <cover.1571435195.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1571435195.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the previous patches, the mechanical application of changes left some
duplicate statements in the test case which were not strictly incorrect
but were redundant and possibly misleading. Remove these duplicate
statements so that it is clear that the intent behind the tests are that
the content of the file stays the same throughout the whole test case.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/t5520-pull.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index c9e4eec004..ef3dbc201a 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -147,7 +147,6 @@ test_expect_success 'fail if wildcard spec does not match any refs' '
 	test_cmp expect file &&
 	test_must_fail git pull . "refs/nonexisting1/*:refs/nonexisting2/*" 2>err &&
 	test_i18ngrep "no candidates for merging" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -161,7 +160,6 @@ test_expect_success 'fail if no branches specified with non-default remote' '
 	test_config branch.test.remote origin &&
 	test_must_fail git pull test_remote 2>err &&
 	test_i18ngrep "specify a branch on the command line" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -174,7 +172,6 @@ test_expect_success 'fail if not on a branch' '
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "not currently on a branch" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -188,7 +185,6 @@ test_expect_success 'fail if no configuration for current branch' '
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "no tracking information" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -202,7 +198,6 @@ test_expect_success 'pull --all: fail if no configuration for current branch' '
 	test_cmp expect file &&
 	test_must_fail git pull --all 2>err &&
 	test_i18ngrep "There is no tracking information" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -215,7 +210,6 @@ test_expect_success 'fail if upstream branch does not exist' '
 	test_cmp expect file &&
 	test_must_fail git pull 2>err &&
 	test_i18ngrep "no such ref was fetched" err &&
-	echo file >expect &&
 	test_cmp expect file
 '
 
@@ -685,10 +679,8 @@ test_expect_success 'pull --rebase fails on unborn branch with staged changes' '
 		git ls-files >actual &&
 		test_cmp expect actual &&
 		test_must_fail git pull --rebase .. master 2>err &&
-		echo staged-file >expect &&
 		git ls-files >actual &&
 		test_cmp expect actual &&
-		echo staged-file >expect &&
 		git show :staged-file >actual &&
 		test_cmp expect actual &&
 		test_i18ngrep "unborn branch with changes added to the index" err
-- 
2.23.0.897.g0a19638b1e

