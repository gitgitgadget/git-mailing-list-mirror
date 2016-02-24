From: Jeff King <peff@peff.net>
Subject: Re: whither merge-tree?
Date: Wed, 24 Feb 2016 02:58:49 -0500
Message-ID: <20160224075849.GB12511@sigill.intra.peff.net>
References: <xmqqio1nge5b.fsf@gitster.mtv.corp.google.com>
 <20160222221209.GA18522@sigill.intra.peff.net>
 <xmqqsi0k4b52.fsf@gitster.mtv.corp.google.com>
 <20160223050210.GA17767@sigill.intra.peff.net>
 <56CC2B2E.6070203@uni-graz.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Stefan =?utf-8?Q?Fr=C3=BChwirth?= <stefan.fruehwirth@uni-graz.at>
X-From: git-owner@vger.kernel.org Wed Feb 24 08:58:57 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYULY-0002Mr-DN
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 08:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757176AbcBXH6w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 02:58:52 -0500
Received: from cloud.peff.net ([50.56.180.127]:48101 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750846AbcBXH6w (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 02:58:52 -0500
Received: (qmail 21423 invoked by uid 102); 24 Feb 2016 07:58:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:58:52 -0500
Received: (qmail 5407 invoked by uid 107); 24 Feb 2016 07:59:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Feb 2016 02:59:00 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Feb 2016 02:58:49 -0500
Content-Disposition: inline
In-Reply-To: <56CC2B2E.6070203@uni-graz.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287184>

On Tue, Feb 23, 2016 at 10:49:34AM +0100, Stefan Fr=C3=BChwirth wrote:

> On 23.02.2016 at 06:02 Jeff King wrote:
> >>Let's wait and see how many "please don't"s we hear, perhaps, befor=
e
> >>deciding to go 3.?
> >
> >I'm guessing we won't see much either way. Even Stefan, the original
> >reporter, does not seem to actively be using it, but rather relaying=
 a
> >report.
>=20
> I _am_ actively using it. Maybe I was unclear on that topic. I'm in f=
avour
> of keeping it, because this means I don't have to rewrite Chris' Code=
 in
> order to be able to use the Python library that uses merge-tree (Acid=
fs).
> But as a sensible human being I want what's best in the long run. I l=
eave
> that up to you as I have no way of assessing that.

Ah, sorry for the confusion. I had thought you were just relaying bugs
on behalf of acidfs folks, but it makes sense that you are using it
indirectly through the library.

> So that's a "please don't" leave the code as-is but provide a (transi=
tional)
> solution that fixes the reported bug and has the best chances of not =
causing
> any more headaches :)

I think the series I posted does what you want, then, and we can stop
short of deprecating for now.

-Peff
