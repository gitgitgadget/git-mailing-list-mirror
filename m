From: NeilBrown <neilb@suse.de>
Subject: Re: [ANNOUNCE] Git v2.0.0
Date: Tue, 3 Jun 2014 21:46:25 +1000
Message-ID: <20140603214625.2db24440@notabene.brown>
References: <xmqqr43dbkni.fsf@gitster.dls.corp.google.com>
	<20140603120832.7235c706@notabene.brown>
	<CA+55aFyEce-48tcguL4GvvbomivZrnOYptzOenCrGTiQxxhHTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=PGP-SHA1;
 boundary="Sig_/xVL0LsoDC_8d9pVx8_CpXy1"; protocol="application/pgp-signature"
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 03 13:46:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WrnAv-0008TN-H6
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jun 2014 13:46:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbaFCLqh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2014 07:46:37 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38997 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932741AbaFCLqg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2014 07:46:36 -0400
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
	by mx2.suse.de (Postfix) with ESMTP id 5CA13AC55;
	Tue,  3 Jun 2014 11:46:34 +0000 (UTC)
In-Reply-To: <CA+55aFyEce-48tcguL4GvvbomivZrnOYptzOenCrGTiQxxhHTg@mail.gmail.com>
X-Mailer: Claws Mail 3.9.2 (GTK+ 2.24.22; x86_64-suse-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250624>

--Sig_/xVL0LsoDC_8d9pVx8_CpXy1
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 2 Jun 2014 19:59:53 -0700 Linus Torvalds
<torvalds@linux-foundation.org> wrote:

> On Mon, Jun 2, 2014 at 7:08 PM, NeilBrown <neilb@suse.de> wrote:
> >
> >   git request-pull master git://neil.brown.name/md
> >
> > after tagging the current commit as "md/3.15-fixes" and pushing out the=
 tag
>=20
> You should *tell* "git request-pull" what you're actually requesting to p=
ull.
>=20
> The old "let's guess based on the commit at the top of your tree" may
> have worked for you (because you only ever had one matching thing),
> but it did not work in general.
>=20
> So the new "git request-pull" does not guess. If you want to request a
> tag to be pulled, you name it.  Because if you don't name it, it now
> defaults to HEAD (like all other git log commands) rather than
> guessing. So please write it as
>=20
>    git request-pull master git://neil.brown.name/md md/3.15-fixes
>=20
> I guess the man-page should be made more explicit about this too.
>=20
>               Linus

OK, thanks.   I guess I can live with being a bit more explicit.

NeilBrown

--Sig_/xVL0LsoDC_8d9pVx8_CpXy1
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIVAwUBU421kTnsnt1WYoG5AQKADw//Qepon/BWBZvxHWOWOGF92yk5YUQso7CE
7uA2QLDkM+/o8d0XZ1QBAHJOlSCN9mP0+hZBYCNVz8BG7OIIuQzbkY+hRcecEQtq
+d2ICUXOADVbA1fkfTV4+/u7C6o0mC+33u3/nGzwMYbNqjYIj+ziCmpPxi0Jf3eV
BD5mU5G35dckWChCpiYGWTQmP00C7RAQV4nMHo9LGxMMbYrT7fQKbhME6AHQ3MMK
NX+mdxRNLj9lWKVSC7ozBRr+3GN5ubM9iJ9C2oUaKBQnfnsLmYIo7+xkol825p6y
RLdIJZBUFLv1VjFEtO8jafA+0nwgxtvMDOvYI2I00BLbM8aGHYINuEkPSfftjDx2
MP0aQszuRmNg3M+qH6WRFbWxg7hHNUISzYhXbjBYTSTYfD3hILaYyNH1vUUVY2Y5
WeDf7C9wHJpHCE7DQ8+/+fcirZl7tAC1p5A7V6ALxiz1Bb1Nq3PGFNBbSAn7/1bi
9I+sqUFAW4zsfrulUSxucwP09DZPWoJkd686uUZs3ozh0C921xQRG3tRB9VL6Lq0
NSmXhfdeu0RsPC7JeHwNoOU74KHzvSG7/Yi6kiULZr4L0sYo7eFIIyQDJeZjZJDJ
ntWo9VQiAa1/dyJPqAXqDAg6qSXvzIi4XAfx33ll1R/hk68p3nzuPmvk/M7h3RG/
b9o4O+ozPY0=
=jBUQ
-----END PGP SIGNATURE-----

--Sig_/xVL0LsoDC_8d9pVx8_CpXy1--
