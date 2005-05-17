From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less distracting.
Date: Tue, 17 May 2005 09:01:58 +0200
Message-ID: <20050517070158.GA10031@pasky.ji.cz>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net> <20050516220559.GC8609@pasky.ji.cz> <7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 09:02:19 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXw5N-0001PD-Uc
	for gcvg-git@gmane.org; Tue, 17 May 2005 09:01:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVEQHCK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 03:02:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261267AbVEQHCK
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 03:02:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:8151 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261251AbVEQHCA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 03:02:00 -0400
Received: (qmail 10552 invoked by uid 2001); 17 May 2005 07:01:58 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 17, 2005 at 01:28:31AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Mon, 16 May 2005, Junio C Hamano wrote:
> 
> >     # mode: 100644 100755 nitfol
> >     --- a/nitfol
> >     +++ b/nitfol
> 
> >     @. 100644 100755 nitfol
> >     --- a/nitfol
> >     +++ b/nitfol
> 
> I have to say, I muct prefer the first over the second.

Glad. :-)

> One final note: I actually think that "rename patches" make a ton of 
> sense, even if git itself doesn't track renames. If we ever have a "smart 
> diff" thing that can generate inter-file diffs, I'd like to eventually see
> 
> 	diff -git a/kernel/sched.c b/kernel/sched.c.old
> 	rename kernel/sched.c kernel/sched.c.old
> 	old mode 100644
> 	new mode 100755
> 	--- a/kernel/sched.c
> 	+++ b/kernel/sched.c.old
> 	@@ -1,5 +1,5 @@
> 	 /*
> 	- *  kernel/sched.c
> 	+ *  kernel/sched.c.old
> 	  *
> 	  *  Kernel scheduler and related syscalls
> 	  *
> 
> Notice? We could have a mode change, a rename _and_ a content change, all
> at the same time under the same header. That's obviously a totally idiotic
> example, but the point is that if we have a nice "extended diff header"
> setup, the format is very easily able to accomodate things like this.

Actually, if the git diff format is fixed, do we even need the explicit
rename line? It could be enough if the filenames on the diff line would
be just different. Or you want it because of clarity?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
