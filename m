Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCBD1367
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 00:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740097101; cv=none; b=rwe8SEfBvX4dQwvC4NktQZsy25b6gR1Tekf1m+oYTPFcJBKOaRjcTx3V4mDQiwtbH/BLXEX2N0YIZUi0ApS4Gtiqni5eFm7YUVHA2PcfjBw9gHc+goHQykWCNY81THqZZkZex2n6KkWOC8JZeymV5VhYKvBbT+UotM57YsW6wus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740097101; c=relaxed/simple;
	bh=5DHJln8s/ml95jUiLEEIQIynxBqq0FqN7nE8zxDSJtU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hsyzN7FqT8bGWrN5EHuUWJfgmdCb5QNtD+q/7n217hi0+EJQIUaiJg5+nFblOMMFzodDuQkxUbnPa9ZMfZAYVuffHSHb7dvJx0sVF5rCHRJySMp6r64UXDsE8q6XDysWnrhBUIeMwaSedfc9EVGzklBi/fdNUESnAiKVipdO+8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=fY1JX7X0; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="fY1JX7X0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1740097090;
	bh=5DHJln8s/ml95jUiLEEIQIynxBqq0FqN7nE8zxDSJtU=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=fY1JX7X0W8CFEou57SqNgfQiIW5+/wA4ygdM8dNBPYMmWORz6YBBgM7M68SYLbREX
	 Bq9kdmgpWZ41yiuNH0wYBcg9Ed9PqLQkF5r78WRpRnKwHPK+cu7BXD21ms/0fMeoEJ
	 nOKaLVfIiMedWJSOHVtEsbbDuLpQ2O3clrkP0S/PMONRXSIq4teZvtc56WfSOTOVde
	 HNf8yqn25dLziRzSYpRV/f8rFjNodMEHvkySbfNeBtqGvtKnztHYTe/G/Th8kuLcdr
	 /OYSFiUTeNJS/f4p/UdfY1dzfXXPwW5KWd+YTTgeneN6EhQKWpsXicII9Mj9UCqcfX
	 ixMfYMH0Gfe9SOLyIuvn7GaLnN0kdweKFdXvs9N4+JCdFESwXaLO+UpvKHJTILn2gC
	 0h4R2yhzgvtISPgtdgpPqebQrYfC5jzKen6xsUAUrltLG/2d4wPy3QUojdyj42Aa76
	 Flasrt6Gwt89HslqBpNW9H5eB6g7x1p3ZKygXdO9ub7Vo80YkHp
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:49c7:e12c:a55a:81cc])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id E862B2008B;
	Fri, 21 Feb 2025 00:18:10 +0000 (UTC)
Date: Fri, 21 Feb 2025 00:18:09 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jamenson Espindula <jafesp@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: Deleting first commits; maintaining last commits
Message-ID: <Z7fGQalzCg_Fx-ub@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jamenson Espindula <jafesp@gmail.com>, git@vger.kernel.org
References: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fxI0rVzShdQvj4ai"
Content-Disposition: inline
In-Reply-To: <CAOW_YOkX8K=7i7w9c5oH5Cfia0kCzwC3=ok5E=eUwYgpcOKTRQ@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--fxI0rVzShdQvj4ai
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-02-20 at 22:53:06, Jamenson Espindula wrote:
> Hi all.

Hi,

> My Git repository on GitHub <https://github.com/espindula/br-blfs> has
> about 23,500 commits. However, there are several old (before Feb, 28
> 2022) commits I would like to delete and maintain the newer ones
> (after Feb, 28 2022). So, Is there any Git command (or combined
> commands) I could use?

No, Git doesn't offer such a thing.  Due to the use of cryptographic
hashes used, it would be impossible to verify the integrity of the
repository if it could just be truncated like that.  In addition, the
goal of Git as a version control system is to track history, not to
destroy it.

However, if the concern is size and not something else (like removing
personal information), then you could use a shallow clone to just
download a certain number of revisions and work on that.  The full
history would remain on the server, and you could still push newer
changes, but the size on your local machine would be smaller.  If you
need more history, you could use a partial clone instead if you're
willing to be online to work.

I'll note that 23,500 commits is not that many.  Git itself has 76,212
commits in my local copy, Linux has over 1,335,000, and I routinely work
on a work project with over 500,000.  Git should scale much farther than
that provided you don't have a really misshapen repository.
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--fxI0rVzShdQvj4ai
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.46 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZ7fGQQAKCRB8DEliiIei
gX7xAP9GtJgJ5b8czzeJ47rGHkyrLfPdq1Jw7HOq8Kgt5fCKfAEA7rSr5ABkpDs1
arTNSnAcFI1hLoi7Ty2CZgoz9IISTgw=
=pYjo
-----END PGP SIGNATURE-----

--fxI0rVzShdQvj4ai--
