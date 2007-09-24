From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: The msysGit Herald, issue 2
Date: Sun, 23 Sep 2007 22:48:28 -0400
Message-ID: <20070924024828.GE3099@spearce.org>
References: <Pine.LNX.4.64.0709232153230.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: msysgit@googlegroups.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Sep 24 04:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZdzz-0002sh-3p
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 04:48:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754420AbXIXCsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 22:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755029AbXIXCsd
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 22:48:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57479 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754849AbXIXCsd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 22:48:33 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IZdze-0005ra-Bg; Sun, 23 Sep 2007 22:48:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 0CF1D20FBAE; Sun, 23 Sep 2007 22:48:29 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0709232153230.28395@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59015>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> Maybe we'll get to the state where a link to git gui is installed in
> addition to the "Git Shell"

I'm hoping that becomes possible as part of the 0.9.x series of
git-gui.  My latest master branch in git-gui.git contains a new
startup wizard that can be used to do one of three common actions:

  - Clone a repository
  - Create a new repository
  - Open an existing repository

Dscho has already seen this wizard.  Its certainly meant to help
with linking to git-gui from "Begin" menus on systems that probably
should have been called "Wide Open Doors" (given their security
track record).  Currently the only way to get the wizard to launch
is to run `git gui` from a pwd that isn't contained within a Git
repository.
 
> > 5) What was the most surprising moment when working with Git?
> 
> It merged a change I made in an old branch in a file that was moved in
> the new branch to a new location. IOW, merge across renames. Really, I
> was so surprised - I wanted to start the manual merge when I discovered
> that git had done all the work for me.

Heh.  That always gets me too.  Especially when applying git-gui
patches made against git.git, but to my git-gui tree.  `git-am -3`
Just Does The Right Thing(tm).  I can't ask for more from a source
code control system.
 
> > 6) What was the most frustrating moment when working with Git?
> 
> Just the other day, I wanted to fetch a set of changes from a public
> repo into my test repo in order to cherry-pick from them - and it
> automatically fetched all the tags. But, the heck, I don't want them tags
> here, just the commits. I just can't figure out how to avoid the automatic
> fetching of tags.

Its called `git fetch --no-tags`.  You can also setup a config
option of "remote.$name.tagopt = --no-tags" to tell git-fetch to
not fetch tags when fetching from that remote.

But yea, I too hate the fact that Git cannot read my mind and realize
that although I usually do want to fetch tags, right now I don't,
even though I forgot to tell it that with --no-tags.  :)

So my most frustrating moment when working with Git was realizing
that Linus didn't supply `git-read-users-mind`.  Sadly it only
comes with `git-read-tree`.  Ah, well, at least my maple and pine
are understood.
 
-- 
Shawn.
