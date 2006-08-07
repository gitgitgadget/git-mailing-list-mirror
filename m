From: Shawn Pearce <spearce@spearce.org>
Subject: Re: EGIT packed delta format reading
Date: Mon, 7 Aug 2006 00:07:07 -0400
Message-ID: <20060807040707.GB20514@spearce.org>
References: <20060806183748.7591.61536.stgit@lathund.dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 07 06:07:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9wOb-0004ZX-Vr
	for gcvg-git@gmane.org; Mon, 07 Aug 2006 06:07:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751008AbWHGEHM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Aug 2006 00:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWHGEHL
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Aug 2006 00:07:11 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:15046 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751008AbWHGEHK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Aug 2006 00:07:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G9wOG-0002DZ-AI; Mon, 07 Aug 2006 00:06:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5530620FB77; Mon,  7 Aug 2006 00:07:07 -0400 (EDT)
To: Robin Rosenberg <robin.rosenberg@dewire.com>
Content-Disposition: inline
In-Reply-To: <20060806183748.7591.61536.stgit@lathund.dewire.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24995>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Hi,
> 
> I deciced to take Shawns Eclipse plugin for a run. There was
> some problem reading the pack files that seemed to work after
> applying the following fixes, i.e. I could connect to the
> project and the interal structures looks ok in the debugger
> as far as I can tell, but decorations don't work. That's as
> far as I've been testing up to now.

I'll take a look at it again, as soon as I get the tree entry
sorting fixed.
 
> BTW. How should EGIT patches be formatted to distingish them
> from git patches? I'm sending this using StGit.

You can use StGit to send patches, or any other GIT based tool.
After all, we're using GIT.  :-)

As far as marking patches specifically as an egit/jgit patch you can
send them directly to me and CC: the mailing list.  The egit/jgit
file names are pretty distinctive, just as the core GIT and Cogito
file names are.  I doubt folks will get confused as to which project
a patch belongs to...

-- 
Shawn.
