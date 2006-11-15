X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 18:02:52 -0500
Message-ID: <20061115230252.GH24861@spearce.org>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org> <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com> <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home> <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org> <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 23:03:19 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, Nicolas Pitre <nico@cam.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87psbos4pb.wl%cworth@cworth.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31524>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTmX-000490-O6 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 00:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162037AbWKOXDA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 18:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031026AbWKOXDA
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 18:03:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:26548 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031022AbWKOXC7
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 18:02:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkTmH-0003kK-Dc; Wed, 15 Nov 2006 18:02:45 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 EA95220FB0B; Wed, 15 Nov 2006 18:02:52 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
> Plus, when I'm teaching "fetch everything first, then manipulate it
> locally", (which is what I teach, since that's the only way I use
> git), then the "." looks really out of place when I teach the 'merge'
> command. I end up saying, "Oh, that's there because you could do the
> fetch and merge all in one step if you really wanted, but I never do
> that.".
> 
> And that's because I _do_ teach fetch first, as you've suggested.

Ditto.  In every way.

I've taught the same fetch first, then merge strategy.  Nobody I
know in meat-space pulls from a remote URL and merges in one shot;
they always fetch locally, look at the incoming changes, decide if
its worthwhile/ok, *then* merge with "git pull . branch".

The "." looks out of place for everyone...

-- 
