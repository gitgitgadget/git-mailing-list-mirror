From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Thu, 19 Feb 2015 12:14:38 +0100
Message-ID: <20150219121438.59050ce8@pc09.procura.nl>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
	<20150218170007.784be6aa@pc09.procura.nl>
	<54E4CFDC.40401@drmicha.warpmail.net>
	<20150218182547.GA6346@peff.net>
	<xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
	<20150218185734.GB7257@peff.net>
	<54E5BBDD.7040100@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/Zu_kfAyEenu/h3ccKjjkkY4"; protocol="application/pgp-signature"
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 12:15:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOP4c-0003Nr-VC
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 12:15:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753145AbbBSLPI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Feb 2015 06:15:08 -0500
Received: from lb2-smtp-cloud6.xs4all.net ([194.109.24.28]:39722 "EHLO
	lb2-smtp-cloud6.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752559AbbBSLPF (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Feb 2015 06:15:05 -0500
Received: from pc09.procura.nl ([82.95.216.30])
	by smtp-cloud6.xs4all.net with ESMTP
	id uBF31p00A0fvp4J01BF4Jt; Thu, 19 Feb 2015 12:15:04 +0100
In-Reply-To: <54E5BBDD.7040100@drmicha.warpmail.net>
X-Mailer: Claws Mail 3.11.1-76-gc8fc78 (GTK+ 2.24.23; x86_64-suse-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264092>

--Sig_/Zu_kfAyEenu/h3ccKjjkkY4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Feb 2015 11:33:01 +0100, Michael J Gruber
<git@drmicha.warpmail.net> wrote:

> Jeff King venit, vidit, dixit 18.02.2015 19:57:
> > On Wed, Feb 18, 2015 at 10:47:16AM -0800, Junio C Hamano wrote:
> >=20
> >>> It seems like we could use
> >>>
> >>>   (cd src && tar cf - .) | (cd dst && tar xf -)
> >>>
> >>> here as a more portable alternative. I don't think we can rely on rsy=
nc
> >>> being everywhere.
> >>
> >> Thanks; I wasn't even aware that we used rsync in our tests.  We
> >> certainly do not want to rely on it.
> >=20
> > I don't think we do.
> >=20
> > Grepping for rsync in t/, it is mentioned in three places:
> >=20
> >   1. In t1509, we use it, but that test script does not run unless you
> >      set a bunch of environment variables to enable it.
> >=20
> >   2. In a sample patch for t4100. Obviously this one doesn't execute. :)
> >=20
> >   3. In t5500, to test "rsync:" protocol supported. This is behind a
> >      check that we can run rsync at all (though it does not properly use
> >      prereqs or use the normal "skip" procedure).
> >=20
> >> Why not "cp -r src dst", though?
> >=20
> > I was assuming that the "-P" in the original had some purpose. My "cp
> > -r" does not seem to dereference symlinks, but maybe there is something
> > I am missing.
> >=20
> > -Peff
>=20
> There's a symlink in sub that needs to be preserved.
>=20
> I'm cooking up a mini-series covering tar/cp -P so far and hopefully the
> JP encodings later. Do I understand correctly that for Merijin's use

Merijn, no second j. You can also call me Tux, as that is what the perl
people do just because of that :)

> case on HP-UX, we want
>=20
> - as few extra tools (GNU...) as possible for the run time git
> - may get a few more tools installed to run the test

You can require as many GNU tools for testing as you like: I'll install
them. I just need to be sure they are not required runtime. (tar, cp)

> I still don't have a clear picture of the iconv situation: Does your
> iconv library require OLD_ICONV to compile?

No

> Is there a reason you want to disable it?

Yes, if I build a package/depot, and the package depends on iconv, it
is highly likely to fail on the client side after installation, as I do
not control the version of iconv/libiconv installed.

As HP does not have libiconv installed by default, I have experienced
many tools to be unusable after installation because of that dependency.

Another reason is that I built 64bitall, as my CURl and SSL environment
is 64bitall for every other project on these systems (including Oracle
related, which *only* ships 64bit objects on HP-UX) and the OpenSource
repos for HP-UX only ship 32bit software (sad, but true). That implies
that I cannot require libiconv.so to be present on the client side.

I'd like my git to be as standalone as possible

> Failing so many tests with NO_ICONV is certainly not ideal, but I'm not
> sure we should care to protect so many tests with a prerequisite.

How feasible is it to isolate those tests into separate test files that
people that know to not use e.g. Asian can safely ignore them?

> Michael

--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/Zu_kfAyEenu/h3ccKjjkkY4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJU5cWxAAoJEAOhR6E+XcCYTE4H/37VXtm3IjP0lytAs/IKCLyA
1Uckvagq8NqDzA/4BUJF1wtgE+heNDrD/9czO7n70Nxs3bJJomxX4zm/ixZ3Uyvk
x7R9yCeesswxCrg1h6O/y9XtHaUUe5QmZwn2hPtg4g6gxzUp3zpomZ+mV1OL6N5T
0Jfn5FDgPKNQOcD5icH2rAvZfROczw5auI+pu3HxEwFXWszZxBOTJHrIhWLwmL0o
Dcti24v/2L2zR3bhg5Q5LPD99bPZD8WKxkkTaM8zejXRdIGBDy7+FnaywZ4yOOaV
qBa4gGeS+uXD2m2vYKQcNlTuHgkYYw8DR0L+4ddru6gzv7pX8Q4NlqkwGhnSSLg=
=oFOH
-----END PGP SIGNATURE-----

--Sig_/Zu_kfAyEenu/h3ccKjjkkY4--
