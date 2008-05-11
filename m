From: Michael Fischer <michael@visv.net>
Subject: Re: git-svn trouble finding all branches/tags
Date: Sun, 11 May 2008 14:36:30 -0400
Message-ID: <20080511183630.GA11310@marlowe.visv.net>
References: <20080506201602.GB10561@marlowe.visv.net> <20080511085145.GD23929@untitled>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Fischer <michael@visv.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun May 11 20:37:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvGQH-0000uF-Rr
	for gcvg-git-2@gmane.org; Sun, 11 May 2008 20:37:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887AbYEKSge (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 14:36:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756849AbYEKSge
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 14:36:34 -0400
Received: from www.visv.net ([64.81.194.132]:34254 "EHLO visv.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756817AbYEKSgd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 14:36:33 -0400
Received: by visv.net (Postfix, from userid 1000)
	id CE28B6FC269; Sun, 11 May 2008 14:36:30 -0400 (EDT)
Mail-Followup-To: Michael Fischer <michael@visv.net>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080511085145.GD23929@untitled>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81808>

On Sun, May 11, Eric Wong wrote:
> Michael Fischer <michael@visv.net> wrote:
> > 
> > Scenario is initialization  of a local git repo from a remote
> > SVN repo.
> > 
> > 
> > $ git svn init -s https://svn.our.office/projname
> > 
> > $ git svn fetch
> > .........................
> > 
> > Now, git branch -r shows trunk, one branch, 3 tags. There ought to be
> > 7 branches, and about 20 tags.
> > 
> > If I go into .git/svn/.metadata and change the 
> > 
> > branches-maxRev
> > tags-maxRev 
> > 
> > values to something much larger than anything in SVN (e.g. 1000000), 
> > and repeat 'git svn fetch', lather, rinse repeat, then I eventually
> > have all the branches and tags.
> > 
> > Surely this isn't the way its supposed to happen?
> 
> No, I've never actually heard of this problem.  Which version of git-svn
> are you using?
> 
> Without further details about your repository layout, I'm not sure how
> to help you, either.  Is there anything non-standard in your layout
> or how the repository was created?

1.5.4 (or maybe 1.5.5 - I can't log in there right now, but it was 
"latest" as of the date of my original mail).

As far as I know, there's nothing odd in the SVN layout. It has
branches under branches/, tags under tags/, etc...

Now.... my boss did his first attempt by making an SVK copy of the 
SVN repo to his laptop, took that home over the weekend, and the
'git svn fetch' got everything from SVK just fine on the first go.

Not an SVN or SVK expert here, so I'm not sure how that might be
usefully informative or not.. but I thought I'd mention it.


Michael
-- 
Michael Fischer
michael@visv.net
