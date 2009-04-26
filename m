From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add an option not to use link(src, dest) && unlink(src)
 when that is unreliable
Date: Sun, 26 Apr 2009 19:40:26 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904261940170.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0904231252080.10279@pacific.mpi-cbg.de> <alpine.LFD.2.00.0904251042490.3101@localhost.localdomain> <200904252052.10327.j6t@kdbg.org> <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j6t@kdbg.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 27 11:40:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ly8MT-0000n0-H6
	for gcvg-git-2@gmane.org; Sun, 26 Apr 2009 19:41:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754553AbZDZRkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Apr 2009 13:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754456AbZDZRkR
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Apr 2009 13:40:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:45997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754421AbZDZRkP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Apr 2009 13:40:15 -0400
Received: (qmail invoked by alias); 26 Apr 2009 17:40:13 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 26 Apr 2009 19:40:13 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/rtCEoQJjrfECDz9WLoyNDm+3fxxCg+4ipKvpnU8
	2oTJfH5rRSW+Yc
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7vhc0cw6w8.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117631>

Hi,

On Sat, 25 Apr 2009, Junio C Hamano wrote:

> Johannes Sixt <j6t@kdbg.org> writes:
> 
> > On Samstag, 25. April 2009, Linus Torvalds wrote:
> >> If you _don't_ do this patch, does
> >>
> >> 	[core]
> >> 		fsyncobjectfiles = true
> >>
> >> hide the bug?
> >
> > Most likely not because our fsync() on Windows is a noop :(
> 
> Actually, the reason I CC'ed Linus (and I also was interested in the
> platform bug itself) was because I think Dscho is accessing the NTFS
> partition from the Linux side.

Yep, correct.

Ciao,
Dscho
