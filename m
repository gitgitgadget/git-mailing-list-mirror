From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Preventing unsigned commit/merge/tag
Date: Tue, 31 Dec 2013 19:27:37 +0000
Message-ID: <20131231192736.GI451338@vauxhall.crustytoothpaste.net>
References: <CAH_OBicyrd=H1uG+_5-Jz=gK0fLsPbKKhkypWDG5yNb0umnhiw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fmEUq8M7S0s+Fl0V"
Cc: Git List <git@vger.kernel.org>
To: shawn wilson <ag4ve.us@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 20:27:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vy4yj-0004Gt-Og
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 20:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756575Ab3LaT1p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 14:27:45 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50774 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756489Ab3LaT1n (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Dec 2013 14:27:43 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:85f:96e4:d804:df86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4B48C28071;
	Tue, 31 Dec 2013 19:27:41 +0000 (UTC)
Mail-Followup-To: shawn wilson <ag4ve.us@gmail.com>,
	Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAH_OBicyrd=H1uG+_5-Jz=gK0fLsPbKKhkypWDG5yNb0umnhiw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239842>


--fmEUq8M7S0s+Fl0V
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 31, 2013 at 12:49:01PM -0500, shawn wilson wrote:
> What's the best way of doing this? I'd prefer this be a pre hook on
> the server that rejects and the user has to rebase and fix their
> stuff. Though, if there's some way to make it easier for users not to
> mess up (other than an alias for everything which I'll probably do
> anyway) that would be useful. Any ideas?

I don't believe the sign-on-rebase stuff ever got picked up, so at the
moment this wouldn't be a good idea, since each and every commit would
have to be manually amended.  It seems it never made it from the list
into Junio's queue whatsoever.  And the always-sign code is only in pu
at the moment.

But if you wanted to anyway, you could simply use a pre-receive hook and
walk the tree, verifying the signatures of each commit against some
canonical list of approved keys.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--fmEUq8M7S0s+Fl0V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSwxqoAAoJEL9TXYEfUvaLVbkP/R2/IHPeDRXDDfNoX8fhP1ph
2OC2ks6EeoivfxsAIJyYQTd7cm7RKox0BJeNk6HY9DU+51MhRZIXzz08bsVn4c3Q
sa9reLftvgOD6riW2y1lYMU49YESUxZVnKN63iK5uP/8WNS456RI7AuCz1iJComh
KMk+5TWawWVC4TipgKeiekgsYeV8ycqV35G9Ijk+TW6pO4cgAKcj5D1nV19AnI9d
icJyCgoTJgmVefnDSHdzk1cQWhKpvq6qaS6AcilyLENRRcODYbiuQdTEP3uLykAK
56DR6uslogZE6mMQKSyY7/tQ+fovPF/vYVW7l3YnfDb+8iTR6aSuH11tFluopDNA
ApmrvlPsN8GZ8NEKYKyLtgFZMMT1C6vxt7IHZqQ7dc2YzeuK62GlFzOzzQ7+jKD4
3j1txjbTBQUBw4dHZGSQWNfO1K5u3WanXvr19nr2PIgtn5LulNc6iKZKMvNo7GcZ
3LYIDg9sXX20KtbNxsyG5mNS2TYaJlKCF2hfSoWk3aZOpH5ku/8r3O7bmPhc9QBY
GWtLPFkpe2r9WoXezUyjaefe+VltBR4bG3EopXCu0SGRWK05e+Ty5Rrsnv/wUGd3
8Ki+K+LXkNGXq2gsZzZZfddy+TqwYkZR8wObNXTlGX/+MJ//45Y4INtfhcUOjQMd
RUqJAksdsuSbzbvtZsIn
=SDwb
-----END PGP SIGNATURE-----

--fmEUq8M7S0s+Fl0V--
