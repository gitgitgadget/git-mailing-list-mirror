Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5BBE2FE2B
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="fJ/q6Jy0"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6A64183
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:05:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 38C7F28DDB;
	Thu, 19 Oct 2023 13:05:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5NsNqP0xWY04
	ZTCkbipgQIkkMIKMmAvpxWpgA6uvq5Y=; b=fJ/q6Jy0jQomwqT2oZbgb0TCrEtO
	SygONAzYZYB2XX+92HIjLUh2v5t3pMxsQj5V7MRk1GbBQJhF4Ez7fx2PZYkGYonp
	WAz9DPupSij8Dgan7xP5ddAQeiq1blzuSMJHP983iAmApdiLAaFLG8gqqyXgS2Ve
	7KxzSbY00x4/Ea0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 3193F28DDA;
	Thu, 19 Oct 2023 13:05:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id B504828DD9;
	Thu, 19 Oct 2023 13:05:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?546L5bi45paw?= <wchangxin824@gmail.com>
Cc: git@vger.kernel.org,  Wangchangxin <1571825323@qq.com>
Subject: Re: [PATCH] typo: fix the typo 'neeed' into 'needed' in the comment
 under merge-ort.c
In-Reply-To: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
 (=?utf-8?B?IueOi+W4uOaWsCIncw==?=
	message of "Thu, 19 Oct 2023 20:24:24 +0800")
References: <2DB9ED79-FE58-4072-91E0-B4C51A3F6C5B@gmail.com>
Date: Thu, 19 Oct 2023 10:05:51 -0700
Message-ID: <xmqq5y32zgnk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 C28839D0-6EA1-11EE-B896-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

=E7=8E=8B=E5=B8=B8=E6=96=B0 <wchangxin824@gmail.com> writes:

> From: foril <1571825323@qq.com>
>
> Signed-off-by: =E7=8E=8B=E5=B8=B8=E6=96=B0 (Wang Changxin) <foril@foril=
.space>
> ---

Thanks. =20

We want to make sure that the "Name <e-mail-address>" on the From:
and Signed-off-by: lines match.  Is your official name/address the
one on the Singed-off-by: line?
