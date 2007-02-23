From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-diff: fix combined diff
Date: Fri, 23 Feb 2007 12:19:40 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702231219080.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702230517480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070223053428.GA13301@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, junkio@cox.net
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 23 12:20:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKYTC-000745-KB
	for gcvg-git@gmane.org; Fri, 23 Feb 2007 12:20:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932517AbXBWLTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 06:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbXBWLTn
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 06:19:43 -0500
Received: from mail.gmx.net ([213.165.64.20]:46487 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932517AbXBWLTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 06:19:42 -0500
Received: (qmail invoked by alias); 23 Feb 2007 11:19:40 -0000
X-Provags-ID: V01U2FsdGVkX19JjZwlG3lJKSK+iATcXM1Vvom3Ilyj09tIHZWYpg
	VveQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070223053428.GA13301@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40440>

Hi,

On Fri, 23 Feb 2007, Jeff King wrote:

> On Fri, Feb 23, 2007 at 05:20:32AM +0100, Johannes Schindelin wrote:
> 
> > With "const unsigned (*parent)[20]", "parent + 1" is not the
> > same as "&parent[1]"...
> 
> Actually, they _are_ the same (the C standard definition of A[B] is *(A+B)).

Modulo binding precedence.

Thanks for clearing this up,
Dscho
