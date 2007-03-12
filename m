From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] fast-import: use binary search in tree_content_remove
Date: Mon, 12 Mar 2007 15:13:13 -0400
Message-ID: <20070312191313.GC15887@spearce.org>
References: <<20070310191515.GA3416@coredump.intra.peff.net>> <20070310192131.GB3875@coredump.intra.peff.net> <20070310192304.GB3416@coredump.intra.peff.net> <20070310194012.GA5126@coredump.intra.peff.net> <20070311033833.GB10781@spearce.org> <20070311163412.GB7110@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 12 20:13:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQpxS-0007jy-7O
	for gcvg-git@gmane.org; Mon, 12 Mar 2007 20:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752215AbXCLTNS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Mar 2007 15:13:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752254AbXCLTNS
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Mar 2007 15:13:18 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51608 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752215AbXCLTNR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Mar 2007 15:13:17 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HQpxD-0008Cs-5H; Mon, 12 Mar 2007 15:13:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id EA1B120FBAE; Mon, 12 Mar 2007 15:13:13 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070311163412.GB7110@coredump.intra.peff.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42059>

Jeff King <peff@peff.net> wrote:
> And here is a test that I believe triggers the problem (fails with my
> patches, succeeds with your fix):

Thanks, this is a good test to have. Since the current "stable"
version passes without your patches I'm applying the test first;
that way we can see if/when a change breaks this ordering requirement
and address it immediately in that patch.
 
> > I'm plastering over the problem by resorting a tree strictly by
> > name after it has been written out and the deleted entries have
> > been filtered out.
> 
> I wonder if we could make this a bit cleaner by actually using the git
> sort in the first place. I will take a look...

Good luck.  I'm not sure its easily done.  Which is why I'm not
attempting to do it right now.

-- 
Shawn.
