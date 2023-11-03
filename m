Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D528468
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 08:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pvOlOQVE"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF5891B9
	for <git@vger.kernel.org>; Fri,  3 Nov 2023 01:16:18 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4F0F03396C;
	Fri,  3 Nov 2023 04:16:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=+wAOKxNtaj7CPtXB4wnbeZUt1YykZWAGNLHOkI
	ClNtc=; b=pvOlOQVEuNZMfow9TkFZS//kuyMHzLPy+CNvl2OKjoV4IcBhzCbqbi
	yuHdPqp69DUGcP0cs8Vj6qtP6mS19d4L5Y3Nm56v0YHt9zd+15DQ2mEuPQzbTxGs
	lvk1mUU+WCYnXjISwNFaimTAGiIpI/MUp+Sb/824ws7s2YxegR4P4=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 479A03396B;
	Fri,  3 Nov 2023 04:16:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E9EDC3396A;
	Fri,  3 Nov 2023 04:16:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] ci: upgrade to using macos-13
In-Reply-To: <pull.1607.git.1698996455218.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Fri, 03 Nov 2023 07:27:35
	+0000")
References: <pull.1607.git.1698996455218.gitgitgadget@gmail.com>
Date: Fri, 03 Nov 2023 17:16:13 +0900
Message-ID: <xmqqo7gbjlpu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 41B16FEE-7A21-11EE-9363-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> In April, GitHub announced that the `macos-13` pool is available:
> https://github.blog/changelog/2023-04-24-github-actions-macos-13-is-now-available/.
> It is only a matter of time until the `macos-12` pool is going away,
> therefore we should switch now, without pressure of a looming deadline.
> ...
> To reinstate the spirit of that commit _and_ to fix that build failure,
> let's switch to the now-newest GCC version: v13.x.

Thank you very much for a well reasoned patch that is very timely.
I am tempted to fast-track this one down from 'seen' to 'maint'
before we tag -rc1.

Will queue.
