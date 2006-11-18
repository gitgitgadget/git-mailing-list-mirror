X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: multi-project repos
Date: Sat, 18 Nov 2006 01:02:43 -0500
Message-ID: <20061118060243.GB2125@spearce.org>
References: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org> <20061117162605.GA32597@spearce.org> <7virhem0ps.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 18 Nov 2006 06:03:09 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>,
	Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7virhem0ps.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31757>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GlJI0-000244-ED for gcvg-git@gmane.org; Sat, 18 Nov
 2006 07:02:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1755993AbWKRGCx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 18 Nov 2006
 01:02:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756022AbWKRGCx
 (ORCPT <rfc822;git-outgoing>); Sat, 18 Nov 2006 01:02:53 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48039 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1755993AbWKRGCw
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 18 Nov 2006 01:02:52 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GlJHj-0004hh-5U; Sat, 18 Nov 2006 01:02:39 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 022DC20E469; Sat, 18 Nov 2006 01:02:43 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> > Although if you have reflog enabled on your current branch there
> > is a 1 character shorter syntax:
> >
> > 	gitk HEAD@{1}..
> 
> Are you sure about this?  I've seen "next@{1}" to look at
> history of the named branch, but never history of "HEAD".
 
Yes.  :-)

If the ref name is a symref then we resolve the symref all the
way down to the real ref before we open and walk the reflog.
Therefore this works.

-- 
