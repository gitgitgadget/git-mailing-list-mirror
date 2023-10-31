Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D972F4D
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 06:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Y83q453q"
Received: from pb-smtp21.pobox.com (unknown [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6492AFC
	for <git@vger.kernel.org>; Mon, 30 Oct 2023 23:05:51 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5A64318095;
	Tue, 31 Oct 2023 01:58:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=arsQPtiZe8Td+/8eWeJL/3lIFF3/A4vFCmmzRD
	KiEMc=; b=Y83q453qByJ0/JlLyFIhb3MVs/Wr8E11nkv5/v8ZgPFCnf8cIf7kAk
	rwuUIJG65irwnENYcukwtMwpudGsm3sO88D70GHX7WfNSF1Hq+N6QkoAuVaUCg2E
	AdzMEawgkHBIaheEScxPQwD4F6gCqVeFTsNAjbjNH1KhfQBaNzO4k=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 44A8418094;
	Tue, 31 Oct 2023 01:58:14 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 551F318093;
	Tue, 31 Oct 2023 01:58:11 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: Hugo Sales <hugo@hsal.es>,  git@vger.kernel.org,  Derrick Stolee
 <derrickstolee@github.com>,  Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: Re: [PATCH 0/3] Add `-p' option to `git-mv', inspired by `mkdir'
In-Reply-To: <ffbb04b363938e4a487906134ce4f3c6@manjaro.org> (Dragan Simic's
	message of "Tue, 31 Oct 2023 05:54:31 +0100")
References: <20231009233458.1371351-1-hugo@hsal.es>
	<xmqq1qe3wbt1.fsf@gitster.g>
	<1384513657.119681.1697027599941@office.mailbox.org>
	<xmqqlebj4dnt.fsf@gitster.g>
	<ffbb04b363938e4a487906134ce4f3c6@manjaro.org>
Date: Tue, 31 Oct 2023 14:58:09 +0900
Message-ID: <xmqq5y2n49la.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 790A3BFE-77B2-11EE-AAAD-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> A quite similar ambiguity exists in cp(1) in mv(1), which is also
> resolved by the use of the trailing slash character.  However, I've
> encountered only one person aware of that disambiguation, and in cp(1)
> only, but in the "I always include the trailing slash" way, without
> actually understanding it fully.  Maybe I need to encounter more
> people, I don't know.

If the majority of (perhaps new) users you already know find such
disambiguation method unfamiliar, that already is a good anecdata
without any need for you to meet more people to tell us that it is
not a very easy-to-understand thing for them, no?
