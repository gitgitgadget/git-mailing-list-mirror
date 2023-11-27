Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KOBVN+nN"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE8C1
	for <git@vger.kernel.org>; Mon, 27 Nov 2023 05:12:27 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B1DD1BCEF3;
	Mon, 27 Nov 2023 08:12:27 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8oqr9ZNDE9vm
	pSDBG3a8uWEiBUeZf6iNEEosJtaFUeU=; b=KOBVN+nN+dxYmkCXHMEC2hUhw0rV
	Pqqld9RUsWukIeg+34EOksKzZ/WBjJCAnpclXTJlAY/5gnUFKMvDU+TeJC6emc35
	aPdsYEmoCxsOA2en1NrjWfJe+7Vx3DOiN4rJzrifpmryxMPNyc/7aenIjP/p//5C
	w7CmAzrZsSXQc7s=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 021AC1BCEF1;
	Mon, 27 Nov 2023 08:12:27 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EAC41BCEF0;
	Mon, 27 Nov 2023 08:12:26 -0500 (EST)
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
Date: Mon, 27 Nov 2023 22:12:25 +0900
Message-ID: <xmqqo7ff1gsm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 9C34AAE0-8D26-11EE-9961-25B3960A682E-77302942!pb-smtp2.pobox.com
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
