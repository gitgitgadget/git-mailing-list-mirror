From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 3/2] parse-options.c: introduce OPT_DATE
Date: Mon, 24 Mar 2008 21:03:04 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803242102140.4353@racer.site>
References: <200803232150.29971.barra_cuda@katamail.com> <alpine.LSU.1.00.0803241409400.4353@racer.site> <200803241502.21465.barra_cuda@katamail.com> <200803241725.42940.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-233973954-1206388985=:4353"
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Michele Ballabio <barra_cuda@katamail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 21:04:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdstW-0006sA-Qi
	for gcvg-git-2@gmane.org; Mon, 24 Mar 2008 21:03:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbYCXUDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2008 16:03:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833AbYCXUDB
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Mar 2008 16:03:01 -0400
Received: from mail.gmx.net ([213.165.64.20]:34276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750772AbYCXUDB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2008 16:03:01 -0400
Received: (qmail invoked by alias); 24 Mar 2008 20:02:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp049) with SMTP; 24 Mar 2008 21:02:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/ONhJb+TLOQphq1iijC7u/2jCwmGNO48FvPp0RAX
	qqKXDuU8wH7heP
X-X-Sender: gene099@racer.site
In-Reply-To: <200803241725.42940.barra_cuda@katamail.com>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78089>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-233973954-1206388985=:4353
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 24 Mar 2008, Michele Ballabio wrote:

> On Monday 24 March 2008, Michele Ballabio wrote:
> > +               OPT_DATE(0, "expire", &expire,
> 
> [...]
> 
> > +#define OPT_DATE(s, l, v, h) \
> 
> Ooops. To be consistent, these should be OPT__DATE (with two 
> underscores) instead (and in the commit message, too).

I thought OPT__BLA was reserved for --bla options?  IOW OPT__DATE would 
not be usable to implement --expire, but only --date.

I might be wrong, though.

Ciao,
Dscho

--8323584-233973954-1206388985=:4353--
