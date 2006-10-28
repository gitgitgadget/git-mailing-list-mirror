X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Add git-count-packs, like git-count-objects.
Date: Sat, 28 Oct 2006 02:51:43 -0400
Message-ID: <20061028065143.GA14607@spearce.org>
References: <20061028040056.GA14191@spearce.org> <7v8xj1axlm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 28 Oct 2006 06:52:04 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7v8xj1axlm.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30368>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gdi2t-0000ho-1i for gcvg-git@gmane.org; Sat, 28 Oct
 2006 08:51:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751600AbWJ1Gvw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 28 Oct 2006
 02:51:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751876AbWJ1Gvw
 (ORCPT <rfc822;git-outgoing>); Sat, 28 Oct 2006 02:51:52 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18829 "EHLO
 corvette.plexpod.net") by vger.kernel.org with ESMTP id S1751600AbWJ1Gvv
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 28 Oct 2006 02:51:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Gdi2i-0001pV-QK; Sat, 28 Oct 2006 02:51:44 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 BBEBE20E45B; Sat, 28 Oct 2006 02:51:43 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

Junio C Hamano <junkio@cox.net> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
> 
> > Now that we are starting to save packs rather than unpacking into
> > loose objects its nice to have a way to list the number of current
> > packs and their total size.  This can help the user in deciding
> > when its time to run `git repack -a -d`.
> 
> Why not just do "ls -lh $GIT_OBJECT_DIR/pack/pack-*.pack"???

Because whatever we decide to use to make a pack 'active' may not
be that simple.

Whatever.  It was clearly a very tiny patch put together quickly
before dinner tonight, perhaps not worth including at this point.
Lets see what comes out of the other pack oriented discussion first.

-- 
