X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 6/6] remove .keep pack lock files when done with refs update
Date: Thu, 2 Nov 2006 00:18:28 -0500
Message-ID: <20061102051827.GA4595@spearce.org>
References: <11624187853116-git-send-email-nico@cam.org> <11624187853865-git-send-email-nico@cam.org> <1162418786895-git-send-email-nico@cam.org> <1162418786390-git-send-email-nico@cam.org> <11624187871572-git-send-email-nico@cam.org> <11624187883225-git-send-email-nico@cam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 2 Nov 2006 05:18:51 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <11624187883225-git-send-email-nico@cam.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30686>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfUyN-0003Hz-Eb for gcvg-git@gmane.org; Thu, 02 Nov
 2006 06:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752648AbWKBFSg (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 2 Nov 2006
 00:18:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752650AbWKBFSg
 (ORCPT <rfc822;git-outgoing>); Thu, 2 Nov 2006 00:18:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:58326 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1752648AbWKBFSf
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 2 Nov 2006 00:18:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GfUyF-00005P-4e; Thu, 02 Nov 2006 00:18:31 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A21A220FB0C; Thu,  2 Nov 2006 00:18:28 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> This makes both git-fetch and git-push (fetch-pack and receive-pack)
> safe against a possible race with aparallel git-repack -a -d that could
> prune the new pack while it is not yet referenced, and remove the .keep
> file after refs have been updated.

Thanks for finishing this series out.  I've gotten sidetracked the
past two days and wasn't able to finish it myself.  Nicely done
too, your code looks much better than my drafts...  :-)

-- 
