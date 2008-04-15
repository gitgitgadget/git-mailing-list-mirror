From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 22:51:49 +0200
Message-ID: <200804152251.51308.rjw@sisk.pl>
References: <47FEADCB.7070104@rtr.ca> <517f3f820804150254w491cdf85s28f1d15696db8d96@mail.gmail.com> <4804B5D5.4090404@davidnewall.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Michael Kerrisk <mtk.manpages@gmail.com>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	Tilman Schmidt <tilman@imap.cc>, Valdis.Kletnieks@vt.edu,
	Mark Lord <lkml@rtr.ca>, David Miller <davem@davemloft.net>,
	jesper.juhl@gmail.com, yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: David Newall <davidn@davidnewall.com>
X-From: netdev-owner@vger.kernel.org Tue Apr 15 22:54:18 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jls8c-0001oN-Go
	for linux-netdev-2@gmane.org; Tue, 15 Apr 2008 22:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYDOUv1 (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Tue, 15 Apr 2008 16:51:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753929AbYDOUv1
	(ORCPT <rfc822;netdev-outgoing>); Tue, 15 Apr 2008 16:51:27 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:52052 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbYDOUvZ (ORCPT <rfc822;netdev@vger.kernel.org>);
	Tue, 15 Apr 2008 16:51:25 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id F012AA5622;
	Tue, 15 Apr 2008 22:03:12 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 26726-08-2; Tue, 15 Apr 2008 22:03:00 +0200 (CEST)
Received: from [192.168.100.119] (nat-be3.aster.pl [212.76.37.200])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 5C618A5878;
	Tue, 15 Apr 2008 22:02:53 +0200 (CEST)
User-Agent: KMail/1.9.6 (enterprise 20070904.708012)
In-Reply-To: <4804B5D5.4090404@davidnewall.com>
Content-Disposition: inline
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79626>

On Tuesday, 15 of April 2008, David Newall wrote:
> Michael Kerrisk wrote:
> > On 4/15/08, David Newall <davidn@davidnewall.com> wrote:
> >   
> >> James Morris wrote:
> >>  > I don't know how to solve this, but suspect that encouraging the use of
> >>  > reviewed-by and also including it in things like analysis of who is
> >>  > contributing, selection for kernel summit invitations etc. would be a
> >>  > start.  At least, better than nothing.
> >>
> >> Would it be hard to keep count of the number of errors introduced by
> >>  author and reviewer?
> >>     
> >
> > I've found quite a few errors in kernel-userland APIs, but I'm not
> > sure that this sort of negative statistic would be helpful -- e.g.,
> > more productive developers probably also introduce more errors.
> 
> We can already see which developers are more active.  What we can't see
> is who is careless, which would be useful to know.  It would also be
> useful to know who is careless in approving changes, because they share
> responsibility for those changes.  It would be a good thing if this
> highlighted that some people are behind frequent buggy changes.

Well, even if someone introduces bugs relatively frequently, but then also
works with the reporters and fixes the bugs timely, it's about okay IMO.

The real problem is when patch submitters don't care for their changes any
more once the patches have been merged.

Thanks,
Rafael
