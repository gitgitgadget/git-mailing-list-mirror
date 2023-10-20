Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B92361
	for <git@vger.kernel.org>; Fri, 20 Oct 2023 00:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="X4UCzn7Q"
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A278BFA
	for <git@vger.kernel.org>; Thu, 19 Oct 2023 17:36:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9A5B02BD9E;
	Thu, 19 Oct 2023 20:36:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Prl+pEa1ubvKtRq0tsCajufOO0nMoCyIYVuQwt
	2hTLA=; b=X4UCzn7QN6FH3II1FymzGv6gl457ayNHYE1ewJj+nvtCDDxMhgGRk7
	lb9s18DKwv6Ild+ZxVg15K8Oc73YDrNkW6u7+lJd52D8Og7MGY4ZCt1iGQuEU5GI
	MF/RdwqQpo3FYA9Vn8I9SZI3AW2Wld9HxouMQvZCNQbfpRYAZ+sXM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 9233B2BD9C;
	Thu, 19 Oct 2023 20:36:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2E11B2BD9A;
	Thu, 19 Oct 2023 20:36:36 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Linus Arver <linusa@google.com>
Cc: Jonathan Tan <jonathantanmy@google.com>,  Linus Arver via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Glen Choo
 <glencbz@gmail.com>,  Christian Couder <chriscool@tuxfamily.org>,  Phillip
 Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v4 2/4] trailer: find the end of the log message
In-Reply-To: <owlymsweqgx4.fsf@fine.c.googlers.com> (Linus Arver's message of
	"Thu, 19 Oct 2023 17:24:55 -0700")
References: <20230928231644.3529127-1-jonathantanmy@google.com>
	<owlymsweqgx4.fsf@fine.c.googlers.com>
Date: Thu, 19 Oct 2023 17:36:34 -0700
Message-ID: <xmqqpm1at9il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B9AF2EF6-6EE0-11EE-A275-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Linus Arver <linusa@google.com> writes:

> Hi Jonathan, it's been a while because I was on vacation. I've forgotten
> about most of the intricacies of this patch (I think this was a good
> thing, read on below).

Welcome back ;-).

> Will update, thanks.

Thanks.

