Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E869476
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 22:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768257551; cv=none; b=XO1v5StlGYlUglm99GI28dWn3G9Yg3VoKzFnDfQEC9v+bWUEJa5oBul3bE0uOyoFNKLUEyNe9Lw2Rt1Rit4ZENqSWj4c+5n27hP71rkIxhNSCFV2I2dBn+3UjXuvKU3vQSb799ESuKSs6klYXj8Bku/Fg45pVVFe4WsYEr6hGI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768257551; c=relaxed/simple;
	bh=PLIveCHvMgEqt1eSP2OtqbxMpHSXHrZ1+7kcN3Cfp+I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j3Zxz+9v9hLuXiDvNaaQW2uh5oKgNElX4CoQhYgpdMZtIlvHncvWnZ6nWB8nllMlQDaF+ZWONloVqS9JzY3AdiHBcFGwvjtGf9WUw3UVwzQ9x9xt6aAm3jOqWb6STYKjWNLnsPFEL6bOkzqkwDtGbU4xpO0prr2QtkWjIP+eLgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=wVc3D/qi; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="wVc3D/qi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1768257541;
	bh=PLIveCHvMgEqt1eSP2OtqbxMpHSXHrZ1+7kcN3Cfp+I=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=wVc3D/qiTgv0E3q5UCuTz3xW90772wXYAtQ/wzxbrlUnLPdoCupmsb1CCZ6yQJ5zP
	 COxSjF8fQfNr42E3EzwdCwShLV2xzivX3eg3XcreILapYLgCiD4H4CR7WKHaAZM5Vq
	 V3dzRCoEKca+TrR5HKxlT5xN0GwB/FBayFQdgLF6RlnBCydRsBINSjezeYr7aPUN34
	 DxXqEEkMkpGn35/IjCK0Rzq88MeAd/vZRoN2UFSFr+QxL1OoJxOQb286/PTobxAofe
	 WURan0EuwACv6/m540yJW4cYb07oN2R0U9CUHEiIB2twpy9Rs2cTkg0PA48edCtRzO
	 vwiZNloYW7bX+WFXfVjnRoq85mGrNpp9jzMuKK3/adjX9j3ZzKsFDuoV448dxdafgF
	 FtfG9iBgzqKVz9Ttm3+INqJWWM5x3h9hSDYHJkyXDvGPiCR18vhZHhvELbAok4TGIi
	 +5YlYjSKn3l2F1PeRGDLSEOOv5zbOq4amCodCDmQPlqig76PZf4
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:e6a9:5e22:aa44:8800])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id BCBBA200B5;
	Mon, 12 Jan 2026 22:39:01 +0000 (UTC)
Date: Mon, 12 Jan 2026 22:39:00 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Krzysztof =?utf-8?B?WmFixYJvY2tp?= <K.Zablocki@student.tudelft.nl>
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Idea regarding GIT
Message-ID: <aWV4BPdrR7nfRWWf@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Krzysztof =?utf-8?B?WmFixYJvY2tp?= <K.Zablocki@student.tudelft.nl>,
	"git@vger.kernel.org" <git@vger.kernel.org>
References: <DU0PR09MB8272C80E049596044EF581C2B181A@DU0PR09MB8272.eurprd09.prod.outlook.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Zb3S4byTMN2Ku6OP"
Content-Disposition: inline
In-Reply-To: <DU0PR09MB8272C80E049596044EF581C2B181A@DU0PR09MB8272.eurprd09.prod.outlook.com>
User-Agent: Mutt/2.2.13 (2024-03-09)


--Zb3S4byTMN2Ku6OP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-01-12 at 02:53:49, Krzysztof Zab=C5=82ocki wrote:
> Dear all,
> I'm emailing to suggest feature for git. It can be useful for ppl working
> with pipelines and having extensive personalized configs. I propose adding
> new configuration file (or parameter in .gitconfig) .gittemplates. Files
> listed in there had to be indexed before adding them to that file, otherw=
ise
> it would work like .gitignore, but difference is if file was added git wi=
ll
> not track changes in it and won't commit them. It can be useful with .env
> files, using this feature their empty, template version can be committed =
and
> frozen where local version can be edited. Same with configs requiring loc=
al,
> machine specific paths. Now there is need to keep template version commit=
ted
> with different name and proper one recreated locally and ignored which ad=
ds
> extra work each time.

Yeah, you're describing the FAQ entry listed at
https://git-scm.com/docs/gitfaq#ignore-tracked-files.  The rationale
that's given is this:

    The reason is that if Git needs to overwrite this file, such as
    during a checkout, it doesn=E2=80=99t know whether the changes to the f=
ile
    are precious and should be kept, or whether they are irrelevant and
    can safely be destroyed.

Even with a `precious` attribute for ignored files, presumably there is
some point at which you want to update the file.  For instance, maybe
the template contains a new, mandatory configuration setting that you
need for your software to work.  However, Git can't possible know when
that situation occurs.

In the case of your `.gittemplates` approach, you have no template file
on disk, only the filled-in file, so there's no way to actually rebuild
the file off the new template.  Your only choice would be to blow away
the file on disk and reset it.  However, with the existing approach, you
can simply run a script (which could even be done in a `post-checkout`
hook if you like) to rebuild the ignored file from the template file,
including whatever information you need or merging the existing data.

It also becomes very complex because Git is absolutely not designed to
have tracked files that are not written into the working tree, so things
like `git reset --hard` would have ambiguous behaviour: do you want to
reset the file to its original state or do you want to preserve it?  If
you want to preserve it, how do you do a full reset of the working tree
to its original state?

At work, we have a standard script for setting up the repository[0], so
it's very easy for anyone to do anything necessary, like generating
these kinds of files or running database migrations.  And again, this
can be done automatically in a hook.

[0] https://github.com/github/scripts-to-rule-them-all
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--Zb3S4byTMN2Ku6OP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.4.8 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCaWV4BAAKCRB8DEliiIei
gROOAQD7ayKulCKyzspTivcwq5JiGHHuxZaq859sC0pIECDArgEAn1gDmqmbOr3V
0nUH0s2NjXbsubLKeC6qjOynn8hfawI=
=CVDS
-----END PGP SIGNATURE-----

--Zb3S4byTMN2Ku6OP--
