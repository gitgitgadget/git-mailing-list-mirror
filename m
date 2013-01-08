From: "W. Trevor King" <wking@tremily.us>
Subject: [PATCH] remote-hg: Fix biridectionality -> bidirectionality typos
Date: Tue, 08 Jan 2013 10:47:37 -0500
Message-ID: <20130108154737.GA4662@odin.tremily.us>
References: <1351995218-19889-1-git-send-email-felipe.contreras@gmail.com>
 <1351995218-19889-8-git-send-email-felipe.contreras@gmail.com>
 <20121128202320.GA22522@odin.tremily.us>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary=qMm9M+Fa2AknHoGS
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Michael J Gruber <git@drmicha.warpmail.net>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 08 16:48:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TsbPP-0006XI-Oy
	for gcvg-git-2@plane.gmane.org; Tue, 08 Jan 2013 16:48:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756707Ab3AHPrv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2013 10:47:51 -0500
Received: from vms173015pub.verizon.net ([206.46.173.15]:39342 "EHLO
	vms173015pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756683Ab3AHPru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2013 10:47:50 -0500
Received: from odin.tremily.us ([unknown] [72.68.82.220])
 by vms173015.mailsrvcs.net
 (Sun Java(tm) System Messaging Server 7u2-7.02 32bit (built Apr 16 2009))
 with ESMTPA id <0MGB00KLSD7ER570@vms173015.mailsrvcs.net> for
 git@vger.kernel.org; Tue, 08 Jan 2013 09:47:40 -0600 (CST)
Received: by odin.tremily.us (Postfix, from userid 1000)	id 0DF2A77F267; Tue,
 08 Jan 2013 10:47:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tremily.us; s=odin;
	t=1357660058; bh=vGH2lnvL5CCiY6IPE1FKQs91q8UfegfWl5bD59ihpIE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oX7IueEqHFrR5QksTmoBKZvdkpk1cS/8envdk2TV8wXi1gYUEuriGIFwQS3qvMHBI
 qwbP2bq0Q9OjxIlvm+MHittHygLqRWY44MqU3HJM8G6gW5cLrHxbiX2BN/7tG797Es
 71yTOsGWkxCLmT9xa0ZIOF2/w6OMhn2nBaNKeYSE=
Content-disposition: inline
In-reply-to: <20121128202320.GA22522@odin.tremily.us>
OpenPGP: id=39A2F3FA2AB17E5D8764F388FC29BDCDF15F5BE8;
 url=http://tremily.us/pubkey.txt
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212970>


--qMm9M+Fa2AknHoGS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Signed-off-by: W. Trevor King <wking@tremily.us>
---

I was looking for one of my older messages to the Git list, and I
found this, which seems to have fallen through the cracks:

On Wed, Nov 28, 2012 at 03:23:20PM -0500, W. Trevor King wrote:
> I'm not sure if this is the most recent patch iteration for this
> feature, but I just saw this typo in `pu`.
>=20
> On Sun, Nov 04, 2012 at 03:13:29AM +0100, Felipe Contreras wrote:
> > +# Commits are modified to preserve hg information and allow biridectio=
nality.
>                                                                ^^^^^^^^
> s/biridectionality/bidirectionality/

This fixes that instance (which has since landed in master) and
another similar typo.

 contrib/remote-helpers/git-remote-hg   | 2 +-
 contrib/remote-helpers/test-hg-bidi.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/=
git-remote-hg
index 016cdad..c700600 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -31,7 +31,7 @@ import urllib
 # hg:
 # Emulate hg-git.
 # Only hg bookmarks are exported as git branches.
-# Commits are modified to preserve hg information and allow biridectionali=
ty.
+# Commits are modified to preserve hg information and allow bidirectionali=
ty.
 #
=20
 NAME_RE =3D re.compile('^([^<>]+)')
diff --git a/contrib/remote-helpers/test-hg-bidi.sh b/contrib/remote-helper=
s/test-hg-bidi.sh
index a94eb28..1d61982 100755
--- a/contrib/remote-helpers/test-hg-bidi.sh
+++ b/contrib/remote-helpers/test-hg-bidi.sh
@@ -6,7 +6,7 @@
 # https://bitbucket.org/durin42/hg-git/src
 #
=20
-test_description=3D'Test biridectionality of remote-hg'
+test_description=3D'Test bidirectionality of remote-hg'
=20
 . ./test-lib.sh
=20
--=20
1.8.1.151.g32238ae

--qMm9M+Fa2AknHoGS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQ7D+YAAoJEEUbTsx0l5OM+14QAL0Ce6u7JqpLgpK+Citbhsba
UIHPxnOxYSn5bdtf52SiGTtibWuJdvOKY9Yin+Hz6Zl3ESe2IwRFpUoHU/uogsru
zLrSkKM7OZM0E4Gp43BZ9n2Iqjb8nxyckmeVyeFHEpsVXfEaTHJKYY2Dmc025I+a
88OWka6rzJs+3Q/WVL8yngviVlPA/4MlPrxEhcBmAPeguss1IdHfx6cPtHL5OYeb
3lN+8aWc+lRvNmW5i6lwlIzMijp4Os4k16kYapGhYoIgGBT3EJ9T18Tn5SgoAcou
FFyIDTDQqcVG1YkJbFy81oMe/jLt1/d+R/HC3AqxQ3l9exEsPunnzcCHym+qeuzs
IR0jDSLFrxvHl2zyDoOUwrkpiwSDbYcEXSvowi9f5oLHkdchD/e/YvvFucD8yWzQ
Znm2Du2aUCNYH/5K+EqHBJY5FsCEoncWA6oODN/BTV+1gLzVvvuIJ1gXFG0O1VEu
YGO74sBkO9LtUex3QlhByocxJbiZQWZxLHKkKlHX3IlA1rN/Be8h2PUVlH9n7Fp4
BnoM6JSl/LAwLcDv73IO+qrSWw1+yC5VYJcFx6VDxdvOjb5jE8KEbBIgmkaISheu
DE7IONZ04G1owXygUCmsQ0p9N4MhqO75pyofu5hCmL0R4ynEWKEkUURnx9w3Fwv3
Ub8n67IVjFOVDymeUPPL
=IImD
-----END PGP SIGNATURE-----

--qMm9M+Fa2AknHoGS--
