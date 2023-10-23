Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EECC22EE7
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 20:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WLOm3N/D"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE894D73
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 13:20:02 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D1553FF74;
	Mon, 23 Oct 2023 16:20:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=5Bm/G+yjm3sW
	zEXVnIyIPz9djiuH6s8DjVQL/YekEc8=; b=WLOm3N/DuywoydQ52waBFibtjJBU
	nZ3Ej/QuM32e/jBZeiVHgJs6ojeTg0qnYk5RYQ+p/yspF5EBYOjvDH+XJ4CSc6NY
	OrO/LuSNrCRJknyeUcl75nqIZIX0/JogPskMclnHOqS911BSoxkViirYc23pGiSO
	hwtTlXpPWJBzhCY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 564BB3FF73;
	Mon, 23 Oct 2023 16:20:02 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id C94003FF70;
	Mon, 23 Oct 2023 16:19:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Isoken June Ibizugbe <isokenjune@gmail.com>,  git@vger.kernel.org,
  Dragan Simic <dsimic@manjaro.org>
Subject: Re: [PATCH v3] builtin/branch.c: adjust error messages to coding
 guidelines
In-Reply-To: <14df596a-d0ef-46aa-97c6-3c9f0da1975f@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Mon, 23 Oct 2023 22:17:33 +0200")
References: <39fd1327b2ae4f73689d70561a2f738d@manjaro.org>
	<20231023160656.4341-1-isokenjune@gmail.com>
	<14df596a-d0ef-46aa-97c6-3c9f0da1975f@gmail.com>
Date: Mon, 23 Oct 2023 13:19:57 -0700
Message-ID: <xmqqmsw9m6qa.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 89CA9668-71E1-11EE-BBA3-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> The rest of the patch is equal to the previous iteration (v2), which
> already seemed correct to me.
>
> Thank you.

Thanks, all.  Let's declare a victory and mark the topic to be
merged to 'next'.

