X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 10:09:09 -0500
Message-ID: <20061215150909.GE17860@spearce.org>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net> <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612141343200.18171@xanadu.home> <Pine.LNX.4.64.0612142307160.18171@xanadu.home> <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 15:09:34 +0000 (UTC)
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45825E0B.5010200@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34513>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEgc-0006tc-J4 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:09:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752662AbWLOPJT (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:09:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752718AbWLOPJT
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:09:19 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49044 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752662AbWLOPJT (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:09:19 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvEgM-0000bE-BY; Fri, 15 Dec 2006 10:09:06 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CB8E720FB65; Fri, 15 Dec 2006 10:09:09 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> wrote:
> Shawn Pearce wrote:
> >Nicolas Pitre <nico@cam.org> wrote:
> >>It is nicer to let the user know when a commit succeeded all the time, 
> >>not only the first time.  Also the commit sha1 is much more useful than 
> >>the tree sha1 in this case.
> >
> >I agree the commit sha1 is more useful than the tree sha1, but I'm
> >not really sure its useful to show the commit sha1 post commit.
> >If you want to show something the diffstat like what git merge does
> >is better.
> >
> 
> diffstats can be huge though. I'd rather have those only with -v option.

But they are on by default for pull/merge, and disabled by -n.

They are on to tell you what you just got during the pull/merge.
If we want commit to confirm it did something successfully, I think
having it confirm what it committed by way of diffstat makes a lot
of sense.

Unfortunately -n is taken to mean --no-verify by git-commit, so
we probably cannot repurpose it to mean --no-summary, like it is
for merge/pull.

-- 
