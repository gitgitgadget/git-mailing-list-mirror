Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB76FC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 23:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC35261104
	for <git@archiver.kernel.org>; Thu,  6 May 2021 23:55:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233175AbhEFX4O (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 19:56:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55847 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233079AbhEFX4O (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 19:56:14 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AE9FBAB4EE;
        Thu,  6 May 2021 19:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9B/EX/uv4jCcF/FV2VyM8DIUAKsXJBADQxyvCc
        uttik=; b=O9BOaaxZqgXHocfHbDfIv/bEMLCrGIC+6OTtS0nqJgcg0hjCZ4Tkg5
        Em6J96lmP2FBvMWlXjRXhe7hOW0u8XKswD2SS9HMmBMZQedGBU5Gw7Y7QVp6sPpy
        pt0+KhXYHD9MUDV8EkHuYc7FcU7bex+gps7I4aqO8HfaoxSIuxN0A=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A5ED3AB4ED;
        Thu,  6 May 2021 19:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 262DBAB4EB;
        Thu,  6 May 2021 19:55:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v1 00/43] completion: git-completion 1.3.1 patches
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
Date:   Fri, 07 May 2021 08:55:13 +0900
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com> (Felipe
        Contreras's message of "Mon, 26 Apr 2021 11:14:15 -0500")
Message-ID: <xmqqfsyzwh7i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 80275442-AEC6-11EB-A462-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> These patches represent what comprises git-completion 1.3.1, a friendly
> fork I'm maintaining.
>
> Some of these have already been sent, and should be in "seen", but for
> some reason they are not [1]. Others have been sent, but probably won't
> receive any review soon.

This is not forgotten, I know they apply cleanly on top of the
thirteenth batch of this cycle in 'master', but there are a few
completion changes in flight between that base and 'seen' so after
the dust settles, these patches may have to be rebased on top.

In the meantime, reviews and improvements are still welcome (even
though it might be harder without having a clean merge into 'seen').

