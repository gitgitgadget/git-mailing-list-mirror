Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 169691F462
	for <e@80x24.org>; Tue, 28 May 2019 12:42:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbfE1MmU (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 May 2019 08:42:20 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45452 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727390AbfE1MmS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 May 2019 08:42:18 -0400
Received: by mail-ed1-f67.google.com with SMTP id g57so16728989edc.12
        for <git@vger.kernel.org>; Tue, 28 May 2019 05:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:message-id:in-reply-to:references:from:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N3Cp8i9JwEcJxG1B2UlqEvv+bqTEEpNWRZZ63pk+CpQ=;
        b=NEv+BptzK3QPzJB4saHLojfNlZ+o0AK6PFTQKri+7OAhkW7z/FvNi3h0d2Ufd+Sc48
         wA/LRIw2Xig3tIryRnOYBwx6S4bDPsb0weUWzC/zCTLIwe5HBJfMohCvqrV1guph8lSP
         tWo1vu9Ou+yTdisF645uGPScDtSqj79VOYaUnml8Lm39WIFAMunJ0jf6VbmTvbzV566T
         gNLPySz5n8lafdoFGxpyBRvmzA6/H6QB4wLXEHypjBi3Ki42U2mWcqJ/85/q98Yy40mQ
         nfLlRhM3aaR8+n/9RsArszCwt2xNxGxef/W2R0ax6ifTMTvyUknVkSVfb6SRdSRAHeFj
         6nIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:in-reply-to:references:from
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=N3Cp8i9JwEcJxG1B2UlqEvv+bqTEEpNWRZZ63pk+CpQ=;
        b=PSGC4YdRHWRSATvoxi9IKUyeftFKA/TCtXw56lWzBtAQht0wSxD/tMrAuLLdA46RIf
         4Y+ThAlRdmz0vNskV/HpjW0VWg64fs8hTmluhM7mLzqlk0qkZucMIyxMf0swyxwaS8K5
         Ycj+oXoy5AzK0f+ZGMyk8phd7QDwHUVP6O+z3W+GWA2tqqEnPOZGA3kOi1QOmeI1HEO/
         iUcTStbNUvScBsSIps0Q/8VcC2CWZY2ciDi7qp242H1Aiyduq+MjfcD8cSBs6TULLhTx
         D7sXAftPNmACxF+HGEq6Jl1jjeD04PdUhPbmItWn452cvARM/ohY+Rv5Pwiw5McFccLe
         odxw==
X-Gm-Message-State: APjAAAVZObUHzI3N4RR3beZSvNUXTwVgvKZEI1fcYdS8F0QpxOGCnroH
        t3Ti6P2KUajJCV8gz4W+vaC7esJNWPc=
X-Google-Smtp-Source: APXvYqztebDGElg2SutsH6P3Rm1y+FVHOaodBsZdZVJVHboAAfFVyAP6IgaYkTaZE21P9qoVfiEHsQ==
X-Received: by 2002:a50:8ed8:: with SMTP id x24mr130719884edx.183.1559047336738;
        Tue, 28 May 2019 05:42:16 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e10sm418513eja.78.2019.05.28.05.42.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 05:42:16 -0700 (PDT)
Date:   Tue, 28 May 2019 05:42:16 -0700 (PDT)
X-Google-Original-Date: Tue, 28 May 2019 12:42:13 GMT
Message-Id: <363da05a66360d2b5f31391878f08dcf81b04915.1559047333.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.227.git.gitgitgadget@gmail.com>
References: <pull.227.git.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Subject: [PATCH 3/3] rebase docs: recommend `-r` over `-p`
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

The `--preserve-merges` option is now deprecated in favor of
`--rebase-merges`; Let's stop recommending the former.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-rebase.txt | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index f5e6ae3907..5e4e927647 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -675,7 +675,8 @@ $ git rebase -i HEAD~5
 
 And move the first patch to the end of the list.
 
-You might want to preserve merges, if you have a history like this:
+You might want to recreate merge commits, e.g. if you have a history
+like this:
 
 ------------------
            X
@@ -689,7 +690,7 @@ Suppose you want to rebase the side branch starting at "A" to "Q". Make
 sure that the current HEAD is "B", and call
 
 -----------------------------
-$ git rebase -i -p --onto Q O
+$ git rebase -i -r --onto Q O
 -----------------------------
 
 Reordering and editing commits usually creates untested intermediate
-- 
gitgitgadget
