Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2040838DC5
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 23:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="HSqGMKm6"
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 746C24496
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 15:15:10 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 33C841B84C;
	Thu,  9 Nov 2023 18:15:07 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hJaxHRYI67Z0vr5cQnWW9mwbuuP7a2AczrMETx
	gTUUo=; b=HSqGMKm6i8MeKvLPtl3R5XhSTdGKkPQ9h9qhI/3dG6P0vBbb1jbmXm
	aVvhZRjilIGwgG/hVWV8DRKi8m/Izsty0m8oiojE+Sf1ZD4slOqgiDqS2lagFG6A
	c/I3yhGKACRqtYKtV2A0dJ6WlQ0mMSpy+d81XOWuBKPO/JXDc64lY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2C2551B84B;
	Thu,  9 Nov 2023 18:15:07 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.67.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 93B781B847;
	Thu,  9 Nov 2023 18:15:03 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  phillip.wood123@gmail.com,
  oswald.buddenhagen@gmx.de,  christian.couder@gmail.com
Subject: Re: [PATCH v10 1/3] unit tests: Add a project plan document
In-Reply-To: <f706ba9b682e7c4070d49086ad3af582bf269c79.1699555664.git.steadmon@google.com>
	(Josh Steadmon's message of "Thu, 9 Nov 2023 10:50:42 -0800")
References: <0169ce6fb9ccafc089b74ae406db0d1a8ff8ac65.1688165272.git.steadmon@google.com>
	<cover.1699555664.git.steadmon@google.com>
	<f706ba9b682e7c4070d49086ad3af582bf269c79.1699555664.git.steadmon@google.com>
Date: Fri, 10 Nov 2023 08:15:02 +0900
Message-ID: <xmqq1qcyzfgp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D0268A82-7F55-11EE-B591-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> In our current testing environment, we spend a significant amount of
> effort crafting end-to-end tests for error conditions that could easily
> be captured by unit tests (or we simply forgo some hard-to-setup and
> rare error conditions). Describe what we hope to accomplish by
> implementing unit tests, and explain some open questions and milestones.
> Discuss desired features for test frameworks/harnesses, and provide a
> comparison of several different frameworks. Finally, document our
> rationale for implementing a custom framework.
>
> Co-authored-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Josh Steadmon <steadmon@google.com>
> ---
>  Documentation/Makefile                 |   1 +
>  Documentation/technical/unit-tests.txt | 240 +++++++++++++++++++++++++
>  2 files changed, 241 insertions(+)
>  create mode 100644 Documentation/technical/unit-tests.txt

Looks good.  I'll downcase "Add" on the title to match what I have
in my tree, but otherwise it looks OK to me.  Let's see if we can
mark this round ready for 'next' and check if we hear complaints.

I have to make sure I do not forget about the other topic that
builds on top of this one.

Thanks.

