From: Petr Baudis <pasky@ucw.cz>
Subject: Re: cg-update with local uncommitted changes
Date: Tue, 31 May 2005 18:04:26 +0200
Message-ID: <20050531160426.GB7013@pasky.ji.cz>
References: <1117463114.7072.185.camel@pegasus> <20050530192541.GA27047@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcel Holtmann <marcel@holtmann.org>,
	GIT Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 18:05:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd9Dm-0000rc-RR
	for gcvg-git@gmane.org; Tue, 31 May 2005 18:04:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261921AbVEaQGM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 12:06:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261941AbVEaQFj
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 12:05:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:19367 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261930AbVEaQE2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 12:04:28 -0400
Received: (qmail 21125 invoked by uid 2001); 31 May 2005 16:04:26 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050530192541.GA27047@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 30, 2005 at 09:25:41PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> On Mon, May 30, 2005 at 04:25:14PM +0200, Marcel Holtmann wrote:
> > Hi Petr,
> > 
> > when doing a cg-update and I have local uncommitted changes it fails
> > with the "... needs update" message.
> 
> I don't see failures, but I do see the "needs update" message often when
> I do cg-update. If I run cg-update a second time it says the tree is fully
> up-to-date. However, if I then do a cg-diff, I will see tons of diff output.
> This is on a tree (the kernel) that I haven't modified at all, I only track it
> with cg-update.

This is strange. I've just did a cg-update on a kernel tree I've left
untouched for more than a week (and I've even locally modified one file)
and everything went fine.

> I also track Cogito, and I use the latest form of all git and Cogito tools.
> Maybe somewhere along the line I've corrupted my repo by using incompatible
> versions of the git/Cogito toolset.

That's entirely possible given the big output format changes from some
git tools. Hopefully most of those problems should be already fixed.

> I've noticed if I do a fresh cg-clone the problem seems to go away.

Tip of the day: cg-cancel will fix almost any working state messup (any
messup as long as you have proper commit id in your refs/heads/master
file).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
