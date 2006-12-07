X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Bug in merge-recursive in virtual commit corner case
Date: Thu, 7 Dec 2006 16:38:23 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071636030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207083531.GA22701@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 15:38:33 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207083531.GA22701@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33594>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLKR-0000Zl-2e for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:38:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S937993AbWLGPi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1032308AbWLGPi1
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:38:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:54621 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S937996AbWLGPi0
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 10:38:26 -0500
Received: (qmail invoked by alias); 07 Dec 2006 15:38:24 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp039) with SMTP; 07 Dec 2006 16:38:24 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Shawn Pearce wrote:

> So I managed to create a fairly complex set of branches which are all
> merged back against each other at various points in time.  Two of
> them have 3 merge bases according to git-merge-base.  Tonight I
> tried to merge them together, but received the following wonderful
> error from git-merge-recursive:
> 
>   fatal: unable to read source tree (4b825dc642cb6eb9a060e54bf8d69288fbee4904)
> 
> For those in the know, that's the empty tree.  This particular 
> repository does not have the empty tree anywhere in it, which is why we 
> can't read the object: it doesn't exist, and shouldn't exist.

I think there is something else wrong. If you have three merge bases, I do 
not see how you could get into that particular code path.

Any possibility for me to have a private look at your repo?

Ciao,
Dscho
