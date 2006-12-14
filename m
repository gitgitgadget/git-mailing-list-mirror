X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Thu, 14 Dec 2006 06:45:46 -0500
Message-ID: <20061214114546.GI1747@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 11:45:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612141136.59041.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34322>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gup2B-0007mZ-9I for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:45:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932648AbWLNLpw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932636AbWLNLpw
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:45:52 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36675 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932648AbWLNLpw (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 06:45:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gup22-0008Vb-VN; Thu, 14 Dec 2006 06:45:47 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 105BC20FB65; Thu, 14 Dec 2006 06:45:46 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> How's this then:
> 
> $ git commit
> $ git commit
> $ git commit
> $ git reset HEAD^^^
> 
> "AGGGHHHHHH!  I meant HEAD^^"
> 
> At this point I start running "git-prune -n | grep commit" and some liberal 
> use of git-show to try and find the hash of the object so I can do

At this point I usually try to politely suggest that users do:

  git repo-config --global core.logAllRefUpdates true

and in the future do something like:

> $ git commit         # {4}
> $ git commit         # {3}
> $ git commit         # {2}
> $ git reset HEAD^^^  # {1}
> 
> "AGGGHHHHHH!  I meant HEAD^^"

  $ git reset HEAD@{4}

should give you what

  $ git reset HEAD^^

would have given had you not added the extra ^.  :-)
 
-- 
