Received: from out-176.mta1.migadu.com (out-176.mta1.migadu.com [95.215.58.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242DA3F54C5
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 12:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783512596; cv=none; b=U5cHx7zIKlGv+eQ/zIQVbBsoYFt/iC3Z4O00BcVDyfBVCRKDGMRseWh8hYRYzC+k++d3qHWeqWy8PZqrm0mFyn46QmbVWx5Dyc6uiVz8eNQyOqgp0YSceEAdyNQS6Ibr2dw9fvvvIEgquUUT214n9QpFa7Lv33nhxDgdNCrk0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783512596; c=relaxed/simple;
	bh=Lu3BhBbXxrFgq/ujL7JtjSXtMHMNpcH0f40QbY3im9A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Jr2X8KDOP+37kZxfOg8PbUPPc2AWLy54cyq+LeaSc/H7KWSQVESP5oA4r6P87ENTsiLUpbJlAdO4Pub2Bt3BVYZN1gAi4YzmiKPMGNeaBBPapYcLmPcuxM6dNdiwdPqvMniyGYDxLLiw+IxVkKGZsc9TTFLrCTivfsHUQRIThVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=Ta1TVPtp; arc=none smtp.client-ip=95.215.58.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="Ta1TVPtp"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1783512592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw6sSky3EL5k+PlkIhYBAk4YUBqEZyrbq/bvyMeT1l4=;
	b=Ta1TVPtpEfjykXP5wut/iMuLRsi564TVUa1bCzNacfdZpj8RqmPRxtJ/ynN5YqF3uznYXL
	7HuHPQyD2PrpliRiMERq/LD8IxtHNL8uzLzCSb7/7FwO/rwi1zfN2k2APqAL+17odE2XOm
	h44zCzzBV7CaP09hxNMxYxcN6Ys+9Ug=
From: Toon Claes <toon@iotcl.com>
To: kristofferhaugsbakk@fastmail.com, Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>, Siddharth Asthana
 <siddharthasthana31@gmail.com>, git@vger.kernel.org, Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v3 4/4] doc: replay: move =?utf-8?B?4oCcZGVmYXVsdA==?=
 =?utf-8?B?4oCd?= to the right-hand side
In-Reply-To: <V3_default_RHS.784@msgid.xyz>
References: <V2_CV_doc_replay_config.767@msgid.xyz>
 <V3_CV_doc_replay_config.780@msgid.xyz> <V3_default_RHS.784@msgid.xyz>
Date: Wed, 08 Jul 2026 14:09:44 +0200
Message-ID: <87a4s1of7b.fsf@emacs.iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Migadu-Flow: FLOW_OUT

kristofferhaugsbakk@fastmail.com writes:

> From: Kristoffer Haugsbakk <code@khaugsbakk.name>
>
> This is now a description list (see previous commit) and parentheticals
> like this do not go on the left-hand side. Moving it to the other side
> makes it stand out just as much and is also more consistent with the
> rest of the documentation.
>
> Let=E2=80=99s also do the same for the `replay.refAction` description lis=
t.
> That makes the two desc. lists identical in the first sentence. Let=E2=80=
=99s
> add a comment about that for future editors.

Ah, these quad slashes are comments? Well, that's a thing I've learned
today.

Makes sense.

> Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
> ---
>
> Notes (series):
>     v2:
>     =E2=80=A2 It=E2=80=99s =E2=80=9Cdescription list=E2=80=9D, not =E2=80=
=9Cdefinition list=E2=80=9D
>       =E2=80=A2 (Same mistake I have done for =E2=80=9Cline continuation=
=E2=80=9D (it=E2=80=99s =E2=80=9Clist=E2=80=9D))
>     =E2=80=A2 It=E2=80=99s e.g. =E2=80=9Cright-hand side=E2=80=9D (drop =
=E2=80=9C-side=E2=80=9D hyphen)
>     =E2=80=A2 Change `replay.refAction` =E2=80=9Cdefault=E2=80=9D placeme=
nt
>     =E2=80=A2 Now that these two description lists are so similar, add an
>       AsciiDoc comment about it for future editors. Note that I
>       outright deleted this list in the previous version because I
>       didn=E2=80=99t want to keep them in synch. But we can remain aware =
of
>       these with two comments.
>=20=20=20=20=20
>     ---
>=20=20=20=20=20
>     v1:
>     > do not go on the left-hand-side.
>=20=20=20=20=20
>     At least I haven=E2=80=99t seen it.
>
>  Documentation/config/replay.adoc | 5 ++++-
>  Documentation/git-replay.adoc    | 5 ++++-
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/replay.adoc b/Documentation/config/repl=
ay.adoc
> index 7328da9537d..40d1695782a 100644
> --- a/Documentation/config/replay.adoc
> +++ b/Documentation/config/replay.adoc
> @@ -3,7 +3,10 @@ replay.refAction::
>  	The value can be:
>  +
>  --
> -`update`;; Update refs directly using an atomic transaction (default beh=
avior).
> +////
> +These use the first sentences from the description list in git-replay(1).
> +////
> +`update`;; (default) Update refs directly using an atomic transaction.
>  `print`;; Output update-ref commands for pipeline use.
>  --
>  +
> diff --git a/Documentation/git-replay.adoc b/Documentation/git-replay.adoc
> index b4fe43ec687..ea4d14baddb 100644
> --- a/Documentation/git-replay.adoc
> +++ b/Documentation/git-replay.adoc
> @@ -80,7 +80,10 @@ incompatible with `--contained` (which is a modifier f=
or `--onto` only).
>  	Control how references are updated. The mode can be:
>  +
>  --
> -`update` (default);; Update refs directly using an atomic transaction.
> +////
> +Expanded description list compared to 'replay.refAction'.
> +////
> +`update`;; (default) Update refs directly using an atomic transaction.
>  	All refs are updated or none are (all-or-nothing behavior).
>  `print`;; Output update-ref commands for pipeline use. This is the
>  	traditional behavior where output can be piped to `git update-ref --std=
in`.
> --=20
> 2.54.0.22.g9e26862b904
>
>

--=20
Cheers,
Toon
