From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: stash-p broken?
Date: Tue, 29 Jul 2014 02:59:40 +0000
Message-ID: <20140729025940.GA8640@vauxhall.crustytoothpaste.net>
References: <CAJWZfo6j2E2qu1n6JTmtPw109tAjnEfWBvKxwGfTrKSF6MZ2Uw@mail.gmail.com>
 <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Cc: git@vger.kernel.org
To: Michael Migdol <michael-spam@migdol.net>
X-From: git-owner@vger.kernel.org Tue Jul 29 04:59:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBxdr-0006Ig-63
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 04:59:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752264AbaG2C7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2014 22:59:50 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:49162 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751702AbaG2C7t (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 22:59:49 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:84c3:81a6:6259:5e7b])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4453E2808F;
	Tue, 29 Jul 2014 02:59:46 +0000 (UTC)
Mail-Followup-To: Michael Migdol <michael-spam@migdol.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAJWZfo741u8KqZax4ReTEg8hy1BKWR2_PofxAQtE4wU=ikRsPw@mail.gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16-rc6-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254390>


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 28, 2014 at 05:56:28PM -0700, Michael Migdol wrote:
> Sorry for error -- I meant: git stash list -p, not git stash -p.
>=20
> On Mon, Jul 28, 2014 at 5:38 PM, Michael Migdol <michael-spam@migdol.net>=
 wrote:
> > I recently upgraded from Ubuntu 13.10 to Ubuntu 14.04.  After doing so,
> > "git stash -p" stopped working.  (It apparently is ignoring the -p
> > parameter).  I'm not sure what version I was using previously, but after
> > some experimentation, I see that:
> >
> > version 1.7.12.2 : stash -p DOES work
> > version 1.9.3 : doesn't work
> > version 2.0.3 : doesn't work

Under the hood, we do:

  git log --format=3D"%gd: %gs" -g "$@" refs/stash --

But it looks like git log ignores -p if -g is provided.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJT1w4cAAoJEL9TXYEfUvaLqqIP/39fos9CAefOlkp0z2ILLeMU
GBcSmYAQvITpX++4jo7Qv0vhLJypEdQETmK8+t4LsslsCudYdrvih6ioZv+3qp45
XIX0J1p7D8krAw75NcFD3hj3TMS95/Li0ZTs7LnoCNlbP+7Ap+wrAg4xsghDQrfE
dH8fLaCj47gbCTRFSvB+h/SwV0jsZmKZuyx/UvNe0urRLgblCy4EtYW5/Mhm9rjZ
82YmsQrn34m2A4WK465MMvUh0QhILnRQGW/CP1CDnL274+PEDkoY40YUxljtTO/1
MvYjiF9DBQrMvRbHbz/ZuGpBLgVYhdwj9HNKacu7DtQXLTRDtqaNV8svzC+CIDrn
qJYTwGLOeRQNhUo7IHWy0ij8cC4IwSBCLzQvim7xyrcEaIgGANfak7bXduNlt5td
uufxRfMpyn6/YGZ4mmdjYNW6oH2+Xg4zS/WVGnidqisOJ191iscdSv3qNzO7jpad
aFL+52PloduJaBxudVlFi1aZ6bq1RMJW5nZ7h6Lqi8sIfbjcfKnJl46gN2O77+82
GbEyx2RK38Q/4mqgYFv8xTwe2Ly9zhr063Xb+UFdLjOM4BxOvAPqElTcUcavNx5c
PjuJh/oQubfSkFgjmgLx8n4nsNurp3180it+5/MFHwwMPPtUdzl3hKQs/yVBX71N
4TQ7c7T1TDwwl/sjAXQ9
=nF/w
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
