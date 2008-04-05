From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: sunos nay install nay ginstall nay
Date: Sat, 5 Apr 2008 13:53:03 +0200
Message-ID: <20080405115303.GV11574@genesis.frugalware.org>
References: <alpine.LNX.1.10.0804050653570.14919@fbirervta.pbzchgretzou.qr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B9BE8dkJ1pIKavwa"
Cc: git@vger.kernel.org
To: Jan Engelhardt <jengelh@computergmbh.de>
X-From: git-owner@vger.kernel.org Sat Apr 05 13:53:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ji6y0-0001gk-Ig
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 13:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbYDELxH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 07:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751515AbYDELxG
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 07:53:06 -0400
Received: from virgo.iok.hu ([193.202.89.103]:37444 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751519AbYDELxF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 07:53:05 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id BD33B1B2533;
	Sat,  5 Apr 2008 13:53:03 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id 82FE044699;
	Sat,  5 Apr 2008 13:49:49 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 259851190543; Sat,  5 Apr 2008 13:53:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.1.10.0804050653570.14919@fbirervta.pbzchgretzou.qr>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78843>


--B9BE8dkJ1pIKavwa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 05, 2008 at 07:07:53AM +0200, Jan Engelhardt <jengelh@computerg=
mbh.de> wrote:
> I found myself in a position to compile Git on Nexenta, and ran into the=
=20
> incredibly smart Makefile logic to pick "ginstall" when `uname -s` equals=
=20
> SunOS. Except that on GNU/*, it's install, not ginstall.

afaik, GNU/* has ginstall as well.

at least this is what i have here:

$ ls -l `which ginstall`
lrwxrwxrwx 1 root root 7 Mar  9 23:10 /usr/bin/ginstall -> install*

> Would not it be time to completely use automake?

or maybe time to fix your system :)

--B9BE8dkJ1pIKavwa
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.8 (GNU/Linux)

iEYEARECAAYFAkf3aB8ACgkQe81tAgORUJZdPwCfV6vNgSdMG4ZEmu+xgGRos+7K
xdsAoIZdpk70QutjngQlVYP8aPn7QvSb
=VGQa
-----END PGP SIGNATURE-----

--B9BE8dkJ1pIKavwa--
