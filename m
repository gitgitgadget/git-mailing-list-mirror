From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] [v8] safecrlf: Add mechanism to warn about irreversible
 crlf conversions
Date: Mon, 4 Feb 2008 17:27:57 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802041722260.7372@racer.site>
References: <86F2B863-6FE8-407E-B535-3F49782DA5F9@zib.de> <12021001351967-git-send-email-prohaska@zib.de> <alpine.LSU.1.00.0802041502290.7372@racer.site> <459F2F36-7110-42A0-BDC1-FED70BC499BD@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 18:29:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JM58M-0007fd-CU
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 18:29:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756688AbYBDR2i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2008 12:28:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbYBDR2h
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Feb 2008 12:28:37 -0500
Received: from mail.gmx.net ([213.165.64.20]:33312 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757333AbYBDR2g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2008 12:28:36 -0500
Received: (qmail invoked by alias); 04 Feb 2008 17:28:35 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 04 Feb 2008 18:28:35 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19Im7Q/PpJIa6/ZyryUrybROoJCOfCinrmDZ4O+0K
	dMiaUm1G9K1eeN
X-X-Sender: gene099@racer.site
In-Reply-To: <459F2F36-7110-42A0-BDC1-FED70BC499BD@zib.de>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72530>

Hi,

On Mon, 4 Feb 2008, Steffen Prohaska wrote:

> On Feb 4, 2008, at 4:02 PM, Johannes Schindelin wrote:
> 
> > On Mon, 4 Feb 2008, Steffen Prohaska wrote:
> > 
> > >  - refactored to lines max 84 chars long.
> > 
> > Why 84?  I think the standard is still 80.
> 
> Because the surrounding code already had lines with more than 80 
> characters and the most natural refactoring without too much wrapping 
> effort resulted in 84.
> 
> Is 80 a strict limit?

It is not a _strict_ limit.  But it is a limit [*1*].  84 is not.

Ciao,
Dscho

*1*: Linux' CodingStyle says/said this:

Statements longer than 80 columns will be broken into sensible chunks. 
Descendants are always substantially shorter than the parent and are 
placed substantially to the right. The same applies to function headers 
with a long argument list. Long strings are as well broken into shorter 
strings. The only exception to this is where exceeding 80 columns 
significantly increases readability and does not hide information.
