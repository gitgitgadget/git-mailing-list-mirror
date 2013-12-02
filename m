From: =?UTF-8?B?TWF0xJtqIENlcGw=?= <mcepl@redhat.com>
Subject: Re: git-svn troubles with calendarserver SVN repo
Date: Mon, 02 Dec 2013 07:03:11 +0100
Message-ID: <529C229F.2030504@redhat.com>
References: <52991FE0.6040503@redhat.com> <CAH3Anro=vM2JLLZhdJ4nnO3qLhw4yV2JFT8EwC3jcbbGrj4H=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="XQ7xqdmwDQsMlbiqnBBEjnx5hhcqaKXnl"
Cc: Git Mailing List <git@vger.kernel.org>
To: Jon Seymour <jon.seymour@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 02 07:03:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VnMbI-00063C-Fl
	for gcvg-git-2@plane.gmane.org; Mon, 02 Dec 2013 07:03:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752897Ab3LBGDQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Dec 2013 01:03:16 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35872 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752491Ab3LBGDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Dec 2013 01:03:16 -0500
Received: from int-mx02.intmail.prod.int.phx2.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id rB263D6x009516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 2 Dec 2013 01:03:13 -0500
Received: from wycliff.ceplovi.cz (ovpn-116-30.ams2.redhat.com [10.36.116.30])
	by int-mx02.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id rB263DiV003953;
	Mon, 2 Dec 2013 01:03:13 -0500
Received: from wycliff.ceplovi.cz (wycliff.ceplovi.cz [127.0.0.1])
	by wycliff.ceplovi.cz (Postfix) with ESMTP id 4F22F40CCC;
	Mon,  2 Dec 2013 07:03:12 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:27.0) Gecko/20100101 Thunderbird/27.0a2
In-Reply-To: <CAH3Anro=vM2JLLZhdJ4nnO3qLhw4yV2JFT8EwC3jcbbGrj4H=g@mail.gmail.com>
X-Enigmail-Version: 1.6
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238611>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XQ7xqdmwDQsMlbiqnBBEjnx5hhcqaKXnl
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 30/11/13 09:54, Jon Seymour wrote:
> I have seen this behaviour, though never determined the root cause
> .Probably the simplest thing you can do without access to the server
> is to put your git svn fetch into a bash while loop, like so:
>=20
> while ! git svn fetch; do :; done;

Of course, I did this, but still I wonder how much is the resulting git
repository http://luther.ceplovi.cz/git/CalendarServer.git/ faithful
representation of the original SVN one http://trac.calendarserver.org/.
Would not be something missing?

Best,

Mat=C4=9Bj

--=20
http://www.ceplovi.cz/matej/, Jabber: mcepl@ceplovi.cz
GPG Finger: 89EF 4BC6 288A BF43 1BAB  25C3 E09F EF25 D964 84AC

They that can give up essential liberty to obtain a little
temporary safety deserve neither liberty nor safety.
    -- Benjamin Franklin, Historical Review
       of Pennsylvania, 1759.


--XQ7xqdmwDQsMlbiqnBBEjnx5hhcqaKXnl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iD8DBQFSnCKf4J/vJdlkhKwRAkqmAKCA2EL3s5wYArA9jtjF2L2Z85ZrhACbB2l9
hFV/c3OMNh3zGjOSQIvlfOo=
=SvD4
-----END PGP SIGNATURE-----

--XQ7xqdmwDQsMlbiqnBBEjnx5hhcqaKXnl--
