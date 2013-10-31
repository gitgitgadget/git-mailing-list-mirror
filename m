From: Max Horn <max@quendi.de>
Subject: Re: [PATCH 00/16] Trivial patches
Date: Thu, 31 Oct 2013 19:03:27 +0100
Message-ID: <87E9F831-E3BB-43AE-BC9F-C32C46908CBB@quendi.de>
References: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_B3F12AE2-5AF9-44EF-9159-EA877858AEFC"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 31 19:03:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbwan-0001Tk-7r
	for gcvg-git-2@plane.gmane.org; Thu, 31 Oct 2013 19:03:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754378Ab3JaSDd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Oct 2013 14:03:33 -0400
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:52535 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754209Ab3JaSDd (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 31 Oct 2013 14:03:33 -0400
Received: from fb07-alg-gast1.math.uni-giessen.de ([134.176.24.161]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1Vbwah-00042L-5C; Thu, 31 Oct 2013 19:03:31 +0100
In-Reply-To: <1383211547-9145-1-git-send-email-felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1383242612;1209c060;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237135>


--Apple-Mail=_B3F12AE2-5AF9-44EF-9159-EA877858AEFC
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 31.10.2013, at 10:25, Felipe Contreras <felipe.contreras@gmail.com> =
wrote:

> Most of these have been sent before, but were not applied for one =
reason or
> another.

All of these look fine and sensible to me. Some of the latter patches in =
the series might be a bit subjective (e.g. I personally don't mind =
"yoda" conditions at all), but none do harm, and most are a clear =
improvement. So I am all for applying this.

Cheers,
Max

>=20
> Felipe Contreras (16):
>  merge: simplify ff-only option
>  t: replace pulls with merges
>  pull: cleanup documentation
>  fetch: add missing documentation
>  revision: add missing include
>  shortlog: add missing declaration
>  branch: trivial style fix
>  sha1-name: trivial style cleanup
>  transport-helper: trivial style fix
>  describe: trivial style fixes
>  pretty: trivial style fix
>  revision: trivial style fixes
>  diff: trivial style fix
>  run-command: trivial style fixes
>  setup: trivial style fixes
>  add: avoid yoda conditions
>=20
> Documentation/git-fetch.txt            |  3 +++
> Documentation/git-pull.txt             |  4 ++--
> builtin/add.c                          |  2 +-
> builtin/branch.c                       |  3 +--
> builtin/describe.c                     |  7 +++----
> builtin/diff.c                         |  2 +-
> builtin/merge.c                        | 11 ++---------
> pretty.c                               |  2 +-
> revision.c                             | 14 ++++++--------
> revision.h                             |  1 +
> run-command.c                          | 13 +++++--------
> setup.c                                |  4 ++--
> sha1_name.c                            |  1 -
> shortlog.h                             |  2 ++
> t/annotate-tests.sh                    |  2 +-
> t/t4200-rerere.sh                      |  2 +-
> t/t9114-git-svn-dcommit-merge.sh       |  2 +-
> t/t9500-gitweb-standalone-no-errors.sh |  2 +-
> transport-helper.c                     |  1 +
> 19 files changed, 35 insertions(+), 43 deletions(-)
>=20
> --=20
> 1.8.4.2+fc1
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20


--Apple-Mail=_B3F12AE2-5AF9-44EF-9159-EA877858AEFC
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlJym3IACgkQIpJVslrhe1laqwEAtQ/hZOGjri9XZ9kIJnZ5ntJ4
SMGJoYL3FiwMTdYoBaYA+gIqLFaLVrecXWpyi98JoqCs9wmk6wo/VCLMKGCRQBFF
=s+Sb
-----END PGP SIGNATURE-----

--Apple-Mail=_B3F12AE2-5AF9-44EF-9159-EA877858AEFC--
