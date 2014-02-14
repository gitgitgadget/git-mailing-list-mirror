From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git blame: "Not Committed Yet" with clean WD
Date: Fri, 14 Feb 2014 19:10:15 +0000
Message-ID: <20140214191015.GG4582@vauxhall.crustytoothpaste.net>
References: <52FC8BA7.30102@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="MGu/vTNewDGZ7tmp"
Cc: git@vger.kernel.org
To: Ephrim Khong <dr.khong@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 14 20:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WEO9p-0004nl-Fr
	for gcvg-git-2@plane.gmane.org; Fri, 14 Feb 2014 20:10:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752518AbaBNTKg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Feb 2014 14:10:36 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:51908 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751757AbaBNTKV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Feb 2014 14:10:21 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:485c:27a1:8772:5ef8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id C66B02807A;
	Fri, 14 Feb 2014 19:10:18 +0000 (UTC)
Mail-Followup-To: Ephrim Khong <dr.khong@gmail.com>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <52FC8BA7.30102@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.12-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242121>


--MGu/vTNewDGZ7tmp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 13, 2014 at 10:08:55AM +0100, Ephrim Khong wrote:
> Hi,
>=20
> for files that contain windows line endings in a repository with
> core.autocrlf=3Dinput, git blame will show lines as "Not Committed
> Yet", even though they were not modified.
>=20
> Example:
>=20
> --
> git init
> git config core.autocrlf false
> echo "foo" > a
> unix2dos a
> git add a
> git commit -m "initial commit"
> git config core.autocrlf input
> git status
> git blame a
> --
>=20
> Output:
>=20
> --
> Reinitialized existing Git repository in /.../testblame2/.git/
> unix2dos: converting file a to DOS format ...
> On branch master
> nothing to commit, working directory clean
> On branch master
> nothing to commit, working directory clean
> 00000000 (Not Committed Yet 2014-02-13 10:02:43 +0100 1) foo
> --
>=20
> Is there an easy way to work around this; is this desired behaviour
> or mor a bug?

I'm pretty sure this is a bug.  git blame should show the proper
information in this case.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--MGu/vTNewDGZ7tmp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJS/moXAAoJEL9TXYEfUvaLK1kP/34mCQmKVDW2mA0EBOzZfTUu
sSp37VSTx07CcoxfjJNVNam78YpD91sVEZV6II4FfJqwCzdfD549yiKjEblhOMKY
B0fih2E9FowsJtfmOmGylE3aVwms2qrBbr/jW+hW1rdhIj3j++CxlBTIs2vuyKBf
DhOsDml9vbyRfmgKCjiUjDhZFqkBi3v4lbFpBUJR6HJ3J42NBTGCAy0stG9ifQqI
ClV8/71ID67WEOWLozQtb3IwCvZ5pk3A0kbFnLMvlOt9+aJdo3nWKUPW5Z1UFuD6
NQMRFiM1kcAsDS4ZM1mwEdJsTPoNq4KQRMAzQVJdZqW/jeiH9I/6uDMfwOE1tMtu
2Ol8QLlm1EDK2y34jfcS2VOiv2Jqz9pqVDZIk9PpMES1KBQthAZ+Hq+22nX4elVC
qg8QnJZNBfQYLGYtO2hsQ61BxcEHN9oCBopEfxRwSaaJLP4r/T5krrVg6SI0N13y
8809AmFP5dsUuwlW6vvctOpEWzFGe9IDitpnONEVNgMbiHPAgqxseZpkdgO2enGx
kJ33ap7ByZLGAZ3weECfCtGPr90gpTqUqoYU72R8/Cp6W06avdZuDAtriNTBY4b8
+AJWjZGoxrxuAeUOBM4Gkpq+sLuUC2oYABlBcMW9gb2lj4m/YpZmi4lJxpSKU1pK
BljSB07OIjipzYyUNfdJ
=WYPb
-----END PGP SIGNATURE-----

--MGu/vTNewDGZ7tmp--
