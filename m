Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B2CB46425
	for <git@vger.kernel.org>; Wed, 20 Dec 2023 16:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JvzqNehu"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 85B2D2E1C3;
	Wed, 20 Dec 2023 11:39:31 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=JAOF1VcwKAcUS2bsIeGpZX5hKIuWzZr6lVMUcr
	ipJrg=; b=JvzqNehuQNtpN0y9gIev/kcVGquSYRdhrAGuffwOVBngHQVd1Aofj+
	pS4bOArGukS7vg8+rAPHud/ZlcKlS37gSdsncOGQnaBtR+An2QLxqOB7D6aPwE+O
	kCfgqyDefB/b85rVM0QkkM7XHg/6zlL1cB8A6sQdYitWdKeA2iyvk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7E1092E1C2;
	Wed, 20 Dec 2023 11:39:31 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 279EC2E18D;
	Wed, 20 Dec 2023 11:39:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Josh Soref via
 GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Josh Soref
 <jsoref@gmail.com>
Subject: Re: [PATCH 6/8] SubmittingPatches: clarify GitHub visual
In-Reply-To: <CABPp-BFU+4Xy8tVrU5qV3GX7Mr3-nOEtSgix3MSne5VVW2hz2Q@mail.gmail.com>
	(Elijah Newren's message of "Wed, 20 Dec 2023 07:40:25 -0800")
References: <pull.1623.git.1702975319.gitgitgadget@gmail.com>
	<043d2a24202d39c5564e4a4369c86ae4648dd721.1702975320.git.gitgitgadget@gmail.com>
	<e788cf7b-56c7-48c2-ad4f-65d9c9e73ad5@web.de>
	<CABPp-BFU+4Xy8tVrU5qV3GX7Mr3-nOEtSgix3MSne5VVW2hz2Q@mail.gmail.com>
Date: Wed, 20 Dec 2023 08:39:26 -0800
Message-ID: <xmqq8r5ou8u9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 57A94D8A-9F56-11EE-99DF-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Elijah Newren <newren@gmail.com> writes:

> ...  I'm tempted to just
> oversimplify ("...marked with red."), but am slightly concerned about
> red/green color-blind folks.

(sheepishly raises hand).  Thanks for being considerate.

> I suspect they'd figure it out anyway by
> comparing the checkmarks (within green) to the x's (within red),

I 100% agree with this.

> but
> if we want to be more detailed, perhaps we drop the "cross" altogether
> and just describe it literally: "...marked with a red circle
> containing a white x."?

Thanks.
