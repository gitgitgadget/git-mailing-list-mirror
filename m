Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF6B1F404
	for <e@80x24.org>; Sun,  2 Sep 2018 05:17:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbeIBJcP (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 05:32:15 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:44318 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726003AbeIBJcP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 05:32:15 -0400
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180902051744.GGUB4136.fed1rmfepo103.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Sun, 2 Sep 2018 01:17:44 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo210.cox.net with cox
        id WVHk1y00559yGBo01VHkjj; Sun, 02 Sep 2018 01:17:44 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020A.5B8B7278.002A,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=eOZjtDh1 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=LUTqltXlp5S_5v7zKl4A:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 03A0C29A00EF;
        Sat,  1 Sep 2018 22:17:44 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?ISO-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 2/3] Add test for commit --dry-run --short.
Date:   Sat, 01 Sep 2018 22:17:43 -0700
Message-ID: <3033920.bsSLEtmIa1@thunderbird>
Organization: Personal
References: <20180901235256.4260-1-ischis2@cox.net> <20180901235256.4260-3-ischis2@cox.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Saturday, September 1, 2018 7:18:34 PM MST Eric Sunshine wrote:
> > diff --git a/t/t7501-commit.sh b/t/t7501-commit.sh
> > @@ -682,4 +682,12 @@ test_expect_success '--dry-run with conflicts fixed
> > from a merge' ' +test_expect_failure '--dry-run --short' '
> > +       # setup two branches with conflicting information
> > +       # in the same file, resolve the conflict
> 
> What is this comment all about? It doesn't seem to have any relation
> to what the test itself is actually doing. (I see that it was copied
> from an earlier test in this script, but that doesn't help me
> understand what it is trying to say.)

Agreed.   

I saw your other email about not being worth a re-roll, but I've made the 
change locally in case Junio wants me to do so.  

Additionally if there are other comments I can wrap them into a single set.



