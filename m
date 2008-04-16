From: Adrian Bunk <bunk@kernel.org>
Subject: Re: Reporting bugs and bisection
Date: Thu, 17 Apr 2008 00:25:54 +0300
Message-ID: <20080416212554.GV1677@cs181133002.pp.htv.fi>
References: <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <4804765B.2070300@davidnewall.com> <bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com> <20080416132634.GA545@cs181133002.pp.htv.fi> <bd6139dc0804161239h17e79c70ta5e938619e5743c9@mail.gmail.com> <20080416201606.GS1677@cs181133002.pp.htv.fi> <20080416205333.GT1677@cs181133002.pp.htv.fi> <bd6139dc0804161405j28470914u488568b565b68a0b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	James Morris <jmorris@namei.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Andrew Morton <akpm@linux-foundation.org>,
	Willy Tarreau <w@1wt.eu>, david@lang.hm,
	Stephen Clark <sclark46@earthlink.net>,
	Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
	"Rafael J. Wysocki" <rjw@sisk.pl>, Tilman Schmidt <tilman@imap.cc>,
	Valdis.Kletnieks@vt.edu, Mark Lord <lkml@rtr.ca>,
	David Miller <davem@davemloft.net>, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	David Newall <davidn@davidnewall.com>
To: sverre@rabbelier.nl
X-From: netdev-owner@vger.kernel.org Wed Apr 16 23:27:27 2008
connect(): Connection refused
Return-path: <netdev-owner@vger.kernel.org>
Envelope-to: linux-netdev-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmF9Z-0000Zy-5B
	for linux-netdev-2@gmane.org; Wed, 16 Apr 2008 23:26:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753521AbYDPV0E (ORCPT <rfc822;linux-netdev-2@m.gmane.org>);
	Wed, 16 Apr 2008 17:26:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752816AbYDPV0D
	(ORCPT <rfc822;netdev-outgoing>); Wed, 16 Apr 2008 17:26:03 -0400
Received: from smtp4.pp.htv.fi ([213.243.153.38]:36858 "EHLO smtp4.pp.htv.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752591AbYDPV0B (ORCPT <rfc822;netdev@vger.kernel.org>);
	Wed, 16 Apr 2008 17:26:01 -0400
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp4.pp.htv.fi (Postfix) with ESMTP id 0C6775BC01E;
	Thu, 17 Apr 2008 00:26:00 +0300 (EEST)
Content-Disposition: inline
In-Reply-To: <bd6139dc0804161405j28470914u488568b565b68a0b@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: netdev-owner@vger.kernel.org
Precedence: bulk
List-ID: <netdev.vger.kernel.org>
X-Mailing-List: netdev@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79756>

On Wed, Apr 16, 2008 at 11:05:17PM +0200, Sverre Rabbelier wrote:
> On Wed, Apr 16, 2008 at 10:53 PM, Adrian Bunk <bunk@kernel.org> wrote:
> >  To avoid any misunderstandings:
> >
> >  This is not in any way meant against you personally.
> 
> Thanks for pointing it out, I wasn't quite sure, but assumed that :).

Sorry, I was a bit overreacting since I see too often people putting 
some data into some statistics or graph and drawing conclusins without 
paying attention to whether their data allows these conclusions at all.

> >  But saying things like " X% of your commits introduced bugs" is not a
> >  friendly thing, and wrong data could be quite hurting.
> 
> Yes, it could be, and I agree that conclusions shouldn't be based on
> the details, but on the bigger picture. Also, I think it should (at
> first) be used mainly as an indicator, of where attention might be
> required. I mean, if it points out that one contributor almost always
> commits buggy code,

I would assume that in all projects the main maintainers already have an 
impression of how good the quality of the patches of each main 
contributor is.

In much more complex ways than a number could express.

> you don't have to present them with those
> statistics right away. Instead you can ask the program where it bases
> it's conclusions on, and research them yourself.

Sooner or later someone will run the program for the Linux kernel, 
write a paper about the results, and publish his research somewhere.

>...
> Cheers,
> 
> Sverre Rabbelier

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

