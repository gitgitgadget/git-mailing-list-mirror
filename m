Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA6391F404
	for <e@80x24.org>; Tue,  4 Sep 2018 18:04:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727662AbeIDWa2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Sep 2018 18:30:28 -0400
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:46581 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbeIDWa2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Sep 2018 18:30:28 -0400
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180904180415.EYFS4167.fed1rmfepo201.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Tue, 4 Sep 2018 14:04:15 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo210.cox.net with cox
        id XW4E1y00z59yGBo01W4FAd; Tue, 04 Sep 2018 14:04:15 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020C.5B8EC91F.0048,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=eOZjtDh1 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=pGLkceISAAAA:8 a=FjUCcwsbvC5fe45qh3EA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id B03DF29A00F6;
        Tue,  4 Sep 2018 11:04:14 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: test files with same names?
Date:   Tue, 04 Sep 2018 11:04:14 -0700
Message-ID: <2293750.yp9BkL5mAn@thunderbird>
Organization: Personal
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I don't mind doing this.

On Tuesday, September 4, 2018 10:27:26 AM MST Junio C Hamano wrote:
> Duy Nguyen <pclouds@gmail.com> writes:
> > t2000-checkout-cache-clash.sh
> > t2001-checkout-cache-clash.sh
> 
> These date back to 368f99d5 ("[PATCH 2/2] The core GIT tests: recent
> additions and fixes.", 2005-05-13) which later were renamed by
> f50c9f76 ("Rename some test scripts and describe the naming
> convention", 2005-05-15).  One was about checking out a regular file
> to a path where a directory currently sits, and the other is about
> checking out a regular file that requires a parent directory at a
> path where a regular file currently occupies.  These days, I suspect
> that we would make these into a single "d/f conflict when checking
> files out" test script, and f50c9f76 might have been a good chance
> to do such a clean-up.  If somebody cares deeply enough, I do not
> mind seeing a belated clean-up, either.
> 
> > t7500-commit.sh
> > t7501-commit.sh
> > t7502-commit.sh
> > t7509-commit.sh
> 
> These seem to have organically grown and it is very likely that ones
> later introduced were added more from laziness.
> 
> If somebody wants to clean them up, probably the first thing to do
> is to study them to come up with a clear $test_description for each
> of them.  I think t7509 says --reset-author and it may have started
> as a test on that single feature, but it now covers other ways to
> set and/or preserve authorship information, so it may make sense to
> update its $test_description to "commit authorship" or something,
> for example.




