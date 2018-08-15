Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD541F404
	for <e@80x24.org>; Wed, 15 Aug 2018 09:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729001AbeHOMbR (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Aug 2018 08:31:17 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:17008 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728668AbeHOMbQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Aug 2018 08:31:16 -0400
Received: from lindisfarne.localdomain ([92.22.33.100])
        by smtp.talktalk.net with SMTP
        id psHGfwZmBoI6LpsHLf4aEe; Wed, 15 Aug 2018 10:39:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1534325988;
        bh=25Fo+o00fHxPDBl/QvhauA8rJZLVjR2GkG8uXt5WY/I=;
        h=From:To:Cc:Subject:Date:Reply-To;
        b=RfzpUCj1NtwSS6dFUpBkRR0TpD830xMAYuaIiN78pP2e7Hs0REKmEu5WGY78nSEFh
         aQ7RPhsfxZ/LGo1euZ6IBwUgvkdvJ137FDGYlqV4jmP1I+srJyAwFlyOEB7ZNVdDic
         UzEBbTLR1a1mCZcswybCMTGdllYTfVCetzea30jw=
X-Originating-IP: [92.22.33.100]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=k9WtyX7eyn4O4XzWYcPtUg==:117
 a=k9WtyX7eyn4O4XzWYcPtUg==:17 a=evINK-nbAAAA:8 a=tU2l-bdFzLqM5LDv12gA:9
 a=RfR_gqz1fSpA9VikTjo0:22
From:   Phillip Wood <phillip.wood@talktalk.net>
To:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: [PATCH 0/2] rebase -i: fix SIGSEGV when 'merge <branch>' fails
Date:   Wed, 15 Aug 2018 10:39:33 +0100
Message-Id: <20180815093935.10222-1-phillip.wood@talktalk.net>
X-Mailer: git-send-email 2.18.0
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
X-CMAE-Envelope: MS4wfJ8vX9a/Vf9qDMZC39sEs7ZbkszV3SC1oSFaKMFrdiw3vAH4LnUutCXkzthaEfG8GyE9+VGlL/i5+e2CvpsY+8UABgiC8ple2J5+ljaX7zcqMdyv/DCJ
 KJz0AylZs4p6wg+2xcOZQ5esVxkobvmeH5fg8W/+7TWacGyQ5DVMtmIASWDye8Exxt0BMJupFf2t4Wi6oDMeifEAnbD7L+/a51Pzy9x6UxWvAWydnyflqtqL
 JVAad7CYHNAPcietxENz2bnSMGsjayQYiJytNM9c+7wLq1BzfY54ZqaA9Vg3l0Lv
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

As they fix a bug these patches are based on maint. Unfortunately
the second patch has semantic conflicts with master

s/git_path_merge_msg()/git_path_merge_msg(the_repository)/

There are additional textual conflicts with pu/next due to some
messages being marked for translation. The new message here should be
marked for translation to match them.

Phillip Wood (2):
  t3430: add conflicting commit
  rebase -i: fix SIGSEGV when 'merge <branch>' fails

 sequencer.c              | 24 +++++++++++++++++++-----
 t/t3430-rebase-merges.sh | 30 +++++++++++++++++++++++-------
 2 files changed, 42 insertions(+), 12 deletions(-)

-- 
2.18.0

