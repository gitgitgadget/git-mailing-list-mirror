Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A8B1553A3
	for <git@vger.kernel.org>; Sun,  8 Jun 2025 21:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749418986; cv=none; b=JgFIXyYHPeGmZEjbm2GuIMx61cJCUZ0HBZUjn+0c5TSKzH5u9z69SJnTzANrf7xXbmPxDMryGaRidZsiwxkc4ew2IjurIY/8gjn3BPrEUgnUp/O9otR9+5Na4o9hifrIjhB1s7DDWZVSrOUu4ApH3RpT65UPQdLj5SJkotPc1Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749418986; c=relaxed/simple;
	bh=irlGmo3y6MOSeRm/w+oAAUMyJPhnrrMveDASjXTkExE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gEhAcpvocLUlmsQtP0ItG1K3OtSrxAcQGuLWI/XRWxiNim3tGPFyqEtFka+bOzEIHcd3hI5Au70YujPsPtyszCaJhfb7b2oF06TM3rLn4C0regbYBYpxeKOZ+HLxagIgyw6vJafLsAJInJpAE/kFZIZ7w4eBbjc1Bq3alNLwQts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=T0MF1NeO; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="T0MF1NeO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1749418982;
	bh=irlGmo3y6MOSeRm/w+oAAUMyJPhnrrMveDASjXTkExE=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=T0MF1NeOeFLM524ZOpx4kHuPhmm4TwcmUtrDIR1Im8xiXAW7KGOWExq40qrev8rjT
	 AJclGIOz3AnUU+EbLc9HsjWO/wkF+LEAuZKShkL3w3m/5GqElX47xCu7CrnC/UIxlD
	 MIXa08XYuiBbAsfPKI9sA87Z9n6fqdDFbV3PUI9KIvwl50Xx6NsI+vJ6dnFscyDQMo
	 onevnGkfRM7sFfQaheJapvdqIiWIpAEpf3rxAdMEPid1BIeseQ1KIQmOtF8ubxkKhX
	 aGMhDCPDXw+XBua6h8oRPTodEJHM3QQFylZu215wV9605RMCeERb6pkUdquzzSIH5/
	 bu7x0plaZoIsGKBn0kdc9kHdmyKrJkYttF58Vf8y9e90XE6k1ov3QJTzdfZwLuaICC
	 9snPsJ7li+sFXM89A+CaMNec8pbmy0jJJty/3/9ESvOuIsDo/6aES9OCZxtsTpvS+H
	 LZiixPG6i3oWTU13HQWbRALANC1bZSL0s1e8RB3u46vtBeJJ6AX
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:9ec0:b846:49f:a41d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 8334420033;
	Sun,  8 Jun 2025 21:43:02 +0000 (UTC)
Date: Sun, 8 Jun 2025 21:43:01 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Aditya Garg <gargaditya08@live.com>
Cc: phillip.wood@dunelm.org.uk, Phillip Wood <phillip.wood123@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Question: is there a short way to merge the last commit to the
 second last one?
Message-ID: <aEYD5X940Li_H7KU@tapette.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Aditya Garg <gargaditya08@live.com>, phillip.wood@dunelm.org.uk,
	Phillip Wood <phillip.wood123@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <PN3PR01MB959708ED22FE7FE70C17C852B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
 <aEXdKMjAbry1aTXe@tapette.crustytoothpaste.net>
 <993914f7-5023-459c-b1e8-ebec2646e243@gmail.com>
 <PN3PR01MB9597D380178A875C6FFA90E0B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ygnfjOXZb8308n3w"
Content-Disposition: inline
In-Reply-To: <PN3PR01MB9597D380178A875C6FFA90E0B868A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
User-Agent: Mutt/2.2.13 (2024-03-09)


--ygnfjOXZb8308n3w
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2025-06-08 at 19:35:24, Aditya Garg wrote:
>=20
>=20
> On 9 June 2025 1:01:19=E2=80=AFam IST, Phillip Wood <phillip.wood123@gmai=
l.com> wrote:
> >On 08/06/2025 19:57, brian m. carlson wrote:
> >>=20
> >> If your goal is to just do the fixups and squash and not anything else
> >> interactive, then you can do this:
> >>=20
> >>      GIT_SEQUENCE_EDITOR=3Dtrue git rebase -i --autosquash
> >
> >Just a quick note to say that since git v2.44.0 you can just run
> >
> >	git rebase --autosquash
> >
>=20
> Silly question but how does it get to know what is the fixup commit?

That's actually a great question.  When you do `git commit --squash
REVISION`, it takes the summary of the commit specified by `REVISION`
and precedes it with `squash! `, and for `--fixup`, it does `fixup! `.

Then, it's just a matter of re-ordering the squash or fixup commits in
order after the commit with the corresponding summary.

So with this shell script:

----
#!/bin/sh

git init --object-format=3Dsha256 test-repo
cd test-repo

echo abc >file.txt
git add file.txt
git commit -m 'Initial commit'

echo def >file.txt
git add file.txt
git commit --fixup HEAD
git show
----

You get something like this:

----
Initialized empty Git repository in /tmp/user/1000/test-repo/.git/
[dev (root-commit) 7327102] Initial commit
 1 file changed, 1 insertion(+)
 create mode 100644 file.txt
[dev 8bdd271] fixup! Initial commit
 1 file changed, 1 insertion(+), 1 deletion(-)
commit 8bdd271b6d4e22b7ca697c2d4499fd3e0825977d7d2c917b92e1f1f12383f52c
Author: brian m. carlson <sandals@crustytoothpaste.net>
Date:   Sun Jun 8 21:41:43 2025 +0000

    fixup! Initial commit

diff --git a/file.txt b/file.txt
index e0ef420..559afde 100644
--- a/file.txt
+++ b/file.txt
@@ -1 +1 @@
-abc
+def
----

Of course, `--autosquash` does require using `--fixup` and `--squash` or
otherwise naming the commits that way.
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--ygnfjOXZb8308n3w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmhGA+UJEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ8bpC1B2MEzP5ne8ku/WMW0w1hFcHtGbEqJLHPwD8SvU
FiEECCzmip28ZfuD0cORfAxJYoiHooEAAAw5AQDX7p0jxE51VS28jgOKAp9TmADg
0cnDQAJIjEGvcTLcZgD9FeYeg3OeHhE8qyyDVNjjUskou9U0GJYyaYsaDgmOOgA=
=Jmnn
-----END PGP SIGNATURE-----

--ygnfjOXZb8308n3w--
