X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 10:40:25 -0500
Message-ID: <20061215154025.GF17860@spearce.org>
References: <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612141343200.18171@xanadu.home> <Pine.LNX.4.64.0612142307160.18171@xanadu.home> <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se> <20061215150909.GE17860@spearce.org> <4582C022.3030706@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 15:40:46 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4582C022.3030706@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34520>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFAr-0003RK-J2 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:40:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752659AbWLOPkf (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:40:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752693AbWLOPkf
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:40:35 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50683 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752659AbWLOPke (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:40:34 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvFAb-0008DH-O3; Fri, 15 Dec 2006 10:40:21 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4510E20FB65; Fri, 15 Dec 2006 10:40:25 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> wrote:
> Yes, but it makes sense for merges where you generally pull someone 
> elses work or one of your topic branches because it gives a general feel 
> for the amount of modifications and are a sort of conclusion. Commits 
> are a different thing, because you should know what kind of changes 
> you've just done. If you don't you have other problems. I for one run 
> git diff quite frequently when I'm getting close to a commit to make 
> sure I don't get only the changes I want. I imagine others do too, so 
> getting a diffstat when issuing the actual commit would just be noisy 
> and irritating.

I do the same (diff a lot before commit) and thus find commit
outputting anything at all to be noisy and irritating.  Frankly
the new

  git-diff-tree --summary --root --no-commit-id HEAD

that Junio put on the end is already irritating.

But it was added to help users verify that commit did what they
thought it would (see 61f5cb7f).  By the same token sometimes users
accidentally commit files they didn't mean to, or forget to include
files they meant to include.  Showing a diffstat would also be a
final sanity check for them.

-- 
