Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C81ADC43381
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A287A224D4
	for <git@archiver.kernel.org>; Mon, 28 Dec 2020 23:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729973AbgL1Wzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Dec 2020 17:55:40 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:62824 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729662AbgL1WoX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Dec 2020 17:44:23 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EC1E311304E;
        Mon, 28 Dec 2020 17:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2KIg1YVy2pdQ
        VxYxYFAakBSHqdA=; b=u3iciJgRhSZ6A6r1xhTB1GjcIi9DPruC4FDYJGW4IPbB
        p3ilEmbrZzL9dgXrNXqYQnSfCzuWpySuQLuSnf2ZuuAuh3Zz5hAyJi6x1fvABlJ+
        oAGZN6ZmlNcfB5kXRKQQzJStLYoXuXZ6wLnWg4zY3Q6DjpcbGJOPO3+nwCDPWTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=dtXLkU
        DzUXbBeQr+Y1uJiENuSRkI5VzdtM2O//ApCiVb1/ugrj7cHrdNIh12JEnY3SMsDY
        avTguSjDBJ511BKUmAcNHrxAFVHn8FQz6lhONxz8FQFucIcpTJn9/83DTvQn/l2w
        b9wUqtdTiZxwi4rc/rs0eLOz7JEDaYe5B3Spw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E4CC911304D;
        Mon, 28 Dec 2020 17:43:40 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2FD0111304C;
        Mon, 28 Dec 2020 17:43:38 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH] CoC: update to 2.0
References: <xmqq5z4mjdbq.fsf@gitster.c.googlers.com>
        <87lfdhvnto.fsf@evledraar.gmail.com>
Date:   Mon, 28 Dec 2020 14:43:36 -0800
In-Reply-To: <87lfdhvnto.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Mon, 28 Dec 2020 18:32:19 +0100")
Message-ID: <xmqqv9cleelj.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 20451640-495E-11EB-A3A8-E43E2BB96649-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> I think the update to 2.0 makes sense. But would in general prefer less
> divergence with upstream for code or documents we copy/paste.
>
> So I submitted a v2 in
> https://lore.kernel.org/git/20201228171734.30038-1-avarab@gmail.com/
> whose diff to upstream is half the size of yours. Perhaps you like it
> better, or not.

I _think_ most of the divergence comes from the fact that I copied
from a wrong variant.  I somehow picked asciidoc variant and
manually adjusted the section leaders, and I wouldn't be surprised
if it wraps lines differently from their markdown variant.

As I expect to be mostly offline this week, I'll let your series sit
on the list while it collects Acks just like we did for the version
1.4, but in any case, let's go with your variant that is based on
the official markdown version supplied by the upstream.

Thanks.
