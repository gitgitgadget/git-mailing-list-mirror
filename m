X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] Optionally check for uncommitted changes before switching branches.
Date: Thu, 7 Dec 2006 14:43:58 -0500
Message-ID: <20061207194358.GF12143@spearce.org>
References: <6ed9774cb95e873e76a4ac406dd740caf954bd3b.1165485618.git.spearce@spearce.org> <20061207100224.GB12966@spearce.org> <7vu007sdhp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:44:15 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu007sdhp.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33616>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPA7-0000C0-U7 for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:44:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163228AbWLGToE (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:44:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163240AbWLGToE
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:44:04 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35516 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163228AbWLGToB (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:44:01 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsP9t-00079I-0c; Thu, 07 Dec 2006 14:43:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7D9E220FB6E; Thu,  7 Dec 2006 14:43:58 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Git shouldn't cause the user to make mistakes when it can help to
> > prevent them.  So now users may set checkout.requireCleanDirectory
> > to true in their config file to have git-checkout verify the working
> > directory is clean before switching branches.
[...snip...]
> People with this new configuration set and has to override it
> with a command line switch will lose this ability if you
> overload that on '-m'.

Yes.  That's a problem with this patch.

What about when this option is enabled then -m means do what we
did before, and -m -m (or -mm, or -m2) does what -m does when the
option is false?

-- 
