From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] "git shell" won't work, need "git-shell"
Date: Mon, 25 Aug 2008 19:58:14 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <20080824202325.GA14930@eagain.net> <7vfxoukv56.fsf@gitster.siamese.dyndns.org> <20080824203825.GB14930@eagain.net> <7vbpzikt4b.fsf@gitster.siamese.dyndns.org> <20080824222534.GC14930@eagain.net> <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
 <48B29B2A.6000802@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tommi Virtanen <tv@eagain.net>, Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Mon Aug 25 19:55:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXgH6-0006Fy-Tq
	for gcvg-git-2@gmane.org; Mon, 25 Aug 2008 19:54:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755481AbYHYRxP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Aug 2008 13:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbYHYRxO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Aug 2008 13:53:14 -0400
Received: from mail.gmx.net ([213.165.64.20]:37064 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755313AbYHYRxN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Aug 2008 13:53:13 -0400
Received: (qmail invoked by alias); 25 Aug 2008 17:53:11 -0000
Received: from pacific.mpi-cbg.de (EHLO [141.5.10.38]) [141.5.10.38]
  by mail.gmx.net (mp057) with SMTP; 25 Aug 2008 19:53:11 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/T6S9zUhDT5alV8+lPvPAFuCWw8yepFNp+vrGK43
	jelV+RnD4n4oCa
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <48B29B2A.6000802@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.72
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93649>

Hi,

On Mon, 25 Aug 2008, Paolo Bonzini wrote:

> > That would involve you actually finding out what's happening, though.
> 
> He said so:
> 
> > test:x:1001:1001:,,,:/home/test:/usr/bin/git shell
> > 
> > just makes ssh loop asking for a password, logging
> > 
> > "User test not allowed because shell /usr/bin/git shell does not exist"

Okay, so this means that you cannot pass arguments to the login shell.  
Makes me wonder... I had the impression that bash was called with --login.

Ciao,
Dscho
