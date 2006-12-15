X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 11:08:33 -0500
Message-ID: <20061215160833.GH17860@spearce.org>
References: <200612132237.10051.andyparkins@gmail.com> <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net> <200612140959.19209.andyparkins@gmail.com> <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0612141343200.18171@xanadu.home> <Pine.LNX.4.64.0612142307160.18171@xanadu.home> <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se> <20061215150909.GE17860@spearce.org> <Pine.LNX.4.64.0612151032240.18171@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 16:08:47 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0612151032240.18171@xanadu.home>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34530>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFc3-0007ea-Jx for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:08:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752797AbWLOQIk (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:08:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752798AbWLOQIk
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:08:40 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52102 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752797AbWLOQIj (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:08:39 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvFbq-000379-2W; Fri, 15 Dec 2006 11:08:30 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0CCF420FB65; Fri, 15 Dec 2006 11:08:34 -0500 (EST)
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

Nicolas Pitre <nico@cam.org> wrote:
> On Fri, 15 Dec 2006, Shawn Pearce wrote:
> > Andreas Ericsson <ae@op5.se> wrote:
> > > diffstats can be huge though. I'd rather have those only with -v option.
> > 
> > But they are on by default for pull/merge, and disabled by -n.
> 
> And it is true that diffstat can be quite large.  I wouldn't mind the 
> diffstat to be added to the commit message summary in the text editor 
> though.  And displaying it when -v is used makes also a lot of sense.  
> But not by default please.

OK, two votes against diffstats by default in commit.  Since I
haven't written a patch for it yet consider it dropped.  ;-)

-- 
