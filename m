Received: from smtpfb1-g21.free.fr (smtpfb1-g21.free.fr [212.27.42.9])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1B1A330D2A
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 20:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784578218; cv=none; b=LTPsZsI/eUYVvIyIQ4JIPOS7yBe1mfWvzv6z/u4ybyhb+RzEbbtj0ouzKZ1+t/t/Ix2YAvXQ3QeX9LKtQCmFF274ZxO3PXkCqh2QtEhLtMMsBcq18mJ5KjJt1LWASSTMYEO/WBbuewGCmQiCYdX6qpyeswgSCJcdl/gAFN2+ItQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784578218; c=relaxed/simple;
	bh=YNoKubWCFaXYDG/MPv6q6QtwXZ7ZyyWWmeupKBiwD0w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GOtQfnludwOxKIvNhcleMP96JuhOLgPC3ZvjPFXDw1FPFLUkazJweS3IBM8vIrDeFVcoq7whHOSqtfOQ/8E9e8xgf5fWMg0SHtkyvPlHqw7UO8FbUPEX9EPsH23UqCWwlnOsYS0So/1viFtIfUTzHdWOqBnnqQR8mgWWcOxo9rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=KSUc+07l; arc=none smtp.client-ip=212.27.42.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="KSUc+07l"
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
	by smtpfb1-g21.free.fr (Postfix) with ESMTP id B16D8DF902D
	for <git@vger.kernel.org>; Mon, 20 Jul 2026 22:10:05 +0200 (CEST)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:ca50:7747:ead3:b011])
	(Authenticated sender: jn.avila@free.fr)
	by smtp3-g21.free.fr (Postfix) with ESMTPSA id 19B7B13F86A;
	Mon, 20 Jul 2026 22:09:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1784578198;
	bh=YNoKubWCFaXYDG/MPv6q6QtwXZ7ZyyWWmeupKBiwD0w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KSUc+07lmh/mtHsn0X3Z2jYqLv8ixrT1TTrtSidT8dRVtK4QeJB6I+D+4RB3eklAz
	 Dz5I3YtuktNmfx+eDdlKlfFJ3qAk5dB1ThHdaqlyZlcD1vCLvxu74rJpMF8brlWUPN
	 ybBkh0zSpnIsvcWa4RM9HWmyLwtQoZA+jhe7JcHqwRJNzy7Rdbt9MkB8UTE3j4ivin
	 Euh+UgHS8HpicX0RdCZW0PWXQH28DLq1RehpSO1cc2Xovt/+vb6Q1xoxmPYS9CXopo
	 qCQK8xthkiEj+rgtAHOQy2ho/X354ivosACdPTsQvwM7JqGQfUjRejizKy4upjWTAp
	 yf0X4I06eZ69Q==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To:
 =?UTF-8?B?SmVhbi1Ob8OrbA==?= Avila via GitGitGadget <gitgitgadget@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH 2/4] doc: convert git-format-patch synopsis and options to new
 style
Date: Mon, 20 Jul 2026 22:09:55 +0200
Message-ID: <2418232.ElGaqSPkdT@piment-oiseau>
In-Reply-To: <xmqqldb6lfa6.fsf@gitster.g>
References:
 <pull.2185.git.1784490878.gitgitgadget@gmail.com>
 <e1ed85e3f2733f0f1cc46416903d1e0c8b4c1856.1784490878.git.gitgitgadget@gmail.com>
 <xmqqldb6lfa6.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Monday, 20 July 2026 01:40:17 CEST Junio C Hamano wrote:
> "Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > Backtick-quote all option terms in the OPTIONS section, convert
> > standalone placeholders to _<placeholder>_ form, and convert
> > single-quoted commands and tools in prose to backtick form.
>=20
> OK.
>=20
> > @@ -708,15 +708,15 @@ BASE TREE INFORMATION
> >=20
> >  The base tree information block is used for maintainers or third party
> >  testers to know the exact state the patch series applies to. It consis=
ts
> >=20
> > +of the "base commit", which is a well-known commit that is part of the
> >=20
> >  stable part of the project history everybody else works off of, and ze=
ro
> >=20
> > +or more "prerequisite patches", which are well-known patches in flight
> > +that is not yet part of the "base commit" that need to be applied on t=
op
> > +of "base commit" in topological order before the patches can be applie=
d.
>=20
> GIven that the last part of this hunk below uses backtick-quoting
> for `prerequisite patch` and `patch id`, shouldn't the references to
> `base commit`, and `prerequisite patch(es)` in the above also be
> backtick quoted for consistency?
>=20

In fact, the formatting were swapped. For proper rendering and preservation=
 of=20
spaces, it should be:

The "base commit" is shown as "`base-commit:` " followed by the 40-hex of
the commit object name.  A "prerequisite patch" is shown as
"`prerequisite-patch-id:` " followed by the 40-hex "patch id", which can
be obtained by passing the patch through the `git patch-id --stable`
command.


Only the constant strings are back-ticked. The others are only quoted.

Will reroll.

> > +The "base commit" is shown as "base-commit: " followed by the 40-hex of
> > +the commit object name.  A `prerequisite patch` is shown as
> > +"prerequisite-patch-id: " followed by the 40-hex `patch id`, which can
> >=20
> >  be obtained by passing the patch through the `git patch-id --stable`
> >  command.




