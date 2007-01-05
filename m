From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 4 Jan 2007 21:59:21 -0500
Message-ID: <20070105025921.GA14042@spearce.org>
References: <7vwt4647g0.fsf@assigned-by-dhcp.cox.net> <81b0412b0701041022h30cd4fcxd62dbf3ecb504ea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 03:59:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2fIv-0005wI-Nm
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 03:59:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030297AbXAEC72 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 21:59:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030303AbXAEC72
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 21:59:28 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52475 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030297AbXAEC71 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 21:59:27 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H2fIW-0000Gv-M4; Thu, 04 Jan 2007 21:59:12 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 450E920FB65; Thu,  4 Jan 2007 21:59:22 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0701041022h30cd4fcxd62dbf3ecb504ea9@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35971>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 1/2/07, Junio C Hamano <junkio@cox.net> wrote:
> >Here are the topics that have been cooking.  Commits prefixed
> >with '-' are only in 'pu' while commits prefixed with '+' are
> >in 'next'.  The topics list the commits in reverse chronological
> >order.
> >
> >* sp/mmap (Sat Dec 30 22:13:43 2006 -0500) 25 commits
> 
> Running this and the merge-recursive speedup I sent today locally.
> sp/mmap needs relatively recent cygwin library (otherwise pread
> is broken). No other ill effects noticed. Perfomance is bearable.

The default on Cygwin is now NO_MMAP.  I've disabled that default
in my own Cygwin environment and continue to use mmap() rather than
pread(), but I'm also running my sp/mmap change there.  I haven't
noticed a performance difference, but I also haven't tested for one.
IOW if there is a difference its close enough to noise to not be
visible to me as a user.

-- 
Shawn.
