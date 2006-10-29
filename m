X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: fetching packs and storing them as packs
Date: Sun, 29 Oct 2006 01:21:46 -0400
Message-ID: <20061029052146.GA3847@spearce.org>
References: <20061028034206.GA14044@spearce.org> <Pine.LNX.4.64.0610272109500.3849@g5.osdl.org> <7vwt6l9etn.fsf@assigned-by-dhcp.cox.net> <20061028072146.GB14607@spearce.org> <20061028084001.GC14607@spearce.org> <7vfyd88d6s.fsf@assigned-by-dhcp.cox.net> <20061029035025.GC3435@spearce.org> <7vejsr68y9.fsf@assigned-by-dhcp.cox.net> <20061029043818.GA3650@spearce.org> <7v3b9766rc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 29 Oct 2006 05:21:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v3b9766rc.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30415>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Ge37K-00071i-N4 for gcvg-git@gmane.org; Sun, 29 Oct
 2006 06:21:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S965019AbWJ2FVv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 01:21:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965023AbWJ2FVv
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 01:21:51 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38878 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S965019AbWJ2FVv
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 01:21:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Ge37Y-0005rJ-0m; Sun, 29 Oct 2006 01:22:08 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8582920E45B; Sun, 29 Oct 2006 01:21:46 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> >> Then we can make "pack-objects --unpacked" to pretend the ones
> >> with corresponding .volatile as if the objects in them are
> >> loose, without breaking backward compatibility.
> >
> > Currently I'm changing --unpacked= to match without needing quoting.
> > I'm allowing it to match an exact pack name or if it starts with
> > "pack-" and matches the last 50 ("pack-X{40}.pack") of the pack name.
> 
> I think is a very sane thing to do (I should have done that from
> the beginning).  I do not like "the last 50", but I do not have
> objection to make it take either full path or just the filename
> under objects/pack/ (so not "the last 50" but "filename w/o
> slash").

OK.  I coded it with the last 50 but will rewrite that commit
without as the code is slightly shorter that way.  :-)

-- 
