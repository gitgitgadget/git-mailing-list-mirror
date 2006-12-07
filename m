X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Explicitly add the default "git pull" behaviour to
 .git/config on clone
Date: Thu, 7 Dec 2006 15:13:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071511440.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612061207.23437.andyparkins@gmail.com>
 <200612061800.17087.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.63.0612070022180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612070349.58521.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 14:13:53 +0000 (UTC)
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612070349.58521.Josef.Weidendorfer@gmx.de>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33579>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsK0R-00048V-Bc for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:13:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032242AbWLGONo (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032245AbWLGONo
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:13:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:36740 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1032242AbWLGONn
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:13:43 -0500
Received: (qmail invoked by alias); 07 Dec 2006 14:13:42 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 07 Dec 2006 15:13:42 +0100
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Josef Weidendorfer wrote:

> On Thursday 07 December 2006 00:23, Johannes Schindelin wrote:
> > Hi,
> > 
> > On Wed, 6 Dec 2006, Josef Weidendorfer wrote:
> > 
> > > On Wednesday 06 December 2006 13:07, Andy Parkins wrote:
> > > > The [branch "master"] section is such that there is no change to the
> > > > functionality of git-pull, but that functionality is now explicitly
> > > > documented.
> > > 
> > > Nice. However, changing "git-clone" for this is an adhoc solution and 
> > > looks wrong.
> > 
> > Not to me. There is _no_ other place to put this, if you want to help 
> > people graps the concept of branch.*.merge.
> 
> As far as I understand, git-clone defaults to kind of a mirror operation
> while changing remotes ref names slightly as tracking branches, and
> afterwards, it sets up a local branch for development, which is
> branched off from the branch which tracks remote's master.

Yes. And I should back off from my strong language: I think this git-clone 
the most obvious program to set branch.master.merge. It should make life 
easier for new Git users.

Ciao,
