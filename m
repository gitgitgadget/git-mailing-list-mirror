From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [GSoC][PATCH v2] log: forbid log --graph --no-walk
Date: Sat, 14 Mar 2015 23:47:19 +0000
Message-ID: <20150314234718.GA612775@vauxhall.crustytoothpaste.net>
References: <md5:Tyvg1g0l6oUcTR3FnSDstw==>
 <5504C533.7060304@norn.io>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Cc: git@vger.kernel.org, me@ikke.info, gitster@pobox.com, peff@peff.net
To: epilys <epilys@norn.io>
X-From: git-owner@vger.kernel.org Sun Mar 15 00:47:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YWvmD-0006Cy-7u
	for gcvg-git-2@plane.gmane.org; Sun, 15 Mar 2015 00:47:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751445AbbCNXrY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Mar 2015 19:47:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:50198 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750955AbbCNXrX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Mar 2015 19:47:23 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:8dad:5aaf:e3cd:b210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 7D0142808F;
	Sat, 14 Mar 2015 23:47:22 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	epilys <epilys@norn.io>, git@vger.kernel.org, me@ikke.info,
	gitster@pobox.com, peff@peff.net
Content-Disposition: inline
In-Reply-To: <5504C533.7060304@norn.io>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.19.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265467>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 15, 2015 at 01:33:07AM +0200, epilys wrote:
> diff --git a/builtin/log.c b/builtin/log.c
> index dd8f3fc..0194133 100644
> --- a/builtin/log.c
> +++ b/builtin/log.c
> @@ -155,6 +155,8 @@ static void cmd_log_init_finish(int argc, const char =
**argv, const char *prefix,
>  	memset(&w, 0, sizeof(w));
>  	userformat_find_requirements(NULL, &w);
> =20
> +    if (rev->graph && rev->no_walk)
> +        die("--graph and --no-walk are incompatible");

It looks like you indented here with four spaces instead of a tab.  We
prefer tabs in Git.

>  	if (!rev->show_notes_given && (!rev->pretty_given || w.notes))
>  		rev->show_notes =3D 1;
>  	if (rev->show_notes)
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 5f2b290..4dd939b 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -887,4 +887,8 @@ test_expect_success GPG 'log --graph --show-signature=
 for merged tag' '
>  	grep "^| | gpg: Good signature" actual
>  '
> =20
> +test_expect_success 'forbid log --graph --no-walk' '
> +    test_must_fail git log --graph --no-walk

And here as well.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVBMiGAAoJEL9TXYEfUvaLnuUQAKrCNnm74/cPg9c/Xuu5aYTG
mmziQBG/alTvkDsVV260/CsBbR9+1vsXRq9iO23ayyaajyftzUrt/h17i8kb6S+J
w8YgnNApXiDYGQoRMJwh+q9d1gcvJ/uKbKLJZ/V8M6DxRIS3JreejXxr1simMMdj
GZZ+IewSj+iazypxWPoQKf6qerVhnpsP6F15CvQQ3Mjw5mjKy6yg6a0TxjxNu2FK
c5ORlXDTrZ/I75KGFvk09JFrzKyiwqfUapxVlJfgseorCdslvHVhQ+Hf5sGlPmZ/
4benPHHWSjqOkaY3AUHWbIvGgRxqxFmkmZxav5BXa7tWthCDsZAMJ98d9jE241mq
lWxM8d394JldxYmvFet3JkIdtcFI0xS7+twH4y3lMfnPan8wpdXm317yrnslT+dV
3/qpUh/7jtkvySxn+/n88D2rB/gSELcTUhEtismbLTcx1k4gqAlT9lCIzabXin0R
+oAzX7G2/ZkUaiqi4NyhJy9HpEDiWxSDjjWzuokXn8+nN2n9JCOfNwNqzWUE3YYt
w7R/UCwW9Nmyz72w9Cyc3p67HvMFpjoq2qK8pFCeQg52oW6MZEEgUthF4Gkd2aNC
+osb4cdJFpqGPY9k9zAXsIL7GAWoh9sk19V6aQU9QR4utldmrWBQ5Kzda1KFp/de
9Okyt2DAEULzWpWMBizP
=TWmH
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
