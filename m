From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: cogito "origin" vs. HEAD
Date: Wed, 04 May 2005 09:49:20 +1000
Message-ID: <1115164160.7627.55.camel@gaston>
References: <1115090660.6156.56.camel@gaston>
	 <20050503064943.GB10244@pasky.ji.cz> <1115104408.6156.100.camel@gaston>
	 <20050503094723.GA22436@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 04 01:45:44 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT74q-0004yr-NH
	for gcvg-git@gmane.org; Wed, 04 May 2005 01:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbVECXvi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 19:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVECXvi
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 19:51:38 -0400
Received: from gate.crashing.org ([63.228.1.57]:7095 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261928AbVECXv3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 19:51:29 -0400
Received: from gaston (localhost [127.0.0.1])
	by gate.crashing.org (8.12.8/8.12.8) with ESMTP id j43NjYgJ023926;
	Tue, 3 May 2005 18:45:35 -0500
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050503094723.GA22436@pasky.ji.cz>
X-Mailer: Evolution 2.2.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 2005-05-03 at 11:47 +0200, Petr Baudis wrote:
> Dear diary, on Tue, May 03, 2005 at 09:13:28AM CEST, I got a letter
> where Benjamin Herrenschmidt <benh@kernel.crashing.org> told me that...
> > > when accessing the remote repository, Cogito always looks for remote
> > > refs/heads/master first - if that one isn't there, it takes HEAD, but
> > > there is no correlation between the local and remote branch name. If you
> > > want to fetch a different branch from the remote repository, use the
> > > fragment identifier (see cg-help cg-branch-add).
> > 
> > Ok, that I'm getting. So then, what happen of my local
> > refs/heads/<branchname> and refs/heads/master/ ? I'm still a bit
> > confused by the whole branch mecanism... It's my understanding than when
> > I cg-init, it creates both "master" (a head without matching branch)
> > and "origin" (a branch  + a head) both having the same sha1. It also
> > checks out the tree.
> > 
> > Now, when I cg-update origin, what happens exactly ? I mean, I know it's
> > pulls all objects, then get the master from the remote pointed by the
> > origin branch, but then, I suppose it updates both my local "origin" and
> > my local "master" pointer, right ? I mean, they are always in sync ? Or
> > is this related to what branch my current checkout is tracking ?
> 
> They are in sync as long as you update only from that given branch.
> At the moment you do a local commit, they get out of sync, at least
> until your master branch is merged to the origin branch on the other
> side. Every cg-update will then generate a merging commit, so it will
> look like this:
> > .../...

Thanks for that detailed explanation !

Ben.


