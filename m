From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Make 'make' quieter while building git
Date: Tue, 6 Mar 2007 18:24:13 -0500
Message-ID: <20070306232413.GA25785@spearce.org>
References: <20070306063501.GA24355@spearce.org> <81b0412b0703060116m166e2da7saeab82c67536558e@mail.gmail.com> <Pine.LNX.4.63.0703061422580.22628@wbgn013.biozentrum.uni-wuerzburg.de> <81b0412b0703060537u5140a034s91b35f0d842843a3@mail.gmail.com> <Pine.LNX.4.63.0703061518250.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vejo2nffj.fsf@assigned-by-dhcp.cox.net> <81b0412b0703061511j30683d14h584275b993d40e1c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:24:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOj16-0004Vk-5K
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:24:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030704AbXCFXYU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:24:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030706AbXCFXYU
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:24:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45700 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030704AbXCFXYT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:24:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOj0o-0002sG-3H; Tue, 06 Mar 2007 18:24:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B4C8120FBAE; Tue,  6 Mar 2007 18:24:13 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <81b0412b0703061511j30683d14h584275b993d40e1c@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41618>

Alex Riesen <raa.lkml@gmail.com> wrote:
> On 3/7/07, Junio C Hamano <junkio@cox.net> wrote:
> >But doesn't "CC foo.o" look just simply WRONG?  We compile foo.c
> >to produce foo.o.  An alternative that I could slightly more
> >sympathize with would be something like this:
> 
> not if you compiled kernels. Doesn't it look wrong to
> output information you already have, if you need to?

Well, I have to admit, the Linux kernel is where I got the idea from.
But I have not built one in a while so I didn't remember what it
outputs, exactly.

I also was too lazy to go look at the kernel makefiles, even though
I have them handy.

;-)

-- 
Shawn.
