From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 10:18:03 -0500
Message-ID: <20070130151803.GA25779@spearce.org>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org> <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 30 16:27:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBukg-0005Wm-2I
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 16:18:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965570AbXA3PSX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 10:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965600AbXA3PSX
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 10:18:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57789 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965570AbXA3PSW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 10:18:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBukC-0008M5-VP; Tue, 30 Jan 2007 10:18:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9FEB220FBAE; Tue, 30 Jan 2007 10:18:03 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38157>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On the git repository, using MinGW:
> Using cygwin:
> 
> IOW MinGW wins hands down with an average 0.33s vs cygwin with an average 
> 0.75s. (I am fairly certain that you must not trust sys times.)

Just curious, but were these tests run with mmap(), or NO_MMAP?

Clearly, for a packed repository most of the overhead should be
in getting to the pack data itself (as everything else is pure
userspace).

-- 
Shawn.
