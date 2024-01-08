Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE372904
	for <git@vger.kernel.org>; Mon,  8 Jan 2024 22:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="D9jfUfD1"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 934351E4ED5;
	Mon,  8 Jan 2024 17:32:22 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=b7nF+/JYPCkO
	7xtbQyo7KbzQu/Waj734IGpBqb7wAD0=; b=D9jfUfD1zAw6fCiO1wemA+tcmBeZ
	Bo/3/D1Ztdv4qhaw/W5bm6lt6up8vzZH+3fQIIWD1QoZ5LhZ60tacdI/uLNjzbpC
	OJ6Dp4EegLUmkvwEyN/LxKG4TaBErFB9h0CyVmLVrld9fM5ckWVzG7+W4lGmrjcK
	q7dhVAUyb7pEhAM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8905B1E4ED4;
	Mon,  8 Jan 2024 17:32:22 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EA32D1E4ED3;
	Mon,  8 Jan 2024 17:32:21 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Achu Luma <ach.lumap@gmail.com>,  git@vger.kernel.org,
  chriscool@tuxfamily.org,  christian.couder@gmail.com,
  phillip.wood@dunelm.org.uk,  steadmon@google.com,  me@ttaylorr.com,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [Outreachy][PATCH v4] Port helper/test-ctype.c to
 unit-tests/t-ctype.c
In-Reply-To: <a087f57c-ce72-45c7-8182-f38d0aca9030@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sun, 7 Jan 2024 13:45:59 +0100")
References: <20240101104017.9452-2-ach.lumap@gmail.com>
	<20240105161413.10422-1-ach.lumap@gmail.com>
	<a087f57c-ce72-45c7-8182-f38d0aca9030@web.de>
Date: Mon, 08 Jan 2024 14:32:20 -0800
Message-ID: <xmqqcyubjw23.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 CA147B78-AE75-11EE-86C9-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Quite an improvement over v3!  Now you only need to repeat the class
> names once.
>
> Can we do any better?

;-)
