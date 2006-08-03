From: Martin Waitz <tali@admingilde.org>
Subject: Re: [PATCH] gitweb.cgi: Customization
Date: Thu, 3 Aug 2006 08:58:52 +0200
Message-ID: <20060803065852.GH16364@admingilde.org>
References: <20060801225352.26998.qmail@web31801.mail.mud.yahoo.com> <7v8xm8xbaa.fsf@assigned-by-dhcp.cox.net> <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Cc: Junio C Hamano <junkio@cox.net>, Luben Tuikov <ltuikov@yahoo.com>,
	git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Thu Aug 03 09:17:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8XAZ-0001fL-Ke
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 08:58:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932320AbWHCG6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 02:58:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932337AbWHCG6y
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 02:58:54 -0400
Received: from admingilde.org ([213.95.32.146]:40627 "EHLO mail.admingilde.org")
	by vger.kernel.org with ESMTP id S932320AbWHCG6y (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 02:58:54 -0400
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1)
	id 1G8XAS-0000aK-NV; Thu, 03 Aug 2006 08:58:52 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90608011913t777cf20dh9baaf355b19d18e6@mail.gmail.com>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24706>


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Wed, Aug 02, 2006 at 02:13:51PM +1200, Martin Langhoff wrote:
> On 8/2/06, Junio C Hamano <junkio@cox.net> wrote:
> >I do not think there is much difference between any of the
> >customization proposed so far (yours, Martin's and the one from
> >Matthias Lederhofer) from functionality and ease-of-use point of
> >view.  They all try to make customization can be done in one
> >place, and the difference is mostly of taste, so I'd just pick
> >one from Martin
>=20
> I'm a bit lost as to gitweb config. Are we not relying on %ENV for
> this stuff? Apache's facilities to configure CGIs via ENV are really
> powerful. You can do conditionals in apache config files, lock stuff
> down in httpd.conf, override it with files in conf.d, and
> allow/disallow overrides in .htaccess ...

we could make the default use %ENV.

Something like (in Makefile):

GITWEB_SITENAME =3D $$ENV{GITWEB_SITENAME}
GITWEB_PROJECTROOT =3D $$ENV{GITWEB_SITENAME} || "/pub/git"
=2E..

and then change gitweb to not put the expanded config values into
quotes. So:

our $projectroot =3D @@GITWEB_PROJECTROOT@@;


This approach would allow both built-time or run-time configuration of
gitweb.

--=20
Martin Waitz

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFE0Z6sj/Eaxd/oD7IRAm0bAJ9rGbzApTJimjbmA2EKBtWzattMDwCeN1OR
U6NVDvYOBRHoWv1OFoPZYK8=
=wB+I
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
