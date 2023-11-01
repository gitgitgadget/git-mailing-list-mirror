Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F1F1CF80
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 23:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ktomfuMW"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A48AF10E
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 16:55:12 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id DC64227FAB;
	Wed,  1 Nov 2023 19:55:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RKDXz3yu4qW7l9Bo0wLgPZmJZfivPIj3JDf+PV
	XwWaI=; b=ktomfuMWnKpy/HIHNYaYlKmr5p1WG0ppIFXhOnQrlx7u3eHbddHMu8
	v0/K9Vy/FeDKUmMYBlqUwGF+ajCRGH3Lel47qVqyh0ejVUi8htM8j5J2RyTS0kP3
	KQkeGzlyDZ4TnvrhscNq/EDSzPHIHhM6wn8oCQVX6TVQbvhdmq+uE=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id D331027FAA;
	Wed,  1 Nov 2023 19:55:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 5DA7627FA9;
	Wed,  1 Nov 2023 19:55:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Elijah Newren <newren@gmail.com>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Taylor Blau <me@ttaylorr.com>,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>
Subject: Re: [PATCH v3 0/2] Object ID support for git merge-file
In-Reply-To: <20231101192419.794162-1-sandals@crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 1 Nov 2023 19:24:17 +0000")
References: <20231024195655.2413191-1-sandals@crustytoothpaste.net>
	<20231101192419.794162-1-sandals@crustytoothpaste.net>
Date: Thu, 02 Nov 2023 08:55:06 +0900
Message-ID: <xmqq4ji5owpx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 1634C59C-7912-11EE-B88D-A19503B9AAD1-77302942!pb-smtp21.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This series introduces an --object-id option to git merge-file such
> that, instead of reading and writing from files on the system, it reads
> from and writes to the object store using blobs.
>
> Changes from v2:
> * Include a patch from Martin to pre-improve the documentation
> * Remove incorrect portion of commit message

Looking good.  Will replace.  Shall we mark the topic ready for
'next'?

Thanks.

