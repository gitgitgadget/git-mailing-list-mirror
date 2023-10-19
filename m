Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A40936B17
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QajS5Z9V"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68D1112
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 10:55:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 099F71BA683;
	Thu, 19 Oct 2023 13:55:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ikZ2gbP6xYFSlGjjdhCx8h4IY9keob6P2MIzvV
	k0VLY=; b=QajS5Z9VorMf+/HfvOcRn7H4tC8CRVyv6onAXMlqPdzioDlLF9ICby
	mizfHMWOPXmbfLGW2lrjlkcFI3EyA1JnqKVDQNRDdUgYksW5JsRTd9KR6v/fb76I
	FoCsgv3bOqM1wgULv6XRKl+kGcCAHjvZauy1jL2HSDznVPeAzGRjA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F2E481BA681;
	Thu, 19 Oct 2023 13:55:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 54FAE1BA680;
	Thu, 19 Oct 2023 13:55:55 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  "Eric W.
 Biederman" <ebiederm@gmail.com>,  Jeff King <peff@peff.net>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 05/10] bulk-checkin: extract abstract
 `bulk_checkin_source`
In-Reply-To: <ZTFI++b51Cj+Sto9@nand.local> (Taylor Blau's message of "Thu, 19
	Oct 2023 11:19:23 -0400")
References: <cover.1696629697.git.me@ttaylorr.com>
	<cover.1697648864.git.me@ttaylorr.com>
	<da52ec838025a59a3f4f4ffaf2e6f9098a37547e.1697648864.git.me@ttaylorr.com>
	<xmqqa5sfplvw.fsf@gitster.g> <ZTFI++b51Cj+Sto9@nand.local>
Date: Thu, 19 Oct 2023 10:55:54 -0700
Message-ID: <xmqq4jimxzrp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C03A6C32-6EA8-11EE-B848-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> I want to be cautious of going too far in this direction.

That's fine.  Thanks.
