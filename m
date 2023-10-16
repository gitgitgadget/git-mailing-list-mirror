Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C3138F80
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 21:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yEVaRLAY"
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3BE6EB
	for <git@vger.kernel.org>; Mon, 16 Oct 2023 14:54:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3449A1AEAC8;
	Mon, 16 Oct 2023 17:54:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ZFR5KLsshgiYSMNYvndZEe+YpYiQIg4Q16WGF1
	83vHo=; b=yEVaRLAY9Ga+uba+66Dv8XF5fWFwRIbMjbn1FvgAb6v/axb9hfohLS
	+g8hCVgwH/goH+4K9mcwOf+3ZqygGUIJ5cZPaTI2m7iWcSh+VySTesHqY1WxMcvK
	oW6e3nlW02j0OdEs0+tWyM1RM46+PdcoNT1XE7eimzSTkb+OX5tLo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 27DC71AEAC7;
	Mon, 16 Oct 2023 17:54:08 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9DB091AEAC5;
	Mon, 16 Oct 2023 17:54:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 00/25] Documentation fixes
In-Reply-To: <pull.1595.git.1696747527.gitgitgadget@gmail.com> (Elijah Newren
	via GitGitGadget's message of "Sun, 08 Oct 2023 06:45:02 +0000")
References: <pull.1595.git.1696747527.gitgitgadget@gmail.com>
Date: Mon, 16 Oct 2023 14:54:05 -0700
Message-ID: <xmqqo7gykzcy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8744D458-6C6E-11EE-B66A-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> I did review every single change here, multiple times, and I have tried to
> split up this series in a way to make it easier to review. In particular I:
> ...
> (Note: every patch in this series, except for the whitespace fixes patch,
> are best viewed with --color-words.)

I didn't think of anything clever, so ended up reading a bit by bit
over days.  I didn't find anything glaringly wrong ;-)

Let's mark it for 'next'.

Thanks.
