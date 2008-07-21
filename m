From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] Ensure that SSH runs in non-interactive mode
Date: Mon, 21 Jul 2008 07:04:36 -0400
Message-ID: <20080721110436.GA8395@sigill.intra.peff.net>
References: <1216598432-18553-1-git-send-email-fredrik@dolda2000.com> <alpine.DEB.1.00.0807210310330.3305@eeepc-johanness> <1216604693.3673.20.camel@pc7.dolda2000.com> <m3fxq3ws16.fsf@localhost.localdomain> <alpine.DEB.1.00.0807211255010.3305@eeepc-johanness>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>,
	Fredrik Tolf <fredrik@dolda2000.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jul 21 13:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKtDC-0002nF-VT
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 13:05:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754956AbYGULEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2008 07:04:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbYGULEi
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jul 2008 07:04:38 -0400
Received: from peff.net ([208.65.91.99]:2808 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756001AbYGULEi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2008 07:04:38 -0400
Received: (qmail 12046 invoked by uid 111); 21 Jul 2008 11:04:37 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 21 Jul 2008 07:04:37 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jul 2008 07:04:36 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807211255010.3305@eeepc-johanness>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89343>

On Mon, Jul 21, 2008 at 12:56:14PM +0200, Johannes Schindelin wrote:

> > or syntax used in RPM spec macros
> > 
> >   %{?p:-P %p}
> > 
> > (and there is complementing %{!?<var>:<expansion>} in RPM spec macro
> > language).
> 
> Yes, this is overkill.  I would even have passed the port argument 
> _always_, since the port 22 for ssh is as likely to change as hell will 
> not freeze over.  Actually, I am not so sure about the latter.

But keep in mind that "-p 22" on the command line _overrides_ what the
user has in their ssh config, so it is not a good idea to pass it all
the time.

-Peff
