X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Tracking a repository for content instead of history
Date: Tue, 12 Dec 2006 17:24:00 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612121715230.2807@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200612121235.09984.andyparkins@gmail.com>
 <200612121326.24508.andyparkins@gmail.com>
 <Pine.LNX.4.63.0612121527070.2807@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612121538.41197.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 12 Dec 2006 16:27:59 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200612121538.41197.andyparkins@gmail.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34107>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuATy-0004ZX-Lp for gcvg-git@gmane.org; Tue, 12 Dec
 2006 17:27:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1751540AbWLLQYu (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 12 Dec 2006
 11:24:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751516AbWLLQY0
 (ORCPT <rfc822;git-outgoing>); Tue, 12 Dec 2006 11:24:26 -0500
Received: from mail.gmx.net ([213.165.64.20]:42333 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1751521AbWLLQYD
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 12 Dec 2006 11:24:03 -0500
Received: (qmail invoked by alias); 12 Dec 2006 16:24:01 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp046) with SMTP; 12 Dec 2006 17:24:01 +0100
To: Andy Parkins <andyparkins@gmail.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 12 Dec 2006, Andy Parkins wrote:

> On Tuesday 2006 December 12 14:28, Johannes Schindelin wrote:
> 
> > You are not by any chance talking about the --remote option to
> > git-archive?
> 
> I wasn't; but that's certainly a helpful switch.  It's certainly a huge 
> help.
> 
> > If you want to reduce the number of objects to be downloaded, by telling
> > the other side what you have, you literally end up with something like
> > shallow clone: the other side _has_ to support it.
> 
> I suppose so; but I was thinking more an automated way of getting the data 
> that is supplied for the kernel anyway.  So:
> 
> base-v1.0.0.tar.gz
> patch-v1.0.1.gz
> patch-v1.0.2.gz
> etc
> 
> Each patch is obviously smaller than "base".  Git could easily make the 
> patches, and each of those patches could be fed by hand into a repository 
> with git-apply.

If it weren't for the recent discussion of kernel.org being overloaded 
with gitweb processes, I'd just write down a hint like 
http://repo.or.cz/w/git/jnareb-git.git?a=commitdiff_plain;h=next;hp=master

But since kernel.org is overloaded, I will not do that.

Ciao,
