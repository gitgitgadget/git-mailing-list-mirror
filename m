From: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
Subject: Re: Commit changes to remote repository
Date: Sat, 14 Jan 2012 12:31:41 +0100
Message-ID: <20120114113141.GG2850@centaur.lab.cmartin.tk>
References: <1326486589088-7185551.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DqhR8hV3EnoxUkKN"
Cc: git@vger.kernel.org
To: ruperty <rupert@moonsit.co.uk>
X-From: git-owner@vger.kernel.org Sat Jan 14 12:32:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rm1q7-0003Fu-Mr
	for gcvg-git-2@lo.gmane.org; Sat, 14 Jan 2012 12:32:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753853Ab2ANLbi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jan 2012 06:31:38 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:60937 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753788Ab2ANLbh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jan 2012 06:31:37 -0500
Received: from centaur.lab.cmartin.tk (brln-4d0c0748.pool.mediaWays.net [77.12.7.72])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 79A64461BE;
	Sat, 14 Jan 2012 12:31:24 +0100 (CET)
Received: (nullmailer pid 6123 invoked by uid 1000);
	Sat, 14 Jan 2012 11:31:41 -0000
Mail-Followup-To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	ruperty <rupert@moonsit.co.uk>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1326486589088-7185551.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188560>


--DqhR8hV3EnoxUkKN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2012 at 12:29:49PM -0800, ruperty wrote:
> Being new to git I am probably not doing things correctly so pointers in =
the
> right direction would be useful.
>=20
> What I want to do make changes on my laptop and commit them to a remote
> repository. Here is what I have done,
>=20
> 1. Created a repository on my remote linux host, in a folder of cource co=
de,
> by,
>=20
>    git init
>    git add *
>    git commit
>=20
> 2. On my laptop I did a git clone pointing by ssh to the remote repo which
> downloaded all the files to my local system.
>=20
> 3. I changed a file locally and did a commit.
>=20
> 4. I then wanted to update the remote repo with my change, which I did wi=
th
> a git push, but that didn't work, getting this error,
>=20
>     remote: error: refusing to update checked out branch:
> refs/heads/master=1B[K
>     remote: error: By default, updating the current branch in a non-bare
> repository=1B[K.......
>=20
>=20
> What am I doing wrong?

You're trying to push to a non-bare repository and change the
currently active branch, which can cause problems, so git isn't
letting you. There's an explanation of bare and non-bare at
http://bare-vs-nonbare.gitrecipes.de/ but the short and sweet is that
you should init the repo you want to use as the central point with
--bare and do modifications locally and then push there.

   cmn

--DqhR8hV3EnoxUkKN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPEWedAAoJEHKRP1jG7ZzToIUH/0vJ6bfR5zuUxxA5kotxymx+
mDoCWZc0oaXp71Mahd0P/qlju8P01BO4/UjaQ73c3FFS10bFBH5byRHlTtIKUCtN
2D1pulpRHU4giubVxAXIoQxclyMqVjG18Ah7Pcf8zPpl7R7HZlpF9CKueNpEwCKk
JGA3SaipNvR+JMwkAYFoccMb9Bkw3OPYO1Bqu9bJ1QmOWGJlBnXN+ZFvpmJ1K6cS
o3T/TV4z3vmZ3H5NLluMkAcvd0lKnxf6/u30xd0f0xA5ehwEE6O76Agkm6K2+z3l
ha78CV9UOHlxYKnGiY9Jjyov1cLHFwMMc9Lxv+EVoA2z1oLmX+Gf0YvTa+Ahsn4=
=vC49
-----END PGP SIGNATURE-----

--DqhR8hV3EnoxUkKN--
