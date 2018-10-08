Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CF7F1F97E
	for <e@80x24.org>; Mon,  8 Oct 2018 01:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726715AbeJHIhw (ORCPT <rfc822;e@80x24.org>);
        Mon, 8 Oct 2018 04:37:52 -0400
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:54099 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725760AbeJHIhw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Oct 2018 04:37:52 -0400
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181008012839.NIVK4136.fed1rmfepo103.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Sun, 7 Oct 2018 21:28:39 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo109.cox.net with cox
        id kpUf1y00659yGBo01pUfJV; Sun, 07 Oct 2018 21:28:39 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5BBAB2C7.0021,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=FLWvONgs c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=smKx5t2vBNcA:10 a=WDhBSedXqNQA:10
 a=kviXuzpPAAAA:8 a=9ZYK22at6wtcaWhKDuEA:9 a=CjuIK1q_8ugA:10
 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 0371329A00EE;
        Sun,  7 Oct 2018 18:28:39 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: How to handle patch series conflicts
Date:   Sun, 07 Oct 2018 18:28:38 -0700
Message-ID: <2206767.tHxkKBSiVS@thunderbird>
Organization: Personal
In-Reply-To: <xmqq1sa74pd5.fsf@gitster-ct.c.googlers.com>
References: <CACsJy8B1UDN26tWPvOtixSBiFF6bYP2BtK2n1u4W-tWdVeKK1A@mail.gmail.com> <32028230.38oFsPliiV@thunderbird> <xmqq1sa74pd5.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, September 5, 2018 2:16:06 PM MST Junio C Hamano wrote:
> Stephen & Linda Smith <ischis2@cox.net> writes:
> > Junio -
> > 
> > On Tuesday, September 4, 2018 10:27:26 AM MST Junio C Hamano wrote:
> >> > t7500-commit.sh
> >> > t7501-commit.sh
> >> > t7502-commit.sh
> >> > t7509-commit.sh
> >> 
> >> These seem to have organically grown and it is very likely that ones
> >> later introduced were added more from laziness.

Junio - I've been working this but would like your opinion on 7500, 7501 and 
now 7510.     

I note that the the commit tests have intermixed functionality.  An example is 
signoff tests that are in the three tests I mentioned. 

I've been tempted multiple times over the last week to just merge the tests 
into a single script, but that doesn't seem right either.

So would you prefer a single script?   Would you prefer me to move tests 
around?

sps


