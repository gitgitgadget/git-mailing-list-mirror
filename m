From: Jeff King <peff@peff.net>
Subject: Re: git gc gives "error: Could not read..."
Date: Mon, 1 Jun 2015 06:22:50 -0400
Message-ID: <20150601102249.GB31792@peff.net>
References: <556C0BAD.80106@atlas-elektronik.com>
 <20150601081450.GA32634@peff.net>
 <556C1A95.9010704@atlas-elektronik.com>
 <20150601085226.GA20537@peff.net>
 <556C2273.4030405@atlas-elektronik.com>
 <20150601095850.GD31389@peff.net>
 <556C2F1B.1060508@atlas-elektronik.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 12:22:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzMrw-0007Nk-RG
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 12:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752282AbbFAKWx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Jun 2015 06:22:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:38702 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752160AbbFAKWw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 06:22:52 -0400
Received: (qmail 26215 invoked by uid 102); 1 Jun 2015 10:22:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 05:22:52 -0500
Received: (qmail 28064 invoked by uid 107); 1 Jun 2015 10:22:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 01 Jun 2015 06:22:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 01 Jun 2015 06:22:50 -0400
Content-Disposition: inline
In-Reply-To: <556C2F1B.1060508@atlas-elektronik.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270394>

On Mon, Jun 01, 2015 at 12:08:27PM +0200, Stefan N=C3=A4we wrote:

> > It ended up as a patch series. However, you can fetch it from:
> >=20
> >   git://github.com/peff/git.git jk/silence-unreachable-broken-links
> >=20
> > which is perhaps even easier.
>=20
> Not really in my situation...(but that's another story)

Oh, sorry. :)

> So (FWIW):
>=20
> Tested-by: Stefan Naewe <stefan.naewe@gmail.com>
>=20
> Anything else I could test ?

Thanks for confirming (though I was pretty sure it was the problem when
you bisected to the same commit I suspected). My only open questions ar=
e
the concerns I raised in the cover letter, but I don't think there is
anything else for you to test there.

-Peff
