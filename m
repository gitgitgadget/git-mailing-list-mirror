X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Tue, 14 Nov 2006 14:29:14 -0500
Message-ID: <20061114192914.GD4299@spearce.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 14 Nov 2006 19:29:32 +0000 (UTC)
Cc: Andy Whitcroft <apw@shadowen.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <87hcx1u934.wl%cworth@cworth.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31364>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gk3yI-0003CM-5f for gcvg-git@gmane.org; Tue, 14 Nov
 2006 20:29:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S966281AbWKNT3X (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 14 Nov 2006
 14:29:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966287AbWKNT3X
 (ORCPT <rfc822;git-outgoing>); Tue, 14 Nov 2006 14:29:23 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49105 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S966281AbWKNT3W
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 14 Nov 2006 14:29:22 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gk3y0-0004Fv-NG; Tue, 14 Nov 2006 14:29:08 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5478020FB0B; Tue, 14 Nov 2006 14:29:14 -0500 (EST)
To: Carl Worth <cworth@cworth.org>
Sender: git-owner@vger.kernel.org

Carl Worth <cworth@cworth.org> wrote:
>  2) From git-<TAB>, (maybe the solution for this is to make
>     "git <TAB>" work and only do tab-completion for the commands
>     blessed enough to appear in "git --help"? Also push the tab
>     completion stuff out as a standard part of packages.

Uh, see contrib/completion/git-completion.bash.

"git <TAB>" completes commands.  It offers too many completions
for your taste it sounds like, as it also offers plumbing... but
that's fixable.  :-)

-- 
