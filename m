X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: win2k/cygwin cannot handle even moderately sized packs
Date: Tue, 7 Nov 2006 13:18:08 -0500
Message-ID: <20061107181808.GC26591@spearce.org>
References: <81b0412b0611070302h50541cd5mf0758afe0d6befda@mail.gmail.com> <45507965.3010806@peralex.com> <81b0412b0611070555u1833cc8ci1d37d45782562df8@mail.gmail.com> <eiq9vm$l7c$1@sea.gmane.org> <81b0412b0611070928l7be83e08kbfc9657937fe7c92@mail.gmail.com> <20061107174859.GB26591@spearce.org> <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 7 Nov 2006 18:20:21 +0000 (UTC)
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <81b0412b0611071013j51254a40s749fb6cba65e6873@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31085>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GhVYU-00074n-He for gcvg-git@gmane.org; Tue, 07 Nov
 2006 19:20:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965673AbWKGSTr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 7 Nov 2006
 13:19:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965671AbWKGSTr
 (ORCPT <rfc822;git-outgoing>); Tue, 7 Nov 2006 13:19:47 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:23738 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965673AbWKGSTq
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2006 13:19:46 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GhVWO-0004rq-Eu; Tue, 07 Nov 2006 13:18:04 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 014E420E487; Tue,  7 Nov 2006 13:18:08 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Sender: git-owner@vger.kernel.org

Alex Riesen <raa.lkml@gmail.com> wrote:
> >The patches are on the mailing list archives somewhere around
> >Sept. 5th timeframe from me; as I recall we dropped them as they
> >didn't apply on top of Junio's 64 bit index changes (which were
> >reverted out of next anyway).
> 
> I seem to be unable to find them. Does anyone still has the
> patches/branch please? Junio, you did sound interested?
> (God, I wish I have paid attention then...)

Junio definately wants to implement at least something similar
to what I did; I just happened to do it at the wrong time.  :-)

I keep saying I'll get back around to rewriting the patch (as the
affected regions of git have been heavily modified recently by Nico
and thus it doesn't apply) but I keep not finding the time.

Maybe that's because I was working on git-gui...

-- 
