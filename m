From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Git 2.7.0 gitignore behaviour regression
Date: Fri, 8 Jan 2016 02:41:25 +0000
Message-ID: <20160108024125.GD265296@vauxhall.crustytoothpaste.net>
References: <4B0F686D-3DF9-4E5D-971D-DB106C6573FD@mikemcquaid.com>
 <20160105150602.GA4130@sigill.intra.peff.net>
 <20160107234455.GB265296@vauxhall.crustytoothpaste.net>
 <CACsJy8C1R+JVmOXQ87eBP1COFNk3Vfqtb6AKzzT65catUhPczg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u65IjBhB3TIa72Vp"
Cc: Jeff King <peff@peff.net>, Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 08 03:41:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aHMzf-0003LZ-L2
	for gcvg-git-2@plane.gmane.org; Fri, 08 Jan 2016 03:41:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753929AbcAHClc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Jan 2016 21:41:32 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:34856 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753408AbcAHCla (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jan 2016 21:41:30 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id CDE42282CB;
	Fri,  8 Jan 2016 02:41:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1452220887;
	bh=CFjEszQdYO7WXPRu393eLYyADqbfLOh9Xw/EDvkPPlM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=slvt+AN5arqPQlcEKjWq3EuC+vObtPccHpNFsHyWi4XNdrIkddwrEB3ljAM+fPfxB
	 0B7mEprR30a2RbjW5jZmq/dGhDvWjw5EH7SbwLfwtDx1hNFeCKHZuUuIY9z7IP07zR
	 4OAdHOThU93965iYkBwiKi1MZMDbunuGdW1XNHmJDwXzeVro9PjF+516TGhyIpZ8b1
	 OF2taqG1S8zIQypp6Nqf+EoroBOq+3G3PBh/oq8dGKej+gT0L1lt9IvO0U1ae4+UYt
	 0kJJZOS3vBt+8gjcnz/i3uqS71XhGac90MT2AtMHbLlTrkIHgYZF+eBHoQ2tXQ3PKi
	 R8SLT5eM7Jcqgfk3SKJ5JkJNtWYfIR4XwNROIMG9Mcynmm6DHsHZIO+ZZqnQ1QBPaG
	 6F16NtZ6owax1/mZpHb2OuBS7gF3i5xcb8ukhrF8b1W8WCavl7cln7K7IM9TtHr2R0
	 tGdBYx/qasB2sUqL+d8oqNOXNNTS2+lrswrT+MmZesuIK7jkAAx
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>,
	Mike McQuaid <mike@mikemcquaid.com>,
	Git Mailing List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CACsJy8C1R+JVmOXQ87eBP1COFNk3Vfqtb6AKzzT65catUhPczg@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.3.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283524>


--u65IjBhB3TIa72Vp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 08, 2016 at 07:38:58AM +0700, Duy Nguyen wrote:
> On Fri, Jan 8, 2016 at 6:44 AM, brian m. carlson
> <sandals@crustytoothpaste.net> wrote:
> > I think there's still a bug in the code here.  If you do
> >
> >   git init
> >   mkdir -p base/a/
> >   printf 'base/a/\n!base/a/b.txt\n' >.gitignore
>=20
> Here we have the ignore rule "base/a/", but gitignore.txt, section
> NOTES mentions this
>=20
>  - The rules to exclude the parent directory must not end with a
>    trailing slash.

The text here says, "To re-include files or directories when their
parent directory is excluded, the following conditions must be met".  In
other words, the text implies that it's required for re-inclusion to
work, not exclusion.

> >   git add .gitignore
> >   git commit -m 'Add .gitignore'
> >   >base/a/b.txt
> >   git add base/a/b.txt
> >   git commit -m 'Add base/a/b.txt'
> >   >base/a/c.txt
> >   git status --porcelain
> >
> > git status outputs base/a/c.txt as unknown, when it should be ignored.
> > We saw this in a repository at $DAYJOB.
>=20
> If I delete that trailing slash, c.txt is ignored. So it's known
> limitation. I think we can make trailing slash case work too, but if I
> remember correctly it would involve a lot more changes, so I didn't do
> it (there are other conditions to follow anyway to make it work).

The case I'm seeing is that b.txt was already checked into the
repository before being re-added, and c.txt was not.  So it didn't
affect us that b.txt was ignored (as it was already in the repo), but
c.txt not being ignored broke a whole bunch of scripts that checked that
the repository was clean, simply because we upgraded Git.

I think regardless of whether b.txt is re-included, c.txt should be
ignored.  If it isn't possible to re-include b.txt, that's fine, since
that isn't a regression, but ignored files should remain ignored.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--u65IjBhB3TIa72Vp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWjyHVAAoJEL9TXYEfUvaLRZIQAKux8GiLASWxgBAFEWq5L4yi
+cXJEOiDxTSXgx1elIJ1ew2NvCgzn06XylHAg+lG9wM9zNnnK6HXiJMLUSA4/F3x
j99RRSo2VPDHLHYIypKih/xEi54yIn9dciRflKqrIlk972hqnUjz/H4/EhGg5+Yu
vXSKqbNo2hYe44tc4QIbBn21DIjKZLAEaDBQ88k9Jx7CJWzedLHhYIMooPInAQ4M
ty+fdYnqFdSXIltmJM0zNR+KX2dkHy/H9qZck3SoEjUfWsX/yh94+5lTY/NMlMAb
icMoGEpmrUVysQ8JplFUp8bjc8d2IfGloMm1TPaNIQdi32mNf+DgsE/R0LcgEZUY
zYaXbQdshmLB9zq772llQFMBYXY6v/0oIDmOtwDwqa54lZleLdOOZVd8CL3y1Z/3
M3PDezUJBDv0HsW4XXuQAF+ilEBp+3eb6mFi1cfnjq70RXzsUB9+obDwAB5eIr1H
GDPBYpQuxVPbhjKDfXbTQlr7gRimwjDS1Xy/FNHxEap3+gUK3RZ8SeNRDikBjaQC
JWRYM+bsdyTGydmAvbEzbMT1ciycVPx0GrWMzAia/dXbEpa5+MB51B9fQRSo8/Y/
o4iALtyJgPSD/8hdQgQIAf2qg1c9+/xlpJA36oUoaz8BK5wOXGUM3fVKCabOYbpe
J8iYUHxD0udtJOI9mNFe
=8lT2
-----END PGP SIGNATURE-----

--u65IjBhB3TIa72Vp--
