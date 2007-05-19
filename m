From: Junio C Hamano <junkio@cox.net>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 11:15:24 -0700
Message-ID: <7vfy5sy91f.fsf@assigned-by-dhcp.cox.net>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net>
	<20070519115245.GA10035@coredump.intra.peff.net>
	<20070519120933.GW17511@curie-int.orbis-terrarum.net>
	<20070519121154.GA10268@coredump.intra.peff.net>
	<pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr>
	<A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com>
	<vpq8xbkoir8.fsf@bauges.imag.fr>
	<839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sat May 19 20:15:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpTSq-0001Ck-Vq
	for gcvg-git@gmane.org; Sat, 19 May 2007 20:15:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756750AbXESSP1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 14:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757184AbXESSP1
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 14:15:27 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:59462 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756750AbXESSP0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 14:15:26 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519181525.KMZW2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sat, 19 May 2007 14:15:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 16FQ1X00K1kojtg0000000; Sat, 19 May 2007 14:15:25 -0400
In-Reply-To: <839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com> (Brian
	Gernhardt's message of "Sat, 19 May 2007 13:13:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47762>

Brian Gernhardt <benji@silverinsanity.com> writes:

> On May 19, 2007, at 12:55 PM, Matthieu Moy wrote:
>
>> Brian Gernhardt <benji@silverinsanity.com> writes:
>>
>>> On May 19, 2007, at 12:08 PM, Matthieu Moy wrote:
>>>
>>>> The commit introducing it is
>>>> 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b,
>>>> and I'd say it's in git 1.5.1:
>>>>
>>>> $ git-describe --tags 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b
>>>> v1.5.1-34-g566842f
>>>
>>> Actually, I think that means it's 34 commits *after* v1.5.1, not
>>> before.  It's in 1.5.2-rc0, but none of the 1.5.1.* series.
>>
>> You're right. Then, is there any easy way to ask git the oldest tag(s)
>> that a commit is an ancestor of? In other words, which command should
>> I have typed above?
>
> I did it the hard way with "git log v1.5.1..v.1.5.1.1", "..1.5.1.2",
> and using grep to look for 566842.  Anybody better at constructing
> these incantations want to chime in?

Perhaps "git-name-rev --refs='refs/tags/v*' $it"?
