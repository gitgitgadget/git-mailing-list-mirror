From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add strbuf_initf()
Date: Sun, 29 Jun 2008 14:40:57 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806291436520.9925@racer>
References: <cover.1214581610.git.vmiklos@frugalware.org> <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org> <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org>
 <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org> <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org> <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org>
 <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org> <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org>
 <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org> <7vk5gal3my.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806281832510.9925@racer>
 <7vskuwek9w.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 15:44:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxCQ-0001bC-NJ
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 15:44:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274AbYF2Nm5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 09:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754841AbYF2Nm5
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 09:42:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:37864 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753104AbYF2Nm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 09:42:56 -0400
Received: (qmail invoked by alias); 29 Jun 2008 13:42:54 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp025) with SMTP; 29 Jun 2008 15:42:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/kFXVxVffk4WIDI4dt6s0T3KwYg+UvrneBAGTlZ1
	Pg4zChgtw0QcZr
X-X-Sender: gene099@racer
In-Reply-To: <7vskuwek9w.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86800>

Hi,

On Sun, 29 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Anyway, I'm fine with having them only in my personal fork.
> 
> It will cost you some "trust point" next time you try to sneak something
> in as a part of a largely unrelated topic.  Please don't.

Fine.  Fine!

I thought it made the code more readable, and that it also might have 
helped other sites where you have to strbuf_init() first, and often need 
curly brackets only because of that.  Making for ultra-ugly code.

Please note that I also added a simple test case for the vaddf() function, 
so your "trying to sneak through" is only half as bad as you made it 
sound.

Also, please note that the situation with SNPRINTF_RETURNS_BOGUS works, 
but is a thorn in this developers eye.

Anyway, I will not try to post this patch again,
Dscho
