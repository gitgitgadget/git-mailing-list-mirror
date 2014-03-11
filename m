From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 7/7] run-command: mark run_hook_with_custom_index as
 deprecated
Date: Tue, 11 Mar 2014 01:00:39 +0000
Message-ID: <20140311010039.GD4271@vauxhall.crustytoothpaste.net>
References: <1394477377-10994-1-git-send-email-benoit.pierre@gmail.com>
 <1394477377-10994-8-git-send-email-benoit.pierre@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wLAMOaPNJ0fu1fTG"
Cc: git@vger.kernel.org
To: Benoit Pierre <benoit.pierre@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 11 02:00:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNB3o-0001cT-C3
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 02:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754188AbaCKBAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2014 21:00:44 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:52494 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753840AbaCKBAn (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Mar 2014 21:00:43 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:7922:e1f9:69f1:ac6c])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EFEDE28074;
	Tue, 11 Mar 2014 01:00:42 +0000 (UTC)
Mail-Followup-To: Benoit Pierre <benoit.pierre@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1394477377-10994-8-git-send-email-benoit.pierre@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.13-1-amd64)
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243829>


--wLAMOaPNJ0fu1fTG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2014 at 07:49:37PM +0100, Benoit Pierre wrote:
> ---
>  run-command.h | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/run-command.h b/run-command.h
> index 88460f9..3653bfa 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -51,6 +51,7 @@ extern int run_hook_le(const char *const *env, const ch=
ar *name, ...);
>  extern int run_hook_ve(const char *const *env, const char *name, va_list=
 args);
> =20
>  LAST_ARG_MUST_BE_NULL
> +__attribute__((deprecated))

It doesn't appear that we use the deprecated attribute anywhere else in
the code.  Wouldn't it just be better to change the places that use this
and then remove the function altogether?  I imagine your current patch
might introduce a number of warnings that some people would rather
avoid.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--wLAMOaPNJ0fu1fTG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTHmA3AAoJEL9TXYEfUvaLXeoQAKDnmK8UTdC6BgYnLLU36X9T
4vxvzLW99H8OvxRildKrxihus3STNZHDytjOyTPs4LK/I7Wnxg9R+8Y2g5v/O7kZ
G42pkOx3zqGtfjUPm9riJ7z2WQoFkeHNyf+3GsWGHUhJFVUPMzBjYHKCJWJTfTNq
C8vN49otrBiBwV04AtrIwwHvpzhz89F7qOVGdZGRPjiIiERBI3tcc1syWFnqbuqU
9pDeisL+1GuUGUsY1V+GnC/yYDSEcAFWnRVftSoQPx6x3zo9CSfR/tEcFmem7liI
rsjJfyBNbFOic8/EgGwzLIc6bJfyPQMrpxazVsg4fsFw52lm6+ceQ+hDB4Li+UCV
nkfZtXAnxNXeImMainZrd0+P2E+Z8GGbq2GsBZQrRPQ506LdfTmRsjzINyx9j3rz
IQLA2ZwgPIncDx1a7zQQzK/RA0xMQw6An81LVX+al5C2xuhPvMFHXsn0peRMnCXP
n25eqF3XmCteR3vZLpCSRw9sPcApNmTDBR6QRplOabSJvd+hLr/JJK2Ar7n1rRFB
SolkbMUHo/hMuldpLDaEdvfWWbMpg1Bh8xea9Bwxd7Hfauz7Mhdi/i/iEUP5Qzf8
vHzlG5WtiMRUqRWiZ9nGcC2FjY0fATDrnvJwXAKb8MzNaZ3HcRjlOtCkNpjfdiTz
ddBvIdsjKSQAfa1NIR8v
=QZEd
-----END PGP SIGNATURE-----

--wLAMOaPNJ0fu1fTG--
