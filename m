From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Merge git-gui into 1.5.0 ?
Date: Sun, 11 Feb 2007 03:40:30 -0500
Message-ID: <20070211084030.GE2082@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 11 09:40:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGAGH-0000Ue-F0
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 09:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753162AbXBKIki (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 03:40:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753163AbXBKIki
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 03:40:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54514 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753162AbXBKIkh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 03:40:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HGAGA-0006so-35
	for git@vger.kernel.org; Sun, 11 Feb 2007 03:40:34 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE9EB20FBAE; Sun, 11 Feb 2007 03:40:30 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39277>

One of my goals for git-gui is to get it merged into core Git, so
there is a GUI tool available out-of-the-box for commit creation,
(some) branch manipulation, basic merging, and pushing/fetching
changes.

I'm wondering, should that start to occur as part of 1.5.0?
Its one .sh script, like gitk.  :)

Given all of the other changes going into 1.5.0, and how much news
we're probably going to try to attract to this release, it may be
nice to be able to say "we also have a commit creating GUI".


The main idea behind git-gui is to provide a complete enough UI
that someone can work on files stored in a Git repository without
needing to drop to the command line.  By sticking to Tcl/Tk,
git-gui is available anywhere gitk is.

It would be nice if all operations available on the command line
were also available through git-gui, but I think that is a very
difficult goal to reach.  The command line interface is simply more
powerful and much more expressive.  So I'm really just aiming to
make an interface that the average user can use to do collaboration
through Git, without needing to fall back on git-cvsserver and a
CVS client.  I fully expect 'power' users to use the command line.
You know who you are.  ;-)

That said, operations like `git gui blame rev file` may simply
be better in the GUI, even for power users, as it offers some way
to visualize the annotation data and navigate through it.  So I'm
also trying to make those parts of git-gui easily available from
the command line, when possible.

Another example is `git gui citool` (or `git citool` if git-citool
is a symlink/hardlink to git-gui), which will open the UI for
just one commit.  Users of that-other-SCM-used-before-Git's citool
subcommand may like this feature, as it offers somewhat similiar
functionality, and some nice extras.  ;-)


Right now git-gui is being used in production by myself and about 5
other coworkers of mine (the rest were either die-hard command line
users already, or found out how useful the command line is and now
refuse to give it up!).  It has thus far proven to be pretty stable
and easy to use.  Its running stably on both Mac OS X and Windows.

It is also lacking the critical `git clone` operation.  ;-)


Thoughts?  Anyone interested can check out the repository:

  gitweb:  http://repo.or.cz/w/git-gui.git
  git:     git://repo.or.cz/git-gui.git

-- 
Shawn.
