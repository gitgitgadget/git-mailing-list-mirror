From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Odd issue - The Diffs That WILL NOT DIE.
Date: Tue, 6 Dec 2011 22:51:03 +0100
Message-ID: <20111206215102.GA3654@centaur.lab.cmartin.tk>
References: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Cc: git@vger.kernel.org
To: Chris Patti <cpatti@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 06 22:51:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RY2uv-0000wB-Bi
	for gcvg-git-2@lo.gmane.org; Tue, 06 Dec 2011 22:51:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839Ab1LFVvH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Dec 2011 16:51:07 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:52580 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752937Ab1LFVvE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Dec 2011 16:51:04 -0500
Received: from centaur.lab.cmartin.tk (brln-4d0c0475.pool.mediaWays.net [77.12.4.117])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id A38AE461AA;
	Tue,  6 Dec 2011 22:51:02 +0100 (CET)
Received: (nullmailer pid 27962 invoked by uid 1000);
	Tue, 06 Dec 2011 21:51:03 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Chris Patti <cpatti@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAJ8P3RBm=RhNf6LKLqprqX6Rqx0OgRnJR+=+-Qhg4PvpeqaUDg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186394>


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2011 at 04:43:50PM -0500, Chris Patti wrote:
> I have a Homebrew installed version if Git 1.7.8 running on OSX Lion.
>=20
> I'm seeing a very odd issue where these diffs I didn't create keep
> recurring in a particular repository.

Which diffs? You haven't given us any? What files does this happen
with? Do they have any peculiarities?

If these are files with non-ASCII filenames, then you're hitting a
misfeature of the HFS+ filesystem (it lies when git asks it about
files).

>=20
> I've tried:
>=20
> * Nuking the repo and re-cloning, cloning into a totally different
> containing directory
> * git reset --hard, git checkout -- of the offending file supposedly
> containing the diffs
>=20
> Is there some sort of uber persistent local cache that's bound to the
> remote repository?

The remote repository shouldn't have anything to do with this.

   cmn

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO3o5GAAoJEHKRP1jG7ZzTlpUH/10w9Wx0oau80n6xpHa/kEPv
Sx95bP0vjQc1m4ky0+tOKSANdsut+fuJ/OGSdJJZArbOyXafdGdasIGbs9Xu0yYh
pUL21yI22mlZCi1AQzmJyaAVoSDTZ3xM+tzO6j6uzPngdxWcocj9hB/s3+TBX9GB
BQLnSSqemVYhKMCJL5SrzuFgLZ/q3UdD6+gDsa3vvNmYWpHUVEhwFtBqLL1CtaMf
y7CFWYpAVffjbglJji9/eHO8A2KsOvJ0fSnDqzFev9GR/aw0xyyrDRSboVx3fUZH
6HmwRqCzoSxxx4TpgBEOmlufDxPsIp6BfH8dFhjaBiwvFllipmbs1fYatm2JXkM=
=wUXF
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
