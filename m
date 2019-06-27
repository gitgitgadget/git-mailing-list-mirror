Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8975A1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 17:11:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfF0RLk (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 13:11:40 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:59528 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726315AbfF0RLk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 13:11:40 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7B627B14E;
        Thu, 27 Jun 2019 13:11:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Z+Bt9vYhWSLcYipDl4x9H+HsFU4=; b=Rxy6jp
        DgG7ZZgZRX2dFCgIaMKKIIHyS6py1q3j5om6iatkHfoq0jV1MPDfgEPfYpef0NBq
        +p3XAtGeZn1IIrCUrCgp+Mq9G0g4SaGkzqIR8JTndbcWRXzIaNS6BUBRvUzlvjcE
        lm4qW8RmuSbLLueT7pRMUTkvULFN2nfp27qOc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ACjvwiVDIpDAERhvzF1apZOebRXvVe4E
        bUB+vPTug/qABI4QCi/Z+m7r2ildVYvvppGGMy1VwIdB+Vf1rzrpv/nEPb/k4dMN
        dme3h6lpEF3hve0eu/FMkdGJGfDl5pdYKIJyNTBlnh6l5dAqlpq1Kz0l9gtw5pk0
        JUIpeE+WkGQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DF6E57B14C;
        Thu, 27 Jun 2019 13:11:39 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id CCEED7B14B;
        Thu, 27 Jun 2019 13:11:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net, stolee@gmail.com
Subject: Re: What's cooking in git.git (Jun 2019, #06; Wed, 26)
References: <xmqq36jwc75i.fsf@gitster-ct.c.googlers.com>
        <20190626224147.75686-1-jonathantanmy@google.com>
Date:   Thu, 27 Jun 2019 10:11:34 -0700
In-Reply-To: <20190626224147.75686-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Wed, 26 Jun 2019 15:41:47 -0700")
Message-ID: <xmqqpnmzar7d.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9F055894-98FE-11E9-AC93-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> Junio, what do you think of this small patch that just updates a test:
>
> https://public-inbox.org/git/20190605192624.129677-1-jonathantanmy@google.com/
>
> For what it's worth, Stolee and Peff have replied and both of them seem
> to be OK with it.

Thanks for pointing out a thread fell in the cracks.  The default
for a patch that have been reviewed and received favourably is to
queue, but sometimes I miss a thread or two among dozens.

Very much appreciated.

