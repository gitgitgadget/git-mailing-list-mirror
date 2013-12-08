From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] Documentation: document pitfalls with 3-way merge
Date: Sun, 8 Dec 2013 22:55:20 +0000
Message-ID: <20131208225519.GH118858@vauxhall.crustytoothpaste.net>
References: <1386535227-209788-1-git-send-email-sandals@crustytoothpaste.net>
 <20131208224013.GC9108@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YrQNB5Deg1WGKZi3"
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 08 23:55:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VpnG9-0000S0-Fg
	for gcvg-git-2@plane.gmane.org; Sun, 08 Dec 2013 23:55:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760233Ab3LHWz3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Dec 2013 17:55:29 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34553 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760125Ab3LHWz1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Dec 2013 17:55:27 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:9965:b023:d7b:c74a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 11DA42807E;
	Sun,  8 Dec 2013 22:55:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20131208224013.GC9108@google.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239055>


--YrQNB5Deg1WGKZi3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 08, 2013 at 02:40:13PM -0800, Jonathan Nieder wrote:
> brian m. carlson wrote:
>=20
> > Oftentimes people will make the same change in two branches, revert
> > the change in one branch, and then be surprised when a merge
> > reinstitutes that change when the branches are merged.
>=20
> Life is even more complicated: if the merge-base chosen happens to be
> a descendent of the change on both branches, the merge won't reinstate
> the change.

Right.  The text should probably be clearer in that respect.

> The problem scenario hasn't happened to me recently.  Can you give an
> example of how it happens?  Why is the same change being made
> independently on two different branches?  I'm wondering because such a
> story could make the example in the documentation a little clearer and
> avoid having to make the explanation overly technical.

It happens pretty much as I described.  There have been two different
posters to the list who have made the same change on both branches,
reverted it on one, and then were surprised when it was reinstated
during the merge.  Generally people expect conflicts in this case.

I don't have any further details, since it hasn't happened to me and I'm
not either one of those posters, but I suspect if someone did a
cherry-pick of a change from one branch to another that could happen.
Maybe an important bug fix was picked from a topic branch, but the
change was reverted because the problem was solved in a better way.

> In any event, that the 3-way merge is really just a stupid 3-way merge
> (modulo multiple merge base madness) does seem worth emphasizing, so
> thanks for working on this.

My goal is simply to stop having to answer the same question on the list
twice within two weeks. :-)

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--YrQNB5Deg1WGKZi3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSpPjXAAoJEL9TXYEfUvaLu0wP/iPkYcieYO3k7HSOsLB5N2hp
iEyt5CZ9ngmyb9MmiKH47GITkJFAtHm0kwRvoEQJ00I9rDWt01x6HXoeAlSLC9oB
mKvXXeCPXQUJ0SmrjcKY7elDPHGTbd6iRedFFx1ILnevF04fEcA6tpiYYEtEvhmr
rHi1YGvjVBNYGfKATWWHvUieFxFv8sQ+n/0F6eBP2sOjx0B3hEdF52qJr2PmfFxj
mZXklVvvm/ZAuDgBszdqsbmouAh9z1tE2C2++NwJf5AEaO9g47U7ENidv3dZ8tvO
hPOoYciUCzQRGoubFj7E7dg/z67L9E1DFemW2GNea7ACdBPAD9If8NZMUKcThpCs
ow4VJ6ARMGsfLz1mB8zr08lrDardh/pilWWMiIJefWpOtuCFAAVtfDiPXtyM9aUK
T0fYousdJ+BTG+Btmyt1Y0Y+IaZrSEEv6zSNL44UJfC3MPhIyBZAAbsi1XK3RAoK
jcJec7z0Cej5MqEcfOyI+/xzjPgJFOViOYuYkZ5JU1A6DyYE5Db7NhnvkkfHwP65
qa9OQ8c10UHhVzBP+zPuvyNAyF9/tr5N0TIumtqUom9G9DCGEN042Q/0/skobgYP
OW4H8NF+sAS4+yBMpbA1IMyHI/jN0HehNFusfFH9EEPU8LETJwL22DrZ+QVxHu1N
mx3Xm+YTkj/Vk2WLxuGr
=zudY
-----END PGP SIGNATURE-----

--YrQNB5Deg1WGKZi3--
