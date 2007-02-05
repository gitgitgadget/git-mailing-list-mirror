From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] add --remote option to git-clone.
Date: Mon, 5 Feb 2007 14:34:29 -0500
Message-ID: <20070205193429.GA8409@spearce.org>
References: <Pine.LNX.4.63.0702020028540.18776@wbgn013.biozentrum.uni-wuerzburg.de> <20070201234706.GP17617@mellanox.co.il> <Pine.LNX.4.63.0702020050190.18870@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz3xmju9.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702021146440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz3wdjxu.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0702051245050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz3smqpp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0702051014040.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org, "Michael S. Tsirkin" <mst@mellanox.co.il>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Feb 05 20:34:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE9bv-0008VJ-FP
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 20:34:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933400AbXBETek (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 14:34:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933418AbXBETek
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 14:34:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:33063 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933400AbXBETej (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 14:34:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HE9bc-0002iD-5I; Mon, 05 Feb 2007 14:34:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E955A20FBAE; Mon,  5 Feb 2007 14:34:29 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0702051014040.8424@woody.linux-foundation.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38771>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> I realize that the
> 
> 	git clone <repo> [<dir>]
> 
> means that we can't have the same syntax as "git pull" (which doesn't take 
> the <dir> part), but that doesn't make the "#branch" syntax any better.
> 
> So I much prefer the
> 
> 	git clone [--default branch] [--branch x]* <repo> [<dir>]
> 
> kind of syntax.

Ugh.  That means the bash completion cannot (easily) do something
fancy, like tab completion of branch names within <repo>.  Yea,
its not fast on slow links, but it beats typing out an ugly branch
name.  :-)

-- 
Shawn.
