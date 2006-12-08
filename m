X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Fri, 8 Dec 2006 01:19:16 -0500
Message-ID: <20061208061916.GF13999@spearce.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net> <20061207195715.GG12143@spearce.org> <7v64cns8nf.fsf@assigned-by-dhcp.cox.net> <20061207214053.GC31035@fieldses.org> <20061207215914.GC12502@spearce.org> <20061208044516.GC5939@fieldses.org> <20061208055938.GB13999@spearce.org> <20061208060850.GE5939@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 8 Dec 2006 06:19:30 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061208060850.GE5939@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33661>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsZ4w-0001i9-Qj for gcvg-git@gmane.org; Fri, 08 Dec
 2006 07:19:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424761AbWLHGTX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006
 01:19:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424766AbWLHGTX
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 01:19:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35082 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1424761AbWLHGTW (ORCPT <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006
 01:19:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsZ4o-0000DN-4F; Fri, 08 Dec 2006 01:19:18 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CECD220FB6E; Fri,  8 Dec 2006 01:19:16 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Fri, Dec 08, 2006 at 12:59:38AM -0500, Shawn Pearce wrote:
> > Its in the prompt for all of these users; I forced it in as part of
> > the system's /etc/profile.d.  They just forget that they should think
> > about where they should start their branch from before they make it.
> 
> Maybe they don't really want to use topic branches at all?  Could they
> get away with just committing everything to master?  Seems like kind of
> a shame, though.  Hm.

Good idea.  But...

No, because they are working on at least two different unrelated
changes at once, and we aren't sure which will graduate into the
testing environment first.  If the unrelated changes are intermingled
on the same branch then moving one moves both; and often at least
one of those unrelated changes isn't functioning right and could
cause headaches for the testing team.

-- 
