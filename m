X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 2/2] git reflog expire
Date: Tue, 19 Dec 2006 05:27:42 -0500
Message-ID: <20061219102741.GA21324@spearce.org>
References: <7vodq3a136.fsf@assigned-by-dhcp.cox.net> <7vr6uxzgjb.fsf@assigned-by-dhcp.cox.net> <20061218140813.GA32446@spearce.org> <7vy7p4u1au.fsf@assigned-by-dhcp.cox.net> <7v64c8thr4.fsf@assigned-by-dhcp.cox.net> <20061219090851.GH2511@spearce.org> <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 19 Dec 2006 10:28:14 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vhcvsry2c.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34811>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GwcCS-0000N8-V1 for gcvg-git@gmane.org; Tue, 19 Dec
 2006 11:27:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932741AbWLSK1q (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 05:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932749AbWLSK1q
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 05:27:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:35000 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S932741AbWLSK1p (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006
 05:27:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GwcCD-0006vw-Cx; Tue, 19 Dec 2006 05:27:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 4E88820FB65; Tue, 19 Dec 2006 05:27:42 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> > I'd like to take a stab at the log display code for the reflog
> > command, but I'd also really like to port forward (aka rewrite)
> > that mmap window code I keep saying I'll work on, but never quite
> > seem to do...
> 
> After today's pread() thing, I was also wondering about that too
> ;-).

I'm working on it now.  I have rather long days on Monday and
Tuesday which keep me otherwise occupied and away from Git work.
Hopefully I'll have something sometime on Wednesday, which so far
I have all day free for hacking.

Smaller mmap units may help on some larger projects. For example
'git whatchanged' shouldn't need to setup page table entries for
the entire pack file when only the front and middle are needed to
obtain the data for the most recent 25 commits, before the user
kills the pager.

But that's just me pulling words out of the air.  I'm tired too,
time to catch a few hours of sleep.  Probably by the time I get back
to my email our local kernel hackers will tell me how wrong I am.

-- 
