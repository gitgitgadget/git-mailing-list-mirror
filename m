Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85D41C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:14:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 692C5610C9
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:14:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbhIJRPV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 13:15:21 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52708 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJRPV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:15:21 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 42E9BE67EA;
        Fri, 10 Sep 2021 13:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yfdj13RT0bW7
        NqKZIXnx+iug3Z4Zew5ILLIa/qKCtGo=; b=vbeQpVWzpLFH9pmVaDwALE9Knw+Q
        awt/Z1wJLtIZ8ZodcwwMZhB6kGVFFow+WuQNdtfH49HABXPu3/hITC2G15udL67n
        3dfwFVY5kw0Mo6HBM6qGItEzILU7gLCQ15RWOw1U67tvr3Z9leFQy887QpoyJfrN
        SjFxuiRLv/tI7nk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39737E67E9;
        Fri, 10 Sep 2021 13:14:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 76142E67E8;
        Fri, 10 Sep 2021 13:14:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl"
 follow-up
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>
        <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
Date:   Fri, 10 Sep 2021 10:14:05 -0700
In-Reply-To: <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 10 Sep
 2021 13:04:25
        +0200")
Message-ID: <xmqqbl50tkte.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 825C6106-125A-11EC-A41D-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> This is a follow-up to the already-integrated topic for dropping
> support for older curl versions submitted before the v2.33 release[1].

To which commit are these expected to apply?  I am having trouble
wiggling 5 and 7 in.

Thanks.
