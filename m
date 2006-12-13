X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-add --interactive (wip)
Date: Wed, 13 Dec 2006 12:20:13 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612131216350.3635@wbgn013.biozentrum.uni-wuerzburg.de>
References: <360959.72234.qm@web31809.mail.mud.yahoo.com>
 <200612111147.44964.Josef.Weidendorfer@gmx.de> <7vwt4wpytm.fsf@assigned-by-dhcp.cox.net>
 <200612130415.59038.Josef.Weidendorfer@gmx.de> <7v1wn4mk9i.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612131137100.3635@wbgn013.biozentrum.uni-wuerzburg.de>
 <20061213105754.GC9484@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 13 Dec 2006 11:22:09 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061213105754.GC9484@spearce.org>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34210>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GuSBW-0003lP-NZ for gcvg-git@gmane.org; Wed, 13 Dec
 2006 12:22:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S964875AbWLMLUx (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 13 Dec 2006
 06:20:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964861AbWLMLUU
 (ORCPT <rfc822;git-outgoing>); Wed, 13 Dec 2006 06:20:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:39482 "HELO mail.gmx.net"
 rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP id S964876AbWLMLUQ
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 13 Dec 2006 06:20:16 -0500
Received: (qmail invoked by alias); 13 Dec 2006 11:20:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp041) with SMTP; 13 Dec 2006 12:20:14 +0100
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

Hi,

On Wed, 13 Dec 2006, Shawn Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 12 Dec 2006, Junio C Hamano wrote:
> > > Hmm, a way to easily stash away local changes and restoring
> > > would lead to a system where you can easily stash and unstash
> > > multiple snapshots and switch between them, and such a model
> > > sounds vaguely familiar...
> > 
> > Hmm, what might that be? :-)
> > 
> > A more simple approach than to buy into Python 
> 
> Hmmm... last I heard Git doesn't depend on Python anymore, thanks
> largely to you and Alex.

I referred to StGit, which is pure Python AFAIK.

> But it does stash and unstash snapshots of my working directory wicked 
> fast using these things called branches...  :-)

The PEBCAK. I cannot hardly type the commands as fast as Git need to stash 
snapshots into branches.

So, git-revolve-stage would help me. Or maybe I create bash aliases

$ alias stash='stash_tree=$(git-write-tree)'
$ alias unstash='git-read-tree $stash_tree'

Ciao,
Dscho
