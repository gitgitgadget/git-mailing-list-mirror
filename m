From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add the diff option --no-defaults
Date: Thu, 16 Apr 2009 11:25:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904161124000.10279@pacific.mpi-cbg.de>
References: <20090320194930.GB26934@coredump.intra.peff.net> <1237600853-22815-1-git-send-email-keith@cs.ucla.edu> <alpine.DEB.1.00.0903210415110.10279@pacific.mpi-cbg.de> <alpine.GSO.2.00.0904021647120.16242@kiwi.cs.ucla.edu> <alpine.DEB.1.00.0904091030030.10279@pacific.mpi-cbg.de>
 <20090409084903.GA18947@coredump.intra.peff.net> <alpine.DEB.1.00.0904091242430.10279@pacific.mpi-cbg.de> <20090410080155.GB32195@coredump.intra.peff.net> <alpine.DEB.1.00.0904140036341.10279@pacific.mpi-cbg.de>
 <20090416083443.GA27399@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Keith Cascio <keith@CS.UCLA.EDU>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 11:24:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LuNp9-0005fO-Vx
	for gcvg-git-2@gmane.org; Thu, 16 Apr 2009 11:24:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328AbZDPJWV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2009 05:22:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753132AbZDPJWV
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Apr 2009 05:22:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:48974 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753041AbZDPJWU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2009 05:22:20 -0400
Received: (qmail invoked by alias); 16 Apr 2009 09:22:18 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp055) with SMTP; 16 Apr 2009 11:22:18 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+oVBRWsWaoAPaSesObZBrSByOGJ6q8+aIc+wZkJL
	vNFginjT5hp9F4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090416083443.GA27399@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116688>

Hi,

On Thu, 16 Apr 2009, Jeff King wrote:

> On Tue, Apr 14, 2009 at 12:37:42AM +0200, Johannes Schindelin wrote:
> 
> > >   1. You could loosen (1) above by assuming that --no-defaults will
> > >      never appears as the argument to an option, and therefore any time
> > >      you find it, it should be respected. Thus your first parse is just
> > >      a simple loop looking for the option.
> > 
> > I go with 1)
> 
> This feels very hack-ish to me, but perhaps this is a case of "perfect
> is the enemy of the good".

I have a strong feeling that none of our diff/rev options can sanely take 
a parameter looking like "--defaults" or "--no-defaults".

But I do not have the time to audit the options.  Maybe you have?

Ciao,
Dscho
