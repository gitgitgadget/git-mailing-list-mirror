Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7D82D792
	for <git@vger.kernel.org>; Wed, 24 Jul 2024 23:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721862959; cv=none; b=BvAEcBuVLqfcIDNFcc+dsI7ZTRX0OfhBwwTAy1+xdTn8NUhCF9g3V1B+xv8M3TRs8iu7rQcoTNi/Ox0n7Y/J4g3MDO//pSQ3ZcXk9s0klnGTatUOSY47Z6onDz7KesNHDLzUlASuLiOTqnzJ6E78BmWYwEZItLoi4qD7K0g0SBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721862959; c=relaxed/simple;
	bh=NgkL+n8pjoxL7QKwV3/kvmP/hxBKXiKjJT7XS99QcRc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=biw9htnCT88fegAvj6x1nIH3yI8HuykDYz2NgGGGbTHwcOHOrOJciMP4B7n/od0IKTnuKjD/HvexJcUXgSsdH8phs4OEsgLVsbEiciKeEPFcIHtJV10dmoVOjONtN+HGt8SftPOKGFKVbCDEcXKjmzv1pF8BVAMTnL3K5AXlic4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=FI9/Nvar; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="FI9/Nvar"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C202C2CCE8;
	Wed, 24 Jul 2024 19:15:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=NgkL+n8pjoxL
	7QKwV3/kvmP/hxBKXiKjJT7XS99QcRc=; b=FI9/NvarsfiViya4CFaliAcjjCmR
	k+k0Pcs06tQAW9FDIbqjj1hC8MAQgI6apqhWDw9bjmeBehgF7QST9mlRfOPAnyDG
	thEPoz7Z5hxtoKp1SjwRxPUmrBnkMswnuRX7mkHRvcJeBICSW5elh2qrrXwgQAkz
	a5DrDiZGl03vp9Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id ABED02CCE6;
	Wed, 24 Jul 2024 19:15:50 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10CE02CCE5;
	Wed, 24 Jul 2024 19:15:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH v2 0/3] doc: introducing synopsis para
In-Reply-To: <pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Wed, 24 Jul 2024 21:06:16
	+0000")
References: <pull.1766.git.1721774680.gitgitgadget@gmail.com>
	<pull.1766.v2.git.1721855179.gitgitgadget@gmail.com>
Date: Wed, 24 Jul 2024 16:15:48 -0700
Message-ID: <xmqqcyn2s7ob.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 AA6C0E10-4A12-11EF-BFE7-BAC1940A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

"Jean-No=C3=ABl Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Following several issues with the way the formatting of synopsis is don=
e in
> the manpages that were recently reworked, this patch series introduces =
the
> processing of a new custom paragraph attribute 'synopsis'.

The rendered result looks OK but the source being just like what we
would write in plain text files without any extra mark-up makes it
look quite nice.

I wonder what we want to do with some oddballs, like git-shortlog
that uses "|" not as an alternative but literally a pipe (i.e. "feed
the output of this other command via a pipe to this command"),
though.

    git log --pretty=3Dshort | git shortlog [<options>]

There may be also some page that indicates "this command takes its
input from its standard input" by using something like

    git cmd [--foo] [--bar] <input-file

which we may need to think how to handle.  The easiest way out may
be to say "don't do these to indicate/force where the input comes
from".  I dunno.

Thanks.


