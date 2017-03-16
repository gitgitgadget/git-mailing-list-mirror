Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B6A6020323
	for <e@80x24.org>; Thu, 16 Mar 2017 19:48:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752558AbdCPTsG (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Mar 2017 15:48:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:50147 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752494AbdCPTsF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Mar 2017 15:48:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B8D356B498;
        Thu, 16 Mar 2017 15:41:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=inolIPmXt3lTRGr8fzXgonr/qtM=; b=mRcqK6
        kNo+7RBWdBw+x6Dl9jFETrLKfes4YEqzLiNuhH+xEidqPSRQSGYrb0PMyGHxm7Ch
        aRRMKdiZqYTAQxr14bg7UXuhoOU5jPLs+94VjnNkIV0tD10uGiUylr1JU7miHClF
        wkuhXlYZ4muHqIill6xGetc0NLP4V9ORNUELs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Sfgv/WxB/hpl8UrPcppVLr3FBQXU3lVK
        jbQGJkOenm3ktirol64tnPYC9sOYAfZVJSrRUJIDpGqFQ1BaOlHHkVNcp1SyrEfY
        T9qIEQMcI/vK/fkT8EHcswvHNJJhr05dPRslQALJDWAydGZK0ScirHe1X0gSGISH
        g6rCC85oYJs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AFD386B497;
        Thu, 16 Mar 2017 15:41:55 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0ADBF6B496;
        Thu, 16 Mar 2017 15:41:54 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: USE_SHA1DC is broken in pu
References: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
Date:   Thu, 16 Mar 2017 12:41:53 -0700
In-Reply-To: <CA+55aFzJ3NFVoN6K9__nM_LWYfegxGo_YxB0OudTNBCG+qq+3Q@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 16 Mar 2017 12:22:00 -0700")
Message-ID: <xmqqfuidau0u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9C307518-0A80-11E7-8031-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> I think there's a semantic merge error and it clashes with
> f18f816cb158 ("hash.h: move SHA-1 implementation selection into a
> header file").
>
> Suggested possible merge resolution attached.
>
>                    Linus

Obviously I have not been paying much attention to the current shape
of that topic, awaiting the real thing X-<.

I am hoping that we can make the "hash.h" thing graduate soon to
'master' and then queue the real thing on top, but in the meantime I
should have made sure the current one still does the right thing.

Thanks.
