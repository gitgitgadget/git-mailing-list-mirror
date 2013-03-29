From: Miklos Vajna <vmiklos@suse.cz>
Subject: Re: [PATCH] cherry-pick -x: improve handling of one-liner commit
 messages
Date: Fri, 29 Mar 2013 21:39:16 +0100
Message-ID: <20130329203915.GA5157@suse.cz>
References: <20130329153818.GB27251@suse.cz>
 <7v8v56p1bl.fsf@alter.siamese.dyndns.org>
 <CA+sFfMet0578rLwAKBBsd8DM3thsw=8+joEAAf44TzwqUZgXzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 29 21:39:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULg5V-0001Wn-Q3
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 21:39:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756779Ab3C2UjW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 16:39:22 -0400
Received: from cantor2.suse.de ([195.135.220.15]:42110 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756279Ab3C2UjV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 16:39:21 -0400
Received: from relay2.suse.de (unknown [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 39996A3A49;
	Fri, 29 Mar 2013 21:39:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CA+sFfMet0578rLwAKBBsd8DM3thsw=8+joEAAf44TzwqUZgXzw@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219529>


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 29, 2013 at 10:41:17AM -0700, Brandon Casey <drafnel@gmail.com>=
 wrote:
> > Sign-off?

Indeed, I forgot about it, my bad.

> > I think this is part of the bc/append-signed-off-by topic that is
> > about to graduate to 'master'; more specifically, b971e04f54e7
> > (sequencer.c: always separate "(cherry picked from" from commit
> > body, 2013-02-12) does the equivalent, no?
>=20
> Yeah, I think this case is already handled.
>=20
> Miklos, can you check out next and see if your problem case is handled?

I just checked next and right, that solves the problem I was fixing.

So -- sorry for the noise. :-)

Miklos

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iEYEARECAAYFAlFV+/MACgkQe81tAgORUJZllwCggRVd1Lt4Sy+7SF5sDsGFbG8/
egsAoIdmNXAN7OpKXE57kjpoUduyPRES
=4Yxa
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
