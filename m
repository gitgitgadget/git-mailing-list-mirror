From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: git svn can't handle giant commit
Date: Wed, 11 Jan 2012 14:07:08 +0100
Message-ID: <20120111130708.GB11984@beez.lab.cmartin.tk>
References: <CADVrmKRySXFAAi5WgpgSrephbsY7JLBECF+c9ZX=_KnRxn3Lzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jq0ap7NbKX2Kqbes"
Cc: Git List <git@vger.kernel.org>
To: fREW Schmidt <frioux@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jan 11 14:07:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rkxtd-0002TX-DF
	for gcvg-git-2@lo.gmane.org; Wed, 11 Jan 2012 14:07:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755609Ab2AKNHM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Jan 2012 08:07:12 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:36383 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755049Ab2AKNHL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Jan 2012 08:07:11 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id DD79D461C3;
	Wed, 11 Jan 2012 14:06:57 +0100 (CET)
Received: (nullmailer pid 9626 invoked by uid 1000);
	Wed, 11 Jan 2012 13:07:08 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	fREW Schmidt <frioux@gmail.com>, Git List <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CADVrmKRySXFAAi5WgpgSrephbsY7JLBECF+c9ZX=_KnRxn3Lzg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188363>


--jq0ap7NbKX2Kqbes
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 19, 2011 at 09:28:04AM -0600, fREW Schmidt wrote:
> Hey guys,
>=20
> I'm working on an import of some repos and I discovered that I can't
> import a certain commit due to it's size.  This is the commit:
>=20
> http://perlcritic.tigris.org/source/browse/perlcritic?view=3Drev&revision=
=3D2676
>=20
> Clearly it's large :-)
>=20
> Anyway, here's the error message I get:
>=20
>    Svndiff data contains invalid instruction: Invalid diff stream:
> [new] insn 4 overflows the new data section at
> /opt/libexec/git-core/git-svn line 5653

What version of git are you using? I can't find any of those error
messages in the git repo, and it looks like it's the svn library that
is creating the error message.

   cmn

--jq0ap7NbKX2Kqbes
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJPDYl8AAoJEHKRP1jG7ZzTFfwH/A/zIP4CG9EXZ0MxpUGP2mX5
RWIqwAFMc/9Yje92Uqxeelj0Zh946TiIiq/qOrQGiLZGuZ8JUx/Vnf1xDCCPSOvx
wEMXa8697jmKZ2nyDl9WjN4dtiN00cRf8Or3aT1p0QGkB6S+wWMthrgI+LaVLKEG
+eypDGBHcwaOD+2+KrejHR92CCkdYtzLTsuSne9jvULLOFpL9dLWZj6t+PpeUqKc
sojkffSp60xcHsvkwUFJJdYqi7jeTFsG1J5pVWUgn177qHI5m/5QfNPs8SS1bBXF
aVUVMzzNP/4ojg9zmQQAfLjNt5zhe45exxgweiiC2WZUQ7hk2fkmrY3arrAYfDQ=
=rZSI
-----END PGP SIGNATURE-----

--jq0ap7NbKX2Kqbes--
