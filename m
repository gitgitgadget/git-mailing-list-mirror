From: Petr Baudis <pasky@suse.cz>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 21:27:28 +0100
Message-ID: <20060214202728.GE31278@pasky.or.cz>
References: <43F20532.5000609@iaglans.de> <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org> <87k6bxvmj6.wl%cworth@cworth.org> <Pine.LNX.4.64.0602141026570.3691@g5.osdl.org> <87fymlvgzv.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Nicolas Vilz 'niv' <niv@iaglans.de>,
	git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:26:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F96l5-0006gf-Ho
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 21:26:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422793AbWBNU0m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 15:26:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422794AbWBNU0m
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 15:26:42 -0500
Received: from w241.dkm.cz ([62.24.88.241]:62444 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422793AbWBNU0m (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Feb 2006 15:26:42 -0500
Received: (qmail 3316 invoked by uid 2001); 14 Feb 2006 21:27:28 +0100
To: Carl Worth <cworth@cworth.org>
Content-Disposition: inline
In-Reply-To: <87fymlvgzv.wl%cworth@cworth.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16166>

Dear diary, on Tue, Feb 14, 2006 at 09:10:28PM CET, I got a letter
where Carl Worth <cworth@cworth.org> said that...
> That gives a very natural name, "seek", for the operation I'd like.
> 
> How about "git seek" for doing the operations above, and using some
> reserved branch name, (say "seek"). Then, git-bisect could easily be
> built on that, and git-commit could respect the "seek" name and refuse
> to commit to it, (could tell the user how to create the branch
> necessary to commit from the current point).
> 
> There could also be a "git seek reset" to return to the HEAD saved by
> the first in a chain of "git seek" operations.
> 
> That looks like I minor generalization of existing behavior in
> git-bisect, but it would provide an operation that I would find
> useful.

Well, this is exactly what cg-seek does (and it's one of pretty old
Cogito commands) - it even has the same name. ;-) See my other mail in
this thread.

It works by creating a new branch cg-seek-point and storing the seeked
point there; if HEAD is already on the branch, it merely changes the
seek point and resets the working tree appropriately. cg-seek without
any arguments will then return to your original head, whose name was
stored in .git/head-name.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
