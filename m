From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file modification
 time
Date: Sun, 2 Nov 2008 17:05:47 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811021704280.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain> <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081031233736.GB21997@steel.home>
 <alpine.DEB.1.00.0811010121570.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081101142434.GA7157@steel.home> <alpine.DEB.1.00.0811012134290.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081102143751.GA18140@blimp.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 16:59:47 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwfMc-00086i-2y
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 16:59:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753612AbYKBP61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 10:58:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753615AbYKBP61
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 10:58:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:45406 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753610AbYKBP60 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 10:58:26 -0500
Received: (qmail invoked by alias); 02 Nov 2008 15:58:23 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 02 Nov 2008 16:58:23 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19IiogqyqdIlhHPzu/THrEDRrNOPMbts0WHzgaNKD
	85ai+JOnyQ3Z+N
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081102143751.GA18140@blimp.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99848>

Hi,

On Sun, 2 Nov 2008, Alex Riesen wrote:

> Johannes Schindelin, Sat, Nov 01, 2008 21:37:14 +0100:
> > On Sat, 1 Nov 2008, Alex Riesen wrote:
> > > Johannes Schindelin, Sat, Nov 01, 2008 01:23:32 +0100:
> > > > 
> > > > P.S.: some guys at the GSoC mentor summit convinced me in at least 
> > > > trying to fix _their_ problems on msysGit, so chances are good 
> > > > I'll fix issues you would encounter in the same run.
> > > 
> > > Do you still plan to distribute MinGW with it? It's very nice to be 
> > > able to track Junio's repo, have own branches and rebuild Git from 
> > > time to time. For me, at least.
> > 
> > You mean to distribute a minimal MSys environment where you have bash?  
> > Yes, we have to do that, as there are still too many important parts 
> > of Git written in Shell.
> 
> No, the mingw compiler and libraries. I vaguely remember some talking 
> about including the build environment into Git distribution.

We do that already for a long time.  Basically, we have two distributions: 
Git for Windows (for the end user) and msysGit (for the developer wanting 
to work _on_ Git).  Actually, msysGit was there first.

Hth,
Dscho
