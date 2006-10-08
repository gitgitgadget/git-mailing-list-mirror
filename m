From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Subject: Re: Does GIT require property like Subversion?
Date: Sun, 8 Oct 2006 11:19:00 +0200
Message-ID: <20061008091900.GG30283@lug-owl.de>
References: <4528C09B.3030004@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kLfXKozCjJHLN+lB"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 08 11:19:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWUoO-0005ja-NK
	for gcvg-git@gmane.org; Sun, 08 Oct 2006 11:19:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750978AbWJHJTE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Oct 2006 05:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWJHJTE
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Oct 2006 05:19:04 -0400
Received: from lug-owl.de ([195.71.106.12]:51640 "EHLO lug-owl.de")
	by vger.kernel.org with ESMTP id S1750978AbWJHJTC (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 Oct 2006 05:19:02 -0400
Received: by lug-owl.de (Postfix, from userid 1001)
	id 060D2F06BC; Sun,  8 Oct 2006 11:19:01 +0200 (CEST)
To: Liu Yubao <yubao.liu@gmail.com>
Content-Disposition: inline
In-Reply-To: <4528C09B.3030004@gmail.com>
X-Operating-System: Linux mail 2.6.12.3lug-owl 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
X-Echelon-Enable: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
X-TKUeV: howto poison arsenous mail psychological biological nuclear warfare test the bombastical terror of flooding the spy listeners explosion sex drugs and rock'n'roll
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28527>


--kLfXKozCjJHLN+lB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 2006-10-08 17:10:51 +0800, Liu Yubao <yubao.liu@gmail.com> wrote:
> I want to know whether there is a plan to add this feature, or GIT doesn't
> require it at all.
>=20
> Properties like encoding (path name, file content), eol-style, mime-type
> are useful for editing.

GIT is a content tracker. It won't ever fiddle with your line
endings. You put data in there and it'll be conserved bit-by-bit. So
if you need to store file encodings, MIME types, automatic CR/CRLF/LF
converstion etc, you have to put this metadata into some additional
files, but GIT won't specifically handle that in any way.

MfG, JBG

--=20
      Jan-Benedict Glaw      jbglaw@lug-owl.de              +49-172-7608481
Signature of:                     Eine Freie Meinung in einem Freien Kopf
the second  :                   f=C3=BCr einen Freien Staat voll Freier B=
=C3=BCrger.

--kLfXKozCjJHLN+lB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFKMKEHb1edYOZ4bsRAkOZAJ9vhZYPusQzvIaycjPEPkD4HclSJwCfSB3l
dt53PD5fy7jv2i2saE/dY5Q=
=JtxA
-----END PGP SIGNATURE-----

--kLfXKozCjJHLN+lB--
