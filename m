From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Fetching a specific commit by commit ID
Date: Sat, 6 Dec 2014 15:52:10 +0000
Message-ID: <20141206155210.GA22146@vauxhall.crustytoothpaste.net>
References: <0EA82B66-7DDD-40A9-BB9C-94D3B1B43DBB@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Cc: git@vger.kernel.org
To: Olivier Croquette <ocroquette@free.fr>
X-From: git-owner@vger.kernel.org Sat Dec 06 16:53:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XxHfc-0000ug-AC
	for gcvg-git-2@plane.gmane.org; Sat, 06 Dec 2014 16:53:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaLFPwT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Dec 2014 10:52:19 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55072 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751521AbaLFPwT (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 6 Dec 2014 10:52:19 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 951F02808F;
	Sat,  6 Dec 2014 15:52:15 +0000 (UTC)
Mail-Followup-To: Olivier Croquette <ocroquette@free.fr>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <0EA82B66-7DDD-40A9-BB9C-94D3B1B43DBB@free.fr>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260955>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 06, 2014 at 01:39:12PM +0100, Olivier Croquette wrote:
> That brings up following questions/remarks:
> - the documentation of git-fetch is not entirely correct, commit ids
>   are partially supported, not only refs

This isn't completely true.  What you're seeing here is that git fetch
performs a negotiation to find out what each side has.  As a
consequence, if git does not need to fetch the item in question because
it already has it, git fetch succeeds.  The two sides essentially never
get to the point where they have to determine whether the behavior is
allowed.

> - more interestingly: is there any reason why git fetch should not
>   support fetching by commit id? There are real world use cases where
>   this can be very useful, for instance when references on the remote
>   have been overwritten or deleted.

It does in some cases if the remote supports this.  See the
uploadarchive and uploadpack groups in git-config(1).  However, you can
still only access existing branches and tags.

The reason this isn't supported in the general case is because one might
want to restrict access to certain branches.  For example, an open
source project might want to embargo some security fixes that are in the
repository.  Allowing a user to specify an arbitrary ID would permit
someone to circumvent those access controls.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUgyYqAAoJEL9TXYEfUvaL2SkQALnboE4j+F57lSn02G9E6HFj
GY5JTs4tb9IDe7j6dThpeg6a9V2eQULNFzQQyd2UkbabDa19g01J5RGS9Cw3bFTX
TNwHcOQm/FTjfuGnOd+E3qmyeXUa46AePZjKDpZAietPof1fL/ShxzEJfT7MEV6w
MANSVW4P2jOObHMoaWFqvxlw+okBOWj2v8Pd9VAQ0djlOOskqORcWZWA1hKlGIZz
M04Tv1RR84HgUYSN2TTANvYy7iP4bEIhOqG6YW7YLDs81YypobSa5gPk7657JHta
vo2oU6IzTSPLWcgSCP0ARGv1rHmMioOxA7nOXH11WTeofH1Y4h1RHjqr4qRjgN8h
X3Euti0ktTLqiwIq3H0usC5RFMkHHgOe7Lnt9Zb0BDS/pYc0GDhlnjA4Fp+V+0nM
7gH4Ba8oP2ARK24w+fj1K1MtneG0hXLXUEfz+QW4BbbTLiOxpxb9UauZZ28XnUJ2
1y3BTa7CIBIKeqrqzy69DjWBgL3NGn7GbvfzmhncGRGU6IFccjr55D3/huFAAr+Q
LxXfqH2YlTXkquLkslPM7PJFaSffSyhiIEC9GDSKapd5ycNPB2xH4t/L0xKsLbWb
qAjc++dXFOLOZO1paE9wKuflEF1/NwwSO+b7je0hPzehK3zCDWZ2J1myLfrkd5Ek
Fo6C6Z5TSfVt5lppKchZ
=fnMW
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
