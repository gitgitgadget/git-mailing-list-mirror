From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC] Enable compilation by Makefile for the MSVC toolchain
Date: Tue, 18 Aug 2009 23:35:24 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908182334460.8306@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <1250600335-8642-1-git-send-email-mstormo@gmail.com>  <alpine.DEB.1.00.0908181605370.4680@intel-tinevez-2-302> <3af572ac0908181007q7622091eqc78861e00c3a9e45@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-629157908-1250631325=:8306"
Cc: Marius Storm-Olsen <mstormo@gmail.com>, msysgit@googlegroups.com,
	git@vger.kernel.org, lznuaa@gmail.com, bonzini@gnu.org,
	kusmabite@googlemail.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Tue Aug 18 23:34:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdWKI-0000Pf-64
	for gcvg-git-2@lo.gmane.org; Tue, 18 Aug 2009 23:34:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751286AbZHRVef (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2009 17:34:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751285AbZHRVef
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Aug 2009 17:34:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:43747 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751275AbZHRVee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2009 17:34:34 -0400
Received: (qmail invoked by alias); 18 Aug 2009 21:34:34 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp068) with SMTP; 18 Aug 2009 23:34:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX194L8kH0YB4X46COTGTbTrBPu47/MOENIDG5gMeb1
	N4dV1z8/HuGto4
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908181007q7622091eqc78861e00c3a9e45@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126459>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-629157908-1250631325=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 18 Aug 2009, Pau Garcia i Quiles wrote:

> On Tue, Aug 18, 2009 at 4:11 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
>
> > On Tue, 18 Aug 2009, Marius Storm-Olsen wrote:
> >
> >>  So, instead of rely on these vcproj files which *will* go stale, we 
> >> can  simply use the same Makefile system which everyone else is 
> >> using. :)  After all, we're just compiling with a different compiler. 
> >> The end  result will still rely on the *msysGit environment* to 
> >> function, so we  already require it. Thus, GNU Make is present, and 
> >> we can use it.
> >
> > We can also use sed or perl to generate/modify the .vcproj files, or 
> > run CMake (once Pau got it to build), and package the stuff using zip 
> > (once I got that to build).
> 
> Re: package the stuff using ZIP, it's trivial to do with CPack (part of 
> the CMake chain). Just tell me what you want to get and I'll implement 
> it.

Well, I tried to tell you already what I want.  A simple and unsupervised 
script that downloads, compiles, installs and commits CMake.

Ciao,
Dscho

--8323328-629157908-1250631325=:8306--
