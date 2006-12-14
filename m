X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-fetch fails with error code 128
Date: Thu, 14 Dec 2006 18:19:21 -0500
Message-ID: <20061214231921.GG26202@spearce.org>
References: <200612142308.45376.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 23:19:31 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <200612142308.45376.andyparkins@gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34434>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuzrM-0000QJ-CE for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751850AbWLNXTZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:19:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751849AbWLNXTZ
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:19:25 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:41448 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751850AbWLNXTY (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 18:19:24 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1Guzr7-0007PB-Da; Thu, 14 Dec 2006 18:19:13 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 CE05E20FB65; Thu, 14 Dec 2006 18:19:21 -0500 (EST)
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Andy Parkins <andyparkins@gmail.com> wrote:
> $ git fetch
> remote: Generating pack...
> remote: Done counting 189146 objects.
> remote: Result has 186566 objects.
> remote: Deltifying 186566 objects.
> remote:  100% (186566/186566) done
> Unpacking 186566 objects
> fatal: failed to apply delta
> fatal: unpack-objects died with error code 128
> Fetch failure: /home/andyp/projects/temp/.git
> 
> What does that mean?  I ran fsck --full on the source repository, but it's 
> made no difference.

Bad voodoo.  What does 'git fetch -k' do?  It uses slightly
different code for handling the deltas...

-- 
