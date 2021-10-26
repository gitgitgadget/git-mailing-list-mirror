Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96601C433F5
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:28:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC5160EB4
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 21:28:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239607AbhJZVak (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Oct 2021 17:30:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54623 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239602AbhJZVai (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Oct 2021 17:30:38 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E39C17394F;
        Tue, 26 Oct 2021 17:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6c6rCVxi2ziRlfNtn7mFIMGMzAIwGYh8/6AISw
        rbl2A=; b=oUy1yxRyM2aCkmcg9+O+VQ8e7G3zy/i5q1kAcp8hazPHL3ZnxgGdpx
        KEO+Qy+ROZk50Rp8HzQY6Kk9A9bG3SelQxffBXGgGZNlApXgKqNCt0dIyKSEYu0h
        y4DbmuCwQIidxD6lk7PUGhx+EWmlP2M6cG0651RQbATpzQ3WeZPGA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2649617394E;
        Tue, 26 Oct 2021 17:28:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 612EB17394B;
        Tue, 26 Oct 2021 17:28:10 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, Victoria Dye <vdye@github.com>
Subject: Re: What's cooking in git.git (Oct 2021, #06; Mon, 25)
References: <xmqq5ytkzbt7.fsf@gitster.g>
        <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com>
Date:   Tue, 26 Oct 2021 14:28:09 -0700
In-Reply-To: <e9bc367e-ae51-da1c-558e-6836922b0d0d@gmail.com> (Derrick
        Stolee's message of "Tue, 26 Oct 2021 08:42:17 -0400")
Message-ID: <xmqqv91jxyqe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9E3ED986-36A3-11EC-9AF6-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>  Various operating modes of "git reset" have been made to work
>>  better with the sparse index.
>> 
>>  Needs review.
>
> This topic had good review in its first three versions, and the
> current v4 has had one response that doesn't seem to have actionable
> changes. Could you re-evaluate if the "needs review" label is still
> appropriate?

The label indeed does not read well.  I know there was a lot of
dicussions on v3 but in the list traffic, but I do not see anybody
looked at v4 and said that the issues they pointed out in v3 are now
covered to their satisfaction.  Probably "Needs ack" may have shown
what I meant better?

Thanks.

