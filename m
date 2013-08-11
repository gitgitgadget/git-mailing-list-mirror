From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] submodule: don't print status output with ignore=all
Date: Sun, 11 Aug 2013 16:03:17 +0000
Message-ID: <20130811160316.GE164436@vauxhall.crustytoothpaste.net>
References: <1375550060-5406-1-git-send-email-sandals@crustytoothpaste.net>
 <1375550060-5406-3-git-send-email-sandals@crustytoothpaste.net>
 <20130803182420.GG2893@elie.Belkin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="47eKBCiAZYFK5l32"
Cc: git@vger.kernel.org, judge.packham@gmail.com, iveqy@iveqy.com,
	Jorge-Juan.Garcia-Garcia@ensimag.imag.fr, gitster@pobox.com,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 11 18:03:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8Y7P-00041o-9G
	for gcvg-git-2@plane.gmane.org; Sun, 11 Aug 2013 18:03:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754124Ab3HKQD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 Aug 2013 12:03:29 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:45782 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754098Ab3HKQD2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 11 Aug 2013 12:03:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 928F328072;
	Sun, 11 Aug 2013 16:03:20 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20130803182420.GG2893@elie.Belkin>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.10-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232137>


--47eKBCiAZYFK5l32
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 03, 2013 at 11:24:20AM -0700, Jonathan Nieder wrote:
> If I have '[submodule "favorite"] ignore =3D all' and I then replace
> that submodule with a blob, should "git submodule status" not mention
> that path?

Yes, I think it should.  I'll fix this in the reroll.

> If I just renamed a submodule, will 'module_name "$path"' do the right
> thing with the old path?

module_name uses whatever's in .gitmodules.  I'm not sure what you mean
by "renamed a submodule", since "git mv foo bar" fails with:

  vauxhall ok % git mv .vim/bundle/ctrlp .vim/bundle/ctrlq
  fatal: source directory is empty, source=3D.vim/bundle/ctrlp, destination=
=3D.vim/bundle/ctrlq

Can you provide me a set of steps to reproduce that operation so I can
test it effectively?

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--47eKBCiAZYFK5l32
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBCgAGBQJSB7XEAAoJEL9TXYEfUvaLS6oQAMHLfzcb+gihpLzeOAkwqvES
8TtxtAjvmI0+CqSBGdiALT+99gJ294Y1ENsYMmHmjbt0FwH1/BZzTTcl4XlwfIcv
4iHPzQDkHifgATw65tuCUayKGqtnbFHPtrJLG6hAEHPYtu9w4xeKKaGSAJ1idIxy
zYIXiWAF7uo7MDSNoxBG9NJfSVO1MUOrvxuBhsYHbvK3t57paEw1ILg9N5xfWWqG
ThjmAmYNX4dr1mcnS0SWH3CCi6HA/7ffPkbPo/JALdv8vYBcZSfHvLinkhBW79rz
eWyr2qu+gC0NbmnvtKFmR3EmK89/ESsqQl/XFbD+lp09iM15jRFVnzi6VPzyRQ/8
dNAGFeZKX72d06AXRO2C4SA98T71mfP4E0V5YwNJ/MNrK6goeeagBjSN4jEypqku
uI5sinD/DgAim9nY0RezVoO54ADW8kbVKYxJYs4k9f+Ce8D7EXGBgkzhT0UdouQ5
PJUKY9RMA3K9s7ZpmG2VFIf7OuzoXxCWAjHqpd+yGAKxFFDYq8zeBjJA6aPWmhde
belOM5GavmqdfWlg40tBel/jeSm7BSfG3zUwvjng/aLfJ/WWaxtkCCkvF/sgtg+D
fEvAOQ8P9AGG0SlOk3fQB8oQUniBy9jINICM6e47a/eCu+HpzySmW0xmaJrDJbKi
QSRQO/PmG8ZXSuBsO6fl
=SEUI
-----END PGP SIGNATURE-----

--47eKBCiAZYFK5l32--
