Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66A80C4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:19:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476C860EB5
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:19:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231403AbhGVUi1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:38:27 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63002 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbhGVUiV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:38:21 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 1C84314EFD2;
        Thu, 22 Jul 2021 17:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JnPR7bQn6qTOX9f2tkHK8aCMLBzgWP+qIZsCPu
        rA/gw=; b=tKM1B23a33i3MhNkNqHQZAMYAfdzntkJrYeOTNbwYRiFzE8qvHoBaw
        ENv/0kw4KdB5K5HWek8VfYRA2JgzIV2cTYik2AW/9AaazlyLfQsq+3DMRVP9zc8w
        plfWsGGTCnIYMP/Ga/5TBoPXiik5bqOTqpswi1IX19kPZ43HGwcxI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0819714EFD1;
        Thu, 22 Jul 2021 17:18:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4158114EFD0;
        Thu, 22 Jul 2021 17:18:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Hu Jialun <hujialun@comp.nus.edu.sg>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] commit: remove irrelavent prompt on
 `--allow-empty-message`
References: <xmqq7dhz711a.fsf@gitster.g>
        <20210722183332.814139-1-hujialun@comp.nus.edu.sg>
Date:   Thu, 22 Jul 2021 14:18:51 -0700
In-Reply-To: <20210722183332.814139-1-hujialun@comp.nus.edu.sg> (Hu Jialun's
        message of "Fri, 23 Jul 2021 02:33:32 +0800")
Message-ID: <xmqqsg0682tg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6A831222-EB32-11EB-9662-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hu Jialun <hujialun@comp.nus.edu.sg> writes:

> Sorry for bothering again; just checking if anything went wrong with
> my previous email about ternary operator conventions :')
>
> https://lore.kernel.org/git/20210710172655.2731007-1-hujialun@comp.nus.edu.sg/

I do not think anything went wrong.

You counted between wrapping after ?: vs before ?: and showed that
locally line-wrapping just before ?:, so that ?  and : appears after
the indent, happens more often, no?

It was my understanding, after your finding above, that we have been
waiting for an updated patch to mimic the majority.

Thanks.
