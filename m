From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Full disk behavior of git
Date: Sat, 17 Feb 2007 01:31:31 -0500
Message-ID: <20070217063130.GC27864@spearce.org>
References: <17877.56557.546383.815806@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Sat Feb 17 07:31:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIJ6h-0003UB-7p
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 07:31:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946419AbXBQGbg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 01:31:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946420AbXBQGbg
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 01:31:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60025 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946419AbXBQGbf (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 01:31:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HIJ6b-0004zu-Hj; Sat, 17 Feb 2007 01:31:33 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 65B0120FBAE; Sat, 17 Feb 2007 01:31:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17877.56557.546383.815806@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39968>

Bill Lear <rael@zopyra.com> wrote:
> As a final point, our "build master" now informs me that he has
> been trapping error status from git pull, e.g.:
> 
>   git pull || { echo "pull failed"; exit 1; }
> 
> however, it appears that the pull read errors above are not resulting
> in an error status being returned.

This was a bug in the 1.4.4.x series.  It has been fixed in 1.5.0.
Upgrade.  :-)

-- 
Shawn.
