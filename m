From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Fri, 20 Feb 2015 12:24:07 +0100
Message-ID: <20150220122407.4183490b@pc09.procura.nl>
References: <20150218182547.GA6346@peff.net>
	<xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
	<20150218185734.GB7257@peff.net>
	<54E5BBDD.7040100@drmicha.warpmail.net>
	<20150219121438.59050ce8@pc09.procura.nl>
	<54E5C6E2.9040101@drmicha.warpmail.net>
	<20150219125433.GA1591@peff.net>
	<54E5E347.4070401@drmicha.warpmail.net>
	<20150220014801.GB16124@peff.net>
	<54E70E2B.8000604@drmicha.warpmail.net>
	<20150220104921.GA2467@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/fFsLsn_Pt3Qb3BGvqn/eJ2q"; protocol="application/pgp-signature"
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 20 12:24:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOlgy-0001mA-Vv
	for gcvg-git-2@plane.gmane.org; Fri, 20 Feb 2015 12:24:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbbBTLYR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Feb 2015 06:24:17 -0500
Received: from lb1-smtp-cloud3.xs4all.net ([194.109.24.22]:46301 "EHLO
	lb1-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753899AbbBTLYQ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Feb 2015 06:24:16 -0500
Received: from pc09.procura.nl ([46.144.236.233])
	by smtp-cloud3.xs4all.net with ESMTP
	id ubQB1p00E52pRCE01bQCUx; Fri, 20 Feb 2015 12:24:13 +0100
In-Reply-To: <20150220104921.GA2467@peff.net>
X-Mailer: Claws Mail 3.11.1-78-gf28db0 (GTK+ 2.24.23; x86_64-suse-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264161>

--Sig_/fFsLsn_Pt3Qb3BGvqn/eJ2q
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 20 Feb 2015 05:49:21 -0500, Jeff King <peff@peff.net> wrote:

> On Fri, Feb 20, 2015 at 11:36:27AM +0100, Michael J Gruber wrote:
>=20
> > > It's not quite so bad as you make out. We write the value to the
> > > GIT-BUILD-OPTIONS file during "make", no matter where it comes from, =
and
> > > load that in test-lib.sh. So:
> > >=20
> > >   make NO_ICONV=3DNope
> > >   cd t
> > >   ./t3901-i18n-patch.sh
> > >=20
> > > works just fine (for this and for any of the other options we mark
> > > there).
> >=20
> > It survives a cd, sure...
>=20
> I think the interesting thing is that it survives running `./tXXXX`
> rather than running the test through make.

I always use prove

$ prove -v t1234.sh

> > Now, change your config.mak before the cd and
> > forget the make. Not everyone does
> >=20
> > make -C t t3901-i18n-patch.sh
> >=20
> > Though, having just discovered that shell completion works for that
> > form, too, I may do it more often (and then complain about having to use
> > GIT_TEST_OPTS ;) )
>=20
> Yeah, I never use "make tXXXX" myself. But nor would I expect the tests
> to respect a version of git I had not actually built. E.g., if you build
> with NO_PERL, and then remove NO_PERL from your config.mak but do _not_
> actually run "make", should that work? Ditto for NO_ICONV, for that
> matter. The tests must match the binary, and the best guess we have
> about the binary is the last thing we built.
>=20
> Adding "git --build-options" would give us a better guess (it may not be
> what the user _wanted_ to test, but it is what they _are_ testing).
>=20
> > > I suspect GIT_TEST_INSTALLED is not all that widely used, or somebody
> > > would have complained before. But if we really want to support it, I
> > > think the right thing is to bake GIT-BUILD-OPTIONS into the binary, so
> > > that "git --build-options" dumps it. It might also have value for
> > > debugging and forensics in general.
> >=20
> > Yep, that would be helpful in general. I don't think we should worry
> > about GIT_TEST_INSTALLED too much. Who came up with that feature anyway=
...?
>=20
> Clearly a crazy person. :) I am not saying it is a _bad_ idea. Only that
> the responsibility to make sure the installed version matches the
> current build parameters lies with the user (and for that matter, the
> current set of tests; we add new tests that would fail on old versions,
> and you cannot mix and match).
>=20
> So an alternate explanation than "not widely used" is "all of the users
> of it are responsible individuals who do not make bogus bug reports to
> the list". :)
>=20
> -Peff


--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/fFsLsn_Pt3Qb3BGvqn/eJ2q
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJU5xlbAAoJEAOhR6E+XcCY0mkH/23Bzb1YcwZI7ynRL1Z8q3gm
nDbhr+Rxd4UkeaO1q156pCtbwRnpw/+/6zwlM3SQN+QSJR/q6STptll3ij5rVVE9
hWLOfJJZxLv3cf9Sg2Cf1EqcFO5aR5r+VZ9LSH5uqUsYTMVVOvSqkPTw42oQuZBU
4X2GUuenldrAbwVcCvoGzaOlSEW3Zx//Uul8cdAT/lxd4QSLUIZVO+QTnpPG27nX
TAlNW+ifZ8q89UZPyNh+RLnu/3BWQkmDoHgpDa3ZyzngJJ+51aP75SsgaeMQCn9C
VB73fGSuB4HLv3LVcMPnAZASrse9DcyZlp2B3AOgdE+WUKDeEkaTKQESij5EaYs=
=3MD6
-----END PGP SIGNATURE-----

--Sig_/fFsLsn_Pt3Qb3BGvqn/eJ2q--
