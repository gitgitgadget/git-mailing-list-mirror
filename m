Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BB1E47766
	for <git@vger.kernel.org>; Fri, 15 Dec 2023 21:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VXVtSqh6"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 820B81BD6C5;
	Fri, 15 Dec 2023 16:01:30 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Wfcal7y3xyzMNB2UBnf8Soe20R9u6Pko4+VZVM
	qTnUc=; b=VXVtSqh6XgTs6a+uBfp1zB5jiJf6zHQPD3n/aRlYt/eQkJcSE4uQgC
	iTPDX6VVYrtphDtU8ewQdB/4QmKCNwqjjfSW40NIIk7J4pRgOPLn1bsyFLYs7AmO
	+QjE6ohEvQNUYq5X7WaKE9nHEq0jpd8E9e3DfLW94PWJfY8jkPg7w=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 798631BD6C4;
	Fri, 15 Dec 2023 16:01:30 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DFE0D1BD6C2;
	Fri, 15 Dec 2023 16:01:29 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  Benjamin Lehmann <ben.lehmann@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] git-add.txt: add missing short option -A to synopsis
In-Reply-To: <20231215204333.1253-1-ericsunshine@charter.net> (Eric Sunshine's
	message of "Fri, 15 Dec 2023 15:43:33 -0500")
References: <CAM=w4Pn46nTcWA1e=n4Rms76gCx7iqbRmOWf3=vRmKgtbhqQmA@mail.gmail.com>
	<20231215204333.1253-1-ericsunshine@charter.net>
Date: Fri, 15 Dec 2023 13:01:28 -0800
Message-ID: <xmqqjzpfkwnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E7DC184-9B8D-11EE-80D9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> With one exception, the synopsis for `git add` consistently lists the
> short counterpart alongside the long-form of each option (for instance,
> "[--edit | -e]"). The exception is that -A is not mentioned alongside
> --all. Fix this inconsistency
>
> Reported-by: Benjamin Lehmann <ben.lehmann@gmail.com>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---

Thanks.

I dug the history just in case we deliberately wanted to leave this
out of the synopsis section, but the side branch leading to the
merge at 378335b3 (Merge branch 'jc/add-addremove', 2008-07-20) does
not say we wanted to discourage "-A" (and encourage "--all").  This
would be a welcome change.

Will queue.
