Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 692C649886
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 21:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hFbyr8PB"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0DE1E1BD4F5;
	Wed, 20 Dec 2023 16:39:39 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=jZXSDzmcNQgR
	BGm3CQGqQEZ1Zr/SZcrnAxdh7pkiS+s=; b=hFbyr8PBN/EUE2JNfoJGr/XJGU9p
	6aAckobQJOztuEqShMNjR2AtlpJedMzQVunXLjG8ctPWh1nCXxs79+fbO36nIRkq
	XNBxkYvqR5Hvm1ItWYM0fdWgj/oNiBTh712oqPuF967IhW+25QhWuHn1QjaDtYwD
	DR4ll6biaNSDrV4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 058161BD4F3;
	Wed, 20 Dec 2023 16:39:39 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6BEB21BD4F2;
	Wed, 20 Dec 2023 16:39:38 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Michael Lohmann <mial.lohmann@gmail.com>
Cc: Michael Lohmann <mi.al.lohmann@gmail.com>,  git@vger.kernel.org,
  l.s.r@web.de,  newren@gmail.com
Subject: Re: [PATCH v3 1/2] Documentation/git-merge.txt: fix reference to
 synopsis
In-Reply-To: <20231220213534.18947-1-mi.al.lohmann@gmail.com> (Michael
	Lohmann's message of "Wed, 20 Dec 2023 22:35:34 +0100")
References: <xmqqy1dor3t5.fsf@gitster.g>
	<20231220213534.18947-1-mi.al.lohmann@gmail.com>
Date: Wed, 20 Dec 2023 13:39:37 -0800
Message-ID: <xmqqmsu4r1t2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 469FDBEC-9F80-11EE-8E9B-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Michael Lohmann <mial.lohmann@gmail.com> writes:

> 437591a9d738 combined the synopsis of "The second syntax" (meaning `git
> merge --abort`) and "The third syntax" (for `git merge --continue`) int=
o
> this single line:
>
>        git merge (--continue | --abort | --quit)
>
> but it was still referred to when describing the preconditions that hav=
e
> to be fulfilled to run the respective actions. In other words:
> References by number are no longer valid after a merge of some of the
> synopses.
>
> Also the previous version of the documentation did not acknowledge that
> `--no-commit` would result in the precondition being fulfilled (thanks
> to Elijah Newren and Junio C Hamano for pointing that out).
>
> This change also groups `--abort` and `--continue` together when
> explaining the prerequisites in order to avoid duplication.
>
> Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> Signed-off-by: Michael Lohmann <mi.al.lohmann@gmail.com>
> ---
>
> @Junio My sentence was ambiguous. I wanted to refer to the upstream
> version of the docs, since that also has the faulty prerequisites, so I
> changed it to "the previous version of the documentation" for
> clarification. If you think that this paragraph is not needed
> nevertheless I am perfectly happy to remove it.

Ah, sorry about the misunderstanding.  Will apply.  Thanks.
