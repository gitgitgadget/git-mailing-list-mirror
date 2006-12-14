X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] merge-recursive: add/add really is modify/modify with an empty base
Date: Thu, 14 Dec 2006 06:41:45 -0500
Message-ID: <20061214114145.GH1747@spearce.org>
References: <Pine.LNX.4.63.0612100056090.28348@wbgn013.biozentrum.uni-wuerzburg.de> <Pine.LNX.4.63.0612100114440.28348@wbgn013.biozentrum.uni-wuerzburg.de> <7vmz5w5tuw.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612122347590.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgog0r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0612130402300.2807@wbgn013.biozentrum.uni-wuerzburg.de> <7vvekgl2z2.fsf@assigned-by-dhcp.cox.net> <b0943d9e0612131401s6cde6d0du5e3c6d2e34bfbbb2@mail.gmail.com> <Pine.LNX.4.63.0612140045430.3635@wbgn013.biozentrum.uni-wuerzburg.de> <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 11:42:01 +0000 (UTC)
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <b0943d9e0612140331q4c3a32e2l361fd04375f091d7@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34321>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuoyJ-0007HZ-N5 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 12:41:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932675AbWLNLlx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 06:41:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932650AbWLNLlx
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 06:41:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:36495 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932675AbWLNLlw (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 06:41:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Guoy8-0008D6-0T; Thu, 14 Dec 2006 06:41:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 06B1A20FB65; Thu, 14 Dec 2006 06:41:45 -0500 (EST)
To: Catalin Marinas <catalin.marinas@gmail.com>
Sender: git-owner@vger.kernel.org

Catalin Marinas <catalin.marinas@gmail.com> wrote:
> One nice addition to git-merge-recursive (probably only useful to
> StGIT) would be more meaningful labeling of the conflict regions,
> passed via a command line similar to the "diff3 -L" option. StGIT
> generates "patched", "current" and "ancestor" labels with diff3.

Indeed.  Getting a SHA1 hash of the branch that I merged in by
name with "git merge foof" is horrible UI.  I want to see "foof"
in the conflict.  Its in my list of things I'd really like to fix,
but is currently low priority compared to the issues I've run into
this past week with git-merge-recursive's basic functions.

On the other hand Git's open source strategy is really paying off on
resolving those problems, typically the issue is fixed and accepted
by Junio into 'next' in under a day of identification.  :-)

-- 
