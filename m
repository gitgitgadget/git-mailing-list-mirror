X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: kernel.org mirroring (Re: [GIT PULL] MMC update)
Date: Thu, 7 Dec 2006 14:39:03 -0500
Message-ID: <20061207193903.GE12143@spearce.org>
References: <45744FA3.7020908@zytor.com> <Pine.LNX.4.64.0612061847190.3615@woody.osdl.org> <45778AA3.7080709@zytor.com> <Pine.LNX.4.64.0612061940170.3615@woody.osdl.org> <4577A84C.3010601@zytor.com> <Pine.LNX.4.64.0612070953290.3615@woody.osdl.org> <45785697.1060001@zytor.com> <Pine.LNX.4.64.0612071052560.3615@woody.osdl.org> <457868AA.2030605@zytor.com> <Pine.LNX.4.64.0612071121410.3615@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:39:41 +0000 (UTC)
Cc: "H. Peter Anvin" <hpa@zytor.com>,
	Kernel Org Admin <ftpadmin@kernel.org>,
	Git Mailing List <git@vger.kernel.org>,
	Jakub Narebski <jnareb@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612071121410.3615@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33615>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsP5n-0007sS-1U for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163229AbWLGTjg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163231AbWLGTjg
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:39:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35219 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163229AbWLGTjf (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:39:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsP57-0006Ki-R1; Thu, 07 Dec 2006 14:38:57 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5D7CF20FB6E; Thu,  7 Dec 2006 14:39:03 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> I'm surprised that Apache can't do that. Or maybe it can, and it just 
> needs some configuration entry? I don't know apache.. I realize that 
> because Apache doesn't know before-hand whether something is cacheable or 
> not, it must probably _default_ to running the CGI scripts to the same 
> address in parallel, but it would be stupid to not have the option to 
> serialize.

AFAIK it doesn't have such an option, for basically the reason
you describe.  I worked on a project which had much more difficult
to answer queries than gitweb and were also very popular.  Yes,
the system died under any load, no matter how much money was thrown
at it.  :-)

> That said, from some of the other horrors I've heard about, "stupid" may 
> be just scratching at the surface.

It is.  :-)

-- 
