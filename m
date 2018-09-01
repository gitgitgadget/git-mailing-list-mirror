Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 92E571F404
	for <e@80x24.org>; Sat,  1 Sep 2018 23:53:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbeIBEGi (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 00:06:38 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:55711 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725898AbeIBEGi (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 00:06:38 -0400
Received: from fed1rmimpo209.cox.net ([68.230.241.160])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180901235257.INQU21918.fed1rmfepo202.cox.net@fed1rmimpo209.cox.net>
          for <git@vger.kernel.org>; Sat, 1 Sep 2018 19:52:57 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo209.cox.net with cox
        id WPsw1y00L59yGBo01PsxRJ; Sat, 01 Sep 2018 19:52:57 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090206.5B8B2659.001B,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=FPJr/6gs c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10 a=hRt26KMdQgSuGMseVbMA:9
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 5E84629A00EF;
        Sat,  1 Sep 2018 16:52:56 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/3] wt-status.c: commitable flag
Date:   Sat,  1 Sep 2018 16:52:53 -0700
Message-Id: <20180901235256.4260-1-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of years ago, during a patch review Junio found that the
commitable bit as implemented in wt-status.c was broken.

Stephen P. Smith (3):
  Move has_unmerged earlier in the file.
  Add test for commit --dry-run --short.
  wt-status.c: Set the commitable flag in the collect phase.

 t/t7501-commit.sh | 12 ++++++++++--
 wt-status.c       | 39 ++++++++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 17 deletions(-)

-- 
2.18.0

