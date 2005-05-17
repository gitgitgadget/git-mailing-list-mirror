From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less distracting.
Date: Tue, 17 May 2005 23:11:32 +0200
Message-ID: <20050517211132.GK7136@pasky.ji.cz>
References: <Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org> <Pine.LNX.4.21.0505161955340.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 23:15:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY9M5-0008Bc-Rr
	for gcvg-git@gmane.org; Tue, 17 May 2005 23:11:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261962AbVEQVMI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 17:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261953AbVEQVMI
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 17:12:08 -0400
Received: from w241.dkm.cz ([62.24.88.241]:10980 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261962AbVEQVLh (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 May 2005 17:11:37 -0400
Received: (qmail 23612 invoked by uid 2001); 17 May 2005 21:11:32 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505161955340.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, May 17, 2005 at 02:10:35AM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Mon, 16 May 2005, Linus Torvalds wrote:
> 
> > One final note: I actually think that "rename patches" make a ton of 
> > sense, even if git itself doesn't track renames. If we ever have a "smart 
> > diff" thing that can generate inter-file diffs, I'd like to eventually see
> > 
> > 	diff -git a/kernel/sched.c b/kernel/sched.c.old
> > 	rename kernel/sched.c kernel/sched.c.old
> > 	old mode 100644
> > 	new mode 100755
> 
> I'd like something like:
> 
> diff -git a/kernel/sched.c b/kernel/sched.c.old
> filename -- kernel/sched.c
> filename ++ kernel/sched.c.old
> mode -- 100644
> mode ++ 100755
> --- a/kernel/sched.c
> +++ b/kernel/sched.c.old
> @@ -1,5 +1,5 @@
> (etc.)
> 
> because I actually start thinking of the two sides as "-" and "+", and I'd
> actually have to think about which is "old" and which is "new", and which
> way the "rename" line goes, and so forth. I'd actually be happier with
> just a "mode -- 100644" line for a deleted file, also. If I'm looking at a
> patch, and I read Makefile with '-' and '+' versions of the lists of
> objects, and then get to a "new file" line, I have to think about it to
> associate the '+' side with having the file and the '-' side with not
> having it.

Oops, I've somehow completely missed this mail, but I like this idea a
lot. What do you think, Linus and Junio?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
