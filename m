From: Jeff King <peff@peff.net>
Subject: Re: squashing patches
Date: Mon, 9 Jun 2008 21:00:33 -0400
Message-ID: <20080610010033.GB16050@sigill.intra.peff.net>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <7vprqqh06j.fsf@gitster.siamese.dyndns.org> <20080609204327.GD8079@leksak.fem-net> <20080609205321.GA15912@sigill.intra.peff.net> <20080609235733.GG8079@leksak.fem-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Stephan Beyer <s-beyer@gmx.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 03:01:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5sFI-0006Fm-Sy
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 03:01:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbYFJBAh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 21:00:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754659AbYFJBAh
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 21:00:37 -0400
Received: from peff.net ([208.65.91.99]:3825 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754006AbYFJBAg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 21:00:36 -0400
Received: (qmail 25198 invoked by uid 111); 10 Jun 2008 01:00:34 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 09 Jun 2008 21:00:34 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2008 21:00:33 -0400
Content-Disposition: inline
In-Reply-To: <20080609235733.GG8079@leksak.fem-net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84465>

On Tue, Jun 10, 2008 at 01:57:33AM +0200, Stephan Beyer wrote:

> > I am just watching this from the sidelines, but it seems to me that you
> > are best off creating the directives as modular and orthogonal as
> > possible.  It is very simple to create "pick $1; edit" from "pick --edit
> > $1" later, but it is more difficult to go the other way around.
> 
> Perhaps it is just me, but isn't "pick X ; edit"
> more modular and orthogonal than "pick --edit X"? ;-)

Sorry, I chose a bad phrase. When I said "create X from Y", I meant
"when the user gives you Y, you can produce the canonical X". Not "once
we have the canonical Y, you can create X out of it."

So I appear to have said the exact opposite of what I meant. :)

> But yes, the "pick --edit X" => "pick X ; edit" conversion seems easier.

Exactly.

-Peff
