From: Willy Tarreau <w@1wt.eu>
Subject: Re: Reporting bugs and bisection
Date: Tue, 15 Apr 2008 06:55:42 +0200
Message-ID: <20080415045541.GA611@1wt.eu>
References: <20080413232441.e216a02c.akpm@linux-foundation.org> <20080414072328.GW9785@ZenIV.linux.org.uk> <Xine.LNX.4.64.0804150131300.4160@us.intercode.com.au> <20080414.150105.101568769.davem@davemloft.net> <20080414160513.9f57e5ba.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Miller <davem@davemloft.net>, jmorris@namei.org,
	viro@ZenIV.linux.org.uk, david@lang.hm, sclark46@earthlink.net,
	johnpol@2ka.mipt.ru, rjw@sisk.pl, tilman@imap.cc,
	Valdis.Kletnieks@vt.edu, lkml@rtr.ca, jesper.juhl@gmail.com,
	yoshfuji@linux-ipv6.org, jeff@garzik.org,
	linux-kernel@vger.kernel.org, git@vger.kernel.org,
	netdev@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764342AbYDOFFa@vger.kernel.org Tue Apr 15 07:06:29 2008
connect(): Connection refused
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1764342AbYDOFFa@vger.kernel.org>
Envelope-to: glk-linux-kernel-3@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JldN5-0006MB-4H
	for glk-linux-kernel-3@gmane.org; Tue, 15 Apr 2008 07:06:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764342AbYDOFFa (ORCPT <rfc822;glk-linux-kernel-3@m.gmane.org>);
	Tue, 15 Apr 2008 01:05:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753428AbYDOFFX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2008 01:05:23 -0400
Received: from 1wt.eu ([62.212.114.60]:3112 "EHLO 1wt.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753332AbYDOFFW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Apr 2008 01:05:22 -0400
Content-Disposition: inline
In-Reply-To: <20080414160513.9f57e5ba.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79567>

On Mon, Apr 14, 2008 at 04:05:13PM -0700, Andrew Morton wrote:
> On Mon, 14 Apr 2008 15:01:05 -0700 (PDT)
> David Miller <davem@davemloft.net> wrote:
> 
> > From: James Morris <jmorris@namei.org>
> > Date: Tue, 15 Apr 2008 01:54:00 +1000 (EST)
> > 
> > > - Things like "who made the kernel" statistics and related articles ignore 
> > >   code review.
> > 
> > Note the apparent irony in that the person who ends up often on the
> > top of those lists, Al Viro, is also someone who also does a
> > significant amount of code review.
> > 
> > I think this is no accident.
> 
> "who made the kernel" was an interesting and useful exercise, but if you
> like irony then...
> 
> - The way to boost your commit count is to submit buggy patches and to
>   then fix your own bugs.
> 
> - The way to lower your commit count is to fix things in other people's
>   patches, then fold your fix into the base patch.  I've lost over 1000
>   commits that way.  Unless they are counting '^    [akpm' as a commit.

And if Dave speaks about these stats : http://lwn.net/Articles/237768/
then Al does not even appear in it, which proves your point.

Willy
