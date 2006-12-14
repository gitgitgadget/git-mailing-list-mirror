X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] INSTALL: no need to have GNU diff installed
Date: Fri, 15 Dec 2006 00:40:24 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612150037240.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0612141139540.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061214204634.GF8179@localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 14 Dec 2006 23:41:28 +0000 (UTC)
Cc: git@vger.kernel.org, junkio@cox.net
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061214204634.GF8179@localdomain>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34440>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gv0CV-0002wr-S4 for gcvg-git@gmane.org; Fri, 15 Dec
 2006 00:41:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751988AbWLNXlR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 14 Dec 2006
 18:41:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751990AbWLNXlR
 (ORCPT <rfc822;git-outgoing>); Thu, 14 Dec 2006 18:41:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:44237 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751988AbWLNXlQ
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 14 Dec 2006 18:41:16 -0500
Received: (qmail invoked by alias); 14 Dec 2006 23:40:30 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp040) with SMTP; 15 Dec 2006 00:40:30 +0100
To: Eric Wong <normalperson@yhbt.net>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 14 Dec 2006, Eric Wong wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 
> > Since a long time, we have inbuilt diff generation.
> 
> We still require it for running tests.  And git-rerere just
> added a dependency on it (my fault :)

Ah! Some of the tests are my fault, since I find the output of "diff -u" 
so much more pleasant than "cmp" when trying to find a bug.

How about adding a GNU diff look alike, say "git-file-diff"?

Ciao,
Dscho
