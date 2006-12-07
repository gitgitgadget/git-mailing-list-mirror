X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: cygwin, 44k files: how to commit only index?
Date: Thu, 7 Dec 2006 14:35:55 -0500
Message-ID: <20061207193555.GD12143@spearce.org>
References: <81b0412b0612070627r3ff0b394s124d95fbf8084f16@mail.gmail.com> <7vd56vtt2g.fsf@assigned-by-dhcp.cox.net> <20061207192632.GC12143@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 19:36:11 +0000 (UTC)
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061207192632.GC12143@spearce.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33613>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsP2J-0007Mw-Dd for gcvg-git@gmane.org; Thu, 07 Dec
 2006 20:36:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S938005AbWLGTgA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 14:36:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S938004AbWLGTgA
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 14:36:00 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35029 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S938005AbWLGTf7 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 14:35:59 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsP25-0005ru-R4; Thu, 07 Dec 2006 14:35:49 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5182320FB6E; Thu,  7 Dec 2006 14:35:55 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Shawn Pearce <spearce@spearce.org> wrote:
> Its Cygwin/NTFS.  lstat() is slow.  readdir() is slow.  I have the
> same problem on my Cygwin systems.

Just to be clear, I'm not trying to blame Cygwin here.

Windows' dir command is slow.  Windows Explorer is slow while
browsing directories.  Eclipse chugs hard while doing any directory
scans (it normally runs very fast if its not rescanning the entire
directory structure).  The drive is just plain slow.

Yea, I know, get a faster disk... but some bean counters don't
believe that a $50 more expensive disk could ever save enough time
to warrant the extra $50 captial expenditure...

I spend at least an hour a week waiting for enough IO to finish so
that the mouse pointer will move again.  *sigh*

-- 
