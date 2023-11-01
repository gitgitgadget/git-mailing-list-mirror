Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988391CF80
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:49:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyOE4Lxi"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A056C2
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:49:24 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 8AF591CB9CC;
	Wed,  1 Nov 2023 19:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GrfjBRQYzzbe
	0wBjlmqsoKqTvDCgAbIyRCT9vq8mRCA=; b=EyOE4LxiOqfaDsebfgG8q1BxuY4R
	rQYF6w3g5uu8Nxg8M3xHZELv+p4qxltGQ029eGLPYBhkQ04QhSAEHUGuhkTbZnOf
	o+5y+dC28dz2WyQJlfwf9+RZlQH4pTjuKH95XknBtaEZj562o4H+UMSfOhu2CX+E
	pwluqY3e0Oi442Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 830901CB9CB;
	Wed,  1 Nov 2023 19:49:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E291C1CB9CA;
	Wed,  1 Nov 2023 19:49:22 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: Christian Couder <christian.couder@gmail.com>,  git@vger.kernel.org,
  phillip.wood123@gmail.com,  linusa@google.com,  calvinwan@google.com,
  rsbecker@nexbridge.com
Subject: Re: [PATCH v8 1/3] unit tests: Add a project plan document
In-Reply-To: <ZUKPJsW1mT62Mcjy@google.com> (Josh Steadmon's message of "Wed, 1
	Nov 2023 10:47:18 -0700")
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
	<cover.1696889529.git.steadmon@google.com>
	<81c5148a1267b8f9ce432a950340f0fa16b4d773.1696889530.git.steadmon@google.com>
	<CAP8UFD26X4MPbJs4KfNOgicLMb-wiuFZj3Hw17acMmmc_=vcqQ@mail.gmail.com>
	<ZUKPJsW1mT62Mcjy@google.com>
Date: Thu, 02 Nov 2023 08:49:21 +0900
Message-ID: <xmqqil6lowzi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 484D17C4-7911-11EE-A218-25B3960A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable

Josh Steadmon <steadmon@google.com> writes:

> On 2023.10.27 22:12, Christian Couder wrote:
>> On Tue, Oct 10, 2023 at 12:22=E2=80=AFAM Josh Steadmon <steadmon@googl=
e.com> wrote:
>> >
>> > In our current testing environment, we spend a significant amount of
>> > effort crafting end-to-end tests for error conditions that could eas=
ily
>> > be captured by unit tests (or we simply forgo some hard-to-setup and
>> > rare error conditions). Describe what we hope to accomplish by
>> > implementing unit tests, and explain some open questions and milesto=
nes.
>> > Discuss desired features for test frameworks/harnesses, and provide =
a
>> > preliminary comparison of several different frameworks.
>>=20
>> Nit: Not sure why the test framework comparison is "preliminary" as we
>> have actually selected a unit test framework and are adding it in the
>> next patch of the series. I understand that this was perhaps written
>> before the choice was made, but maybe we might want to update that
>> now.
>
> Fixed in v9, thanks.

Thanks for working well together.
