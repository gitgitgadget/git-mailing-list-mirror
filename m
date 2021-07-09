Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B76C07E99
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:54:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30484613BD
	for <git@archiver.kernel.org>; Fri,  9 Jul 2021 14:54:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbhGIO4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Jul 2021 10:56:53 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62225 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231588AbhGIO4w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jul 2021 10:56:52 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 26ADDE0965;
        Fri,  9 Jul 2021 10:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QWVctB/HQHU6oz8CeZk5aPP5cR+nYs6caJsFEC
        MFQGE=; b=ybHq3lBNTqp+SJuW2w4s0ioNq8oDxP0hKiq721XEHo4kHzivx5Wwdx
        1qUWo0gGq9wb43uXFuAEdIdUcxK7O/D1v0PRJOdDtN1CQtJmJjma3e6JUBErl/0J
        8z/XuMuYM7hJHkdOFCL7UvrS0PeO05aJWsT6o20yNsCO25xzX8zK4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1C796E0964;
        Fri,  9 Jul 2021 10:54:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7BDD2E0963;
        Fri,  9 Jul 2021 10:54:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2021, #02; Thu, 8)
References: <xmqq8s2ga19f.fsf@gitster.g>
        <YOecw2k5x1qc/GJk@camp.crustytoothpaste.net>
Date:   Fri, 09 Jul 2021 07:54:06 -0700
In-Reply-To: <YOecw2k5x1qc/GJk@camp.crustytoothpaste.net> (brian m. carlson's
        message of "Fri, 9 Jul 2021 00:48:03 +0000")
Message-ID: <xmqqh7h38rn5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 82F56E8A-E0C5-11EB-8E1A-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> On 2021-07-08 at 22:28:44, Junio C Hamano wrote:
>> * bc/rev-list-without-commit-line (2021-07-06) 1 commit
>>  - rev-list: add option for --pretty without header
>> 
>>  "git rev-list" learns to omit the "commit <object-name>" header
>>  lines from the output with the `--no-commit-header` option.
>> 
>>  Will merge to 'next'.
>
> I haven't seen a review for this, so it might be better to hold off
> until it gets one.  The two people I CC'd happen to be off this week, so
> it may be next week before they get to respond.
>
> Of course, if you've taken a look and think it's fine, I am happy to
> trust your judgement.

Yeah, I looked at it when I queued it, and didn't find anything
glaringly wrong with it.  But still, I'll give it a few more days
for others to pick nits.

Thanks for being extra careful.
