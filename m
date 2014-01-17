From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Workflow on git with 2 branch with specifc code
Date: Fri, 17 Jan 2014 23:05:07 +0000
Message-ID: <20140117230507.GD107228@vauxhall.crustytoothpaste.net>
References: <1389960868.21737.2.camel@pc14.intranet>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Q0rSlbzrZN6k9QnT"
Cc: git@vger.kernel.org
To: Gordon Freeman <freemanmtc@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 18 00:05:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4ITe-0004CL-Dt
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jan 2014 00:05:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753443AbaAQXFV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 18:05:21 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51143 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751892AbaAQXFU (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 18:05:20 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:8133:d4ab:17ba:f5ea])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 9BCF728074;
	Fri, 17 Jan 2014 23:05:12 +0000 (UTC)
Mail-Followup-To: Gordon Freeman <freemanmtc@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1389960868.21737.2.camel@pc14.intranet>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240633>


--Q0rSlbzrZN6k9QnT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2014 at 10:14:28AM -0200, Gordon Freeman wrote:
> Hello guys, im Gordon.
>
> I have a question about workflow with git that i dont know if im doing
> it right.
> I have 1 repo with 2 branchs the first is the master of the project.
> the second is a branch copy of the master but he need to have some
> specifc code because is code for a client.
> so, every time that i updade master i need to merge master with client
> branch and it give me conflicts of course that will hapen.
> Well if was just me who work on this 2 branchs it will be easy to fix
> the conflicts and let all work and shine.
> But whe have here, 10 people woking on master branch and some times code
> are lost on merge and we need to look on commits to search whats goin
> on.
> What i just asking here is if its correct the workflow that i do. If for
> some problem like this, the community have a standard resolution. Or if
> what im doing here is all wrong.

There are many correct workflows.  I personally use the workflow you've
mentioned for the exact same reason (customizations for a client), but
I'm the only developer on that repository.

What you might try instead is a slightly different workflow.  Have each
developer create a feature branch to add a feature or fix a bug.  Merge
these into master as they become ready.  Have a specific person or group
of people be integrators, and have them merge master into the client
branch as necessary, fixing up any conflicts.  When conflicts are
non-trivial, use pair programming or a review process to ensure that the
result is good.

We use a similar workflow at my regular employer, and it is generally
very successful for a department with 45 employees.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--Q0rSlbzrZN6k9QnT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS2bciAAoJEL9TXYEfUvaLCmsP/0tn0qFBzGouNTbzbzr2Wbgz
yq77NqABOS9ZTvPFipcqX8xve/gI33pZ9i81l/nzU0zASXbEzh0y8QGTkxTBJu4C
0PKKijM5xEkNOKYfYj1BbkRcTVZ+qeK6t901RULcpmi46xD5vWJgLEKWeB8x/syp
iPREW314dz9/dkT2ZyPZJmOhapj7qnxG1sSJWr/s4FXN4f3BRuSPiL2w4FCx1fuO
eh/Wnpv8OwItVlLeo1BsGV2GArBHtPsr/w+d/fLb1zZd0WuRZKE2UH6/lsY54EaS
jEr6mN/kdwqX0FZy+Mk9LnMUXu+CDGH+Iy6PYWfrC4SOp7J+BTCVvOwfoHh2MRAN
TNMWIm4Kql7n5u1nH0C95utY4+C9znsXVANJw86tPxZvSipxQJVyWD4tQpfK1ikb
YevGAFz3rT4Iug7b+gkxPIjFN9gv0GhvoP/W1QzmxDYmor1EtKP2D6WjJM23mVrQ
npjimG70o2D8M44WvCBQwhbaMGYG3BSNJqfautHPq6ZDisZGdTgJ20ErQhAyKbMq
435Yb5FSLIhz0hK4k4aVc5rDC2NaUfo+4OoegqRhJ/YiKTfi4tHLCrSuI0X4kdTz
EJPEZShgBcvkoFjCLRpsu/eSgEM88J/pQwe/LcHUM+2Em4mYhjWSXjV1Qb6ceFiQ
J9MgfCs7gqEffAnoX9Lp
=PL9y
-----END PGP SIGNATURE-----

--Q0rSlbzrZN6k9QnT--
