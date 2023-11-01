Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49C71102
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 03:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OdB5/J7a"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DB40C1
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 20:44:35 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1617529F8A;
	Tue, 31 Oct 2023 23:44:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=IgKd+LhoP4KAgubPIGQAaPW7asfF34KrgqcAj3
	0IH5M=; b=OdB5/J7aJXTH5NV8LGb4YDkLfGkEfNCFAxyh//i4tWU5p+X3t2Sj3N
	45BvS/vy+q1VuLaQW++s6Q04TjvIqDWSavMK0RDMgYxvZiS6+hKLxXdcUpDemDLl
	P9VT+pwuCbaLYNng7qapkBM15wwv+OLlZcu2VxIlsMTr+X+KAk9Bw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E4C329F89;
	Tue, 31 Oct 2023 23:44:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 9BE3B29F87;
	Tue, 31 Oct 2023 23:44:31 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
  git@vger.kernel.org,  Elijah
 Newren <newren@gmail.com>,  Phillip Wood <phillip.wood123@gmail.com>,
  Eric Sunshine <sunshine@sunshineco.com>,  Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 1/1] merge-file: add an option to process object IDs
In-Reply-To: <ZUGASkMgoAbe7RjR@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Tue, 31 Oct 2023 22:31:38 +0000")
References: <20231030162658.567523-2-sandals@crustytoothpaste.net>
	<20231031214859.25293-1-martin.agren@gmail.com>
	<ZUGASkMgoAbe7RjR@tapette.crustytoothpaste.net>
Date: Wed, 01 Nov 2023 12:44:30 +0900
Message-ID: <xmqqedhaw31d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F755323C-7868-11EE-BFF3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> This seems reasonable.  Junio, do you want to sneak this in and fix the
> commit message above, or do you want me to do a v3?

As it hasn't hit 'next' on my end, I'd prefer to see a version I can
blindly apply without having to care all the details of what was
discussed.  Thanks.

