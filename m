X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 01:39:35 -0500
Message-ID: <20061121063934.GA3332@spearce.org>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com> <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com> <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com> <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 06:39:59 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31973>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmPIR-0005HO-HB for gcvg-git@gmane.org; Tue, 21 Nov
 2006 07:39:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S934356AbWKUGjm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 01:39:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934353AbWKUGjm
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 01:39:42 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:2261 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S934356AbWKUGjl
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 01:39:41 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GmPI9-0004r5-Gg; Tue, 21 Nov 2006 01:39:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 7228920FB09; Tue, 21 Nov 2006 01:39:35 -0500 (EST)
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org

Jon Smirl <jonsmirl@gmail.com> wrote:
> brendan said SVN is likely for the main Mozilla repo and monotone for
> the new Mozilla 2 work. No native win32 caused git to be immediately
> discarded.

Yea, that lack of native win32 seems to be one of a number of
blockers for people switching their projects onto Git.

I think there's a number of issues that are keeping people from
switching to Git and are instead causing them to choose SVN, hg
or Monotone:

  - No GUI.
  - No native win32 installation.
  - CVS import fails on some projects (e.g. Mozilla).
  - Confusing documentation.
  - pull/merge debate.
  - Fear of hash conflicts corrupting a repository.

I think Junio has solved the pull/merge debate issue.  We've talked
the hash conflict issue to death, but some new people still haven't
read those threads (or won't believe them).  I know people are trying
to work on improving the documentation, but there is obviously still
room for improvements.

Right now I'm trying to work on the no GUI problem with git-gui...

-- 
