X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: how-to "backup" a repository
Date: Mon, 6 Nov 2006 00:52:25 -0500
Message-ID: <20061106055224.GA23126@spearce.org>
References: <454ECC23.6010503@saville.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 6 Nov 2006 05:52:53 +0000 (UTC)
Cc: git <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <454ECC23.6010503@saville.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30994>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgxPN-0006u4-98 for gcvg-git@gmane.org; Mon, 06 Nov
 2006 06:52:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1423552AbWKFFwa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 6 Nov 2006
 00:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423553AbWKFFwa
 (ORCPT <rfc822;git-outgoing>); Mon, 6 Nov 2006 00:52:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:26291 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1423552AbWKFFw3
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 6 Nov 2006 00:52:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgxPH-0007L4-7i; Mon, 06 Nov 2006 00:52:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9C37520E491; Mon,  6 Nov 2006 00:52:25 -0500 (EST)
To: Wink Saville <wink@saville.com>
Sender: git-owner@vger.kernel.org

Wink Saville <wink@saville.com> wrote:
> I've been working with git for a little while, but still very
> much a neophyte. One thing I'd like to do is be able to backup
> my work on a server located on my network.
> 
> Currently I have cloned the Linux 2.6 tree on my personal computer
> and have been backing it up by tar'ing the subdirectory with the
> cloned repository and then using scp to copy it to my server.
> 
> I suspect there is a better way, probably using git itself:)
> 
> How is the typically handled?

Create a remote (in .git/remotes) which refers to your backup
location.  Then use 'git push' to push your branch(es) of
interest to the backup.

-- 
