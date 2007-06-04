From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] Support environment variables in config file
Date: Mon, 4 Jun 2007 09:27:07 +0200
Message-ID: <20070604072707.GE16637@admingilde.org>
References: <20070603223727.GA16637@admingilde.org> <20070604053443.GA15148@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="X3gaHHMYHkYqP6yf"
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Jun 04 09:27:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hv6yE-0004Ox-79
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 09:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751413AbXFDH1J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 03:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751912AbXFDH1J
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 03:27:09 -0400
Received: from mail.admingilde.org ([213.95.32.147]:38522 "EHLO
	mail.admingilde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbXFDH1I (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 03:27:08 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1Hv6y3-0006SH-ND; Mon, 04 Jun 2007 09:27:07 +0200
Content-Disposition: inline
In-Reply-To: <20070604053443.GA15148@moooo.ath.cx>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49074>


--X3gaHHMYHkYqP6yf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

thanks for the review!

Do you think the approach is ok?
Can you see other examples where we may need $VAR support?
Or would everybody be happy with support for ~/ in filenames?

On Mon, Jun 04, 2007 at 07:34:43AM +0200, Matthias Lederhofer wrote:
> Martin Waitz <tali@admingilde.org> wrote:
> > Environment variables (e.g. $HOME) can be helpful for the GIT configura=
tion.
> > With this change you can use them with the normal shell "$" syntax.
> > If you want to insert a plain "$" in a variable, it can be escaped as \$
> > or put inside quotes (").
>=20
> Perhaps we should also allow variable interpolation in double quoted
> strings as this is quite common in various languages.

I thought about that too.  I guess I first will have to do a patch
which adds single quote (') support.

> We could have a short example here how to concatenate a variable and a
> string without a space in between.  I came up with '$FOO""bar' which
> is not that obvious imo.

yes, shell-like ${FOO} would be nicer but I don't know if it is that
important.  Perhaps your example $FOO"bar".

> You should allow at least underscores in environment variables too.

right

> If you use the HOME environment variable without setting it yourself
> you should place quotes around the $(..) in case there is a space in
> $HOME:

stupid error, yes.

--=20
Martin Waitz

--X3gaHHMYHkYqP6yf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFGY77Lj/Eaxd/oD7IRAjOvAJ4yeZJjf1PaD17XkGJto/BkB14ZmgCfQ6ms
oaFzJNVWbRZancZi4n6B1so=
=GBsC
-----END PGP SIGNATURE-----

--X3gaHHMYHkYqP6yf--
