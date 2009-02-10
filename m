From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] shortstatus v1
Date: Tue, 10 Feb 2009 16:36:34 -0500
Message-ID: <20090210213634.GA26954@coredump.intra.peff.net>
References: <1234227067-56666-1-git-send-email-tuncer.ayaz@gmail.com> <20090210110330.GB12089@coredump.intra.peff.net> <7vwsbynv0o.fsf@gitster.siamese.dyndns.org> <20090210181052.GA19634@coredump.intra.peff.net> <20090210191118.GA26651@coredump.intra.peff.net> <4ac8254d0902101321w1b6171cfkf7a6253181324acd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Tuncer Ayaz <tuncer.ayaz@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 22:38:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LX0JM-0007hb-4k
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 22:38:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756654AbZBJVgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 16:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753869AbZBJVgh
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 16:36:37 -0500
Received: from peff.net ([208.65.91.99]:55274 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755548AbZBJVgh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2009 16:36:37 -0500
Received: (qmail 18712 invoked by uid 107); 10 Feb 2009 21:36:53 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 10 Feb 2009 16:36:53 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Feb 2009 16:36:34 -0500
Content-Disposition: inline
In-Reply-To: <4ac8254d0902101321w1b6171cfkf7a6253181324acd@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109319>

On Tue, Feb 10, 2009 at 10:21:16PM +0100, Tuncer Ayaz wrote:

> I tried this and it did not run faster than my experiment.

I'm surprised, based on the numbers you gave before. I guess your
machine is just a lot slower than what I am experimenting with. I think
you will have to profile to see what is taking so long, then, if you
want to speed it up.

> I had to add a missing opening curly brace in
> have_untracked() before it compiled.

Sorry about that. I added the comment just above directly into the
patch, and obviously managed to butcher the brace while I was doing it.

-Peff
