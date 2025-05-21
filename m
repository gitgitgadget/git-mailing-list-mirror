Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0E72B9A9
	for <git@vger.kernel.org>; Wed, 21 May 2025 21:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747864640; cv=none; b=k8fhtKB5AIpz6nc3/j+27o0Mrrwal+Gugu1wgXJM+MtmUcYhN88XD5yD4PJMC0B+cNqGkJwXGaEY6A2tJMIa6HOCvbbHvDDsXO44U6hmEvCISG7a6OZnStEB4RPbI9alt9CbMNeqwVZ+WSeg+ojB6bn8ewtCZpGvRQm4cDYCPxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747864640; c=relaxed/simple;
	bh=4yRrZhFnmHtyP1h5+gP1oNcGcIFD/zjSR/UjmD8W0Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=byDB3VQj+BxinWEHyTv547M4KCgU/0FCnWyjKeSvBheyTbp0xys6rlJ4CbSkpIWRAmx9mAp6r8BBU2rRaCKthI6lnkJX+TBenTZe4lzdjwf1Ggzr8uieLV5QGuGcYMxGn9nEUlIB9CZPwgPSsx3tXz0/82L3/7+JyKHi+MI6JJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=o3ZaixOo; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="o3ZaixOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747864636;
	bh=4yRrZhFnmHtyP1h5+gP1oNcGcIFD/zjSR/UjmD8W0Xw=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=o3ZaixOoJB1IzNmcjZu2NAhH30Fcs0dWNEHLOq4lXsugkPF57/foyN0McCYRXVLL4
	 8Q0BLYhxc++t5F9+k9ujFfIg0tebYz/mWxfHoZC0b+rwJcBDtpOYaeNar7y6Wr7Xcg
	 UxWzMrkjjcAQMPA6RC2CF1QySJTfMZXFGiXFJO1KJkFtgFZomW4mvPeR8aQNgAaYzA
	 xZC2hhei57+g3dB4WkUZs1VtITq/Y9m2VkMCdeWRhou+f5A7I6qkFYH/aKyFYUjYLi
	 MAfBLCJnSszcVn6SwcbMFoS76OkhyfILBYwdIs6rqsRM0wVxP/2wOEZxO/KGfUfz0v
	 05jpwNBUiJTSBBhecpRxjhGN2OXgrGiDrL5xJCsGXu690t/E7oc3oVnONjb55uUOB1
	 A0L2JkoJaaAB9oiuwXKThxmDIU3ZhaGBPTW9fGf+pIOeQPA++Kkit36qVE9hEv2KXt
	 MqGrS+vmTtQu56RNAsnSNqpcyXlKSdnKpuY3QHNibGcPBgJjDEG
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:df25:78ac:1a43:dee8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 341F82010F;
	Wed, 21 May 2025 21:57:16 +0000 (UTC)
Date: Wed, 21 May 2025 21:57:14 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] help: inform about 'git update-git-for-windows' on
 Windows
Message-ID: <aC5MOl66YuIK1eyU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
References: <PN3PR01MB9597FDF30B7CE529985DE546B89FA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <PN3PR01MB9597AFD63B750703E90AD18BB89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7cHlQYFje5DVnvEo"
Content-Disposition: inline
In-Reply-To: <PN3PR01MB9597AFD63B750703E90AD18BB89EA@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--7cHlQYFje5DVnvEo
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-05-21 at 14:22:29, Aditya Garg wrote:
> diff --git a/help.c b/help.c
> index 6ef90838f1..238ed1913c 100644
> --- a/help.c
> +++ b/help.c
> @@ -355,6 +355,9 @@ void list_common_cmds_help(void)
>  	puts(_("These are common Git commands used in various situations:"));
>  	putchar('\n');
>  	print_cmd_by_category(common_categories, NULL);
> +#ifdef _WIN32
> +	printf("\n'git update-git-for-windows' can be used to update git.\n");
> +#endif

I don't think this belongs in our codebase.  It should instead be
carried as a patch in Git for Windows.  The reason is that there are a
variety of possible projects that compile for Windows=E2=80=94Git for Windo=
ws,
Cygwin, MINGW, etc.=E2=80=94and only one of them ships this binary.  It is =
even
possible for users to compile their own Windows binaries, which I know
is at least done by Microsoft as well as some Git contributors on
Windows.

This change might be misleading or incorrect as it might tell users to
invoke a binary which is not present or to update software in a way
which is not via the normal package mechanism.  For instance, telling a
MINGW or Cygwin user to run that command would not result in anything
useful or desired happening.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--7cHlQYFje5DVnvEo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmguTDoJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+6S0Yi11soZEyxC1HYXYF1Oxz4YKfGy3JB1KJw4Vlun
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAQ2AQCWxrFrx7PsVqnKS8pnneRS1a8M
o9shC7lLYtNIQMVY/gEAiSFIGY7HyunsXQGLWbFcn+bQ7RTNMU8Jp6F8TI3xLw4=
=MQbl
-----END PGP SIGNATURE-----

--7cHlQYFje5DVnvEo--
