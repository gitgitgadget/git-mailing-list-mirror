From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH next] git-notes: fix printing of multi-line notes
Date: Wed, 14 Jan 2009 11:14:06 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901141113250.3586@pacific.mpi-cbg.de>
References: <496CF21C.2050500@trolltech.com> <alpine.DEB.1.00.0901132339270.3586@pacific.mpi-cbg.de> <7v3afm758u.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-2022730797-1231928047=:3586"
Cc: =?ISO-8859-15?Q?Tor_Arne_Vestb=F8?= <tavestbo@trolltech.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 11:14:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN2ll-0006rd-En
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 11:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753240AbZANKNS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 05:13:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753170AbZANKNS
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 05:13:18 -0500
Received: from mail.gmx.net ([213.165.64.20]:56491 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751531AbZANKNR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 05:13:17 -0500
Received: (qmail invoked by alias); 14 Jan 2009 10:13:15 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp035) with SMTP; 14 Jan 2009 11:13:15 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18JIPIjFoIJ1G586rMX6e56txUDPZ2FSQNZA8isgA
	9MYTKFQTw/a8Su
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v3afm758u.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105609>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2022730797-1231928047=:3586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Tue, 13 Jan 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Tue, 13 Jan 2009, Tor Arne Vestbø wrote:
> >
> >> The line length was read from the same position every time,
> >> causing mangled output when printing notes with multiple lines.
> >> 
> >> Also, adding new-line manually for each line ensures that we
> >> get a new-line between commits, matching git-log for commits
> >> without notes.
> >> 
> >> Signed-off-by: Tor Arne Vestbø <tavestbo@trolltech.com>
> >> ---
> >
> > Patch looks good, so 
> >
> > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > For extra browny points, you could add a test with multi-line notes.
> 
> Yeah, not just "extra", having tests is a good way to make sure a new
> feature like this evolves healthily.

Oh, and of course I meant "brownie"...

Ducks,
Dscho

--8323328-2022730797-1231928047=:3586--
