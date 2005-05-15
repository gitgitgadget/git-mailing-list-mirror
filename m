From: Zack Brown <zbrown@tumblerings.org>
Subject: Re: README rewrite
Date: Sun, 15 May 2005 08:40:41 -0700
Message-ID: <20050515154041.GD7391@tumblerings.org>
References: <20050515044244.GA7391@tumblerings.org> <20050515044941.GB7391@tumblerings.org> <4286F146.2090302@saville.com> <42876B30.1070404@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 15 17:46:05 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXLJT-0000yy-N6
	for gcvg-git@gmane.org; Sun, 15 May 2005 17:45:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261667AbVEOPp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 11:45:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261670AbVEOPp7
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 11:45:59 -0400
Received: from dsl092-000-086.sfo1.dsl.speakeasy.net ([66.92.0.86]:64151 "EHLO
	tumblerings.org") by vger.kernel.org with ESMTP id S261667AbVEOPpp
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 11:45:45 -0400
Received: from zbrown by tumblerings.org with local (Exim 4.50)
	id 1DXLEP-0005DB-74; Sun, 15 May 2005 08:40:41 -0700
To: Wink Saville <wink@saville.com>
Content-Disposition: inline
In-Reply-To: <42876B30.1070404@saville.com>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 at 08:30:56AM -0700, Wink Saville wrote:
> Wink Saville wrote:
> >Zack Brown wrote:
> >
> > > Hi Petr,
> > >
> 
> <snip>
> 
> >Actually looking in the repository I see that "origin" appears to be a 
> >"branch" not a revision, what is the relationship between a branch, tag 
> >and revision's? I have some experience with subversion and in subversion 
> >they are actually all the same, simply the state of a "sub-tree" within 
> >the repository at a particular "time". That time is defined by the 
> >repositories current revison number which is incremented after each 
> >succesful commit to the repository.
> >
> 
> 
> Zack,
> 
> I patched the README by hand this morning and read the explanation on 
> cg-tag and it appears branches, tags and revisions are synonymous, please 
> correct me if I'm wrong.

I think that's wrong:


revision: a particular state of the tree, identified by an SHA1 hash ID

tag: a revision with a cute name

branch: a code fork, identified by name


As I understand it, a tag refers to a specific revision, and so when you use a
tag's name, you are referring only to that revision. A branch is different. When
you use a branch's name, you are referring to all the development that has
occurred in that branch.

So, when the 2.6.12 kernel comes out, Greg and Chris may decide to create a
fork for 2.6.12.x stablization. So linux and linux_2.6.12.x will be seperate
development branches in the same development tree. Patches and revisions
going into the 2.6.12.x branch will not be reflected in the 2.6.12 branch. The
two branches will diverge.

At the same time, unlike tags, their names will remain the same. With each new
revision, the linux_2.6.12.x branch will still refer to that branch with that
new revision. In the case of tagging, the tag name refers only to a single
revision that took place at a specific point in the history of the tree or
branch.

This much I think I understand. What I don't understand is how to actually use
branches. I don't see a Cogito command to create or destroy them.

> 
> Is there a way to use time or relative values (HEAD-1) as "revision" 
> parameters, it would be nice if its not already there.

As far as I know, you use only the SHA1 hash ID or a tag name to identify
revisions. Special cases like HEAD are the exceptions.

Be well,
Zack

> 
> Again, thanks for the update adds very useful information!
> 
> Wink
> 
> 
> 
> 
> -- 
> No virus found in this outgoing message.
> Checked by AVG Anti-Virus.
> Version: 7.0.308 / Virus Database: 266.11.10 - Release Date: 5/13/2005
> 
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
Zack Brown
