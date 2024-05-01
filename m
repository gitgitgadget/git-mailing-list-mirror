Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3D39461
	for <git@vger.kernel.org>; Wed,  1 May 2024 01:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714527922; cv=none; b=fjnvEy2YbgMkwWrXjzH2C1Yxk3y/1SULTFpg+BjQA1mN4byJMNxhG9iuV0XE0EWabcvbrYSrara5xcJIgBIINPckBz1bzamTWKu6BU/N2PB39+dApK2+iUX1/7aZreruPB/rE2PWdM2/UzcFNVPN0F10Y3tx4q6SjWCto18e3PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714527922; c=relaxed/simple;
	bh=RwNfempLgtk0exXpjvZiOqTcmsg4TZJzVUrNYpfmHGM=;
	h=From:To:Subject:In-Reply-To:References:cc:Date:Message-ID:
	 MIME-Version:Content-Type; b=o68nVmi7mlWqAEW6iVwRinqLRuTarc33plN3D++gdjPnthAJmBTlKb9ppnT7YnWq5MdDlJs+bZZ8qmnbpLViPA2wKwm1ZNgYIk/xxqOuISM8FcV5Qnwbei8pEGmGiq/CXua8qwLwTn241sehZJbDM2An9oPCwNWqA3zya+W7gIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=W6LbTbcg; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="W6LbTbcg"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 133602F821;
	Tue, 30 Apr 2024 21:45:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:in-reply-to:references:cc:date:message-id:mime-version
	:content-type; s=sasl; bh=RwNfempLgtk0exXpjvZiOqTcmsg4TZJzVUrNYp
	fmHGM=; b=W6LbTbcgaASjNqP47XpYdH0O/DKrYJARdT+amLWFy+ON6lBznRv+BO
	EO6blBisNHWoA7VMrrUXeBKgXsOM2cDDct8qLfG9FnTWZPYGv3QDOLKVICJEiWGG
	zVr0trCjStKwE9WK1p5tY4bm034cpCouLFwKIPdjq5qnMiM5h9Q84=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 09EDA2F820;
	Tue, 30 Apr 2024 21:45:19 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 640072F81F;
	Tue, 30 Apr 2024 21:45:18 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: A note from the maintainer
In-Reply-To: <xmqqv840ulrg.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	29 Apr 2024 10:22:27 -0700")
References: <xmqqv840ulrg.fsf@gitster.g>
cc: Johannes Sixt <j6t@kdbg.org>
Date: Tue, 30 Apr 2024 18:45:17 -0700
Message-ID: <xmqqv83ywbiq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 76DB86E6-075C-11EF-B2F0-25B3960A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Although the following are included in git.git repository, they have their
> own authoritative repository and maintainers:
>
>  - git-gui/ comes from git-gui project, maintained by Pratyush Yadav:
>
>         https://github.com/prati0100/git-gui.git

This entry is a bit stale.  Johannes Sixt volunteered to take this
over recently.  We'll have an update soon.

Thanks.
