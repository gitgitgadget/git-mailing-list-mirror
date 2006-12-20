X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-merge-recursive segmentation error
Date: Wed, 20 Dec 2006 03:31:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612200329530.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <427701.7195.qm@web31811.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 20 Dec 2006 02:31:57 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <427701.7195.qm@web31811.mail.mud.yahoo.com>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34896>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GwrF6-00015W-Mo for gcvg-git@gmane.org; Wed, 20 Dec
 2006 03:31:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964785AbWLTCbi (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 19 Dec 2006
 21:31:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964787AbWLTCbi
 (ORCPT <rfc822;git-outgoing>); Tue, 19 Dec 2006 21:31:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:58479 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964785AbWLTCbh
 (ORCPT <rfc822;git@vger.kernel.org>); Tue, 19 Dec 2006 21:31:37 -0500
Received: (qmail invoked by alias); 20 Dec 2006 02:31:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp020) with SMTP; 20 Dec 2006 03:31:35 +0100
To: Luben Tuikov <ltuikov@yahoo.com>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 19 Dec 2006, Luben Tuikov wrote:

> --- Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> > 
> > On Tue, 19 Dec 2006, Luben Tuikov wrote:
> > 
> > > Auto-merging init/version.c
> > > /home/luben/bin/git-merge: line 394: 12030 
> > > Segmentation fault git-merge-$strategy $common -- "$head_arg" "$@"
> > 
> > Do you have any pointers how to get the two branches you try to merge? I'd 
> > be most grateful to have the sha1's of both heads, too...
> 
> The source tree is Linus' "master" tree.  The destination tree
> is my own "dev" tree, which I use as an intermediate tree, before 
> merging into my own kernel trees.
> 
> Hopefully with the backtrace I posted and with the big-bisect
> results pointing to the culprit commit, someone can get a patch out
> to fix this.

Given that you have an optimized git (it even optimized orig out!), and 
that the commit you bisected says "Avoid accessing a slow working copy 
during diffcore operations." which has nothing to do at all with 
merge-recursive, I give up. I don't have enough information. Really.

Ciao,
Dscho

