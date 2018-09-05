Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39101F404
	for <e@80x24.org>; Wed,  5 Sep 2018 22:03:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727593AbeIFCgB (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Sep 2018 22:36:01 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:59059 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbeIFCgB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Sep 2018 22:36:01 -0400
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180905220347.IMIS4136.fed1rmfepo103.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Wed, 5 Sep 2018 18:03:47 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo305.cox.net with cox
        id Xy3m1y00T59yGBo01y3nxr; Wed, 05 Sep 2018 18:03:47 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090207.5B9052C3.0033,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=IdH3YSia c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=5rxgeBVgAAAA:8
 a=kviXuzpPAAAA:8 a=nR1l2SmUDYW9zJRNLwwA:9 a=CjuIK1q_8ugA:10 a=u09W0hvIdLUA:10
 a=PwKx63F5tFurRwaNxrlG:22 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id BED4F29A00F6;
        Wed,  5 Sep 2018 15:03:46 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: How to handle patch series conflicts
Date:   Wed, 05 Sep 2018 15:03:46 -0700
Message-ID: <6537729.UHPOpRP2X2@thunderbird>
Organization: Personal
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com> <32028230.38oFsPliiV@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, September 5, 2018 2:16:06 PM MST Junio C Hamano wrote:
> I think that one that is not even in 'pu' hasn't been looked at for
> a long time; it is probably a good idea to discard and replace, if
> you have something working.

I submitted [1] over the weekend.  I will add a spelling error patch and then 
submit version 3 hopefully before the end of the day.   I am working on the 
test rename, but will wait to submit until after the wt-status.c patches cook 
and then go to mainline.   Rationale:   I haven't yet gone through the commit 
scripts to decided on the best proposed names.

[1] https://public-inbox.org/git/20180901235256.4260-1-ischis2@cox.net/







