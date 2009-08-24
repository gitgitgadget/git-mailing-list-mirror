From: Sanjiv Gupta <sanjiv.gupta@microchip.com>
Subject: Re: Pulling one commit at a time.
Date: Tue, 25 Aug 2009 00:38:19 +0530
Message-ID: <4A92E523.50504@microchip.com>
References: <F536B7C316F9474E9F7091239725AC9A02FA7F44@CHN-CL-MAIL01.mchp-main.com> 	<4A9172D0.6030507@microchip.com> <20090824060710.6117@nanako3.lavabit.com> 	<4A92318F.6050105@microchip.com> <32541b130908241119t1b969d30q8c8b484481f30ace@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 24 21:08:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MfeuN-00052F-3k
	for gcvg-git-2@lo.gmane.org; Mon, 24 Aug 2009 21:08:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753342AbZHXTIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2009 15:08:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753337AbZHXTIV
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Aug 2009 15:08:21 -0400
Received: from smtp02.microchip.com ([198.175.253.48]:40515 "EHLO
	smtp02.microchip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753211AbZHXTIU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2009 15:08:20 -0400
Received: from CHN-CL-MAIL01.mchp-main.com ([10.10.76.21]) by smtp02.microchip.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 12:08:23 -0700
Received: from [10.41.200.168] ([10.41.200.168]) by CHN-CL-MAIL01.mchp-main.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 24 Aug 2009 12:08:22 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <32541b130908241119t1b969d30q8c8b484481f30ace@mail.gmail.com>
X-OriginalArrivalTime: 24 Aug 2009 19:08:22.0628 (UTC) FILETIME=[3FE52A40:01CA24EE]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126959>

Avery Pennarun wrote:
> On Mon, Aug 24, 2009 at 6:22 AM, Sanjiv Gupta<sanjiv.gupta@microchip.com> wrote:
>   
>> Excellent description. Thanks for that. I want to merge commits one by one
>> because I want to run a regression suite on each commit and therefore know
>> if any one is causing failures.
>>     
>
> Hi Sanjiv,
>
> 'git bisect' is an even better way to do this, in my experience.  I
> wrote a program (http://github.com/apenwarr/gitbuilder/) that
> automatically runs regression tests against all the new versions on
> all the new branches.  It then publishes the results on a web page and
> via RSS.
>
> gitbuilder does take a shortcut: if commit x passes and commit x+10
> passes, it doesn't bother to test commit x+1..9.  
Even, I won't need to run in between commits in that case.
What I wanted to do is to
1. off load this job to a script which sends an email to the developer 
who broke something,
2. schedule that script
3. and sit back relaxed myself.

Looks like you already have the tool. Thanks.

BTW, git is not git, it's great.

thanks to everybody who replied.
- Sanjiv

> However, if x+10
> fails, it bisects automatically to find the first commit that caused a
> failure.  You could disable this shortcut easily enough, however.
>
> Have fun,
>
> Avery
>   
