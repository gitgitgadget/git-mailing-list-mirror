From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Thu, 14 Jun 2007 09:09:40 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706140909360.4059@racer.site>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
 <20070613184109.GG10941@coredump.intra.peff.net> <Pine.LNX.4.64.0706131953370.4059@racer.site>
 <20070613200011.GA17360@coredump.intra.peff.net> <Pine.LNX.4.64.0706132317240.4059@racer.site>
 <4670F2BB.5060909@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 14 10:13:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HykS7-0008HH-TS
	for gcvg-git@gmane.org; Thu, 14 Jun 2007 10:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754106AbXFNINI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Jun 2007 04:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754091AbXFNINI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jun 2007 04:13:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:48451 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753634AbXFNING (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jun 2007 04:13:06 -0400
Received: (qmail invoked by alias); 14 Jun 2007 08:13:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp031) with SMTP; 14 Jun 2007 10:13:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/CTJ5aRSzCyMdaxETcopoIV5u+tsnqawbRh+0tr/
	v9iAVxdLV9eTzT
X-X-Sender: gene099@racer.site
In-Reply-To: <4670F2BB.5060909@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50179>

Hi,

On Thu, 14 Jun 2007, Sam Vilain wrote:

> Johannes Schindelin wrote:
>
> > So no, I think pcre is just not worth it.
>
> A strange thing to conclude from your figures, which show pcre as the 
> fastest out of several libraries that you tested.

The best of the worse. Yes. An external (!) program was 4x faster than 
pcre. I don't know how to make it more obvious that pcre sucks.

Hth,
Dscho
