Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=172.105.7.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792708274;
	b=ExxdF2vUUL/dWZ7HHdEeqyL+XnSRHCtlsePjPSMsnDgRgqSdLTAa/7+2LsKbaibLYR5r
	 QT4te2/bdwcGe2XioLz6CyMQWuP1OYujfnziBImzHEIvUP921UHZcFJEmHTRTz4rbiR5z
	 vX1/rTCYaiBvnAxCSCyBnlDrD9WGI1i2d0ruHf2+QY2nCRmTncIHenALTHtMznHnJqN/u
	 V8dZY3YeBCK11d1oFEFLe9vp1MC5oIK84KI/QvP0OOEEDREATRlcsov9E6csxdM0fyrzo
	 pGMvhc1FbxMDAnqw13SCz/4vEMR5tNZzUoC7M/dFCUQlwuQuWEhcTfu6UzCMaAHMLSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792708274;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:Mail-Followup-To:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:User-Agent;
	bh=sUxV0W0AfUeE7Ng6FpWi8kO4bwa2Por1JQxO6VQoW2o=;
	b=ozqFpMuS50Qp4/iltm6xdcMgWYgMfRIv23K4/dtjXlixWLcWMn50PAFod7NSQnaNwMuB
	 ekPQvWzm5VjmGUvo1L2+fXMI49uY14xjdqNwW3QmgtVWaFZ8ZcsF9u98VyYzpumjUw1hM
	 ecRBojxQN1SPwSej4mOraFe9LfQBAn12BkhkHnDfFq3rchEdFfReLCol9n53cjv90Y8ne
	 0xxyh33ijQ5Ih4q2KRrMQNDWmVlGJVbbmxHOc8vH7cK4Gwgd2Y0ArWv1Msdoq0eUcjiMK
	 jSTV4GUnybqjDlW6JLezVRVX6TnnHgYn/a3d4BpzXfAfZEzzfwTXNtgyQRytjsOQS8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=crustytoothpaste.net;
	spf=pass smtp.mailfrom=crustytoothpaste.net;
	dkim=pass header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=RVyHFxlq;
	arc=none smtp.remote-ip=172.105.7.114
Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2489606A31E
	for <git@vger.kernel.org>; Thu, 22 Oct 2026 22:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F2489606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key, unprotected) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.a=rsa-sha256 header.s=default header.b=RVyHFxlq
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1792708267;
	bh=1iD9H+uWdc5iO5Vri/l4dVrWB1z42j3TRZm4Gnvjo0I=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=RVyHFxlqH00o9H3dRmj5wO+ZW7NlmtgUo4n90YY9YHkrC57iz+H5Un9Mz3APJ44aJ
	 ztMeztqGVhCOnUuDFEeOSUDACAgaq4MGpr4ltryW4skATiDVzmGdplg8lxa5gBHCnI
	 yQTVZXLPjR79HdfcBxGNhTyc/tFHLDZu35FsqhmCaR8fjTcOgMHghBzr5B3sNwgLL/
	 vEQzpYuHARnnFkrmdBiQY7rioR9dhE/dlR4uvH9i295Up2OAzCqvJwNQxPq+lh6QRo
	 ND0zNYnzNdgRBPXI0Aax/pXFa1+d+f+DxmEdEB/QT9jrmcUNjfuCLq1B8tB747bVjw
	 DWAVtpxK8ffUbHBWywzCzgdiU+cY9IaJmnr9sRqTCHD5SfXPvis8MCHxPY8w9guSBZ
	 OfiSbTqt8mfnvGWgK7ctNOtKNZwuHZ7HEuVZA65B46Ay5fzgOx86GSp06WnIGhdWd4
	 fRwm75nHOOzN98M6b2GXSIBrYh/YL6s1VWKU3kGY+1B6vVJ8aED
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:b44d:c6f6:4e4b:66bf])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8ECCB2006B;
	Thu, 22 Oct 2026 22:31:07 +0000 (UTC)
