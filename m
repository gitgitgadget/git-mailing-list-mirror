From: Jan Hudec <bulb@ucw.cz>
Subject: Re: VCS comparison table
Date: Sun, 22 Oct 2006 09:45:13 +0200
Message-ID: <20061022074513.GF29927@artax.karlin.mff.cuni.cz>
References: <Pine.LNX.4.64.0610172014250.3962@g5.osdl.org> <4536EC93.9050305@utoronto.ca> <87lkncev90.wl%cworth@cworth.org> <453792A8.1010700@utoronto.ca> <878xjc2qeb.wl%cworth@cworth.org> <453803E6.2060309@utoronto.ca> <87ods727pn.wl%cworth@cworth.org> <45382120.9060702@utoronto.ca> <87irie1wvv.wl%cworth@cworth.org> <453A7D7E.8060105@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Worth <cworth@cworth.org>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 09:45:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbY1D-0000gX-5f
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 09:45:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423133AbWJVHpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 03:45:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932164AbWJVHpK
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 03:45:10 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:65434 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S932149AbWJVHpI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 03:45:08 -0400
Received: by artax.karlin.mff.cuni.cz (Postfix, from userid 17196)
	id BCFBA4E45; Sun, 22 Oct 2006 09:45:13 +0200 (CEST)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <453A7D7E.8060105@utoronto.ca>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29710>

On Sat, Oct 21, 2006 at 04:05:18PM -0400, Aaron Bentley wrote:
> Carl Worth wrote:
> > On Thu, 19 Oct 2006 21:06:40 -0400, Aaron Bentley wrote:
> [...]
> > But it really is fundamental and unavoidable that sequential numbers
> > don't work as names in a distributed version control system.
> 
> Right.  You need something guaranteed to be unique.  It's the revno +
> url combo that is unique.  That may not be permanent, but anyone can
> create one of those names, so it is decentralized.

But it is *not* *distributed*. The definition of a distributed system
among other things require, that resource identifiers are independent on
the location of the resources. So only using the revision-ids is really
distributed.

> >> I meant that the active branch and a mirror of the abandoned branch
> >> could be stored in the same repository, for ease of access.
> > 
> > Granted, everything can be stored in one repository. But that still
> > doesn't change what I was trying to say with my example. One of the
> > repositories would "win" (the names it published during the fork would
> > still be valid). And the other repository would "lose" (the names it
> > published would be not valid anymore). Right?
> 
> No.  It would be silly for the losing side to publish a mirror of the
> winning branch at the same location where they had previously published
> their own branch.  So the old number + URL combination would remain valid.

I regularly use bzr and I never used git. But I'd not hesitate a second
to pull --overwrite over the old location. Because the url has a meaning
"the base I develop against" for me and I'd want to preserve that
meaning.

> If the losing faction decided to maintain their own branch after the
> merge, they'd have two options
> 
> 1. continue to develop against the losing "branch", without updating its
> numbers from the "winning" branch.  It would be hard to tell who had won
> or lost in this case.
> 
> 2. create a new mirror of the "winning" branch and develop against that.
>  I'm not sure what this point of this would be.
> 
> I think the most realistic thing in this scenario is that they leave the
> "losing" branch exactly where it was, and develop against the "winning"
> branch.
> 
> >> Bazaar encourages you to stick lots and lots of branches in your
> >> repository.  They don't even have to be related.  For example, my repo
> >> contains branches of bzr, bzrtools, Meld, and BazaarInspect.
> > 
> > Git allows this just fine. And lots of branches belonging to a single
> > project is definitely the common usage. It is not common (nor
> > encouraged) for unrelated projects to share a repository, since a git
> > clone will fetch every branch in the repository.
> 
> Right.  This is a difference between Bazaar and Git that's I'd
> characterize as being "branch-oriented" vs "repository-oriented".  We'll
> see more of this below.

This is one of things I on the other hand like better on bzr than git.
Because it is really branches and not repositories that I usually care
about.

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
