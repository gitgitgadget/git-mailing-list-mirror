X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-PS1 bash prompt setting
Date: Sun, 26 Nov 2006 15:27:07 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611261524130.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Sun, 26 Nov 2006 14:27:36 +0000 (UTC)
Cc: git@vger.kernel.org, Theodore Tso <tytso@mit.edu>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <BAYC1-PASMTP037FDA6C6465F0541AC613AEE90@CEZ.ICE>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32346>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GoKyV-0001vw-Hc for gcvg-git@gmane.org; Sun, 26 Nov
 2006 15:27:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S935407AbWKZO1L (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 26 Nov 2006
 09:27:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935408AbWKZO1L
 (ORCPT <rfc822;git-outgoing>); Sun, 26 Nov 2006 09:27:11 -0500
Received: from mail.gmx.de ([213.165.64.20]:49351 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S935407AbWKZO1K (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 26 Nov 2006 09:27:10 -0500
Received: (qmail invoked by alias); 26 Nov 2006 14:27:08 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp026) with SMTP; 26 Nov 2006 15:27:08 +0100
To: Sean <seanlkml@sympatico.ca>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 16 Nov 2006, Sean wrote:

> For what it's worth i'll post a little script i've been using for quite
> some time that helps a little.  It's called git-PS1 and is used by
> including it in your bash PS1 variable like so:
> 
> export PS1='$(git-PS1 "[\u@\h \W]\$ ")'

I actually like that very much! So much that I tried to implement this as 
an option to an existing builtin (I did not want to clutter the list of 
commands any more...).

But there really is no good place to put it: most commands need a git 
repository, and those which do not, are inappropriate to put an option 
"--show-ps1" into. Except maybe repo-config. Thoughts?

Ciao,
Dscho
