From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 19:47:19 +0200
Message-ID: <20070604174719.GH16637@admingilde.org>
References: <20070603223727.GA16637@admingilde.org> <20070604053443.GA15148@moooo.ath.cx> <20070604072707.GE16637@admingilde.org> <Pine.LNX.4.64.0706041657210.4046@racer.site>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="cW+P/jduATWpL925"
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 04 19:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvGeh-0000Kc-Kn
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 19:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753483AbXFDRrW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 13:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754159AbXFDRrW
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 13:47:22 -0400
Received: from mail.admingilde.org ([213.95.32.147]:35675 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753483AbXFDRrV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 13:47:21 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1HvGeF-00080W-UM; Mon, 04 Jun 2007 19:47:19 +0200
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0706041657210.4046@racer.site>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49118>


--cW+P/jduATWpL925
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Mon, Jun 04, 2007 at 04:57:35PM +0100, Johannes Schindelin wrote:
> I actually would like it more if the calling program did the interpolatio=
n=20
> itself.

That's another possibility, perhaps along the line of git_config_int.

> So, for example if you want a script to access whatever.my.url, and want=
=20
> to allow to interpolate any environment variable, why not
>=20
> 	url=3D$(eval $(git config whatever.my.url))

Well, complete shell syntax does too much: it also supports $() and
friends.

> I am just hesitant to change the existing behaviour, and possibly=20
> introduce weird breakages. (There could even be some unwanted env leakage=
s=20
> in programs like gitweb...)

exactly.

So should we simply update semantics of config variables to not require
any environment variables?

--=20
Martin Waitz

--cW+P/jduATWpL925
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGZFAnj/Eaxd/oD7IRAuV9AJ9WMDAjzbJOP+0RwUKhNmGIFUcbGwCeL4YS
2DcoInidvEhjUyEiUaW76wU=
=712I
-----END PGP SIGNATURE-----

--cW+P/jduATWpL925--
