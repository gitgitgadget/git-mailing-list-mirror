Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37469C433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E816161077
	for <git@archiver.kernel.org>; Thu,  6 May 2021 21:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbhEFVkd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 17:40:33 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54616 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhEFVkc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 17:40:32 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E57DEAA492;
        Thu,  6 May 2021 17:39:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=q/fT4jnNQHk9Q0R88pkc/jmqd37YAzF+dE6pyC
        jMr1k=; b=KXM85+QbUkQlDVm+J2ShN4KmNNrXKOcgzbkTep7damfoOQQqtqFZDd
        rY/RSCeWsM1vYZR2Nf4nmVm5QlwfxyjgioRC/5QwVh5xdH7vj1sXoZAfimOAFmyG
        PBfrNI4J4tZKDZairbk0/5JgZi0EIJg/FFezmICHBnqBJhxX6dGxA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DCE8AAA491;
        Thu,  6 May 2021 17:39:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4A530AA490;
        Thu,  6 May 2021 17:39:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     dyroneteng@gmail.com, git@vger.kernel.org
Subject: Re: [PATCH] Optimize the description of the configuration in
 packfile-uris doc
References: <20210506073354.27833-1-dyroneteng@gmail.com>
        <20210506164728.336409-1-jonathantanmy@google.com>
Date:   Fri, 07 May 2021 06:39:31 +0900
In-Reply-To: <20210506164728.336409-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Thu, 6 May 2021 09:47:28 -0700")
Message-ID: <xmqq4kffy224.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8B3B7EE8-AEB3-11EB-83A6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

>> There is a description problem in the document about packfile-uris. This
>> patch describes the configuration format of `uploadpack.blobPackfileUri`
>> more accurately.
>
> Thanks for noticing this. The diff itself is correct, of course.
>
> As for the commit message, limit the title to 50 characters or fewer if
> possible. Maybe something like "packfile-uri.txt: fix blobPackfileUri
> description" or something like that.
>
> Also in the commit message, maybe mention that the correct format can be
> seen in t5702.

Thanks for giving a review with clear suggestion for improvements,
Jonathan.  And thanks for contributing, Teng.

Will look forward to seeing an updated patch.
