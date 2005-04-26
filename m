From: Petr Baudis <pasky@ucw.cz>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 20:15:54 +0200
Message-ID: <20050426181554.GA13224@pasky.ji.cz>
References: <Pine.LNX.4.58.0504260746320.18901@ppc970.osdl.org> <Pine.LNX.4.21.0504261114090.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 20:12:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQUX6-0006Od-4q
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 20:11:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVDZSQj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 14:16:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261577AbVDZSQj
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 14:16:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:6541 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261656AbVDZSQA (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 14:16:00 -0400
Received: (qmail 13900 invoked by uid 2001); 26 Apr 2005 18:15:54 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504261114090.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Tue, Apr 26, 2005 at 05:40:08PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Tue, 26 Apr 2005, Linus Torvalds wrote:
> 
> > On Tue, 26 Apr 2005, Andrew Morton wrote:
> > > 
> > 
> > The only thing you should be a bit careful about is to remember what the 
> > "heads" at different points were. In particular, you want to remember 
> > where you merged with me last was. I've started tagging my releases with 
> > the git tag facility (_not_ the pasky one, but I think pasky will start 
> > picking up on that soon enough), so finding a specific release will be 
> > easy, but if you ever do a non-release merge you'll just have to tag it 
> > yourself.
> 
> Your tag system is in the "cogito-0.8" release, plus a pasky-style way of
> keeping track of what tags you have in your repository.

It came in with merge with Linus, but there's no support in the Cogito
toolkit for it whatsoever.

I'm personally unlikely to get any time for doing it (or much anything
else; but this is probably the priority now) until Sunday evening. :-(

> > > d) To generate davem's tree (patch against linus's current tree (ie: patch
> > >    against 2.6.12-rc3+linus.patch)):
> > > 
> > > 	git pull git-net
> > 
> > Yes. This should have merged the two (assuming "git pull" does what I 
> > think it does).
> 
> I think git pull only downloads the contents of the repo and saves the new
> head in a separate file. You're left to do the merge yourself, in case
> what you actually wanted to do was just read the patches in the remote
> repo without merging them.
> 
> You probably need a "git merge git-net" here, and things will be in the
> state that Linus expects.

Yes. git pull only pulls the stuff, doesn't merge it (that is, unless it
is tracked branch; but I think this isn't the case; this was cleaned up
in cogito-0.8 and cg-pull now always only pulls, cg-update
pulls+merges).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
