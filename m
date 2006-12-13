X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Using git as a general backup mechanism (was Re: Using GIT to
 store /etc)
Date: Wed, 13 Dec 2006 01:01:39 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612130100220.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com>
 <Pine.LNX.4.64.0612111837210.20138@iabervon.org> <8900B938-1360-4A67-AB15-C9E84255107B@mac.com>
 <200612121553.37499.andyparkins@gmail.com> <457F31E6.8090701@midwinter.com>
 <Pine.LNX.4.63.0612122355400.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <457F3606.7020805@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 00:08:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <457F3606.7020805@midwinter.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34171>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuHfd-0002B9-Mv for gcvg-git@gmane.org; Wed, 13 Dec
 2006 01:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S932577AbWLMAIX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 19:08:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWLMAIX
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 19:08:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:38431 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S932577AbWLMAIW
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 19:08:22 -0500
Received: (qmail invoked by alias); 13 Dec 2006 00:01:41 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp043) with SMTP; 13 Dec 2006 01:01:41 +0100
To: Steven Grimm <koreth@midwinter.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Steven Grimm wrote:

> Johannes Schindelin wrote:
> > $ git pull --depth 1
> > 
> > Though it needs a server _and_ a client supporting shallow clones, 
> > which support is brewed in "next" right now.
> 
> Will that actually discard old revisions that are already stored 
> locally?

No. A pull should _never_ lose anything from the repository. However, if 
some objects become no-longer reachable (and at the moment it looks like 
we cut of history, even if we should not need to), they can be pruned from 
the repo.

Hth,
Dscho
