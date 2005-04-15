From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 13:13:21 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504151212160.7211@ppc970.osdl.org>
References: <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net>
 <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net>
 <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net>
 <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net>
 <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
 <20050415185624.GB7417@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 22:10:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMX8t-0000yz-Js
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 22:10:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261955AbVDOUM6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 16:12:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261958AbVDOUM6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 16:12:58 -0400
Received: from fire.osdl.org ([65.172.181.4]:659 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261955AbVDOULa (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 16:11:30 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3FKBOs4019929
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 15 Apr 2005 13:11:24 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3FKBNc2012595;
	Fri, 15 Apr 2005 13:11:23 -0700
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050415185624.GB7417@pasky.ji.cz>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 15 Apr 2005, Petr Baudis wrote:
> 
> So, I assume that you don't want to merge my "SCM layer" (which is
> perfectly fine by me). However, I also apply plenty of patches
> concerning the "core git" - be it portability, leak fixes, argument
> parsing fixes and so on.

I'm actually perfectly happy to merge your SCM layer too eventually, but 
I'm nervous at this point.  Especially while people are discussing some 
SCM options that I'm personally very leery of, and think that may make 
sense for others, but that I personally distrust.

> BTW, just out of interest, are you personally planning to use Cogito for
> your kernel and sparse (and possibly even git) work, or will you stay
> with your lowlevel plumbing for that?

I'm really really hoping I'd use cogito, and that it ends up being just 
one project. In particular, I'm hoping that in a few days, I'll have done 
enough plumbing that I don't even care any more, and then I'd not even 
maintain a tree of my own. 

I'm really not that much of an SCM guy. I detest pretty much all SCM's out
there, and while it's been interesting to do 'git', I've done it because I
was forced to, and because I really wanted to put _my_ needs and opinions
first in an SCM, and see how that works. That's why I've been so adamant
about having a "philosophy", because otherwise I'd probably just end up
with yet another SCM that I'd despise.

So for me, the "optimal" situation really ends up that you guys end up as
the maintainers. I don't even _want_ to maintain it, although I'd be more
than happy to be part of the engineering team. I just want to mark out the
direction well enough and get it to a point where I can _use_ it, that I
feel like I'm done.

But before I can do that, I need to feel like I can live with the end 
result. The only missing part is merges, and I think you and Junio are 
getting pretty close (with Daniel's parent finder, Junio's merger etc). 

			Linus
