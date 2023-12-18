Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8139642392
	for <git@vger.kernel.org>; Mon, 18 Dec 2023 16:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="c3IITvua"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0178B1E215;
	Mon, 18 Dec 2023 11:34:51 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=O3dpZ6T9sBl0
	t0xFa4CWIuRA7XwxpoYa6syjg6155Jw=; b=c3IITvuaVDE7kHjN9wvzm1tdv3MF
	8ISaUa05Fy5jtv5O3X1IOBI6Hf5LbjgCHwa4MAGzUdBHBYQ3sakE4ppPeiA07u8o
	dd3KlGS8K1ypbJIR+FKPfKbSlNxGFzOJurd9ZOq1lPolziGN9HohCIyS3B4cH9SH
	889x6JzO4Y0y6AQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EE0941E214;
	Mon, 18 Dec 2023 11:34:50 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2EF661E213;
	Mon, 18 Dec 2023 11:34:47 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>,
  git@vger.kernel.org,  five231003@gmail.com
Subject: Re: [PATCH v2] test-lib-functions.sh: fix test_grep fail message
 wording
In-Reply-To: <CAPig+cSJ=RcJtYKzT0Kj1-0nJT0YxA=KPYV=5H80_inJYS_Vnw@mail.gmail.com>
	(Eric Sunshine's message of "Sun, 17 Dec 2023 19:51:23 -0500")
References: <20231203171956.771-1-shreyanshpaliwalcmsmn@gmail.com>
	<20231217153140.1831-1-shreyanshpaliwalcmsmn@gmail.com>
	<CAPig+cSJ=RcJtYKzT0Kj1-0nJT0YxA=KPYV=5H80_inJYS_Vnw@mail.gmail.com>
Date: Mon, 18 Dec 2023 08:34:45 -0800
Message-ID: <xmqqjzpbh3kq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 5B5D6964-9DC3-11EE-BCCA-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Sun, Dec 17, 2023 at 10:32=E2=80=AFAM Shreyansh Paliwal
> <shreyanshpaliwalcmsmn@gmail.com> wrote:
>> ping.
>
> Junio was on vacation at the time[1] that this patch was submitted, so
> it's quite possible that it simply got overlooked or he hasn't gotten
> through the backlog of emails which accumulated while he was away.

It was dropped due to automated filter that noticed that the address
on its in-body From: line does not appear on any of its Signed-off-by:
line ;-)

I'll see if that is the only glitch in the patch (in which case I'll
manually adjust the authorship and apply) or respond on list
(otherwise).

Thanks for pinging and ponging.

> So,
> pinging is indeed the correct thing to do, and the patch is obviously
> an improvement, so hopefully it will be picked up soon.
>
> [1]: https://lore.kernel.org/git/xmqq34wj4e55.fsf@gitster.g/
