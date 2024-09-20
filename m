Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A5C18EB0
	for <git@vger.kernel.org>; Fri, 20 Sep 2024 18:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726856241; cv=none; b=YE7bS/0uJjSOTDkjCjyqw0KfIdCskKikd85aI7DM1V/yYSH7HTiOZYOIs2DDVrWB638WIf+avTZTHy6qwleUqY5sDVIdTR8WrBhl1GM53isyoL+RsRg9ULB9hIB22kISbe+ksF3iMV6TS8n583mMQa6Fgn3kucUOP1rkYvJoK0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726856241; c=relaxed/simple;
	bh=qxBgLDUQ/G489hY4S9ELsZ9hsZPBpSgeR7UuPCtlkAI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DyAman3P8oielRifhB6MPraX1Xi+AzOy7dV4G8UCHIcLmw/bE1gdFDqYHDTUzsy6M0tfjxWkalUDGkVnJAly2crWe8Rx85tL905TOE/3291F8u5RtoT9JjjauASLyV24mdqnq0w/b2oqkTd/r371HvMiLALH4+n59dXzkLPv8zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=GBwpyGhD; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GBwpyGhD"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id BA9411D03E;
	Fri, 20 Sep 2024 14:17:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qxBgLDUQ/G48
	9hY4S9ELsZ9hsZPBpSgeR7UuPCtlkAI=; b=GBwpyGhD9F/eRdCyyy23NP+FHqIp
	QBrkDQPrFFRJACbTOwXrvU18koW/2pKF+VJ8r6DLzlxdb+Gbk7/62W1k+7DnT288
	k3/p6h1Z0b1ZcRmBK/JGchQjASj7zeR/GPbZMl6H8W7qzzD11SEEFydSYS7nk8XC
	VyAhH+WjVs9LLiA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AFE131D03D;
	Fri, 20 Sep 2024 14:17:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 08EBB1D03C;
	Fri, 20 Sep 2024 14:17:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Andrew Kreimer <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 3/3] Documentation: fix typos
In-Reply-To: <CAPig+cSDQyhpuLx_NKj-jby1Uhx+UMe_7=akJT90hqdeB_B5Vg@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 20 Sep 2024 12:55:02 -0400")
References: <20240920082815.8192-1-algonell@gmail.com>
	<20240920082815.8192-3-algonell@gmail.com>
	<CAPig+cSDQyhpuLx_NKj-jby1Uhx+UMe_7=akJT90hqdeB_B5Vg@mail.gmail.com>
Date: Fri, 20 Sep 2024 11:17:16 -0700
Message-ID: <xmqqo74igpg3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 91FAF6A6-777C-11EF-8439-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, Sep 20, 2024 at 4:29=E2=80=AFAM Andrew Kreimer <algonell@gmail.=
com> wrote:
>> Fix typos in documentation.
>>
>> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
>> ---
>
> All three patches in this series look fine. Thanks.

Thanks, both.
