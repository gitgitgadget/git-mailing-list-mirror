Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794613702;
	b=yAQ+DMNL5q74YwWaZmShEWtvfdM4NHlV7zKg+ErX4F68OoN/W7TOBRC9eDIwuCwlRqGQ
	 Li1XbikwPWY0WjANS6d9L+6d2pzTWxm2At3A8erTyIaRrdQEOpE2Y4NNSTWFy9fhf8NW9
	 6xhWACqDP5muN+ujztNuvpBBNTwKlbUEhzmFXokbgneW4e7C/VDUtPVjLZ2dQrjkFXyKA
	 RX1udpdxGGl/XgLgxV703VyqBf08xSePVA10J+r74FImguWvrNeu9ktMYN6jEhnHhq+ny
	 Z0Y6OMPaseHgp96OZQtxuUTrpMsoQHiEIvZAWBCDdQ2PX7D5ZQicqaNa1jDJNNIRwjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794613702;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=IRyzp/QMN4iQN5N7N8merNqe40gIoR5rfiNCLq9oKcQ=;
	b=rdOXmkEuHDHnn1cJ2zjjM6ehKkrH7Y5SYvb5LN+7MSdDfKqklu4FiiAVK+IZpuPJIrpZ
	 plWcb/9gQuAwQ4Q/V9eO81eltKWPMov07pSDBcwTkv+I5lL2st5UFReRQMuyQLF2EsWWs
	 d3b0ed8uTlos5LRyr83iyMGvtLP2wwTUpjMDkn3At6uhKQIIdjavfOeMAse71gse42L6W
	 2GWM7msLpdHEarWQmqc6EkaEXRMBBRUl5se/tj1FJ/6IiEO7smbwHJqo+7NZa+XFw1rFY
	 gnkFQSN+Gu8JlpcgGQsif5MudQB0yqTf0HkNukzXQEPjCwUWRGq/na5NtRnFtfpYHdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=0rPBhARK;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4F2606A885
	for <git@vger.kernel.org>; Fri, 13 Nov 2026 23:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5F4F2606A885
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=0rPBhARK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1794613700;
	bh=cQhdFzZL+SCU7Z7ZqWL5rT8nnd1Oql6yy/FCy6v7lD0=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=0rPBhARKbfMH+MzJy6LIqDRCZPV4JRgvuaxUY98iP+Xv4Sqtgf320k0mPEqIeCLE9
	 2cYJwbRuOTROoAJlfOQezSY8WImugi2Mj4cSOO7Wa1k1ml7fbyHcTfhl47DwfmCPHk
	 gf9X4rZjHOqA5ieI/2v0PiwRYJgO6RSy+IRBFUgwXsGbnBSZeG2xMrUui/AA4oC1LP
	 79zukmbYoQtU91mRl8vliLFWPVS5x1TW/uUnV/BUTHEZeUazvUkJen3hREIozZnq+8
	 PSqbp+Andt6ZaBSQknr9EX6+xvA9jtIHzQYq9fYdxn9x+9/eOTvN8XuKBNaGnYK1C5
	 b9J9UNyUatECI3rKHDuQVqpc2F7KowvUiGIPNcqkOoH9NmOGr+PZWetWz6BzJlqOok
	 LWSkwqtvgGRQ+Ji0HhZIai0Issghe4olIsrEmTeIlZbdppsXTg+bOAkifL0yZfbXLI
	 1FjKl9ZowGC/2GaejeovtCuXIZ/qHPrO79uJI0AEhCqLcP9lQTq
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:f0c7:7240:9733:e326])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E8681200AA;
	Fri, 13 Nov 2026 23:48:20 +0000 (UTC)
Date: Fri, 13 Nov 2026 23:48:19 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2026, #05)
Message-ID: <avehwsI-uOJ6DldC@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqpkw9fwc1.fsf@gitster.g>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LDEfPPdBngUFlzsl"
Content-Disposition: inline
In-Reply-To: <xmqqpkw9fwc1.fsf@gitster.g>
User-Agent: Mutt/2.4.1 (2026-07-04)

--LDEfPPdBngUFlzsl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-11-12 at 23:45:18, Junio C Hamano wrote:
> * bc/setup-default-hash-algo (2026-11-07) 1 commit
>  - setup: default hash algo to GIT_HASH_DEFAULT
>=20
>  The object format initialization in 'git init' has been updated to
>  use the default hash algorithm compiled into the binary, ensuring
>  new repositories use 'sha256' when breaking changes are enabled.
>  Waiting for response.
>  cf. <xmqqik274201.fsf@gitster.g>
>  source: <20261108011633.1772000-1-sandals@crustytoothpaste.net>

I just sent a v2 of this.

> * bc/restrict-hex-to-lowercase (2026-09-07) 7 commits
>  - hex: allow only lowercase object IDs in breaking changes mode
>  - t5324: adjust tests for corrupt commit-graph
>  - object-name: use hexval
>  - hex: label usages of hex parsing for object IDs
>  - hex: make hex_to_bytes accept kind of hex to use
>  - hex: allow specifying hex type with hex2chr
>  - hex: add functionality for lowercase-only hex
>=20
>  The parser for hex object names has been updated to reject uppercase
>  hexadecimal characters when running in the breaking changes mode, in
>  preparation for Git 3.0.
>=20
>  Needs review.
>  source: <20260907195941.1024289-1-sandals@crustytoothpaste.net>

I would love a review if someone can provide one.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA
Speaking for myself only

--LDEfPPdBngUFlzsl
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8Fgmr3ocIJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ/B+E6W4RRgTBGWN8mMHcg6sW7NY7D4JHAC7qIminGc8
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAJLYAQCAgQ8PCadgb2o+p3oxnyyURL/S
dkEWK+ZaOKLaQ7y8cgD8Cw+Lk758Ckov+1yUOSRk+U/zyQU5z1uppMojBATPmA4=
=Q6xC
-----END PGP SIGNATURE-----

--LDEfPPdBngUFlzsl--
