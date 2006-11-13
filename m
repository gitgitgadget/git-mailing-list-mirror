X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Getting new branches from remote repo.
Date: Mon, 13 Nov 2006 12:44:57 -0500
Message-ID: <20061113174457.GA16979@spearce.org>
References: <6e1787fe0611122033p49671e13xf5b7f95beeba8b06@mail.gmail.com> <7v8xigar36.fsf@assigned-by-dhcp.cox.net> <20061113091736.GA31693@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 13 Nov 2006 17:45:57 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Alexander Litvinov <litvinov2004@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061113091736.GA31693@diana.vm.bytemark.co.uk>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31305>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gjfru-0006aN-3Y for gcvg-git@gmane.org; Mon, 13 Nov
 2006 18:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932164AbWKMRpJ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 13 Nov 2006
 12:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932144AbWKMRpI
 (ORCPT <rfc822;git-outgoing>); Mon, 13 Nov 2006 12:45:08 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:4243 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S932164AbWKMRpH
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 13 Nov 2006 12:45:07 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GjfrZ-0005Nf-NN; Mon, 13 Nov 2006 12:44:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A13B220FB0B; Mon, 13 Nov 2006 12:44:57 -0500 (EST)
To: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Sender: git-owner@vger.kernel.org

Karl Hasselstr?m <kha@treskal.com> wrote:
> On 2006-11-12 20:49:33 -0800, Junio C Hamano wrote:
> > After finding out $that_new_branch's name, add either
> >
> >       Pull: refs/heads/$that_new_branch:refs/heads/$that_new_branch
> >
> > or if you are in "separate remote" school, then perhaps
> >
> >       Pull: refs/heads/$that_new_branch:refs/remotes/origin/$that_new_branch
> >
> > to .git/remotes/origin and running git fetch would give you what you
> > want, I think.
> 
> There really should be a flag to make git fetch do this job. And if we
> use separate remotes, the flag should probably default to "on".

And also to automatically stop fetching any branch which is no longer
listed on the remote system, rather than reporting a "Fetch failure".

I probably would keep the local ref (they are cheap) just in case
the user was counting on that branch and then the remote system
pulled the rug out from under them.  :-)

-- 
