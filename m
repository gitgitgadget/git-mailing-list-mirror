From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 18:18:15 +0200
Message-ID: <20050728161815.GC17952@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de> <20050728153506.GL14229@pasky.ji.cz> <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 21:35:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyE8v-00050h-FV
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 21:34:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVG1QVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 12:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVG1QT2
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 12:19:28 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47119 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261556AbVG1QSR (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 12:18:17 -0400
Received: (qmail 21281 invoked by uid 2001); 28 Jul 2005 16:18:15 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 05:56:21PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> Hi,

Hello,

> On Thu, 28 Jul 2005, Petr Baudis wrote:
> 
> > Dear diary, on Thu, Jul 28, 2005 at 03:07:01PM CEST, I got a letter
> > where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> >
> > > On Thu, 28 Jul 2005, Petr Baudis wrote:
> > >
> > > > See above. I would much rather see more flexible git-send-pack. Junio,
> > > > what about changing its [heads]* parameter e.g. to
> > > > [remotehead[:localhead]]* ?
> > >
> > > IMHO this opens the door for shooting in your own foot. Isn't it much too
> > > easy to make a mistake with that syntax?
> >
> > What mistake?
> 
> To mix up different branches. With that syntax you can easily push changes
> onto the wrong head.

How? Only when you explicitly specify the remote head. When you're
explicit, you ought to know what are you doing.

> I might well be wrong here, but I think the most common usage for git-push
> is to update a public repository, which is done by one or just a few
> maintainer(s), in which case it is no problem to enforce
> localhead=remotehead. BTW, this whole multihead mess applies only to Jeffs
> anyway :-)

AFAIK the plan is to centralize all the kernel repositories to a single
one. For that, developers would generally push into branches with name
different that "master".

> I just do not see a high demand for mappings of remote and local HEAD
> names, but rather a high potential of making mistakes (after all, it is
> not the machine which makes mistakes, it's the human operator).

If you fear making mistakes, better use something which attempts to do
some babysitting for you, like Cogito. ;-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
