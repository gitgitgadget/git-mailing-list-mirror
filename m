From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH v1] Add Travis CI support
Date: Sat, 3 Oct 2015 23:34:23 -0400
Message-ID: <20151004033423.GA20876@sigill.intra.peff.net>
References: <1443131004-39284-1-git-send-email-larsxschneider@gmail.com>
 <xmqqeghnuy8t.fsf@gitster.mtv.corp.google.com>
 <1443150875.3042.3.camel@kaarsemaker.net>
 <699c08632232180166145f70c7f16645@dscho.org>
 <CAE5ih7_f8qy9WvmgRUR6-qFwB4WFhZ6Qr5iOpE0YxqJH8AsZyw@mail.gmail.com>
 <vpq7fnc83ki.fsf@grenoble-inp.fr>
 <vpq4mie1m3n.fsf@grenoble-inp.fr>
 <xmqqlhbqcrf7.fsf@gitster.mtv.corp.google.com>
 <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Luke Diamand <luke@diamand.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Git Users <git@vger.kernel.org>
To: Roberto Tyley <roberto.tyley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 04 05:34:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zia4g-0003Qf-Be
	for gcvg-git-2@plane.gmane.org; Sun, 04 Oct 2015 05:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098AbbJDDe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Oct 2015 23:34:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:39331 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750786AbbJDDe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Oct 2015 23:34:26 -0400
Received: (qmail 8211 invoked by uid 102); 4 Oct 2015 03:34:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Oct 2015 22:34:26 -0500
Received: (qmail 5127 invoked by uid 107); 4 Oct 2015 03:34:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Oct 2015 23:34:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Oct 2015 23:34:23 -0400
Content-Disposition: inline
In-Reply-To: <CAFY1edZSNKepx_+2U=C-raOBiVK3Zh2r_Y_NO2-RtbhH_n-tdg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278990>

On Sat, Oct 03, 2015 at 11:23:52PM +0100, Roberto Tyley wrote:

> On 28 September 2015 at 19:47, Junio C Hamano <gitster@pobox.com> wrote:
> > I won't enable it on github.com:gitster/git anyway, so I do not
> > think that is a concern.  I thought what people are talking about
> > was to add it on github.com:git/git, but have I been misreading the
> > thread?  I do not even own the latter repository (I only can push
> > into it).
> 
> I was momentarily surprised to hear that Junio doesn't own github.com/git/git
> but I had a quick look at the github.com/git organisation, and it turns
> out that Peff and Scott Chacon are the current owners - so at the
> moment I think they're the only ones who could switch on the GitHub
> webhook to hit Travis.

There is a @git/git team on GitHub that should have full access to the
git/git repository, and Junio is on that (but I also do not _expect_
Junio to spend time managing it; he has plenty of other things to do).

I am on vacation at the moment, but am happy to look at it when I get
back in a few weeks.

-Peff
