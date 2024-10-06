Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D4C5EC5
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 05:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728191496; cv=none; b=ume1Cocad4gZ2cuiY4mZ7cZ7azl+0Bj3vLt3jDyTG2RnOmlQFNhmzaOAp5sjnut6hAN70f/st+yP1JQ8T4a45w96VV78pxSHpAMV8N4/Bk0BsHuX/3uCtckOqEEIVXogsPWH7snFUngGskevb5QgjB7qYjiBBDa6Y8/FUZMnEm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728191496; c=relaxed/simple;
	bh=itwQNvBbXS4Uc4y8p5X1Vih2cGwLAjRMdJh/aVr2ROA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nulfE2hUVx46pe+6EL9bPVwUodagZx8tb6gVhyreeCDlJH5saATIfWc1+pfRwtQtiEy8qwKZj23dJlC1WHfThlVLjzrs3zJpsTWyI5z+UdB4GVA8Lo0B+ODuKwwoZP4smFidoHRAIoojo8l0hIID16ZZLuI7ax8FcHH4TiPLpzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=RB+YYbzm; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="RB+YYbzm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1728191493; x=1728450693;
	bh=itwQNvBbXS4Uc4y8p5X1Vih2cGwLAjRMdJh/aVr2ROA=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=RB+YYbzmPyS3EAlLeTczkZCAtpsaE2q5qi5T5F2IsEkTiN0zfI2RcQ4YdyJQzRtF5
	 SKlM1hkzAlYSylWxBzdnbZ0PRJeVpr+rNM/isX+g2dju+KOut10gPY6+d+NPKXhRsB
	 M0G2LsJEan5Qj4pGa6oPDNNr6XUvYnW4GhYhWmWyBzxBx5s5odo3/2ZP2JNA0VcKO/
	 drlXXS/8AxfaU9PEvfNPLbs5N1wuC1UzWKlOUhrzLOhDL2Z30tL89GN8NjZlGNWbez
	 zKMHI2ckQeUvdOKCY0b8GY1XXiBntrIhqfmSsVdedMVNJyWET2STqTOAbe397r0aMf
	 pAUGhXSbh1eWg==
Date: Sun, 06 Oct 2024 05:11:28 +0000
To: Eric Sunshine <sunshine@sunshineco.com>
From: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 0/4] Link worktrees with relative paths
Message-ID: <zKUnWY8u1SJNeS4oLK85znjacgYJJeN8HefenwaJ9B9Q1YrQAumpAxWos4svaawkTfQZ_HaS3yp6WrOQQI7yt3ZO0UMCfkM0lJDDnMD-Lno=@pm.me>
In-Reply-To: <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
References: <20241006045847.159937-1-cdwhite3@pm.me> <CAPig+cTB-sA-g4cdhfEjWwY1mnbWJ41e=bOCNwp=Y8JKvpmpRg@mail.gmail.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 961ca382835fe74ffa0e3979a9d47ff89edf9fc8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------0f53783b6231fb36d3ee7db42323e2822099f9986b6b762d2048838a8685eab4"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------0f53783b6231fb36d3ee7db42323e2822099f9986b6b762d2048838a8685eab4
Content-Type: multipart/mixed;boundary=---------------------5128656bfbe1b83550fe79fd23ba4b35

-----------------------5128656bfbe1b83550fe79fd23ba4b35
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

On Sunday, October 6th, 2024 at 00:04, Eric Sunshine <sunshine@sunshineco.=
com> wrote:

> On Sun, Oct 6, 2024 at 12:59=E2=80=AFAM Caleb White cdwhite3@pm.me wrote=
:
> =


> > This patch series modifies Git's handling of worktree linking to use
> > relative paths instead of absolute paths. The motivation behind this
> > change is to enhance the robustness of worktree links when the main
> > repository is moved, or when used in environments like containerized
> > development where absolute paths differ across systems.
> > [...]
> > Caleb White (4):
> > worktree: refactor infer_backlink() to use *strbuf
> > worktree: link worktrees with relative paths
> > worktree: sync worktree paths after gitdir move
> > worktree: prevent null pointer dereference
> =


> =


> Unfortunately, these patches are whitespace-damaged. Can you please
> resubmit using either `git send-email` or GitGitGadget[1]?
> =


> [1]: https://gitgitgadget.github.io/

I sent them with `git send-email`, let me try again and then if that
doesn't work then I'll try GitGitGadget. Just out of curiosity, how
could you tell that they are whitespaced-damaged (so I know what to
look for)?

Thanks,
-----------------------5128656bfbe1b83550fe79fd23ba4b35--

--------0f53783b6231fb36d3ee7db42323e2822099f9986b6b762d2048838a8685eab4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wsBzBAEBCAAnBYJnAhvxCZAy5Kywm9vL4hYhBE+hHqFr3OG0O+P29TLkrLCb
28viAADAIQf+LgzfDOh3atZmzGS73wZ4/EFnavkEV/Mq+et1IFHgAR2FtyPp
mbTMMV2+V/3XRrD5mb3HKKhAXRDxtaIBOUP7/1I+VPdG83uS/hGI2ypzVK19
bZlfx9dQE3/+oPtTJnaQS7jmXHPeAl+10WBLm9MoKhMa+SYXOP7yM48LtNRp
vYe+sszgGNbFQk/8g5ADuGiWGnyD63StTs7nyD4wMtxMbtdo00y/HZlzNTOs
6PD+gxKR6FWnt+JQBa8EmoaV6iYhgjx815tQBYIq6ZTJjhj/RHr3gw2/OJMf
IpQK5Ux57fpNGZ58gFVQmRjl9hnpcBW+stI14zKQU5dh5pQWxqBQRw==
=tKuD
-----END PGP SIGNATURE-----


--------0f53783b6231fb36d3ee7db42323e2822099f9986b6b762d2048838a8685eab4--

