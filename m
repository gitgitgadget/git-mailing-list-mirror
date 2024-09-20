Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387FC17555
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 20:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726863144; cv=none; b=NhfM/tlK7GnJFc96OVNqfL+mc5dQAc6RtC6SpgP77GyYW13+h/ljCXj95636Yot2l2AcGbfxbb1S7ELTOpJh3M6H9i7df3E3ri0toTOG4U4IpzofToSeCfuqVOEWY+O0+6yH3DG75KeWJGWqHrd+P5NxpwFfwYc4UWF6W4ghHho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726863144; c=relaxed/simple;
	bh=no4PDkvd8dqBq1RgseIWFmVOCDIH/GE5EZMs2i0U8hc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OZLBMHfLksss65yUypErITRBYks5uQePnaSFmMsf6FxSIu6u73FTzLaSaQ0t+lDTzSVASK4SbVbfOVDuuKAj+U4A2l91CRTXopVzEvSXAfZ9OPyp7+RtQ3bFknj64iJLUB5KR+uXo7PNLrGYnJELGfJjkdP9I/9h11ReCJyowSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=kKlvg1ua; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="kKlvg1ua"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1763A18AF0;
	Fri, 20 Sep 2024 16:12:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=no4PDkvd8dqBq1RgseIWFmVOCDIH/GE5EZMs2i
	0U8hc=; b=kKlvg1uaxCYhBIRnLF3XkQp9EjzPBkHdp0in1rQfYxpH7nIhK8LSZQ
	G2gNNrlu9BGr2QWpl+XhRgnzIzeCMM4eeAT4hfZbHlqU9GoORLiHxcwbqkdEDyFk
	kH4L1mMGYNjmPktzU7zzeF1d/TVPiNhtRnudkZVAk4GKYTrTPiVJ0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F6FA18AEE;
	Fri, 20 Sep 2024 16:12:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 70F7718AED;
	Fri, 20 Sep 2024 16:12:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation/technical: fix a typo
In-Reply-To: <20240920082815.8192-1-algonell@gmail.com> (Andrew Kreimer's
	message of "Fri, 20 Sep 2024 11:28:13 +0300")
References: <20240920082815.8192-1-algonell@gmail.com>
Date: Fri, 20 Sep 2024 13:12:20 -0700
Message-ID: <xmqqbk0if5jv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 A4BD4C5C-778C-11EF-8430-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Andrew Kreimer <algonell@gmail.com> writes:

> Fix a typo in documentation.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/technical/sparse-checkout.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/technical/sparse-checkout.txt b/Documentation/technical/sparse-checkout.txt
> index fa0d01cbda..d968659354 100644
> --- a/Documentation/technical/sparse-checkout.txt
> +++ b/Documentation/technical/sparse-checkout.txt
> @@ -287,7 +287,7 @@ everything behaves like a dense checkout with a few exceptions (e.g. branch
>  checkouts and switches write fewer things, knowing the VFS will lazily
>  write the rest on an as-needed basis).
>  
> -Since there is no publically available VFS-related code for folks to try,
> +Since there is no publicly available VFS-related code for folks to try,

As a general rule, unless we are doing codewide sweep to use a
single word in our glossary to refer to the same thing, or
something, we should honor author's preference, when it is already
written and it is not blatantly wrong.

  https://www.collinsdictionary.com/us/dictionary/english/publically

I am inclined to say that we should keep it as written, but I am not
a native speaker, so please cite a source that tells what is written
is blatantly wrong to help me accept this patch.

Thanks.
