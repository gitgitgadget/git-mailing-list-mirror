Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAEA6C27C41
	for <git@archiver.kernel.org>; Wed, 16 Aug 2023 21:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346424AbjHPVTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Aug 2023 17:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346433AbjHPVTL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Aug 2023 17:19:11 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46E20E4F
        for <git@vger.kernel.org>; Wed, 16 Aug 2023 14:19:10 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BF03A19D7B2;
        Wed, 16 Aug 2023 17:19:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=gWhHDp36VkD4MZM1dEncTo1cssgAQQ0kr6rCqs
        XrIuE=; b=baQ+kncvmR1DSxm2wJuKI1nMjhGXXpFGeVkqX38GMjpKQEYBc7hHWW
        EMlPftHVle+WbMaMqxtwWBoyikdVOSv8v3EY8Y5xX44cescyOJKLCZZhPRIaZuF0
        V9jK09N7TSFtIo7EmxGKCT+FBmSgFoDKrj20vW/bJb/XQlCf7wliw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 889CC19D7B0;
        Wed, 16 Aug 2023 17:19:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id C9E0E19D7AE;
        Wed, 16 Aug 2023 17:19:03 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org,
        nasamuffin@google.com, jonathantanmy@google.com, linusa@google.com,
        vdye@github.com
Subject: Re: [RFC PATCH v2 0/7] Introduce Git Standard Library
References: <20230627195251.1973421-1-calvinwan@google.com>
        <20230810163346.274132-1-calvinwan@google.com>
        <kl6lmsyy8sfj.fsf@chooglen-macbookpro.roam.corp.google.com>
        <56d0838d-12a5-8a8a-3c3e-7d473f2977e8@gmail.com>
        <CAFySSZBN+-HVPekCjkshepKZLB5uP-m9A=1bWm5Z_OBUVtgQYQ@mail.gmail.com>
Date:   Wed, 16 Aug 2023 14:19:02 -0700
In-Reply-To: <CAFySSZBN+-HVPekCjkshepKZLB5uP-m9A=1bWm5Z_OBUVtgQYQ@mail.gmail.com>
        (Calvin Wan's message of "Wed, 16 Aug 2023 10:17:39 -0700")
Message-ID: <xmqqr0o2eldl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 86B4175C-3C7A-11EE-9302-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> Thanks for resolving the conflicts on master. I should've rebased
> before sending out this v2 since it's built off of 2.41 with some of
> my other patch cleanup series.

I think the freeze period before the release would be a good time to
rebuild on an updated base to prepare v3 for posting.

Thanks.
