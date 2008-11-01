From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file modification
 time
Date: Sat, 1 Nov 2008 01:23:32 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811010121570.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain> <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081031233736.GB21997@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 01:17:28 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kw4BD-0004nF-B4
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 01:17:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbYKAAQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 20:16:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750695AbYKAAQP
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 20:16:15 -0400
Received: from mail.gmx.net ([213.165.64.20]:57747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750756AbYKAAQO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 20:16:14 -0400
Received: (qmail invoked by alias); 01 Nov 2008 00:16:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp014) with SMTP; 01 Nov 2008 01:16:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+021BqZja0W9lTy7tcemjHatMwUEbT0ywIhlQ4gu
	fcO50q6oDtjnZC
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081031233736.GB21997@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99688>

Hi,

On Sat, 1 Nov 2008, Alex Riesen wrote:

> Johannes Schindelin, Fri, Oct 31, 2008 23:14:59 +0100:
> 
> > On Fri, 31 Oct 2008, Alex Riesen wrote:
> > 
> > > ActiveState Perl on Windows is portable? To another windows, maybe.
> > 
> > /me wonders why you could not use the Perl that ships with Git for 
> > Windows, at least for the purposes of Git.
> 
> Corporate policy and very-very incompetent IT service. Besides being 
> illegal to install actually usable software, there are some of internal 
> programs which are quite sensitive to perl (any other perl) appearing 
> anywhere on disk, not to mention PATH (the build system, for one). Same 
> for cygwin revisions.
> 
> I tried using other perl and more modern cygwin, and it can be made to 
> work, but it is cumbersome and boring. And one more thing to reinstall 
> after IT wipes your computer because you've got a new disk or they 
> decided you need winxp instead of w2k, or something else... So I'm just 
> trying reduce effort I put into what I'm not supposed to do at work 
> anyway.

Well, if you install Git for Windows (as opposed to cygwin), it is minimum 
hassle, and Perl is delivered right with it.

Ciao,
Dscho

P.S.: some guys at the GSoC mentor summit convinced me in at least trying 
to fix _their_ problems on msysGit, so chances are good I'll fix issues 
you would encounter in the same run.
