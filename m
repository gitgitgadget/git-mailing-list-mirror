Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798DE200DE
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052646; cv=none; b=ENU1/zv+cU6pFwoIqq3iV05ILIiMvDpxgD1+sULDBSmko1s67Kkn4jdPpQXLq3+pkrmv8/NB2J9mLiJ1TOOiCPowst2+NHPI0EwWSdle++SbUM08XO2GSckTmY0odjt7XLW0YugGP3AbUpuvWVfpuJSjrgemrAFBzNePap7NEYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052646; c=relaxed/simple;
	bh=tWZUitChUH/bzli4K4CaeilI/KbEqQH+saoyDPbn6SU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tXsNeSkyxO51dunvtJVPnqiNa/DhHWVm3QW7GpZLLF1RYGZl6d6pcvN9gjDQhQah0YMbk3eET+BQCpOtq0VcJ5LQ6HvK8tORaGQIbF0SMdpEppUfxsvgxqcMcJEivOBAAHt1igFOfHS4Z2mvGoUnW6TJzLIYD3++7MoRoNYbRsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=iXZ641lm; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="iXZ641lm"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 274F7237A0;
	Tue, 27 Feb 2024 11:50:45 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=tWZUitChUH/bzli4K4CaeilI/KbEqQH+saoyDP
	bn6SU=; b=iXZ641lmgs1ehtO5ZC8PBy1f841s0TIdRNBU2UilLMWw95T8tiRKKy
	onTR2NvFO5JHC4igPq3qSM3/bPmh0GgJSH/TmGR6BY9KZyHBhT73CVFpPX0AW70X
	HEqvU4OcA2mJwqPJ0JfzC7qzo+ku17ARBXIx/IM8hvrdH6n7Hla/o=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1ED012379F;
	Tue, 27 Feb 2024 11:50:45 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 50FED2379D;
	Tue, 27 Feb 2024 11:50:41 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Richard Macklin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Richard Macklin <code@rmacklin.dev>,
    Andy Koppe <andy.koppe@gmail.com>
Subject: Re: [PATCH] rebase: fix typo in autosquash documentation
In-Reply-To: <pull.1676.git.1709015578890.gitgitgadget@gmail.com> (Richard
	Macklin via GitGitGadget's message of "Tue, 27 Feb 2024 06:32:58
	+0000")
References: <pull.1676.git.1709015578890.gitgitgadget@gmail.com>
Date: Tue, 27 Feb 2024 08:50:39 -0800
Message-ID: <xmqqv869vokg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57675A40-D590-11EE-B042-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Richard Macklin via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Richard Macklin <code@rmacklin.dev>
>
> This is a minor follow-up to cb00f524df (rebase: rewrite
> --(no-)autosquash documentation, 2023-11-14) to fix a typo introduced in
> that commit.
>
> Signed-off-by: Richard Macklin <code@rmacklin.dev>
> ---

[jc: andy cc'ed as the original author to give him a chance to give
his Acked-by]

>  Documentation/git-rebase.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 06206521fc3..e7e725044db 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -607,7 +607,7 @@ The recommended way to create commits with squash markers is by using the
>  linkgit:git-commit[1], which take the target commit as an argument and
>  automatically fill in the subject line of the new commit from that.
>  +
> -Settting configuration variable `rebase.autoSquash` to true enables
> +Setting configuration variable `rebase.autoSquash` to true enables

Good eyes.  Thanks for fixing.

>  auto-squashing by default for interactive rebase.  The `--no-autosquash`
>  option can be used to override that setting.
>  +
>
> base-commit: 3c2a3fdc388747b9eaf4a4a4f2035c1c9ddb26d0
