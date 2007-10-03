From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 3 Oct 2007 22:39:48 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710032238080.28395@racer.site>
References: <1191390255.16292.2.camel@koto.keithp.com>
 <7vtzp8g2s2.fsf@gitster.siamese.dyndns.org> <87y7ekr86e.wl%cworth@cworth.org>
 <47038669.30302@viscovery.net> <Pine.LNX.4.64.0710031634300.28395@racer.site>
 <87myv0qj2u.wl%cworth@cworth.org> <85ejgcrx6r.fsf@lola.goethe.zz>
 <20071003202157.GA28043@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 23:41:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdBy2-0005fs-JA
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 23:41:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbXJCVlK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 17:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753969AbXJCVlK
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 17:41:10 -0400
Received: from mail.gmx.net ([213.165.64.20]:53032 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753811AbXJCVlJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 17:41:09 -0400
Received: (qmail invoked by alias); 03 Oct 2007 21:41:06 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp043) with SMTP; 03 Oct 2007 23:41:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ulQAreayu6ajhYuRVVbvK8VYMFEGPKnk9PVZE0P
	h6CBISQ7U8EuP6
X-X-Sender: gene099@racer.site
In-Reply-To: <20071003202157.GA28043@coredump.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59892>

Hi,

On Wed, 3 Oct 2007, Jeff King wrote:

> > for i in {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}
> > do
> >   ...
> > done
> 
> $ dash
> $ for i in {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}; do echo $i; done
> {1,2,3,4,5}{0,1,2,3,4,5,6,7,8,9}
> $

AFAIK this is the same as bash (I thought I was the last one to make that 
mistake 10 years ago).  As long as you do not have _files_ matching the 
pattern, it does not expand.  And besides, this is too complicated anyway: 
[1-5] is much shorter than {1,2,3,4,5}.

Ciao,
Dscho
