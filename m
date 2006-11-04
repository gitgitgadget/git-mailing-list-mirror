X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 00:04:02 -0500
Message-ID: <20061104050402.GB9003@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103081232.GB15972@diana.vm.bytemark.co.uk> <20061103042540.192bbd18.seanlkml@sympatico.ca> <20061103202945.GA7585@spearce.org> <20061103162707.cc8af608.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 05:04:21 +0000 (UTC)
Cc: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>,
	Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103162707.cc8af608.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30904>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgDhb-0002t8-EV for gcvg-git@gmane.org; Sat, 04 Nov
 2006 06:04:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753587AbWKDFEK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 00:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753589AbWKDFEK
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 00:04:10 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:3550 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1753587AbWKDFEI
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 00:04:08 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgDhL-0005MR-G6; Sat, 04 Nov 2006 00:04:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 E620520E491; Sat,  4 Nov 2006 00:04:02 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Fri, 3 Nov 2006 15:29:45 -0500
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > Nack.  I'd rather see the entries added/removed from .git/config when
> > the branch is created/deleted, just like the ref and the reflog are
> > created/deleted.  It makes behavior more consistent for the user
> > and it is mostly self documenting...
> > 
> > 	"why is branch FOO pulling FOO by default?  ahhh, its in
> > 	.git/config after git branch FOO FOO."
> > 
> > Same goes for git-clone.  The branch.master.merge=origin/master
> > entry should be in .git/config file after the clone is complete.
> 
> Well that's certainly an alternative implementation that achieves 
> the same thing.  The essential point is that most of the time the
> Git user should not have to manually create the merge entries
> in the config file.  Git should be smart enough to get it right
> most of the time automatically.

Agreed completely.  At least though with repo-config we have a
command line tool which users/scripts alike can use to read/edit
the configuration of a "remote"; .git/remotes/ has no such tool.

-- 
