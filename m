From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn throwing assertion on old svn tracking branch
Date: Fri, 22 Dec 2006 22:45:31 -0800
Message-ID: <20061223064531.GB10460@localdomain>
References: <20061220235551.GA2974@hermes.lan.home.vilz.de> <20061221010520.GB3901@localdomain> <20061222013510.GA9595@hermes> <20061222021613.GB9595@hermes> <20061222083803.GD26800@hand.yhbt.net> <20061222094337.GC9595@hermes>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 23 07:45:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gy0dg-0006ib-Hq
	for gcvg-git@gmane.org; Sat, 23 Dec 2006 07:45:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752501AbWLWGpe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 23 Dec 2006 01:45:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752532AbWLWGpe
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Dec 2006 01:45:34 -0500
Received: from hand.yhbt.net ([66.150.188.102]:38648 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752501AbWLWGpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Dec 2006 01:45:33 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id D5EAA7DC02A;
	Fri, 22 Dec 2006 22:45:31 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Fri, 22 Dec 2006 22:45:31 -0800
To: Nicolas Vilz <niv@iaglans.de>
Content-Disposition: inline
In-Reply-To: <20061222094337.GC9595@hermes>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35277>

Nicolas Vilz <niv@iaglans.de> wrote:
> On Fri, Dec 22, 2006 at 12:38:03AM -0800, Eric Wong wrote:
> > Nicolas Vilz <niv@iaglans.de> wrote:
> > > On Fri, Dec 22, 2006 at 02:35:10AM +0100, Nicolas Vilz wrote:
> > > > On Wed, Dec 20, 2006 at 05:05:20PM -0800, Eric Wong wrote:
> > > > > Nicolas Vilz <niv@iaglans.de> wrote:
> > > [...]
> > > > beneath there is svn, version 1.4.2 (r22196) ... on that repository is
> > > > Subversion version 1.1.4 (r13838).
> > > 
> > > i should ammend, that the same error message comes, when i want to
> > > dcommit something in this repository...
> > 
> > Weird, so you have the SVN:: libraries installed? (dcommit requires it).
> > Is the repository you're tracking public?  If so, I'd like to have a
> > look...
> unfortunatelly, its not public...
> 
> I noticed, it is not the step of committing anything, but the step to
> fetch the revisions in the svn tree. I had a workaround last night... I
> used the documentation on Advanced Example: Tracking a Reorganized
> Repository to reorganize my tree from broken old repository to
> reorganized fresh tree that is working... that all because time was
> running out this night and i had to work something.

So the repository was reorganized?  That could be it...

> I keep the old one as a souvenier... The problem lies somewhere there in
> the old branch. The history is not lost here in any case.

Good to know :)

> I backuped my repository and pruned my tree as you suggested it... I
> connected to that remote repository... and then the assertion came down
> on me. Personally i can live with that reorganized repository. If you
> are really keen on digging the error down to ground, i could try to
> setup something.
> 
> Perhaps back were i worked on that repository, git-svn accessed a little
> different from now....
 
Some things have changed such as allowing access to repositories with
limited read permissions.  I'm not sure how/if that affects you.  If you
have time, can you try going back to revision
30d055aa1e45b4740edc3bfbff77fa5d65e106ff?  Or try bisecting...

-- 
Eric Wong
