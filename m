Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8278D28FF
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721534; cv=none; b=UcWDz+lBgiRgvlcIxJvrPY6eMwzrNfdNcu4FAjk575ejNFuBs3iEL120cv/bw3UAb+elP4TgIYkn7JN3TrC6NL8riXwWGlK5PMF9LQVFquMbtoa3loCLa4SJDukJmR6LbkGDfGFAU8mi+5iffZogbzHP9ko9dYUkes1Yie2cKY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721534; c=relaxed/simple;
	bh=whKzJ8EjfQT4EaF61uOP8tOhdPesD147cdbmR6LzaQ8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hFwqwTXyXRzdj1RqhuIK5Bz+mf4fN8ZnHzMrNqs6pMaeuu7pWj1MyaS9D/NEwqfeXh4lHX9HMmKN+pyTe5AjvkNiGszm2WJjaT+t+ceA+tEQKhK+PF7atPZ4l5FjmClkjUOXhe4d1BJiAfbvL9MK20wT/XEJSqBzo+aVBeajsK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=neH1bxuf; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="neH1bxuf"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6E830268C0;
	Thu, 11 Jul 2024 14:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=whKzJ8EjfQT4EaF61uOP8tOhdPesD147cdbmR6
	LzaQ8=; b=neH1bxufYu++1pmHpYH3IovZoJb/pGKP++TFaxno+MPNBFpMDSdaWs
	NtbQSP/YsS4Az8oY1gosKigM/HNR611D/7lFQPnUBeCPtS81T5gkyGD3b4FrMQDy
	H4iDYDxO9owRlB7egia2JOtqUot9lfezv5g0Ip4lovOVLcTMk/vDY=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 66F05268BF;
	Thu, 11 Jul 2024 14:12:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7E501268BC;
	Thu, 11 Jul 2024 14:12:01 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: chriscool@tuxfamily.org,  git@vger.kernel.org,  jltobler@gmail.com
Subject: Re: [PATCH v2 0/8] clang-format: add more rules and enable on CI
In-Reply-To: <20240711083043.1732288-1-karthik.188@gmail.com> (Karthik Nayak's
	message of "Thu, 11 Jul 2024 10:30:35 +0200")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240711083043.1732288-1-karthik.188@gmail.com>
Date: Thu, 11 Jul 2024 11:11:59 -0700
Message-ID: <xmqq8qy7ssr4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 11FC9BA6-3FB1-11EF-87AB-C38742FD603B-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> This is v2 of my series to add clang-format to the CI.

Aside from a few comments, the series looked good.

Will queue.  Thanks.
