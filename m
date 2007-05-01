From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 0/8] git-repack --max-pack-size
Date: Tue, 1 May 2007 00:37:53 -0400
Message-ID: <20070501043753.GW5942@spearce.org>
References: <463678B7.70409@gmail.com> <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 01 06:38:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hik7u-00032Z-Sr
	for gcvg-git@gmane.org; Tue, 01 May 2007 06:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030919AbXEAEiB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 1 May 2007 00:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031585AbXEAEiA
	(ORCPT <rfc822;git-outgoing>); Tue, 1 May 2007 00:38:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60349 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030919AbXEAEh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2007 00:37:59 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1Hik7g-0007C2-1A; Tue, 01 May 2007 00:37:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id DE7CF20FBAE; Tue,  1 May 2007 00:37:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7v7irt9qm1.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45910>

Junio C Hamano <junkio@cox.net> wrote:
> Heh, since last night, 'master' and 'next' points at exactly the
> same tree object, although their commit ancestry are vastly
> different for obvious reasons.
> 
> Which leaves 'master' right now at v1.5.2-rc1 while 'next' at
> v1.5.2-rc1-687-gcb3892c; we might want to do something about
> this apparent discrepancy.

Are you considering rewinding next to master?  I'm not sure how
else we could cancel out all of those merges and reverts of bad
ideas from next.

One option might be to teach git-describe to look for matching trees,
and see if git-describe could match the tree that v1.5.2-rc1 points
at with the tree that cb3892c points and, and just call the latter
the former...  But that sounds a little risky to me in some projects,
I'm not convinced that is always the right way to describe a history.

-- 
Shawn.
