Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF5AA1F428
	for <e@80x24.org>; Mon,  3 Sep 2018 04:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbeICImK (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 04:42:10 -0400
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:60559 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbeICImK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 04:42:10 -0400
Received: from fed1rmimpo110.cox.net ([68.230.241.159])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180903042346.RNCR4163.fed1rmfepo203.cox.net@fed1rmimpo110.cox.net>
          for <git@vger.kernel.org>; Mon, 3 Sep 2018 00:23:46 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo110.cox.net with cox
        id WsPl1y00N59yGBo01sPms9; Mon, 03 Sep 2018 00:23:46 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090201.5B8CB752.0018,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=Zc1tDodA c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=JBFolyDoGHsA:10 a=WDhBSedXqNQA:10
 a=5rxgeBVgAAAA:8 a=_5pFr9p-j2jDCrpCHnYA:9 a=CjuIK1q_8ugA:10 a=u09W0hvIdLUA:10
 a=PwKx63F5tFurRwaNxrlG:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 7B35429A00F0;
        Sun,  2 Sep 2018 21:23:45 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2018, #06; Wed, 29)
Date:   Sun, 02 Sep 2018 21:23:45 -0700
Message-ID: <4712497.Q6PRmZFGHc@thunderbird>
Organization: Personal
In-Reply-To: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
References: <xmqqbm9kajhu.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wednesday, August 29, 2018 3:35:57 PM MST Junio C Hamano wrote:
> 
> * mk/use-size-t-in-zlib (2017-08-10) 1 commit
>  . zlib.c: use size_t for size
> 
>  The wrapper to call into zlib followed our long tradition to use
>  "unsigned long" for sizes of regions in memory, which have been
>  updated to use "size_t".
> 
>  Needs resurrecting by making sure the fix is good and still applies
>  (or adjusted to today's codebase).

This appears to be part of a large patch set. [1]  Does the entire patch set 
need revisiting or just the one for zlib.c?

sps

[1] https://public-inbox.org/git/1502914591-26215-1-git-send-email-martin@mail.zuhause/


