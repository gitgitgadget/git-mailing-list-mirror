From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Fri, 26 Jan 2007 04:51:14 -0500
Message-ID: <20070126095114.GA15905@spearce.org>
References: <20070125173954.GA13276@spearce.org> <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net> <7v7ivaailb.fsf@assigned-by-dhcp.cox.net> <20070125214923.GD13874@spearce.org> <Pine.LNX.4.64.0701251830400.3021@xanadu.home> <7vmz4663xq.fsf@assigned-by-dhcp.cox.net> <38b2ab8a0701260052q517285e8l2505114a48d34558@mail.gmail.com> <7vlkjq17sm.fsf@assigned-by-dhcp.cox.net> <38b2ab8a0701260139w25d3e6c7ka8a0097f247f8421@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Francis Moreau <francis.moro@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 26 10:51:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HANjw-0002j7-C8
	for gcvg-git@gmane.org; Fri, 26 Jan 2007 10:51:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161020AbXAZJvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Jan 2007 04:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161021AbXAZJvV
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Jan 2007 04:51:21 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39450 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161020AbXAZJvV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jan 2007 04:51:21 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HANjo-0007JP-Pd; Fri, 26 Jan 2007 04:51:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 49D8D20FBAE; Fri, 26 Jan 2007 04:51:15 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <38b2ab8a0701260139w25d3e6c7ka8a0097f247f8421@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37829>

Francis Moreau <francis.moro@gmail.com> wrote:
> But there are incompatibilities.

Nothing really *that* major.  Heck, that git-describe change is
probably one of the biggest, if not the biggest.
 
> Another example, which may be a bad one since I unfortunately don't
> have time to follow closely git's development: the internal of 'git
> pull' has completely changed. If I clone a repo with git v1.4.x and I
> pull in this repo with git v1.5.x, does it still works ?

Yes, of course.  Just like before too.

What's different is if you clone with 1.5.x, as we now default to the
seperate remotes layout.  This was an option in 1.4.x and earlier,
its now the only way its done in 1.5.x.

-- 
Shawn.
