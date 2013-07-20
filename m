From: Jeff King <peff@peff.net>
Subject: Re: Git tag output order is incorrect (IMHO)
Date: Fri, 19 Jul 2013 20:22:41 -0400
Message-ID: <20130720002241.GA22143@sigill.intra.peff.net>
References: <840FACA0-7E13-41DB-A0F8-124FAB53BFBD@rtcamp.com>
 <87wqon7ok4.fsf@igel.home>
 <7vli52uym0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Rahul Bansal <rahul.bansal@rtcamp.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 20 02:23:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V0Kx0-0001HL-LA
	for gcvg-git-2@plane.gmane.org; Sat, 20 Jul 2013 02:23:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753375Ab3GTAWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jul 2013 20:22:48 -0400
Received: from cloud.peff.net ([50.56.180.127]:53330 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753143Ab3GTAWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jul 2013 20:22:47 -0400
Received: (qmail 19653 invoked by uid 102); 20 Jul 2013 00:22:47 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 19 Jul 2013 19:22:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jul 2013 20:22:41 -0400
Content-Disposition: inline
In-Reply-To: <7vli52uym0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230867>

On Fri, Jul 19, 2013 at 12:40:55PM -0700, Junio C Hamano wrote:

> Andreas Schwab <schwab@linux-m68k.org> writes:
> 
> > Rahul Bansal <rahul.bansal@rtcamp.com> writes:
> >
> >> IMHO "git tag" is expected to show tag-list ordered by versions. 
> >
> > A git tag can be anything, not related to versions at all.
> 
> Correct.
> 
> But that does not prevent somebody to add "git tag --sort=X" option
> to the command, just like "git for-each-ref" has "--sort=X" option.

A while ago I started on (but did not get very far on) unifying the ref
selection code for for-each-ref, tag, and branch. It would be nice if
they all supported the same set of --contains/--points-at/--merged/--sort,
etc.

I do plan to finish it eventually, but if anyone else feels like picking
it up, I'd be glad to review patches and/or share my work-in-progress as
a starting point.

-Peff
