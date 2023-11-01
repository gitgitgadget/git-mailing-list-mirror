Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B6A7F
	for <git@vger.kernel.org>; Wed,  1 Nov 2023 05:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="qF0RBCNK"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38FFEB9
	for <git@vger.kernel.org>; Tue, 31 Oct 2023 22:01:11 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id DE16E2A642;
	Wed,  1 Nov 2023 01:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YNoNNY28A7ljkURe/qAXO8QS8bXQU3nXcPLYQm
	vnWV4=; b=qF0RBCNKcQzAF2w5bswqQcNJRDSj96oeAIcl/pNao8pYFiQ2fUpiTt
	PyLlkZkRfjigCtjFR4nLdLhMBybUP3QlAKNI1gC1zCy/Y7yZrFLXmCdqD+9pskwi
	Ph+4edi4IxvF+WMOJE9bOjh7wdcB6jSOnMGAmeu4nFq5bFfN48HEQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D6BFB2A641;
	Wed,  1 Nov 2023 01:01:10 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.198.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6EFC22A640;
	Wed,  1 Nov 2023 01:01:07 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Taylor Blau <me@ttaylorr.com>,  git@vger.kernel.org,  Karthik Nayak
 <karthik.188@gmail.com>,  Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] commit-graph: detect commits missing in ODB
In-Reply-To: <ZUHaLqslYFDahNkq@tanuki> (Patrick Steinhardt's message of "Wed,
	1 Nov 2023 05:55:21 +0100")
References: <cover.1698060036.git.ps@pks.im> <cover.1698736363.git.ps@pks.im>
	<ZUFSqRYXhwsWC+EA@nand.local> <xmqqh6m6z6pe.fsf@gitster.g>
	<xmqq34xqxm5u.fsf@gitster.g> <ZUHaLqslYFDahNkq@tanuki>
Date: Wed, 01 Nov 2023 14:01:05 +0900
Message-ID: <xmqqh6m6t6cu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AAA70694-7873-11EE-B08E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> In the meantime, here is a mechanically produced incremental I'll
>> tentatively queue.  Hopefully I did not screw up while generating
>> it.
>> 
>> Thanks.
>
> Ah, sorry, didn't notice it was in 'next' already. Anyway, the diff
> below looks good to me, thanks!

I changed my mind ;-) I'll kick out a few topics and rebuild 'next',
with your v3 patches.

Thanks.
