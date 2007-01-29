From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Add a Checkpoint Action
Date: Mon, 29 Jan 2007 16:10:18 -0500
Message-ID: <20070129211018.GB31075@spearce.org>
References: <20070129162842.11876.31483.stgit@lathund.dewire.com> <20070129163036.11876.78314.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 29 22:10:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBdlh-0006Av-Mg
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 22:10:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752486AbXA2VKX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 16:10:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752599AbXA2VKW
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 16:10:22 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:54337 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752486AbXA2VKW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 16:10:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBdko-0007E4-RB; Mon, 29 Jan 2007 16:09:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B3F7920FBAE; Mon, 29 Jan 2007 16:10:18 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070129163036.11876.78314.stgit@lathund.dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38099>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
>  org.spearce.egit.ui/plugin.xml                     |    9 +++-

All four patches applied and pushed.  The plugin.xml noted above had
some whitespace issues, apparently it is using spaces for indentation
and not tab, so the diff alignment in gitk didn't come out right.
I changed 'em when I applied the patch.  I think there was also
trailing whitespace on one of those lines, so I applied it with
--whitespace=strip.

I was worried about the time required for the CheckpointClockJob,
but hadn't had a chance to use it on a large project.  Thanks for
backing that out, seeing as how its useless...

-- 
Shawn.
