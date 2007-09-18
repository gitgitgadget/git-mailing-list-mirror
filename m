From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] contrib/fast-import: add perl version of simple example
Date: Tue, 18 Sep 2007 12:17:15 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709181216040.28586@racer.site>
References: <20070918072627.GB3506@coredump.intra.peff.net>
 <Pine.LNX.4.64.0709181115250.28586@racer.site> <46EFA84C.3080906@op5.se>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Sep 18 13:18:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXb5u-0002ao-4d
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 13:18:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754531AbXIRLSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Sep 2007 07:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755421AbXIRLSI
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Sep 2007 07:18:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:54495 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754531AbXIRLSH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Sep 2007 07:18:07 -0400
Received: (qmail invoked by alias); 18 Sep 2007 11:18:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp001) with SMTP; 18 Sep 2007 13:18:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/g79FdUTTgr15e+JLVDNlUhTFjlwdmxUcHWtjLJt
	xFKSPi0+XMowSW
X-X-Sender: gene099@racer.site
In-Reply-To: <46EFA84C.3080906@op5.se>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58578>

Hi,

On Tue, 18 Sep 2007, Andreas Ericsson wrote:

> Johannes Schindelin wrote:
>
> > Maybe somebody will then grab the low-hanging fruit of writing a 
> > "git-fast-export", which can be used to dump a complete repository in 
> > text format?
> 
> I thought that was already taken care of since format-patch handles
> --root flag properly?

Umm.  Probably you forgot about merge commits, right?  And about more than 
one branch?

> Otherwise, "git repack -a --window=0 --depth=0" should provide an easily 
> parseable dump of an entire repo.

This is not a dump.  It is a log.

Ciao,
Dscho
