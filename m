From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Tue, 28 Apr 2009 10:23:08 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904281022070.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain> <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
 <7vws95vete.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 10:23:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyiam-0007k7-IF
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 10:23:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932104AbZD1IW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 04:22:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759794AbZD1IW4
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 04:22:56 -0400
Received: from mail.gmx.net ([213.165.64.20]:56684 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759661AbZD1IWz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 04:22:55 -0400
Received: (qmail invoked by alias); 28 Apr 2009 08:22:53 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 28 Apr 2009 10:22:53 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18SGXY4IPwS3d8VD0mfCAjb8eL3C1AQTtR5fvmBWA
	tcZgOLIQuUGfyL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vws95vete.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117754>

Hi,

On Mon, 27 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > diff --git a/Makefile b/Makefile
> > index 5c8e83a..9ca1826 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -172,8 +172,8 @@ all::
> >  # information on a not yet closed file that lstat would return for the same
> >  # file after it was closed.
> >  #
> > -# Define UNRELIABLE_HARDLINKS if your operating systems has problems when
> > -# hardlinking a file to another name and unlinking the original file right
> > +# Define OBJECT_CREATION_USES_RENAMES if your operating systems has problems
> > +# when hardlinking a file to another name and unlinking the original file right
> 
> With the configuration variable for this relatively obscure feature in 
> place, I wonder if we can simply get rid of the hardcoded compilation 
> preference.

I'd rather not, for Windows.  Remember, it fixes issues 222 and 229.  And 
from the comments in those issues I understand that more than 2 persons 
had problems due to these issues.

Ciao,
Dscho
