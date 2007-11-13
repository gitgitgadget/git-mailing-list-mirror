From: Jeff King <peff@peff.net>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 23:23:42 -0500
Message-ID: <20071113042342.GC9745@sigill.intra.peff.net>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com> <Pine.LNX.4.64.0711121412410.4362@racer.site> <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org> <Pine.LNX.4.64.0711122040350.4362@racer.site> <9e4733910711121254j5af5dba6k5acdce939936af66@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 13 05:24:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrnJh-00050y-3e
	for gcvg-git-2@gmane.org; Tue, 13 Nov 2007 05:24:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753931AbXKMEXq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 23:23:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753436AbXKMEXq
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 23:23:46 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1722 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752625AbXKMEXp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 23:23:45 -0500
Received: (qmail 17329 invoked by uid 111); 13 Nov 2007 04:23:44 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 12 Nov 2007 23:23:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 12 Nov 2007 23:23:42 -0500
Content-Disposition: inline
In-Reply-To: <9e4733910711121254j5af5dba6k5acdce939936af66@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64748>

On Mon, Nov 12, 2007 at 03:54:59PM -0500, Jon Smirl wrote:

> It is eaiser to put
>   git config remote.origin.url
> http://git.digispeaker.com/projects/digispeaker-kernel.git
> in a cookbook web page sequence than say edit the config file by hand.

I think that falls under "scripting" (it's just that your interpreter is
a human).

> I added the cookbook sequence to my git project page.
> http://git.digispeaker.com/
> Without cloning from kernel.org first it takes an hour to clone from
> dreamhost, but what do you want for $5/mth. I'll more to a better host
> when traffic picks up.

It sounds like you are posting commits on top of Linus' kernel tree. Why
not use repo.or.cz's hosting? It's free, and it _already_ has the
linus-2.6 tree, so you can start a 'fork' and not even waste any space.

-Peff
