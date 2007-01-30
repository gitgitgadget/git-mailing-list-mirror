From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 11:28:35 -0500
Message-ID: <20070130162835.GD25950@spearce.org>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org> <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070130151803.GA25779@spearce.org> <Pine.LNX.4.63.0701301635050.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070130155653.GB25950@spearce.org> <Pine.LNX.4.63.0701301708160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 30 17:29:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvql-0005th-1N
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:28:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092AbXA3Q2r (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:28:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752487AbXA3Q2r
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:28:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32795 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752092AbXA3Q2q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:28:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBvqR-00078R-Iz; Tue, 30 Jan 2007 11:28:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 2A6D520FBAE; Tue, 30 Jan 2007 11:28:35 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701301708160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38165>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > I wonder what the difference is between NO_MMAP=Yes and NO_MMAP=
> > on Windows.
> Cygwin:
> 	real    0m0.812s
> and
> 	real    0m2.094s
> 
> IOW, the numbers are slightly worse (!) than with mmap().

Slightly?  That's double the time!
 
> MinGW does not even have mmap().

But Windows has something almost there.  I just read a flame war
thread about implementing mmap in libiberty for MinGW by stealing
source from Cygwin, and how the FSF might feel about someone's
dirty feet after playing rugby.  Yea... Google is good.  :)

-- 
Shawn.
