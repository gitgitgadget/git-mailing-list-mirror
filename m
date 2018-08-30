Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C73D31F404
	for <e@80x24.org>; Thu, 30 Aug 2018 01:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbeH3F4W (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Aug 2018 01:56:22 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:39300 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbeH3F4V (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Aug 2018 01:56:21 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180830015638.ZAKT4167.fed1rmfepo201.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Wed, 29 Aug 2018 21:56:38 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id VDwc1y00f59yGBo01DwdeQ; Wed, 29 Aug 2018 21:56:37 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090208.5B874ED5.0073,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=M9I9E24s c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10 a=WDhBSedXqNQA:10
 a=686mCR5ySq1uq-XAPacA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id D109B29A0093
        for <git@vger.kernel.org>; Wed, 29 Aug 2018 18:56:36 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Git Mailing List <git@vger.kernel.org>
Subject: Missing Tagger Entry
Date:   Wed, 29 Aug 2018 18:56:36 -0700
Message-ID: <2548439.nLQp1kU402@thunderbird>
Organization: Personal
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I am getting the following warning when runing a git fsck command against tag 
v0.99.

$ git --version
git version 2.18.0

$ git fsck
checking object directories: 100% (256/256), done.
warning in tag d6602ec5194c87b0fc87103ca4d67251c76f233a: missingTaggerEntry: 
invalid format - expected 'tagger' line
Checking objects: 100% (254339/254339), done.
Checking connectivity: 254329, done.
	


