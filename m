From: Shawn Pearce <spearce@spearce.org>
Subject: Re: A look at some alternative PACK file encodings
Date: Thu, 7 Sep 2006 00:33:00 -0400
Message-ID: <20060907043300.GA31376@spearce.org>
References: <44FF41F4.1090906@gmail.com> <9e4733910609061623k73086dbey4a600ecf2852c024@mail.gmail.com> <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, gitzilla@gmail.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 07 07:01:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLC15-0000s6-Fs
	for gcvg-git@gmane.org; Thu, 07 Sep 2006 07:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161088AbWIGFBN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Sep 2006 01:01:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161089AbWIGFBN
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Sep 2006 01:01:13 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42182 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1161088AbWIGFBM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Sep 2006 01:01:12 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GLC0h-0006NY-5S; Thu, 07 Sep 2006 01:01:07 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 81DA020E42C; Thu,  7 Sep 2006 00:33:01 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0609062037560.18635@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26591>

Nicolas Pitre <nico@cam.org> wrote:
> On Wed, 6 Sep 2006, Jon Smirl wrote:
> 
> > Shawn is doing some prototype work on true dictionary based
> > compression. I don't know how far along he is but it has potential for
> > taking 30% off the Mozilla pack.
> 
> BTW I'm half-way done with support for deltas which base object is 
> referenced with an offset in the pack instead of a hash.  It is quite 
> messy though since it touches pretty core code all over the place when 
> it comes to fetching objects out of a pack.

And I'm half-way done with the 64 bit mmap sliding window.  You,
Junio and I are all hacking on the same tiny bit of core code for
different reasons.  :-)

Right now I'm struggling with merging my 32 bit sliding window onto
Junio's 64 bit index in pu.  The merge is almost done, but so is
my dinner.  So dinner first.  I don't think I'm going to get the
sliding window code out tonight.

-- 
Shawn.
