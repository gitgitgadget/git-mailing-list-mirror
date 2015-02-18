From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: Interested in helping open source friends on HP-UX?
Date: Wed, 18 Feb 2015 20:22:44 +0100
Message-ID: <20150218202244.61f0dbe4@pc09.procura.nl>
References: <xmqq4mt2fx2m.fsf@gitster.dls.corp.google.com>
	<20150218170007.784be6aa@pc09.procura.nl>
	<54E4CFDC.40401@drmicha.warpmail.net>
	<20150218182547.GA6346@peff.net>
	<xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 boundary="Sig_/FeDG5ofWju/a5NgUcc26Xa1"; protocol="application/pgp-signature"
Cc: Jeff King <peff@peff.net>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 18 20:23:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOAD6-0004jJ-UP
	for gcvg-git-2@plane.gmane.org; Wed, 18 Feb 2015 20:23:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753017AbbBRTW5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2015 14:22:57 -0500
Received: from lb2-smtp-cloud3.xs4all.net ([194.109.24.26]:54651 "EHLO
	lb2-smtp-cloud3.xs4all.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752728AbbBRTW4 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Feb 2015 14:22:56 -0500
Received: from pc09.procura.nl ([82.95.216.30])
	by smtp-cloud3.xs4all.net with ESMTP
	id tvNt1p0080fvp4J01vNuKz; Wed, 18 Feb 2015 20:22:55 +0100
In-Reply-To: <xmqqpp972h1n.fsf@gitster.dls.corp.google.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264052>

--Sig_/FeDG5ofWju/a5NgUcc26Xa1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 18 Feb 2015 10:47:16 -0800, Junio C Hamano <gitster@pobox.com>
wrote:

> Jeff King <peff@peff.net> writes:
>=20
> > On Wed, Feb 18, 2015 at 06:46:04PM +0100, Michael J Gruber wrote:
> >
> >> Well, how can we help if we don't even know the limitations of that
> >> platform?
> >
> > I'm not sure, but I think the original call for help may have been "I
> > will give you shell access to these boxes if you want to play around".
>=20
> Yeah, that probably was my bad---I didn't make it clear enough that the
> request for volunteer from H.Merijn was exactly that.

Plus some possible help in how HP-UX is organized plus maybe install
more developer tools on request.

> > It seems like we could use
> >
> >   (cd src && tar cf - .) | (cd dst && tar xf -)
> >
> > here as a more portable alternative. I don't think we can rely on rsync
> > being everywhere.
>=20
> Thanks; I wasn't even aware that we used rsync in our tests.  We
> certainly do not want to rely on it.

You don't. It was a quick hack from me to see if this was the only
cause of failure for that test

> Why not "cp -r src dst", though?


--=20
H.Merijn Brand  http://tux.nl   Perl Monger  http://amsterdam.pm.org/
using perl5.00307 .. 5.21   porting perl5 on HP-UX, AIX, and openSUSE
http://mirrors.develooper.com/hpux/        http://www.test-smoke.org/
http://qa.perl.org   http://www.goldmark.org/jeff/stupid-disclaimers/

--Sig_/FeDG5ofWju/a5NgUcc26Xa1
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJU5OaNAAoJEAOhR6E+XcCYOTsIALqw2K3KL4QnwdIT5n6NG/mV
L4OLInQ1uqhU7XrH++Lvj6ogGLEgHMmmCSZ8+mSFfHjgXqGshCGO41egx5kHmOLj
7gUfoH9jUjpmEVU1kM8IlmWiKt6bDLycOvlEHtSFHa6aEg9/xcQoISnVEd4hptJS
KPKxGZ4vpb2dAFtpWhzTvoruxEKUcU2ujgtLufa9FIYTyO30wSrdbatIcpykj08T
Aonnd90yfdyjlh7IhN01qjEp6MP9lHyNwfpyFasmL0VXtSvd1VUeptsFTt24RBDE
Qzf92WEnezspqpcaWoAfpgAeFaleWoYyeW0nE01gYMxD6uejllEDSw33QHwnMNI=
=IYCT
-----END PGP SIGNATURE-----

--Sig_/FeDG5ofWju/a5NgUcc26Xa1--
