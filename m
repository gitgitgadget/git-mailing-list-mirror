Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44671C433EF
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:05:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbhKVSIV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:08:21 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59756 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239790AbhKVSIU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:08:20 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id EE656107B32;
        Mon, 22 Nov 2021 13:05:13 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=AEGfWP1mHjYLmOJXHPW0FXQGQXp7H8bdb1U4yu
        WtfJQ=; b=S5ZEiCjssUGpnCJFxXO66JAvn08izn/8GEB3QwMQXFYvqlUZrcrHci
        vuFK6lSg5UNiyu979bC+3mK3sWsdl57h5k5S8ya3VA76B23YCLwUBGC+vfyiZW4n
        /VXmHIBi9cLbQ+pLy/sX+B+S5ZZSBraglk+egXqipT/OPvOIkJvas=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E6771107B31;
        Mon, 22 Nov 2021 13:05:13 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5C47E107B30;
        Mon, 22 Nov 2021 13:05:13 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2021, #05; Fri, 19)
References: <xmqqa6hznvz1.fsf@gitster.g>
        <kl6lr1b8qde3.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 22 Nov 2021 10:05:12 -0800
In-Reply-To: <kl6lr1b8qde3.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 22 Nov 2021 10:00:20 -0800")
Message-ID: <xmqqbl2cgj6v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: BD548124-4BBE-11EC-9A56-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> * gc/remote-with-fewer-static-global-variables (2021-11-18) 5 commits
>>  - remote: die if branch is not found in repository
>>  - remote: remove the_repository->remote_state from static methods
>>  - remote: use remote_state parameter internally
>>  - remote: move static variables into per-repository struct
>>  - t5516: add test case for pushing remote refspecs
>>
>>  Code clean-up to eventually allow information on remotes defined
>>  for an arbitrary repository to be read.
>>
>>  Will merge to 'next'?
>
> This got a Reviewed-by from Jonathan Tan; do we need more reviewers to
> look at this?

As I promised, I've been ignoring anything that won't be in 2.34.1
until it goes out, so I do not know the answer to that question at
this moment ;-)

