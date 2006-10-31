X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Tue, 31 Oct 2006 01:56:35 -0500
Message-ID: <20061031065635.GC7375@spearce.org>
References: <20061030223615.GH5775@spearce.org> <7vlkmxtmln.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0610302258400.11384@xanadu.home> <7v7iyhrsoi.fsf@assigned-by-dhcp.cox.net> <20061031063941.GB7375@spearce.org> <7vwt6hq8nu.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 06:56:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vwt6hq8nu.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30572>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GenYA-0006tv-Cb for gcvg-git@gmane.org; Tue, 31 Oct
 2006 07:56:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422828AbWJaG4j (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 01:56:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422825AbWJaG4j
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 01:56:39 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:14540 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422828AbWJaG4i
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 01:56:38 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GenY4-0000w8-RE; Tue, 31 Oct 2006 01:56:36 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 792E420FB0C; Tue, 31 Oct 2006 01:56:35 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> >> Because that approach assumes recieve-pack and unpack-objects
> >> and index-pack are from the same vintage (otherwise your
> >> receive-pack would need to have a way to see if unpack-objects
> >> and index-pack would grok --pack_header argument), we could even
> >> get away without passing the pack version if we wanted to.
> >...
> > BTW I think we do need to pass the pack version in the option.
> 
> We are in agreement; I mentioned "we could ... if we wanted to"
> because I wanted to see if you are paying attention ;-).

Hah.  Trying to keep me on my toes aren't you.  :-)

I almost have the change finished. I'll send it before I go to bed.

-- 
