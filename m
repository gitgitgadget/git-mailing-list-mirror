From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 09 Feb 2012 17:06:41 +0100
Message-ID: <1328803601.3416.0.camel@centaur.lab.cmartin.tk>
References: <20120209095415.GA19230@glitch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-iBmLb3j9XHdvd1zA+/mT"
Cc: git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 17:07:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvWWY-00057v-FE
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 17:07:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073Ab2BIQGu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 11:06:50 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:41148 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758071Ab2BIQGs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 11:06:48 -0500
Received: from [192.168.1.17] (brln-4db9d88c.pool.mediaWays.net [77.185.216.140])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id A090546081;
	Thu,  9 Feb 2012 17:06:39 +0100 (CET)
In-Reply-To: <20120209095415.GA19230@glitch>
X-Mailer: Evolution 3.2.2-1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190294>


--=-iBmLb3j9XHdvd1zA+/mT
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2012-02-09 at 10:54 +0100, Domenico Andreoli wrote:
> Hi,
>=20
>   with the recent changes in tag merging (I updated git to 1.7.9),
> my usual "git merge v3.X-rcY" command does not fast-forward any more.
> Of course the initial head is something like "v3.X-rcZ" without any
> change so that it should (and usually did) fast-forward to the new head.
>=20
> The editor is instead fired off and I have to fill the details of a
> merge commit, diverging from mainline as soon as I save and exit.
>=20
> Is there any simple and clear explanation for this? Thank you.
>=20
> cheers,
> Domenico
>=20
> ps: I admit I didn't follow the details about tag signatures so probably
> I missed something that I shouldn't.

This was discussed recently

http://thread.gmane.org/gmane.comp.version-control.git/189825



--=-iBmLb3j9XHdvd1zA+/mT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJPM+8RAAoJEHKRP1jG7ZzTmJ0H/ij6r0KsN0gECz2sijj75S9h
wJP17MrIwdIQmzGjM3AbW6RZrEmXzn3hIxQuHISwk30hhDUmo95A3vAZVzQ5F0Lg
E96AedV+FP/WJd6zGejwu8dox/0K2MYlQlRp6oS+C6gpRdN6GEmFbMYgTpxdFKXU
I4cVxYkkSKpFYq5UXTL3daYDyoHfxfjBNRAVHL+eD++tTbY1/8F5QpFRf3zw70Z6
jHaQOjeHXBUZYms09i/SM0mbRxacBHQaaVtR0hPiTZJv4aF8Gx5AxGNgRRw4vWwO
7oiJr2ITt5/jm/U74GP0KlZ0f0d0/LYEURez40wiL1WBzV+O31olCjpedEwtut4=
=kF3A
-----END PGP SIGNATURE-----

--=-iBmLb3j9XHdvd1zA+/mT--
