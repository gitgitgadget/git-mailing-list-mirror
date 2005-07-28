From: Petr Baudis <pasky@suse.cz>
Subject: Re: How is working on arbitrary remote heads supposed to work in Cogito (+ PATCH)?
Date: Thu, 28 Jul 2005 17:35:06 +0200
Message-ID: <20050728153506.GL14229@pasky.ji.cz>
References: <200507271458.43063.Josef.Weidendorfer@gmx.de> <7vll3rlnqm.fsf@assigned-by-dhcp.cox.net> <200507271458.43063.Josef.Weidendorfer@gmx.de> <20050728120806.GA2391@pasky.ji.cz> <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 28 17:41:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyAUQ-000072-QA
	for gcvg-git@gmane.org; Thu, 28 Jul 2005 17:40:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261272AbVG1Pjd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jul 2005 11:39:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVG1PhH
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jul 2005 11:37:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:64270 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261272AbVG1PfI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Jul 2005 11:35:08 -0400
Received: (qmail 17823 invoked by uid 2001); 28 Jul 2005 15:35:06 -0000
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0507281504100.25402@wgmdd8.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Jul 28, 2005 at 03:07:01PM CEST, I got a letter
where Johannes Schindelin <Johannes.Schindelin@gmx.de> told me that...
> Hi,

Hello,

> On Thu, 28 Jul 2005, Petr Baudis wrote:
> 
> > See above. I would much rather see more flexible git-send-pack. Junio,
> > what about changing its [heads]* parameter e.g. to
> > [remotehead[:localhead]]* ?
> 
> IMHO this opens the door for shooting in your own foot. Isn't it much too
> easy to make a mistake with that syntax?

What mistake?

> What is so wrong with git-clone not allowing you to name the HEAD
> differently?

Did you read the preceding discussion? When you are pushing from your
master branch to a remote branch, it may well be called different over
there.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
