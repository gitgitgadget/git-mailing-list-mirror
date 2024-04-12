Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CCA14884A
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 16:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712937771; cv=none; b=ehjKXZzeo4sa6QClxPtQ3n2Y49/e5qcEGSwG5LDZfOucBa+TbA9bO+HSIJDiNCrkkPVXloJ3z6wbDN8udmx+9UD/8RCCWN8kb6dfOU0PvKr1Lo0z4rTYZBxnbezpGfrvUl2IHU9kj0kGMOWN11/pz2ez3KA8kOMk9b7bJq6JtXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712937771; c=relaxed/simple;
	bh=0ufqY/JoBVB0q2FyOcakFkEsSgkSMr3S6seaUzE8WSw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lOGnl6Nx4g23D+Hrt9oMELKYmDKkbpUR8OoUilz2KfGmzi8KkWI9QNYbO+2J1yn/WAvUt4mN8ZkIqip7oJdhDSFu6IJjVUV1/+m7y14rcWIn98LowZ6WxLCsfNirAJRS0EJaMswXvHDT2QdTwx5rJfsj2xEH0M/4wuGRMQOWYVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=XmT+Hbmt; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="XmT+Hbmt"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D3BB1E0AA1;
	Fri, 12 Apr 2024 12:02:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=0ufqY/JoBVB0q2FyOcakFkEsSgkSMr3S6seaUz
	E8WSw=; b=XmT+HbmtJBhplR+aTwiHcBApVfaIkF6ASmfcov8RvCwgw8/E8Xwlxm
	P7/tX3213Gy3A/vTxPE63o8LF5YK21XJYJmuQIwmJOEC7bui4Qr2TUXfBdULDgTt
	0OXqyy0YRor7WF7mWwrY9kS2cuhzZ1G+yyJo8Uk5GGMZRbOygSbi4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 340641E0AA0;
	Fri, 12 Apr 2024 12:02:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 844001E0A9F;
	Fri, 12 Apr 2024 12:02:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "blanet via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  blanet <bupt_xingxin@163.com>,  Xing Xin
 <xingxin.xx@bytedance.com>
Subject: Re: [PATCH] Documentation: fix typos describing date format
In-Reply-To: <pull.1716.git.1712911876943.gitgitgadget@gmail.com> (blanet via
	GitGitGadget's message of "Fri, 12 Apr 2024 08:51:16 +0000")
References: <pull.1716.git.1712911876943.gitgitgadget@gmail.com>
Date: Fri, 12 Apr 2024 09:02:41 -0700
Message-ID: <xmqqh6g6po0u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 181A45F4-F8E6-11EE-B9C1-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

"blanet via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Xing Xin <xingxin.xx@bytedance.com>
>
> This commit corrects a typographical error found in both
> date-formats.txt and git-fast-import.txt documentation, where the term
> `email format` was mistakenly used instead of `date format`.

Saying "date" is much more correct than "email" ;-).  Thanks for
noticing both instances.

>  Documentation/date-formats.txt    | 2 +-
>  Documentation/git-fast-import.txt | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
> index 67645cae64f..e24517c496f 100644
> --- a/Documentation/date-formats.txt
> +++ b/Documentation/date-formats.txt
> @@ -11,7 +11,7 @@ Git internal format::
>  	For example CET (which is 1 hour ahead of UTC) is `+0100`.
>  
>  RFC 2822::
> -	The standard email format as described by RFC 2822, for example
> +	The standard date format as described by RFC 2822, for example
>  	`Thu, 07 Apr 2005 22:13:13 +0200`.

RFC 2822 defines it as "date-time" (and this hasn't been updated by
RFC 5322).  "date" is used to specifically mean "day month year".

    https://www.rfc-editor.org/rfc/rfc2822.html#section-3.3

    date-time       =       [ day-of-week "," ] date FWS time [CFWS]
    day-of-week     =       ([FWS] day-name) / obs-day-of-week
    day-name        =       "Mon" / "Tue" / "Wed" / "Thu" /
                            "Fri" / "Sat" / "Sun"
    date            =       day month year

So the new phrasing may get complain from pedants.  Saying "The
standard date-time format as described by RFC 2822" is more
technically correct, but I actually wonder if we should go in the
opposite, looser direction, like

	The timestamp format used by RFC 2822, for example
	...

so that we do not even pretend to use the wording they use in the
RFC documents.  Doing so makes it in line with "git rev-list --help"
which says

	"--date=rfc" shows timestamps in RFC 2822 format, often
        found in e-mail messages.

But that's minor.  "date" is fine as-is.  The same comment applies
to the other hunk.

Thanks.

> diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-import.txt
> index b2607366b91..0ccede255ea 100644
> --- a/Documentation/git-fast-import.txt
> +++ b/Documentation/git-fast-import.txt
> @@ -303,7 +303,7 @@ and some sanity checks on the numeric values may also be performed.
>  	with e.g. bogus timezone values.
>  
>  `rfc2822`::
> -	This is the standard email format as described by RFC 2822.
> +	This is the standard date format as described by RFC 2822.
>  +
>  An example value is ``Tue Feb 6 11:22:18 2007 -0500''.  The Git
>  parser is accurate, but a little on the lenient side.  It is the
>
> base-commit: 436d4e5b14df49870a897f64fe92c0ddc7017e4c
