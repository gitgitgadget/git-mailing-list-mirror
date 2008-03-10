From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Write diff output to a file in struct diff_options
Date: Mon, 10 Mar 2008 13:29:39 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803101329200.3975@racer.site>
References: <alpine.LNX.1.00.0803092235150.19665@iabervon.org> <fr37ec$9k4$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-265362176-1205152180=:3975"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 13:30:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYh8x-0002ev-FA
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 13:30:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750900AbYCJM3g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 08:29:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750931AbYCJM3g
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 08:29:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:51089 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750850AbYCJM3g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 08:29:36 -0400
Received: (qmail invoked by alias); 10 Mar 2008 12:29:33 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp055) with SMTP; 10 Mar 2008 13:29:33 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/OWDsUMKvO1Bt4yEt1QB/Lx432hiXoDIERXI1GTX
	f1T2rvEZb6J7Gm
X-X-Sender: gene099@racer.site
In-Reply-To: <fr37ec$9k4$1@ger.gmane.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76723>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-265362176-1205152180=:3975
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 10 Mar 2008, Jakub Narebski wrote:

> Daniel Barkalow wrote:
> 
> > I remember there being some expectation that this would be difficult, but 
> > it was a pretty straightforward conversion, so I'm wondering if I've 
> > missed something. In any case, this is missing tests and documentation for 
> > --output=, but I really want it to use directly for rebase-interactive, 
> > and I only did the command line option so I could do informal testing.
> > 
> >  diff.c |  306 +++++++++++++++++++++++++++++++++++-----------------------------
> >  diff.h |    3 +
> >  2 files changed, 169 insertions(+), 140 deletions(-)
> 
> Errr... where is the documentation?

There is no user for that feature yet, so where exactly should it be 
documented?

Ciao,
Dscho

--8323584-265362176-1205152180=:3975--
