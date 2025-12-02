Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDC9212574
	for <git@vger.kernel.org>; Tue,  2 Dec 2025 22:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764714042; cv=none; b=erbtXiXKeaRIu2zzCxHKlSXRl+kxixnO1N+PuUGMoniWhIuX5cHBMWbnoujM5tror0aI17Gp4iPyXxj/d5IpQ9SXZoiIhVrj1+3OggmCugqkUBR4eofHEucxV9AzzFRrZ8xyc2rLglPNHFnfQ7XFnenBcS8cPkdC8SfmxlWNI3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764714042; c=relaxed/simple;
	bh=qermPbEn6KFwMc9F72CHq5g+jfH03DhtzrGi5brcYCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvA6fIw1WugEtINA29N4AKUwB1mDmjqgqDA3NBA2alj/qrTtFvLIH0ytFn/wMp2iykkGq51vn3UEZ8+XWChv6/opjSoeBNv1N5t5cJ7VPsGAO+N05sBoExDY5d/CFmDEnK7Jp/tIO9qJGCpv6bb1s9gXldmbo8flt+Tmlz4/b4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=zPxEO/JM; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="zPxEO/JM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1764714038;
	bh=qermPbEn6KFwMc9F72CHq5g+jfH03DhtzrGi5brcYCs=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=zPxEO/JMEaZaZOPDXLVp5URPvBFeW7A78G02sgvpU8EJ292aiwIYbPZfzMfoHwPI4
	 xGtU974MCBBCekpK10w5m/85HewsRQTbUD966rJREGEoVufAsMC+ld3UkCdG2+63f1
	 WldgcTWJP8A+VUqXojPTZyIqqwxcvyJ1ZQ/r54RU42TCsZdj7loFtslDoc8BDC2x3P
	 jZDQeuXC/z98e+0VYv9si9JZr15Z/X2tnQTYbHv3ljcNvDAau/v/9q8v5Xa6Alf/ku
	 BPCMuJz3iRtJrl5tX3+XwdJdXB9tLIFmok02sPdC+DdYkGqFgW26HM8ny0itihZzw7
	 tieE4RgKgPooYjB/vnYOsgXm5IvvN6FtT6uW6DxWlQZ3LjcTifdbBWkqs4MHr8p7tK
	 GVVl6cFMCgazwSmTHHRHa/DsgdvVwwuJm/bBugMfEnVjw/HcHg1j00oCb8x0QOLaJ5
	 FIIxcrsDTztEFTh+GMt1doJYE3wGzZCog9dajjZp8Z9Solcfiug
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:ec58:fb7:4d4e:5078])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id DD92A2003B;
	Tue,  2 Dec 2025 22:20:38 +0000 (UTC)
Date: Tue, 2 Dec 2025 22:20:37 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: "Lipofsky, Dan -ND" <Dan.Lipofsky.-ND@disney.com>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: status shows no changes but stage won't pop
Message-ID: <aS9mNdJSJP49-V4Q@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	"Lipofsky, Dan -ND" <Dan.Lipofsky.-ND@disney.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <95EA2230-530D-4EB5-AF19-ADED54976F17@disney.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="wbYo1nUo6hyGgZ5A"
Content-Disposition: inline
In-Reply-To: <95EA2230-530D-4EB5-AF19-ADED54976F17@disney.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--wbYo1nUo6hyGgZ5A
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-12-02 at 19:23:53, Lipofsky, Dan -ND wrote:
> I believe I've uncovered a weird bug in the git client (2.49.0 and 2.52.0=
, installed with brew on MacOS 15.6.1).
>=20
> status shows no changes, but stash won't pop because it says it would ove=
rwrite local changes
>=20
> $ git status -u
> On branch release/2.0.0
> Your branch is ahead of 'origin/release/2.0.0' by 16 commits.
>   (use "git push" to publish your local commits)
>=20
> nothing to commit, working tree clean
>=20
> $ git stash pop
> error: Your local changes to the following files would be overwritten by =
merge:
> 	src/main/java/com/wdpr/nge/edt/gstexpds/web/ExperienceRecordController.j=
ava
> Please commit your changes or stash them before you merge.
> Aborting
> On branch release/2.0.0
> Your branch is ahead of 'origin/release/2.0.0' by 16 commits.
>   (use "git push" to publish your local commits)
>=20
> nothing to commit, working tree clean
> The stash entry is kept in case you need it again.
>=20
> $ git version
> git version 2.52.0
>=20
>=20
> So how did I get here?
> I did something weird (accidentally, because I was distracted with multip=
le windows open).
> I was doing a "git rebase -i" from the command-line,
> while at the same time I staged a change using Sourcetree,
> and then exited the rebase (I think without actually changing anything).

Do you maybe have some files that are marked assume-unchanged or
skip-worktree here?  I wonder if that might be causing this issue,
although I don't know for sure.

You can try this to see:

  git ls-files -v | grep -v '^H'

In a normal case, I would expect to not see any output from that
command, but if one of the assume-unchanged or skip-worktree bits are
set, then you would.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--wbYo1nUo6hyGgZ5A
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaS9mNAAKCRB8DEliiIei
gYPuAP0eamvFnKYTu29wuChSq9cNHNCCMtZHCIvnFagIT6ps9QD/YytopBtlDpUY
tNqfREShd1I0oCHIY++mNsu3bqie5go=
=s8Ic
-----END PGP SIGNATURE-----

--wbYo1nUo6hyGgZ5A--
