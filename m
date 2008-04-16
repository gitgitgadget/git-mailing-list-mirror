From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: Reporting bugs and bisection
Date: Wed, 16 Apr 2008 13:01:08 -0700
Organization: Intel
Message-ID: <20080416130108.4eda6c2c@laptopd505.fenrus.org>
References: <20080413205406.GA9190@2ka.mipt.ru>
	<48028830.6020703@earthlink.net>
	<alpine.DEB.1.10.0804131546370.9318@asgard>
	<20080414043939.GA6862@1wt.eu>
	<20080414053943.GU9785@ZenIV.linux.org.uk>
	<20080413232441.e216a02c.akpm@linux-foundation.org>
	<20080414072328.GW9785@ZenIV.linux.org.uk>
	<Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au>
	<4804765B.2070300@davidnewall.com>
	<bd6139dc0804160515s64a36748v49556c56d475dda4@mail.gmail.com>
	<20080416132634.GA545@cs181133002.pp.htv.fi>
	<20080416120247.c665859c.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Adrian Bunk <bunk@kernel.org>, sverre@rabbelier.nl,
	git@vger.kernel.org, linux-kernel@vger.kernel.org,
	jmorris@namei.org, viro@zeniv.linux.org.uk, w@1wt.eu,
	david@lang.hm, sclark46@earthlink.net, johnpol@2ka.mipt.ru,
	rjw@sisk.pl, tilman@imap.cc, Valdis.Kletnieks@vt.edu, lkml@rtr.ca,
	davem@davemloft.net, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org, netdev@vger.kernel.org,
	davidn@davidnewall.com
To: Andrew Morton <akpm@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752897AbYDPUB4@vger.kernel.org Wed Apr 16 22:11:35 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752897AbYDPUB4@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JmDqT-0000CP-Dx
	for glk-linux-kernel-3@gmane.org; Wed, 16 Apr 2008 22:03:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897AbYDPUB4 (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Wed, 16 Apr 2008 16:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756456AbYDPUBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2008 16:01:39 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:34965 "EHLO
	pentafluge.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762254AbYDPUBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2008 16:01:38 -0400
Received: from [192.102.209.1] (helo=laptopd505.fenrus.org)
	by pentafluge.infradead.org with esmtpsa (Exim 4.68 #1 (Red Hat Linux))
	id 1JmDon-0002MR-Mq; Wed, 16 Apr 2008 20:01:22 +0000
In-Reply-To: <20080416120247.c665859c.akpm@linux-foundation.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.12.5; i386-redhat-linux-gnu)
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79736>

On Wed, 16 Apr 2008 12:02:47 -0700
Andrew Morton <akpm@linux-foundation.org> wrote:

> 
> > At least with the data we have currently in git it's impossible to 
> > figure that out automatically.
> > 
> > E.g. if you look at commit f743d04dcfbeda7439b78802d35305781999aa11 
> > (ide/legacy/q40ide.c: add MODULE_LICENSE), how could you determine 
> > automatically that it is a bugfix, and the commit that introduced
> > the bug?
> > 
> > You can always get some data, but if you want to get usable
> > statistics you need explicit tags in the commits, not some
> > algorithm that tries to guess.
> 
> Well yes.  One outcome of the project would be to tell us what
> changes we'd need to make to our processes to make such data
> gathering more effective.

also.. "what is a bugfix" is an interesting thing... for some things it's very easy.
For others.. it's really hard to draw a solid line where bugs stop and features start.
(for example, is a missing cpu id in oprofile a bugfix ("oprofile doesn't work") or 
a feature ("new cpu support"). This one is one of the more simple ones even...)

-- 
If you want to reach me at my work email, use arjan@linux.intel.com
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
