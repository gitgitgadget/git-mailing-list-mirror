From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CMake, was Re: [PATCH 09/11] Add MSVC porting header files.
Date: Mon, 17 Aug 2009 22:58:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908172256560.8306@pacific.mpi-cbg.de>
References: <1250525103-5184-1-git-send-email-lznuaa@gmail.com>  <1250525103-5184-2-git-send-email-lznuaa@gmail.com>  <1250525103-5184-3-git-send-email-lznuaa@gmail.com>  <1250525103-5184-4-git-send-email-lznuaa@gmail.com>  <alpine.DEB.1.00.0908171902300.4991@intel-tinevez-2-302>
  <3af572ac0908171231n30864c85ud67454a03ca08fbe@mail.gmail.com>  <alpine.DEB.1.00.0908172147240.8306@pacific.mpi-cbg.de> <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1752746963-1250542673=:8306"
Cc: Frank Li <lznuaa@gmail.com>, git@vger.kernel.org,
	msysgit@googlegroups.com
To: Pau Garcia i Quiles <pgquiles@elpauer.org>
X-From: git-owner@vger.kernel.org Mon Aug 17 22:57:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Md9Gk-0007bR-KE
	for gcvg-git-2@lo.gmane.org; Mon, 17 Aug 2009 22:57:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754850AbZHQU5W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Aug 2009 16:57:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754518AbZHQU5V
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Aug 2009 16:57:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:57402 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753692AbZHQU5V (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Aug 2009 16:57:21 -0400
Received: (qmail invoked by alias); 17 Aug 2009 20:57:21 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp011) with SMTP; 17 Aug 2009 22:57:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19sll1VhNps0hl7bOmBpr9vLajgdeLd06YKGmjzj9
	qqWA+KZ8so/voi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <3af572ac0908171251y355a1e2bjf2d10192bc3eca2e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
Content-ID: <alpine.DEB.1.00.0908172258050.8306@pacific.mpi-cbg.de>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126280>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1752746963-1250542673=:8306
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.DEB.1.00.0908172258051.8306@pacific.mpi-cbg.de>

Hi,

On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:

> On Mon, Aug 17, 2009 at 9:48 PM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> 
> > On Mon, 17 Aug 2009, Pau Garcia i Quiles wrote:
> >
> >> What about having a CMake build system, which would work on every
> >> platform (including cross-compiling), and would produce an appropriate
> >> config.h and makefiles/vcproj/Eclipse projects/XCode projects/whatever
> >> is fit for each platform? If it's OK to include such a build system
> >> upstream, I'm volunteering to implement it.
> >
> > And reap in another dependency?
> >
> > First Python, then CMake, what tomorrow?  Is it the month of adding
> > dependencies?
> 
> I'd say it's the month of getting problems solved.

What?  I beg your _pardon_?

> CMake would make git a lot easier to build on Windows, particularly with 
> Visual C++. Replace autotools with CMake and suddenly you need to 
> maintain a single build system for every platform and compiler git 
> supports/will support. That's a sound advantage to me.

Well, I heard some pretty different opinions, and they are from quite 
recently.

In any case, before you get CMake to compile in msysGit, I think we do not 
need to talk about getting problems solved.

Ciao,
Dscho
--8323328-1752746963-1250542673=:8306--
