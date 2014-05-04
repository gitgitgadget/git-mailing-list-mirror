From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/3] Silence a bunch of format-zero-length warnings
Date: Sun, 4 May 2014 19:01:22 +0000
Message-ID: <20140504190121.GP75770@vauxhall.crustytoothpaste.net>
References: <1399183975-2346-1-git-send-email-felipe.contreras@gmail.com>
 <1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dT+85zccSFkyJC53"
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 04 21:01:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wh1fI-0004qT-UU
	for gcvg-git-2@plane.gmane.org; Sun, 04 May 2014 21:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280AbaEDTB2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 May 2014 15:01:28 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47549 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752028AbaEDTB2 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 May 2014 15:01:28 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:285a:6bfa:4cc0:fb21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 97DD828087;
	Sun,  4 May 2014 19:01:27 +0000 (UTC)
Mail-Followup-To: Felipe Contreras <felipe.contreras@gmail.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1399183975-2346-4-git-send-email-felipe.contreras@gmail.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248107>


--dT+85zccSFkyJC53
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 04, 2014 at 01:12:55AM -0500, Felipe Contreras wrote:
> This is in gcc 4.9.0:
>=20
>   wt-status.c: In function =E2=80=98wt_status_print_unmerged_header=E2=80=
=99:
>   wt-status.c:191:2: warning: zero-length gnu_printf format string [-Wfor=
mat-zero-length]
>     status_printf_ln(s, c, "");
>     ^
>=20
> We could pass -Wno-format-zero-length, but it seems compiler-specific
> flags are frowned upon, so let's just avoid the warning altogether.

I believe these warnings existed before GCC 4.9 as well, but I'm not
opposed to the change.

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--dT+85zccSFkyJC53
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTZo6BAAoJEL9TXYEfUvaLMgQQAKCYPIDR0IKswAnY0V4lkbU1
FXp9RgKM05X+dHA6e3YwulP2u51f1BwlSx2yjT8/PMaYN+I20EtmQflOuHglwWad
72NmYva6YbhOQ93fjPh8FfatXSvP63RzZ320DySredON9OfFlLtdA7xoXoazAxQe
VWA9ekLWFNy6vZxst0V0pMGF6uGtcaihwysTuJmRaM5lzgO2oFJuq258gHtD812q
hwGCpGfJ1lUnokWDUl3lKTtUjgqU1QM48R5eZ6MF3USL406Z9sjdW+ywFsxdhD01
W98T+acm83S9q8CaRnBX5vDShZGrIvBog/vwyst7ZtNCGxBfP5cgP6YgDbDlKmWh
Z1bweA3Uavzo1irCVklIe70PHWXBVvjuVgDu5NYnrI192xx1Awv4CtdIlq3doA20
5uNkomLKDEE/sgrs57XW3zmuLgEyPhHuCQr+l0si5IlGsRwwGFtsOKPDkVNRSYth
21sS5l2VfNP8wUWTGl68OjqEP0Rte/0SUFRlitiCITtEEb1BCNBthkfgAbHu+ccm
M+xDgVjCSzwC/sRMe8ukcmGVNRgRJIwIhqOGhpp/5ZE/lfTX9fScN6Zy/2rYteEy
yE3rZ79kOlH+vFI7WCHXVLo3xSblIidB7ZhXXl9hum/RqWOiam4sk0nVmqafxGef
1RvqPMmuJy+39r0g1Mtd
=yepV
-----END PGP SIGNATURE-----

--dT+85zccSFkyJC53--
