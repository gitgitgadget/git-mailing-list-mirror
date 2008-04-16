From: Stephen Clark <sclark46@earthlink.net>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 08:41:38 -0400
Message-ID: <4805F402.1020603@earthlink.net>
References: <47FEADCB.7070104@rtr.ca> <517f3f820804150254w491cdf85s28f1d15696db8d96@mail.gmail.com> <4804B5D5.4090404@davidnewall.com> <200804152251.51308.rjw@sisk.pl> <480565D3.6000100@davidnewall.com> <alpine.DEB.1.10.0804152042320.15483@asgard>
Reply-To: sclark46@earthlink.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Newall <davidn@davidnewall.com>,
	"Rafael J. Wysocki" <rjw@sisk.pl>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: david@lang.hm
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762870AbYDPMmq@vger.kernel.org Wed Apr 16 14:43:51 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762870AbYDPMmq@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jm6z8-0004Er-W0
	for glk-linux-kernel-3@gmane.org; Wed, 16 Apr 2008 14:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762870AbYDPMmq (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 16 Apr 2008 08:42:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757708AbYDPMmg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2008 08:42:36 -0400
Received: from elasmtp-junco.atl.sa.earthlink.net ([209.86.89.63]:46537 "EHLO
	elasmtp-junco.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755678AbYDPMmf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2008 08:42:35 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=earthlink.net;
  b=nrsN4sZoGNm0h0isHuYHvoFPzA4/77uOw7SMTa27uISrhrW7rUsSZ8rdCEJbOYWe;
  h=Received:Message-ID:Date:From:Reply-To:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Received: from [24.144.77.185] (helo=joker.seclark.com)
	by elasmtp-junco.atl.sa.earthlink.net with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.67)
	(envelope-from <sclark46@earthlink.net>)
	id 1Jm6xJ-0004w3-4m; Wed, 16 Apr 2008 08:41:41 -0400
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <alpine.DEB.1.10.0804152042320.15483@asgard>
X-ELNK-Trace: a437fbc6971e80f61aa676d7e74259b7b3291a7d08dfec79cb627b4d525c59a20cfef712fb0894c2350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.144.77.185
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79697>

david@lang.hm wrote:
> On Wed, 16 Apr 2008, David Newall wrote:
> 
>> Rafael J. Wysocki wrote:
>>> Well, even if someone introduces bugs relatively frequently, but then 
>>> also
>>> works with the reporters and fixes the bugs timely, it's about okay IMO.
>>>
>> This really is not okay.  Even if bugs are fixed a version or two later,
>> the impact those bugs have on users makes the system look bad and drives
>> them away.  We do not, I believe, want Linux to top the list for "most
>> bugs".  It's unprofessional, unreliable and quite undesirable.
> 
> timely frequently means the code was merged in -rc1/2 and was fixed 
> before the final release of the same version.
> 
> given the huge variety of hardware and workloads, it's just too easy for 
> there to be cases where any trade-off you make (code size, performance, 
> memory usage, common case definitions) can turn around and bite you. In 
> addition frequently hardware doesn't work quite the way the design specs 
> say that it should (completely ignoring the fact that many drivers are 
> reverse engineered). what's most important is that when a case shows up 
> it gets addressed promptly
> 
> I'd rather have a developer/maintainer who introduces and fixed 100 bug, 
> but fixes them promptly, as opposed to one who only introduces one bug, 
> but refuses to consider fixing the code 'because they don't make 
> mistakes like that' (usadly a common attitude from people who produce 
> very good code much of the time)
> 
> best of all is a developer/maintainer who writes very good code and is 
> willing to accept the fact that they make mistakes and fixes the code 
> promptly, but those people are extremely rare, and usually they emerge 
> from the pool of people who make more mistakes and fix them promptly, 
> which is an added reason I'm more tolerant of that group.
> 
> David Lang
> 
Having been a Linux user since the late 90's the problem I see is that
developers decide to re-design stuff that is already working and then things
that used to work don't work anymore.

Libata is a good example. I had an older laptop that eventually got working
again - but the old ide stuff wasn't studied enough to find out what had to be
brought forward and supported in libata.

Regards,
Steve
-- 

"They that give up essential liberty to obtain temporary safety,
deserve neither liberty nor safety."  (Ben Franklin)

"The course of history shows that as a government grows, liberty
decreases."  (Thomas Jefferson)
