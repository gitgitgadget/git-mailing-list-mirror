X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-svn bug?
Date: Wed, 15 Nov 2006 17:37:10 -0500
Message-ID: <20061115223709.GG24861@spearce.org>
References: <op.ti2svo0ozidtg1@rygel.lnxi.com> <m2psbocpbo.fsf@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 22:37:41 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <m2psbocpbo.fsf@ziti.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31521>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkTNh-0008Qv-Mg for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162013AbWKOWhQ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:37:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162014AbWKOWhQ
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:37:16 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:29360 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1162013AbWKOWhN
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:37:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkTNO-0001H5-TH; Wed, 15 Nov 2006 17:37:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 527FB20FB0B; Wed, 15 Nov 2006 17:37:10 -0500 (EST)
To: Seth Falcon <sethfalcon@gmail.com>
Sender: git-owner@vger.kernel.org

Seth Falcon <sethfalcon@gmail.com> wrote:
> I always send commits as:
> 
> git-svn dcommit remotes/git-svn..master
> 
> Possibly replacing master with whatever git branch I'm working on.

Or just:

   git-svn dcommit remotes/git-svn..

to send the current branch.

> One nice thing about this approach is that you can sort of preview the
> commit as:
> 
>   git diff remotes/git-svn..master

Or see the log and patch of each commit on the current branch:

   git log -p remotes/git-svn..

-- 
