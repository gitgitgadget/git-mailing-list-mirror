From: Joey Hess <joey@kitenet.net>
Subject: Re: symlinked working tree gotcha
Date: Mon, 25 Apr 2011 15:09:38 -0400
Message-ID: <20110425190938.GA24744@gnu.kitenet.net>
References: <20110424165825.GA21062@gnu.kitenet.net>
 <7vpqoajiz0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sdtB3X0nJg68CQEu"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 25 21:10:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QERBC-0007tE-QN
	for gcvg-git-2@lo.gmane.org; Mon, 25 Apr 2011 21:10:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758847Ab1DYTKh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2011 15:10:37 -0400
Received: from wren.kitenet.net ([80.68.85.49]:39655 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758203Ab1DYTKh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2011 15:10:37 -0400
Received: from gnu.kitenet.net (dialup-4.154.39.85.Dial1.Atlanta1.Level3.net [4.154.39.85])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 46C9B118294
	for <git@vger.kernel.org>; Mon, 25 Apr 2011 15:10:35 -0400 (EDT)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 707B24AD2E; Mon, 25 Apr 2011 15:09:38 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vpqoajiz0.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172039>


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Junio C Hamano wrote:
> Two 'foo's makes it confusing to read so let's rephrase.
>=20
> Given this structure:
>=20
>     /tmp/foo/
>     /tmp/foo/.git/
>     /tmp/foo/hello
>     /tmp/sym@ -> foo
>=20
> when you refer to /tmp/sym/hello where $(/bin/pwd) is /tmp/foo, should it
> be considered to be within the bounds of the working tree that is governed
> by your current $GIT_DIR (which is ".git")?

Hmm, my /bin/pwd does not return "/tmp/foo" when I've cd'd to "/tmp/sym".

> The answer is "perhaps yes, ideally speaking, but does it really matter in
> practice, or is it just nice to have?".

FWIW, my motivation for using the absolute path was that I wanted to
always add $GIT_WORK_TREE/hello, but the add could be run when in a
subdirectory of the repository, so "git add hello" might not add the
right file.

--=20
see shy jo

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTbXG8ckQ2SIlEuPHAQjAag/+NvFmvWw6ClnW0wBuPJ43JH+KcnGjyaq6
b3fAHo3wpHox+kF/VIaDchPTK1tUTRon92/1H5uvlwnVb64dzxU4+2P98IibtrDR
eyJbc64HBZBUZ7/X1f+NJk4/EHjgMy1tisn75Fg4mqsdnQFR6d5KCbxaN/zOyJVU
Zu+TbE3YI8OvmGzCGR4WVTtlKGLv4fHaK87+0eOsqLc/UAevnQRjXp1qUaelMgA+
tp7QvI3JZjmZB1xpFj8PyF/yyx0hZg1YpeJK2A9cpY5q8a0m5zXxJyPH7FwX4GXh
vjsRr0lJjHudESeaTblCV70LMKgoMSPvmE/f2xyqfPoxhKLXZ8jncps09yW1pkO5
8+lVh0SVDIyG5vRESBvCtHQl+g9OIJtp7LB0tfoeSdadtGE/pHGdhU18JxawW5Cp
0hi6Wv+Xfekt0tStohleD2zKGBsccley1w0tuIFBQVl3Vl81NQYaRLAOBeL2Wiey
wJy4HEMzBO0GALhk/QRvoUVF7YnPYKP1uXaUKypDEQuFb0KiZXB0gUUp0zxX8RuC
Bq6Aan/Q8mZCcFAD9UiiRY30QfWgnlTbf01/M7ljCFUyGsshGyJ02qNdcdBCqzxG
E4YrrgoKlSY9NCmVXQV6o/LHAxuwgU0Aqs6Uqh1waCn3YVs84oPrQUBJm10jAoxz
pk8Tcw1Ey4k=
=D1y2
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--
