From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: CVS import [SOLVED]
Date: Mon, 16 Feb 2009 21:59:29 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902162157080.6289@intel-tinevez-2-302>
References: <19651.77.61.241.211.1234775877.squirrel@hupie.xs4all.nl>    <7291.77.61.241.211.1234790434.squirrel@hupie.xs4all.nl> <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Ferry Huberts (Pelagic)" <ferry.huberts@pelagic.nl>
X-From: git-owner@vger.kernel.org Mon Feb 16 22:58:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZBTa-0004DS-O0
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 22:58:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756806AbZBPVzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 16:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756793AbZBPVzo
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 16:55:44 -0500
Received: from mail.gmx.net ([213.165.64.20]:52465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756772AbZBPVzn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 16:55:43 -0500
Received: (qmail invoked by alias); 16 Feb 2009 20:59:31 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp069) with SMTP; 16 Feb 2009 21:59:31 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+lThpHbkmlhkS6q3d6u3u/Kkjs1jDjmhD/fHjjAO
	DV7OgQOgBBkg/O
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <60044.192.168.0.51.1234816333.squirrel@hupie.xs4all.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110252>

Hi,

On Mon, 16 Feb 2009, Ferry Huberts (Pelagic) wrote:

> On Mon, February 16, 2009 14:20, Ferry Huberts (Pelagic) wrote:
> > I solved it:
> >
> > it has to do with the
> > core.autocrlf=input
> > core.safecrlf=true
> >
> > settings I had in my global config.
> > Maybe the manual page should warn against having these defined?
> >
> 
> I'm working on it now, and did some more testing: it's actually the 
> safecrlf setting, not the autocrlf option.

Oh.  That probably means that cvsimport gets confused by the extra 
warnings.

However, I think it is not correct to run cvsimport with autocrlf set to 
anything than false anyway (and safecrlf would not trigger then, right?).

So IMHO the solution is still to force autocrlf off.

Ciao,
Dscho
