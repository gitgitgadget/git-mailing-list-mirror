Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4AD18DF9D
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 22:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722379209; cv=none; b=R8mK+WcarXZ38x1rFZ3uiB3swZkNL87AV9vUSBu+VOMFu7z4Hy1u9pOsupQwlriAHc3AvKBSAW8nO0beyXZlVSFicqGlzanJX50vdf0gZs/psih8UaYziv42P8v93RTwtLIZ6NRfaz4SXMC3CjK2s8CqCnd64EiShJASHQ1XIYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722379209; c=relaxed/simple;
	bh=RIbYabPCXDpUDhMDfnovDiNNdAfxfQDF94JfadUu9MQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o6h9gKREqPojIZGnTum2GLkCU4D/M4ItVg3vRYvML8bz/TU0/KHVG/U+7L4V5IIrp8lZFwZQuly0uvpZSWIhJrkO+h4AWx3T7ZoTDcS/R3OGq6vWYLhIjR6zCtsFNE+kGyoCcPnXAG0hiiowVEYHJok6AGERWKoAtesE41WTZ2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=bukTF46b; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="bukTF46b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1722379205;
	bh=RIbYabPCXDpUDhMDfnovDiNNdAfxfQDF94JfadUu9MQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=bukTF46bW8+R3NT/Xf3E2xPxseOmFeLHWsjau/lYeJ9hnou707oDv34Lr52clA6gP
	 BC2GtMI+kBlhUbBJZCWu6i2rWq+xoQJxW5HtqsKdivcxNkZExZBcCOSoI5FxKLR8om
	 lOmTtmqmvyWnFyNKIKSzo4b3fuMOXh1N5UqG4KC3oiwiSALgrE3bngYhYr0F9C89Sb
	 jQ2RuuzpS7JYB22Zg4CCdxXaUaNeWQ6upoQfPZkSBlSt3kNiVbnrMzAtoLqJ9Jt2/r
	 7xVdvsTvMsXwkWdK7DUhXCAYGT9+rz5ia/rZixXQr/cF+y3n0xAAIrOAH8O/Kr/hr+
	 rXQyxdh1UIZvTYMuOXNQuOSkNhhpXQylf9klFPnHs0iahfu8EBCFft5prLdAbQ73wI
	 g2+o45BqOzxjJJPBumc/rUfut8Z82ES4KHt5PIdYIJbiaAMuec6AVMkCvYOb+MTjKs
	 ZvcDCr9NCggl/SjoTlrKTqWZkFd1zq20CpA6+H5tx1BHTt75Seh
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 63301209B9;
	Tue, 30 Jul 2024 22:40:05 +0000 (UTC)
Date: Tue, 30 Jul 2024 22:40:04 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Nathan Teodosio <nathan.teodosio@canonical.com>
Cc: git@vger.kernel.org
Subject: Re: Tracked file cannot be added, mentions to sparse checkout that I
 don't have.
Message-ID: <ZqlrxFrzuC2lGyTU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Nathan Teodosio <nathan.teodosio@canonical.com>,
	git@vger.kernel.org
References: <20240730122926.638a9263@canonical>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="eEsMZiy7YnVw5maw"
Content-Disposition: inline
In-Reply-To: <20240730122926.638a9263@canonical>
User-Agent: Mutt/2.2.12 (2023-09-09)


--eEsMZiy7YnVw5maw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2024-07-30 at 10:29:26, Nathan Teodosio wrote:
> What did you do before the bug happened? (Steps to reproduce your issue)
>=20
> I modified a tracked file.
>=20
> What did you expect to happen? (Expected behavior)
>=20
> The file is listed as modified in git status and added with git add etc.,
> i.e. the usual commit routine.
>=20
> What happened instead? (Actual behavior)
>=20
> I cannot add or commit the changes done to that file.
>=20
> --->
> % echo 1 >> snapcraft.yaml
> % tail -n1 snapcraft.yaml
> 1
> # I expected snapcraft.yaml to show here:
> % git status -s
> ?? git-bugreport-2024-07-30-1212.txt
> # I expected snapcraft.yaml to be added here:
> % git add snapcraft.yaml
> The following paths and/or pathspecs matched paths that exist
> outside of your sparse-checkout definition, so will not be
> updated in the index:
> snapcraft.yaml
> hint: If you intend to update such entries, try one of the following:
> hint: * Use the --sparse option.
> hint: * Disable or modify the sparsity rules.
> hint: Disable this message with "git config advice.updateSparsePath false"
> <---

Have you perhaps done `git update-index --skip-worktree snapcraft.yaml`?
Here's how you can find out:

  % git ls-files -t | grep snapcraft.yaml
  S snapcraft.yaml

That "S" means it's skip-worktree.  Otherwise, we'd normally expect to
see an "H" or maybe another letter there.

If so, that might be because you've received some information
(unfortunately erroneous) that `git update-index --skip-worktree` or
`git update-index --assume-unchanged` are good ways to ignore changes to
a tracked file.  The Git FAQ[0] is pretty clear that Git doesn't allow
ignoring tracked files and explains why.  The skip-worktree bit is
designed to implement sparse checkout, so that's why you typically get
that message if that bit is set and you try to add the file.

You can unset that bit with `git update-index --no-skip-worktree
snapcraft.yaml`, which should fix the problem.  As for ignoring files,
the Git FAQ outlines an alternative which we recommend instead:

  If your goal is to modify a configuration file, it can often be
  helpful to have a file checked into the repository which is a template
  or set of defaults which can then be copied alongside and modified as
  appropriate. This second, modified file is usually ignored to prevent
  accidentally committing it.

Hopefully that's helpful.  If I'm incorrect and that bit hasn't been set
in the index, please do let us know, because that would be unexpected.

[0] https://git-scm.com/docs/gitfaq#ignore-tracked-files
--=20
brian m. carlson (they/them or he/him)
Toronto, Ontario, CA

--eEsMZiy7YnVw5maw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.4 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCZqlrwwAKCRB8DEliiIei
gRSFAQCE/zYJUuCZ9svDt+Gm/VBQtTkjya/MEhunpDuAABOVvgD/XIZlvsUqF1JJ
q/a1ou1thNI6MvO1YVGFk2MgQnxQbg0=
=Z2Gd
-----END PGP SIGNATURE-----

--eEsMZiy7YnVw5maw--
