From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 12:22:20 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0807211221310.8986@racer>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com> <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness> <1216604693.3673.20.camel@pc7.dolda2000.com> <m3fxq3ws16.fsf@localhost.localdomain> <alpine.DEB.1.00.0807211255010.3305@eeepc-johanness>
 <20080721110436.GA8395@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKtUB-0008Kn-4Y
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399AbYGULWY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 07:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590AbYGULWY
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 07:22:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:42067 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751087AbYGULWX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 07:22:23 -0400
Received: (qmail invoked by alias); 21 Jul 2008 11:22:21 -0000
Received: from grape.st-and.ac.uk (EHLO grape.st-and.ac.uk) [138.251.155.28]
  by mail.gmx.net (mp047) with SMTP; 21 Jul 2008 13:22:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18tkh0k8GUtEsyec0AeOCE4SN6kfUYTuPX20RbCQQ
	Kiah1yI179ijoq
X-X-Sender: gene099@racer
In-Reply-To: <20080721110436.GA8395@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89347>

Hi,

On Mon, 21 Jul 2008, Jeff King wrote:

> On Mon, Jul 21, 2008 at 12:56:14PM +0200, Johannes Schindelin wrote:
> 
> > > or syntax used in RPM spec macros
> > > 
> > >   %{?p:-P %p}
> > > 
> > > (and there is complementing %{!?<var>:<expansion>} in RPM spec macro
> > > language).
> > 
> > Yes, this is overkill.  I would even have passed the port argument 
> > _always_, since the port 22 for ssh is as likely to change as hell will 
> > not freeze over.  Actually, I am not so sure about the latter.
> 
> But keep in mind that "-p 22" on the command line _overrides_ what the
> user has in their ssh config, so it is not a good idea to pass it all
> the time.

Oh, good point.  So we might need something distasteful as what Jakub 
proposed... Hrmpf.

Ciao,
Dscho
