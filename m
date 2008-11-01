From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file modification
 time
Date: Sat, 1 Nov 2008 21:37:14 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0811012134290.22125@pacific.mpi-cbg.de.mpi-cbg.de>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain> <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081031233736.GB21997@steel.home>
 <alpine.DEB.1.00.0811010121570.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081101142434.GA7157@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 01 21:31:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwN7k-0007ad-09
	for gcvg-git-2@gmane.org; Sat, 01 Nov 2008 21:31:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752591AbYKAU3z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Nov 2008 16:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752541AbYKAU3z
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Nov 2008 16:29:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:46866 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752586AbYKAU3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Nov 2008 16:29:54 -0400
Received: (qmail invoked by alias); 01 Nov 2008 20:29:52 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp062) with SMTP; 01 Nov 2008 21:29:52 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ETn9UH0GEklPUU3IGDOT7Cxo6Te0D5kYIhjzmiz
	miVuKO3STpOqb0
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20081101142434.GA7157@steel.home>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99774>

Hi,

On Sat, 1 Nov 2008, Alex Riesen wrote:

> Johannes Schindelin, Sat, Nov 01, 2008 01:23:32 +0100:
> > 
> > Well, if you install Git for Windows (as opposed to cygwin), it is 
> > minimum hassle, and Perl is delivered right with it.
> 
> I'd like to try it again, but weren't ther some fatal problems with 
> cygwin1.dll being in PATH? I always work either in Cygwin's bash or just 
> have to have it in PATH, because of the build environment even being 
> strictly Windows based (case-insensitive and alike) just have to use 
> sane tooling in its scripts.

I was talking about Git for Windows, i.e. the result of msysGit (as 
opposed to Git in Cygwin).

So no, there have not been any conflicts with cygwin1.dll in the PATH, as 
far as I can recall.  There have been problems with shell utilities being 
found in the Cygwin PATH before being found in the MSys PATH, but I 
thought we just prepended the MSys PATH to avoid that.  Haven't checked, 
though.

> > P.S.: some guys at the GSoC mentor summit convinced me in at least 
> > trying to fix _their_ problems on msysGit, so chances are good I'll 
> > fix issues you would encounter in the same run.
> 
> Do you still plan to distribute MinGW with it? It's very nice to be able 
> to track Junio's repo, have own branches and rebuild Git from time to 
> time. For me, at least.

You mean to distribute a minimal MSys environment where you have bash?  
Yes, we have to do that, as there are still too many important parts of 
Git written in Shell.

Ciao,
Dscho
