Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OQnDolDR"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE37E10E6
	for <git@vger.kernel.org>; Thu, 23 Nov 2023 16:28:25 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 961961B47E6;
	Thu, 23 Nov 2023 19:28:24 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=HXDYsxg3fmeS
	7FxNA+/+tAEPBDKHUlxC1mJdrrVszkI=; b=OQnDolDRUgclFopXQxJBi8IqQU/K
	8xhQUfUqqbMvxJxthpr4rkFeCU8y2PUDtVkIWHUbRHfhP4+z4Usa4Ewt2s9wRVGc
	y3xmpbKii3h1mp21BNEsOqEQf3DnJGzcXJMmUZFggrHfd8NWDq++7xLJqxlm1JvY
	Hi4CVpcm29lic8M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8D5221B47E4;
	Thu, 23 Nov 2023 19:28:24 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id F12601B47E3;
	Thu, 23 Nov 2023 19:28:23 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Elijah Newren <newren@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Christian Couder
 <christian.couder@gmail.com>,  git@vger.kernel.org,  Patrick Steinhardt
 <ps@pks.im>,  John Cai <johncai86@gmail.com>,  Derrick Stolee
 <stolee@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,  Calvin Wan
 <calvinwan@google.com>,  Toon Claes <toon@iotcl.com>,  Dragan Simic
 <dsimic@manjaro.org>,  Linus Arver <linusa@google.com>
Subject: Re: [PATCH v7 00/14] Introduce new `git replay` command
In-Reply-To: <CABPp-BFgJFeL4cUJ8+JZ2ZuM58F3rSYGYu_5w_mDLYWtzO4raw@mail.gmail.com>
	(Elijah Newren's message of "Thu, 23 Nov 2023 11:32:37 -0800")
References: <20231102135151.843758-1-christian.couder@gmail.com>
	<20231115143327.2441397-1-christian.couder@gmail.com>
	<fb6eb685-0af1-082a-b20c-028b06b6914e@gmx.de>
	<CABPp-BFgJFeL4cUJ8+JZ2ZuM58F3rSYGYu_5w_mDLYWtzO4raw@mail.gmail.com>
Date: Fri, 24 Nov 2023 09:28:22 +0900
Message-ID: <xmqqwmu89eqh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 60C4DE26-8A60-11EE-AD4F-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Elijah Newren <newren@gmail.com> writes:

> Hi Christian,
>
> On Thu, Nov 16, 2023 at 12:53=E2=80=AFAM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
>> On Wed, 15 Nov 2023, Christian Couder wrote:
>>
>> > # Range-diff between v6 and v7
>> >
> [...]
>> Apart from the one little outstanding nit where I would love to see
>> `(EXPERIMENTAL!)` as the first word of the synopsis both in the manual
>> page and in the output of `git replay -h`, you have addressed all of m=
y
>> concerns.
>>
>> Thank you!
>> Johannes
>
> Looks good to me too.  Thanks!

Thanks, both, for reviews.  I guess the only remaining issue now is
the "(EXPERIMENTAL)" label and we are ready to declare a victory?

Thanks.
