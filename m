From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 20:17:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808252015080.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080824202325.GA14930@eagain.net>  <7vfxoukv56.fsf@gitster.siamese.dyndns.org>  <20080824203825.GB14930@eagain.net>  <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>  <20080825170816.GQ10544@machine.or.cz>
 <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <gitster@pobox.com>,
	Tommi Virtanen <tv@eagain.net>, git@vger.kernel.org
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 25 20:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgZ4-0004CF-AW
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 20:13:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753868AbYHYSMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 14:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753685AbYHYSMM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 14:12:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:48824 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750935AbYHYSML (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 14:12:11 -0400
Received: (qmail invoked by alias); 25 Aug 2008 18:12:09 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp066) with SMTP; 25 Aug 2008 20:12:09 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/DMKsr7OzDFPYyqhkGDge3+fsbefakmupmAk5xRs
	xRk3YR6B1eZD7B
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <37fcd2780808251020j1ef51b38h7c6d6e8f050a92ce@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93650>

Hi,

On Mon, 25 Aug 2008, Dmitry Potapov wrote:

> On Mon, Aug 25, 2008 at 9:08 PM, Petr Baudis <pasky@suse.cz> wrote:
> >
> > Can we agree that direct calls of libexec stuff should never be part 
> > of the "official" interface (i.e. not workarounds for deprecated 
> > usage)?
> 
> Agreed. It looks somewhat strange to type the libexec path in 
> /etc/passwd.

FWIW I do not agree.  IMNHO libexec/ is just a way to organize executable 
parts of any software package that are usually not called from the command 
line.  And a login shell qualifies for that.

> > Considering that calling the git-shell executable directly is the 
> > _only_ sensible way of using this interface, it should follow that it 
> > has to be in /usr/bin, no matter if users type this command or not.
> 
> Perhaps, /usr/sbin would be a better place, as it is intended only for 
> system administration binaries.

Does it not strike you as odd, then, that "sh" -- by far the most common 
login shell -- does not live in /usr/sbin/?

Ciao,
Dscho
