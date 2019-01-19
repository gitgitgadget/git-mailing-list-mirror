Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786931F453
	for <e@80x24.org>; Sat, 19 Jan 2019 03:44:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbfASDoh (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 Jan 2019 22:44:37 -0500
Received: from fed1rmfepo103.cox.net ([68.230.241.145]:55788 "EHLO
        fed1rmfepo103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730398AbfASDoh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jan 2019 22:44:37 -0500
Received: from fed1rmimpo109.cox.net ([68.230.241.158])
          by fed1rmfepo103.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190119034436.YOKW4136.fed1rmfepo103.cox.net@fed1rmimpo109.cox.net>
          for <git@vger.kernel.org>; Fri, 18 Jan 2019 22:44:36 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 4F7D2B82416;
        Fri, 18 Jan 2019 20:44:35 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090211.5C429D24.0004,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=OtL7NB3t c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10 a=kviXuzpPAAAA:8
 a=N8lvuTpQk6VGJmNFX3YA:9 a=CjuIK1q_8ugA:10 a=qrIFiuKZe2vaD64auk6j:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.org>,
        Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH v2 2/5] Remove the proposed use of auto as secondary way to specify human
Date:   Fri, 18 Jan 2019 20:44:34 -0700
Message-ID: <1639837.7qUrSqU32g@thunderbird>
Organization: Personal
In-Reply-To: <xmqq5zullsph.fsf@gitster-ct.c.googlers.com>
References: <20181231003150.8031-1-ischis2@cox.net> <20190118061805.19086-3-ischis2@cox.net> <xmqq5zullsph.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Friday, January 18, 2019 11:35:22 AM MST Junio C Hamano wrote:
> "Stephen P. Smith" <ischis2@cox.net> writes:
> I think doing two things in this step (i.e. reverting Linus's "auto"
> support from 1/5, and adding "auto" that is similar to color's auto)
> is OK, but then the title should list both.  It sounded like it was
> this step is doing only the former.

Will change as part of a re-roll.



