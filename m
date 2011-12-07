From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Wed, 7 Dec 2011 23:58:27 +0100
Message-ID: <20111207225827.GB641@centaur.lab.cmartin.tk>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
 <20111206215102.GA3654@centaur.lab.cmartin.tk>
 <CAJ8P3RCPt9Kwi1F7_TEkZQhkm1mwR_TFKhYszS5LL50kXU8oNQ@mail.gmail.com>
 <20111207220345.GA21596@sigill.intra.peff.net>
 <CAJ8P3RB=Gj-QCe6meqXSZ7N8+PnfNxSD8omUxT6dDh00bUf0QQ@mail.gmail.com>
 <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eJnRUKwClWJh1Khz"
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 07 23:58:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RYQRd-0006kh-1y
	for gcvg-git-2@lo.gmane.org; Wed, 07 Dec 2011 23:58:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758044Ab1LGW62 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Dec 2011 17:58:28 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:44014 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755730Ab1LGW62 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2011 17:58:28 -0500
Received: from centaur.lab.cmartin.tk (brln-4d0c18e3.pool.mediaWays.net [77.12.24.227])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 9998A461AA;
	Wed,  7 Dec 2011 23:58:25 +0100 (CET)
Received: (nullmailer pid 27630 invoked by uid 1000);
	Wed, 07 Dec 2011 22:58:27 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Chris Patti <cpatti@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAJ8P3RA48W7ZiABvjkn_KkU-JPnCnaF_X_WK0wPtToph3DGDvg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186517>


--eJnRUKwClWJh1Khz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 07, 2011 at 05:30:19PM -0500, Chris Patti wrote:
> Actually I'm wrong on that count, but in an interesting way.
>=20
> Both CloudSponge.php and Cloudsponge.php exist and are *not* deleted
> in the remote repository, but on OSX only Cloudsponge.php shows up on
> the filesystem, yet CloudSponge.php is being reported as modified.
>=20
> Turns out two of our other developers are also seeing this behavior.

HFS+ (the filesystem used by OSX) is case insensitive unless you
toggle some magic switch, so git set core.ignorecase to true on clone
(the config manpage claims its done on init or clone, in any case)
which makes it assume that Cloudsponge.php and CloudSponge.php are the
same file (which in a case-insensitive filesystem is true).

If you want to use OSX to develop this project, you'll have to either
rename one of those files or set your filesystem to be case-sensitive
(and unset core.ignorecase afterwards). From what I've heard, the OS
itself will work fine with a case-sensitive filesystem, but not all
applications might. YMMV.

   cmn


--eJnRUKwClWJh1Khz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO3++TAAoJEHKRP1jG7ZzTFskH/i3xjMgUXhu5t39S5tY2CbYw
jZE1g67qHh0zwTelt8sONe1z5XlBoGWOuVXkdPtzNEGcEgKO8kCiXQTmLgowPWGc
iUnfbDKlWfKN/YoB47KNkytzrsQPeWm9hhEUQESyp6I5bevkdCoATM761NHtZO8K
ti8SVPyeC1KUAsMFzBVTlgd2NzzaOJY/t8bUDEalY3WVBGGGbSbg6rw9JSmEMu/s
X9yF5xDy8nop4YCQIHF2hklhJdP7YMH1wqUoHVv17GbJFlZvjWoO3Yfr1VVml8qW
67NsTgOcwtCRl6Y7ZrvSkeU7SAdvw+CKUqZVwRvuzYuQmibXbY60s0sQSt/qZ54=
=F/2G
-----END PGP SIGNATURE-----

--eJnRUKwClWJh1Khz--
