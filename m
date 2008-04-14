From: Adrian Bunk <bunk@kernel.org>
Subject: Re: Reporting bugs and bisection
Date: Mon, 14 Apr 2008 15:08:21 +0300
Message-ID: <20080414120821.GA4625@cs181133002.pp.htv.fi>
References: <20080413202118.GA29658@2ka.mipt.ru> <200804132233.50491.rjw@sisk.pl> <20080413205406.GA9190@2ka.mipt.ru> <48028830.6020703@earthlink.net> <alpine.DEB.1.10.0804131546370.9318@asgard> <20080414043939.GA6862@1wt.eu> <20080414053943.GU9785@ZenIV.linux.org.uk> <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <20080414010412.c42dc560.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Al Viro <viro@ZenIV.linux.org.uk>, Willy Tarreau <w@1wt.eu>,
	david@lang.hm, Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: netdev-owner@vger.kernel.org Mon Apr 14 14:10:21 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlNVj-0005cd-P9
	for linux-netdev-2@gmane.org; Mon, 14 Apr 2008 14:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYDNMJ1 (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Mon, 14 Apr 2008 08:09:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754018AbYDNMJ1
	(ORCPT <rfc822;netdev-outgoing>); Mon, 14 Apr 2008 08:09:27 -0400
Received: from smtp6.pp.htv.fi ([213.243.153.40]:33727 "EHLO smtp6.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753823AbYDNMJ0 (ORCPT <rfc822;netdev@vger.kernel.org>);
	Mon, 14 Apr 2008 08:09:26 -0400
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 966DA5BC03B;
	Mon, 14 Apr 2008 15:09:24 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <20080414010412.c42dc560.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79500>

On Mon, Apr 14, 2008 at 01:04:12AM -0700, Andrew Morton wrote:
>...
> (And I don't think developers and maintainers _should_ spend time mucking
> in bug-tracking systems.  They should have helpers who do all the
> triaging/tracking/routing/closing work for them, and then provide other
> developers with the results, letting them know what they should be spending
> time on.  But there's a manpower problem).
>...

Speaking as the one who was for a few years going again and again 
through all open bugs in the kernel Bugzilla:

The manpower problem isn't in handling the bugs in Bugzilla.

I'd claim that even if all bugs in the kernel would be reported in the 
kernel Bugzilla I alone would be able to do all the handling of incoming 
bugs, bug forwarding and doing all the cleanup stuff like asking 
submitters whether a bug is still present in the latest kernel.

The manpower problem is at the developers and maintainers who could 
actually debug the problems.

One problem are unmaintained areas.
Do we have anyone who would debug e.g. APM bugs?
And if I want to be really nasty, I'll ask whether we have anyone who 
understands our floppy driver...  ;)

And who would debug problems with old and unmaintained drivers, e.g. 
some old net or SCSI driver?

Note that I do not blame James or Jeff or whoever else for the latter - 
they might simply not have the time to spend a day or two for debugging 
some obscure problem on some obscure hardware.

And it could happen everywhere that maintainers simply don't have 
the time to cope with all incoming bug reports.

We have many people who write new bugs^Wcode.
But too few people who review code.
And too few people willing to maintain the existing code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

