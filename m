X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] (experimental) per-topic shortlog.
Date: Tue, 28 Nov 2006 14:43:49 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0611281439500.30004@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7v8xhxsopp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611261652520.30076@woody.osdl.org>
 <Pine.LNX.4.63.0611280040480.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <7v7ixge8j2.fsf@assigned-by-dhcp.cox.net> <20061128131139.GA10874@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 13:46:43 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20061128131139.GA10874@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32525>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gp3Fk-00064d-0D for gcvg-git@gmane.org; Tue, 28 Nov
 2006 14:44:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933606AbWK1Nnw (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 08:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758675AbWK1Nnw
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 08:43:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:20128 "HELO mail.gmx.net") by
 vger.kernel.org with SMTP id S1758674AbWK1Nnv (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 08:43:51 -0500
Received: (qmail invoked by alias); 28 Nov 2006 13:43:50 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2)
 [132.187.25.13] by mail.gmx.net (mp023) with SMTP; 28 Nov 2006 14:43:50 +0100
To: Jeff King <peff@peff.net>
Sender: git-owner@vger.kernel.org

Hi,

On Tue, 28 Nov 2006, Jeff King wrote:

> I think it's clear that "important commits" is going to be something we 
> determine through heuristics; blame-able lines is probably a heuristic 
> worth considering.

I was surprised that not more of my stuff was in the top-15, since I 
submitted less-than-finished patches quite often. Especially 
merge-recursive was quite a bit of work for Alex and me.

BTW merge-recursive is a perfect example why this approach will break 
down: most of the rewrite in C took place in a private repository with 
quite some commits. This does not show in the git repository.

I fully expect the linux repository to behave similarly, since most of the 
features are cooked elsewhere, and not all of them are pulled, but some 
are applied (i.e. they appear out of nowhere from the repository's 
viewpoint).

Ciao,
Dscho
