Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF82720986
	for <e@80x24.org>; Fri,  7 Oct 2016 16:40:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941230AbcJGQkm (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Oct 2016 12:40:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54674 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S938859AbcJGQkj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2016 12:40:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8AA75416AD;
        Fri,  7 Oct 2016 12:40:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=eMG+FuTwGsidflwanvJPsZMX6f0=; b=Czjkm+
        w9AOP8SbJA2B/kAZC5X6ZHzAHTpZitA3vkIHQ0RRBxeuK4/he5H5MT5trmjVNotS
        2gmO9ZU2bULMl4F74kZtE09smhZ47LA4W97N+dT5ZwMmJlWNJG9gaENs4px6eWcQ
        Q/CqA+cgkJ3PXKOgBM3CZwIBGKQDpAIy/m28k=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=a07VkqUK0x8RNmaRuSXxrTWqMZb0/s0o
        mDhTVD8mIf7slHclcySlJNmV/FRk867rPla8A/HQUd5NARlw4qW//xuaoJRAUASZ
        qk4C4Oa8vHyrq9RKmoA4guc8PzJD3rWtgr76J1QO40s6MyohDE29RoSuf1z8eIqc
        A6kx4QhZ10E=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 571E8416AA;
        Fri,  7 Oct 2016 12:40:04 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76FDA416A9;
        Fri,  7 Oct 2016 12:40:03 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Kevin Daudt <me@ikke.info>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Oct 2016, #02; Thu, 6)
References: <xmqqd1jdi0a6.fsf@gitster.mtv.corp.google.com>
        <20161007045613.GB25613@ikke.info>
Date:   Fri, 07 Oct 2016 09:40:01 -0700
In-Reply-To: <20161007045613.GB25613@ikke.info> (Kevin Daudt's message of
        "Fri, 7 Oct 2016 06:56:13 +0200")
Message-ID: <xmqqzimggljy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B24D246A-8CAC-11E6-ACAF-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Kevin Daudt <me@ikke.info> writes:

> Just wondering why the topic "kd/mailinfo-quoted-string (2016-09-28) 2
> commits" is not listed anymore. Previous what's cooking said it was
> merged to "next".

Thanks for your contribution.

The topic was listed as graduated to 'master' in issue #1 of this
month:

    http://public-inbox.org/git/<xmqqtwct3w0p.fsf@gitster.mtv.corp.google.com>

After a topic graduates, it will not be included in the report.
