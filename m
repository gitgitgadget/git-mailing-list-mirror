X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [RFC] git-gui: A commit / fetch / push interface
Date: Wed, 8 Nov 2006 01:03:50 -0500
Message-ID: <20061108060350.GE28498@spearce.org>
References: <20061107083603.GB9622@spearce.org> <17745.3287.358673.265578@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 8 Nov 2006 06:04:30 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <17745.3287.358673.265578@cargo.ozlabs.ibm.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31122>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhgXx-000670-JX for gcvg-git@gmane.org; Wed, 08 Nov
 2006 07:04:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1754337AbWKHGD4 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 8 Nov 2006
 01:03:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754338AbWKHGD4
 (ORCPT <rfc822;git-outgoing>); Wed, 8 Nov 2006 01:03:56 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:57541 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1754335AbWKHGDz
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 8 Nov 2006 01:03:55 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhgXR-0002DG-H7; Wed, 08 Nov 2006 01:03:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5DC5620E487; Wed,  8 Nov 2006 01:03:51 -0500 (EST)
To: Paul Mackerras <paulus@samba.org>
Sender: git-owner@vger.kernel.org

Paul Mackerras <paulus@samba.org> wrote:
> One thing I have been meaning to do is to integrate gitool into gitk,
> now that gitk can display a fake commit showing the local changes.  I
> intend to add a menu item to gitk saying "Commit local changes" or
> something, which would invoke gitool, or maybe now git-gui instead. :)
> The nice thing is that then gitk could update the graph to show the
> new commit once it was created.

Right.  :-)

I have absolutely no plans (or desire) to attempt to do graph
rendering in git-gui.  The most I may do for showing history in it
is perhaps a "git log --max-count=5 --pretty=oneline" type of display
so the user can see more than just an empty window after a commit.

IMHO gitk does a very nice job of rendering the graph on a wide
range of platforms (although it still has two annoying bugs: one
on Windows and one on Mac OS X that really make it hard to use).
git-gui is just an attempt to bring the other major features of Git
to that same set of platforms, with the same set of dependencies
(wish 8) and ease of use...

It would be nice if we can eventually connect gitk and git-gui so
they can coordinate as you are talking about above...

> My current version of gitool also has menus that let you revert
> modified files, and delete or ignore untracked files.  Have you
> considered adding that to git-gui?

Yes, they are in my TODO list (or if missing from there are certainly
in my head as things to add).  I'd like to get git-gui finished this
week, which means getting those features in today or tomorrow.  :-)
I'll probably do branches first though.

-- 
