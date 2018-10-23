Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AB161F453
	for <e@80x24.org>; Tue, 23 Oct 2018 13:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeJWVny (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 17:43:54 -0400
Received: from fed1rmfepo102.cox.net ([68.230.241.144]:49412 "EHLO
        fed1rmfepo102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbeJWVny (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 17:43:54 -0400
Received: from fed1rmimpo305.cox.net ([68.230.241.173])
          by fed1rmfepo102.cox.net
          (InterMail vM.8.01.05.28 201-2260-151-171-20160122) with ESMTP
          id <20181023132027.MWAU4170.fed1rmfepo102.cox.net@fed1rmimpo305.cox.net>
          for <git@vger.kernel.org>; Tue, 23 Oct 2018 09:20:27 -0400
Received: from thunderbird.smith.home ([68.2.114.239])
        by fed1rmimpo305.cox.net with cox
        id r1LT1y00859yGBo011LT0h; Tue, 23 Oct 2018 09:20:27 -0400
X-CT-Class: Clean
X-CT-Score: 0.00
X-CT-RefID: str=0001.0A09020C.5BCF201B.0075,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CT-Spam: 0
X-Authority-Analysis: v=2.3 cv=TOXxtGta c=1 sm=1 tr=0
 a=BlDZPKRk22kUaIvSBqmi8w==:117 a=BlDZPKRk22kUaIvSBqmi8w==:17
 a=kj9zAlcOel0A:10 a=smKx5t2vBNcA:10 a=nHVxSsbvAAAA:8 a=oO1xZUEQ9IMcE5_a89AA:9
 a=CjuIK1q_8ugA:10 a=NZJ8GFk-Z7heW4sy7ZCy:22
X-CM-Score: 0.00
Authentication-Results: cox.net; auth=pass (LOGIN) smtp.auth=ischis2@cox.net
Received: from thunderbird.localnet (localhost [127.0.0.1])
        by thunderbird.smith.home (Postfix) with ESMTP id 274C429A00F7;
        Tue, 23 Oct 2018 06:20:27 -0700 (MST)
From:   Stephen Smith <ischis2@cox.net>
To:     Anton Serbulov via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Anton Serbulov <aserbulov@plesk.com>
Subject: Re: [PATCH 2/2] mingw: fix getcwd when the parent directory cannot be queried
Date:   Tue, 23 Oct 2018 06:20:27 -0700
Message-ID: <31438048.4iejHa56lk@thunderbird>
Organization: Personal
In-Reply-To: <6700297.8bfoVLpaf1@thunderbird>
References: <pull.54.git.gitgitgadget@gmail.com> <3e3b1c3b1ff3363b216574f09d2c9cf22d25ad30.1540291965.git.gitgitgadget@gmail.com> <6700297.8bfoVLpaf1@thunderbird>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tuesday, October 23, 2018 6:16:43 AM MST Stephen Smith wrote:
> On Tuesday, October 23, 2018 3:52:49 AM MST you wrote:
> > From: Anton Serbulov <aserbulov@plesk.com>
> > 
> > `GetLongPathName()` function may fail when it is unable to query
> > the parent directory of a path component to determine the long name
> > for that component. It happens, because of it uses `FindFirstFile()`
> 
> s/of it/it/
> 
> > function for each next short part of path. The `FindFirstFile()`
> > requires `List Directory` and `Synchronize` desired access for a calling
> > process.

BTW - It was "Stephen" that sent the email. :-)





