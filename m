Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C1F91F6A9
	for <e@80x24.org>; Fri,  4 Jan 2019 13:03:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726712AbfADNDV (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Jan 2019 08:03:21 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:38549 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbfADNDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jan 2019 08:03:21 -0500
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190104130320.SPDE12708.fed1rmfepo102.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Fri, 4 Jan 2019 08:03:20 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 1AC85B82576;
        Fri,  4 Jan 2019 06:03:19 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5C2F5998.0008,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=NZRSKFL4 c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10
 a=KxJIi9MXGhmf0OHgJ3sA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   Stephen P Smith <ischis2@cox.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] Add 'human' date format
Date:   Fri, 04 Jan 2019 06:03:18 -0700
Message-ID: <4462659.Bys67ThUBR@thunderbird>
Organization: Personal
In-Reply-To: <20190104075034.GA26014@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net> <2637944.PqRbksyA0G@thunderbird> <20190104075034.GA26014@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, January 4, 2019 12:50:35 AM MST Jeff King wrote:
> On Thu, Jan 03, 2019 at 06:19:56AM -0700, Stephen P. Smith wrote:
> > 
> > I didn't see anything in the code which would prohibit setting something
> > like that.
> 
> Yeah, I don't think supporting that is too hard. I was thinking
> something like this:

I take it that if I update Linus's patch, I still keep Junio's and Linus' 
sign-off line for the purpose of the chain of custody?  Of should I use a 
second patch?

Just trying to follow the rules.
sps


