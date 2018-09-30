Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FB91F453
	for <e@80x24.org>; Sun, 30 Sep 2018 14:12:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeI3UqB (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Sep 2018 16:46:01 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:41376 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726816AbeI3UqB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Sep 2018 16:46:01 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180930141246.TOGW4136.fed1rmfepo103.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Sun, 30 Sep 2018 10:12:46 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id hqCm1y00C59yGBo01qCmn5; Sun, 30 Sep 2018 10:12:46 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090212.5BB0D9DE.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=PcRLeRpd c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10 a=xXuUxmRQGS_YGPWe0osA:9
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 35D8829A00F4;
        Sun, 30 Sep 2018 07:12:46 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git List <git@vger.kernel.org>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 0/1] wt-status-state-cleanup
Date:   Sun, 30 Sep 2018 07:12:44 -0700
Message-Id: <20180930141246.19651-1-ischis2@cox.net>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <CAPig+cTm_Fb9xFend5UF2TAx+5M6+siseRDVEAVGYUodjBAMRg@mail.gmail.com>
References: <CAPig+cTm_Fb9xFend5UF2TAx+5M6+siseRDVEAVGYUodjBAMRg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio suggested a cleanup patch, jc/wt-status-state-cleanup, which is
the basis for this patch.

This patch uses ss/wt-status-committable.

Update to fix a spelling error in the commet message

Stephen P. Smith (1):
  roll wt_status_state into wt_status and populate in the collect phase

 builtin/commit.c |   3 ++
 wt-status.c      | 134 +++++++++++++++++++++--------------------------
 wt-status.h      |  38 +++++++-------
 3 files changed, 82 insertions(+), 93 deletions(-)

-- 
2.19.0

