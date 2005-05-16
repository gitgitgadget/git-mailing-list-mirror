From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: README rewrite
Date: Mon, 16 May 2005 08:16:04 -0700
Message-ID: <20050516151604.GF7391@tumblerings.org>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com> <42876B30.1070404@saville.com> <20050515154041.GD7391@tumblerings.org> <20050515155315.GE7391@tumblerings.org> <20050515172802.GH13024@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Wink Saville <wink@saville.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 17:28:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXhVA-0002SC-5N
	for gcvg-git@gmane.org; Mon, 16 May 2005 17:27:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVEPP00 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 May 2005 11:26:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEPPXm
	(ORCPT <rfc822;git-outgoing>); Mon, 16 May 2005 11:23:42 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:6301 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261690AbVEPPVV
	(ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2005 11:21:21 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DXhK8-0001LM-D0; Mon, 16 May 2005 08:16:04 -0700
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050515172802.GH13024@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 at 07:28:03PM +0200, Petr Baudis wrote:
> Dear diary, on Sun, May 15, 2005 at 05:53:15PM CEST, I got a letter
> where Zack Brown <zbrown@tumblerings.org> told me that...
> > On Sun, May 15, 2005 at 08:40:41AM -0700, Zack Brown wrote:
> > > This much I think I understand. What I don't understand is how to actually use
> > > branches. I don't see a Cogito command to create or destroy them.
> > 
> > Or I'm blind. The cg-branch-add command is right there. It also has a long
> > comment at the top of the script. Unfortunately the comment only describes how
> > to use the command, not what exactly branches are or how to work with them.
> > 
> > Clearly 'branches' are diverging branches of development. But if I have my
> > own tree, with several branches in it, it's unclear to me how to specify
> > which branch I'm actually working on at any given moment.
> 
> I think it's actually very BKish. Each repository has its own "master"
> branch, which always corresponds with your current branch of
> development. That is, your working tree is always represented by the
> "master" branch.
> 
> The rest of branches are "remote", that is they just point at the other
> repositories. When you want to get the new changes from them, you
> cg-pull, or cg-update to merge them to your branch too.
> 
> So if you want to create a new branch, you cg-clone the original branch.
> And if you want to refer to the new branch in any other branch, you
> cg-branch-add it in the other branch.

So a branch is just a name for a cloned tree somewhere, the same as a tag is
just a name for a revision some time in the past?

> 
> So the local branch is the "master" branch, the rest are "remote"
> branches. Note that there is a theoretical support for multiple local
> branches, but I decided not to make things even more confusing and there
> is no Cogito interface for managing them now.

Is there anything about the repository that 'knows' which is the master branch,
or is this just a matter of which person is in charge? So, if I have a project,
and I have a Cogito repository, so far it's just me, and just one branch.

Then another person joins the project, and they clone my repository onto their
local system, and give it their own branch name.

Now here is the question:

We decide that the other person is a better project leader, and we decide to use
their branch as the master branch, and mine as just a remote branch.

Would that be normal Cogito behavior? i.e. there is nothing to distinguish a
'master' branch from any other except that it is the one everyone says is the
master branch?

Be well,
Zack

> 
> I will add cg-switch which will switch the master branch to some other
> branch (e.g. cg-switch linus will rename your current master to
> master-1234 or something, update your "origin" branch to point to the
> "linus" branch, and make your "master" branch to point at the same
> commit as the "origin" branch). I might also do something like
> cg-branch-add --local, which will add a local branch and you could then
> cg-switch to it too.
> 
> -- 
> 				Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
