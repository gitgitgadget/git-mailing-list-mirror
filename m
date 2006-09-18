From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-repack: Outof memory
Date: Mon, 18 Sep 2006 02:50:55 -0400
Message-ID: <20060918065055.GC20660@spearce.org>
References: <450CA561.9030602@gmail.com> <20060917022534.GB7512@spearce.org> <4b3406f0609161946x52a89dd3q6d74127c376270e7@mail.gmail.com> <20060917031853.GC7512@spearce.org> <4b3406f0609170003t63a2f9f4pf2c42faec9746a73@mail.gmail.com> <4b3406f0609170543p68d96b9x9ba0c5a74d9e89e8@mail.gmail.com> <20060918002357.GA19727@spearce.org> <7v64flyjpe.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Dongsheng Song <dongsheng.song@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 18 08:51:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPCy9-0007LN-RP
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 08:51:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965492AbWIRGvB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 02:51:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965495AbWIRGvA
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 02:51:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:48073 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S965492AbWIRGvA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 02:51:00 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPCy1-0002dV-3b; Mon, 18 Sep 2006 02:50:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A05E620E48E; Mon, 18 Sep 2006 02:50:55 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v64flyjpe.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27236>

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > ...  I fear that
> > you are going to bump up against address space limitations soon
> > on 32 bit systems.  Then you will bump up against the 4 GiB pack
> > file size limit.  Which means you will need to use several packs
> > and avoid the '-a' flag when calling git-repack.
> 
> I presume that you are hinting that we would need to update
> git-repack so that it is still useful without --all.

Yes.  :-)

Apparently the Porcelain level is still open for debate.  Someone
just needs to post a reasonable implementation to get discussion
(or lack there of) going.  I'm too tired right now to try to roll
something up right, even though it looks to be rather simple.

As it is I'm having a difficult time navigating in vi to write this
email and normally vi navigation is as easy as breathing for me...

> I think pack-objects --unpacked=active-pack is ready, so I'll
> push it out.

Thanks; I noticed that in your "What's in git.git" announcement.

-- 
Shawn.
