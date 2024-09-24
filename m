Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903C335C7
	for <git@vger.kernel.org>; Tue, 24 Sep 2024 20:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727209421; cv=none; b=IUYgmc/x4ItHhakH/iCkTiPbEl7g+r3lGDc+m3w8dKW7swbBfGMZHdg0UtTV0xxUDlYi8nGyEhJ36iCsZxCHdHqR33ITtajVkih9pg8ofmOytWhCZWTj2DLz8Y2IAsn+BzG1DoQLLhhwrs0oo+aWbHSiyBOCxUzPN/nWqD2yzT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727209421; c=relaxed/simple;
	bh=pTXTegp/pTFxxvkpyK16ensC7HKgVKmkCaw3p0IXIRk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=siegErecfdyhrOy9FGGXu7IORFYRUtSrwP1DqmBDVNT5AdDuRWbwo68nfMB1KuIuRRZISri1UKr1NdyQo9M8qIw+x40LDaWeC4KHtwx+CIWqLjl+1hURQNRqsD0ynAPDBDGOoFkLcoG5wJlvAnJG3K+p9vErHtXWVRI5uOOlrs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ALq+lA6k; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ALq+lA6k"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 404611D198;
	Tue, 24 Sep 2024 16:23:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=pTXTegp/pTFx
	xvkpyK16ensC7HKgVKmkCaw3p0IXIRk=; b=ALq+lA6k8bEiYgWVmzRyqF/Zrgb4
	/e3YfBP05llGdnfrLw15wVtQgU/Qzbk9MUZcnJpjj8GibpTcMkyt6UNvIt57nidS
	RwGCUh/F7VaI122Njjc8UAgculq3w4baFSSXIrbB7Y6py35P9ftwzw2D/MB8C/V2
	18N534kSUZL39Ck=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 38FE11D197;
	Tue, 24 Sep 2024 16:23:38 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9AAD81D196;
	Tue, 24 Sep 2024 16:23:37 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Andrew Kreimer <algonell@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] builtin: fix typos
In-Reply-To: <CAPig+cSSE98QKjSmdQ=HPLiw7Z=BgS6S+EakHyGOAiKFacjB5A@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 24 Sep 2024 12:35:24 -0400")
References: <20240924130906.21392-1-algonell@gmail.com>
	<CAPig+cSSE98QKjSmdQ=HPLiw7Z=BgS6S+EakHyGOAiKFacjB5A@mail.gmail.com>
Date: Tue, 24 Sep 2024 13:23:36 -0700
Message-ID: <xmqqfrpossvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 E16CAA16-7AB2-11EF-9528-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Sep 24, 2024 at 9:09=E2=80=AFAM Andrew Kreimer <algonell@gmail.=
com> wrote:
>> Fix typos in comments.
>>
>> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
>> ---
>>  builtin/help.c         | 2 +-
>>  builtin/ls-files.c     | 2 +-
>>  builtin/name-rev.c     | 2 +-
>>  builtin/receive-pack.c | 2 +-
>>  4 files changed, 4 insertions(+), 4 deletions(-)
>
> All look fine. Thanks.

Thanks, both.
