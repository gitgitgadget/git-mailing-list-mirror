X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Enable reflogs by default in any repository with a working directory.
Date: Thu, 14 Dec 2006 18:18:32 -0500
Message-ID: <20061214231832.GF26202@spearce.org>
References: <7v1wn243mu.fsf@assigned-by-dhcp.cox.net> <20061214224117.GA26374@spearce.org> <20061214231038.GC5147@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 23:18:46 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <20061214231038.GC5147@fieldses.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34433>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Guzqb-0000LG-VK for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:18:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751771AbWLNXSi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:18:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751826AbWLNXSi
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:18:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41414 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751771AbWLNXSh (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:18:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GuzqK-0007J3-KW; Thu, 14 Dec 2006 18:18:24 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 D5F9B20FB65; Thu, 14 Dec 2006 18:18:32 -0500 (EST)
To: "J. Bruce Fields" <bfields@fieldses.org>
Sender: git-owner@vger.kernel.org

"J. Bruce Fields" <bfields@fieldses.org> wrote:
> On Thu, Dec 14, 2006 at 05:41:17PM -0500, Shawn O. Pearce wrote:
> > New and experienced Git users alike are finding out too late that
> > they forgot to enable reflogs in the current repository, and cannot
> > use the information stored within it to recover from an incorrectly
> > entered command such as `git reset --hard HEAD^^^` when they really
> > meant HEAD^^ (aka HEAD~2).
> 
> Stupid question--I assume a mention in the reflog doesn't count as a
> real reference to an object, so they won't save you in the case when you
> pruned recently?

Not a stupid question.  Your assumption is correct, its not a real
reference, so prune will remove things that the log mentions but
that refs don't currently mention.

-- 
