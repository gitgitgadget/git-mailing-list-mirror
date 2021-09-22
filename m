Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3088C433F5
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 21:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9955D611CA
	for <git@archiver.kernel.org>; Wed, 22 Sep 2021 21:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238136AbhIVVoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Sep 2021 17:44:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60408 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238066AbhIVVoc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Sep 2021 17:44:32 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 45F65158E9F;
        Wed, 22 Sep 2021 17:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=WCgJogVTGJ58ZZGW60B0CpvY2jLa6OwMDf0hwz
        0u70c=; b=dBVcOsEp7S99qf89iavELrTLdhNVuGEfU29vI//mwcMFllvV8iB75k
        TpJUOcoTJe3ZkumFpvFs+4yeULeDWZNJvAmDbjvBbVOX6M+Xikw1+VtS7f6boSUN
        vzN+MaJ4Jw0QZqi2ehD5sKyGC3s/TmfP/qL4ARBuvGhrCLIY2DVyM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F07B158E9E;
        Wed, 22 Sep 2021 17:43:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99865158E9C;
        Wed, 22 Sep 2021 17:42:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Daniel Stenberg <daniel@haxx.se>
Subject: Re: [PATCH] http: match headers case-insensitively when redacting
References: <YUonS1uoZlZEt+Yd@coredump.intra.peff.net>
        <xmqq8rzo770h.fsf@gitster.g>
        <YUuNXOb5blV7iN6P@coredump.intra.peff.net>
        <xmqqk0j85o6c.fsf@gitster.g>
        <YUudqYmzy9N3e0Bk@coredump.intra.peff.net>
Date:   Wed, 22 Sep 2021 14:42:57 -0700
In-Reply-To: <YUudqYmzy9N3e0Bk@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 22 Sep 2021 17:18:33 -0400")
Message-ID: <xmqqbl4k5lsu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DA02A26-1BEE-11EC-8DE4-98D80D944F46-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> No, I think we are on the same page now. Do you want me to take
> another stab at writing the commit message to clarify things (i.e., do
> we think it's badly written, or was it just mis-interpreted)?

I am not sure which, but perhaps more of the latter.  So I would not
insist.

Thanks.
