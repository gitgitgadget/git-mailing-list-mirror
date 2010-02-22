From: Jelmer Vernooij <jelmer@samba.org>
Subject: Re: Storing (hidden) per-commit metadata
Date: Mon, 22 Feb 2010 20:13:13 +0100
Message-ID: <1266865993.11527.49.camel@ganieda>
References: <1266687636-sup-7641@ben-laptop>
	 <32541b131002201057t31fc8a6aydb0942171fe1b8c8@mail.gmail.com>
	 <20100221063433.GA2840@coredump.intra.peff.net>
	 <1266754646.12035.23.camel@ganieda>
	 <20100222051748.GB10191@dpotapov.dyndns.org>
	 <1266832607.31769.37.camel@ganieda>
	 <20100222112845.GE10191@dpotapov.dyndns.org>
	 <1266839972.4575.38.camel@ganieda>
	 <20100222130836.GG10191@dpotapov.dyndns.org>
	 <1266846289.4575.69.camel@ganieda>
	 <20100222142013.GA7863@dpotapov.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-pqzDjHa7KcW90KESpuGn"
Cc: Jeff King <peff@peff.net>, Avery Pennarun <apenwarr@gmail.com>,
	Ben Gamari <bgamari@gmail.com>, git <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 22 20:14:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NjdjR-0002u9-In
	for gcvg-git-2@lo.gmane.org; Mon, 22 Feb 2010 20:14:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754460Ab0BVTN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Feb 2010 14:13:27 -0500
Received: from gwenhwyvar.vernstok.nl ([92.243.4.181]:60801 "EHLO
	gwenhwyvar.vernstok.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754397Ab0BVTNZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Feb 2010 14:13:25 -0500
Received: from ganieda (localhost [127.0.0.1])
	by gwenhwyvar.vernstok.nl (Postfix) with ESMTP id 84CD6265F8;
	Mon, 22 Feb 2010 19:14:52 +0000 (UTC)
Received: by ganieda (Postfix, from userid 1000)
	id CE16A14FC68; Mon, 22 Feb 2010 20:13:21 +0100 (CET)
In-Reply-To: <20100222142013.GA7863@dpotapov.dyndns.org>
X-Mailer: Evolution 2.28.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140708>


--=-pqzDjHa7KcW90KESpuGn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2010-02-22 at 17:20 +0300, Dmitry Potapov wrote:
> On Mon, Feb 22, 2010 at 02:44:49PM +0100, Jelmer Vernooij wrote:
> > On Mon, 2010-02-22 at 16:08 +0300, Dmitry Potapov wrote:
> > > I am not sure that the commit object is the right place to store that
> > > metadata, but hidding this information is even more problematic. Let'=
s
> > > suppose that someone cherry-pick your Bazaar originated commit. Now w=
hen
> > > you try to synchronize with Bazaar, your synchronizer will see that i=
t
> > > has some Bazaar revision ID and branch name, but, in fact, it is new
> > > commit on a completely different branch...
> > I don't see how the fact that the bzr-git/hg-git data is being hidden i=
s
> > the problem in the scenario you mention.
> Because you can easily remove that information manually when you cherry-p=
ick
> some commit. It is more difficult to do when it is hidden.
My point is that if you don't make it part of the user-visible commit
message there is no need to remove it at all, it'll just disappear by
itself.

> > It'd be nice if this sort of information was discarded by "git rebase",
> > but that's another good reason to treat it in a different way from the
> > commit message instead.
> Well, I do not see any other place in the commit object aside the commit
> message where you can easily put information, and I do not think it is a
> good idea for "git rebase" to edit the commit message automatically.
> Maybe, you should look at git-notes. (I don't know enough about them to
> tell whether they are suitable or not).
Some other people have suggested putting e.g. a RFC822-style header in
the commit message field and using the headers in that to allow custom
revision properties, only displaying the body in "git log", "git show"
etc. What do you think about that?

Cheers,

Jelmer

--=-pqzDjHa7KcW90KESpuGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQIcBAABAgAGBQJLgtdIAAoJEACAbyvXKaRXsocP/ip4VawEkddl8Tc6sNdjYEsp
Q6Lp/TqGvAjoUh/OpAbM9D9P9h93tlDq7dOsZCO+p2xsvKd52x+FKkEGsLshiwZR
o/nVLudN+xqM0wuYSwTdgBPsMkHgvYTcgx/sp0hTwa/GHSjCvcXiJVnqeza89xy5
Hh7LUhEyRQHh5ZvET5r503yAG9vEQTLTuR2ew2Jzq8mcLsT2FtSARbUOysVBaPMg
lP9IvRMqacCe2AfmXICEkP1v1TI2SKEz9HVbqEROjRXXt6NuOJk+7dGS9CzWr5Tt
Ujx//EYZM82dxdGaLNRVJF2F0BEDnLCozPsCUMuxgMwhUtnn+0H5ek6+pt62sXA8
hPm5wfZfajllpiF4LnDOQw2Z/93z25eir7C3vDNVo0KRfcZDvt1cTQYPZyZFZCkF
lLWpDKimFzjKclYFhYjqkxBelJqBkIHul+Oa1ij6ihh0iMhX8rAx0FEUd+N6IzdG
UaAscUpQzkeJijZdP3gTSDtO8HXYtrTsUkN4dsCa8JDrN+VxdPtpX1lvZiYNb3Ma
Ubq8zCpAZJjxj6Gx1CmIMplLkTGvN6tyxQ6uj0gf7jGl/Cgbd8XUBfC1uAfAalfE
uStlVVp9TgaLk2CHdLIp9TYhuuWzlNN7sPg51rrnlCAkEjm1xRQ1kBGWSSG109Lt
MEcKtlOz3rIkZYrXLIXG
=WaMy
-----END PGP SIGNATURE-----

--=-pqzDjHa7KcW90KESpuGn--
