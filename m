Return-Path: <SRS0=mjbR=3L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4F48C32771
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:45:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8685E2253D
	for <git@archiver.kernel.org>; Wed, 22 Jan 2020 22:45:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="rXlJl3MA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbgAVWpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jan 2020 17:45:34 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51209 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725884AbgAVWpe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jan 2020 17:45:34 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4FD6EAC8D4;
        Wed, 22 Jan 2020 17:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=EYGUxqq8ZT+jRhL0t9B/jKENga0=; b=rXlJl3
        MAIQOa7zb4etMIjgrXYZ4Oj051PVBRQhEDe0Pemean7nIa74+CTYXaaXlPGKa3N4
        ZjW/rs8E/JOPK6kxslVecJr0JFQZawdwI7/33qTtWsu32QmCtflMPwFdEGGg8F26
        76HCongTh/5C8yOuaGEPnMkvcGYnEpi0ta8mg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mC+Prf+50iT/Z5eDrQPb6PbL+Y3JZzwW
        aR1/yjeOEgqbJxL0vjy/Dsj+3mwJeHHin7L2ie5olrITmhcVaEMuCPICEPDKz9kr
        kcgybDcQofL01PBbGRU2E2TVSq6Juw4DbbdikOD4eaHSkB7RNiPAQ1jRyYc5tWOe
        uI3PlXsRaE8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 48DEFAC8D3;
        Wed, 22 Jan 2020 17:45:32 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 89F7BAC8D2;
        Wed, 22 Jan 2020 17:45:29 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jan 2020, #04; Wed, 22)
References: <xmqqr1zr5e5e.fsf@gitster-ct.c.googlers.com>
        <CABPp-BHMwkP5r2tmVfmrjVM904EnhEAQ8hqCbxQ7QEg+vyRNZQ@mail.gmail.com>
Date:   Wed, 22 Jan 2020 14:45:27 -0800
In-Reply-To: <CABPp-BHMwkP5r2tmVfmrjVM904EnhEAQ8hqCbxQ7QEg+vyRNZQ@mail.gmail.com>
        (Elijah Newren's message of "Wed, 22 Jan 2020 14:37:55 -0800")
Message-ID: <xmqqk15j5cvs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E3C9C0DC-3D68-11EA-980A-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> * en/unpack-trees-check-updates-simplify (2020-01-04) 1 commit
>>  - unpack-trees: exit check_updates() early if updates are not wanted
>>
>>  Code simplification.
>>
>>  Will merge to 'next'.
>
> ...this is v1 of the same submission.

Thanks for spotting.  Discarded.
