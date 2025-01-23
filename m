Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9551435943
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 00:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737592453; cv=none; b=iPiyfnzttcNkhGMCR8qit3/ihxKJLNjc5ZpdTzlH3Eklu7BusMUOb5Ivhu6UYELpNE2CV3TaVJT7GkH9YcuCbMSwg8aOMJKKtLmzmRXJGlvpK+ZY9O3+a2IhhvErkMyLzM0nVjolP/jyiS4eolbVgW/UChohmnpK0HaZxsS9qnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737592453; c=relaxed/simple;
	bh=t9FYJxIc+zSnpcx8yTvUOhPzhe6pNbW4U9PypssnQGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bvLcK9PhNO1zD8K6/+SouVcmFeoI+bUuWcZsUTwWnHsj2UgSfgIWNTGg2fXk+kLoBv07K+yR7Ka1+urZ/Z7cQqAImvw4rr+POY5FzNZQ8weGftmcTfCQV/IdZqPn1AA4Vq7ivodrH1R5ChSm3CY9Uja2VRzguFQJqFDPwQvO6I0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=lU+9hmfP; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="lU+9hmfP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1737592448;
	bh=t9FYJxIc+zSnpcx8yTvUOhPzhe6pNbW4U9PypssnQGs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=lU+9hmfPiaPw9nKJuf+JqfA5qlc051Q3PlaBqW4bqpPIelGESCnGHOnb/H2p/5RXQ
	 bw5O+Mas+xRT21OrTKRfg8gg+TNlqVWq3mchQjV+fNYKPrZll/T8EsDK3n2ZkW/G7c
	 bTJ/rjIY5mLki1mAyu7LBNw0H723a9CpxidDS2wNWTiF//Ck8JiyAhuyIq9rXDQCh4
	 T2gqFj7SAcLq4VzarXiIXoeShM0PaKYBFMGTI+6M902IFDElC88Hd16loC4GY+9bjz
	 6BNuIKPhD8MnMtCzKmG0CzAAKliugWlmuw8RruD1BpEwQXrKU/gmFlp872+HQTl1zf
	 Fth+j4WMDKiXMW0oA5iijGEgHG6QOjCXARCJvceR4wbCdBhLXe/ai6f7mAJKqYRJZ8
	 Nzg5tcuCSQ2gl8lIt4ZaqwNoMxR9fC5yxbY6XegYJnIi7wePbNrOm8PBThDoTvlZL2
	 Vj/SkdpPa8OohnfOv66bvDF/QO/jsk8Yt/Os+lhbO+guzFSoCk1
Received: from tapette.crustytoothpaste.net (ipagstaticip-2d4b363b-56b8-9979-23b8-fd468af1db4c.sdsl.bell.ca [142.112.6.242])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 997B620033;
	Thu, 23 Jan 2025 00:34:08 +0000 (UTC)
Date: Thu, 23 Jan 2025 00:34:07 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Andrew Carter via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Andrew Carter <andrew@emailcarter.com>
Subject: Re: [PATCH] docs: indicate http.sslCertType and sslKeyType
Message-ID: <Z5GOfwBR7JBloIs0@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Andrew Carter via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, Andrew Carter <andrew@emailcarter.com>
References: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="XEBuqJcdZ1BZJSsr"
Content-Disposition: inline
In-Reply-To: <pull.1854.git.1737591366672.gitgitgadget@gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--XEBuqJcdZ1BZJSsr
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-01-23 at 00:16:06, Andrew Carter via GitGitGadget wrote:
> diff --git a/Documentation/config/http.txt b/Documentation/config/http.txt
> index a14371b5c96..cd39e182527 100644
> --- a/Documentation/config/http.txt
> +++ b/Documentation/config/http.txt
> @@ -216,6 +216,18 @@ http.sslBackend::
>  	This option is ignored if cURL lacks support for choosing the SSL
>  	backend at runtime.
> =20
> +http.sslCertType::
> +	Type of client certificate used when fetching or pushing over HTTPS.
> +	(e.g. "PEM", "DER", or "P12"). See also libcurl `CURLOPT_SSLCERTTYPE`
> +	Can be overridden by the `GIT_SSL_CERT_TYPE` environment variable.
> +
> +http.sslKeyType::
> +	Type of client private key used when fetching or pushing over HTTPS.
> +	(e.g. "PEM", "DER", or "ENG"). Particularly useful when set to "ENG"
> +	for authenticating with PKCS#11 tokens. See also libcurl
> +	`CURLOPT_SSLCERTTYPE` . Can be overridden by the `GIT_SSL_KEY_TYPE`
> +	environment variable.

Are there any particular limitations on these values that are platform-
or backend-specific that we should document?  For instance, I seem to
recall that at some point PKCS#12 files were limited to schannel or
Windows, although I could be mistaken.

Do we also have documentation for whatever engine parameter is required
according to the libcurl documentation?
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--XEBuqJcdZ1BZJSsr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ5GOfwAKCRB8DEliiIei
genYAP9KIyvYZCud6bPHGlD5QYtvz93EmHXhAlIRvlkGZn90fwD/QUyBSDP5YlJE
xK87GHJpMb2/HjzR+LXVViA1eajjsA0=
=4aTt
-----END PGP SIGNATURE-----

--XEBuqJcdZ1BZJSsr--
