X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface warts)
Date: Fri, 17 Nov 2006 12:08:36 -0500
Message-ID: <20061117170836.GD32597@spearce.org>
References: <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org> <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org> <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org> <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org> <Pine.LNX.4.64.0611161039160.3349@woody.osdl.org> <20061117162605.GA32597@spearce.org> <Pine.LNX.4.64.0611170836120.3349@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 17:09:30 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611170836120.3349@woody.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31714>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gl7Cq-0002CF-Gb for gcvg-git@gmane.org; Fri, 17 Nov
 2006 18:08:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933725AbWKQRIp (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 17 Nov 2006
 12:08:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933740AbWKQRIp
 (ORCPT <rfc822;git-outgoing>); Fri, 17 Nov 2006 12:08:45 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32660 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S933725AbWKQRIp
 (ORCPT <rfc822;git@vger.kernel.org>); Fri, 17 Nov 2006 12:08:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gl7Cd-0003su-9O; Fri, 17 Nov 2006 12:08:35 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 84C1420E469; Fri, 17 Nov 2006 12:08:36 -0500 (EST)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> wrote:
> On Fri, 17 Nov 2006, Shawn Pearce wrote:
> > 
> > Although if you have reflog enabled on your current branch there
> > is a 1 character shorter syntax:
> > 
> > 	gitk HEAD@{1}..
> 
> Heh. With a finnish keyboard, that "@" is AltGr+'2', and the '{'/'}' is 
> AltGr+'7'/'0', I guarantee that it's not "1 character shorter", it's 
> "three pretty complicated characters longer" and "off the normal path 
> where you hold your fingers on the keyboard ;)

I forgot that you use a finnish keyboard.  :-)

I agree with you; its not easier to type, for you.  Me, I'm a dumb
American who uses a Kinesis keyboard, therefore my left foot is
my shift key and its in sync with my fingers.  I have no extra
pinky load for either syntax.  And since the reflog syntax works
in a lot more contexts (e.g. after a fetch into a tracking branch)
I have just forgotten about ORIG_HEAD entirely.  Oh sure, I know
its there, but its not something I think about using...

-- 
