From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Create 'git gc' to perform common maintenance operations.
Date: Wed, 27 Dec 2006 03:33:28 -0500
Message-ID: <20061227083328.GD23022@spearce.org>
References: <20061227071759.GA23057@spearce.org> <7vr6ul93wz.fsf@assigned-by-dhcp.cox.net> <20061227075330.GA23022@spearce.org> <7vhcvh922r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 27 09:33:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GzUEC-0004eI-Va
	for gcvg-git@gmane.org; Wed, 27 Dec 2006 09:33:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753609AbWL0Ide (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 03:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbWL0Idd
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 03:33:33 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56282 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753610AbWL0Idd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 03:33:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GzUED-0006AW-7M; Wed, 27 Dec 2006 03:33:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4166C20FB65; Wed, 27 Dec 2006 03:33:29 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhcvh922r.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35457>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > I don't care either way.  60 days may be too long for some users,
> > but for others it may be nice to have.  I think the two defaults
> > should match just because.  Feel free to edit my patch before
> > applying to be whatever 'git-reflog expire' uses if you want.
> 
> I think the built-in git-reflog should be updated to honor the
> configuration in the absense of command line options; if we do
> that git-gc.sh does not even have to call repo-config anymore.

Sure, but then maybe the configuration options shouldn't be
'gc.reflog*' but instead 'reflog.*'.

git-gc.sh was a quick hack while I was waiting for that huge disk
IO to repack a git.git with 1.3.3.  I was trying to avoid hacking
C code for it, but you are probably right, better to just make the
C code do the right thing from "day one".

-- 
Shawn.
