X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Problem with git-apply?
Date: Sat, 4 Nov 2006 02:30:00 -0500
Message-ID: <20061104073000.GB9422@spearce.org>
References: <20061104072349.GA19667@cubit>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 07:30:19 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061104072349.GA19667@cubit>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30907>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgFyn-0007iY-0O for gcvg-git@gmane.org; Sat, 04 Nov
 2006 08:30:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964826AbWKDHaG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 02:30:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964830AbWKDHaF
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 02:30:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56812 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964826AbWKDHaE
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 02:30:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgFya-0000zS-Um; Sat, 04 Nov 2006 02:30:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 71FCA20E491; Sat,  4 Nov 2006 02:30:00 -0500 (EST)
To: Kevin Shanahan <kmshanah@disenchant.net>
Sender: git-owner@vger.kernel.org

Kevin Shanahan <kmshanah@disenchant.net> wrote:
>     git apply ../test.diff

Try:

      git apply --index ../test.diff

instead.  The --index is needed to record the new file in the index;
otherwise it won't actually be added during commit.

-- 
