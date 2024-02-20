Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 698D3154C07
	for <git@vger.kernel.org>; Tue, 20 Feb 2024 22:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469451; cv=none; b=gVIymVKpBnX9Y0s99FNhGHXbujC0r9RGg4pCPoU7kmSlvb8hJJ/74yG8anEg/5uJSRbr1vBBsj+PC2NMNiqbkoHHwKOeARrxz2WSeJ95mCPfD+oQ37OVTTPG0iaxh32reDWoHUmtASNhm8qHylCyZ5bn5H0lZIPok8w3m2PoJ5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469451; c=relaxed/simple;
	bh=r7+AQYq9V9TPfXzzi27hklH29F90NiU0AvbFfXabQZk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TQU9l1dOwP0WidSHPiz98bx7KzCPXawMMDLQIjdTB1CHk0z8EG3uVWgi1s1Wzcb2FRZF4DgM6unDiCdJ8iHyAdCa063tXyb4z+3TfE6kI7j6KB66neMxf4SoRhxKLILVxnl0OfMdqGj4MEwllNQLKqZnfRufMZz313PPWguZP5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=nJbm4A6V; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="nJbm4A6V"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 365F21EB8B3;
	Tue, 20 Feb 2024 17:50:49 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=r7+AQYq9V9TP
	fXzzi27hklH29F90NiU0AvbFfXabQZk=; b=nJbm4A6V5G5NJfZ/8t7ZeMiOZ1N1
	so165w1X7vR+adpImOreWMVH/t1/0F3huLHgiziomq7dMUsj3/kAIHSKskWfIz3M
	wfRwxrdq5dE98nn0oWezmNHHCrmYT47UNyYBpxuRkcXr3d3c6IVhEmfiQvyM6HhJ
	odcM5Vnsc5p3E+U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F0EB1EB8B2;
	Tue, 20 Feb 2024 17:50:49 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 891541EB8B1;
	Tue, 20 Feb 2024 17:50:48 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 3/3] doc: add some missing sentence dots.
In-Reply-To: <1faa934a152d2eedc8949c1e17aff787614770e2.1708468374.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Tue,
 20 Feb 2024
	22:32:54 +0000")
References: <pull.1670.git.1708468374.gitgitgadget@gmail.com>
	<1faa934a152d2eedc8949c1e17aff787614770e2.1708468374.git.gitgitgadget@gmail.com>
Date: Tue, 20 Feb 2024 14:50:47 -0800
Message-ID: <xmqqzfvulph4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 7D6CEA14-D042-11EE-8B80-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH 3/3] doc: add some missing sentence dots.

"sentence dots." -> "full stop at the end of sentence" or something?

> diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.=
txt
> index bd5ae0c3378..6c7e09a1ef5 100644
> --- a/Documentation/config/diff.txt
> +++ b/Documentation/config/diff.txt
> @@ -223,5 +223,5 @@ diff.colorMoved::
> =20
>  diff.colorMovedWS::
>  	When moved lines are colored using e.g. the `diff.colorMoved` setting=
,
> -	this option controls the `<mode>` how spaces are treated
> -	for details of valid modes see '--color-moved-ws' in linkgit:git-diff=
[1].
> +	this option controls the `<mode>` how spaces are treated.
> +	For details of valid modes see '--color-moved-ws' in linkgit:git-diff=
[1].

Very good.  Thanks for spotting this one.

> diff --git a/Documentation/git-fast-export.txt b/Documentation/git-fast=
-export.txt
> index 4643ddbe68f..752e4b9b01d 100644
> --- a/Documentation/git-fast-export.txt
> +++ b/Documentation/git-fast-export.txt
> @@ -48,7 +48,7 @@ When asking to 'abort' (which is the default), this p=
rogram will die
>  when encountering such a tag.  With 'drop' it will omit such tags from
>  the output.  With 'rewrite', if the tagged object is a commit, it will
>  rewrite the tag to tag an ancestor commit (via parent rewriting; see
> -linkgit:git-rev-list[1])
> +linkgit:git-rev-list[1]).

Ditto.
