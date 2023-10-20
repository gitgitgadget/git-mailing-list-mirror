Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146F20F5
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 16:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="CMOjVZcH"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32162D65
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 09:44:34 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CA61131878;
	Fri, 20 Oct 2023 12:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=H/VkQK1Sfegr
	akEmzr19ynBAcyXh3+aum+XKKq5TTwQ=; b=CMOjVZcHAG3UPlSTS3sRnFUMr+RP
	D9bLeowx75Cvt+ODLjnJyEGn9fyStWSqv7L7Nsg114PqLbE/0PGtiE88dYE7zyel
	NjA0QowETXNULl4rLOce/T8ShuOUsLkyeOvAQYJ7UcS7o97+oIcAXM95CG/+7x3q
	XFK7RJ+zbrm1iR8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C2E2C31877;
	Fri, 20 Oct 2023 12:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5E4E331876;
	Fri, 20 Oct 2023 12:44:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
In-Reply-To: <42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
 (=?utf-8?B?IueOi+W4uOaWsCIncw==?=
	message of "Fri, 20 Oct 2023 10:14:51 +0800")
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
	<xmqq5y32zgnk.fsf@gitster.g>
	<42D0A6FD-1314-4977-92E6-BF6535D82E8A@gmail.com>
Date: Fri, 20 Oct 2023 09:44:28 -0700
Message-ID: <xmqqv8b1s0pf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 F09A2F7E-6F67-11EE-BF2E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

=E7=8E=8B=E5=B8=B8=E6=96=B0 <wchangxin824@gmail.com> writes:

> It is my official name. But the email address is not a valid one. Shoul=
d I rewrite the commit message?

We try to keep the name and address on Signed-off-by: the official
one that we can give court if/when some copyright troll sues us (see
Documentation/SubmittingPatches:sign-off), and one of them (if more
than one developers signed off the patch) must match the primary
author's name and address.

Thanks.
