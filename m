Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FFC1C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC4F60200
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 00:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhFHAHm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 20:07:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53164 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230183AbhFHAHl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 20:07:41 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6C29CDB38D;
        Mon,  7 Jun 2021 20:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yFA/B2K6RL/hc9yvjfXf3UVCNtSADcUqvGF3an
        WXdoY=; b=v2rJpxMMc0ZLxRTenS97/qEcqIhW3xJlkNHZnVCGVs5fHwvBivl6im
        khmBFPv2JqeV0pRwoyD5qYnTJbgRuyc5lro3Z7PIWd1GhB74zw64IYT7raOridhH
        KYXJ8xSQcQBSZJ1APXrY3cMUJsIBxtN8iGRc19lTBer4jA2UWXINU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 63884DB38C;
        Mon,  7 Jun 2021 20:05:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7A25DB387;
        Mon,  7 Jun 2021 20:05:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/4] CodingGuidelines: recommend singular they
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <d2c079264955b3bd6c3a5ef77a9c3684206f8475.1623085069.git.gitgitgadget@gmail.com>
        <xmqq4ke9v6za.fsf@gitster.g>
        <a66ed39c-926d-d887-526b-dc0f9c049085@gmail.com>
Date:   Tue, 08 Jun 2021 09:05:48 +0900
In-Reply-To: <a66ed39c-926d-d887-526b-dc0f9c049085@gmail.com> (Derrick
        Stolee's message of "Mon, 7 Jun 2021 15:05:19 -0400")
Message-ID: <xmqq5yypte3n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 47B3547C-C7ED-11EB-A154-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> I'll admit that I was trying to be instructive in my commit message
> whenever possible, so specifically chose that option among brian's
> preferred pronouns. If I misinterpreted the purpose of "he/him or
> they/them" then I will absolutely change this instance.
>
> For my part, I did run this message by brian before sending the patch,
> to be sure that my use of the quote was appropriate. (Also, I'm
> purposefully lower-casing "brian m. carlson" to match chosen email
> signatures, but perhaps that is also incorrect?)

I upcased out of habit, even I know his preference is all lowercase,
purely by mistake.  This is talking about a particular person and
using the name that particular person wants to be called with, so
honoring that wish is good regardless of how an unspecified person
should be referred to as, and I should have double checked.


