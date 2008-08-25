From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 12:37:12 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080824222534.GC14930@eagain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Tommi Virtanen <tv@eagain.net>
X-From: git-owner@vger.kernel.org Mon Aug 25 12:33:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXZNt-0004Ie-50
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 12:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237AbYHYKcN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 06:32:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753002AbYHYKcM
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 06:32:12 -0400
Received: from mail.gmx.net ([213.165.64.20]:52812 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752863AbYHYKcM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 06:32:12 -0400
Received: (qmail invoked by alias); 25 Aug 2008 10:32:10 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 25 Aug 2008 12:32:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX184IZsJka84oSb6X/D1desXfrOOlMTrVTCY0FiEsY
	mrhsxDagwuyywc
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <20080824222534.GC14930@eagain.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93609>

Hi,

On Mon, 25 Aug 2008, Tommi Virtanen wrote:

> On Sun, Aug 24, 2008 at 02:20:20PM -0700, Junio C Hamano wrote:
> > I do not have particular preference either way.  What people wanted was to
> > have smaller number of git-foo on $PATH, and especially as "git-shell" is
> > not something people would be typing from their command line, so I dunno.
> 
> That's true, but I kinda think libexec is something only used
> *internally*, and you can't claim /etc/passwd to be internal to git..
> 
> At the minimum, git-shell(1) should explain that one needs to use the
> libexec path.

Or maybe the real issue can be fixed?  Namely that your configuration does 
not work?  That would involve you actually finding out what's happening, 
though.

Ciao,
Dscho
