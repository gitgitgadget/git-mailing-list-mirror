From: Jeff King <peff@peff.net>
Subject: Re: [kernel.org users] [RFD] On deprecating "git-foo" for builtins
Date: Tue, 26 Aug 2008 17:03:19 -0400
Message-ID: <20080826210318.GA6305@coredump.intra.peff.net>
References: <7vprnzt7d5.fsf@gitster.siamese.dyndns.org> <1219664940.9583.42.camel@pmac.infradead.org> <alpine.DEB.1.00.0808252018490.24820@pacific.mpi-cbg.de.mpi-cbg.de> <7vy72kek6y.fsf@gitster.siamese.dyndns.org> <20080826145719.GB5046@coredump.intra.peff.net> <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Woodhouse <dwmw2@infradead.org>, git@vger.kernel.org,
	users@kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 26 23:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KY5iE-0000x2-69
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 23:04:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbYHZVDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 17:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751708AbYHZVDW
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 17:03:22 -0400
Received: from peff.net ([208.65.91.99]:1157 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751389AbYHZVDV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 17:03:21 -0400
Received: (qmail 1932 invoked by uid 111); 26 Aug 2008 21:03:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Tue, 26 Aug 2008 17:03:20 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 26 Aug 2008 17:03:19 -0400
Content-Disposition: inline
In-Reply-To: <7vr68b8q9p.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93821>

On Tue, Aug 26, 2008 at 01:39:30PM -0700, Junio C Hamano wrote:

> But I can't.  People who complain _now_ just annoy me even more.  Why
> weren't you defending the backward compatibility with me, which you seem
> to value it so much, perhaps even more than I did back then?  Why are you
> wasting our time bringing it up again, instead of joining the discussion
> when it _mattered_ back then?

Yes, I was hoping my message would help provoke them to say "here is why
I did not do it back then, and why this should be revisited now". But
all it seems to have done is bring up more arguments that should have
been given back then. So for that I apologize, since I know that is
exactly what you did not want to read. ;)

> Read the subject line again, and notice that we are not talking about
> /usr/bin vs /usr/libexec/git-core; the request-for-discussion was about
> removing "git-add" and friends from /usr/libexec/git-core/, so that we do
> not have to even have these many hardlinks there.  Except for Linus (and
> obviously myself who started the thread), I saw nobody expressed any
> opinion on it.

I was slightly negative on the change at the time of "/usr/bin vs
/usr/libexec/git-core" and I planned to put "git --exec-path" in my
PATH. But I gave the new way a try, and I have not been very bothered.
So let me say that I really don't care much what happens with libexec,
and you can hold me to that when the next flame-war breaks out if such a
change is implemented. Now you have three opinions. :)

I really was just concerned that we are rejecting legitimate, popular
concerns because of a grumpy "you missed the deadline" stance, when
perhaps there is a good reason (which I am still waiting to hear) that
those concerns missed the deadline.

-Peff
