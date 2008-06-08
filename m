From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] improve doc heading for git-bisect
Date: Sun, 8 Jun 2008 17:27:58 -0400
Message-ID: <20080608212757.GA8034@sigill.intra.peff.net>
References: <20080607070637.79B17C7C0E@rwavmlap> <m37id1y4zj.fsf@localhost.localdomain> <9af502e50806070906u63e52de4wa0bc4dced0c4d984@mail.gmail.com> <20080608043543.GB11194@sigill.intra.peff.net> <alpine.DEB.1.00.0806081600220.1783@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robert Anderson <rwa000@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 08 23:28:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5SRb-0005q7-IS
	for gcvg-git-2@gmane.org; Sun, 08 Jun 2008 23:28:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755546AbYFHV2B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 17:28:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755507AbYFHV2B
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 17:28:01 -0400
Received: from peff.net ([208.65.91.99]:3588 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755538AbYFHV2A (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 17:28:00 -0400
Received: (qmail 15666 invoked by uid 111); 8 Jun 2008 21:27:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Sun, 08 Jun 2008 17:27:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 08 Jun 2008 17:27:58 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0806081600220.1783@racer>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84322>

On Sun, Jun 08, 2008 at 04:01:48PM +0100, Johannes Schindelin wrote:

> > I was going to suggest a "--paste" option for format-patch which would
> > produce a nicer output for cutting and pasting,
> 
> You still have to move the subject line where it belongs, so I think the 
> value of --paste is limited.  You do have to pay attention anyway (for 
> example when imitating how other people do it), so I think the current 
> state should be fine.

Not necessarily. I often end up posting patches like:

How about this?

-- >8 --
subject

body

---
diffstat

patch

but the --pretty=format recipe I provided works just fine for that.

-Peff
