From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Buffer overflows
Date: Fri, 31 Aug 2007 11:06:01 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708311104200.28586@racer.site>
References: <1188502009.29782.874.camel@hurina> 
 <alpine.LFD.0.999.0708301340470.25853@woody.linux-foundation.org> 
 <7D84F3C7-129D-4197-AAF1-46298E5D0136@iki.fi> 
 <alpine.LFD.0.999.0708302050170.25853@woody.linux-foundation.org>
 <1188536430.29782.903.camel@hurina>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: Timo Sirainen <tss@iki.fi>
X-From: git-owner@vger.kernel.org Fri Aug 31 12:06:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IR3OI-0001hc-2A
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 12:06:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756740AbXHaKGK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 06:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756643AbXHaKGJ
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 06:06:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:59165 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756602AbXHaKGI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 06:06:08 -0400
Received: (qmail invoked by alias); 31 Aug 2007 10:06:07 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp032) with SMTP; 31 Aug 2007 12:06:07 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19pB85Tej5pGzWaXWlxc9lQ/WWCZoMcd52jSKMU/h
	Ghe5M7iX0719o9
X-X-Sender: gene099@racer.site
In-Reply-To: <1188536430.29782.903.camel@hurina>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57146>

Hi,

On Fri, 31 Aug 2007, Timo Sirainen wrote:

> On Thu, 2007-08-30 at 21:09 -0700, Linus Torvalds wrote:
> 
> > So yes, I bet there are faster string libraries out there.
> 
> Oh, well that's easy to fix. But I don't think the speed matters much in 
> string manipulation, it's usually not done in performance critical 
> paths.

AFAIR one of the recent performance studies showed strlen() as one of the 
_biggest_ offenders.  So no, your point has been disproven _already_.

I have to wonder, though, why you do not just go and enhance strbuf.[ch], 
which is nice and easy, and not the least unelegant.

Ciao,
Dscho
