From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Passing tar(1) options via git-archive(1)
Date: Wed, 24 Sep 2014 00:15:22 +0000
Message-ID: <20140924001522.GB6920@vauxhall.crustytoothpaste.net>
References: <87bnq6jhbk.fsf@brockman.se>
 <5421EAE4.30704@virtuell-zuhause.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ABTtc+pdwF7KHXCz"
Cc: Daniel Brockman <daniel@brockman.se>, git@vger.kernel.org
To: Thomas Braun <thomas.braun@virtuell-zuhause.de>
X-From: git-owner@vger.kernel.org Wed Sep 24 02:15:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XWaF6-0005C2-75
	for gcvg-git-2@plane.gmane.org; Wed, 24 Sep 2014 02:15:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbaIXAPc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2014 20:15:32 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50330 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755275AbaIXAPb (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Sep 2014 20:15:31 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0A4762808F;
	Wed, 24 Sep 2014 00:15:28 +0000 (UTC)
Mail-Followup-To: Thomas Braun <thomas.braun@virtuell-zuhause.de>,
	Daniel Brockman <daniel@brockman.se>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5421EAE4.30704@virtuell-zuhause.de>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17-rc5-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257449>


--ABTtc+pdwF7KHXCz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 23, 2014 at 11:49:24PM +0200, Thomas Braun wrote:
> Am 23.09.2014 um 20:57 schrieb Daniel Brockman:
> > Would it make sense to add an --mtime option to git-archive(1) to enable
> > explicitly setting the mtime for all files in the archive?  It could
> > just pass through to the tar(1) --mtime option.
> >=20
> > My use case is `git archive HEAD | docker build -`, in which the Docker
> > cache is prevented from working because the mtime keeps getting bumped
> > on all files.  I would like to have the mtime always be the same.
> >=20
> > See, e.g., <https://github.com/deis/deis/issues/1334>.
> >=20
> > Otherwise, how about a generic way to pass options to tar(1)?
>=20
> Actually I wanted to just hint to TAR_OPTIONS
> as in
> TAR_OPTIONS=3D"--mtime 2014-09-23\ 00:00" git archive -o ausg.tar HEAD
> but that does not work here (on windows).

Git does not invoke tar(1).  It has its own tar (actually, pax)
implementation, so any options would have to be implemented in Git.
We'd probably want to make such a change effective in the zip format as
well.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--ABTtc+pdwF7KHXCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUIg0aAAoJEL9TXYEfUvaLF8YP/jAQRQ0UIDOfdQgCX5AE43YJ
M+Dx1ZfiTS9Y6VQvHiiE3tqZbg/izQRULkrTFVu/q2T4IqbSJ5bjIxm3VVtTOcqI
R6QQyxAv/AmI8no/h9PHR6WUFJgAfRRbyN0AiyCxkFNf3n531NVE2H4WXRLTpk9I
uxabJGKSjdDQwYS15F7/UsEmIm+VCvB20XyaN8HT2BTyaGW+8ZaOJ8JlnxUDhlbT
2co5p08vQnNPrwrbDF+qcR6hIwChAPnsw18jCU0uP5VZzV3A3eDZ1TfapCE8q/Tq
GvsMapO0Cxf54f9DOQ5MRzZldjp/n1owNITtNJ2S36M+julQe4v0T/Oy/HJ3HInf
PTDmDo9nj8/aE/K2LN2WxNzlbPsURO5Mnv7O5NffC5KQdRmYca0gs08X4U84aoxy
FqPwHhroKyiIGDfuTj/QnTaS8D4HPbW3zoIhVYSPS2PHDfCXL+m21Tp9fS2OSaRr
mLtUW4d2kqWRTp54hc1dZp4+ECySAJCwMX7T5LMYQQcAMBSdJyzcLrqiiIZTphZ2
IUjjku12prFNWGYA7CPatwj75XWrb1upyJ4/MhxQGKJgE8sZxFsSLVCXGMA8Kiri
dO0X/Oc0B0wHXzwo/uOgPoEHj+1q69vbXjm8Zh7osl1KfqQeScwjPt/epgpova7n
Q9uENSbW1bu1Rb7J9Z+F
=8jwx
-----END PGP SIGNATURE-----

--ABTtc+pdwF7KHXCz--
