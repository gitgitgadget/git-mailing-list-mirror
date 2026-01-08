Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A14226E70E
	for <git@vger.kernel.org>; Thu,  8 Jan 2026 23:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767914536; cv=none; b=IgsCo5nKaimSsBdj66nU/pj3Ywp9lby7pIkws3KzdAyMDK+xMjLpImohV1FhUXye5KeM+d2i1qt2cJ0kwi+0abF2HQy5Nv6W64i5TisB5H13UnkokUwqXEbcW0y/E3ehIEOr1B8f9+PC08tc8opmb8cK1g8S99x9IuPnpHQjKLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767914536; c=relaxed/simple;
	bh=xCnhWa4gbAy0SwrTb67vCCihSececnlV2qJxH+QV9MM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qALjXp/aQZk6ezjkUPiEmj865OiZ9gDCCTIF6rrAlzqNLTfpWqtyLoGm7E/dlNghns+qj5V0iIjuKrOJv1PiYF7kk8yS4kIoi6q7mq2tR/ftHuy+3aG78dUs98cJ9DpRjATWHSVO7tDNMOT9Q4mCUvu7lu5zEMS6N5RXzTV0B8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O+ycqAZx; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O+ycqAZx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1767914533;
	bh=xCnhWa4gbAy0SwrTb67vCCihSececnlV2qJxH+QV9MM=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=O+ycqAZxFrOGKlp77k53NabS6YhjHMg0l8scLTP6/bUFgsU+0ibFO1a/DpI2lGpjs
	 jxzfWT4We4nzuLdzsGUghr+Z+ef+FGXOe/OaRqL5JxFQx5EguiT5KkmgJ2GkeMA4eh
	 8HXBFLnX4fg7Q+70PIMUN23te1Th9wjl7mdO6gk46PJ5E/euGn3jpZlBLuFVN1o3UV
	 jMxZYOdds39SAB2zvvG4a9d3L1SxOzjBZJwWxl6Ta2R6pBxDzb/FKw7PSrLsqXtca+
	 dmSIapaB+qqicHP2ig692DW3klIiLsK1bgv8NU7sc0ZEkZbhDKMWUZNRQuSitRz8u7
	 sHj2D92ISntv2rKQpQWvzroXUTvCvk/jsFLxIG3mzCZESWQnnVj73hxWNgj6Vw+25b
	 jcyczPx414p7N793CDgZ80NWnePEu1eZKtUGk3l8+SPgzkNMe01/OA6vIv+iA5gWRi
	 cFTsAeDAkLMPZYCd6EYg/XWfYv/V2KW71ngHubjxFzHGeVhT5LS
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ae80:80f7:4179:f223])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 39FBB20031;
	Thu,  8 Jan 2026 23:22:13 +0000 (UTC)
Date: Thu, 8 Jan 2026 23:22:11 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: David Miguel Susano Pinto <carandraug@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: git init with specified user.email
Message-ID: <aWA8I82PXXVjiMVR@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	David Miguel Susano Pinto <carandraug@gmail.com>,
	git@vger.kernel.org
References: <875x9cvx44.fsf@word>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="svL6hpYaeBIv49XQ"
Content-Disposition: inline
In-Reply-To: <875x9cvx44.fsf@word>
User-Agent: Mutt/2.2.13 (2024-03-09)


--svL6hpYaeBIv49XQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-08 at 17:21:31, David Miguel Susano Pinto wrote:
> git checkout has a --config option so one can do:
>=20
>     git clone --config 'user.email=3Demail-for-this-clone' ...
>=20
> which I find nice to setup as git alias:
>=20
>     clone-work =3D clone --config 'user.email=3Dmy-work-email'
>=20
> (while leaving the default clone for my personal projects; or an alias
> for clone-personal with the work email as the clone default).

The reason this functionality exists is because it sets those
configuration variables as soon as the repository is initialized and
_before_ actually downloading the data.  As an example, if you wanted to
set a split index or a default line ending configuration, you'd want to
set that before the index was created and the working tree was checked
out, so you can't do that after the clone command completes.

> I would like something similar for git init.  However, git init does not
> have a `--config` option.  I tried to use
>=20
>     git -c 'user.email=3Dmy-work-email' init
>=20
> but that's not working (I'm guessing it only picks up configurations
> mentioned on the man page for git-init).

`git -c` (where `-c` precedes the subcommand) is different.  It sets the
configuration option _for this command only_ and doesn't save it in the
config.  For instance, if you want to run a single diff command without
colours, you can run `git -c color.diff=3Dfalse diff`; that won't affect
any of the configuration files.

The reason that Git doesn't provide a config option for `git init` is
because, except for things like the hash algorithm and ref format,
almost nothing is done to the repository when the command completes.
There isn't even an index created, so setting configuration like split
index in a separate configuration command isn't a problem.

> I am currently working around this with a template for work but would
> prefer to init with `-c` (or similar) or at least understand why this is
> not possible.

This is possible with an alias like so:

    init-work =3D "!f() { dir=3D\"$1\"; shift; git init \"$@\" \"$dir\"; gi=
t -C \"$dir\" config set user.email my-work-email; }"

This would work slightly differently in that you'd need to specify the
directory first unless you wanted to adjust the alias to do more
complicated shell parsing.  You could also implement a shell script
called `git-init-work` (using `git rev-parse --parseopt`[0] or otherwise)
that would handle the complexities and it would work just like the
alias as long as you put it in `PATH`.

One other approach that might work for you is the includeIf
functionality in the config file.  You could do something like this in
your main config file:

    [includeIf "gitdir:~/checkouts/work/**"]
        path =3D ~/.config/git/config-work

And then set the `user.email` value in `~/.config/git/work`.  That would
mean that any repositories under `~/checkouts/work` would automatically
have the config values in `~/.config/git/config-work` set.

[0] If you want an example of using `git rev-parse --parseopt`, you can
see https://github.com/bk2204/dotfiles/blob/dev/bin/dct-mtree, which
demonstrates some of the functionality.  The manual page is also
helpful.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--svL6hpYaeBIv49XQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWA8IwAKCRB8DEliiIei
gb5gAQCe9MW95OrEzDVVy5Nd3rqI15A1j2su1zIk5vCnMGSGfgD/VrD1caA8HQv/
y7TNdrgExwDF6IW628rBg3TxVb2kaQQ=
=U5jq
-----END PGP SIGNATURE-----

--svL6hpYaeBIv49XQ--
