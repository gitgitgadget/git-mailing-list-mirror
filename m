Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286EBFC1C
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="G2gbTOxa"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF0B4CA
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 10:10:06 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 7DD6C27020;
	Fri, 20 Oct 2023 13:10:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bI8WUSuif8oa
	yuZ1pmlBYurU9qzOgCOZcmhhFEAoH58=; b=G2gbTOxa/+A+pX+fsAQbleXh3UhL
	EYiYApYCpo497OzR9zpfyy0ZjuLvVXs4IsL6ucWQn5CtULSZCmaxrz+ShQFovpLq
	F/5kIqinqYpNYfq+wmR1Ur+igGx7oKqWPtWUftSM4EzlJy75TsHvBD4OYFt7nCir
	BXkZY6xCC4IPFlk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 763EB2701F;
	Fri, 20 Oct 2023 13:10:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DFD712701C;
	Fri, 20 Oct 2023 13:10:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Isoken Ibizugbe <isokenjune@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2] builtin/branch.c: adjust error messages to coding
 guidelines
In-Reply-To: <CAP8UFD1U0cz3CDdE_0d0FUgPKP2pX-ZcVDJqz2tW-+rnZ7rvQw@mail.gmail.com>
	(Christian Couder's message of "Fri, 20 Oct 2023 11:41:15 +0200")
References: <e08b2ec4-786a-4c18-b7af-0a6a250ae0f0@gmail.com>
	<20231019084052.567922-1-isokenjune@gmail.com>
	<CAJHH8bFXVnFgjoCD+JU2uw77JAWUiKU+G=ub9Xg7xYJ_MwXPQQ@mail.gmail.com>
	<CAP8UFD1U0cz3CDdE_0d0FUgPKP2pX-ZcVDJqz2tW-+rnZ7rvQw@mail.gmail.com>
Date: Fri, 20 Oct 2023 10:10:01 -0700
Message-ID: <xmqqbkctrziu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 820F694E-6F6B-11EE-80B3-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

>> Hello Junio, I would appreciate your comment on this.
>
> Please don't expect Junio to give direct feedback on all the patches
> sent to the mailing list. This patch has already been reviewed by
> Rub=C3=A9n.

Correct.

> If Junio doesn't review it and if this patch is not mentioned
> in the next "What's cooking in git.git" email from Junio, it likely
> means that you should send a version 3 addressing Rub=C3=A9n's feedback
> about the commit message.

While the above may be a good advice, I try to be easier to read
than the above tealeaf-reading, especially to new contributors ;-)

At least I should comment on Rub=C3=A9n's comment, but I haven't got
around to it yet.

Thanks.




