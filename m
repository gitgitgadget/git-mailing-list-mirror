Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-0.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: (qmail 7556 invoked by uid 107); 24 Aug 2009 10:49:59 -0000
Received: from vger.kernel.org (HELO vger.kernel.org) (209.132.176.167)
    by peff.net (qpsmtpd/0.40) with ESMTP; Mon, 24 Aug 2009 06:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751462AbZHXKtg (ORCPT <rfc822;peff@peff.net>);
	Mon, 24 Aug 2009 06:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbZHXKtg
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 06:49:36 -0400
Received: from smtp02.microchip.com ([198.175.253.48]:37884 "EHLO
	smtp02.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbZHXKtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 06:49:35 -0400
Received: from CHN-CL-MAIL01.mchp-main.com ([10.10.76.21]) by smtp02.microchip.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 03:49:38 -0700
Received: from [10.41.200.168] ([10.41.200.168]) by CHN-CL-MAIL01.mchp-main.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 03:49:36 -0700
Message-ID: <4A92703E.90007@microchip.com>
Date:	Mon, 24 Aug 2009 16:19:34 +0530
From:	Sanjiv Gupta <sanjiv.gupta@microchip.com>
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
MIME-Version: 1.0
To:	David Aguilar <davvid@gmail.com>
CC:	Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
Subject: Re: Pulling one commit at a time.
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com> <4A9172D0.6030507@microchip.com> <20090824060710.6117@nanako3.lavabit.com> <4A92318F.6050105@microchip.com> <20090824102242.GA70861@gmail.com>
In-Reply-To: <20090824102242.GA70861@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Aug 2009 10:49:37.0135 (UTC) FILETIME=[92E94FF0:01CA24A8]
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

David Aguilar wrote:
> On Mon, Aug 24, 2009 at 11:52:07AM +0530, Sanjiv Gupta wrote:
>   
>> Excellent description. Thanks for that. I want to merge commits one by  
>> one because I want to run a regression suite on each commit and  
>> therefore know if any one is causing failures.
>>     
>
> 'git bisect' is your friend.
>
> If your developers are disciplined and test each change as they
> commit it then you're going to have fewer problems.
>
> If they aren't, then make 'em send you patches.  Then you can
> at least 'git am' each one and run the tests at each step,
> including the critical steps where you merge various topics
> together.
>
> I'm not sure what exactly you're trying to accomplish, though.
> I'm just making guesses without you telling us more.
>
> Are you trying to do post-mortem change-that-introduced-bug
> finding (git bisect), commit-time bug prevention
> (patch-based workflows, using git commit hooks to disallow
> commits that fail the tests, etc), or is it something
> completely different?
>
>
> HTH,
>
>   
Thanks everyone for the overwhelming response.
I was looking for post-mortem change-that-introduced-bug.
It's also called "buildbot" in other terms, which sends you an email 
with the details of the "culprit" commit as soon as it introduces a bug.

- Sanjiv


-

