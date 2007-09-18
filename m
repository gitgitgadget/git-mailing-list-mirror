From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 12:18:24 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181217200.28586@racer.site>
References: <20070918072627.GB3506@coredump.intra.peff.net>
 <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se>
 <20070918103051.GA22239@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:19:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXb6w-0002sQ-FT
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:19:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbXIRLTQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:19:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755499AbXIRLTP
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:19:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:49257 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755390AbXIRLTO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:19:14 -0400
Received: (qmail invoked by alias); 18 Sep 2007 11:19:10 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 18 Sep 2007 13:19:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19GsZ5oZVRG0cBvUbScKPs1eA8YJtcebfLNy/2iS4
	Jvs/sJr7mVPk6I
X-X-Sender: gene099@racer.site
In-Reply-To: <20070918103051.GA22239@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58580>

Hi,

On Tue, 18 Sep 2007, Jeff King wrote:

> I think he means a dump that you can meaningfully edit with sed or a 
> text editor. And even nicer, one that could be fed back into 
> git-fast-import. So you could do something like:
> 
> git-fast-export A..B >dump
> vi dump
> git-fast-import <dump
> 
> to rewrite history in a very flexible way.

Exactly what I meant.  Some people seem to have problems with 
filter-branch, but somehow no proper bug report, let alone fix, evolved 
from that.

I guess these people are more comfortable with what you just described.

Ciao,
Dscho
