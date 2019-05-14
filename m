Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 311221F4B6
	for <e@80x24.org>; Tue, 14 May 2019 15:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbfENPY6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 11:24:58 -0400
Received: from smtp-out-1.talktalk.net ([62.24.135.65]:10034 "EHLO
        smtp-out-1.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726084AbfENPY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 11:24:57 -0400
Received: from localhost.localdomain ([92.1.197.142])
        by smtp.talktalk.net with SMTP
        id QZIVhRxqmp7QXQZIWhXwXD; Tue, 14 May 2019 16:24:56 +0100
X-Originating-IP: [92.1.197.142]
X-Spam: 0
X-OAuthority: v=2.3 cv=drql9Go4 c=1 sm=1 tr=0 a=gH7h/AuSNjzKVpz8AWYPeg==:117
 a=gH7h/AuSNjzKVpz8AWYPeg==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19
 a=xtxXYLxNAAAA:8 a=REC4JAj3wfx6mZ0gcK4A:9 a=xts0dhWdiJbonKbuqhAr:22
 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
From:   Philip Oakley <philipoakley@iee.org>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH] git.c: show usage for accessing the git(1) help page
Date:   Tue, 14 May 2019 16:24:50 +0100
Message-Id: <20190514152450.15220-1-philipoakley@iee.org>
X-Mailer: git-send-email 2.21.0.windows.1.1517.gbad5f960a3.dirty
In-Reply-To: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
References: <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4wfHhQPyQD7QOrFZnnp4iLGLllYGd67+LMuKCA9MTgEKrsErnGDg0Fpk8YrDivhs/hhoa1iWexkhFlzVWMs995LaWMCkDlLkKWuSBz/+Pu3OzcOuvZgclK
 zKiyvodocqSI0UBQMBdXlDG4w530vEWnhKPrNNXARTS/ZvxXOl5d1nQ1v/yTFyMlUwcS/jpURB039/fF4cPBgqXlLFAOSAUacbwae22ynBhTxrxo7hO32bNe
 gfqTa7bIFxLc5WPFUrwg/FSHELob1uaSTGXNMmmzBNOtmfugHnvYUitgohyMiWb7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is not immediately obvious how to use the `git help` system
to show the git(1) page, with all its background and ccordinating
material, such as environment variables.

Let's simply list it as the last few words of the last usage line.

Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
This follows from the discussion <3cd065d1-9db5-f2e6-ddff-aa539746d45e@iee.org>
---
 git.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git.c b/git.c
index 2324ac0b7e..9a852b09c1 100644
--- a/git.c
+++ b/git.c
@@ -33,7 +33,7 @@ const char git_usage_string[] =
 const char git_more_info_string[] =
 	N_("'git help -a' and 'git help -g' list available subcommands and some\n"
 	   "concept guides. See 'git help <command>' or 'git help <concept>'\n"
-	   "to read about a specific subcommand or concept.");
+	   "to read about a specific subcommand or concept. Or use 'git help git'.");
 
 static int use_pager = -1;
 
-- 
2.21.0.windows.1.1517.gbad5f960a3.dirty

