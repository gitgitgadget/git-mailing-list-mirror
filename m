From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Rename core.unreliableHardlinks to core.createObject
Date: Tue, 28 Apr 2009 16:50:01 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904281647350.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
 <alpine.DEB.1.00.0904271400180.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904270806130.22156@localhost.localdomain> <7vljpl3m8i.fsf@gitster.siamese.dyndns.org> <alpine.LFD.2.00.0904271314130.22156@localhost.localdomain> <alpine.DEB.1.00.0904280031100.10279@pacific.mpi-cbg.de>
 <7vws95vete.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0904281022070.10279@pacific.mpi-cbg.de> <7v1vrdqi9i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 28 16:50:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lyodb-0008Sp-KP
	for gcvg-git-2@gmane.org; Tue, 28 Apr 2009 16:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755000AbZD1Ots (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Apr 2009 10:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754793AbZD1Ots
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Apr 2009 10:49:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:50420 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752998AbZD1Otr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Apr 2009 10:49:47 -0400
Received: (qmail invoked by alias); 28 Apr 2009 14:49:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 28 Apr 2009 16:49:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lPWRFvGflZQC+ISdfq+leipkKB/+y13Da5Pqc02
	6/RUg5ITnKiIk8
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7v1vrdqi9i.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.61
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117776>

Hi,

On Tue, 28 Apr 2009, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> With the configuration variable for this relatively obscure feature 
> >> in place, I wonder if we can simply get rid of the hardcoded 
> >> compilation preference.
> >
> > I'd rather not, for Windows.  Remember, it fixes issues 222 and 229.
> 
> Wait a bit. Wasn't this about you accessing NTFS on your EeePC via unfs 
> from the Linux side?

Both.  I realized that there was a problem with the ufsd driver of the 
Xandros Linux on my EeePC, accessing NTFS partitions.  (This is the issue 
that made me add a config variable, but which was solved by Linus' 
core.fsyncobjects suggestion.)

Later I had a hunch that the issues 222 and 229 of msysGit might have 
exactly the same reason, let the reporters test, and indeed, the problems 
went away.

But come to think of it, we can _easily_ just set core.createObject=rename 
in msysGit, so I agree that there is no longer a need for the Makefile 
variable.

Want me to resend?

Ciao,
Dscho