Date: Thu, 22 Oct 2026 22:31:06 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Jason Newton <nevion@gmail.com>
Cc: Jason Newton via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 1/2] worktree: add --reflink for copy-on-write
 worktree creation
Message-ID: <atqOqRE866bgyxfL@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jason Newton <nevion@gmail.com>,
	Jason Newton via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
References: <pull.2317.git.git.1780685368.gitgitgadget@gmail.com>
 <pull.2317.v2.git.git.1792512249.gitgitgadget@gmail.com>
 <83841020f43f9f8989371117075ebf089888d619.1792512249.git.gitgitgadget@gmail.com>
 <atfbDXhTUmPtv5pE@fruit.crustytoothpaste.net>
 <CAGou9MhkmSZs3ViSj6qqkZY6LLLQQ+5RzjLG5EhM-AXx+d7h=A@mail.gmail.com>
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
	protocol="application/pgp-signature"; boundary="EQadoteHDiFMB6Dc"
Content-Disposition: inline
In-Reply-To: <CAGou9MhkmSZs3ViSj6qqkZY6LLLQQ+5RzjLG5EhM-AXx+d7h=A@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)

--EQadoteHDiFMB6Dc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-10-21 at 07:15:50, Jason Newton wrote:
> Brian,

Hay,

> macOS cp has no --reflink=3Dalways. The clone option is -c, which is
> clonefile(2). t/t2400-worktree-add.sh already probes that way. The
> REFLINK prerequisite runs "cp -c" when the MACOS prerequisite is set,
> and "cp --reflink=3Dalways" otherwise. The test that depends on REFLINK
> is "--reflink carries untracked files and reconciles changes".
>=20
> That is in 042485f0e9cd8cf1765b811ea7334247aec44971. The pull request
> CI for that commit is the APFS run:
>=20
> https://github.com/git/git/pull/2317
> https://github.com/git/git/actions/runs/39502233266
>=20
> All four macos-14 jobs succeeded. The runners were macOS 14.8.9
> (23J631), image macos-14-arm64 20260831.0302.1. "print test failures"
> was skipped on each job, which is the step that runs only when a test
> script fails.

You have a test_lazy_prereq for REFLINK in your test file and it uses
`cp --reflink=3Dalways`.  If that doesn't work on macOS, then the
prerequisite fails, so the test with the REFLINK prerequisite is
skipped.  That means it doesn't fail, but it also doesn't run, so it
isn't testing anything at all.

What I'm saying is that it should actually pass the REFLINK prerequisite
and run the test on macOS.  It looks like you did do that in v3, which
is good.

It also looks like at the very least substantial portions of this email
are the output of an LLM.  You should read and understand our AI
policy[0].  In any event, I'm not going to review or respond further to
AI slop, especially since I work on Git entirely in my personal time and
my time is currently quite limited.

We consider it important to explain our patches and our thought process
well on this list and we have high standards for inclusion=E2=80=94as we
should=E2=80=94since many developers around the world depend on us.  You're
welcome to participate, but you should respond to other humans with your
own words and thoughts, since we're giving you the same time and
courtesy.  If I wanted to know what an LLM thinks about what I have to
say, I know where to find one=E2=80=94I wouldn't have asked.[1]

[0] https://git-scm.com/docs/SubmittingPatches#ai
[1] For the avoidance of doubt, these em dashes are my own creation and
come from my love of language and the fact that I have an English
degree.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--EQadoteHDiFMB6Dc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmrajqkJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ5XlZp/dJlhhmar6AsKYNWXj9eFbfgMlOvYHz8yXeHce
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAKb3AQCrbsIEINzNJK1uIGhSXVZJ+SQ+
6f9YGijfWWSgRubP1gD/SaTziz/1bOtXFWalYh+RU6PVn3NfLBXJ20Z5VXV6eQY=
=Eo2O
-----END PGP SIGNATURE-----

--EQadoteHDiFMB6Dc--
