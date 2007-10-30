From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Tue, 30 Oct 2007 19:58:23 -0400
Message-ID: <20071030235823.GA22747@coredump.intra.peff.net>
References: <20071030044026.GA9600@thunk.org> <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org> <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org> <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal@obry.net>, Matthieu Moy <Matthieu.Moy@imag.fr>,
	Tom Prince <tom.prince@ualberta.net>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>, Jan Hudec <bulb@ucw.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>,
	Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 00:58:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1In0z2-0006aG-5W
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 00:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753923AbXJ3X62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Oct 2007 19:58:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753198AbXJ3X62
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Oct 2007 19:58:28 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2479 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754022AbXJ3X61 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Oct 2007 19:58:27 -0400
Received: (qmail 6056 invoked by uid 111); 30 Oct 2007 23:58:25 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 30 Oct 2007 19:58:25 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Oct 2007 19:58:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62762>

On Tue, Oct 30, 2007 at 12:38:27PM -0700, Linus Torvalds wrote:

> So if you want to follow the RFC, you'd better give a real reason. And no, 
> the existence of an RFC, and the fact that people use the same name for 
> things that superficially _look_ the same is not a reason in itself.
> 
> So hands up, people. Anybody who asked for RFC quoting. Give a damn 
> *reason* already!

I didn't ask for RFC quoting, but a nice side effect of URL syntax is
that they are machine parseable. If you wanted to write a tool to pick
the URLs out of this email and clone them as git repos, then how do you
find the end of:

  http://host/git repo with spaces in the path

compared to:

  http://host/git+repo+with+spaces+in+the+path

I don't know if that's worth changing anything in git (in fact, I'm not
even clear on _what_ people want to change; the point of this discussion
seems to be to argue about terminology). But you did ask for any reason
for quoting URLs.

-Peff
