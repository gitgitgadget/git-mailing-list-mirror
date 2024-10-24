Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584EC156C74
	for <git@vger.kernel.org>; Thu, 24 Oct 2024 21:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729806802; cv=none; b=nShHHOgNKELhSXCWYI1P5ymrAZp8KKPcbOoDyzVANo1DsHxn5uXwG96Ad5FgrsoYdTi1+VR1zWgL5/rqK6FzQazx+mLsbp7NfgtVoelIdxOqG2EPAaQypYYzwe/FztyargFODO8vGhjBJzLsBK7szW9DVjtfZgzQm/L8Z4dJDH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729806802; c=relaxed/simple;
	bh=dMwPvxSBSw+9GRg5BTg6Nq+xVnJ/EtHKZI/AbHiPU7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ueHALFHU3c26LjWQdDHrep5kY+9meGBdCzCEF5o5fqbfhVQIMdSYmSyxkMM4/PQnjAGGpIf0m1IcZxZVJPWKygZSAofbb42bFPrR56UQOe7yoaSr/OkpUHxF5mCnQioZjVVgMxvW4OJMpWzl91gIeXxu7pqVI9CnG97fSrECILM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=XbBwt27F; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="XbBwt27F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1729806798;
	bh=dMwPvxSBSw+9GRg5BTg6Nq+xVnJ/EtHKZI/AbHiPU7Y=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=XbBwt27FHA/j2o6YIjAFaWK9m38QCz3IrGBb8yE7Tdzn83SIhMGOySp7CB4OaHYfh
	 Ah4fv0FWKu3cB9XTcCux5F63tevoYvEWJuvoQ3pz5HQBEaNwnuH2Vx1l7QDegyrvx0
	 sw6TLCBiYuJRPPY+6jaQGru3Uz9EgijwtpJxHhuA/W1oEzDglbd9uK5JPdWUWxFJ3a
	 dEck4DFnQz/8xN3dDaAqqRUnCaTdaQuFzyLaUI0kniCrQ+4RxqKQkmBgIN+kJ1XxRq
	 W8VeP1K2zgPL73Svn5eCfLid6sN36H9XciIJLjB12DFsVqNGKd2+7cHo/CKl8HleYs
	 kid8s/EB+72UHLybmte4szdF6DM4vO4FuWsfqfpBbuCUGre5ozJ8g9eLHfBCBIGklU
	 77U3Dm0yyLlxFxUX67OHpWebZWM/Kl7uo7JJhYBer1eQi5zhBfrE04AiAApNf/D6O6
	 VQx2t99t5D/IHpEa1OxJTwBuhJz0DxZB1RdDWa1l725zMZ+rnqs
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 58999200B1;
	Thu, 24 Oct 2024 21:53:18 +0000 (UTC)
Date: Thu, 24 Oct 2024 21:53:17 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/12] Update versions of libcurl and Perl
Message-ID: <ZxrBzT6lE47m_3Ia@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20241010235621.738239-1-sandals@crustytoothpaste.net>
 <20241023004600.1645313-1-sandals@crustytoothpaste.net>
 <ZxlZuxllqjAZfAZm@nand.local>
 <Zxnjt2QVwVTsYwvW@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/MM3aHcPnFyuNNiV"
Content-Disposition: inline
In-Reply-To: <Zxnjt2QVwVTsYwvW@pks.im>
User-Agent: Mutt/2.2.13 (2024-03-09)


--/MM3aHcPnFyuNNiV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-10-24 at 06:05:49, Patrick Steinhardt wrote:
> Note that this still breaks GitLab CI, as we exercise Ubuntu 16.04 there
> which doesn't have recent-enough versions of curl. This version has
> recently moved into Extended Security Maintenance mode, so the next LTS
> release would be Ubuntu 20.04.

Yes, I think we should add that on top.  I don't believe we should be
testing or supporting Ubuntu 16.04, so 20.04 would be the right version
to choose.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--/MM3aHcPnFyuNNiV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZxrBzQAKCRB8DEliiIei
gWt7AP0UozypzaacEWVzdC2f1Ywzg5ErpCaqNLPm575iOLmReAEA4DlwdZFcDF8g
Af76W4RIdCjJcwOnZjr6PqCoVMsB2QY=
=TpNf
-----END PGP SIGNATURE-----

--/MM3aHcPnFyuNNiV--
