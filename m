From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 10:56:53 -0500
Message-ID: <20070130155653.GB25950@spearce.org>
References: <200701292320.43888.johannes.sixt@telecom.at> <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org> <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070130151803.GA25779@spearce.org> <Pine.LNX.4.63.0701301635050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 30 17:07:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvMK-0003yX-J8
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 16:57:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965403AbXA3P5K (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 10:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965386AbXA3P5K
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 10:57:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:59567 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965308AbXA3P5J (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 10:57:09 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HBvLm-0004Er-EU; Tue, 30 Jan 2007 10:56:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ABDBB20FBAE; Tue, 30 Jan 2007 10:56:53 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701301635050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38162>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Tue, 30 Jan 2007, Shawn O. Pearce wrote:
> > Just curious, but were these tests run with mmap(), or NO_MMAP?
> 
> Both with NO_MMAP=YesPlease.

I wonder what the difference is between NO_MMAP=Yes and NO_MMAP=
on Windows.  This is something I've never tried, but probably should
do.  I run about ~25 developers on NO_MMAP= on Windows (all NTFS)
without issue, but now I'm curious if there's an actual performance
difference for some operations.  There's no real rationale behind
my NO_MMAP= setting, other than that's how we've always used it...
 
> That said, I find the numbers quite convincing. On a (much weaker 
> equipped) Linux bux, it takes 0.65s and 1.2s, respectively.

The time difference between the MinGW and Cygwin ports of Git
is certainly an interesting one, and says good things about the
MinGW work.

We're paying a price for POSIX compatibility on Windows, and its a
pretty high one it seems.  I can't blame the Cygwin folks, they've
done a great job at trying to make the most of VMS.  But sometimes
you just need Linux (or *BSD, or Solaris).  :-)

-- 
Shawn.
