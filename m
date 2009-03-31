From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Implementing stat() with FindFirstFile()
Date: Tue, 31 Mar 2009 22:49:48 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0903312249190.6616@intel-tinevez-2-302>
References: <200903212055.15026.j6t@kdbg.org> <20090324215416.GB27249@jeeves.jpl.local> <49CB2BA5.1070100@viscovery.net> <20090326213907.GC27249@jeeves.jpl.local> <alpine.DEB.1.00.0903270320020.10279@pacific.mpi-cbg.de> <20090329224803.GD27249@jeeves.jpl.local>
 <alpine.DEB.1.00.0903300245080.6454@intel-tinevez-2-302> <20090330051118.GA2681@atjola.homenet> <20090330220709.GA68118@macbook.lan> <alpine.DEB.1.00.0903310128410.10279@pacific.mpi-cbg.de> <20090331203248.GE27249@jeeves.jpl.local>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1590473202-1238532589=:6616"
Cc: Heiko Voigt <hvoigt@hvoigt.net>,
	=?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Magnus_B=E4ck?= <baeck@swipnet.se>
X-From: git-owner@vger.kernel.org Tue Mar 31 22:51:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lokvg-0000th-LJ
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 22:51:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755182AbZCaUty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 16:49:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752841AbZCaUtx
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 16:49:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:55411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751246AbZCaUtx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 16:49:53 -0400
Received: (qmail invoked by alias); 31 Mar 2009 20:49:49 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 31 Mar 2009 22:49:49 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/9VF1IcBD9YLBp00mxAtQS6nWF1EvA1rOT7ZHhP6
	JSPnCVJ+KufDl7
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <20090331203248.GE27249@jeeves.jpl.local>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115316>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1590473202-1238532589=:6616
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 31 Mar 2009, Magnus Bäck wrote:

> On Tuesday, March 31, 2009 at 01:29 CEST,
>      Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 31 Mar 2009, Heiko Voigt wrote:
> > 
> > > On Mon, Mar 30, 2009 at 07:11:18AM +0200, Björn Steinbrink wrote:
> > >
> > > > Not official documentation, but at least from some MS guy it seems: 
> > > > http://www.osronline.com/showThread.cfm?link=73086 (last message).
> > > > 
> > > > Apparently, it was in NT3.x, but they document only what's actually 
> > > > defined in the header.
> > > 
> > > How about runtime checking? You could do GetProcAddress(...) and if
> > > you don't get it use the old behaviour. I mean if it really is
> > > faster why not let Users of recent systems benefit from it.
> > 
> > While my first reaction was negative, I have to admit that thinking
> > about it longer, it does seem to make a whole lot of sense.
> 
> If anything worries me it's forward compatibility should Microsoft
> change the function signature. Backwards compatibility can always
> be guaranteed by using GetProcAddress(). Again, I would be very
> surprised but IF it could be quite fatal.
> 
> Anyway, we don't know for sure if it's faster or if it fixes the DST
> problem of FindFirstFile(). I'll write some code to try it out.

Thank you very much, I appreciate it!

Ciao,
Dscho

--8323329-1590473202-1238532589=:6616--
