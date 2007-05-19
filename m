From: Brian Gernhardt <benji@silverinsanity.com>
Subject: Re: Commits gone AWOL, but not reported by git-fsck --unreachable
Date: Sat, 19 May 2007 13:13:47 -0400
Message-ID: <839C7D1E-E1D0-4EA1-8221-789C418CB242@silverinsanity.com>
References: <20070519103011.GU17511@curie-int.orbis-terrarum.net> <20070519115245.GA10035@coredump.intra.peff.net> <20070519120933.GW17511@curie-int.orbis-terrarum.net> <20070519121154.GA10268@coredump.intra.peff.net> <pan.2007.05.19.15.45.46@progsoc.org> <vpq646opzio.fsf@bauges.imag.fr> <A04FB6C2-20B2-4263-9D58-6C281C04C6C4@silverinsanity.com> <vpq8xbkoir8.fsf@bauges.imag.fr>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Anand Kumria <wildfire@progsoc.org>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sat May 19 19:13:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpSVD-00013W-Fo
	for gcvg-git@gmane.org; Sat, 19 May 2007 19:13:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754078AbXESRNx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 13:13:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXESRNx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 13:13:53 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:44085 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754078AbXESRNw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 13:13:52 -0400
Received: from [IPv6???1] (localhost [127.0.0.1])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTP id CFB201FFC03B;
	Sat, 19 May 2007 17:13:49 +0000 (UTC)
In-Reply-To: <vpq8xbkoir8.fsf@bauges.imag.fr>
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47759>


On May 19, 2007, at 12:55 PM, Matthieu Moy wrote:

> Brian Gernhardt <benji@silverinsanity.com> writes:
>
>> On May 19, 2007, at 12:08 PM, Matthieu Moy wrote:
>>
>>> The commit introducing it is  
>>> 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b,
>>> and I'd say it's in git 1.5.1:
>>>
>>> $ git-describe --tags 566842f62bdf1f16c2e94fb431445d2e6c0f3f0b
>>> v1.5.1-34-g566842f
>>
>> Actually, I think that means it's 34 commits *after* v1.5.1, not
>> before.  It's in 1.5.2-rc0, but none of the 1.5.1.* series.
>
> You're right. Then, is there any easy way to ask git the oldest tag(s)
> that a commit is an ancestor of? In other words, which command should
> I have typed above?

I did it the hard way with "git log v1.5.1..v.1.5.1.1", "..1.5.1.2",  
and using grep to look for 566842.  Anybody better at constructing  
these incantations want to chime in?

~~ Brian
