From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Problem while cloning a git repo
Date: Wed, 13 Nov 2013 00:20:35 +0000
Message-ID: <20131113002035.GK183446@vauxhall.crustytoothpaste.net>
References: <597769726.308442105.1384260624974.JavaMail.root@zimbra35-e6.priv.proxad.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="tKtFalx5NIx0HZ72"
Cc: git@vger.kernel.org
To: ycollette.nospam@free.fr
X-From: git-owner@vger.kernel.org Wed Nov 13 01:21:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgOCZ-00048n-Bc
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 01:20:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755290Ab3KMAUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 19:20:47 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33784 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755239Ab3KMAUp (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Nov 2013 19:20:45 -0500
Received: from vauxhall.crustytoothpaste.net (vauxhall.local [172.16.2.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7B78D2807A;
	Wed, 13 Nov 2013 00:20:42 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <597769726.308442105.1384260624974.JavaMail.root@zimbra35-e6.priv.proxad.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237767>


--tKtFalx5NIx0HZ72
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 12, 2013 at 01:50:24PM +0100, ycollette.nospam@free.fr wrote:
> Hello,
>=20
> When I clone a repository, I get an error from git:
>=20
> git clone http://192.168.0.18:8080/test test_Gerrit
> Clonage dans 'test_Gerrit'...
> remote: Counting objects: 25106, done
> remote: Finding sources: 100% (25106/25106)
> error: RPC failed; result=3D56, HTTP code =3D 200iB | 8.12 MiB/s  =20

curl code 56 is a receive error (CURLE_RECV_ERROR).  It sounds like
you're encountering some sort of network error or broken proxy.  Does
cloning this repository over the git protocol or SSH work, or can you
try it over https (to avoid the proxy)?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--tKtFalx5NIx0HZ72
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSgsXSAAoJEL9TXYEfUvaLH08QALk1uozCXbZoBNIjYCsUEpoc
eQOcttKYkloE1Y8eMc/WCyMMiUpgkD853FNO5u0XQxG/l/WQaBFCk8v80io3PAMw
GQGA2g1+fkJo29skVJx49DKISKfvZgTOcl0frCdER6OSHoCbrjmjxCNKz458tPSg
FCnbOGyvml1xS3PJTtUptrqLHDmWwqw1E+QBn6a1Kre+mYgeW8rJQRtyQhpXyk2+
g3LtFPp8g9hhBAJbP3FDfC00IZm9BqzxiunwbgPYe05E7+47z5Q0vkjUTjwd0DBK
1Txm1tFPDY44w/5DNnhEpOTdW9FLjESLXMpg+T6ja4mCfZo3q7rYLwsVQ7C6GBwF
HyYNUE6RnPH7MYyldyZsr4mLm/tL6fI3ZkKPe2qYhFJS9beNbndLIDoRjwTWykzM
YgYNX3mFVkOE5toqQZQaFkGAKwbWOsx2l3IJKHjFFqojghAvPW/Na1NsD9lnbs13
zu+QpDTm4Z8o93b8smuh+njzbFVDUbMwyBGKWKLev2/u2rEc7wuGy/PDxNaALIe0
POUHub+75K0LLQ0lczA3QAHXUGWjGMj8GB0+i/08J295KkFeFVw4e6+q2H62ypvZ
xEH1uxW9PoObBadSqcqitgMVQmf5ZDvF8yaSst26gyGXUe5sn4qeDa+n5HMWNPJq
h4DdPNMJ756iCWSGATpU
=DGhj
-----END PGP SIGNATURE-----

--tKtFalx5NIx0HZ72--
