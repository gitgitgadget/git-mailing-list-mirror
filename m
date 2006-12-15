X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 11:12:57 -0500
Message-ID: <20061215161257.GI17860@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <eluemi$gc0$1@sea.gmane.org> <Pine.LNX.4.64.0612151029080.18171@xanadu.home> <4582C3CE.3000902@op5.se> <Pine.LNX.4.64.0612151106580.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 16:13:13 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612151106580.18171@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34531>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFgK-0008RS-JF for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:13:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752803AbWLOQNF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:13:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752804AbWLOQNF
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:13:05 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52322 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752803AbWLOQND (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:13:03 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvFg5-0003rf-I7; Fri, 15 Dec 2006 11:12:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 87C7920FB65; Fri, 15 Dec 2006 11:12:57 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> Wouldn't it be possible for aliases to be effective only when issued 
> from an interactive shell?  It is certainly true that aliases just make 
> no sense in a script.

Probably, but on Cygwin gitk needs to use 'git foo' to invoke a
command, even if 'git-foo' exists, because 'git-foo' might be a shell
script and the Cygwin wish process cannot execute shell scripts.

Worse it cannot pass down environment variables to git commands.
So it may be a little hard to tell in the git wrapper we are being
run from within gitk (or git-gui)...

-- 
