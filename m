From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/3] format-patch: introduce option to suppress commit
 hashes
Date: Tue, 15 Dec 2015 00:35:04 +0000
Message-ID: <20151215003504.GN990758@vauxhall.crustytoothpaste.net>
References: <1450027638-788102-1-git-send-email-sandals@crustytoothpaste.net>
 <20151214213239.GH14788@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="8MZM6zh5Bb05FW+3"
Cc: git@vger.kernel.org, Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 01:35:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8daI-0002ei-3Z
	for gcvg-git-2@plane.gmane.org; Tue, 15 Dec 2015 01:35:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050AbbLOAfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 19:35:14 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47106 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933023AbbLOAfL (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Dec 2015 19:35:11 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:f2de:f1ff:feb8:36fd])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id EBAB6282CA;
	Tue, 15 Dec 2015 00:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
	s=default; t=1450139709;
	bh=pnOR9GK7cK4ww78TthA/SX8O4jyg7X91hjwELdmufUw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CB2KUxE02rfW6pyG77enWQDspj4iA0VATxa5AUVoHfZKqPh2tzYtt3X2wdctg1DZ+
	 4OtdH3vUtcJIa9cyfEy/I1SQuLwLa/wHNZISiwhG9iFAMKP/o9D3Hn1pQK6R8S3FSM
	 gUXoAohKZ39E+YqbDlbQKT06fUaUGlvI4VFUsLBbMmG+JeuWDNIbwojCjIKvhmvgcc
	 5EhK7GDhOpFgR70c1nv8MOKTukJ3PBBFFrvJtebJh28ESM2B4rBVtXUFDpPjPkVRTk
	 HLA+zPQXKc4XiuTvfE0Ia7nOPaN/eGN7Dve6ApG5zRhxUgFc6FKo5sBI1QZ+8njuzh
	 vm43fkYTxU4rknJ8dxgRpSO7hZ8dtgcmWei0/yZVjlEH1EPNq2cpKdC5ywNeOxRHxx
	 6Vhkub6fJSITCN2Uew02m4osNBgo/3w1qbGZeqRIIT/kDMCuveK4QQTfuuJoNthERh
	 yQhWOYRnLsYfP4aCIfB8+zt2HmMi0OanY2o0Zy6oezJLPIaiT51
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <20151214213239.GH14788@sigill.intra.peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 4.2.0-1-amd64)
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Spam-Score: -0.262 BAYES_00,RDNS_NONE,T_DKIM_INVALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282458>


--8MZM6zh5Bb05FW+3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 14, 2015 at 04:32:39PM -0500, Jeff King wrote:
> The intent here makes sense to me, and with the exception of the
> test_line_count thing that Torsten mentioned, the code looks good.
>=20
> I briefly wondered if the option should simply be "--diffable" or
> something like that, and trigger this new behavior as well as implying
> --no-signature. Along with any other relevant options (if any; I don't
> recall if --stat-width is terminal-dependent for format-patch, for
> example).
>=20
> But that is probably overkill. People can flip those switches
> individually if they want to (and even if somebody did want
> "--diffable", it may make sense to build it on top, so they can flip the
> zero-commit thing individually if they want).

That does sound like a potentially worthwhile thing to build on top at
some point.

I'll reroll with the other suggested changes and a slight tweak to make
the tests less dependent on the history in both cases.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--8MZM6zh5Bb05FW+3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.10 (GNU/Linux)

iQIcBAEBCgAGBQJWb2A4AAoJEL9TXYEfUvaLpS8P/2E69XksMTMqyS/Ae5688gsB
2pyrcrI7dsPXF/KdTMrwdXuJ2gYQv8EFT/u08JKGc4S05vsQQpxit51OjN6fotcC
U/nexe5JXLmkl+eAfXsUiw/Q/JX9gHiEaNqX+rPG2f37rq8rKI2vbTjblDb9ONuH
fXRLcparvLxzrckPKpG7a+VADDMAstEw87HRR7ElxUozjkD/uEaRNZ718AdBa3Qd
PiCXEbr9dQA+RolVT8+h2h4YkmAVZAf76HGEsG3N7aGWJqgQy/yOKwsKv0DzGho4
iCw8MQ0tnofMWBwvNetdVnLusIWPJ2FrBM98TLYo3EC/NIUGUV49MOMrLA2c/eXz
YKWL3DBGxdEziZoYE9JNO3cpGVIiXb8Zb+MXSLGuDALsKqgFtxn5QUb5tcdPIMd8
Nc0MkUOFO4giOieO7uRaW2hPC064LblGkJ3ERSFynHcqBuQILv5GPksVXmY1b4G1
I95N4IfZB+XkY73/BHa8FZZASZPE+5hh9TxdjVVA+cb8YiKn6Oem0gsWaOXKuPAk
0WFLfUaG0I52mjx8CoQd9dsuhvKdwsepgsXOfR2q0xLO+scABfnAdlZr23fwyrhS
EofM3FN9VyB6jfXxM8wDOJqWXqKEhUdATA2sf8CkhiHQ9v+Dvd08LpFzzJw01yRV
eFHR4T7ASwciAOVrGAX8
=bM56
-----END PGP SIGNATURE-----

--8MZM6zh5Bb05FW+3--
