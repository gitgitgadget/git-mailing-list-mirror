From: Jeff King <peff@peff.net>
Subject: Re: Friendly refspecs (Was: Re: git annoyances)
Date: Wed, 9 Apr 2008 20:33:52 -0400
Message-ID: <20080410003352.GA14057@sigill.intra.peff.net>
References: <20080409101428.GA2637@elte.hu> <20080409145758.GB20874@sigill.intra.peff.net> <20080409200836.GA19248@mithlond> <20080409203453.GA10370@sigill.intra.peff.net> <20080409222500.GB19248@mithlond> <20080409225112.GB12103@sigill.intra.peff.net> <bd6139dc0804091616k53f4e0c1sf75aa9585c5a54c5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Thu Apr 10 02:34:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JjkkQ-0004d7-QU
	for gcvg-git-2@gmane.org; Thu, 10 Apr 2008 02:34:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbYDJAdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 20:33:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753306AbYDJAdy
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 20:33:54 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1427 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753244AbYDJAdx (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 20:33:53 -0400
Received: (qmail 25599 invoked by uid 111); 10 Apr 2008 00:33:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 09 Apr 2008 20:33:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 09 Apr 2008 20:33:52 -0400
Content-Disposition: inline
In-Reply-To: <bd6139dc0804091616k53f4e0c1sf75aa9585c5a54c5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79162>

[Your message didn't go to the list, but I think it was supposed to, so
I am re-adding the list].

On Thu, Apr 10, 2008 at 01:16:57AM +0200, Sverre Rabbelier wrote:

> >  I wonder if people like Linus who do a lot of one-off pulls would find
> >  that too cluttery. I guess we can post a patch and see. ;)
> 
> Maybe a 'newbie' configuration option could be added?
> We can then, if that option is set, provide this kind of information
> to the user.
> Then, later on, when the user is more confident, they can unset the option.
> I reckon it should be set to default-off but that we should provide an
> easy way to turn it on.
> (That is, 'git config newbie on', is easy enough, as long as it is
> mentioned in a/the newbie guide)

This has been discussed before, and I think the general consensus was
that it's a bad idea to separate the "newbie" and "expert" experience
too much. It makes it harder to provide advice and documentation that
works for everyone.

Now that argument generally applies to _behavior_ changes, not verbosity
of messages. But in this case, I think it is easy enough to find a
"right" behavior for everyone: show the message on fetch, which would
otherwise be a very confusing command, but suppress it on "pull", where
the fetching is mostly a side effect.

-Peff
