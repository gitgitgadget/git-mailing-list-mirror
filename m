From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 01/15] Move split_cmdline() to alias.c
Date: Sun, 29 Jun 2008 15:15:39 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806291513450.9925@racer>
References: <cover.1214581610.git.vmiklos@frugalware.org> <58b2c36de6a6f51a562da303695482bea567f4bf.1214581610.git.vmiklos@frugalware.org> <486796C3.7040304@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1661603181-1214748941=:9925"
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Olivier Marin <dkr@freesurf.fr>
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Sun Jun 29 16:18:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCxjg-000384-Fc
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 16:18:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759166AbYF2ORj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 10:17:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759708AbYF2ORj
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 10:17:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:36270 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759106AbYF2ORj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 10:17:39 -0400
Received: (qmail invoked by alias); 29 Jun 2008 14:17:36 -0000
Received: from 87.113.36.200.plusnet.pte-ag1.dyn.plus.net (EHLO racer.local) [87.113.36.200]
  by mail.gmx.net (mp020) with SMTP; 29 Jun 2008 16:17:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX199xB5eX6994Kzcly5fX3nSkEBAMg/hrHX0VhdCHT
	6H6MXPTKRVewkL
X-X-Sender: gene099@racer
In-Reply-To: <486796C3.7040304@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86805>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1661603181-1214748941=:9925
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 29 Jun 2008, Olivier Marin wrote:

> Miklos Vajna a écrit :
> > split_cmdline() is currently used for aliases only, but later it can be
> > useful for other builtins as well. Move it to alias.c for now,
> > indicating that originally it's for aliases, but we'll have it in libgit
> > this way.
> 
> This function does not trim cmdline. 

As the string comes either from the config (where it is trimmed), or from 
the command line (where the user can be stup^W^Wask for whitespace 
explicitely),  I do not see much merit in this patch.

Unless you can provide an example where it fails, of course,
Dscho
--8323329-1661603181-1214748941=:9925--
