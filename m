Received: from smtpfb2-g21.free.fr (smtpfb2-g21.free.fr [212.27.42.10])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84E791F0991
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772287748; cv=none; b=RIcqx77o1NYN/ncaAa8fWRUJRtNruqMdTKpTgqv0gdtIEAqCyY+btCR3BjUuVnmbs36zNcZkmPju/wqxcCRXrN+wAXehAAEoQzemXsljIoJ0ztNRRtyGJcZ0dJWsF5eP5RhArUMnEZNs66DoL0PXC6c4zu7vekBKiVpOatLfR6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772287748; c=relaxed/simple;
	bh=+hpwWdwce7fBfuqkePQt9Kbu+bEhuCEEsJIjbxp/+R8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EnQgKU/9h8w0flkdp6k9jNY0Ihg53yH9vvLH+IpUWofvaVE5OTZ7DlnC77vIfBV/ApXFqsNGVHMZ0/78NSw+oQtuJ8gh/dvSCWnU2rv/56NXFjcpVHIpyef5I8KFcCauJNfCsnM0SBcgpSBcSnsm5xC9pbw0W6ytBgSSx9PCwhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b=hwk3RuHz; arc=none smtp.client-ip=212.27.42.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=free.fr header.i=@free.fr header.b="hwk3RuHz"
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [212.27.42.1])
	by smtpfb2-g21.free.fr (Postfix) with ESMTP id B91874CF9C
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 15:08:54 +0100 (CET)
Received: from piment-oiseau.localnet (unknown [IPv6:2a01:e0a:d1:f360:3d51:7a10:3981:3744])
	(Authenticated sender: jn.avila@free.fr)
	by smtp1-g21.free.fr (Postfix) with ESMTPSA id 8698FB0053D;
	Sat, 28 Feb 2026 15:08:41 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
	s=smtp-20201208; t=1772287727;
	bh=+hpwWdwce7fBfuqkePQt9Kbu+bEhuCEEsJIjbxp/+R8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hwk3RuHzWwWaqWCbjXKNVopsN8d8QT9Ggqa33PShwu27DSFD3SVET26eCTGTnXatw
	 9iUSqabivGoxO80qiaTtKZQLNKYXoYqtXozU38+9phV0yBCeltumKFMUMFpIdbLgeY
	 1vsW8TabxtUnlwtSRs9pCc5QO0+VcS4CHRe6QM/6zubDewfoah5tD3jdop5tJCOZCf
	 Dj3+IgRbJawZ88B/uJNybTPTK9tHS4BJGDExKSIgowM0bBNbcsDOSR1mg64JHBKCpZ
	 nj7cNuG6dQywdiFwQ/sdUZLDM9fIIkPjr5uDqN+ozJpqLglLdD8Ob/3Z+saCK5mbI+
	 1BbBpvExpGn3w==
From: =?UTF-8?B?SmVhbi1Ob8OrbA==?= AVILA <jn.avila@free.fr>
To: git@vger.kernel.org, kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
 kristofferhaugsbakk@fastmail.com, gitster@pobox.com, peff@peff.net
Subject:
 Re: [PATCH v2 2/2] doc: diff-options.adoc: show format.noprefix for
 format-patch
Date: Sat, 28 Feb 2026 15:08:41 +0100
Message-ID: <5970320.DvuYhMxLoT@piment-oiseau>
In-Reply-To: <better_for_translators.424@msgid.xyz>
References:
 <ff86f877-4b75-403d-a5a4-10ab528a9691@free.fr>
 <better_for_translators.424@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Saturday, 28 February 2026 13:20:33 CET kristofferhaugsbakk@fastmail.com=
=20
wrote:
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>=20
> On Fri, Feb 27, 2026, at 10:57, Jean-No=C3=ABl Avila wrote:
> > Le 24/02/2026 =C3=A0 00:30, kristofferhaugsbakk@fastmail.com a =C3=A9cr=
it :
> >> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> >>
> >>[snip]
> >>
> >>  `--default-prefix`::
> >>  	Use the default source and destination prefixes ("a/" and "b/").
> >>=20
> >> -	This overrides configuration variables such as `diff.noprefix`,
> >> +	This overrides configuration variables such as
> >> +ifndef::git-format-patch[`diff.noprefix`,]
> >> +ifdef::git-format-patch[`format.noprefix`,]
> >>=20
> >>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
> >>  	(see linkgit:git-config[1]).
> >=20
> > Hello,
> >=20
> > This kind of sentence assembly does not fit well with translations. Each
> > hunk of the sentence is processed separately and it is a difficulty for
> > translators as they need to understand the surrounding context of a
> > segment when translating it.
> >=20
> > It is safer to just write the whole paragraph, or at least a sentence in
> > the ifdef/ifndef sections.
>=20
> Thanks for bringing this up. I have never taken doc translations into
> consideration.
>=20
> Would the following be the correct approach?
>=20
> -- 8< --
> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
> Subject: [PATCH] doc: diff-options.adoc: make *.noprefix split translatab=
le
>=20
> We cannot split single words like what we did in the previous
> commit. That is because the doc translations are processed in
> bigger chunks.
>=20
> Instead write the two paragraphs with the only variations being this
> configuration variable.
>=20
> It=E2=80=99s not easy to spot the difference here. So let=E2=80=99s leave=
 a comment
> for translators.
>=20
> Reported-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>  Documentation/diff-options.adoc | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/diff-options.adoc b/Documentation/diff-
options.adoc
> index 8f632d5fe1a..e4d02cc93a9 100644
> --- a/Documentation/diff-options.adoc
> +++ b/Documentation/diff-options.adoc
> @@ -859,12 +859,19 @@ endif::git-format-patch[]
>  	Do not show any source or destination prefix.
>=20
>  `--default-prefix`::
> +// TRANSLATORS: format.noprefix / diff.noprefix
> +ifdef::git-format-patch[]
>  	Use the default source and destination prefixes ("a/" and "b/").
> -	This overrides configuration variables such as
> -ifndef::git-format-patch[`diff.noprefix`,]
> -ifdef::git-format-patch[`format.noprefix`,]
> +	This overrides configuration variables such as `format.noprefix`,
>  	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
>  	(see linkgit:git-config[1]).
> +endif::git-format-patch[]
> +ifndef::git-format-patch[]
> +	Use the default source and destination prefixes ("a/" and "b/").
> +	This overrides configuration variables such as `diff.noprefix`,
> +	`diff.srcPrefix`, `diff.dstPrefix`, and `diff.mnemonicPrefix`
> +	(see linkgit:git-config[1]).
> +ifndef::git-format-patch[]

I think this line should read : endif::git-format-patch[]
I also don't quite understand the addition of the // TRANSLATORS: part. Thi=
s=20
is not needed as each paragraph will be translated as a standalone segment.

Otherwise, this format of conditional text is fit for translation.

Thanks





