From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Add Gitweb support for LZMA compressed snapshots
Date: Sat, 1 Aug 2009 14:34:02 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0908011431060.8306@pacific.mpi-cbg.de>
References: <E0C39B59-E2C5-4C28-9570-D33FEA2A44EB@uwaterloo.ca>  <m3r5vy1siq.fsf@localhost.localdomain>  <alpine.DEB.1.00.0907301042300.7467@intel-tinevez-2-302> <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-822640726-1249130042=:8306"
Cc: Jakub Narebski <jnareb@gmail.com>,
	Mark A Rada <marada@uwaterloo.ca>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 01 14:33:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXDmc-0000JV-Hi
	for gcvg-git-2@gmane.org; Sat, 01 Aug 2009 14:33:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751487AbZHAMdq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Aug 2009 08:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751398AbZHAMdq
	(ORCPT <rfc822;git-outgoing>); Sat, 1 Aug 2009 08:33:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:40668 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751367AbZHAMdp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Aug 2009 08:33:45 -0400
Received: (qmail invoked by alias); 01 Aug 2009 12:33:44 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp016) with SMTP; 01 Aug 2009 14:33:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX197qL1uJ9J7FIR1DGMeuQDVgrv3tAA1W20csJTqSR
	VjVT7ZljBGTeyx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <94a0d4530907310845k51dbafbfy8e240467113dfc16@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124618>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-822640726-1249130042=:8306
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 31 Jul 2009, Felipe Contreras wrote:

> On Thu, Jul 30, 2009 at 8:43 AM, Johannes
> Schindelin<Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Thu, 30 Jul 2009, Jakub Narebski wrote:
> >
> >> BTW. I wonder if it would be good idea to add support for this format
> >> directly to git-archive...  OTOH it would mean additional dependency.
> >
> > I don't think it would be a good idea; we do not have bzip2 support
> > either.
> 
> bzip2 has no advantages whatsoever.

Bzzzzt.  Wrong.  Just because you cannot see them does not mean it has no 
advantages.

> AFAIK xz is superior to other formats and it would be nice to see git 
> make a technological stance encouraging xz.

Bzzzt. Wrong again.  Git's mission in life is not to encourage one 
compression over another.

If at all, the only compression Git actually does promote in a sense is 
zlib compression.

> > The only reason we have inbuilt gzip and zip support is because the 
> > format is so similar to Git's own compression.
> 
> Personally I don't see the point of having zip support.

Personally, I see the point of having zip support.  It makes things easy 
for Windows users.  And it's an established format, much more so than 
tar.gz.

Ciao,
Dscho

--8323328-822640726-1249130042=:8306--
