From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach Git how to parse standard power of 2 suffixes.
Date: Sun, 31 Dec 2006 01:26:18 -0500
Message-ID: <20061231062618.GD6106@spearce.org>
References: <20061231031305.GA5620@spearce.org> <7vy7ooip6y.fsf@assigned-by-dhcp.cox.net> <20061231061232.GC6106@spearce.org> <7vpsa0inwr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 31 07:26:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H0u9M-0004vI-IS
	for gcvg-git@gmane.org; Sun, 31 Dec 2006 07:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933031AbWLaG0X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 31 Dec 2006 01:26:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933033AbWLaG0X
	(ORCPT <rfc822;git-outgoing>); Sun, 31 Dec 2006 01:26:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45845 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933031AbWLaG0W (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Dec 2006 01:26:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1H0u9Q-0005ps-BY; Sun, 31 Dec 2006 01:26:32 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5068920FB65; Sun, 31 Dec 2006 01:26:18 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vpsa0inwr.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35681>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Junio C Hamano <junkio@cox.net> wrote:
> >
> >> Why?  Are you allowing "1024 k"?  Do we want to?
> >
> > Yes.  Why not?
> 
> Stricter input checking.  Allowing extra things later is far
> easier than later finding problems with a looser way we started
> from and having to tighten it.

Good point.  I'm currently writing tests for this btw.

-- 
Shawn.
