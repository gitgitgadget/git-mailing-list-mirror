X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 15:28:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612121235.09984.andyparkins@gmail.com> <elm993$rf1$1@sea.gmane.org>
 <200612121326.24508.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 14:28:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612121326.24508.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34101>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gu8cN-0000uI-S2 for gcvg-git@gmane.org; Tue, 12 Dec
 2006 15:28:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751367AbWLLO2Y (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 09:28:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWLLO2Y
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 09:28:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:43848 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751367AbWLLO2Y
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 09:28:24 -0500
Received: (qmail invoked by alias); 12 Dec 2006 14:28:22 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp029) with SMTP; 12 Dec 2006 15:28:22 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Andy Parkins wrote:

> The way I would do it given nothing else is to simply extract snapshots 
> into a working directory; and create a repository from scratch.  I was 
> just wondering if a method existed that could reduce the size of the 
> download.

You are not by any chance talking about the --remote option to 
git-archive?

If you want to reduce the number of objects to be downloaded, by telling 
the other side what you have, you literally end up with something like 
shallow clone: the other side _has_ to support it.

Ciao,
Dscho
