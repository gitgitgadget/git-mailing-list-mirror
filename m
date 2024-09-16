Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F1F2E646
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 17:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726509021; cv=none; b=X0rzhb6Y31cbG/hiR09lPGdrEJD0JKkpu0DSg8aBEm26uobMwLSG6RREakUSqR583ezPtuxSWPKOm9HSgetwFcwNmZoACkZfyvsE40ZlIXmCn6p0wu5KjtxUKyiZ3sw0lVflcUYjhX6OeK9/bEUkMeMrQVc/HTVNh1mTjFAenQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726509021; c=relaxed/simple;
	bh=crx2PxbZV1W5YIl9buVz1psfTp4w0pGfEWV90eKP6qo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QdJ+H8BZPxD0DopVle/XvDYIMmPi9Wrk9KToiH4LM/eAdxIaX2+oSueqNBOs+BfPV8qX5h0yGLAyN88xH1iKVxc+0PTfAHtdN0X/56v2YIWPxWqp9kk+tcinm0WWCSdkTfe/99mkRAW2AcnIMjXpPPksIuljrWjkshlVL1ULCQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=BaLxJVwT; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="BaLxJVwT"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 89CD935951;
	Mon, 16 Sep 2024 13:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=crx2PxbZV1W5YIl9buVz1psfTp4w0pGfEWV90e
	KP6qo=; b=BaLxJVwTJrtHFxsSA+fVbnVaJfO0cbCkFYocaTJfnDs28pTc3zdSqY
	E+PfyAYOFDqLUWKpONGufkEMimiv28ghCq3hxiySVZjdfDGiH24rOAhpadLrimvV
	6zIsbk+yJoKI2WOc32SwPAI6zRD59GRbdm0et+cXElh7+Bk4RoDy4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 709073594F;
	Mon, 16 Sep 2024 13:50:12 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E824F3594E;
	Mon, 16 Sep 2024 13:50:10 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Kreimer <algonell@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH] cbtree: fix a typo
In-Reply-To: <Zuf_3mNRm3KuQxlV@void.void> (Andrew Kreimer's message of "Mon,
	16 Sep 2024 12:52:30 +0300")
References: <20240915230522.129253-1-algonell@gmail.com>
	<Zufef70mfdUwSwnY@pks.im> <Zuf_3mNRm3KuQxlV@void.void>
Date: Mon, 16 Sep 2024 10:50:07 -0700
Message-ID: <xmqq34lzqyi8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1E84B7D2-7454-11EF-A400-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Andrew Kreimer <algonell@gmail.com> writes:

>> Thanks!
>> 
>> Patrick
>
> Thank you!

Will queue.  Thanks.
