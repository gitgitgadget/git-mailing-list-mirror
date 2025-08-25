Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ACF1DAC95
	for <git@vger.kernel.org>; Mon, 25 Aug 2025 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756162252; cv=none; b=IlaBpPwQNVNTniEswPuvMP2djByKviWnn59F6kbx8jvLtV1A27w5zmPTHZ9m+eZidriputetebHcS88i5a3GN7RCBPfJszxuTyo8nQHoPk+uv6aDzRsBcYqMpZAJp/VnH8tmnHZCkWBOkIzXa6eCjH2c2ArXf9dFx8zxfzBzLqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756162252; c=relaxed/simple;
	bh=tmSkOl1g6KoLA9tKA9FXpLXeSToW0OQIILCDS9J3MLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLc+eaafR4VmT8ybStH+8CO8a79tz2vig+A1wEwbPA2FIsQeLZh1jOoAfVr39wccvpPbXlcx4NO6pFtfMXTEo1G2U+NX6HobahHb90xp/TTEMzQA1GssURP36R8m9dXXFYoeEoSEMChvS0IViaHiAFDbOfMdodonSyfDJZdOUlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=QaGF8jOz; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="QaGF8jOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1756162250;
	bh=tmSkOl1g6KoLA9tKA9FXpLXeSToW0OQIILCDS9J3MLY=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=QaGF8jOz8gjZcnZ+oVsIAP/z6VcxfV/KxBYircZA/6crPEIukjecx0lkG1nzQRKUB
	 EaK/HmlPBJ0BnPa9/2AJkWZxy6iDvJDIHYEiM1hOE4gbf9K4IutIycOj5sJVOoX00x
	 L1DCZqa86a/bukSyw6E2QL4LUlq8Ehweo6vYkzh93jWCGbfM/vF7BUofSq7LfwOp7u
	 VJKE9EMdHkAsEDEKs4XFjnBquf2xWKrQukgWtbwbDVO17bo/dahQaoJNH6F0kFVt/2
	 fYPCkUebWnoYlUzffgifXlvRNbO6M6O4hKoGP1suOfbhyUDZRsRfXmsCK0t/MtPVRh
	 VRPkWuBQDqMyZponfDwHuG1DdzSA/APeE1JH7Hi1qZHa1jXZs/3zXEcUhEUA9Aa/xG
	 Dvn7jr88IXd8HgYKq9agCJBMVljQIQoXrq3Lin7u1UZJt2/ZHnIgXZG1U8E4IiugVo
	 /oTRavgjqeroaI9NyuzsXrITQLMmhM71nFtgaH8ww3fsTY8e/H7
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:5044:243e:8019:42f0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 26B1D200C3;
	Mon, 25 Aug 2025 22:50:50 +0000 (UTC)
Date: Mon, 25 Aug 2025 22:50:48 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2] docs: note that extensions.compatobjectformat is
 incomplete
Message-ID: <aKzoyFbdohhpiEzK@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20250823220601.336079-1-sandals@crustytoothpaste.net>
 <20250825221101.611876-1-sandals@crustytoothpaste.net>
 <xmqqms7nnhod.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6JgH7LrvvKjn3jUB"
Content-Disposition: inline
In-Reply-To: <xmqqms7nnhod.fsf@gitster.g>
User-Agent: Mutt/2.2.13 (2024-03-09)


--6JgH7LrvvKjn3jUB
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-08-25 at 22:46:26, Junio C Hamano wrote:
> Much better.  Let's further do "This option" -> "This extension", as
> all the others described in this document call themselves as such.

Great, I've just sent a v3 that does that.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--6JgH7LrvvKjn3jUB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaKzoyAAKCRB8DEliiIei
gYLyAQCn66phYh8qBL88kWBMIJ+ToBf8rKvjXQFwS5lj7xn9HAD9HloL8mYqeuIS
xMsuoI85grCPsxcdhVmnIA9LqvCUug4=
=Ewjt
-----END PGP SIGNATURE-----

--6JgH7LrvvKjn3jUB--
