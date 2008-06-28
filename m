From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 11/15] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add strbuf_initf()
Date: Sat, 28 Jun 2008 18:33:49 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806281832510.9925@racer>
References: <cover.1214581610.git.vmiklos@frugalware.org> <4a9a3a34d8c42b60f002acb20083cb9e187c262f.1214581610.git.vmiklos@frugalware.org> <876e733753999f116bfd975d9a262a5c1b3855a1.1214581610.git.vmiklos@frugalware.org>
 <99b931de28ab3017269d15c334c83e242d025489.1214581610.git.vmiklos@frugalware.org> <5c33ca94d6edb203bd2fbbb949f834b3771470ed.1214581610.git.vmiklos@frugalware.org> <25a8ffde9783638080d2b998d8f2579e6ed6c8e7.1214581610.git.vmiklos@frugalware.org>
 <715117f89992568500bd26b1a4e1357c0a570c4a.1214581610.git.vmiklos@frugalware.org> <d600b25cb1d8f3b6bce12b2a479d4b68b1935dfd.1214581610.git.vmiklos@frugalware.org> <a01223ac1d530522b383fc3e9590ac1a2a5d66ed.1214581610.git.vmiklos@frugalware.org>
 <67035c91a933887c7cc97fa6d3dda9462594d611.1214581610.git.vmiklos@frugalware.org> <cover.1214581610.git.vmiklos@frugalware.org> <7ea320cd49601de0e331777f82528876101fd946.1214581610.git.vmiklos@frugalware.org> <7vk5gal3my.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 28 19:36:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCeLs-0001DJ-Np
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 19:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753057AbYF1Rfs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 Jun 2008 13:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753213AbYF1Rfs
	(ORCPT <rfc822;git-outgoing>); Sat, 28 Jun 2008 13:35:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:59212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753023AbYF1Rfr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 Jun 2008 13:35:47 -0400
Received: (qmail invoked by alias); 28 Jun 2008 17:35:45 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp011) with SMTP; 28 Jun 2008 19:35:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+dk9oBxOGda8FDwvRMHXe2JdocKjvpA4YtZZw1jb
	erO72JqwdUXPJm
X-X-Sender: gene099@racer
In-Reply-To: <7vk5gal3my.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86734>

Hi,

On Fri, 27 Jun 2008, Junio C Hamano wrote:

> Do you really think these two patches belong to the series, I seriously 
> have to wonder?

Heh.  I suggested it, as I thought this was a perfect excuse to introduce 
strbuf_initf(), which has been on my wishlist since long.

Anyway, I'm fine with having them only in my personal fork.

Ciao,
Dscho
