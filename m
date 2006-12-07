X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Allow users to require source branch on git-checkout -b.
Date: Thu, 7 Dec 2006 14:57:15 -0500
Message-ID: <20061207195715.GG12143@spearce.org>
References: <20061207100152.GA12966@spearce.org> <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:57:24 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vlkljsd1k.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33620>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPMw-0002PC-MA for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:57:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S938016AbWLGT5T (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:57:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938018AbWLGT5T
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:57:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36300 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S938016AbWLGT5S (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:57:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsPMj-00025h-Vr; Thu, 07 Dec 2006 14:57:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 92FEA20FB6E; Thu,  7 Dec 2006 14:57:15 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> > This introduces a new config option: checkout.requireSourceBranch,
> 
> You could turn it around and make it a per-branch configuration,
> like:
> 
> 	[branch "main"]
>         	allowbranchbydefault = true

Are you suggesting that we change "git-checkout -b" to by default
require the source branch, but the user can restore the original
behavior by setting the above per-branch configuration option?

I'm OK with that version too.  Most of these users want to be
required to enter the source branch, and their topic branches (which
are always their current branches btw) are so transient they won't
bother with a per-branch setting.  So they get what they want:
the tool reminding them to select their source revision.

-- 
