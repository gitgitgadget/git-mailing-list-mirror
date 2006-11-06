X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how-to "backup" a repository
Date: Mon, 6 Nov 2006 01:18:46 -0500
Message-ID: <20061106061846.GB23126@spearce.org>
References: <454ECC23.6010503@saville.com> <20061106055224.GA23126@spearce.org> <454ED27F.8060106@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 06:19:04 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <454ED27F.8060106@saville.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30997>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ggxou-0003FH-1I for gcvg-git@gmane.org; Mon, 06 Nov
 2006 07:18:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932627AbWKFGSw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 01:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWKFGSw
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 01:18:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:31414 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932627AbWKFGSw
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 01:18:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ggxoo-0002Ge-3p; Mon, 06 Nov 2006 01:18:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E798C206D6B; Mon,  6 Nov 2006 01:18:47 -0500 (EST)
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org

Wink Saville <wink@saville.com> wrote:
> This sounds easy enough, but how-to "create a remote"?
> I looked in .git/remotes and see origin which contains:
> 
> URL: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
> Pull: refs/heads/master:refs/heads/origin
> 
> But where is the syntax defined?

See http://www.kernel.org/pub/software/scm/git/docs/git-push.html#URLS
 
> Also, how do I setup git on my server so that it becomes a server?

So long as you can ssh to it and Git is installed in your PATH then
there's nothing else to do; Git will login via SSH and execute Git
on the remote side to run the server.

-- 
