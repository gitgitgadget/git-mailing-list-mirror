From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 10/11] Add MSVC Project file
Date: Mon, 17 Aug 2009 23:05:37 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172304200.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <1250525103-5184-5-git-send-email-lznuaa@gmail.com>
  <4A899495.8050902@gnu.org>  <40aa078e0908171040g5718a809o88b093fe5a4a0e28@mail.gmail.com>  <alpine.DEB.1.00.0908172149480.8306@pacific.mpi-cbg.de>  <3af572ac0908171317s3ef1506fpb3df11916f8a6ee9@mail.gmail.com>  <3f4fd2640908171343s6e2796a8le0455e02fd8386d9@mail.gmail.com>
 <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-182758008-1250543138=:8306"
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Erik Faye-Lund <kusmabite@googlemail.com>,
	Paolo Bonzini <bonzini@gnu.org>, Frank Li <lznuaa@gmail.com>,
	git@vger.kernel.org, msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 23:05:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9Ny-0002bE-SR
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 23:04:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758089AbZHQVEu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 17:04:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754559AbZHQVEt
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 17:04:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:36533 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751631AbZHQVEt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 17:04:49 -0400
Received: (qmail invoked by alias); 17 Aug 2009 21:04:49 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 17 Aug 2009 23:04:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX193zu8FRBd3rmrJSNdMH0Vu7DDJViH5vCk9vyytrm
	Bt69WzK0wceRm1
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908171354i6dd231etb576859ab8941214@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126284>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-182758008-1250543138=:8306
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:

> On Mon, Aug 17, 2009 at 10:43 PM, Reece Dunn<msclrhd@googlemail.com> wrote:
> > 2009/8/17 Pau Garcia i Quiles <pgquiles@elpauer.org>:
> >> On Mon, Aug 17, 2009 at 9:53 PM, Johannes
> >> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> >>
> >>> Of course, we could have a script that verifies that the .vcproj 
> >>> files contain reference the appropriate files (which it would know 
> >>> about by being called from the Makefile and being passed the file 
> >>> names), maybe even be able to edit the .vcproj file if it is missing 
> >>> some.  Should not be too hard in Perl.
> >>
> >> You'll need to special-case for Visual C++ 2010, which is different 
> >> and incompatible with previous versions. Hence my suggestion for 
> >> CMake: appropriate project files would be generated for the tool the 
> >> user chooses, be it VC++ 2005, VC++2010, gcc, Borland C++ or anything 
> >> else.
> >
> > The problem is that you'd still need the Visual Studio projects (one 
> > each for 6, 7 (2002), 7.1 (2003), 8 (2005), 9 (2008) and 10 (2010) -- 
> > yes, there'll need to be one for each version of Visual Studio) as 
> > people who use Visual Studio tend to primarily use the IDE. CMake 
> > (which Windows users will need to download & install from somewhere) 
> > will sit outside this -- unless you mean making the project files be 
> > the "Makefile project" type and simply use it to invoke CMake and host 
> > the source files to ease access to them from the IDE?
> 
> If a CMake build system is provided, you will not need a single Visual 
> Studio project, or the autotools build system, or anything else. Just 
> CMake and the CMake build system (which are a bunch of CMakeLists.txt 
> plain text files).

You are putting an undue burden on the already overloaded maintainer.

Well, let's see if you can provide a /src/cmake/release.sh that compiles 
CMake from scratch, and _then_ I'll look into CMake again.

Ciao,
Dscho

--8323328-182758008-1250543138=:8306--
