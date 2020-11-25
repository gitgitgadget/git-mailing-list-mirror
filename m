Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90CDBC56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:38:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33BCD20B1F
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:38:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="VAkRptXy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726798AbgKYWiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:38:01 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65038 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725836AbgKYWiB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:38:01 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 506B4FCC81;
        Wed, 25 Nov 2020 17:37:59 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=K/c3A6SKhNz1jUsF2lc6sH48Ujw=; b=VAkRpt
        Xy+RXe5jNX6WeXnOP8XEvSKcNdzfGAdBoXQ4jnqY8FaXewvGy+aNZUbxM9qSstpI
        Vcd2Wsp1DzUKB9VtcWYm9ZJu3jdqaZ8Z+D9QXmYd1/lOX2/Vlfufdpd4hEZ2qSWI
        JnWtTXtVBl2vRrIejQysIeSXoVlhJWBEABPaU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=snW23p64k2CRUZthZMaCQiEmVBVmWKZI
        jw9qoJfAiMz+zn53mVLYlW8AuXukd9qdh3kqGLEW2sezcc1ddHWgG2asjVx9Z695
        6Bt7eZvOHjWXBHXET/htJklO02lB/vJKOwwsq/Jvk1HoyBWqMwRuUt5bme/XFhee
        nrir26k2CUw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 49E3EFCC80;
        Wed, 25 Nov 2020 17:37:59 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.75.7.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 27324FCC7F;
        Wed, 25 Nov 2020 17:37:56 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, peff@peff.net, szeder.dev@gmail.com
Subject: Re: [PATCH v4 0/4] update-ref: allow creation of multiple transactions
References: <cover.1604501265.git.ps@pks.im> <cover.1605254957.git.ps@pks.im>
Date:   Wed, 25 Nov 2020 14:37:54 -0800
In-Reply-To: <cover.1605254957.git.ps@pks.im> (Patrick Steinhardt's message of
        "Fri, 13 Nov 2020 09:12:26 +0100")
Message-ID: <xmqqh7pdcbb1.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DCC53D40-2F6E-11EB-9225-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> this is the fourth version of this patch series implementing support for
> creation of multiple reference transactions in a single git-update-ref
> process.

It is my impression that the series is now in good enough shape that
we didn't see much discussion on this round.

So I'll mark this to be merged to 'next', but I ask reviewers to
please holler to stop me otherwise.

Thanks.
