Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA888BFD
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 23:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721517369; cv=none; b=e5UQMtGM1JODIR0+3tNBnSkhidAB4VpROkkjVqErG0U1YnKppXhYXB3Q7YCwTHaIREVi66xcrbEusRDtW41yzyehy5yO6dCbPv3x4S1XToGKsDSOcSkh/wfAhy3LlQ33smDYoVFK5h3jRfvxr1RAdDRtBBubcYp23IcD/ApSnRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721517369; c=relaxed/simple;
	bh=mj3ri3CFjgqORANmER30MhRogc245PWhxdPukIar1mg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f/TEgz0nzpxK8bprHbxfipGv/YeiSF0bxjnAe6bcU813hk+RR1XFzvaJ4+tOsav5vSKuKWNaoj5cnOHQvNYcuOE67IeDEx9AtoZ4eProGdSZI3hlVhH0hCFaS2NBdAZUxOtq18b+MotCmfapCUVHuesqW2m12T+eaJx2SAwMmRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mV4vliJB; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mV4vliJB"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B65B52BBCD;
	Sat, 20 Jul 2024 19:16:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mj3ri3CFjgqO
	RANmER30MhRogc245PWhxdPukIar1mg=; b=mV4vliJBSNcleFC6VpMIeA+pjqIv
	Ez/TO2roUsBsuBpyHvFF1PzUG8lkGj51CfJL6JFFD70frh0+jTG5Prla70gIAASh
	M9R+JE8T8W3KbQ+j8rpfK3/i0eytnyvn/uM87axz51JifqSNWlLfVIKyIShZ/rVj
	RHPgY4XtLXIQbvQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B03692BBCC;
	Sat, 20 Jul 2024 19:16:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D8C3D2BBCB;
	Sat, 20 Jul 2024 19:16:03 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] doc: git-clone fix discrepancy between asciidoc and
 asciidoctor
In-Reply-To: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Sat, 20 Jul 2024 17:34:13
	+0000")
References: <pull.1765.git.1721496853517.gitgitgadget@gmail.com>
Date: Sat, 20 Jul 2024 16:16:02 -0700
Message-ID: <xmqq8qxvhcy5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 090198AA-46EE-11EF-AB2F-9625FCCAB05B-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Asciidoc.py does not have the concept of generalized roles, whereas
> asciidoctor interprets [foo]`blah` as blah with role foo in the
> synopsis, making in effect foo disappear in the output. Note that
> square brackets not directly followed by an inline markup do not
> define a role, which is why we do not have the issue on other parts of
> the documentation.

This was utterly misleading, at least to me, and it took a few times
of reading for me to really understand what you wanted to say.

It does not matter that "generalized roles" is not known by
AsciiDoc.  What really causes the breakage is that a string inside
[square brackets] followed by string inside `a pair of back quotes`
is interpreted by Asciidoctor as "generalized roles" (whatever it
is), even though we do not care at all about such a feature here.

How about phrasing it more like so?

    Writing a string inside [square brackets], immediately followed
    by a string inside `a pair of back quotes`, causes asciidoctor
    to eliminate the string inside [square brackets], because it is
    a syntax to trigger a "generalized role" feature, which we do
    not care about in the context of the synopsis section here.

    Work it around by inserting an otherwise no-op {empty} string to
    forbid asciidoctor from triggering that feature here.  AsciiDoc
    is not affected negatively by this additional empty string.

The reondered result _might_ be easier to read than pre-2.45 version
of documentation, but I somehow find the updated SYNOPSIS section
almost impossible to work with in the source form.  And the need for
these otherwise no-op {empty} makes it even less pleasant to work
with.

I wonder if there is a magic incantation that says "everything
should be typeset in monospace in this block, unless ..." so that we
can lose all these `back quotes`?  And then the part that follows
"unless ..." would say how we mark up the <placeholder> part which
is the only thing exempt from "everything is in monospace" default.

Thanks for a quick response.

>  Documentation/git-clone.txt | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
> index 5de18de2ab8..8e925db7e9c 100644
> --- a/Documentation/git-clone.txt
> +++ b/Documentation/git-clone.txt
> @@ -13,9 +13,9 @@ SYNOPSIS
>  	  [`-l`] [`-s`] [`--no-hardlinks`] [`-q`] [`-n`] [`--bare`] [`--mirro=
r`]
>  	  [`-o` _<name>_] [`-b` _<name>_] [`-u` _<upload-pack>_] [`--referenc=
e` _<repository>_]
>  	  [`--dissociate`] [`--separate-git-dir` _<git-dir>_]
> -	  [`--depth` _<depth>_] [`--`[`no-`]`single-branch`] [`--no-tags`]
> -	  [++--recurse-submodules++[++=3D++__<pathspec>__]] [`--`[`no-`]`shal=
low-submodules`]
> -	  [`--`[`no-`]`remote-submodules`] [`--jobs` _<n>_] [`--sparse`] [`--=
`[`no-`]`reject-shallow`]
> +	  [`--depth` _<depth>_] [`--`[`no-`]{empty}`single-branch`] [`--no-ta=
gs`]
> +	  [++--recurse-submodules++[++=3D++__<pathspec>__]] [++--++[++no-++]{=
empty}++shallow-submodules++]
> +	  [`--`[`no-`]{empty}`remote-submodules`] [`--jobs` _<n>_] [`--sparse=
`] [`--`[`no-`]{empty}`reject-shallow`]
>  	  [++--filter=3D++__<filter-spec>__] [`--also-filter-submodules`]] [`=
--`] _<repository>_
>  	  [_<directory>_]
> =20
>
> base-commit: a7dae3bdc8b516d36f630b12bb01e853a667e0d9
