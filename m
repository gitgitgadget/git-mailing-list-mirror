Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD9441379E
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788810073; cv=none; b=mM6JjpTPSk6151xgFe3mdMZbJijZWC6uZoMinGqTaUiw652ak7rKoh0K+U8ld5Ehyur3brrYNKmvEt5H1/iCNpRtX26f3gP9+i84uNOyQjKAERdBElCWAd6f6a0RP8Hsa8mKnFJU+EHFQaa64QS6FN882edXUVYVFRMI8hzg3t8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788810073; c=relaxed/simple;
	bh=MfDbWBBVLIsOSssloZZCmve+Wo9HHr6/7C9pBCp06xA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WmIT6sxzeXcQM21lkLW2M2xfelLMYokRvd8YH+EHcU00ZvVoF8vcxCRzPxo8FBhHQDXMA1Cj/5FCcVC8zltSMnqj6ocbP+T82LsSi3SmIMKdeEB/QAy+3ZWdnrnRewQcEJpxZ00m1XaCdOTpCl9HZrtb9dX+LJ151Zwziab1CzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=cQ+HFBX/; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="cQ+HFBX/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788810063;
	bh=MfDbWBBVLIsOSssloZZCmve+Wo9HHr6/7C9pBCp06xA=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=cQ+HFBX/0eIHIhy70SbipphKrSMMs9VFiDBJWGqx2mpw1fPplNoXckrffPjyLlMGd
	 327LiUVv50vNpCrVjc6ycPJCcaxSjnIWggNfiiWiD8zQag7v8BDWf11gvrrgKYBBOo
	 hogqbEyqQ40pX7yp5hBLYU3BpQSgkcgHFm5cMsWdN8O9VJGNUaPEWHRaweWTHnOxET
	 LulvFSSbaSw8+/riFWz7N0euZo6dL+yQhNAr/0m2/84r2IQqSx3iJM8DCkZebOF3Gh
	 QerRsPQrqyUITCK9CrQeBc/1xDyEuLFy2bjNQ7QykGoCCoIGBOEc3cQwXxneZVg2TU
	 o1FDR8cgCEHVdSGBmGkGF24zZdm7Ud4Rvb5QHBHvODmNAIWmyM9vXJq2v5pznfJpC7
	 gYOi4Z2OlZepBIi9orwyH5mcJkJAY7JaijsAyZIe1Tyz2c9jnZx3ICl/GqiFWAig6d
	 efCcrA/+14wS/AJmQblChc0msgAmCHoi4/Zry6m/sE+sejCzcVi
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 61FAC20033;
	Mon,  7 Sep 2026 19:41:03 +0000 (UTC)
Date: Mon, 7 Sep 2026 19:41:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: AIKSXD ax <aiksxd@outlook.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] git pull silently overwrites local directory with
 symlink due to .gitignore "dir/"
Message-ID: <ap8TTRctdrsFo2l1@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	AIKSXD ax <aiksxd@outlook.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DSWPR04MB9945756976C15A3A4978CE9AD0B22@DSWPR04MB9945.namprd04.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="OxFoi/oquKvTs5Q9"
Content-Disposition: inline
In-Reply-To: <DSWPR04MB9945756976C15A3A4978CE9AD0B22@DSWPR04MB9945.namprd04.prod.outlook.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--OxFoi/oquKvTs5Q9
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-07 at 08:19:17, AIKSXD ax wrote:
> Hello,I would like to report a issue in Git that can cause silent data lo=
ss on user machines. The problem occurs when a '.gitignore' pattern ending =
with a slash (e.g. 'dir/') is used to ignore a directory, but a symbolic li=
nk with the same name will be committed. Later, when another user pulls the=
 repository, Git silently replaces their local directory with that symlink,=
 destroying all data inside it without any hints.
>=20
> OS: Linux(Git 2.43.0) & Windows(Git 2.53.0.windows.2) both reproduced
> - The symlink is tracked and committed because the trailing-slash ignore =
rule have no effect on files.

Yes, as you've noticed, symlinks (and files) are not ignored by patterns
containing a trailing slash.  This is because `dataset/` doesn't
actually ignore `dataset`, but everything under it instead.  The index
doesn't track directories, only regular files and symlinks, so `dataset`
as a symlink is not even considered by that rule.

> - On pull, Git silently replaces the local directory with the symlink, ca=
using irreversible data loss.
> This is unacceptable behavior; Git should never overwrite a local directo=
ry with a symlink without explicit user confirmation.

I tested this with a non-symlink file and Git also removes the directory
in this case.  As you noticed, `git checkout` deletes ignored files and
directories.  You can see in the manual page:

     --overwrite-ignore, --no-overwrite-ignore
         Silently overwrite ignored files when switching branches. This
         is the default behavior. Use --no-overwrite-ignore to abort the
         operation when the new branch contains ignored files.

Git does not consider ignored files to be valuable by default.  There
has been discussion of a `precious` attribute to preserve ignored files,
but it hasn't been implemented yet.  [0] is one relatively recent proposal.

> Impact:
> This issue can result in the loss of hundreds of gigabytes of local data,=
 as users often keep large datasets or other important directories with the=
 same name as an ignored symlink. The data loss is silent and occurs during=
 a routine 'git pull'( I don=E2=80=99t know why so much free space showed u=
p on my computer that day).
>=20
> My options:
> The pattern 'dataset/' should also ignore a symlink with that name, so it=
 never enters the repository in the first place.

This would be a substantial change in behaviour.  We don't know that the
symlink points to a directory and it would be bizarre to have a symlink
to a file affected in that way.  Moreover, on Unix, a symlink need not
actually point _anywhere_, so whether this worked would be dependent on
subtle behaviour about what the symlink is pointing to at this time.

> If such a symlink is committed (accidentally or otherwise), Git must dete=
ct the conflict when pulling to a machine that has a real directory at the =
same path, and refuse to overwrite it without prompting.

This would also be a big change in behaviour and probably break a lot of
tooling that relies on the status quo.

In general, I would recommend not keeping valuable data in untracked or
ignored files within the working tree.  I've seen lots of data loss from
this case and have actually had to restore people's development VMs from
a snapshot for that reason at a previous job.

[0] https://lore.kernel.org/git/pull.1627.git.1703643931314.gitgitgadget@gm=
ail.com/
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--OxFoi/oquKvTs5Q9
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqfE00JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZyzsw9WbaqYNWwdqDS4KmzJTcZioXIMmHzbg+G/PJKPa
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAGDWAPwJ5hRFvI1tTKhqVL8QnRBwUxhm
1l/fKAaPERyvdzbKewD/YScodU7R4zubDyEiqEakGROYbGAqtOKPNOq59H+sxAo=
=bDZh
-----END PGP SIGNATURE-----

--OxFoi/oquKvTs5Q9--
