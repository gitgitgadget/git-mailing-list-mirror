From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why do base objects appear behind the delta in packs?
Date: Tue, 29 Aug 2006 14:32:39 -0400
Message-ID: <20060829183239.GH21729@spearce.org>
References: <20060829134233.GA21335@spearce.org> <ed1kn3$c3r$1@sea.gmane.org> <20060829162747.GA21729@spearce.org> <7v8xl7moo7.fsf@assigned-by-dhcp.cox.net> <20060829174448.GD21729@spearce.org> <Pine.LNX.4.64.0608291410290.9796@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 29 20:33:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GI8OR-0003jR-US
	for gcvg-git@gmane.org; Tue, 29 Aug 2006 20:33:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965252AbWH2Sco (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Aug 2006 14:32:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965253AbWH2Sco
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Aug 2006 14:32:44 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27112 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965249AbWH2Scn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Aug 2006 14:32:43 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GI8O2-00009o-03; Tue, 29 Aug 2006 14:32:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 111AE20FB7F; Tue, 29 Aug 2006 14:32:40 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608291410290.9796@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26212>

Nicolas Pitre <nico@cam.org> wrote:
> I look forward to being able to use your (and Jon's) fast-import work in 
> order to play with (re)generation of big packs myself.

My repository is here:

  http://www.spearce.org/projects/scm/git.git

branch 'refs/heads/sp/fastpack'.

I'd appreciate it if folks didn't clone directly from me but instead
used an existing clone to pull the branch down into.  Its based on
a fairly recent 'next' branch.  Anything not available via Junio's
'next' on kernel.org is loose objects in this repository and are
specific to my fast-import work.

Documentation of the protocol used to stuff a pack is in the
header of fast-import.c.  Its a relatively trivial stream format.
It should be quite simple to generate a random large project and
pipe it into fast-import to get a resulting pack to play with.

I don't have Jon's cvs2svn code and I don't know if its ready for
public consumption yet.  git-fast-import however looks like its
almost there, so I'm making the URL publicly available for those
that may be interested in it.

[Junio: please do the lazy thing and don't pull this into Git just
 yet, I don't think this branch is ready for that, not even for pu.]

-- 
Shawn.
