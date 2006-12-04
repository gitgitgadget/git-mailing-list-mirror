X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: egit/jgit wishlist
Date: Mon, 4 Dec 2006 13:29:02 -0500
Message-ID: <20061204182902.GG6011@spearce.org>
References: <20061204172836.GB6011@spearce.org> <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 4 Dec 2006 18:29:18 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612041841280.14187@alpha.polcom.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33215>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GrIYy-0004nJ-5o for gcvg-git@gmane.org; Mon, 04 Dec
 2006 19:29:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937235AbWLDS3J (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 4 Dec 2006
 13:29:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937236AbWLDS3J
 (ORCPT <rfc822;git-outgoing>); Mon, 4 Dec 2006 13:29:09 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40518 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S937235AbWLDS3G (ORCPT <rfc822;git@vger.kernel.org>); Mon, 4 Dec 2006
 13:29:06 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GrIZa-0008Ia-PO; Mon, 04 Dec 2006 13:29:50 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8DDBD20FB7F; Mon,  4 Dec 2006 13:29:02 -0500 (EST)
To: Grzegorz Kulewski <kangur@polcom.net>
Sender: git-owner@vger.kernel.org

Grzegorz Kulewski <kangur@polcom.net> wrote:
> I think that doing it in 100% pure Java is ok in long run but I wonder if 
> you couldn't make "wrapper" plugin for a start (that would call the real C 
> git for every operation) and make it usable (with full pure Java SWT UI 
> support) and then try to implement feature by feature in pure Java (with 
> config options telling what should be called by wrapper and what by pure 
> implementation)?

Several people have proposed doing exactly that, but thus far
myself and Robin Rosenburg have been the only two to step forward
with code.  I personally want to avoid calling external programs
as much as possible here, and that means staying with a 100% pure
Java implementation.  Hence the desire to not build a wrapper plugin.

We have the core repository reading and writing working.  We can
write out trees.  We can create commits (we just lack UI for it).
So we're part of the way there...

-- 
