From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: auto gc again
Date: Wed, 19 Mar 2008 16:27:28 -0500
Message-ID: <47E18540.4020908@nrlssc.navy.mil>
References: <20080318180118.GC17940@kernel.dk> <alpine.LFD.1.00.0803181112270.3020@woody.linux-foundation.org> <20080318181948.GH17940@kernel.dk> <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jens Axboe <jens.axboe@oracle.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Mar 19 22:32:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5tQ-0007D0-RO
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 22:32:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932370AbYCSV2l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 17:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757339AbYCSV2i
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 17:28:38 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:58749 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764037AbYCSV2f (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 17:28:35 -0400
Received: from starfish.gems.nrlssc.navy.mil (localhost [127.0.0.1])
	by mail.nrlssc.navy.mil (8.13.7/8.13.7) with ESMTP id m2JLRT4Q002340;
	Wed, 19 Mar 2008 16:27:29 -0500
Received: from tick.nrlssc.navy.mil ([128.160.25.48]) by starfish.gems.nrlssc.navy.mil with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 19 Mar 2008 16:27:29 -0500
User-Agent: Thunderbird 2.0.0.9 (X11/20071031)
In-Reply-To: <alpine.LFD.1.00.0803191629240.2947@xanadu.home>
X-OriginalArrivalTime: 19 Mar 2008 21:27:29.0282 (UTC) FILETIME=[08D83E20:01C88A08]
X-TM-AS-Product-Ver: : ISVW-6.0.0.2339-5.0.0.1023-15792001
X-TM-AS-Result: : Yes--9.081000-0-31-1
X-TM-AS-Category-Info: : 31:0.000000
X-TM-AS-MatchedID: : =?us-ascii?B?MTUwNTY3LTcwMDA3NS0xMzkw?=
	=?us-ascii?B?MTAtNzA0ODUyLTcwOTU4NC0xMjExMTMtNzAxMzM5LTcwMjkyMC03?=
	=?us-ascii?B?MDQ5ODMtNzExMjQ4LTcwNDA0OS03MDIzNTgtNzAyMDQ0LTcwMTU5?=
	=?us-ascii?B?NC03MDQ5MjctNzA2NTY0LTcwMTgzNy03MDM1NDMtNzAzNzEyLTE0?=
	=?us-ascii?B?ODAzOS0xNDgwNTEtMjAwNDA=?=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77559>

Nicolas Pitre wrote:
> On Tue, 18 Mar 2008, Jens Axboe wrote:
> 
>> But freshly pulled repo, git auto gc is enabled. And that is my main
>> annoyance, I just don't think that type of policy should be in there.
> 
> Just do this once:
> 
> 	git config --global gc.auto 0
> 	git config --global gc.autopacklimit 0

Is there any reason why gc.auto=0 couldn't be used to disable auto
packing entirely?

Said differently, are there valid use cases where one might want automatic
repacking based on the number of packs but _not_ based on the number of
loose objects?

If the answer is "no", then "gc.auto=0 means completely disable auto-gc"
seems intuitive and would have protected Jens in this case.

-brandon
