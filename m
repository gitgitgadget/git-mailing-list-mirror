From: Jeff Licquia <jeff@licquia.org>
Subject: Re: VCS comparison table
Date: Sat, 21 Oct 2006 20:07:25 -0400
Message-ID: <1161475645.9241.195.camel@localhost.localdomain>
References: <45357CC3.4040507@utoronto.ca>
	 <20061021191949.GA8096@coredump.intra.peff.net>
	 <20061021214629.GO75501@over-yonder.net>
	 <200610220025.32108.jnareb@gmail.com>
	 <1161474168.9241.188.camel@localhost.localdomain>
	 <8764ed1b7z.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: bazaar-ng@lists.canonical.com, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 22 02:07:39 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbQsG-0005bO-Qb
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 02:07:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161510AbWJVAHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 20:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161514AbWJVAHa
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 20:07:30 -0400
Received: from jeffindy.licquia.org ([216.37.46.185]:20372 "EHLO
	jeffindy.licquia.org") by vger.kernel.org with ESMTP
	id S1161510AbWJVAH3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Oct 2006 20:07:29 -0400
Received: from server1.internal.licquia.org (unknown [192.168.50.3])
	by jeffindy.licquia.org (Postfix) with ESMTP id 239AA6FD88;
	Sat, 21 Oct 2006 20:07:28 -0400 (EDT)
Received: from localhost.localdomain (unknown [192.168.52.6])
	by server1.internal.licquia.org (Postfix) with ESMTP id A33A6980DA;
	Sat, 21 Oct 2006 20:07:27 -0400 (EDT)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id B01644E4025; Sat, 21 Oct 2006 20:07:25 -0400 (EDT)
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <8764ed1b7z.wl%cworth@cworth.org>
X-Mailer: Evolution 2.6.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29694>

On Sat, 2006-10-21 at 16:49 -0700, Carl Worth wrote:
> On Sat, 21 Oct 2006 19:42:47 -0400, Jeff Licquia wrote:
> > I don't think so.  Recently, I've been trying to track a particular
> > patch in the kernel.  It was done as a series of commits, and probably
> > would have been its own branch in bzr, but when I was trying to group
> > the commits together to analyze them as a group, the easiest way to do
> > that was by the original committer's name.
> 
> As far as "its own branch in bzr" would such a branch remain available
> indefinitely even after being merged in to the main tree?

Yes, in the sense that you can recreate the branch by using that
branch's last commit.  But not in the git sense that there's a branch ID
pointing at the commit in question.

You know what?  It occurs to me that much of the problem with git
branches vs. bzr branches might be solved when bzr gets proper tagging
support.  Because, after all, aren't branches more like special tags in
git?

> > Now, there's probably a better way to hunt that stuff down, but in this
> > case hunting the user down worked for me.  (It may have made a
> > difference that I was using gitweb instead of a local clone.)
> 
> Vast, huge, gaping, cosmic difference.
> 
> Almost none of the power of git is exposed by gitweb. It's really not
> worth comparing. (Now a gitweb-alike that provided all the kinds of
> very easy browsing and filtering of the history like gitk and git
> might be nice to have.)

So, very probably, I would have had a far easier time of it if I had
been able to really use git to do the work, instead of gitweb.

I still don't think, though, that it's a sign of a small project to be
concerned about one's own branches more than others.
