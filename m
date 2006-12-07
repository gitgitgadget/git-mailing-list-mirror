X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Commit f84871 breaks build on OS X
Date: Thu, 7 Dec 2006 15:55:03 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071554180.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 14:55:29 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <2D096A57-D7B3-49C7-81E4-EB47A0D933B2@silverinsanity.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33586>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsKei-00021H-Rh for gcvg-git@gmane.org; Thu, 07 Dec
 2006 15:55:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1032275AbWLGOzI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 09:55:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032280AbWLGOzI
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 09:55:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:53800 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1032275AbWLGOzG
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 09:55:06 -0500
Received: (qmail invoked by alias); 07 Dec 2006 14:55:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp001) with SMTP; 07 Dec 2006 15:55:04 +0100
To: Brian Gernhardt <benji@silverinsanity.com>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Brian Gernhardt wrote:

> When I pulled the most recent changes for git (de51faf), `make` began 
> failing with the following messages: [...]

I found the same, but could not reproduce it. But a "touch perl/perl.mak" 
fixes at least compilation.

Ciao,
Dscho
