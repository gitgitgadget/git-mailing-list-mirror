From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Can the git exclude files mask out whole directories?
Date: Mon, 18 Sep 2006 14:32:20 -0400
Message-ID: <20060918183220.GA31371@spearce.org>
References: <1158604087.28026.160.camel@okra.transitives.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 20:33:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPNve-0002WY-PN
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 20:33:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWIRScZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 14:32:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751877AbWIRScZ
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 14:32:25 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:42715 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751492AbWIRScY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 14:32:24 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPNuh-0006j9-PW; Mon, 18 Sep 2006 14:32:15 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CBC1D20E48E; Mon, 18 Sep 2006 14:32:20 -0400 (EDT)
To: Alex Bennee <kernel-hacker@bennee.com>
Content-Disposition: inline
In-Reply-To: <1158604087.28026.160.camel@okra.transitives.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27256>

Alex Bennee <kernel-hacker@bennee.com> wrote:
> I may be being a bit dim but according to the man page I should be able
> to specify paths with /'s in them. I want to exclude all CVS directories
> so I can commit stuff. I have tried:
> 
> #
> # Ignore CVS files
> #
> */CVS/*

Just use CVS in your info/exclude file:

	#
	# Ignore CVS files
	#
	CVS
 
> to my exclude file but that seems suboptimal. Besides I'll also want to
> be ignoring whole build directories later. Have I subtly misunderstood
> the man page?

I ignore my build directories all the time by just putting their
names in .gitignore, with no trailing /.

-- 
Shawn.
