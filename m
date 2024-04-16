Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFB210A14
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 02:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713235338; cv=none; b=iaIxFhW8yQazlTJu0jXrMDp2gHvtnyR7LtfE/p4UnVTu+UQX/sjsxLxbQMiMkKySV41y+QYj1PTlcdV/NTgd4x0zOmxsQ1GwxdZRE1IA76747vTYjyr2OFqR3nJyRRnLSu9JGTvrrCWJ+k5VEameXpeU90ZViLCTeq+qbR8MdGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713235338; c=relaxed/simple;
	bh=8psnA9hgAuCrWGYvNEu03CTQQKz5025Diy0CjkIVZkw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZtuLtkvrpK2e8YFY+Ymj8B/zg/3WJTqJnYA/AM0ZQc5DmZ8GUStJXZli+zUzj0boicfbK0eGq7geFGonvYdSv6mxDsC7Fl3PZYQrUK0N+C50wFgAM4i/8hEssZrNezKppoWZEg2ml+5jWbmOYedFroHF+IgIhK6cSiHJAnoD2bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
From: Sam James <sam@gentoo.org>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 0/2] diff: copies-harder support
In-Reply-To: <875xwr27le.fsf@gentoo.org> (Sam James's message of "Mon, 08 Apr
	2024 16:32:29 +0100")
Organization: Gentoo
References: <20240311213928.1872437-1-sam@gentoo.org>
	<875xwr27le.fsf@gentoo.org>
User-Agent: mu4e 1.12.3; emacs 30.0.50
Date: Tue, 16 Apr 2024 03:42:13 +0100
Message-ID: <87sezm1116.fsf@gentoo.org>
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
>> range-diff:
>> ```
>> [...]
>> ```
>>
>> Sam James (2):
>>   diff: implement config.diff.renames=copies-harder
>>   diff: whitespace cleanup
>>
>
> It was pointed out that
> https://github.com/gitgitgadget/git/pull/1606#issuecomment-2002137907
> that I forgot to add the changes in v2/v3.
>
> v2: Documentation phrasing fixes.
> v3: Split out whitespace & formatting changes into their own commit and
> apply missed documentation phrasing tweaks.

ping

I'm not sure of the etiquette for git development, so if it's too short
to ping, my apologies.

>
>
>>  Documentation/config/diff.txt   |  8 +++++---
>>  Documentation/config/status.txt |  4 +++-
>>  diff.c                          | 14 +++++++++++---
>>  diff.h                          |  1 +
>>  diffcore-rename.c               |  6 ++++--
>>  merge-ort.c                     |  2 +-
>>  merge-recursive.c               |  2 +-
>>  7 files changed, 26 insertions(+), 11 deletions(-)
