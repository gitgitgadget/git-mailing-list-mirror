From: Petr Baudis <pasky@suse.cz>
Subject: Re: cg update failing
Date: Wed, 20 Jul 2005 03:07:12 +0200
Message-ID: <20050720010712.GB2255@pasky.ji.cz>
References: <m3oe95qn64.fsf@lugabout.cloos.reno.nv.us> <1121365461.4729.0.camel@localhost.localdomain> <m3k6jtnod8.fsf@lugabout.cloos.reno.nv.us> <1121376069.4729.2.camel@localhost.localdomain> <m3d5plm50o.fsf@lugabout.cloos.reno.nv.us> <m3eka04shr.fsf@lugabout.cloos.reno.nv.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Darrin Thompson <darrint@progeny.com>
X-From: git-owner@vger.kernel.org Wed Jul 20 01:07:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dv1BO-0000WW-Vg
	for gcvg-git@gmane.org; Wed, 20 Jul 2005 01:07:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261421AbVGSXHQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Jul 2005 19:07:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVGSXHQ
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jul 2005 19:07:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43780 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261421AbVGSXHO (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 19 Jul 2005 19:07:14 -0400
Received: (qmail 4744 invoked by uid 2001); 20 Jul 2005 01:07:13 -0000
To: James Cloos <cloos+vger-git@jhcloos.com>
Content-Disposition: inline
In-Reply-To: <m3eka04shr.fsf@lugabout.cloos.reno.nv.us>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Jul 15, 2005 at 06:12:48AM CEST, I got a letter
where James Cloos <cloos+vger-git@jhcloos.com> told me that...
> Well, it wasn't as Ok as I first thought.  There were several .rej and
> backup files as left behind by patch(1).  cg update HEAD says:  Branch
> already fully merged but Makefile still says 2.6.12.
> 
> I'm cloning now to a remote uml and will try and rsync from there to
> the laptop.  Perhaps *that* will get me a working repo.

Huh. Well, you had to do uberweird things with your repository - why did
you cg-seek at all? What Cogito version is it?

Anyway, cg-reset (or cg-cancel in "older" Cogito) should bring
everything in shape.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
