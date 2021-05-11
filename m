Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96749C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:01:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F2A561921
	for <git@archiver.kernel.org>; Tue, 11 May 2021 05:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbhEKE7Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 00:59:16 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55728 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhEKE7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 00:59:16 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4ABBBBD086;
        Tue, 11 May 2021 00:58:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/iny80zOpsHkCbUvfC1DBEtN6Li8RjhcUHblq
        01xyI=; b=VDFd/n3HAPGnoogLLghohSskU0Pl4vPlklH/0eLRd0arGT7H22+Dd/
        mAgQh/OAq+HCD5ieWhLuFP0G+xrOkMYBXfbmPE2leddkcP34uSVsdGjJMf2KTpO0
        wIgRrQYc7h2+JDvYQOW8WB8X9AvJUmD5PImW/tIyfFByPs41mrqrs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42A67BD085;
        Tue, 11 May 2021 00:58:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BDFFABD084;
        Tue, 11 May 2021 00:58:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Will Chandler <wfc@wfchandler.org>, git@vger.kernel.org, ps@pks.im
Subject: Re: [PATCH] refs: cleanup directories when deleting packed ref
References: <YJVQpaDwkQH/aCee@mini.wfchandler.org>
        <YJW3n6lVWVAuLQap@coredump.intra.peff.net>
        <YJW46fsdKaUv2Fln@coredump.intra.peff.net>
        <YJXF4xA0GFx2/2v4@coredump.intra.peff.net>
        <YJYTQYk5q8g6HaIm@mini.wfchandler.org>
        <YJYa+7yUyt2YD16r@mini.wfchandler.org>
        <YJnfV7op4yhyLqdg@coredump.intra.peff.net>
Date:   Tue, 11 May 2021 13:58:08 +0900
In-Reply-To: <YJnfV7op4yhyLqdg@coredump.intra.peff.net> (Jeff King's message
        of "Mon, 10 May 2021 21:35:19 -0400")
Message-ID: <xmqqk0o5ooin.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7AB97DA8-B215-11EB-A3A1-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> This thread got off on a tangent about threads, but to get back to the
> main idea: this v2 patch looks good to me. Thank you very much for
> finding and fixing it.

Thanks.  But now we have a harder time to find that v2 patch X-<.

