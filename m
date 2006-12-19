X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-cvsserver: fix breakage when calling git merge-file
Date: Wed, 20 Dec 2006 00:59:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200058280.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061219225820.GA6418@soma>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 00:00:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061219225820.GA6418@soma>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34867>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwosN-0005zP-3U for gcvg-git@gmane.org; Wed, 20 Dec
 2006 01:00:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932626AbWLSX74 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 18:59:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932622AbWLSX74
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 18:59:56 -0500
Received: from mail.gmx.net ([213.165.64.20]:49383 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932661AbWLSX7z
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 18:59:55 -0500
Received: (qmail invoked by alias); 19 Dec 2006 23:59:53 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp005) with SMTP; 20 Dec 2006 00:59:53 +0100
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Eric Wong wrote:

> In the same vein as 8336afa563fbeff35e531396273065161181f04c, this fixes 
> the the RCS merge to git-merge-file conversion in commit e2b70087.

Ooops. I should have checked after reading 8336afa if there are more 
offenders. Alas, I checked now, and there seem none to be left. But 
everybody can see now why I try to get an all-C Git: I suck at perl.

Ciao,
Dscho
