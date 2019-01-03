Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2F271F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 13:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731334AbfACNUx (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 08:20:53 -0500
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:57710 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727175AbfACNUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 08:20:52 -0500
Received: from fed1rmimpo210.cox.net ([68.230.241.161])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20190103132050.VKWM12708.fed1rmfepo102.cox.net@fed1rmimpo210.cox.net>
          for <git@vger.kernel.org>; Thu, 3 Jan 2019 08:20:50 -0500
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 490D8B82571;
        Thu,  3 Jan 2019 06:20:50 -0700 (MST)
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090205.5C2E0C32.0069,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=JKOPTPCb c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=3JhidrIBZZsA:10 a=WDhBSedXqNQA:10
 a=VnBdPPu0nqa7nRbom8wA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
From:   "Stephen P. Smith" <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 3/3] t0006-date.sh: add `human` date format tests.
Date:   Thu, 03 Jan 2019 06:20:50 -0700
Message-ID: <7749329.coFLYGqBuQ@thunderbird>
Organization: Personal
In-Reply-To: <xmqqk1jmi6nn.fsf@gitster-ct.c.googlers.com>
References: <20181231003150.8031-1-ischis2@cox.net> <2832897.SWEsZI4Xea@thunderbird> <xmqqk1jmi6nn.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, January 2, 2019 11:42:20 PM MST Junio C Hamano wrote:
> > Are you suggesting that t4202-log.sh not be updated and that only and 
> > t7007- show.sh and t0006-date.sh updated?
> 
> I am saying that using "log -1" and "show" in different tests _only_
> for the value of "Date:" field does not buy us much.  And by unifying,
> I was hoping that the single helper can be placed in a common file
> that is dot-sourced by these three scripts more easily.

Thanks for the clarification.



