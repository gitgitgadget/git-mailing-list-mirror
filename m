Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEBE1F404
	for <e@80x24.org>; Fri, 31 Aug 2018 05:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727230AbeHaJpX (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Aug 2018 05:45:23 -0400
Received: from fed1rmfepo202.cox.net ([68.230.241.147]:57502 "EHLO
        fed1rmfepo202.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727106AbeHaJpX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Aug 2018 05:45:23 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo202.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180831053935.YPTO21918.fed1rmfepo202.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Fri, 31 Aug 2018 01:39:35 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id Vhfa1y00N59yGBo01hfawD; Fri, 31 Aug 2018 01:39:34 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090205.5B88D497.0001,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Ip1uSP3g c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=hRt26KMdQgSuGMseVbMA:9
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.smith.home (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 3F22E29A00EB;
        Thu, 30 Aug 2018 22:39:34 -0700 (MST)
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "Stephen P. Smith" <ischis2@cox.net>
Subject: [PATCH 0/3] wt-status.c: commitable flag
Date:   Thu, 30 Aug 2018 22:39:18 -0700
Message-Id: <20180831053921.8083-1-ischis2@cox.net>
X-Mailer: git-send-email 2.18.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A couple of years ago, during a patch review Junio found that the
commitable bit as implemented in wt-status.c was broken.

Stephen P. Smith (3):
  Change tests from expecting to fail to expecting success.
  Add test for commit --dry-run --short.
  wt-status.c: Set the commitable flag in the collect phase.

 t/t7501-commit.sh | 14 ++++++++++++--
 wt-status.c       |  6 +++++-
 2 files changed, 17 insertions(+), 3 deletions(-)

-- 
2.18.0

