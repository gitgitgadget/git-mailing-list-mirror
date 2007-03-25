From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 17:05:04 -0400
Message-ID: <20070325210504.GG12376@spearce.org>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr> <20070325203901.GB12376@spearce.org> <7v3b3t3uws.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	Eric Lesh <eclesh@ucla.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Mar 25 23:05:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZtr-00022h-U6
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 23:05:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932140AbXCYVFM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 17:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752702AbXCYVFM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 17:05:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60474 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752689AbXCYVFK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 17:05:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVZtZ-0001SV-Kt; Sun, 25 Mar 2007 17:04:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D669720FBAE; Sun, 25 Mar 2007 17:05:04 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v3b3t3uws.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43077>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Actually, I'd almost say put it into .git/config, e.g.:
> >
> > 	mkdir .git
> > 	cat >.git/config <<EOF
> > 	[core]
> > 		repositoryversion = 0
> > 		filemode = true
> > 		link = /path/to/source
> > 	EOF
> >
> > as then the index and HEAD file can both be stored in .git, just
> > like with the non-gitlink case.
> 
> This is not usable at least for me as it does not allow sharing
> the .git/config file across checkouts.

Me either.

What I thought of after writing that was that core.link should
also imply reading ${core.link}/config before .git/config, so that
the repository config can override the master repository, but the
master repository provides the bulk of the configuration.

-- 
Shawn.
