From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: Re: cvsimport using proxy?
Date: Wed, 5 Oct 2005 14:50:55 +0200
Message-ID: <20051005125055.GF4682@kiste.smurf.noris.de>
References: <7v4q7xc62d.fsf@assigned-by-dhcp.cox.net> <46a038f90510050309t1d075d7fj37c60a6052ec62f3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jL2BoiuKMElzg3CS"
Cc: Junio C Hamano <junkio@cox.net>,
	Martin Langhoff <martin@ng.eduforge.org>,
	Sven Verdoolaege <skimo@kotnet.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 05 14:53:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EN8lI-0000HI-8f
	for gcvg-git@gmane.org; Wed, 05 Oct 2005 14:52:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965157AbVJEMwl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Oct 2005 08:52:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965156AbVJEMwl
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Oct 2005 08:52:41 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:37021 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S965157AbVJEMwk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2005 08:52:40 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1EN8jY-0008IG-5h; Wed, 05 Oct 2005 14:51:14 +0200
Received: (nullmailer pid 25146 invoked by uid 501);
	Wed, 05 Oct 2005 12:50:55 -0000
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510050309t1d075d7fj37c60a6052ec62f3@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-Smurf-Spam-Score: -2.6 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9705>


--jL2BoiuKMElzg3CS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Martin Langhoff:
> For the second stage, we'll need to hack CVSConn::conn() method around
> line 118. As I have never used the proxy option, I did a bit of
> googling. It seems that cvs 1.12.11 knows how to tunnel its protocol
> over an HTTP proxy.
>=20
HTTP proxies are quite simple, you say=20

   1. Connect to Proxy Server.
   2. Issue CONNECT Host:Port HTTP/1.1<CR><LF>.
   3. Issue <CR><LF>.
   4. Wait for a line of response.
      If it contains HTTP/1.X 200 , the connection is successful.
   5. Read further lines of response until you receive an empty line.
   6. Now, you are connected to outside world through a proxy.
      Do any data exchange you want.

--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Almost all absurdity of conduct arises from the imitation of those who we
cannot resemble.
					-- Samuel Johnson

--jL2BoiuKMElzg3CS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFDQ8wv8+hUANcKr/kRAv7bAJ9dAWX/ASp5QNoEftJW9oq/fsU3hQCdHakq
hFvO4hVgACJT8bas7VhdSKs=
=2llx
-----END PGP SIGNATURE-----

--jL2BoiuKMElzg3CS--
