Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7CD42941B
	for <git@vger.kernel.org>; Sun, 21 Apr 2024 18:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713724156; cv=none; b=L3ZCiKzOkzNR8x/cBABxwf3p0M1qHjuuDDbSB6SQgIywQhI1F7FlmYhOE3AW/KutLRjNexHL8Y7RUKWzv5LcUVicziiBwPvy5vPweQaMVu9+mtvNGDBpCB8eGG+UmhUXOtF8TGc5tCV4FsthlnXJeNl9T/KyAQA+Pg/+zB8Fka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713724156; c=relaxed/simple;
	bh=MAWXMx6gyySXxzxaviEVFqIPKwlqhrSZ8OPTKxLTzcI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bwt84j9ATd4XLGpZmD1VakkSAnnp2bdrysYRgiae/PNfQyRdNeLJdUJxQloX525kK60RjZYse+CAM66YVqVStpCSMh2F3Fd4nTZQIFIz4HPRD94MDS6F4YyClE5fX6v+wE0puZRYclykeiCPzFSSc64X5/yFXVJfxa8j2SfcpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wDRaftND; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wDRaftND"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 48A492315B;
	Sun, 21 Apr 2024 14:29:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=MAWXMx6gyySXxzxaviEVFqIPKwlqhrSZ8OPTKx
	LTzcI=; b=wDRaftNDCqzIlPDo38WY1JoaeTy1hLRzD7WxJG8VYYZPeGHTTJIvxL
	SEwO87G8YluvjNHY8AT7lQMywjiPGBudaYbA5NEXbMi0gKuhGgept5551m6SY9gR
	77NvMeao7dAqtPPkRD5BQdO3z180fL5qiiBueBmaNpr2nxCK7Tb2Q=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3F6B82315A;
	Sun, 21 Apr 2024 14:29:15 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B1C5223157;
	Sun, 21 Apr 2024 14:29:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] docs: remove duplicate entry and fix typo in 2.45
 changelog
In-Reply-To: <pull.1711.git.git.1713642690371.gitgitgadget@gmail.com> (Orgad
	Shaneh via GitGitGadget's message of "Sat, 20 Apr 2024 19:51:30
	+0000")
References: <pull.1711.git.git.1713642690371.gitgitgadget@gmail.com>
Date: Sun, 21 Apr 2024 11:29:10 -0700
Message-ID: <xmqqseze1seh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 0C951D20-000D-11EF-8DE6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>
>  Documentation/RelNotes/2.45.0.txt | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
>
> diff --git a/Documentation/RelNotes/2.45.0.txt b/Documentation/RelNotes/2.45.0.txt
> index 0570dcd8773..38458664407 100644
> --- a/Documentation/RelNotes/2.45.0.txt
> +++ b/Documentation/RelNotes/2.45.0.txt
> @@ -100,7 +100,7 @@ Performance, Internal Implementation, Development Support etc.
>  
>   * The way placeholders are to be marked-up in documentation have been
>     specified; use "_<placeholder>_" to typeset the word inside a pair
> -   of <angle-brakets> emphasized.
> +   of <angle-brackets> emphasized.

Thanks.

> @@ -110,9 +110,6 @@ Performance, Internal Implementation, Development Support etc.
>     clean.requireForce has been simplified, together with the
>     documentation.
>  
> - * The code to iterate over refs with the reftable backend has seen
> -   some optimization.
> -
>   * Uses of xwrite() helper have been audited and updated for better
>     error checking and simpler code.

Interesting.  It is likely that we had two topics that did things
that summarised down to the same description.  They are 

 448a74e1 (Merge branch 'ps/reftable-iteration-perf-part2', 2024-03-14)
 9f67cbd0 (Merge branch 'ps/reftable-iteration-perf', 2024-02-26)

I do not know which is better between removing the second entry
(which is what this patch is doing, as the entries are in
chronological order of the topics' graduation to 'master'), or
amending it to say "has seen some more optimization".

