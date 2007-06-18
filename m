From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add a local implementation of hstrerror for the system
 which do not have it
Date: Mon, 18 Jun 2007 16:34:17 -0500
Message-ID: <4676FA59.5040602@nrlssc.navy.mil>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home> <4676F8EA.1030305@nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:34:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Orl-00081W-6N
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:34:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764763AbXFRVe1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763117AbXFRVe1
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:34:27 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:47050 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762146AbXFRVe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:34:26 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l5ILYB52010633;
	Mon, 18 Jun 2007 16:34:14 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Jun 2007 16:34:17 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <4676F8EA.1030305@nrlssc.navy.mil>
X-OriginalArrivalTime: 18 Jun 2007 21:34:17.0453 (UTC) FILETIME=[6C88F1D0:01C7B1F0]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15240001
X-TM-AS-Result: : Yes--8.352100-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDAw?=
	=?us-ascii?B?NzUtMTM5MDEwLTcwNDcwOS03MDg3OTctNzA2NTM4LTcwMTkxNC03?=
	=?us-ascii?B?MDEyNDktNzA2NzE5LTcxMDA3OC03MDA5NzAtNzAwNDgxLTEzOTcw?=
	=?us-ascii?B?My03MDc5MDQtMTg4MDE5LTcwMDk3MS0xNDgwNTEtMjAwNDItMTU5?=
	=?us-ascii?B?MTMtMTU5MTQ=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50415>

Brandon Casey wrote:
> Alex Riesen wrote:
>> The function converts the value of h_errno (last error of name
>> resolver library, see netdb.h). One of systems which supposedly do
>> not have the function is SunOS. POSIX does not mandate its presence.
> 
> I saw a comment on another mailing list that hstrerror() is in the
> resolv library.
> 
>    So adding -lresolv should do it.
> 
> A quick compile works for my test program.

Here's a SunOS5.9 man page for hstrerror:

http://bama.ua.edu/cgi-bin/man-cgi?hstrerror+3RESOLV

which shows:

    cc [ flag ... ] file ... -lresolv  -lsocket  -lnsl [ library ... ]

-brandon
