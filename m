X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git and bzr
Date: Tue, 28 Nov 2006 16:53:32 -0500
Message-ID: <20061128215332.GK28337@spearce.org>
References: <456B7C6A.80104@webdrake.net> <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com> <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com> <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de> <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 28 Nov 2006 21:54:13 +0000 (UTC)
Cc: Nicholas Allen <nick.allen@onlinehome.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32587>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAtd-0008DZ-0u for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757090AbWK1Vxl (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:53:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757098AbWK1Vxl
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:53:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:31435 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1757090AbWK1Vxl
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:53:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GpAtJ-0002X9-G1; Tue, 28 Nov 2006 16:53:25 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 BD66A20FB7F; Tue, 28 Nov 2006 16:53:32 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> There are lots of reasons why "git status" may tell you that something 
> isn't merged. The most common one by far being an actual data conflict, 
> not a name conflict. The reason for why something conflicts is always told 
> at merge-time.

Except when you are doing a large merge, your terminal scrollback
is really short, and there's a lot of conflicts.  Then you can't
see what merge said about any given file.  :-(

Fortunately its easy to back out of the merge and redo it with
large enough scrollback, or redirecting it to a file for later
review, but its annoying that we don't save that information off
for later review.

-- 
