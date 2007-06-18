From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] Add a local implementation of hstrerror for the system
 which do not have it
Date: Mon, 18 Jun 2007 16:28:10 -0500
Message-ID: <4676F8EA.1030305@nrlssc.navy.mil>
References: <86ejkh40cr.fsf@blue.stonehenge.com> <20070612205210.GC2459@steel.home> <20070612213129.GD2459@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 18 23:28:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0Ols-0006la-FH
	for gcvg-git@gmane.org; Mon, 18 Jun 2007 23:28:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764623AbXFRV2T (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Jun 2007 17:28:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764618AbXFRV2T
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jun 2007 17:28:19 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:39513 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764602AbXFRV2S (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jun 2007 17:28:18 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id l5ILS4qG010557;
	Mon, 18 Jun 2007 16:28:06 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 18 Jun 2007 16:28:10 -0500
User-Agent: Thunderbird 2.0.0.0 (X11/20070326)
In-Reply-To: <20070612213129.GD2459@steel.home>
X-OriginalArrivalTime: 18 Jun 2007 21:28:10.0533 (UTC) FILETIME=[91D56550:01C7B1EF]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-3.6.0.1039-15240001
X-TM-AS-Result: : Yes--7.197700-0-4-1
X-TM-AS-Category-Info: : 4:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTE0NzAxOC03MDQ3?=
	=?us-ascii?B?MDktNzAwMDc1LTEzOTAxMC03MDg3OTctNzA2NTM4LTcwMTkxNC03?=
	=?us-ascii?B?MDEyNDktNzA2NzE5LTcxMDA3OC03MDA5NzAtMTQ4MDUxLTIwMDQw?=
	=?us-ascii?B?LTE1OTEzLTE1OTE0?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50413>

Alex Riesen wrote:
> The function converts the value of h_errno (last error of name
> resolver library, see netdb.h). One of systems which supposedly do
> not have the function is SunOS. POSIX does not mandate its presence.

I saw a comment on another mailing list that hstrerror() is in the
resolv library.

    So adding -lresolv should do it.

A quick compile works for my test program.

-brandon
