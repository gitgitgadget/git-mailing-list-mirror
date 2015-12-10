From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: GPG public keys
Date: Thu, 10 Dec 2015 01:16:24 +0000
Message-ID: <20151210011624.GE990758@vauxhall.crustytoothpaste.net>
References: <9E65FDC7-B4F6-45DC-9B0E-F017B904C868@pixelrebel.com>
 <xmqqtwnsie6h.fsf@gitster.mtv.corp.google.com>
 <3860CB92-AD83-4372-AE7C-BBA8BF2D8F67@pixelrebel.com>
 <20151209220413.GA21751@sigill.intra.peff.net>
 <CAGZ79kYk0RkwNj2aX6iixGjceKVYTy24os_Xb_wY8BWDZwY+Fg@mail.gmail.com>
 <20151209224335.GB32104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="u5E4XgoOPWr4PD9E"
Cc: Stefan Beller <sbeller@google.com>,
	Jamie Evans <jamie@pixelrebel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Dec 10 02:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a6pqd-00073U-PU
	for gcvg-git-2@plane.gmane.org; Thu, 10 Dec 2015 02:16:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754019AbbLJBQi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Dec 2015 20:16:38 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:38176 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753511AbbLJBQa (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 9 Dec 2015 20:16:30 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E7AD52808C;
	Thu, 10 Dec 2015 01:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1449710187;
	bh=m5OFobwcBiiE2wD2HKSgvkeeal+kpF35qnupx8hc6CQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tB1ntXjeDQry4dmiJztx6Bs8yH68BLncK5seM+ioun4Xlec1BW2FKFVF2wPEdg10Z
	 m/XXsHNaE9I0lnQBJJKcdpgFz2vkG7egJ/XkDCOLXA1ArIDZZO+6q1+UFRDIj8aIs5
	 r/EPO3equP8hijoVcQml1bPfBwPyzInEZs1YuQIN8ximIKTpalXpr02KolQ2YXjAtB
	 9SsbH9S7xKY8Vs9ShSSwnzqW31VLLzXJTkLZMVYcqMWa6L7Mk3PovYcgWf3FobOqsF
	 ZmcJEUyj4IJGufwY+oNr32jfVyYew3ErvrcnfpD+b0lysIIuVcPdDWie609WBnjmMI
	 ouZ4gUcav7VVa5SznqspY+WdM+Fo91nWIbaS5KAsQKcxgOPhJKt677Vf7VzdKSI2M5
	 GhCXNkNdsjEUbr26ZieJgTSWk96NwY3gxnM+vOdbtxeaJSmzL2WhYMdtd5wNDMp777
	 PHAYOHtUF24gTDodRzaPXuCW0EigrMgBphbIBf3Ey8Ga/bCZzn5
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
	Jamie Evans <jamie@pixelrebel.com>,
	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20151209224335.GB32104@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282209>


--u5E4XgoOPWr4PD9E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 09, 2015 at 05:43:36PM -0500, Jeff King wrote:
> On Wed, Dec 09, 2015 at 02:24:17PM -0800, Stefan Beller wrote:
>=20
> > On Wed, Dec 9, 2015 at 2:04 PM, Jeff King <peff@peff.net> wrote:
> > >
> > > Of course you can't just fetch the v1.7.1.4 tag _now_, because the sa=
me
> > > person impersonating the most recent tag could also be impersonating
> > > (and back-dating) the older tags. But you could fetch it now, store it
> > > somewhere trusted (e.g., on your laptop), and wait two weeks. If you
> > > find no public outcry over hacked git, then it is probably OK to assu=
me
> > > that is the real key.
> > >
> >=20
> > With all of us pointing out 96AFE6CB being the right hash, you may or m=
ay not
> > trust the list enough to also trust the key now.
>=20
> Who's to assume that I actually checked that 96AFE6CB is right? ;)
>=20
> Actually, I don't typically verify Junio's tag signatures. I fetch and
> run "make" daily, far more often than he signs, so I would have been
> p0wned long ago.

It might also be worthwhile to check that the signatures on kernel.org
match the key in the repo.  kernel.org autosigns the tarballs as well,
so presumably that key matches what kernel.org has on file for Junio.

It may also be less important that the key really belongs to a human
named Junio C Hamano than that the same key consistently signs tags and
tarballs.  I can't personally vouch for the human behind the signatures,
but when building git from tarballs, I do check that the same key signed
them.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--u5E4XgoOPWr4PD9E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.9 (GNU/Linux)

iQIcBAEBCgAGBQJWaNJoAAoJEL9TXYEfUvaLZLIP/iyXyVVtvkhUUkXpEqkOospl
juYy7xNQXPFNbGz3G8tkUvPMRU3K74oi/iQeLAwC52HCX6F5VDnsR60wR4JziN9I
L76yjlq1BHBXkgnMWVuB6GwVtZJSDRRtOuzNqbMwT7PM7mHDf+Sp2+Do5SGM9kKV
7i5M7G3DbvhXjec8CY7dw6F4xt2s6TTZRfZP20pm7uUGz+34VBgVnqjx6cvF9vFw
kdjPrzwfZtf71YslP0S2xNdiXzXYKlPy/9DqtlLB9zlH2RBsJ23GyTZ9PX1OTqsc
ve7RytGtJw36VrLzGiiWB1xInewOoOe8h4gA8Ibm4TSmRAiSnEIvU9Uy8jQPfHgt
0u73hQGqbMfri3PvnArGfmElIW9G0HDp6NirmVqlUAHgkl4ZoD7IdeF9mJGV+zif
E8DltP6y254p4AnvE5lMoH0njjqZaNak7x1/OQnt5ablaEuMOC8Lg0i0wdLCGSY3
p3JMusr/w/mGFCL0NcYZbEEmieAZYOMPBsjdhUPF5Gc5OqEDYLNFbnjWqUwr8m8m
Uh8qHdaOv7Z/kcdaLr77JqXoFhukfL5m8BWp64BjjzMEyofjMHfx0+Pe6iDL1eLq
ucGFqhPOc7FCWetDIlCMUHrVr6zIVIxWCNbtY2ZSCBiB5+PbxmnljHwMCqjJ/vba
PYNpd3UOcmTVpf4tPH3K
=E6Pj
-----END PGP SIGNATURE-----

--u5E4XgoOPWr4PD9E--
