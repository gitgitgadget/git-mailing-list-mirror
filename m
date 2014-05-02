From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Define constants for lengths of object names
Date: Fri, 2 May 2014 22:09:08 +0000
Message-ID: <20140502220908.GI75770@vauxhall.crustytoothpaste.net>
References: <1398942410-112069-1-git-send-email-sandals@crustytoothpaste.net>
 <20140501172007.GZ9218@google.com>
 <20140501230041.GC75770@vauxhall.crustytoothpaste.net>
 <20140501230553.GE9218@google.com>
 <CACsJy8AhxJDcBHNWbssWs2F1oQB4xGG7rpBePX60m4=_+MVEZw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 03 00:09:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WgLdt-0004Dk-A8
	for gcvg-git-2@plane.gmane.org; Sat, 03 May 2014 00:09:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752719AbaEBWJN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 May 2014 18:09:13 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47507 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752332AbaEBWJN (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 May 2014 18:09:13 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:406f:e13c:7c96:bfde])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 24CE328087;
	Fri,  2 May 2014 22:09:12 +0000 (UTC)
Mail-Followup-To: Duy Nguyen <pclouds@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <CACsJy8AhxJDcBHNWbssWs2F1oQB4xGG7rpBePX60m4=_+MVEZw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247992>


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 02, 2014 at 07:15:44AM +0700, Duy Nguyen wrote:
> On Fri, May 2, 2014 at 6:05 AM, Jonathan Nieder <jrnieder@gmail.com> wrot=
e:
> >
> > I can make up for it in enthuasiasm.  Please?  It's something I've
> > wanted for a long time but never found the time to do.
>=20
> It's definitely better in the sense that the compiler will catch new
> "char[20]" declarations for us. It's also a lot more work.

It is.  I'm going to start with a patch that introduces struct object_id
and the fixed constants.  Then I'm going to get a patch that compiles
with lots of warnings, and then I'm going to fix all those warnings.
Otherwise, the patch will simply be too enormous to review.

I'm willing to hear other suggestions for going about this, though.

> No architecture was named last time if I remember correctly. But we
> could check "sizeof(struct object_id) =3D=3D 20" in a test or something.
> When people scream, we can pack the struct on that particular
> platform?

Sounds like a plan.  I am not aware of any architecture that has this
limitation; I've worked with x86(-64)?, 32-bit PowerPC, UltraSPARC, and
ARM.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZBeEAAoJEL9TXYEfUvaLHO4P/052hG0IzzZl13BKUS7Muqya
GL5VyIZKJT7VvWPQAZKtrExTidw1jXLaZOQ+J67saciTHLGZUahiRGS4Jc7Qpmhe
Ey65dLtqzT8VE32ZAiaFBB86u04kFoaNgktmTqyaz2x3bnuu5uMoX91I3VcvhZWM
uLt/iCJDetF6y35mYNw5LIbi6VkVZtw8fTUe8JG75Xmf9bZrH91Q+R9CaYLcmmOS
PmdbXjtjeIehRF0Pc6tlwHQ/tl3NRnK2F79++r5i8o8vFgHDny+JOKeyqY03rY1E
ZMqQ1riTk9x8YN0SDXbvpwf7059LmcKNpCsnz1ouR/omzgj9M4LTsz5fqJIImjdd
MB4MlJoeaOwd6LHZWHkW84ZtVXkoDX5hWTy9pwu1ZybHcfC/XeqvztddNrF/u/GG
OfWaROzUtLu8uV9DA61u1pSJUhKZ6V1vwpkXDn7GwuZ4riFdDe/9kQiMJvf7xFvj
YjjejSVYmmkaBz6GwlWr/GxV34A5MG6UnAi6SSUjas2KTU9iD/ouhGRtSqXDslZ7
qAJTcyqfzIc3jKKI1i0idRTeDhUvVgtdQ8rurYzir6yVuJm2Jimzp/g7Sum54FOq
depV+jD2iYnSjM7xAx2nY7WBPuQ/GHSD98uLRnXU0FppDmK/nSgM853t7qQPBAGl
pKu+nKuKkjGlrlLWvo2H
=Le+q
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
