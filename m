From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 12:49:37 -0400
Message-ID: <20060913164937.GC29933@spearce.org>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com> <20060913152451.GH23891@pasky.or.cz> <9e4733910609130859v347a7a9ew5c3ebc982bf9b07b@mail.gmail.com> <ee9akc$d62$1@sea.gmane.org> <45083490.9020203@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 13 18:50:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNXvl-0001mK-0m
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 18:49:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750766AbWIMQtm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 12:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750768AbWIMQtm
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 12:49:42 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46520 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750766AbWIMQtl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 12:49:41 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GNXvZ-0001nz-G2; Wed, 13 Sep 2006 12:49:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BA03920E49A; Wed, 13 Sep 2006 12:49:37 -0400 (EDT)
To: A Large Angry SCM <gitzilla@gmail.com>
Content-Disposition: inline
In-Reply-To: <45083490.9020203@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26922>

A Large Angry SCM <gitzilla@gmail.com> wrote:
> Jakub Narebski wrote:
> ...
> > As it was said somewhere in this thread, you can use tags (tag objects) for
> > that, i.e. tag each of the abandoned branches, explaining why branch wa
> > abandoned for example, remove head refs, and move tag refs to
> > refs/abandoned or refs/tags-abandoned/ or refs/Attic/ or in refs-abandoned/
> > (the last has the advantage to not be included by default in any command,
> > even when --all is given)
> 
> Using $GIT_DIR/refs-abandoned/ means changing a number of core parts;
> think fsck and friends. Better to decide on a name in $GIT_DIR/refs/ and
> teach the various visualizers to ignore that prefix by default. Maybe
> even make the name a config item. *ducks*


How about using a regex or a shell wildcard in config such as:

	[core]
		hideRefs = refs/abandoned/
		hideRefs = refs/some-garbage-i-have/

?

-- 
Shawn.
