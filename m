Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADC2D1F954
	for <e@80x24.org>; Thu, 23 Aug 2018 01:28:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726261AbeHWEz3 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Aug 2018 00:55:29 -0400
Received: from fed1rmfepo203.cox.net ([68.230.241.148]:59324 "EHLO
        fed1rmfepo203.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbeHWEz3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Aug 2018 00:55:29 -0400
Received: from fed1rmimpo306.cox.net ([68.230.241.174])
          by fed1rmfepo203.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20180823012815.WVMD4163.fed1rmfepo203.cox.net@fed1rmimpo306.cox.net>
          for <git@vger.kernel.org>; Wed, 22 Aug 2018 21:28:15 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo306.cox.net with cox
        id SRUE1y00V59yGBo01RUFQY; Wed, 22 Aug 2018 21:28:15 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A090208.5B7E0DAF.000C,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.2 cv=IJpyMknG c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=x7bEGLp0ZPQA:10 a=dapMudl6Dx4A:10
 a=p8FZXJqfF5CFKBbYSHkA:9 a=CjuIK1q_8ugA:10
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 959B029A00E7;
        Wed, 22 Aug 2018 18:28:14 -0700 (MST)
From:   Stephen & Linda Smith <ischis2@cox.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] wt-status.c: set commitable bit if there is a meaningful merge.
Date:   Wed, 22 Aug 2018 18:28:14 -0700
Message-ID: <4269794.LOdZa0ZRjb@thunderbird>
Organization: Personal
References: <72756249.nAoBccgOj7@thunderbird> <28440975.G22uFktzHy@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > On Tuesday, February 16, 2016 8:33:54 PM MST Junio C Hamano wrote:
> Wow, that's quite an old discussion ;-)
It wasn't intended to be so

> After these:
<snip>
> tells me that "--short" still does not notice that there _is_
> something to be committed, either with an ancient version like
> v2.10.5 or more modern versions of Git.  The "long" version exits
> with 0, while "--short" one exists with 1.

$ git commit --dry-run --short; echo $?
A  a-new-file
0

$ git commit --dry-run --short; echo $?
A  a-new-file
1

> 
> So...?

For me it is the return code that is faulty  .... Starting to investigate.   
Thanks




