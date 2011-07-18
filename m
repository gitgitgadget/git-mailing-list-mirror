From: Jeff King <peff@peff.net>
Subject: Re: Getting a list of commits between 2 points without upstream
 changes
Date: Sun, 17 Jul 2011 21:28:44 -0400
Message-ID: <20110718012844.GA2112@sigill.intra.peff.net>
References: <CAFOYHZC5hQ9JV8a5d20AaPR_eYFDViama+4148MPumvvJ-n6wQ@mail.gmail.com>
 <20110718001749.GA706@sigill.intra.peff.net>
 <CAFOYHZDUyQpVc5m4w9jcDsmed+UR8a_zxzR0mBAjPf7_A80MQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 18 03:28:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qicdg-0002Gu-GC
	for gcvg-git-2@lo.gmane.org; Mon, 18 Jul 2011 03:28:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756463Ab1GRB2q convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 17 Jul 2011 21:28:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:48580
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756316Ab1GRB2q (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Jul 2011 21:28:46 -0400
Received: (qmail 16495 invoked by uid 107); 18 Jul 2011 01:29:12 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Jul 2011 21:29:12 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Jul 2011 21:28:44 -0400
Content-Disposition: inline
In-Reply-To: <CAFOYHZDUyQpVc5m4w9jcDsmed+UR8a_zxzR0mBAjPf7_A80MQg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177329>

On Mon, Jul 18, 2011 at 12:33:27PM +1200, Chris Packham wrote:

> > I'm not clear on what makes "B" more special than "A" in the graph
> > above. But assuming you know A, don't you just want:
>=20
> What makes A special in this case is that commits up to and including
> A have been reviewed, regression tested etc. My use-case is really
> about telling people what has been worked on since the last time the
> code was reviewed.

OK, that makes sense.

> > =C2=A0git log --no-merges topic ^upstream ^A
> >
> > ? That is, "everything in topic, but not in upstream, nor in the pa=
rent
> > of A". Or if you know A and not B, you can use "^B^!" (which means =
"do
> > not include commits that are in any parent of B").
>=20
> Brilliant, that's exactly what I wanted. Thanks.

Oops, I mis-stated it above. It would be "everything in topic, but not
in upstream, nor in A". Which I think is what you actually want (I had
originally written it as "^B^!", but forgot to change the text when I
switched it to the more-readable "^A").

-Peff
