X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: multi-project repos
Date: Sat, 18 Nov 2006 02:45:02 -0500
Message-ID: <20061118074502.GB2338@spearce.org>
References: <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org> <20061117162605.GA32597@spearce.org> <7virhem0ps.fsf@assigned-by-dhcp.cox.net> <20061118060243.GB2125@spearce.org> <7vvelddxcx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 07:45:25 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vvelddxcx.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31764>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlKt7-0003F4-Rg for gcvg-git@gmane.org; Sat, 18 Nov
 2006 08:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755987AbWKRHpN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 02:45:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756228AbWKRHpN
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 02:45:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:4531 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1755987AbWKRHpL
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 02:45:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GlKsl-0002Qb-Rk; Sat, 18 Nov 2006 02:44:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 78D7320E469; Sat, 18 Nov 2006 02:45:02 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> True, except if you did:
> 
>         $ git pull
>         $ git checkout otherbranch
>         $ git show HEAD@{1}
> 
> My real point was that I was wondering if it also makes sense
> for ref-log to record switching branches for the symref itself.
> 
> But after sending that message I thought about it a bit more and
> concluded that it is not an interesting information.  It is more
> code that affects unrelated places even if we were to implement
> it and without real gain, so let's not log symref itself and
> keep the current implementation.

I agree completely.

I have no interest in a history of what branches I've recently
been on.  All I care about is the history of this branch.  And I
consider HEAD to be nothing but a shortcut that always points to
the current branch... so its darn useful for that.

In retrospect CURR may have been a better name for the HEAD symref
but its far too late to even consider changing that, so lets not
go down that road.  :-)

-- 
