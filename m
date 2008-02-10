From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remove "nohup" from git-help--browse
Date: Sun, 10 Feb 2008 02:06:54 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802100205440.11591@racer.site>
References: <7vhcgkm7yy.fsf@gitster.siamese.dyndns.org> <1202502982-6822-1-git-send-email-dpotapov@gmail.com> <200802090653.43280.chriscool@tuxfamily.org> <20080209200351.GC30368@dpotapov.dyndns.org> <7vbq6p7emn.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Dmitry Potapov <dpotapov@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 03:07:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JO1bK-0007BC-J0
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 03:07:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964AbYBJCGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Feb 2008 21:06:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbYBJCGw
	(ORCPT <rfc822;git-outgoing>); Sat, 9 Feb 2008 21:06:52 -0500
Received: from mail.gmx.net ([213.165.64.20]:49175 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751919AbYBJCGw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Feb 2008 21:06:52 -0500
Received: (qmail invoked by alias); 10 Feb 2008 02:06:50 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp040) with SMTP; 10 Feb 2008 03:06:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19XOTpD4fRXaYCvAxgXiUfC/9pD+RB4cdrLVuJThx
	nIr1xaV2WzZCHL
X-X-Sender: gene099@racer.site
In-Reply-To: <7vbq6p7emn.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73290>

Hi,

On Sat, 9 Feb 2008, Junio C Hamano wrote:

> Dmitry Potapov <dpotapov@gmail.com> writes:
> 
> > So, I want to hear what other people think. If there is no objection,
> > I will add this redirection.
> 
> I personally feel that we should not hide output from the
> backend browsers by redirection.  Some may be chattier than
> others, but then we would know against which browser to file bug
> reports.
> 
> Just my two yen.

Yeah.  If you do not like the chatty side, then there should be a way to 
configure a script which redirects stdout/stderr to be called in place of 
the browser binary.

Just my two (rapidly losing) pound.

Ciao,
Dscho
