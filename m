X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 17:07:23 -0500
Message-ID: <20061115220723.GB24861@spearce.org>
References: <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <Pine.LNX.4.64.0611151315291.2591@xanadu.home> <20061115184914.GA24122@spearce.org> <455B64F7.9040506@gmx.net> <7vejs4l9wy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 15 Nov 2006 22:07:47 +0000 (UTC)
Cc: Marko Macek <marko.macek@gmx.net>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	cworth@cworth.org, pasky@suse.cz
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vejs4l9wy.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31512>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkSuv-0003CN-P1 for gcvg-git@gmane.org; Wed, 15 Nov
 2006 23:07:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1161827AbWKOWHe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 17:07:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161829AbWKOWHe
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 17:07:34 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:31147 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1161827AbWKOWHd
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 17:07:33 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GkSub-0006sd-2x; Wed, 15 Nov 2006 17:07:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D9F9420FB0B; Wed, 15 Nov 2006 17:07:23 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> The index is quite central to the way git works at the concept
> level, and I think it is doing disservice to the end user to try
> hiding it forever from them and failing to do so, rather than
> being honest and teaching them the concept upfront.
> 
> But me thinking so does not necessarily mean you are forbidden
> from trying.  Your efforts may result in a system where the
> index is totally invisible and the end user never has to know
> about it.

I agree with what you are saying about the index.

But in git-gui I found myself writing code on Monday which tries to
hide the index from the user unless he/she requested that the index
be made visible.

The reason is there are some users who I'd like to give git-gui to
who I'm not sure I trust to make sure their index is in sync with
their working directory before they commit.  In some cases I'm lucky
that the user even knows what directory their file is stored in.  :-(
Yes, there really are computer users who are afraid of directories
and command lines.

I probably could try to teach them to make sure the final file
is included in the index before committing, but I think that for
most of them they would find this to be just another couple of
mouse clicks they have to perform before every commit, meaning its
something that the #$@!*@!*@$# tool should just do for them.

-- 
