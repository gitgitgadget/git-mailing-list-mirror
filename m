From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 0/4] Improve push performance with lots of refs
Date: Wed, 24 Dec 2014 21:31:40 +0000
Message-ID: <20141224213140.GD170128@vauxhall.crustytoothpaste.net>
References: <1419336082-283091-1-git-send-email-sandals@crustytoothpaste.net>
 <xmqqd27a2oqx.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LTeJQqWS0MN7I/qa"
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 24 22:31:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y3tX5-0001hH-Qq
	for gcvg-git-2@plane.gmane.org; Wed, 24 Dec 2014 22:31:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbaLXVbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Dec 2014 16:31:48 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55948 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751568AbaLXVbr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 24 Dec 2014 16:31:47 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2601:e:280:10f8:116:4aad:5f45:a30d])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 408142808F;
	Wed, 24 Dec 2014 21:31:46 +0000 (UTC)
Mail-Followup-To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Duy Nguyen <pclouds@gmail.com>
Content-Disposition: inline
In-Reply-To: <xmqqd27a2oqx.fsf@gitster.dls.corp.google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.18.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261813>


--LTeJQqWS0MN7I/qa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 23, 2014 at 10:40:54AM -0800, Junio C Hamano wrote:
> You spell "--thin-aggressive" as two words, "--thin" "--shallow", in
> this series, essentially, no?

Essentially, yes.  It became obligatory after I noticed the test
failure, since that test actually checks whether the remote side sends
a shallow-optimized pack.

> I think this is going in the right direction.  The "shallow"
> propagated on the wire from the fetcher is the right thing to use
> to make this decision.
>=20
> I wonder if the call to is_repository_shallow() is still necessary
> (read: I would prefer to see it go away) where we decide between
> "--objects-edge" and "--objects-edge-aggressive".

Okay.  I'll try to push it up the stack a little bit.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--LTeJQqWS0MN7I/qa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUmzC8AAoJEL9TXYEfUvaLZIwP/2wxPAqJUQZh7HHiPUxreuNS
gMPM9In3GWl8vV1hZe22OHiRgsx52mfAUgxfFVUweIYEip0U+cTvF5G45139ET1h
RAPcA3ROicKQtk9GkzbB6wUQyzIv0+trPdRmEEn9nZAHlYsY+DKFl62Nt+CRdCl0
ld3Pev51UVXWc8Lwoo17lnhxsZLlYDGPGs1ETEDtZ3BsQxgyB5pptvVWEU/EOYIg
ZK78aYxGqQkGxkel+23ENncufa+chdqfTS6lICm8P02665ny0FnOez8N8QZ9lNIS
lhyZLLvzeIZGLR5tFu0oZhnJTjivVKNrwyfBgEcSF6d59f+BuEnQRXl3770lo2Fq
loOFnmmMcYNMSzjVN3vex8nPT3TDhugpOI3fbZEepvN0iCcY/fkXpgIbkYmh2Aab
LS0b3tsacCHjhBO+gwqCI8d8ALV1kb4JD9bC/RFuQJeLbktAFJSyQUgcbCpKkRU6
62lQHiA04BRJzn4mpfTBq9nvesgZ/NjDOQyiQhor6R5BB4f7+ppq8RV9PZjXTkNy
T9Trm7qukCkrftz/kMQNGuBqbDYQWKR6jHu7rO2Y1TkMWjJBxyUbjwVjqSYwobwj
cZbd5D5UlyjeBQo7h4XbQwRWW9pQKvt4FKECZarI7C3ZUD1Fa9HipBJjhx9Rdo57
f0AS5epw7Civ7Fj2d5il
=3RXj
-----END PGP SIGNATURE-----

--LTeJQqWS0MN7I/qa--
