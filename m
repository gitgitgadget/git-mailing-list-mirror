Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AFD1F461
	for <e@80x24.org>; Wed, 15 May 2019 22:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726482AbfEOWrS (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 May 2019 18:47:18 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:43324 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726449AbfEOWrS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 May 2019 18:47:18 -0400
Received: from localhost.localdomain ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id R2g6hewKCnuQZR2g7h9y9P; Wed, 15 May 2019 23:47:16 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=echDgIMH c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=xtxXYLxNAAAA:8 a=Obkg1d1cbEzlLVj79PEA:9 a=xts0dhWdiJbonKbuqhAr:22
 a=pHzHmUro8NiASowvMSCR:22 a=n87TN5wuljxrRezIQYnT:22
From:   Philip Oakley <philipoakley@iee.org>
To:     Git List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v3 1/2] git.c: show usage for accessing the git(1) help page
Date:   Wed, 15 May 2019 23:47:08 +0100
Message-Id: <20190515224709.2936-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.1517.gbad5f960a3.dirty
In-Reply-To: <20190515224709.2936-1-philipoakley@iee.org>
References: <CAPig+cQ4FZeOxbVU-5qTrQm8Q-khwHuCwekAr-aGtbLKAVzY0Q@mail.gmail.com>
 <20190515224709.2936-1-philipoakley@iee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfJP3Xm/rQepz2PZMcLpa1bD8FemqzZABOL3jWxevi1RgP4Bd9VXYleowNzb8ScxMSz0xO9C5ZajyWUMJiPEgDGU3hSNprbrkrVT9DEAGGj5OQ7BjDwF9
 AxxWdIDb2gMm9Jaca4eEl9pOzGTbm4WZdkmvENlEc1Ash/0E/VmbXMjr7r5Rvff1KUgS6+hnWXM0LTIZtCxoPwMVmI42YDl+tgxb6bSYWRvT12vb2Pq3aXsA
 dbmf0Ghp74nANlekKFTa5ZG++xtajELRWb5mLopkGowk9HsXww4fKbaZnEcoByx9x2iRLdVTHuX79DsMiSh3thBUhn9mdBm84G6jSDAOKmxF8SlMPcmPE3yC
 hbYTiuKOxjJSUYrmzBkmGohB6Djtgw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not immediately obvious how to use the `git help` system to show
the git(1) page, with its overview and its background and coordinating
material, such as environment variables.

Let's simply list it as the last few words of the last usage line.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
This follows from the discussion <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
---
 git.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 2324ac0b7e..9e24de43d7 100644
--- a/git.c
+++ b/git.c
@@ -33,7 +33,8 @@ const char git_usage_string[] =
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
 	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
-	   "to read about a specific subcommand or concept.");
+	   "to read about a specific subcommand or concept.\n"
+	   "See 'git help git' for an overview of the system.");
 
 static int use_pager = -1;
 
-- 
2.21.0.windows.1.1517.gbad5f960a3.dirty

