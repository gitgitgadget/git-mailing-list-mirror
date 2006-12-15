X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Suggest use of 'git add' when 'nothing to commit' gets shown.
Date: Fri, 15 Dec 2006 10:06:32 -0500
Message-ID: <20061215150632.GD17860@spearce.org>
References: <20061215001350.GA26755@spearce.org> <458266D4.5050301@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 15 Dec 2006 15:06:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Parkins <andyparkins@gmail.com>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <458266D4.5050301@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34511>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvEe0-0006S2-Vo for gcvg-git@gmane.org; Fri, 15 Dec
 2006 16:06:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751570AbWLOPGi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 10:06:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752710AbWLOPGi
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 10:06:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48880 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751570AbWLOPGh (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 10:06:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GvEdp-0007Vs-4W; Fri, 15 Dec 2006 10:06:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8CA1C20FB65; Fri, 15 Dec 2006 10:06:32 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Sender: git-owner@vger.kernel.org

Andreas Ericsson <ae@op5.se> wrote:
> Shawn O. Pearce wrote:
> > else
> > 	if [ -z "$(git-ls-files)" ]; then
> >-		echo >&2 Nothing to commit
> >+		echo >&2 "Nothing to commit (use \"git add\" include for 
> >commit)"
> 
> s/git add include/git add to include/

Thanks!  I'm going to rewrite this patch series as I clearly fumbled
a few items, which you were kind enough to take the time to point
out for me.

> It would probably be nice to use one and the same message everywhere though.

That was my intent.  My fingers failed me somehow.  ;-)

-- 
