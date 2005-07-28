From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How is working on arbitrary remote heads supposed to work in
 Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 17:56:21 +0200 (CEST)
Message-ID: <Pine.LNX.4.58.0507281747320.29968@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de>
 <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
 <20050728153506.GL14229@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 18:00:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyAnt-0003t3-HO
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 18:00:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbVG1P7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 11:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261590AbVG1P6W
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 11:58:22 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:21696 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S261575AbVG1P4W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2005 11:56:22 -0400
Received: from wrzx34.rz.uni-wuerzburg.de (wrzx34.rz.uni-wuerzburg.de [132.187.3.34])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 4D7B4E24D4; Thu, 28 Jul 2005 17:56:21 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 2E23FA8678; Thu, 28 Jul 2005 17:56:21 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx34.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 0F54CA5CFF; Thu, 28 Jul 2005 17:56:21 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 02297E24D4; Thu, 28 Jul 2005 17:56:21 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20050728153506.GL14229@pasky.ji.cz>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 28 Jul 2005, Petr Baudis wrote:

> Dear diary, on Thu, Jul 28, 2005 at 03:07:01PM CEST, I got a letter
> where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
>
> > On Thu, 28 Jul 2005, Petr Baudis wrote:
> >
> > > See above. I would much rather see more flexible git-send-pack. Junio,
> > > what about changing its [heads]* parameter e.g. to
> > > [remotehead[:localhead]]* ?
> >
> > IMHO this opens the door for shooting in your own foot. Isn't it much too
> > easy to make a mistake with that syntax?
>
> What mistake?

To mix up different branches. With that syntax you can easily push changes
onto the wrong head.

I might well be wrong here, but I think the most common usage for git-push
is to update a public repository, which is done by one or just a few
maintainer(s), in which case it is no problem to enforce
localhead=remotehead. BTW, this whole multihead mess applies only to Jeffs
anyway :-)

I just do not see a high demand for mappings of remote and local HEAD
names, but rather a high potential of making mistakes (after all, it is
not the machine which makes mistakes, it's the human operator).

> If you want the holes in your knowledge showing up try teaching
> someone.  -- Alan Cox

I like that one.

Ciao,
Dscho
