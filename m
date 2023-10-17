Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2BE430F9
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 20:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pDhJlDOu"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81F92
	for <git@vger.kernel.org>; Tue, 17 Oct 2023 13:22:00 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id BE54F2E0EC;
	Tue, 17 Oct 2023 16:21:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=YhRh7ePOmlDIVt4gYeo6Ysahgd2bAV8kU43IIL
	mNQFM=; b=pDhJlDOuiwn1HmY9HNZTlicS0CANcWWeS1/ZMAMH01TAGnVXAO2K/b
	1Y4NSueMzZKkJdZqcbBraRhKuT+9Cr/A59qifsxkyktY0QCCGuPWU72mv29LV7EG
	vLg5V9WM0uPPQCUm3zEp6pOET4zGf3GhINRZZJjfOjoYm/tOuefbM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id B65772E0EB;
	Tue, 17 Oct 2023 16:21:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 2FED92E0EA;
	Tue, 17 Oct 2023 16:21:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dorcas Litunya <anonolitunya@gmail.com>
Cc: christian.couder@gmail.com,  git@vger.kernel.org
Subject: Re: none
In-Reply-To: <ZS2ESFGP2H3CTJSK@dorcaslitunya-virtual-machine> (Dorcas
	Litunya's message of "Mon, 16 Oct 2023 21:43:20 +0300")
References: <ZS2ESFGP2H3CTJSK@dorcaslitunya-virtual-machine>
Date: Tue, 17 Oct 2023 13:21:54 -0700
Message-ID: <xmqqjzrlgftp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D145AAFC-6D2A-11EE-9B31-A19503B9AAD1-77302942!pb-smtp21.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Dorcas Litunya <anonolitunya@gmail.com> writes:

> Bcc: 
> Subject: Re: [PATCH] t/t7601: Modernize test scripts using functions
> Reply-To: 
> In-Reply-To: <xmqq1qdumrto.fsf@gitster.g>

What are these lines doing here?

> So should I replace this in the next version or leave this as is?

Perhaps I was not clear enough, but I found the commit title and
description need to be updated to clearly record the intent of the
change with a handful of points, so I will not be accepting the
patch as-is.

These two sections may be of help.

Documentation/MyFirstContribution.txt::now-what
Documentation/MyFirstContribution.txt::reviewing

Thanks.
