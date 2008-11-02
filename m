From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Use find instead of perl in t5000 to get file
	modification time
Date: Sun, 2 Nov 2008 15:37:52 +0100
Message-ID: <20081102143751.GA18140@blimp.localdomain>
References: <81b0412b0810290338j1beaa25bx9fb373a69f5dfe7@mail.gmail.com> <1225344554.10803.17.camel@maia.lan> <20081031070003.GA4458@blimp.localdomain> <alpine.DEB.1.00.0810312314190.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081031233736.GB21997@steel.home> <alpine.DEB.1.00.0811010121570.22125@pacific.mpi-cbg.de.mpi-cbg.de> <20081101142434.GA7157@steel.home> <alpine.DEB.1.00.0811012134290.22125@pacific.mpi-cbg.de.mpi-cbg.de>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?iso-8859-15?Q?Ren=E9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Nov 02 15:42:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kwe9Y-0002KY-FH
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 15:42:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753441AbYKBOiL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 09:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753425AbYKBOiK
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 09:38:10 -0500
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:39524 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753385AbYKBOiI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 09:38:08 -0500
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :Pm0FVUW6aauhRGJJc5OfA4AU8DM8ZlijdmJYxKn/UQvEQQx8AU81pIV0
Received: from tigra.home (Faa73.f.strato-dslnet.de [195.4.170.115])
	by post.webmailer.de (fruni mo27) (RZmta 17.14)
	with ESMTP id k00248kA2CiOlV ; Sun, 2 Nov 2008 15:37:54 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp.localdomain (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id BE240277C8;
	Sun,  2 Nov 2008 15:37:53 +0100 (CET)
Received: by blimp.localdomain (Postfix, from userid 1000)
	id 380C536D27; Sun,  2 Nov 2008 15:37:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0811012134290.22125@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99846>

Johannes Schindelin, Sat, Nov 01, 2008 21:37:14 +0100:
> On Sat, 1 Nov 2008, Alex Riesen wrote:
> > Johannes Schindelin, Sat, Nov 01, 2008 01:23:32 +0100:
> > > 
> > > Well, if you install Git for Windows (as opposed to cygwin), it is 
> > > minimum hassle, and Perl is delivered right with it.
> > 
> > I'd like to try it again, but weren't ther some fatal problems with 
> > cygwin1.dll being in PATH? I always work either in Cygwin's bash or just 
> > have to have it in PATH, because of the build environment even being 
> > strictly Windows based (case-insensitive and alike) just have to use 
> > sane tooling in its scripts.
> 
> I was talking about Git for Windows, i.e. the result of msysGit (as 
> opposed to Git in Cygwin).
> 
> So no, there have not been any conflicts with cygwin1.dll in the PATH, as 
> far as I can recall.  There have been problems with shell utilities being 
> found in the Cygwin PATH before being found in the MSys PATH, but I 
> thought we just prepended the MSys PATH to avoid that.  Haven't checked, 
> though.

Ok, I'll give it a try.

> > > P.S.: some guys at the GSoC mentor summit convinced me in at least 
> > > trying to fix _their_ problems on msysGit, so chances are good I'll 
> > > fix issues you would encounter in the same run.
> > 
> > Do you still plan to distribute MinGW with it? It's very nice to be able 
> > to track Junio's repo, have own branches and rebuild Git from time to 
> > time. For me, at least.
> 
> You mean to distribute a minimal MSys environment where you have bash?  
> Yes, we have to do that, as there are still too many important parts of 
> Git written in Shell.

No, the mingw compiler and libraries. I vaguely remember some talking
about including the build environment into Git distribution.
