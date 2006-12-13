X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: svn versus git
Date: Wed, 13 Dec 2006 18:17:54 -0500
Message-ID: <20061213231754.GD32568@spearce.org>
References: <200612132200.41420.andyparkins@gmail.com> <elpun9$qp1$1@sea.gmane.org> <200612132251.17202.andyparkins@gmail.com> <elq1c8$37d$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 13 Dec 2006 23:18:45 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <elq1c8$37d$1@sea.gmane.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34251>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GudN0-0008Lx-1A for gcvg-git@gmane.org; Thu, 14 Dec
 2006 00:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751729AbWLMXR7 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 18:17:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751733AbWLMXR7
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 18:17:59 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:39149 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751729AbWLMXR6 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006
 18:17:58 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GudMA-0007z7-TA; Wed, 13 Dec 2006 18:17:46 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 8441F20FB6E; Wed, 13 Dec 2006 18:17:54 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Jakub Narebski <jnareb@gmail.com> wrote:
> Andy Parkins wrote:
> 
> >> Hmmm... I thought that some progress indicator of download/upload was
> >> added... guess I was wrong.
> > 
> > You're not wrong, there is a progress indicator, but it's measured 
> > in "objects" not megabytes.  It's got a percentage as well.  Neither of these 
> > things is a whole lot of use if I want to know how much data (in megabytes) 
> > has been transferred, how much is there left to go and how long is it going 
> > to take.
> 
> No, what you see is if I understand correctly progress indicator for
> local and remote generating pack to send / exploding pack into loose
> objects (or not). There was some patch to add download/upload progress
> indicator, but I guess it was not applied.

There is one that gets started when the transfer is taking a while,
but it shows the total number of MiB transferred and the current
transfer rate.  I don't think there's a way to tell when it will be
done, just that its running and running slower than you might like.
:-)

Part of the problem is the remote end doesn't know how many bytes
are needed for the pack its sending until after it has finished
sending the pack.  Sort of a catch-22.

-- 
