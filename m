From: david@lang.hm
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 20:53:27 -0700 (PDT)
Message-ID: <alpine.DEB.1.10.0804152042320.15483@asgard>
References: <47FEADCB.7070104@rtr.ca> <517f3f820804150254w491cdf85s28f1d15696db8d96@mail.gmail.com> <4804B5D5.4090404@davidnewall.com> <200804152251.51308.rjw@sisk.pl> <480565D3.6000100@davidnewall.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>,
	Michael Kerrisk <mtk.manpages@gmail.com>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: David Newall <davidn@davidnewall.com>
X-From: netdev-owner@vger.kernel.org Wed Apr 16 06:31:03 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jlyez-0004Z3-5f
	for linux-netdev-2@gmane.org; Wed, 16 Apr 2008 05:50:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345AbYDPDs5 (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Tue, 15 Apr 2008 23:48:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754441AbYDPDs5
	(ORCPT <rfc822;netdev-outgoing>); Tue, 15 Apr 2008 23:48:57 -0400
Received: from mail.lang.hm ([64.81.33.126]:49333 "EHLO bifrost.lang.hm"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754435AbYDPDs4 (ORCPT <rfc822;netdev@vger.kernel.org>);
	Tue, 15 Apr 2008 23:48:56 -0400
Received: from asgard.lang.hm (asgard.lang.hm [10.0.0.100])
	by bifrost.lang.hm (8.13.4/8.13.4/Debian-3) with ESMTP id m3G3lTj8021912;
	Tue, 15 Apr 2008 20:47:30 -0700
X-X-Sender: dlang@asgard
In-Reply-To: <480565D3.6000100@davidnewall.com>
User-Agent: Alpine 1.10 (DEB 962 2008-03-14)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79649>

On Wed, 16 Apr 2008, David Newall wrote:

> Rafael J. Wysocki wrote:
>> Well, even if someone introduces bugs relatively frequently, but then also
>> works with the reporters and fixes the bugs timely, it's about okay IMO.
>>
> This really is not okay.  Even if bugs are fixed a version or two later,
> the impact those bugs have on users makes the system look bad and drives
> them away.  We do not, I believe, want Linux to top the list for "most
> bugs".  It's unprofessional, unreliable and quite undesirable.

timely frequently means the code was merged in -rc1/2 and was fixed before 
the final release of the same version.

given the huge variety of hardware and workloads, it's just too easy for 
there to be cases where any trade-off you make (code size, performance, 
memory usage, common case definitions) can turn around and bite you. In 
addition frequently hardware doesn't work quite the way the design specs 
say that it should (completely ignoring the fact that many drivers are 
reverse engineered). what's most important is that when a case shows up it 
gets addressed promptly

I'd rather have a developer/maintainer who introduces and fixed 100 bug, 
but fixes them promptly, as opposed to one who only introduces one bug, 
but refuses to consider fixing the code 'because they don't make mistakes 
like that' (usadly a common attitude from people who produce very 
good code much of the time)

best of all is a developer/maintainer who writes very good code and is 
willing to accept the fact that they make mistakes and fixes the code 
promptly, but those people are extremely rare, and usually they emerge 
from the pool of people who make more mistakes and fix them promptly, 
which is an added reason I'm more tolerant of that group.

David Lang
