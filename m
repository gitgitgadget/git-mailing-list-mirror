From: David Newall <davidn@davidnewall.com>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 23:34:05 +0930
Message-ID: <4804B5D5.4090404@davidnewall.com>
References: <47FEADCB.7070104@rtr.ca> <20080413205406.GA9190@2ka.mipt.ru>	 <48028830.6020703@earthlink.net>	 <alpine.DEB.1.10.0804131546370.9318@asgard>	 <20080414043939.GA6862@1wt.eu>	 <20080414053943.GU9785@ZenIV.linux.org.uk>	 <20080413232441.e216a02c.akpm@linux-foundation.org>	 <20080414072328.GW9785@ZenIV.linux.org.uk>	 <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>	 <4804765B.2070300@davidnewall.com> <517f3f820804150254w491cdf85s28f1d15696db8d96@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Michael Kerrisk <mtk.manpages@gmail.com>
X-From: netdev-owner@vger.kernel.org Tue Apr 15 16:23:50 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jllme-0004Vr-VK
	for linux-netdev-2@gmane.org; Tue, 15 Apr 2008 16:05:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762196AbYDOOEH (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Tue, 15 Apr 2008 10:04:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758246AbYDOOEG
	(ORCPT <rfc822;netdev-outgoing>); Tue, 15 Apr 2008 10:04:06 -0400
Received: from eth7959.sa.adsl.internode.on.net ([150.101.82.22]:33110 "EHLO
	hawking.rebel.net.au" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754800AbYDOOEF (ORCPT
	<rfc822;netdev@vger.kernel.org>); Tue, 15 Apr 2008 10:04:05 -0400
Received: from [192.168.0.9] (ppp121-45-0-36.lns10.adl2.internode.on.net [::ffff:121.45.0.36])
  (AUTH: PLAIN davidn, SSL: TLSv1/SSLv3,256bits,AES256-SHA)
  by hawking.rebel.net.au with esmtp; Tue, 15 Apr 2008 23:34:00 +0930
  id 00394489.4804B5D0.000013E2
User-Agent: Thunderbird 2.0.0.12 (X11/20080227)
In-Reply-To: <517f3f820804150254w491cdf85s28f1d15696db8d96@mail.gmail.com>
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79601>

Michael Kerrisk wrote:
> On 4/15/08, David Newall <davidn@davidnewall.com> wrote:
>   
>> James Morris wrote:
>>  > I don't know how to solve this, but suspect that encouraging the use of
>>  > reviewed-by and also including it in things like analysis of who is
>>  > contributing, selection for kernel summit invitations etc. would be a
>>  > start.  At least, better than nothing.
>>
>> Would it be hard to keep count of the number of errors introduced by
>>  author and reviewer?
>>     
>
> I've found quite a few errors in kernel-userland APIs, but I'm not
> sure that this sort of negative statistic would be helpful -- e.g.,
> more productive developers probably also introduce more errors.

We can already see which developers are more active.  What we can't see
is who is careless, which would be useful to know.  It would also be
useful to know who is careless in approving changes, because they share
responsibility for those changes.  It would be a good thing if this
highlighted that some people are behind frequent buggy changes.
