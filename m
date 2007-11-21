From: Jan Hudec <bulb@ucw.cz>
Subject: Re: Git in a Nutshell guide
Date: Wed, 21 Nov 2007 20:45:07 +0100
Message-ID: <20071121194507.GA3569@efreet.light.src>
References: <1195477504.8093.15.camel@localhost> <fhsc7b$k4g$1@ger.gmane.org> <1195488877.10573.29.camel@localhost> <3057F6F3-BEAA-447A-AB79-A0AFB7DB8826@lrde.epita.fr> <fhvs95$5qk$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="17pEHd4RhPHOinZp"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:45:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuvW0-0008LJ-My
	for gcvg-git-2@gmane.org; Wed, 21 Nov 2007 20:45:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753564AbXKUTpW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2007 14:45:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753497AbXKUTpW
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Nov 2007 14:45:22 -0500
Received: from ns1.bluetone.cz ([212.158.128.13]:36024 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbXKUTpU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2007 14:45:20 -0500
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 47EEA76E0E;
	Wed, 21 Nov 2007 20:45:17 +0100 (CET)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id ZZQHf+9WXrr9; Wed, 21 Nov 2007 20:45:12 +0100 (CET)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id AE6615736F;
	Wed, 21 Nov 2007 20:45:11 +0100 (CET)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IuvVT-0002jc-L0; Wed, 21 Nov 2007 20:45:07 +0100
Content-Disposition: inline
In-Reply-To: <fhvs95$5qk$1@ger.gmane.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65694>


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 21, 2007 at 00:57:28 +0100, Jakub Narebski wrote:
> I think that writing proper "Git Guide" aka "The Git Book" is hard because
> of some things:
>=20
>  1. Git has many useful advanced features. Describing those advanced
>     features is not easy. For example git uses multiple branches in single
>     repository paradigm freely, which makes learning curve a bit steeper;
>     IIRC hgbook describes one branch per repos situation (at least at
>     beginning), which is easier.

I think I saw the "sharp curve" and "double sharp curve" paragraphs in other
places besides the the TeXbook. I even have an impression (without actually
looking) that it was documentation of some version control system.

That deals with difficult to read, but it does make it more difficult to
write.

>  2. Git has some historical cruft, including the fact that it began as
>     series of low level tools (plumbing) and became proper SCM (acquired
>     proper porcelain) later, what can be even now seen in documentation...

Most plumbing can be safely ignored through most of the book or covered by
those "double sharp curve" paragraphs. It unfortunately does make it harder
to write, because the author has to consider what to cover and what to hide.

>  3. Explanation of some features (like object model) would be much easier
>     with some graphics (diagrams etc.), but chosen documentation format,
>     AsciiDoc, doesn't make it easy...

I dare to disagree here. Asciidoc supports generating image tags for
respective output formats and it really does not look hard. We could have
PNGs and if we wanted higher press quality even SVG or EPS and convert them
to PNGs for the HTML version (and use EPS for latex output).

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--17pEHd4RhPHOinZp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHRIrDRel1vVwhjGURAiONAKDgGKcvL3PvRx4c6d2DYMUuxEevYQCglv/i
Y0kNlGcjDOJdXue+YOO6zVE=
=JbI0
-----END PGP SIGNATURE-----

--17pEHd4RhPHOinZp--
