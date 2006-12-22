From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cloning the kernel - why long time in "Resolving 313037 deltas"
Date: Thu, 21 Dec 2006 20:56:56 -0500
Message-ID: <20061222015656.GE14773@spearce.org>
References: <86y7p57y05.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181251020.3479@woody.osdl.org> <86r6uw9azn.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181625140.18171@xanadu.home> <86hcvs984c.fsf@blue.stonehenge.com> <Pine.LNX.4.64.0612181414200.3479@woody.osdl.org> <8664c896xv.fsf@blue.stonehenge.com> <46a038f90612181502y3e2a41cds7f16113ad0270f31@mail.gmail.com> <991F50E2-2C98-4710-84C5-3D7348E00B64@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	"Randal L. Schwartz" <merlyn@stonehenge.com>,
	Linus Torvalds <torvalds@osdl.org>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 02:57:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxZen-00020r-N5
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 02:57:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945915AbWLVB5G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 20:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945909AbWLVB5G
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 20:57:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:60086 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945908AbWLVB5F (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 20:57:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GxZeR-00052n-Tw; Thu, 21 Dec 2006 20:56:48 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B7DFE20FB65; Thu, 21 Dec 2006 20:56:56 -0500 (EST)
To: Kyle Moffett <mrmacman_g4@mac.com>
Content-Disposition: inline
In-Reply-To: <991F50E2-2C98-4710-84C5-3D7348E00B64@mac.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35116>

Kyle Moffett <mrmacman_g4@mac.com> wrote:
> Just as an example, it takes my OS-X-running Quad-2.5GHz G5 ten times  
> as long to do a "grep -rl foo linux/" as my Linux-running dual-1GHz  
> G4 with 400MHz system bus.  This is disk-cache-hot too.  And that's  
> not even a stat-heavy workload.  There's more than one reason I'm  
> trying to make a Mac OS X ABI emulation layer on top of Linux :-D.

Try 'git grep foo' instead; its very fast if you are working with
a fully packed Git repository.

Doesn't help any other application on Mac OS X however. :-(

-- 
Shawn.
