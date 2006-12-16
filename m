X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: What's in git.git (stable)
Date: Fri, 15 Dec 2006 21:54:21 -0500
Message-ID: <20061216025421.GB19636@spearce.org>
References: <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net> <200612141136.59041.andyparkins@gmail.com> <20061214114546.GI1747@spearce.org> <8764ce6654.wl%cworth@cworth.org> <20061214120518.GL1747@spearce.org> <Pine.LNX.4.64.0612141251520.18171@xanadu.home> <7vy7pa45m8.fsf@assigned-by-dhcp.cox.net> <20061214200245.GP1747@spearce.org> <4581C83A.10907@op5.se> <7vslfgomdg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 16 Dec 2006 02:54:37 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vslfgomdg.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34589>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvPgz-0001bE-J9 for gcvg-git@gmane.org; Sat, 16 Dec
 2006 03:54:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753335AbWLPCy0 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 21:54:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753354AbWLPCy0
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 21:54:26 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56357 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1753335AbWLPCy0 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 21:54:26 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvPgh-0008T4-DK; Fri, 15 Dec 2006 21:54:11 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 429C020FB65; Fri, 15 Dec 2006 21:54:21 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> > Shawn Pearce wrote:
> >>
> >> About the only trouble that can cause is a failed push when
> >> git-receive-pack needs to generate the reflog entry but cannot
> >> get the user's committer data because their gecos information
> >> doesn't exist.
> >
> > In that case, it would be best if it let the commit go through using
> > only the username. Reflogs are fixable afterwards, so there's no real
> > harm done.
> 
> This sounds sensible, regardless of the current discussion on
> the default 'logallrefupdates' setting.
> 
> Volunteers?

Its a good idea.  I'll do it later tonight, after dinner.

-- 
