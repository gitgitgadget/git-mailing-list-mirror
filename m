From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Wed, 13 Jun 2007 19:54:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131953370.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <20070613184109.GG10941@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 13 20:58:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyY30-00071F-2W
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 20:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751111AbXFMS6Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 14:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751041AbXFMS6Y
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 14:58:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:45661 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbXFMS6X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 14:58:23 -0400
Received: (qmail invoked by alias); 13 Jun 2007 18:58:20 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp041) with SMTP; 13 Jun 2007 20:58:20 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1883dU4mwM8Tbq5MBf1ob10d20w15PvFoWWLJ14SZ
	u3opkGFQGzO4Pi
X-X-Sender: gene099@racer.site
In-Reply-To: <20070613184109.GG10941@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50117>

Hi,

On Wed, 13 Jun 2007, Jeff King wrote:

> On Wed, Jun 13, 2007 at 01:50:22AM +0100, Johannes Schindelin wrote:
> 
> > Earlier, Git interpreted the pattern as a strict prefix, which made
> > the operator unsuited in many cases.
> 
> Thank you for working on this...I really like the :/ concept, but find
> myself wishing for a regex all the time. I have been meaning to do it
> since you introduced the original. :)

:-) Since you seem comfortable with regular expressions, maybe you can 
help me: I am looking for a pattern which matches _any_ character, and one 
which matches only non-newlines, both with and without REG_NEWLINE. Hmm?

Tia,
Dscho
