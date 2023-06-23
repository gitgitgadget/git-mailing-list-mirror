Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20DD2EB64D7
	for <git@archiver.kernel.org>; Fri, 23 Jun 2023 16:26:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231623AbjFWQ06 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jun 2023 12:26:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjFWQ05 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jun 2023 12:26:57 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CD2610F2
        for <git@vger.kernel.org>; Fri, 23 Jun 2023 09:26:56 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BDE19375E3;
        Fri, 23 Jun 2023 12:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lHnOEXzWnoTrYwql6z+c3sTvKHYe4zuqJTJwAt
        LLRfk=; b=W9Pu7mSIRXEz8xz9kftF/o96pTXd82iaiBNxXJs7YHl5xQ+P3g2cWw
        q6UJH+0NxU3H2ilxGY7/lgkvew9o00RlLLDCSXHPlD639cljX6uW0ffimWmKm/i+
        rjWkKxj2/KCNlrfLz+CEr6MAgjp2byXUgMZ7Pw0xwqY3ymMpf4dZk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B6AE3375E2;
        Fri, 23 Jun 2023 12:26:55 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.62.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id C8CF0375E1;
        Fri, 23 Jun 2023 12:26:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org, Joshua Hudson <jhudson@cedaron.com>
Subject: Re: [PATCH] ll-merge: killing the external merge driver aborts the
 merge
References: <6e1b9ce4-e86d-fe30-e5de-27a3be57eefd@cedaron.com>
        <xmqqttuze2fh.fsf@gitster.g> <xmqq4jmzc91e.fsf_-_@gitster.g>
        <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
Date:   Fri, 23 Jun 2023 09:26:51 -0700
In-Reply-To: <CABPp-BG-KDu0fAC=bydz9A56xguSmgwO6SFDdxZ8h=90qR1PUA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 22 Jun 2023 23:25:40 -0700")
Message-ID: <xmqqv8feb0vo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C316B140-11E2-11EE-B821-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> Reviewed-by: Elijah Newren <newren@gmail.com>


Thanks for a quick review.
