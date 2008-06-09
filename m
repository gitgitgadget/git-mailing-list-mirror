From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: squashing patches
Date: Tue, 10 Jun 2008 01:57:33 +0200
Message-ID: <20080609235733.GG8079@leksak.fem-net>
References: <20080607220101.GM31040@leksak.fem-net> <20080609114550.GA8079@leksak.fem-net> <7vprqqh06j.fsf@gitster.siamese.dyndns.org> <20080609204327.GD8079@leksak.fem-net> <20080609205321.GA15912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Joerg Sommer <joerg@alea.gnuu.de>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:58:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5rFw-0004O4-Ml
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755923AbYFIX5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755896AbYFIX5j
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:57:39 -0400
Received: from mail.gmx.net ([213.165.64.20]:44932 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755433AbYFIX5i (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:57:38 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:57:36 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp017) with SMTP; 10 Jun 2008 01:57:36 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX181y4A0D5Y1TzU2mrVQmqBOdSkpygzOZwy9CHY7w4
	J3f/DMRw/DGJNw
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1K5rEz-0000ad-37; Tue, 10 Jun 2008 01:57:33 +0200
Content-Disposition: inline
In-Reply-To: <20080609205321.GA15912@sigill.intra.peff.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84459>

Hi,

> I am just watching this from the sidelines, but it seems to me that you
> are best off creating the directives as modular and orthogonal as
> possible.  It is very simple to create "pick $1; edit" from "pick --edit
> $1" later, but it is more difficult to go the other way around.

Perhaps it is just me, but isn't "pick X ; edit"
more modular and orthogonal than "pick --edit X"? ;-)

But yes, the "pick --edit X" => "pick X ; edit" conversion seems easier.

And I'm slightly confused which solution seems better to you for now ;)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
