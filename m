From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Tue, 28 Apr 2009 00:28:23 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904280027540.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain>
 <7vvdopwxxa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 00:28:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LyZJ8-0007Hg-NT
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 00:28:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757354AbZD0W2M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Apr 2009 18:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756936AbZD0W2L
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Apr 2009 18:28:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:55960 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757247AbZD0W2K (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Apr 2009 18:28:10 -0400
Received: (qmail invoked by alias); 27 Apr 2009 22:28:08 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp060) with SMTP; 28 Apr 2009 00:28:08 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18BIlY7t0EB5gTovu8Ut3OyXL6NnZH+/35KGoP9gN
	8HX6UYQC9DhCTL
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vvdopwxxa.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117722>

Hi,

On Mon, 27 Apr 2009, Junio C Hamano wrote:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
> 
> > Maybe the config option shouldn't be a boolean, but a "how to instantiate 
> > objects". IOW, we could do
> >
> > 	[core]
> > 		createobject = {link|rename}
> >
> > instead. Maybe we some day could allow "inplace", for some totally broken 
> > system that supports neither renames nor links, and just wants the object 
> > to be created with the final name to start with.
> >
> > (Ok, that sounds unlikely, but I mention it because it's an example of the 
> > concept. Maybe somebody likes crazy databases, and would like to have a 
> > "createobject = mysql" for some DB-backed loose object crap).
> >
> > 		Linus
> 
> More likely is "bigtable", I guess ;-)

As I said, this is highly unlikely, as certain people made sure that the 
Google Code people do not like Git.

Ciao,
Dscho
