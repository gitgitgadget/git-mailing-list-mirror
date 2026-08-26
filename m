Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E063B960F
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 21:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787781354; cv=none; b=nXMQbjtwLFsrSr1rdYKUTt4EorRHCyNMLJwtFurXPLtibrqfl1mw2Esba+A30uWc+2ZSo10ERHS8Gyb921FmQeKDOAvRnASF4/e7NIfqBSumD0M18V9y8CWi/9YreC22gCsYTHBtMvjcI+x1bgrxFvuEKyHpm7f8OZ+UpTWgJzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787781354; c=relaxed/simple;
	bh=Lbhwc1BXHkE39AtMlt4TfeRe5rNy5/H+FM76NsauTqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rvYGLKLlKb9uRIRxr/Oa8FW/t69YtgR1fFjojnVsbQYkbb6nplbA8jKsnfPvfVlEUXw4m8bqUVkbnziy8AsI+9QodqZcGpRsavQvI3/ENtHvmBHOiGVIKWs4nfrskv0y1MugVr2Hvp1fgULX3zKC2TQAeWiJzdLxPUZc9FSqDfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=yQzgU1pG; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="yQzgU1pG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1787781344;
	bh=Lbhwc1BXHkE39AtMlt4TfeRe5rNy5/H+FM76NsauTqU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=yQzgU1pG59hdX22pKF72a7RwJOaMD6M1YTlIcjUMm2nCg3ay//Rcbk98djulImcrn
	 BMh3ky2rOF3hc0I1uRWdjot2yYYWpYyyAF0Y7Mk1vS5S347tej1pM+pdRbDYBt7E75
	 gxuUJqigx6Kz/HIFqzU0h7nz3IYnMe1IVUBrVgVr8WHkta1EFL1O8nfp6OBFn78cwc
	 5d7PWBthUCR2B1Opw2VD/2tEHD61mV9APwZJCeIdATmq/7Dmb5uuo1FDtEiaJIaaVj
	 ZPTfx0nwH9kX+k5mNx+S0GnJBLUj65iXmVKLqasJ+2Fw7PwhTDZRQ9QVRuoec7g0xN
	 FxzNJkj9JbCVmjuLVxhPtENZ+uTBAmtb35Azld+Ar6qv/FNHqM8ARJffOPPg8gfUdx
	 GZ4iKuw/L78gpfi+9OduhzzAWPqzBvE3j85b3q+vRBxzU+uxA5fgGTfmUicRUP0DYh
	 g7Iuo3booLI7GpQZKEhjfelv4hl4fhlFIqmVtNJVrLau5SL6QGV
Received: from fruit.crustytoothpaste.net (pool-99-237-158-163.cpe.net.cable.rogers.com [99.237.158.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 6F13320101;
	Wed, 26 Aug 2026 21:55:44 +0000 (UTC)
Date: Wed, 26 Aug 2026 21:55:41 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitk: discourage AI contributions
Message-ID: <ao9g3AaGJGQR0N_p@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
References: <b4ce8b09-5faa-4e6e-af38-5384a71ae699@kdbg.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yM3DHJXI4brFDnS7"
Content-Disposition: inline
In-Reply-To: <b4ce8b09-5faa-4e6e-af38-5384a71ae699@kdbg.org>
User-Agent: Mutt/2.4.1 (2026-07-04)

--yM3DHJXI4brFDnS7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-08-23 at 09:25:42, Johannes Sixt wrote:
> +Please do not submit work that originated from AI, because this project
> +is down-streamed to the Git project, which has a rather
> +[strict AI guideline](https://git-scm.com/docs/SubmittingPatches#ai).
> +

I think this seems like the right thing to do.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--yM3DHJXI4brFDnS7
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqPYNwJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5sTpZoSsEWqQkDgHo1SOk22UbmrB3YrceYekR6NHnik
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAPQpAQCJk6u09SCAg5DJQ4zIARxxuN4+
4rcluGw+Suug7cTyfwEAh3Iowdwq+q7dgHC261xU+0sIXMDDBTY0ZHDsqF1eGg4=
=L1ng
-----END PGP SIGNATURE-----

--yM3DHJXI4brFDnS7--
