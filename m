Received: from mx1.ddevault.org (mx1.ddevault.org [172.233.46.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34157524F
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 10:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.233.46.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751798532; cv=none; b=pZSSCAIM2qZo0Xxa2uSc7T0o0zURYVo1/g81upTFgOvZbPxvGFoH/zb9gN05ECsDlUjWTOD4f9/plLqGwslk5jyje6HRU7CZKNYL/hb9YFsI0+Szk3xVjNGKEUy/iabnUs4RHZd80SGwH4KEERHwUGk4rzHEUW51osq5CPu4Wlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751798532; c=relaxed/simple;
	bh=G67Igrr/Jzn9GT9xVeTctxvC4hV8ml0CITW2ofDddUI=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=pJB62wCXLzjEKstFCyTa0CXPyaOb5ZzubFp6mNqdORO3tpLm2LjyZ7fiho/rSaCfz8l15ilm4snjC/DK9ivJOiuAr2qPK7nSTlsv/okZWvt2nOlKhujkNkdEOeaHM+/rQItO3G1O0nsSpA8lWs6K+1k3Zvo6dg01T9q9xvr3cro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org; spf=pass smtp.mailfrom=ddevault.org; dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b=rZ+Qta+i; arc=none smtp.client-ip=172.233.46.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ddevault.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddevault.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ddevault.org header.i=@ddevault.org header.b="rZ+Qta+i"
DKIM-Signature: a=rsa-sha256; bh=G67Igrr/Jzn9GT9xVeTctxvC4hV8ml0CITW2ofDddUI=;
 c=relaxed/relaxed; d=ddevault.org;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@ddevault.org; s=default; t=1751798512; v=1; x=1752230512;
 b=rZ+Qta+ivOZyo47K9cYHikY5ia6/HqebiUbbWqfzd+r+eXF8AMupH3WbxWE3FDpMoDJ/YPWG
 wda4ieqqK1SNOQUzWy2ty491TmDe59GWq+Nq0lOtbD75ZGu5zZZe7MqX00N9yxYyu2xeIXIwiNX
 GJMzgxTnJIUvDKb9d4dGtQLhl9M17K3Km9xlkOJzt6KChjbNfJEUUrol2+q0edy6ujqehC/vKCB
 /F/WUwz6uL8Wd50DIysUEAeOuxT/RbkhxDofdfnHLcK2LOdgxGXgvx+WAVq/sGPo7yDU7T2wl1S
 OqJIZMUkqqLaeXqnPm12MLz6fKOOSu1iKmf7/Sqhj6arw==
Received: by mx1.ddevault.org (envelope-sender <drew@ddevault.org>) with
 ESMTPS id 50036ef4; Sun, 06 Jul 2025 10:41:52 +0000
Received: by taiga (Postfix, from userid 1000)
	id 8E02D70206F2; Sun, 06 Jul 2025 12:41:52 +0200 (CEST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ed32ec2aa1ec35589417f3001bf0e80796a28c0a16ca2306868da498ffde;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Sun, 06 Jul 2025 12:41:50 +0200
Message-Id: <DB4WQTRHWZN3.3VG20AZDK8VN@ddevault.org>
To: "Aditya Garg" <gargaditya08@live.com>, <git@vger.kernel.org>
Cc: "Martin von Zweigbergk" <martinvonz@google.com>, "Patrick Steinhardt"
 <ps@pks.im>, "Andy Koppe" <andy.koppe@gmail.com>, "Remo Senekowitsch"
 <remo@buenzli.dev>, "Jeff King" <peff@peff.net>
Subject: Re: [PATCH v2 1/2] pretty: add X-Change-ID to mail formats
From: "Drew DeVault" <drew@ddevault.org>
X-Mailer: aerc 0.20.1-64-g7cb8e0e7ce24-dirty
References: <20250703113505.11889-1-drew@ddevault.org>
 <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <PN3PR01MB9597069B8CF014BFE01B53F3B84CA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>

--ed32ec2aa1ec35589417f3001bf0e80796a28c0a16ca2306868da498ffde
Content-Type: multipart/mixed;
 boundary=c4cdfc0c9d137856efc8d35265d419de5950a305b99ca77728c12f1439e1

--c4cdfc0c9d137856efc8d35265d419de5950a305b99ca77728c12f1439e1
Content-Type: multipart/alternative;
 boundary=0aee5dec23518b94d44c62c453caa38fc0768658aee47aa6e2959dc9d4cd

--0aee5dec23518b94d44c62c453caa38fc0768658aee47aa6e2959dc9d4cd
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
Content-Type: text/plain; charset=UTF-8

On Sun Jul 6, 2025 at 8:20 AM CEST, Aditya Garg wrote:
> I don't think we should add it to email headers. There are many email pro=
viders
> which do not allow custom headers in the emails. For example if you are u=
sing
> protonmail bridge or any third party protonmail client, the headers are n=
ot
> preserved. Similarly, if you are using MS Graph to send emails, headers a=
re
> again not preserved. We should also consider cases when people use Thunde=
rbird,
> Mutt or something similar to send emails, rather than git send-email.

As far as I can tell, this isn't actually true. I looked into it and
protonmail and MS Graph both seem to support custom headers. I have also
verified that mutt will preserve the header when you edit the email
normally with mutt -H. If you're sending an email with Thunderbird, none
of these things are preserved (including From, Subject, etc), and the
best you can hope for is attaching the patch, in which case X-Change-ID
will be preserved unmolested.

Moreover, if the change-id header is lost, it's not the end of the
world, it just degrades to the present-day state of affairs, in which
you cannot use it to associate patches with prior versions.

> The headers IMO should include the standard ones like From, Subject etc.
> Custom headers should be a part of body, just like we do Signed-off-by, L=
ink etc.

Trailers and headers are different. The main point of the change-id
discussion earlier on this list was to avoid adding trailers.

I also suspect that if we added this as an "inbody header" that older
git implementations would ingest the X-Change-ID header into the commit
message, which is not a desirable behavior.

IMO the right way forward is to use a mail header.

--0aee5dec23518b94d44c62c453caa38fc0768658aee47aa6e2959dc9d4cd--

--c4cdfc0c9d137856efc8d35265d419de5950a305b99ca77728c12f1439e1
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename=42F3F1862E3CC4B8.asc
Content-Type: application/pgp-keys; charset=UTF-8

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgptRE1FWjdZOWt4WUpLd1lCQkFI
YVJ3OEJBUWRBL3BQeTZYK25OTDVUMlFhSktFTTA4eE4vS3o3d0ZUQVpvSDVZCnJpVjl4MW0wSUVS
eVpYY2dSR1ZXWVhWc2RDQThaSEpsZDBCa1pHVjJZWFZzZEM1dmNtYytpSk1FRXhZS0FEc0MKR3dN
RkN3a0lCd0lDSWdJR0ZRb0pDQXNDQkJZQ0F3RUNIZ2NDRjRBV0lRU2Z0ZWMzM0NXeW5ZN3NScEZD
OC9HRwpManpFdUFVQ1o3WTl3d0FLQ1JCQzgvR0dManpFdU1FRUFQOURIKzFMZ3ZUcVpETFo4YmFi
QjVDZHA1eTBaVytRClR4NzhtaDFMOGpKZDZnRUFzc21nc0ltY3JadjRhZFAyVVc1UlU1QkhDZTlL
VWR4MER5VjgzUXdsRkFTNE9BUm4KdGoyVEVnb3JCZ0VFQVpkVkFRVUJBUWRBR0FIOWRsYUNPTm9Y
cG1RZ0hvUWdZSTJ0UytWTTNtelU4STJQeVZZUQoxR1VEQVFnSGlIZ0VHQllLQUNBQ0d3d1dJUVNm
dGVjMzNDV3luWTdzUnBGQzgvR0dManpFdUFVQ1o3WTkxZ0FLCkNSQkM4L0dHTGp6RXVIY25BUDR5
ak9pTTB5cWtTVDZ5WHpEVVd6ZTdCOUltMjRGOEhWeCt3TnFjRGFEdGNBRC8KZktRaHowU0NQaWJs
TzZsYzdNRlV2bGFPejJ2ODdVcFVZUmh6UGRnUXF3az0KPWVtcmIKLS0tLS1FTkQgUEdQIFBVQkxJ
QyBLRVkgQkxPQ0stLS0tLQo=
--c4cdfc0c9d137856efc8d35265d419de5950a305b99ca77728c12f1439e1--

--ed32ec2aa1ec35589417f3001bf0e80796a28c0a16ca2306868da498ffde
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSftec33CWynY7sRpFC8/GGLjzEuAUCaGpS7gAKCRBC8/GGLjzE
uIZAAQDyO3WRQqtdKtWNsKB+1nCY1jY7Nyoszek05y/1Q2ce0QD5ASbk8ZDoyPek
S0254qP6gveOayqsPxFi32b+Npjk4Ak=
=ViJq
-----END PGP SIGNATURE-----

--ed32ec2aa1ec35589417f3001bf0e80796a28c0a16ca2306868da498ffde--
