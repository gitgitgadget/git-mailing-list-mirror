From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: More precise tag following
Date: Mon, 29 Jan 2007 01:18:07 -0500
Message-ID: <20070129061807.GA4634@spearce.org>
References: <7vy7nqxd08.fsf@assigned-by-dhcp.cox.net> <20070127080126.GC9966@spearce.org> <Pine.LNX.4.64.0701270837170.25027@woody.linux-foundation.org> <Pine.LNX.4.64.0701270945260.25027@woody.linux-foundation.org> <7vzm84gmei.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701271439340.25027@woody.linux-foundation.org> <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Jan 29 07:18:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBPqU-0000ci-Mr
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 07:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933145AbXA2GSO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 01:18:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933166AbXA2GSO
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 01:18:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54240 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933145AbXA2GSN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 01:18:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBPpY-00077G-4X; Mon, 29 Jan 2007 01:17:28 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 733A420FBAE; Mon, 29 Jan 2007 01:18:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vps8zfqlx.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38063>

Junio C Hamano <junkio@cox.net> wrote:
> Yes and no -- it might be interesting to start from a blank
> canvas, and insert the lines as they are received at appropriate
> places (recorded as ent->lno), although in general I agree the
> GUI would have the way and the need to grab the blob contents
> without us giving it in the --incremental output.

I just implemented the blame --incremental thing in git-gui.
I'm grabbing the file data ahead of time with git-cat-file, throwing
up the UI, then streaming in the incremental blame data as it comes.
Its *VERY* fast.  Nice job to both of you (Linus and Junio).

If you are curious its been pushed to repo.or.cz:

  git://repo.or.cz/git-gui.git

  Repository->Browse Current Branch
  Double click on the file you want to see.

I'm going to work up screenshots a bit later.

-- 
Shawn.
