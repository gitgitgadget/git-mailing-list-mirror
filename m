From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Problem with cogito and Linux tree tags
Date: Fri, 3 Jun 2005 09:28:47 +0200
Message-ID: <20050603072847.GC16619@pasky.ji.cz>
References: <429F5FA5.2030306@gorzow.mm.pl> <429F6270.50009@gmail.com> <429F6591.8080005@gorzow.mm.pl> <429F69B6.4030806@gmail.com> <429F73E4.1020502@gorzow.mm.pl> <429F92CA.9060908@gorzow.mm.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dan Holmsand <holmsand@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 03 09:27:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1De6Yp-0000vM-DQ
	for gcvg-git@gmane.org; Fri, 03 Jun 2005 09:25:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261161AbVFCH2v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Jun 2005 03:28:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261170AbVFCH2u
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Jun 2005 03:28:50 -0400
Received: from w241.dkm.cz ([62.24.88.241]:13536 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261161AbVFCH2s (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2005 03:28:48 -0400
Received: (qmail 17458 invoked by uid 2001); 3 Jun 2005 07:28:47 -0000
To: Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl>
Content-Disposition: inline
In-Reply-To: <429F92CA.9060908@gorzow.mm.pl>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jun 03, 2005 at 01:14:18AM CEST, I got a letter
where Radoslaw Szkodzinski <astralstorm@gorzow.mm.pl> told me that...
> Radoslaw Szkodzinski wrote:
> 
> >Dan Holmsand wrote:
> >
> >  
> >
> >>$ git-cat-file tag 06f6d9e2f140466eeb41e494e14167f90210f89d
> >>
> >>which tells you that v2.6.12-rc5 is commit
> >>2a24ab628aa7b190be32f63dfb6d96f3fb61580a
> >>
> >>    
> >>
> >Ok.  This doesn't work too. That cogito version really works fine, but I
> >had that branch cloned from a local repository gotten from rsync and
> >probably that's the problem.
> >The tags weren't propagated, but they should be.
> >
> >AstralStorm
> >  
> >
> Well, new cogito-0.11.1 (300ab153620d2492e824cb3561c32debb5e80bf8) has
> this fixed and picked up missing objects automatically.

Oh yes, I wanted to mention it in this thread but forgot.

However note that what it does now is awful and it's just a
quick'n'dirty fix to make it mostly work. I guess a better way would be
to teach the pull tools to download refs/ files too and do the proper
dependency things from them too (in addition to the passed commit id).

I will need to go back and look again at the set of Daniel's patches
which implemented something like that.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
