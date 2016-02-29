From: =?UTF-8?B?TWljaGFsIMSMaWhhxZk=?= <michal@cihar.com>
Subject: Re: git cat-file -e behavior
Date: Mon, 29 Feb 2016 13:16:34 +0100
Message-ID: <56D436A2.4090202@cihar.com>
References: <56D41645.4050800@cihar.com>
 <20160229114455.GD29769@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="7IIWAN40HibidFCtQPWQmMkHF4KF9QsDs"
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Feb 29 13:16:47 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aaMkp-0004Or-GH
	for gcvg-git-2@plane.gmane.org; Mon, 29 Feb 2016 13:16:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752710AbcB2MQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 07:16:43 -0500
Received: from mort.cihar.com ([77.78.107.252]:54803 "EHLO mail.cihar.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752129AbcB2MQn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 07:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cihar.com; s=20150416;
	h=Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=MU3nMsaSr+h82VYk3V0oBIaYksUJk3fULSV7N27giT8=;
	b=bZbbYqHlwSDeQ5p1HPBfd4b7McUS2zrZXObJuEeeKRCINaJWuyirxcHWZdUGocBjlMzDobDHdjoTHLVC3GjLIPhhDAJEgEQU738r6gr1RY7PM8eNYMAlvfCvUFmCRXTc6/DukicE7rw/Uu8icaRZ7I03/tDPAdRgaXm7tgNxVmg=;
Received: from 127.0.0.1 (helo=authenticated.u-s-e-r)
	by mail.cihar.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
	(Exim 4.84)
	(envelope-from <michal@cihar.com>)
	id 1aaMkg-00024z-5J; Mon, 29 Feb 2016 13:16:38 +0100
Received: from [::1]
	by nutt with esmtp (Exim 4.86)
	(envelope-from <michal@cihar.com>)
	id 1aaMkd-0004Ub-06; Mon, 29 Feb 2016 13:16:35 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Icedove/38.6.0
In-Reply-To: <20160229114455.GD29769@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287830>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7IIWAN40HibidFCtQPWQmMkHF4KF9QsDs
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi

Dne 29.2.2016 v 12:44 Jeff King napsal(a):
> It looks like it has been this way forever. The first thing we do with
> the object is resolve its name to a sha1, and that's where the error yo=
u
> see comes from. And then we actually check whether we have the object.
>=20
> I think the intended use was to feed it a sha1 to see if it exists. The=
n
> the name-resolution step is a noop.

I found this as best way to check whether file exists in branch.
Checking git ls-tree output seems less error prone than checking return
value of git cat-file -e...

> I'm not sure if the behavior you are seeing is all that bad (the
> documentation could be read as suppressing the normal stdout output, bu=
t
> error messages remain),=20

I understand this, that's why I'm asking whether it's expected output or
not :-).

--=20
	Michal =C4=8Ciha=C5=99 | http://cihar.com | http://blog.cihar.com


--7IIWAN40HibidFCtQPWQmMkHF4KF9QsDs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJW1DaiAAoJEPSqIp1NWMJFjs4P+wYVt+UTDxBemkek3lbG3SC9
UbEhQlPl091PdA0YMG/pJlszHqwTvcua/6wmQoZtpKRvDT4cLU4z4V5UZXSwR3C9
1yETsdkTQmyHFj5/BsH2zJ0DV/POjxTziIk3T4VZ4D6ci/V0fTyIvxUHJzGzbpr/
fS5ES4UfFcSUjAFdEFfB4HK0xpGh/kt5KJIUSc2FsF4ZlpTvbAw/S3eepwFboQtE
931sQ7FRhwGHrpTUEPTwhAQ3iI7ab2JrmFVRKtjs1olM4h64sqClKsqdctwvAun0
QXWgAFyu7jnv4dKnWTcWGjodf47HA0JrOgiz3JhQ4H8QauVTxvxpbuiyY8ykFjN0
3fd9d8+A1Q7vMSKq9DGOF0uL2Czjux0V1IoNfcIrAq2FWD9YeJbGCeo3SSFE15Tr
DyN6CjW/KQtTdoU/SZ+Q52MHb6oNQiPOU+ZFVV4tK+sfQyPjirat41zHR8uJh8OG
+2+M6ssz8uILjXfEvcmDtcqxwI8ad2XMBnCFBJanxDqGUvjObez27rNZRnJhYg4/
B0qDlO6B9xHk+34N07iZEm/SPIFAFPyabrs8FjcFMaiJ0GQE3USVM3z+ntZuwdWz
ltmXhDEuevE7bBUege2R/zDz+hjBFGrzY4GLv1aCVz1g0BQlXLmDeuKsnuOTHuvt
Gn4rzyfzG8cMF3RQcdIY
=0Vya
-----END PGP SIGNATURE-----

--7IIWAN40HibidFCtQPWQmMkHF4KF9QsDs--
