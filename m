X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: (unknown)
Date: Wed, 25 Oct 2006 18:16:59 -0400
Message-ID: <20061025221659.GC10140@spearce.org>
References: <E1Gck2K-0003H4-00@dvr.360vision.com> <200610251610.02446.andyparkins@gmail.com> <7vods0b5rk.fsf@assigned-by-dhcp.cox.net> <200610252303.07900.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 25 Oct 2006 22:17:25 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200610252303.07900.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30109>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gcr3c-0004yP-Jj for gcvg-git@gmane.org; Thu, 26 Oct
 2006 00:17:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964838AbWJYWRG (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 25 Oct 2006
 18:17:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964843AbWJYWRF
 (ORCPT <rfc822;git-outgoing>); Wed, 25 Oct 2006 18:17:05 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:8072 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S964838AbWJYWRC
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 25 Oct 2006 18:17:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gcr3L-000869-7X; Wed, 25 Oct 2006 18:16:51 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 5423621269E; Wed, 25 Oct 2006 18:16:59 -0400 (EDT)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> On Wednesday 2006, October 25 19:38, Junio C Hamano wrote:
> 
> > > I did try that, but then the branches don't appear in git branch.  I
> > > still like that they exist.
> >
> > "git branch -r" perhaps.
> 
> That's pretty good.  It makes things like
> 
>   git-log remotes/origin/master..master
> 
> A bit long winded, but it's certainly what I asked for.
> 
> You guys really have thought of everything.

Try the bash completion support in contrib/completion.  If you
are using the bash shell it does branch name completions for most
commands, including both sides of the '..' in log there.  At this
point I can't use Git without it.

-- 
