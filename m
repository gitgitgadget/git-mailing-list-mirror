From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: status of libgit.a
Date: Sun, 7 Mar 2010 17:36:24 +0100 (CET)
Message-ID: <alpine.DEB.1.00.1003071733440.7596@pacific.mpi-cbg.de>
References: <499B3F65.8010109@synapse.com>  <20090218091617.7805.qmail@2684cdd72f0ee9.315fe32.mid.smarden.org>  <499C40EA.6050108@synapse.com>  <20090219092446.23272.qmail@3b5a9fa637f270.315fe32.mid.smarden.org> <1267957655.3759.29.camel@mattotaupa>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1416964788-1267979788=:7596"
Cc: git@vger.kernel.org, Marc Oscar Singer <elf@synapse.com>,
	407722@bugs.debian.org
To: Paul Menzel <pm.debian@googlemail.com>
X-From: git-owner@vger.kernel.org Sun Mar 07 17:29:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NoJMA-000249-MH
	for gcvg-git-2@lo.gmane.org; Sun, 07 Mar 2010 17:29:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751408Ab0CGQ3P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Mar 2010 11:29:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:39990 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750848Ab0CGQ3O (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Mar 2010 11:29:14 -0500
Received: (qmail invoked by alias); 07 Mar 2010 16:29:11 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 07 Mar 2010 17:29:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0IOkuYi301PhrCoOggVRXgNY8grL+Fv7AdRr2GN
	ntPazTFCImBA3A
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1267957655.3759.29.camel@mattotaupa>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59999999999999998
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141716>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1416964788-1267979788=:7596
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Sun, 7 Mar 2010, Paul Menzel wrote:

> Am Donnerstag, den 19.02.2009, 09:24 +0000 schrieb Gerrit Pape:
> > On Wed, Feb 18, 2009 at 09:10:02AM -0800, Marc Oscar Singer wrote:
> > > Gerrit Pape wrote:
> 
> […]
> 
> > > >It depends on upstream.  Back then, Junio asked to not provide such 
> > > >a library package in Debian, and I respect that.  There've been 
> > > >some plans and effort to stabilize the lib in the past, but I'm not 
> > > >sure about the status.
> > > >  
> > > Would it be a compromise to provide libgit.a as a static library for 
> > > until it stabilizes?
> > 
> > That's not the compromise, that's the option, I don't know any plans 
> > about a shared library.  The git-core-dev package that was available 
> > for short included such a static library.
> > 
> > You really need to talk to upstream if you want this libgit.a.
> 
> could you please give an update on the status of libgit.a.

There had been some people who worked towards a re-entrant libgit.a (read: 
non-die()ing in library functions). But there were too many others, so 
that effort stopped.

The most likely route for people needing libgit.a would be libgit2:

http://git.wiki.kernel.org/index.php/SoC2010Ideas#Complete_libgit2

> For example cgit still could not be packaged yet for Debian [1] because 
> of this bug [2].

cgit should not depend on libgit.a, as it is linked statically anyway.

Ciao,
Dscho
--8323328-1416964788-1267979788=:7596--
