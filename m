Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA441FA5
	for <git@vger.kernel.org>; Mon, 23 Sep 2024 18:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727117726; cv=none; b=mtGR0pIG1Zm+/D7aAUHBEejhWe/cSf5TdOKlEQQ4sjO7QT+cuDbMqgrasI71MEMS/iRMWuh7ZvMnieRJxakW0bMYnzxatNOdjLpyDVxSK7Xwm/tfx6nsK/a7sUm8uXNwf5lWkLcx2ynGScCoccnCTelTiprbdbEPp9X6QNXizT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727117726; c=relaxed/simple;
	bh=cdMcKTFqDi5FlPy9AMcsY+ZHgrBEkQbaDxHcSpVBv74=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qoIlgBM2ziwnmewjsCbWQy1jQzyveC6+uRrtOITEHWbUg4BM8lGJY1rzSn7NcB0ShCco9HRupT76yBZhSRqueUl9kIUdXlbEu5kdl9vmtJ4Pd1T14P/TVSwdWB0XyoAIm1l6j/R1K1JeNvmLd2jd8Pqx1XNtnIL0yTda6i+SjcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=izfOKjfg; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="izfOKjfg"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 53D1F2415F;
	Mon, 23 Sep 2024 14:55:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=cdMcKTFqDi5FlPy9AMcsY+ZHgrBEkQbaDxHcSp
	VBv74=; b=izfOKjfgS5zq2Ypbfy1v7wtyrTT5o7z2bXf9O/BXFHiVQB575yIh4r
	R6el7M7tnB0tyy4N5GHAKZYmJSPW4arVqZAHF+cqflC/lD2j+q075GXP4wcrkthB
	1EsqHuMcKpZzthz6YGsosnpEiQbIcwheab0E3AgfAAYWxrlrrZ2zw=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4B2652415E;
	Mon, 23 Sep 2024 14:55:17 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 953172415D;
	Mon, 23 Sep 2024 14:55:16 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Andrew Kreimer <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 1/3] Documentation/technical: fix a typo
In-Reply-To: <CAPig+cSis+QYgkPM2pFrEpEWOyny3XpMJpgYbGbJu2ZL5SBmow@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 23 Sep 2024 13:32:03 -0400")
References: <20240920082815.8192-1-algonell@gmail.com>
	<xmqqbk0if5jv.fsf@gitster.g>
	<CAPig+cSis+QYgkPM2pFrEpEWOyny3XpMJpgYbGbJu2ZL5SBmow@mail.gmail.com>
Date: Mon, 23 Sep 2024 11:55:15 -0700
Message-ID: <xmqq34lq2oa4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5F5C4DFE-79DD-11EF-BA89-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Eric Sunshine <sunshine@sunshineco.com> writes:

> The word "publicly" is, of course, so frequently misspelled that it is
> not surprising that "publically" has been accepted into some
> dictionaries as a legitimate spelling, but, as one who grew up
> understanding the correct spelling to be "publicly", the variant
> spelling still makes my reading hiccup big time, so I found no problem
> with this patch.

Yup, living languages annoy old-timers more than new folks with
phrases and usages that used to be ungrammatical gaining legitimacy
with wider use.  I see this all the time in the language I am native
in, too.

Thanks for an input.  Let's queue this patch, then.

