Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96DB5217F55
	for <git@vger.kernel.org>; Tue, 30 Sep 2025 15:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245446; cv=none; b=P7MhcWsQMqNX4+nOeKJosV2dz4aoM9LElV2jvTf5SWePnb32e4QV+mrTDCp6a2Pl94XAeCFzquWOOmGFKK4X/97C4Cqy5f7DP5SKLhx0YGHshsK15MlKSWwA9sXGmKJNYyQOnU87t0/VwrYqnrWd4Od+SNCsPMrnMbBN6slefm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245446; c=relaxed/simple;
	bh=vWoC+BqZnEqkcmdBg0MliZPPFuh1KD9PTwXLCze97kM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PhNyH5b5/UFrNTUEj33GD2KNLaT6n7B/ygVTUDI/qynBich1e4ocJaVPCQZW9nxtXjxIDNt4wRNcFEiF91S+7ZYmGeUmZUGA/0h9e549OFVnPUVuDlNqQOaxBJSgbXF4N9qJC9kI1YAA+ZFtlnfrTn5pAymwY3vowph4GsGG9bE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=ytt9ChLm; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="ytt9ChLm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1759245443;
	bh=vWoC+BqZnEqkcmdBg0MliZPPFuh1KD9PTwXLCze97kM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=ytt9ChLmpE0mYH4wlT0OD0Ai3o4LFg6HaShrOJbJ1VTBbA+QeU7q1JaFHlZjEl18g
	 IC/fo/YJf2XU5gPujtfRAPHKhZCH1/1OEyI0KdbROzRNWXhTC8UpBPw0PuyIFuyQSg
	 oTqQdk9k1dg+f/uKobGcesNMV2qukL0NAgq7CbGXAGkBmlvi2xIWzOLi1hl/7MYndJ
	 j7QRUlewbzybosvQ5JN3cxNpsYmMvHkt5TTFEfQ+8YsgEqimxBDX6A8w10alaINQw9
	 +7W3jf3Ts1TXnl52cBOlb4cMkf6fWuhAC5r+YBnqXzitk3RO9yCKQBhyu1upyLCIzz
	 NiSRY7m9ZDHrEmmz2VyFgzYvKgdyOWGsM+0uiwkUyYSQQ7WrFRl6vDr3ihQOGK+0Uz
	 GKpk97rMeWY1XJ0mN1cZDkhpf2+lwCAY7VPiOG+oZe1bYd4x9k6MiW2bU9dsEYx3M2
	 DH43+aGb4MVUTGwwZmaf3/nTV1cwbAd+uQh4kbG6GO96+f4ZIMT
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:416b:3f41:6bad:4527])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 4D3F820117;
	Tue, 30 Sep 2025 15:17:23 +0000 (UTC)
Date: Tue, 30 Sep 2025 15:17:22 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Rasmus Villemoes <ravi@prevas.dk>
Cc: git@vger.kernel.org
Subject: Re: customizing "cherry picked from commit abcd" comment
Message-ID: <aNv0glRxXcviP5yH@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Rasmus Villemoes <ravi@prevas.dk>, git@vger.kernel.org
References: <87v7l18nnt.fsf@prevas.dk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ZpQOKag4T705K8E9"
Content-Disposition: inline
In-Reply-To: <87v7l18nnt.fsf@prevas.dk>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ZpQOKag4T705K8E9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-09-29 at 12:10:30, Rasmus Villemoes wrote:
> Is this something that others could find useful, or is it too niche? If
> the former, I'll try to cook up a patch, but I'd also like some input on
> what the semantics should be, or if there's some other idea for
> achieving the same thing without a custom callback.

I haven't looked, but I wonder if maybe you can use one of the commit
message hooks for this.  If you're creating that cherry pick, then you
might be able to automatically edit the message accordingly using some
sort of script.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ZpQOKag4T705K8E9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaNv0gQAKCRB8DEliiIei
geKbAQCxAhXJes3ZL4DM4gr4EaUiuWsMeBa4/U/jqNFXw1vEtgEApoXSmW8dip9P
SHAVE+3ajVp1Zaml+LjkYrzfZ7RGFgg=
=8Ojz
-----END PGP SIGNATURE-----

--ZpQOKag4T705K8E9--
