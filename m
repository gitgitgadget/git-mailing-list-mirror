X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git bug? + question
Date: Sat, 4 Nov 2006 00:03:06 -0500
Message-ID: <20061104050305.GA9003@spearce.org>
References: <buoejsme6ho.fsf@dhapc248.dev.necel.com> <7v4pthmew1.fsf@assigned-by-dhcp.cox.net> <20061102224549.499610d1.seanlkml@sympatico.ca> <20061103203610.GB7585@spearce.org> <20061103162422.b0bf105e.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 4 Nov 2006 05:03:31 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Miles Bader <miles@gnu.org>,
	git@vger.kernel.org,
	Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061103162422.b0bf105e.seanlkml@sympatico.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30903>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GgDgk-0002k9-8t for gcvg-git@gmane.org; Sat, 04 Nov
 2006 06:03:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1753584AbWKDFDO (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 4 Nov 2006
 00:03:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753583AbWKDFDO
 (ORCPT <rfc822;git-outgoing>); Sat, 4 Nov 2006 00:03:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:62941 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1751925AbWKDFDN
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 4 Nov 2006 00:03:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GgDgR-00058P-Ig; Sat, 04 Nov 2006 00:03:07 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 93ECC20E491; Sat,  4 Nov 2006 00:03:06 -0500 (EST)
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Sean <seanlkml@sympatico.ca> wrote:
> On Fri, 3 Nov 2006 15:36:10 -0500
> Shawn Pearce <spearce@spearce.org> wrote:
> 
> > > Maybe even going as far as automatically creating a local branch
> > > for each remote branch on clone is worth considering.
> > 
> > Nack.
> > 
> > I work with a workflow where our central repository has 2 important
> > branches (vmtip and vmvt), and a bunch of transient developer
> > topic branches (e.g. sp/foo).  We only have a master branch in this
> > repository so that git-clone will clone it without choking during
> > the clone.  Users tend to do immediately after a clone:
> > 
> > 	git branch -D master
> > 	git branch -D origin
> > 	git branch -D ... other topic branches not interested in ...
> > 	edit .git/remotes/origin ... delete topic branches ...
> 
> I think your Nack was a little rash here.  The feature would be quite
> useful to work flows other than yours.  It sounds like what _you_ want
> is a feature to select branches when cloning rather than the current
> default of cloning all.  That would stop your developers having to 
> delete branches and editing .git/remotes/origin immediately
> after cloning.

After reading your reply you are probably correct.  I can see there
may be workflows that want every remote branch also created as a
local branch.

I could certainly live with a command line option to clone, e.g.:

	git clone --only vmdvt,vmtip user@host:/path...

So yes, my 'Nack' may have been a little too rash.

-- 
