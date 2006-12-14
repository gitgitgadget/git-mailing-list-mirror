X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Document the simple way of using of git-cat-file
Date: Thu, 14 Dec 2006 01:29:17 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612140127520.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061213221841.GB4928@fieldses.org>
 <20061213232056.11218.67473.stgit@lathund.dewire.com> <elq3pa$93b$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 00:29:32 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <elq3pa$93b$1@sea.gmane.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34271>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GueTa-0008Oz-UG for gcvg-git@gmane.org; Thu, 14 Dec
 2006 01:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751856AbWLNA3U (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 19:29:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751853AbWLNA3U
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 19:29:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:41238 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751856AbWLNA3T
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 19:29:19 -0500
Received: (qmail invoked by alias); 14 Dec 2006 00:29:17 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 14 Dec 2006 01:29:17 +0100
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Jakub Narebski wrote:

> Robin Rosenberg wrote:
> 
> > Since you can give a version and a path name to git-cat-file,
> > mention it in the man page.
> 
> Very nice, with the exception that git cat-file can be used also
> for trees and commits (although hit-ls-tree and git-show are usually
> used) and for tags, not only for files.

The point is: you are much more likely to look at a blob that at a tree. 
And if you want to do that, you can always use git-ls-tree.

But as I mentioned in another thread, I'd rather see git-show do the job 
of showing blobs, too, in addition to commits as it does already.

Ciao,
Dscho
