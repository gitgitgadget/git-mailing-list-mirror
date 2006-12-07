X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Locked down (but still shared) repositories
Date: Thu, 7 Dec 2006 15:16:25 -0500
Message-ID: <20061207201625.GA12502@spearce.org>
References: <20061207113539.GA10781@spearce.org> <Pine.LNX.4.63.0612071640160.28348@wbgn013.biozentrum.uni-wuerzburg.de> <20061207191730.GA12143@spearce.org> <45786F5A.6020400@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 7 Dec 2006 20:16:48 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <45786F5A.6020400@dawes.za.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33629>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsPfY-0005F3-6H for gcvg-git@gmane.org; Thu, 07 Dec
 2006 21:16:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1163274AbWLGUQa (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 15:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1163273AbWLGUQa
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 15:16:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:37401 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1163277AbWLGUQ3 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006
 15:16:29 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GsPfI-00069K-7D; Thu, 07 Dec 2006 15:16:20 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 0879220FB6E; Thu,  7 Dec 2006 15:16:26 -0500 (EST)
To: Rogan Dawes <discard@dawes.za.net>
Sender: git-owner@vger.kernel.org

Rogan Dawes <discard@dawes.za.net> wrote:
> Shawn Pearce wrote:
> >In the situation you describe everyone looks the same to the
> >update hook...
> 
> See Section 8.2.6.1
> 
> http://www.unix.org.ua/orelly/networking_2ndEd/ssh/ch08_02.htm
> 
> You should be able to do something similar for git as they do for SSH.

Ok, I just learned something new.  Thank you!

Forced commands on a per-key basis would certainly work.  I'm not
settled on the idea as the end solution, but it does seem to be
perhaps slightly better than the setuid approach.

-- 
