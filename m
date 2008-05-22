From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gui: Possible to see which commands are executed?
Date: Thu, 22 May 2008 19:05:45 -0400
Message-ID: <20080522230545.GR29038@spearce.org>
References: <48301B17.30309@dirk.my1.cc> <20080519022125.GV29038@spearce.org> <4833206E.1080300@dirk.my1.cc> <20080520194403.GC29038@spearce.org> <bd6139dc0805201305k61807561k8026b4c6509e4041@mail.gmail.com> <20080520201722.GF29038@spearce.org> <bd6139dc0805201322r6c8dae8cy45d31af6c25fd25a@mail.gmail.com> <20080520203153.GH29038@spearce.org> <320075ff0805221355y6d5dd4dcgdd12fad9582ea588@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Nigel Magnay <nigel.magnay@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 23 01:06:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JzJrs-0000Td-9z
	for gcvg-git-2@gmane.org; Fri, 23 May 2008 01:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173AbYEVXFt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 May 2008 19:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755214AbYEVXFt
	(ORCPT <rfc822;git-outgoing>); Thu, 22 May 2008 19:05:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57269 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067AbYEVXFs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 May 2008 19:05:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JzJqq-0004jT-IP; Thu, 22 May 2008 19:05:36 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4CCDA20FBAE; Thu, 22 May 2008 19:05:45 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <320075ff0805221355y6d5dd4dcgdd12fad9582ea588@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82668>

Nigel Magnay <nigel.magnay@gmail.com> wrote:
> 
> git-gui is good though - but there's a few things I wish it had. I
> often find the need to flip between git gui and gitk (for a 'where the
> heck am I at the moment' overview) - the 2 tools seems to confuse
> people coming at git, even given 'visualize branch'.

Yup.  I haven't tried to reimplement a visualizer in git-gui, nor
have I tried to embed gitk into git-gui.  Both would take a great
deal of work I think (though embedding gitk is likely easier) and I
just have too many things going on to pursue this myself.  If someone
showed patches for this, I'd definately try to get them included.

> It'd be nice to
> be able to add files / directories to .gitignore,

Always been a "wishlist" feature for git-gui.  Paul Mackerras' gitool
prototype (which is what seeded git-gui) had this feature, but it was
never carried into git-gui.  Again, patches welcome.  :-)

> and to view the
> staged/unstaged changes as trees - helpful for when a build has
> created a non-ignored directory with thousands of files.

Yea.  And when that happens to me I immediately slap the directory
into my .gitignore or .git/info/exclude and rescan to make the huge
pile of untracked files disappear.  So a tree view in git-gui has
never been something I wanted.  Trees in Tcl/Tk are also horrible
to implement.  The toolkit just has never been very good at that
sort of thing.

> Maybe I
> should get qgit - but git gui has the massive advantage of being in
> every install by default, and so is available in msysgit.

Yes, I have to admit that git-gui's popularity among git users has a
_lot_ to do with the simple fact that it ships out of the box as part
of Junio's git releases.  Since most git users have Tcl/Tk available
so they can use gitk, git-gui is also ready-to-go, with no extra libs
needed on your system.

However, QGit is also a good program, and has many loyal users.
There are benefits and drawbacks to both GUIs.
 
> Whilst I'm thinking about it - I'm surprised in retrospect how little
> prominence the index is given in the frontends I've seen.

Really?  git-gui is all about the index.

> It's easy,
> coming from SVN, to gloss over the index as the same as just checking
> off files at commit time, and miss stuff like 'git add --patch' and
> 'git mergetool' altogether.

Right click on a hunk in the diff pane in git-gui and stage/unstage
it?  Its about as good as `git add --patch`.  Or better, depending
on how you work.

-- 
Shawn.
