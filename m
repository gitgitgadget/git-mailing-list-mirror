Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="T2G56v6p"
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9182190
	for <git@vger.kernel.org>; Fri,  8 Dec 2023 15:11:18 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 03C321C98BD;
	Fri,  8 Dec 2023 18:11:18 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D1m63k0P5khrLhsRRDqfsQ/Tq5qi0jj70InqnM
	GcxbA=; b=T2G56v6pX8ot4J/Xu3k3oZYtAuemgJ80xtve7VP2I4fsQHxXogeVF5
	d3wHZZ60y1fsdxwsZRXYwNzWya2+5zmHY1IeWQ2dKsq09dCFxXj0LUHtb5254dMd
	lAXVD1jFG54x61kKElJR0HXKFiboyS7vH/vaRWA5ksJcXEUv907fY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EFA8A1C98BC;
	Fri,  8 Dec 2023 18:11:17 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.103.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5EF261C98BB;
	Fri,  8 Dec 2023 18:11:17 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/7] builtin/clone: fix bundle URIs with mismatching
 object formats
In-Reply-To: <c7a9d6ef74ff39e660f80e2e104a96b7c875845d.1701863960.git.ps@pks.im>
	(Patrick Steinhardt's message of "Wed, 6 Dec 2023 13:40:01 +0100")
References: <cover.1701863960.git.ps@pks.im>
	<c7a9d6ef74ff39e660f80e2e104a96b7c875845d.1701863960.git.ps@pks.im>
Date: Sat, 09 Dec 2023 08:11:16 +0900
Message-ID: <xmqqil58z3vv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 174BB858-961F-11EE-83C0-25B3960A682E-77302942!pb-smtp2.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> This is not a problem in the context of the files backend ...
> It will become a problem though once
> we land the reftable backend, which indeed does require to know about
> the proper object format at the time of creation.

OK.  That answers the question I had on the previous step.

Thanks.
