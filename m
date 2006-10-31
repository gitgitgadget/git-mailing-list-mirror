X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Teach receive-pack how to keep pack files when unpacklooseobjects = 0.
Date: Tue, 31 Oct 2006 01:33:12 -0500
Message-ID: <20061031063312.GA7375@spearce.org>
References: <20061030223615.GH5775@spearce.org> <7vu01ltnfs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 31 Oct 2006 06:33:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vu01ltnfs.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30569>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GenBa-0003dr-8c for gcvg-git@gmane.org; Tue, 31 Oct
 2006 07:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1422794AbWJaGdT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 31 Oct 2006
 01:33:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422798AbWJaGdT
 (ORCPT <rfc822;git-outgoing>); Tue, 31 Oct 2006 01:33:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56009 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1422794AbWJaGdS
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 31 Oct 2006 01:33:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GenBU-00086h-9r; Tue, 31 Oct 2006 01:33:16 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 6A95B20FB0C; Tue, 31 Oct 2006 01:33:13 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Until this is resolved, I feel there should be some way to
> control the behaviour, so while I agree with the general
> direction, I think the patch to revert the sender's wish should
> come at the end.
 
I disagree, but I'm not the maintainer.  :-)

I reverted it before making my changes as I was editing the same
lines as c7740a modified.  Therefore reverting c7740a after my
changes would no longer be a clean revert, making it slightly
harder to actuallly do the revert as you would need to manually
fix up receive-pack.c.

-- 
