X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Locked down (but still shared) repositories
Date: Thu, 7 Dec 2006 16:42:43 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612071640160.28348@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20061207113539.GA10781@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 7 Dec 2006 15:43:02 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061207113539.GA10781@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33595>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GsLOb-0001EJ-4O for gcvg-git@gmane.org; Thu, 07 Dec
 2006 16:42:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1759420AbWLGPmq (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 7 Dec 2006
 10:42:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760074AbWLGPmq
 (ORCPT <rfc822;git-outgoing>); Thu, 7 Dec 2006 10:42:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:52983 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S1759420AbWLGPmp
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 7 Dec 2006 10:42:45 -0500
Received: (qmail invoked by alias); 07 Dec 2006 15:42:44 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp045) with SMTP; 07 Dec 2006 16:42:44 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Thu, 7 Dec 2006, Shawn Pearce wrote:

> For various auditing reasons the repositories need to be tightly
> controlled.  That is the following cannot be permitted:
> 
>   * delete or overwrite a loose object;
>   * delete or overwrite a pack file;
>   * delete or overwrite a ref, except see below;
>   * change the config;
>   * change the description;
>   * change HEAD;
> 
> [...]
>
> I also cannot create secondary git-only UNIX accounts for each user,
> using git-shell in the git-only account.

How about just one such user? After all, you already have this user: the 
repo owner. Of course, people have to push via ssh, even on the same 
machine.

Ciao,
Dscho
