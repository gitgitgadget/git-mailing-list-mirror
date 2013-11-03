From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 1/8] cherry-pick, revert: add the --gpg-sign option
Date: Sun, 3 Nov 2013 17:50:15 +0000
Message-ID: <20131103175015.GA183446@vauxhall.crustytoothpaste.net>
References: <1383494064-5653-1-git-send-email-boklm@mars-attacks.org>
 <1383494064-5653-2-git-send-email-boklm@mars-attacks.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="X1bOJ3K7DJ5YkBrT"
Cc: git@vger.kernel.org
To: Nicolas Vigier <boklm@mars-attacks.org>
X-From: git-owner@vger.kernel.org Sun Nov 03 18:50:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vd1og-0006xi-Mb
	for gcvg-git-2@plane.gmane.org; Sun, 03 Nov 2013 18:50:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753863Ab3KCRuX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Nov 2013 12:50:23 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:33536 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753355Ab3KCRuW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Nov 2013 12:50:22 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:b0ef:4a47:7a46:7dd2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id A4D5C2807A;
	Sun,  3 Nov 2013 17:50:21 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1383494064-5653-2-git-send-email-boklm@mars-attacks.org>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.11-1-amd64)
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237271>


--X1bOJ3K7DJ5YkBrT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 03, 2013 at 04:54:17PM +0100, Nicolas Vigier wrote:
> diff --git a/sequencer.h b/sequencer.h
> index 1fc22dcabe13..db43e9cf86dc 100644
> --- a/sequencer.h
> +++ b/sequencer.h
> @@ -37,6 +37,8 @@ struct replay_opts {
> =20
>  	int mainline;
> =20
> +	const char *gpg_sign;
> +
>  	/* Merge strategy */
>  	const char *strategy;
>  	const char **xopts;

One thing you're missing here is the ability to save and retrieve the
options.  You might be cherry-picking or reverting multiple commits and
get interrupted (maybe one is already applied) and need to use
--continue.

So populate_options_cb and save_opts need to learn about this sequencer
option so that after --continue, commits continue to get signed.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--X1bOJ3K7DJ5YkBrT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.15 (GNU/Linux)

iQIcBAEBCgAGBQJSdozXAAoJEL9TXYEfUvaLFDwQALvnJMKwFn5Ik2Ki9Mc4PBMv
/gRO+bne7rMB+xdCl7MUDE8bDiVXxeoxQWxXqV4vEGiTE07rR80+wheKNR7IdyP4
AB0m7o+AOYUYivySdXPc2bg8AHGkpWvGGLJtdv9MFdyaaY5COFWgnEPLpH5mStM5
2MAXjV6Sa1WQUyxVIdb+afgCBm3PMyLuIegpIdCFvV9JvU9CehVVudva2zEI96Am
Z0Lw5NbkvVdm7IYMbA47h1O/oyjkoyllmUDGP13DOL8hJgs9N2auBEWsJoOheT5B
Q8EkI0VePXaytnBDW9M6WC7osixG9WUPVskU8FdVD3+xLW5Z0erLRZXhbeYqvBhK
jPTpK3LrFW3SyeOMcrF6wNqvqk4sF/KUGqT7RvzzmJFSlwg+jx5WMuJhsaUxF+iY
T4HgAVzy0B61UfmQKmvUs2616wfC3CO+icN5EEXwxcnn80aoHjJDx7J0lVTPBePP
eDRf5J8a5mDFvH10Ic7jYj/XVeoVx9+FFnhiXJ3pmM9JuoXwvDqI3JvmLeavXt5M
Y4Oo8U5LAmxSsbS1eorb74e9I7xcCBNL4clGQOKXGpJh0m/IE1UwZtBFoU9FG9LK
eUWeqEhmpOYlRdu0z2kzhToEwbm1n56uKG/exK02gAHOpHiPoHrCfTirFvTNEpto
jvh+MJFzaqKrlwLnFlkW
=x/p8
-----END PGP SIGNATURE-----

--X1bOJ3K7DJ5YkBrT--
