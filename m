Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A09020899
	for <e@80x24.org>; Sat, 12 Aug 2017 00:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751675AbdHLAj3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Aug 2017 20:39:29 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63292 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751361AbdHLAj2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2017 20:39:28 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CBD2C903AB;
        Fri, 11 Aug 2017 20:39:20 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=md7fLfBzvEbZjMKMOUG2DH/Whio=; b=Hj4HkA
        FjYDPPdWbouM7uqRYlgn2cEfstL91awKHwWU3eTtWqJxuDilE2YRXDU4b1VYDa/v
        ILeqaaHKgboBkTz0AzgAKMriEyc2AzjE9rpZC+6UDBNmZ2lZjmRGx+oQHVleqoEU
        qP5bEUavcOoubBMCFcnjwgTJJyoKG48QLcMDc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gK8qa6HKvVf+xW1iINZX/8fuUpV3UCJz
        Ycw4AyvOjoGEJec+FEgc6rJqw8MAA5Xvkobr/kJ7xLP7jNHjpkt8l82Uz8BvIkwM
        XokcP3Vb5MfOuR+t6aHm10OuvfTUMbkVworyKp4sf9m94um32dz1UxpR2uGEdj46
        r0t4TFnfV4Y=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BE480903AA;
        Fri, 11 Aug 2017 20:39:20 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2DA9B903A8;
        Fri, 11 Aug 2017 20:39:20 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com
Subject: Re: [RFC PATCH 0/3] Fixes to "diff --color-moved" MIN_BLOCK_LENGTH handling
References: <cover.1502491372.git.jonathantanmy@google.com>
Date:   Fri, 11 Aug 2017 17:39:18 -0700
In-Reply-To: <cover.1502491372.git.jonathantanmy@google.com> (Jonathan Tan's
        message of "Fri, 11 Aug 2017 15:49:13 -0700")
Message-ID: <xmqqk229y5zd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ADDBD4C0-7EF6-11E7-84F0-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Note that these patches are for "next", depending on the "--color-moved"
> patches.

As we have finished Git 2.14 cycle, in preparation for the next one,
the 'next' branch will be rewound and rebuilt early next week.  I do
not mind tentatively ejecting some topics that needs fix-ups out of
'next' to give them a clean restart.

My preference however is to keep sb/diff-color-move topic as-is
without replacing and fixing it with incremental updates like these
patches.

Thanks.

