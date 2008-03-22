From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: Re: [PATCH 3/3] Improve failure test for preserve merges
Date: Sat, 22 Mar 2008 22:57:02 +0100
Message-ID: <20080322215702.GA29174@alea.gnuu.de>
References: <1206222266-29179-1-git-send-email-joerg@alea.gnuu.de> <1206222266-29179-2-git-send-email-joerg@alea.gnuu.de> <1206222266-29179-3-git-send-email-joerg@alea.gnuu.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FL5UXtIhxfXey3p5"
Cc: B.Steinbrink@gmx.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Mar 22 23:00:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JdBlR-0000JT-Om
	for gcvg-git-2@gmane.org; Sat, 22 Mar 2008 23:00:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752646AbYCVV7u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2008 17:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754235AbYCVV7s
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Mar 2008 17:59:48 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:1316 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754141AbYCVV7o (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2008 17:59:44 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 41E4B488035; Sat, 22 Mar 2008 22:59:43 +0100 (CET)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBi3-0003Q2-Qk; Sat, 22 Mar 2008 22:57:03 +0100
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1JdBi2-0007bk-FX; Sat, 22 Mar 2008 22:57:02 +0100
Content-Disposition: inline
In-Reply-To: <1206222266-29179-3-git-send-email-joerg@alea.gnuu.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77855>


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

J=F6rg Sommer schrieb am Sat 22. Mar, 22:44 (+0100):
>=20
> Signed-off-by: J=F6rg Sommer <joerg@alea.gnuu.de>
> ---
>  t/t3404-rebase-interactive.sh |   10 ++++++----
>  1 files changed, 6 insertions(+), 4 deletions(-)
>=20
> diff --git a/t/t3404-rebase-interactive.sh b/t/t3404-rebase-interactive.sh
> index 014b036..eaa2fc0 100755
> --- a/t/t3404-rebase-interactive.sh
> +++ b/t/t3404-rebase-interactive.sh
> @@ -213,11 +213,13 @@ test_expect_success 'preserve merges with -p' '
>  '
> =20
>  test_expect_failure 'preserve merges with -p (case 2)' '

This test still fails, but I don't know how to fix it. The situation is
this:

o---P
 \   \
  A---M---B

A and B should get exchanged. So I would assume that telling rebase the
following should do it:

pick P
pick B
pick M
pick A

But what should be the new parent of B?

Is it allowed to permute lines with preserve merges? I've got the
impression it's not.

Bye, J=F6rg.
--=20
[dpkg] We are the apt. Resistance is futile. You will be packaged.

--FL5UXtIhxfXey3p5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFH5YCuwe0mZwH1VIARAqt2AJ419Jf1h4x5r9xlPMfrC3laE50tfwCeLFtS
1X3T88QGgn7PZ4sEP3zS6/k=
=hYHu
-----END PGP SIGNATURE-----

--FL5UXtIhxfXey3p5--
