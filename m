Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 56FBA20A1E
	for <e@80x24.org>; Sun,  9 Dec 2018 01:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbeLIBwK (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Dec 2018 20:52:10 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58607 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726029AbeLIBwJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Dec 2018 20:52:09 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 64FB82E7A1;
        Sat,  8 Dec 2018 20:52:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Nd39XEd+iZlSpN+I1rRLD40SFfY=; b=dulvLT
        YL4oBSAS0rn9hb+ikWuuBUj81PyaRCjsunb7BFFtTBdRi6r79LxdlRMDlYO2KwGI
        cLZkInKSq+nLYsZEItkmCqW4q20OHxfOgDQhUZ6hGobwwxZHuajSX76OHHnG3v68
        Hu0JBGuXMVwjV0ZpcujB01nB+/8Sr399Bybu8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PxBe72gOrPzCCz3AgskaKxPXw9XQMVKM
        u5stOGtWoM32JRdAQjYCD5av5sk8RpJta+xoFSc8CpOKKkJIjxAV8G8NQTDt7jB1
        U3knLxXwgRBGdcSt5Z8CAwaY8L5/M6eQdn8tCYsTLGQhXxWiEsnz5WjJIgK6Y8Pt
        pERxZoWPKSM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5D6812E79F;
        Sat,  8 Dec 2018 20:52:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.187.50.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7BD272E79E;
        Sat,  8 Dec 2018 20:52:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, jrn@google.com, matvore@comcast.net,
        dstolee@microsoft.com, pclouds@gmail.com, peff@peff.net
Subject: Re: [PATCH] terminology tweak: prune -> path limiting
References: <20181206213315.64423-1-matvore@google.com>
        <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com>
Date:   Sun, 09 Dec 2018 10:52:04 +0900
In-Reply-To: <xmqqo99v5vnc.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Sun, 09 Dec 2018 10:36:07 +0900")
Message-ID: <xmqq5zw35uwr.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0852AE16-FB55-11E8-A738-CC883AD79A78-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> AFAIK, "prune" is also used to describe unreachable loose objects,

s/describe/& the act of culling/

> but that use is fairly isolated and have little risk of being
> confusing too much.  Are there other uses to make you consider it
> "highly overloaded"?
