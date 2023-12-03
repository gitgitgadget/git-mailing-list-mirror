Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="uA9F6lpX"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12C9AFD
	for <git@vger.kernel.org>; Sun,  3 Dec 2023 05:15:22 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E9761B5965;
	Sun,  3 Dec 2023 08:15:21 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ue8wtc1fUOUkMQhIIxnEbEks6gt3eVK4RwTMBh
	CbCtQ=; b=uA9F6lpX7kJ2mSBKw0G1tZ80PjHWdHQabd0hbKoXza2W6uRP2Z8uay
	g3p2V++FiSeHLyKUqP3fP/JsDGOGovRS5gLBJo+IvUWFuTMfdwlWjBVKeK6Mg6W3
	Ii3ibj6Iuh5A9FSg5xNOeS8iwtQxu6rlpXLrSkTczg/XGAUTQK8Gk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75D971B5964;
	Sun,  3 Dec 2023 08:15:21 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF9671B5963;
	Sun,  3 Dec 2023 08:15:20 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Marcel Krause <mk+copyleft@pimpmybyte.de>
Cc: git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] doc: make the gitfile syntax easier to discover
In-Reply-To: <20231128065558.1061206-1-mk+copyleft@pimpmybyte.de> (Marcel
	Krause's message of "Tue, 28 Nov 2023 07:55:58 +0100")
References: <182d290a-86e5-b361-87a1-6860641fc726@pimpmybyte.de>
	<20231128065558.1061206-1-mk+copyleft@pimpmybyte.de>
Date: Sun, 03 Dec 2023 22:15:19 +0900
Message-ID: <xmqq8r6b4ec8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 02B5AEF2-91DE-11EE-9668-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Marcel Krause <mk+copyleft@pimpmybyte.de> writes:

> Signed-off-by: Marcel Krause <mk+copyleft@pimpmybyte.de>
> ---
>  Documentation/gitrepository-layout.txt | 4 +++-
>  Documentation/glossary-content.txt     | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)

Looking good.  Will queue.  Thanks.
