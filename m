Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 026BAC433EF
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 18:23:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D879860EE6
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 18:23:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346981AbhIBSX6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 14:23:58 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:54576 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346986AbhIBSX5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 14:23:57 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id CDCDC1580B4;
        Thu,  2 Sep 2021 14:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Jiq2tfhDdEEX
        DRgqblCSeq8mczs5ZzpPCWh6CqOaVgo=; b=u/hWnlP/suedl4PQFuL7fezG1rTC
        XP7iLaXU+0fduo1lBa7jsRnGtYnL2eQYh1aPhvwv+0KtFMIw8t7udA0D3R++hVhK
        ViEjyUIermxInxEzZuQWC9rFKiAVz9YEwpOCp9v8UEbuTCMoJ9UXlB2cPzGi14FA
        MmquQ0C7X8pKxQU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C659B1580B3;
        Thu,  2 Sep 2021 14:22:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E580F1580B2;
        Thu,  2 Sep 2021 14:22:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: What's cooking in git.git (Aug 2021, #10; Tue, 31)
References: <xmqqo89drwad.fsf@gitster.g> <8735qnax0o.fsf@evledraar.gmail.com>
Date:   Thu, 02 Sep 2021 11:22:52 -0700
In-Reply-To: <8735qnax0o.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Thu, 02 Sep 2021 15:29:33 +0200")
Message-ID: <xmqqy28ekfb7.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CA9BFD5A-0C1A-11EC-86B3-9BA3EF469F85-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Tue, Aug 31 2021, Junio C Hamano wrote:
>
>> * ab/gc-log-rephrase (2021-08-31) 1 commit
>>  - gc: remove trailing dot from "gc.log" line
>>  (this branch uses uk/userdiff-php-enum.)
>
> Is the dependency on uk/userdiff-php-enum a mistake? They combine just
> fine, but they don't have an inter-dependency.

It definitely is.

Thanks, will rebase on 'maint'.
