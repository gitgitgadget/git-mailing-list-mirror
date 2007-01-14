From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sat, 13 Jan 2007 19:21:52 -0500
Message-ID: <20070114002152.GA18277@spearce.org>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net> <200701140111.20671.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 01:22:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5t8K-0002sm-Q9
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 01:22:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXANAV6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 19:21:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbXANAV5
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 19:21:57 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39144 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbXANAV5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 19:21:57 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5t83-0002nK-IC; Sat, 13 Jan 2007 19:21:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4A36620FBAE; Sat, 13 Jan 2007 19:21:52 -0500 (EST)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Content-Disposition: inline
In-Reply-To: <200701140111.20671.Josef.Weidendorfer@gmx.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36783>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> wrote:
> The wish to allow git-fetch from subdirectories is the
> inconvenience to have to cd up, and later down. This is
> avoided by running "git --top fetch", and theses people
> should be happy.

But not only that, git-fetch *never* alters the working directory.
So it doesn't matter where git-fetch is invoked from, just that
it can find the correct .git directory to run against.  And --top
isn't necessary to do that, the command will find the implied .git
directory own its own.
 
-- 
Shawn.
