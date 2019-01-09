Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 013D91F803
	for <e@80x24.org>; Wed,  9 Jan 2019 00:44:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728642AbfAIAoC (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 19:44:02 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:42798 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727829AbfAIAoC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 19:44:02 -0500
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190109004402.PTVC4136.fed1rmfepo103.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Tue, 8 Jan 2019 19:44:02 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 2934EB82AC5;
        Tue,  8 Jan 2019 17:44:01 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020E.5C3543D1.0037,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=e8qytph/ c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=UCsaZMsR6JUBqvxAb-QA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Tue, 08 Jan 2019 17:44:00 -0700
Message-ID: <6530822.TNJIEUz5BA@thunderbird>
Organization: Personal
In-Reply-To: <a8a586d9-dad7-606f-948c-06725ac3e062@kdbg.org>
References: <20181231003150.8031-1-ischis2@cox.net> <20181231003150.8031-4-ischis2@cox.net> <a8a586d9-dad7-606f-948c-06725ac3e062@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, January 8, 2019 2:27:22 PM MST Johannes Sixt wrote:
> Am 31.12.18 um 01:31 schrieb Stephen P. Smith:
> > +
> > +TODAY_REGEX='[A-Z][a-z][a-z] [012][0-9]:[0-6][0-9] .0200'
<snip>
> The $...REGEX expansions must be put in double-quotes to protect them
> from field splitting. But then the tests do not pass anymore (I tested
> only t4202). Please revisit this change.
> 
> -- Hannes

I will later figure out why you are seeing the fields splitting but I am not.   
In the mean time I will change the quoting.

I started working on test updates based on prior comments this past weekend.

sps




