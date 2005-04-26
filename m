From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: : Networking
Date: Tue, 26 Apr 2005 11:40:08 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504261114090.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504260746320.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andrew Morton <akpm@osdl.org>,
	"David S. Miller" <davem@davemloft.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 26 17:45:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQSEq-00036W-GD
	for gcvg-git@gmane.org; Tue, 26 Apr 2005 17:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVDZPnM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Apr 2005 11:43:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDZPlI
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Apr 2005 11:41:08 -0400
Received: from iabervon.org ([66.92.72.58]:1798 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261447AbVDZPkK (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Apr 2005 11:40:10 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DQSAT-0003B4-00; Tue, 26 Apr 2005 11:40:09 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504260746320.18901@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 26 Apr 2005, Linus Torvalds wrote:

> On Tue, 26 Apr 2005, Andrew Morton wrote:
> > 
> 
> The only thing you should be a bit careful about is to remember what the 
> "heads" at different points were. In particular, you want to remember 
> where you merged with me last was. I've started tagging my releases with 
> the git tag facility (_not_ the pasky one, but I think pasky will start 
> picking up on that soon enough), so finding a specific release will be 
> easy, but if you ever do a non-release merge you'll just have to tag it 
> yourself.

Your tag system is in the "cogito-0.8" release, plus a pasky-style way of
keeping track of what tags you have in your repository.

> > d) To generate davem's tree (patch against linus's current tree (ie: patch
> >    against 2.6.12-rc3+linus.patch)):
> > 
> > 	git pull git-net
> 
> Yes. This should have merged the two (assuming "git pull" does what I 
> think it does).

I think git pull only downloads the contents of the repo and saves the new
head in a separate file. You're left to do the merge yourself, in case
what you actually wanted to do was just read the patches in the remote
repo without merging them.

You probably need a "git merge git-net" here, and things will be in the
state that Linus expects.

	-Daniel
*This .sig left intentionally blank*

