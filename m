From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add a local implementation of hstrerror for the system
 which do not have it
Date: Mon, 18 Jun 2007 16:53:24 -0500
Message-ID: <4676FED4.70905@nrlssc.navy.mil>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home> <4676F8EA.1030305@nrlssc.navy.mil> <20070618213749.GB16397@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:54:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0PAe-0004IG-7a
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:54:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765276AbXFRVxe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765186AbXFRVxe
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:53:34 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57731 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765119AbXFRVxc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:53:32 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l5ILrIJA010812;
	Mon, 18 Jun 2007 16:53:21 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Jun 2007 16:53:24 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070618213749.GB16397@steel.home>
X-OriginalArrivalTime: 18 Jun 2007 21:53:24.0732 (UTC) FILETIME=[185DD3C0:01C7B1F3]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15240001
X-TM-AS-Result: : Yes--8.642200-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDQ3?=
	=?us-ascii?B?MDktNzAwMDc1LTEzOTAxMC03MDA0MTItNzA4Nzk3LTcwNjUzOC03?=
	=?us-ascii?B?MDE5MTQtNzAxMjQ5LTcwNjcxOS03MTAwNzgtNzAwOTcwLTcwMDEw?=
	=?us-ascii?B?Ny03MDk1ODQtNzAzNzEyLTE0ODA1MS0yMDA0Mi0xNTkxMy0xNTkx?=
	=?us-ascii?B?NA==?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50419>

Alex Riesen wrote:
> Brandon Casey, Mon, Jun 18, 2007 23:28:10 +0200:
>> Alex Riesen wrote:
>>> The function converts the value of h_errno (last error of name
>>> resolver library, see netdb.h). One of systems which supposedly do
>>> not have the function is SunOS. POSIX does not mandate its presence.
>> I saw a comment on another mailing list that hstrerror() is in the
>> resolv library.
>>
>>    So adding -lresolv should do it.
>>
>> A quick compile works for my test program.
>>
> 
> Ah-ha. Good to know, thanks!
> 
> Still, the patch is correct: no need for hstrerror there.

I see, right, just the NO_IPV6 case.

-brandon
