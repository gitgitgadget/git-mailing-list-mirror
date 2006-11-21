X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 21:22:57 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611212116340.26827@wbgn013.biozentrum.uni-wuerzburg.de>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com>
 <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com>
 <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com>
 <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com>
 <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com>
 <20061121063934.GA3332@spearce.org> <20061121200341.GH7201@pasky.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 21 Nov 2006 20:23:41 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Jon Smirl <jonsmirl@gmail.com>,
	Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061121200341.GH7201@pasky.or.cz>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32035>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmc93-0002wT-Mi for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:23:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031392AbWKUUXA (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031391AbWKUUXA
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:23:00 -0500
Received: from mail.gmx.de ([213.165.64.20]:64227 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1031392AbWKUUW7 (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:22:59 -0500
Received: (qmail invoked by alias); 21 Nov 2006 20:22:57 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp010) with SMTP; 21 Nov 2006 21:22:57 +0100
To: Petr Baudis <pasky@suse.cz>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 21 Nov 2006, Petr Baudis wrote:

> On Tue, Nov 21, 2006 at 07:39:35AM CET, Shawn Pearce wrote:
> > 
> > Yea, that lack of native win32 seems to be one of a number of
> > blockers for people switching their projects onto Git.
> 
> Yep. :-(

I started playing with MinGW, and got it to compile and run, with some 
features lacking. See

Message-ID: <Pine.LNX.4.63.0609021724110.28360@wbgn013.biozentrum.uni-wuerzburg.de>

for details. From TFM

: The two biggest obstacles are fork() and the network stuff (I do not 
: plan on supporting Git.pm there). To overcome the absence of fork() I 
: wanted to use the subprocess stuff in MinGW's port of GNU make.


> > I think there's a number of issues that are keeping people from
> > switching to Git and are instead causing them to choose SVN, hg
> > or Monotone:
> > 
> >   - No GUI.
> 
> It has been my impression that Git's situation is far better than in
> case of the other systems (except SVN: TortoiseSVN and RapidSVN). Is
> that not so?

I also started playing with writing a shell extension (this is what custom 
context menu entries are called in Windows) using only MinGW, and no 
payware (except, of course, Windows).

Since both of these little projects were sidetracks from what I am really 
supposed to do, I will not be able to continue on these on a regular 
basis. Get somebody else interested, though, and I will be glad to help!

Ciao,
Dscho
