X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] git-show: grok blobs, trees and tags, too
Date: Thu, 14 Dec 2006 05:37:41 -0500
Message-ID: <20061214103741.GD1747@spearce.org>
References: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 14 Dec 2006 10:38:07 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612141129320.3635@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34304>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GunyN-0007K9-8q for gcvg-git@gmane.org; Thu, 14 Dec
 2006 11:37:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932311AbWLNKhv (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 05:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbWLNKhv
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 05:37:51 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34239 "EHLO
 corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1751917AbWLNKhu (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006
 05:37:50 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173]
 helo=asimov.home.spearce.org) by corvette.plexpod.net with esmtpa (Exim 4.52)
 id 1GunyC-0004DD-JN; Thu, 14 Dec 2006 05:37:44 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000) id
 A92D820FB65; Thu, 14 Dec 2006 05:37:42 -0500 (EST)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>..

Nice!  I like this.

> +git show master:Makefile master:t/Makefile
> +	Concatenates the contents of said Makefiles in the head
> +	of the branch `master`.
> +

Uh, isn't that what cat does?  Shouldn't this be "git cat"?  :-)

Nevermind.  :)

-- 
