From: Jeff King <peff@peff.net>
Subject: Re: Implementation of a "textconv" filter for easy custom diff.
Date: Sun, 28 Sep 2008 12:11:07 -0400
Message-ID: <20080928161106.GA30199@coredump.intra.peff.net>
References: <1222567618-22156-1-git-send-email-Matthieu.Moy@imag.fr> <20080928041040.GA24214@coredump.intra.peff.net> <vpqd4io1tla.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Sep 28 18:12:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kjysh-0008MZ-0R
	for gcvg-git-2@gmane.org; Sun, 28 Sep 2008 18:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751730AbYI1QLL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Sep 2008 12:11:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751786AbYI1QLK
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Sep 2008 12:11:10 -0400
Received: from peff.net ([208.65.91.99]:4175 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751670AbYI1QLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Sep 2008 12:11:10 -0400
Received: (qmail 7127 invoked by uid 111); 28 Sep 2008 16:11:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 28 Sep 2008 12:11:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 28 Sep 2008 12:11:07 -0400
Content-Disposition: inline
In-Reply-To: <vpqd4io1tla.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96977>

On Sun, Sep 28, 2008 at 11:57:05AM +0200, Matthieu Moy wrote:

> > Neat. I started on something like this quite a while ago,
> 
> Did you publish/send it anywhere?

No, I was waiting to clean it up and test it a bit more.

> Well, OTOH, one could argue that "blame" is based on diff-ing, and
> therefore it's natural to define a diff filter to tell how "blame"
> should work.

Yes, I would have made that argument. ;)

> >     [diff "foo"]
> >     xfuncname = "some regex"
> >     binary = auto
> 
> No sure that would actually be useful in real life, but it doesn't
> harm to have it. And the argument "better path forward for defining
> sets of diff tweaks" is a good one IMO.

Yes, I think currently most diff options supersede the decision about
whether or not it's binary (like textconv, in which you probably assume
the result is diff-able as text). xfuncname doesn't, but the example is
perhaps a bit contrived. So I do think of it as more of a way for future
expansion.

I seem to recall actually running into this as part of the textconv work
I was doing, but now I can't remember the exact details.  So that's not
that compelling an argumen.t :)

-Peff
