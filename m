From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: "git-send-pack"
Date: Sat, 02 Jul 2005 10:48:29 -0700
Message-ID: <42C6D36D.4060006@zytor.com>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>	 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org>	 <42C482ED.1010306@zytor.com>	 <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>	 <42C5D553.80905@timesys.com>	 <Pine.LNX.4.58.0507011831060.2977@ppc970.osdl.org>	 <42C61351.10306@zytor.com>	 <Pine.LNX.4.58.0507012119360.3019@ppc970.osdl.org>	 <42C61818.30109@zytor.com>	 <Pine.LNX.4.58.0507021009580.3019@ppc970.osdl.org> <12c511ca05070210441c0d3a33@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@osdl.org>,
	Mike Taht <mike.taht@timesys.com>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 19:49:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dom7b-0003C1-Ak
	for gcvg-git@gmane.org; Sat, 02 Jul 2005 19:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVGBRt0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jul 2005 13:49:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261248AbVGBRt0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jul 2005 13:49:26 -0400
Received: from terminus.zytor.com ([209.128.68.124]:18911 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261246AbVGBRtM
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Jul 2005 13:49:12 -0400
Received: from [172.27.0.18] (c-67-180-239-42.hsd1.ca.comcast.net [67.180.239.42])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j62HmTPQ018895
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 2 Jul 2005 10:48:30 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.3 (X11/20050513)
X-Accept-Language: en-us, en
To: Tony Luck <tony.luck@gmail.com>
In-Reply-To: <12c511ca05070210441c0d3a33@mail.gmail.com>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=-0.9 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Tony Luck wrote:
> 
> At least part of the problem for kernel.org is that there around 50 repositories
> that are tracking the 2.6 kernel.  All of them have 50,000 objects that are
> duplicates of each other ... and a few hundred 'unique' objects that belong
> to just one repo, or are minimally shared.
> 
> If there was a way to specify an alternate repo, then a large GIT server like
> kernel.org could set up a "git-history"[1] repo which each of the hosted repos
> could point to.  Then a cron job could look for duplicates, and move them
> off to the history area.
> 

This is why I've been talking about a global object repository -- 
including the problems associated with them.  git as it currently stands 
permit a single global object store, *except* for the issue of duplicate 
tags.

	-hpa
