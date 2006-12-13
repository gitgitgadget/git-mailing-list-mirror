X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 18:26:37 -0500
Message-ID: <20061213232637.GF32568@spearce.org>
References: <200612132200.41420.andyparkins@gmail.com> <20061213225627.GC32568@spearce.org> <elq1ig$4ie$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 23:27:04 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <elq1ig$4ie$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34256>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudV2-0000wc-H3 for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:26:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751747AbWLMX0l (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:26:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751795AbWLMX0l
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:26:41 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39617 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751747AbWLMX0k (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 18:26:40 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GudUb-0000kS-MX; Wed, 13 Dec 2006 18:26:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 9BE8920FB6E; Wed, 13 Dec 2006 18:26:37 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Shawn Pearce wrote:
> 
> >   git cat-file -p $REV:$file
> > 
> > not sure how much easier it gets than that.  Load in the bash
> > completion from contrib/completion and you can even tab complete
> > the $file part.
> 
> Actually, tab completion allows to complete both $REV and $file part.

Good point.  Unless $REV is a SHA1 in hex format, as tab completion
for commits in hex SHA1 isn't supported.

Though I have thought about implementing it.  ;-)

-- 
