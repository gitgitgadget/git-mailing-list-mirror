From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Re: write-tree is pasky-0.4
Date: Fri, 15 Apr 2005 20:56:24 +0200
Message-ID: <20050415185624.GB7417@pasky.ji.cz>
References: <20050414193507.GA22699@pasky.ji.cz> <7vmzs1osv1.fsf@assigned-by-dhcp.cox.net> <20050414233159.GX22699@pasky.ji.cz> <7v7jj4q2j2.fsf@assigned-by-dhcp.cox.net> <20050414223039.GB28082@64m.dyndns.org> <7vfyxsmqmk.fsf@assigned-by-dhcp.cox.net> <20050415062807.GA29841@64m.dyndns.org> <7vfyxsi9bq.fsf@assigned-by-dhcp.cox.net> <7vaco0i3t9.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 20:53:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMVwG-0000MD-MB
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 20:53:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261880AbVDOS4a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 14:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVDOS4a
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 14:56:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3807 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261880AbVDOS4Z (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Apr 2005 14:56:25 -0400
Received: (qmail 13454 invoked by uid 2001); 15 Apr 2005 18:56:24 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504151138490.7211@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 15, 2005 at 08:44:02PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> And I merged your "Add -z option to show-files", but you had based your 
> other patches on Petr's tree which due to my other changes is not going to 
> merge totally cleanly with mine, so I'm wondering if you might want to try 
> to re-merge your mergepoint stuff against my current tree? That way I can 
> continue to maintain a set of "core files", and Pasky can maintain the 
> "usable interfaces" part..

Actually, I wanted to ask about this. :-)

So, I assume that you don't want to merge my "SCM layer" (which is
perfectly fine by me). However, I also apply plenty of patches
concerning the "core git" - be it portability, leak fixes, argument
parsing fixes and so on.

Would it be of any benefit if I maintained two trees, one with just your
core git but what I merge (I think I'd call this branch git-pb), and one
with my git-pasky (to be renamed to Cogito) layer. I'd then put the
"core git" changes to the git-pb branch and pull from it to the Cogito
branch regularily, but it should be safe for you to pull from it too.

In fact, in that case I might even end up entirely separating the Cogito
tools from the core git and distributing them independently.

BTW, just out of interest, are you personally planning to use Cogito for
your kernel and sparse (and possibly even git) work, or will you stay
with your lowlevel plumbing for that?

Thanks,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
