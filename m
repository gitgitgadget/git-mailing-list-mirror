Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Yxx0t8n4"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741AAC1
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:12:00 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id A4A3D1D65C;
	Mon, 27 Nov 2023 08:11:59 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8oqr9ZNDE9vm
	pSDBG3a8uWEiBUeZf6iNEEosJtaFUeU=; b=Yxx0t8n4CEflKcwjDCqBSn6h/JvG
	lRSQMzTU8D3klFpNcEfRLn3SDZ/NgquYBNvXh9E8q8IkbejIGVIwd+tiAOABIuX0
	9618Z+E1KnLJEsMiVtkZwKS7BDA2H75y9WYC1TJkjHEAzVOyLOJHrl4ERWojccYa
	w8dKcSiirpIpZXc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D7451D65B;
	Mon, 27 Nov 2023 08:11:59 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5C66F1D659;
	Mon, 27 Nov 2023 08:11:54 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] i18n: factorize even more 'incompatible options' messages
In-Reply-To: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 26 Nov 2023 12:57:43 +0100")
References: <e6eb12e4-bb63-473c-9c2f-965a4d5981ad@web.de>
X-Gnus-Delayed: Mon, 27 Nov 2023 22:03:02 +0900
Date: Mon, 27 Nov 2023 22:11:52 +0900
Message-ID: <xmqqttp71gtj.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 89204518-8D26-11EE-B37C-A19503B9AAD1-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Continue the work of 12909b6b8a (i18n: turn "options are incompatible"
> into "cannot be used together", 2022-01-05) and a699367bb8 (i18n:
> factorize more 'incompatible options' messages, 2022-01-31) to use the
> same parameterized error message for reporting incompatible command lin=
e
> options.  This reduces the number of strings to translate and makes the
> UI slightly more consistent.

Will queue.  Thanks.
