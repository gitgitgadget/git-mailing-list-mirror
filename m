Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D828078C8B
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 19:15:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723749355; cv=none; b=uL87dor0cPYo/LgerwJAzQlknLjWE3uWAK6ozi24MV8GHk+KaOHkeS222gmcFQVZd5EHNOy2XsAi4nT52S8ELU3lYNQed7ra5KNxvy8OhbXxYcZQRpadKLzDvNO0VPR9b5AAvVYANGbIa9YvYTWBIcUG5bdb8+LpLdT3l9Ppqh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723749355; c=relaxed/simple;
	bh=5rlDspH54xNkXIHkmAIYGhZb7/nm94Vx4N3lYrn4TXw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CSDKjzuqBkvNgD6rS9clymRv+vPr6b/3gBaKWCsSubwW5os6dp0TLOMOH6Q2YqC8ntbNea3xWosUaauhIqOgAl6AHp95VVLbhGBx8e9ZsxolIYLi0Wasew7rsUHN4/003UOMaDp51+VlkiXBuVbyJVSSPXUP9WrTi8j+g/3xwyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mdd1ekdu; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mdd1ekdu"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AAD832493D;
	Thu, 15 Aug 2024 15:15:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5rlDspH54xNk
	XIHkmAIYGhZb7/nm94Vx4N3lYrn4TXw=; b=mdd1ekdu8u0xc5wE+q+USCTOzCRI
	i5m7K/LoFFCJgZxFmoHAD1aRT914hxQC+JGgR7VS38PNktbNiJg3UQQfVInsCljs
	FFu7RFIqjtLRP2ogDtvOLvQvuxqPkEAyC6kQ7V/ic3+X50b/jWjTUqKTSZf53I+d
	zowJJyHD4adcwvM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A152C2493C;
	Thu, 15 Aug 2024 15:15:52 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0BAF22493A;
	Thu, 15 Aug 2024 15:15:51 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: avih <avihpit@yahoo.com>
Cc: "Avi Halachmi (:avih) via GitGitGadget" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>,  "brian m. carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 5/8] git-prompt: add some missing quotes
In-Reply-To: <1228065843.3779090.1723743313433@mail.yahoo.com> (avih's message
	of "Thu, 15 Aug 2024 17:35:13 +0000 (UTC)")
References: <pull.1750.git.git.1721762306.gitgitgadget@gmail.com>
	<pull.1750.v2.git.git.1723727653.gitgitgadget@gmail.com>
	<4f77b7eb7f1110e47201b8c97c34a0cbcd14e24f.1723727653.git.gitgitgadget@gmail.com>
	<xmqqmsldu4iu.fsf@gitster.g>
	<1228065843.3779090.1723743313433@mail.yahoo.com>
Date: Thu, 15 Aug 2024 12:15:50 -0700
Message-ID: <xmqqv801sil5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C99FA434-5B3A-11EF-9E2B-9B0F950A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

avih <avihpit@yahoo.com> writes:

>> Well no matter what value $? has, it by definition has a few digits
>> without any $IFS funnies.=C2=A0 Does this really matter?=C2=A0 I'd ima=
gine
>> that we would prefer to treat "$?" exactly the same way as "no".
> ...
> Two things here:
>
> 1. It can matter, because we don't control IFS. __git_ps1 is
> =C2=A0=C2=A0 a function which runs in the user's shell, so if the user =
did
> =C2=A0=C2=A0 IFS=3D0123, then unquoted $? or $exit can get IFS-split.

Fair enough.  My "we would prefer to treat $? exactly the same way
as no" still stands.  If the user did IFS=3Do, "no" would be broken.

> =C2=A0=C2=A0 As the commit message notes, this is unlikely to fix thing=
s in
> =C2=A0=C2=A0 practice, but it will fix things with weird IFS values.

Yes, so I'd prefer to see us being consistent.  If we quote "$?" to
protect ourselves from crazy folks who set insane values to $IFS, we
should quote "no" the same way, no?

