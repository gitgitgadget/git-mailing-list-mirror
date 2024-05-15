Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3A315B96C
	for <git@vger.kernel.org>; Wed, 15 May 2024 22:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715812028; cv=none; b=u9HCaHm6FY+lUp1e8Ay8Ia2SjgbCcWUOqT316ScCJutI+wJ0KvJv7nfwU3q8d8EtWgu9gR1h1o+82gFgwKI9rKL4JI48l4NIXn/JczfGEvgJqhEuYLyFTe34VnDRx8U9lrcAyJsz+MxzQVC1AXjJiwBCRfrwcnxEv/AWUMc4Cr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715812028; c=relaxed/simple;
	bh=YfG1bK4aDctweTpLFqiU2g9jFwdsD/Cy19gXHv1SJvc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U6kzpAOVS7BNW2blc7hJ0+22EMQeb2keYLosLS7vvAKrQfPs0VoSqIdJ/aayiPVC+8NqBsYRFYHx5CC4VNb6seHpczUrCXj5Hcnwks4GWdmg1yw5wwYiVLCpKXSPGZtW3jsl9pklerD9lJPHz3q2zBsVvsvLyu8cV6+EgUjX2Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] diff: copies-harder support
In-Reply-To: <87sezm1116.fsf@gentoo.org> (Sam James's message of "Tue, 16 Apr
	2024 03:42:13 +0100")
Organization: Gentoo
References: <20240311213928.1872437-1-sam@gentoo.org>
	<875xwr27le.fsf@gentoo.org> <87sezm1116.fsf@gentoo.org>
Date: Wed, 15 May 2024 23:27:02 +0100
Message-ID: <8734qihft5.fsf@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Sam James <sam@gentoo.org> writes:

> Sam James <sam@gentoo.org> writes:
>
>> Sam James <sam@gentoo.org> writes:
>>
>>> range-diff:
>>> ```
>>> [...]
>>> ```
>>>
>>> Sam James (2):
>>>   diff: implement config.diff.renames=copies-harder
>>>   diff: whitespace cleanup
>>>
>>
>> It was pointed out that
>> https://github.com/gitgitgadget/git/pull/1606#issuecomment-2002137907
>> that I forgot to add the changes in v2/v3.
>>
>> v2: Documentation phrasing fixes.
>> v3: Split out whitespace & formatting changes into their own commit and
>> apply missed documentation phrasing tweaks.
>
> ping
>
> I'm not sure of the etiquette for git development, so if it's too short
> to ping, my apologies.
>

ping - let me know if I need to do anything different. Thanks!

>>
>>
>>>  Documentation/config/diff.txt   |  8 +++++---
>>>  Documentation/config/status.txt |  4 +++-
>>>  diff.c                          | 14 +++++++++++---
>>>  diff.h                          |  1 +
>>>  diffcore-rename.c               |  6 ++++--
>>>  merge-ort.c                     |  2 +-
>>>  merge-recursive.c               |  2 +-
>>>  7 files changed, 26 insertions(+), 11 deletions(-)
