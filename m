From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Tue, 30 Jan 2007 10:31:26 -0500
Message-ID: <20070130153126.GC25779@spearce.org>
References: <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701281107050.25027@woody.linux-foundation.org> <7vveirdkpb.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701281143190.25027@woody.linux-foundation.org> <7vodog3m3f.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jan 30 16:39:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBuxp-00027j-3r
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 16:32:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965617AbXA3Pbl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 10:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965616AbXA3Pbl
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 10:31:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58395 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965614AbXA3Pbj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 10:31:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBux9-0001EJ-Hx; Tue, 30 Jan 2007 10:31:23 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C1CF620FBAE; Tue, 30 Jan 2007 10:31:26 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vodog3m3f.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38159>

Junio C Hamano <junkio@cox.net> wrote:
> This is a WIP to make "git blame" without any positive rev to
> start digging from the working tree copy, which is made into a
> fake commit whose sole parent is the HEAD.

I hate to be a stick in the mud, but including MERGE_HEAD as parents
of the virtual commit would also be nice.  Then you can get a blame
on conflicted files while in the middle of a merge and are working
on sorting the mess out.  :-)

Yea, MERGE_HEAD is really strictly for git-merge and git-commit,
but here its got some use too.

-- 
Shawn.
