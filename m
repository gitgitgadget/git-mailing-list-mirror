From: Jeff King <peff@peff.net>
Subject: Re: ! [rejected] master -> master (non-fast forward)
Date: Mon, 19 Nov 2007 23:16:20 -0500
Message-ID: <20071120041620.GA23566@sigill.intra.peff.net>
References: <9e4733910711180712n6ee271fau774310e63ab08f6d@mail.gmail.com> <20071118182901.GA5939@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 20 05:16:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuKXc-0005QQ-FZ
	for gcvg-git-2@gmane.org; Tue, 20 Nov 2007 05:16:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754993AbXKTEQZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 23:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755045AbXKTEQZ
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 23:16:25 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2058 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754965AbXKTEQY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 23:16:24 -0500
Received: (qmail 27012 invoked by uid 111); 20 Nov 2007 04:16:22 -0000
Received: from c-24-125-35-113.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (24.125.35.113)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Mon, 19 Nov 2007 23:16:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Nov 2007 23:16:20 -0500
Content-Disposition: inline
In-Reply-To: <20071118182901.GA5939@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65523>

On Sun, Nov 18, 2007 at 07:29:01PM +0100, Alex Riesen wrote:

> > jonsmirl@terra:~/ds$ git push digispeaker
> > To ssh://jonsmirl1@git.digispeaker.com/~/projects/digispeaker-kernel.git
> >  ! [rejected]        master -> master (non-fast forward)
> > error: failed to push to
> 
> the branch you are pushing does not fast-forward to the one on
> digispeaker. IOW, the master on digispeaker has changed since you made
> changes on your local master.

Alex, are you going to rework your "consolidate nonff errors and print a
more extended message" patch on top of what's in next (I think it should
be much simpler now).

-Peff
