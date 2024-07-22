Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1124B4D584
	for <git@vger.kernel.org>; Mon, 22 Jul 2024 22:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721689151; cv=none; b=t+PSemzbM4WbyWAt5zVpaJiBoTQNzMqtUTWFm/MvdMJuMeFPmtpMKd3Q01CyGVOZXnAsmI7w/zRYg19cqa+Y/K1MqZ2SmpN1+jaFW0/GufdeHf73ZyOyCG3hc1aNPI8QBzYxr/jhx4Vis0lXNdTzkydSbZfn9ScDTUELw5rR9sE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721689151; c=relaxed/simple;
	bh=lEBoLzThJJg4sExJxeeEzjhVr43MorfMMXiHDntfeQg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ED7tfe9LBzalv8h88WPgVc4w2FWVtqs9k7av1slLZcFrqaWeDptqMg0xHzd/mcYnhqKchzc/AEu9BL1K/0kESl3ezoxLC9Q7QLNcBeluk7LZ8qRvZ0rIZrdA70G3sD6r+3aa1X6YqH00lk9GjzwewIz7sow54aaIoJ4H7aaIxN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=DJLfHTpP; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="DJLfHTpP"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id D8EFB3B0AB;
	Mon, 22 Jul 2024 18:59:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lEBoLzThJJg4sExJxeeEzjhVr43MorfMMXiHDn
	tfeQg=; b=DJLfHTpPtd/B9Lg+B6W4sv5Hcxr3WVuawy1IUtpYjy3SN56OeB2AML
	lz+Kg9GMaG0oZrPN9cPWsUOcNfZMXTY6Y/GGinQMBn1fsjU5cF7wI+2JuwWndb8T
	A3mI6dvo7Q0nLY1/iAHUFevNiWJX5qywSFWnGtU4ZZSeaCZHJ2Cqg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CFAA03B0AA;
	Mon, 22 Jul 2024 18:59:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 378D03B0A9;
	Mon, 22 Jul 2024 18:59:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Tomas Nordin <tomasn@posteo.net>
Cc: git@vger.kernel.org,  charvi077@gmail.com
Subject: Re: [PATCH 1/1] doc: remove dangling closing parenthesis
In-Reply-To: <20240722225302.124356-1-tomasn@posteo.net> (Tomas Nordin's
	message of "Mon, 22 Jul 2024 22:53:02 +0000")
References: <20240722225302.124356-1-tomasn@posteo.net>
Date: Mon, 22 Jul 2024 15:59:06 -0700
Message-ID: <xmqqy15t824l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 00747202-487E-11EF-9A52-BAC1940A682E-77302942!pb-smtp2.pobox.com

Tomas Nordin <tomasn@posteo.net> writes:

> The second line of the synopsis, starting with [--dry-run] has a
> dangling closing paren in the second optional group. Probably added by
> mistake, so remove it.
>
> Signed-off-by: Tomas Nordin <tomasn@posteo.net>
> ---
>  Documentation/git-commit.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index 89ecfc63a8..c822113c11 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -9,7 +9,7 @@ SYNOPSIS
>  --------
>  [verse]
>  'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
> -	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>)]
> +	   [--dry-run] [(-c | -C | --squash) <commit> | --fixup [(amend|reword):]<commit>]
>  	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
>  	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
>  	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]

Wonderful.  Thanks.

Will queue.

