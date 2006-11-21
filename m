X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Some tips for doing a CVS importer
Date: Tue, 21 Nov 2006 15:05:08 -0500
Message-ID: <20061121200508.GB22461@spearce.org>
References: <9e4733910611201349s4d08b984g772c64982f148bfa@mail.gmail.com> <46a038f90611201503m6a63ec8ct347026c635190108@mail.gmail.com> <9e4733910611201537h30b6c9f4oee9d8df75284c284@mail.gmail.com> <46a038f90611201629o39f11f42ye07b86159360b66e@mail.gmail.com> <87vel9y5x6.wl%cworth@cworth.org> <9e4733910611201740i348302e6r84c3c27dc27e5954@mail.gmail.com> <20061121063934.GA3332@spearce.org> <456359E2.8010403@cc.jyu.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 20:05:56 +0000 (UTC)
Cc: Jon Smirl <jonsmirl@gmail.com>, Carl Worth <cworth@cworth.org>,
	Martin Langhoff <martin.langhoff@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <456359E2.8010403@cc.jyu.fi>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32033>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gmbs3-0006Mn-QI for gcvg-git@gmane.org; Tue, 21 Nov
 2006 21:05:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031377AbWKUUFU (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 15:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031379AbWKUUFU
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 15:05:20 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:7146 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1031377AbWKUUFS
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 15:05:18 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gmbra-00076e-2n; Tue, 21 Nov 2006 15:05:02 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 3AEBF20FB09; Tue, 21 Nov 2006 15:05:08 -0500 (EST)
To: lamikr <lamikr@cc.jyu.fi>
Sender: git-owner@vger.kernel.org

lamikr <lamikr@cc.jyu.fi> wrote:
> Shawn Pearce wrote:
> >   - No GUI.
> >   
> QGIT allows using some commands. I plan to try out the GIT eclipse
> plugin in near future myself.
> This mail list have some discussion and download link to it's repo in
> archives.
> (title: Java GIT/Eclipse GIT version 0.1.1, )

I'm the author of that plugin.  :-)

Its not even capable of making a commit yet.  The underling plumbing
(aka jgit) can make commits but the Eclipse GUI has no function to
actually invoke that plumbing and make a commit to the repository.

The Eclipse plugin has apparently been a low priority for me.
I haven't worked on it very recently.  Robin Rosenburg has supposedly
gotten the revision compare interface to work, but its slow as a
duck in November due to jgit's pack reading code not running as
fast as it should.
 
-- 
