Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEF9B1F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 13:12:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730870AbfACNMG (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 08:12:06 -0500
Received: from fed1rmfepo201.cox.net ([68.230.241.146]:58845 "EHLO
        fed1rmfepo201.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730864AbfACNME (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 08:12:04 -0500
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo201.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190103131203.OQHH4108.fed1rmfepo201.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Thu, 3 Jan 2019 08:12:03 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id D7758B82571;
        Thu,  3 Jan 2019 06:12:02 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020F.5C2E0A23.0029,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=PIC7BsiC c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10
 a=LDTt_-Bv8LqR1hLLBKwA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Thu, 03 Jan 2019 06:12:02 -0700
Message-ID: <3321253.lROl3XOJ1W@thunderbird>
Organization: Personal
In-Reply-To: <20190103074421.GC24925@sigill.intra.peff.net>
References: <20181231003150.8031-1-ischis2@cox.net> <20181231003150.8031-4-ischis2@cox.net> <20190103074421.GC24925@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thursday, January 3, 2019 12:44:22 AM MST Jeff King wrote:
> We already have $TEST_DATE_NOW, which "test-tool date" will respect for
> various commands to pretend that it's currently a particular time. I
> think you'd need to add a sub-command similar to "relative" (which
> directly calls show_date_relative()) which calls into the "human" code.

I'll investigate.  Looks like this comment is related other comments.

> Note that there _isn't_ a way to have actual non-test git programs read
> the current time from an environment variable (as opposed to actually
> calling gettimeofday()).
Agreed

> 
> -Peff




