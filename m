From: Petr Baudis <pasky@ucw.cz>
Subject: Re: README rewrite
Date: Wed, 18 May 2005 23:42:16 +0200
Message-ID: <20050518214216.GF10358@pasky.ji.cz>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com> <42876B30.1070404@saville.com> <20050515154041.GD7391@tumblerings.org> <20050515155315.GE7391@tumblerings.org> <20050515172802.GH13024@pasky.ji.cz> <20050516151604.GF7391@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wink Saville <wink@saville.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 18 23:44:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DYWJ1-00044L-Ce
	for gcvg-git@gmane.org; Wed, 18 May 2005 23:42:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262221AbVERVmc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 May 2005 17:42:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262274AbVERVmc
	(ORCPT <rfc822;git-outgoing>); Wed, 18 May 2005 17:42:32 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44684 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262218AbVERVmS (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 May 2005 17:42:18 -0400
Received: (qmail 8375 invoked by uid 2001); 18 May 2005 21:42:16 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050516151604.GF7391@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 16, 2005 at 05:16:04PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> So a branch is just a name for a cloned tree somewhere, the same as a tag is
> just a name for a revision some time in the past?

Very much so.

> On Sun, May 15, 2005 at 07:28:03PM +0200, Petr Baudis wrote:
> > So the local branch is the "master" branch, the rest are "remote"
> > branches. Note that there is a theoretical support for multiple local
> > branches, but I decided not to make things even more confusing and there
> > is no Cogito interface for managing them now.
> 
> Is there anything about the repository that 'knows' which is the master branch,
> or is this just a matter of which person is in charge? So, if I have a project,
> and I have a Cogito repository, so far it's just me, and just one branch.
> 
> Then another person joins the project, and they clone my repository onto their
> local system, and give it their own branch name.
> 
> Now here is the question:
> 
> We decide that the other person is a better project leader, and we decide to use
> their branch as the master branch, and mine as just a remote branch.
> 
> Would that be normal Cogito behavior? i.e. there is nothing to distinguish a
> 'master' branch from any other except that it is the one everyone says is the
> master branch?

That's right. The "master" branch is just your local thing, as well as
naming of the remote branches. The "master" branch name means this is
the branch representing your working tree, not that it is the mainline
of the project or anything. If you fork Linus' tree, in your repository
your fork will be the "master" branch, and Linus' branch will be called
however you name it.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
