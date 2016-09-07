Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8B9E12070F
	for <e@80x24.org>; Wed,  7 Sep 2016 19:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755335AbcIGT6r (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 15:58:47 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60074 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753696AbcIGT6I (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 15:58:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2E7C938D54;
        Wed,  7 Sep 2016 15:58:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=bOplq7OKLQNfAmTPo7HbpOYoNCo=; b=W5/od4
        RotCUKogyIoC+8TlWkqmuySJ7fzQuoIlRnbUOzRB7YoYkU7Lq3iXdNdxvHywIx1a
        ZW7mOKnLaeolJS2R0bRIQVboNkULXDO+tINqkfoye28qmao225ddVeimis/tGjiA
        Kuhxac5wPKMLuCrutJicZ4IDhY54BQAuZFh2M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=fpJM7S25wCVeSgdk4ENBlt5qbdeLK9Q5
        DMPPghDZuiC4ujqIPiL7PgHINUNZk+0KxJfe6RX/2GxKOs/6EFvFJRwUBm6qNDzK
        Yj+pO7jZ5nVWe3O5+ziJENEOh17xZ1qtuS0YmUiCEm+guc6okKu1q8nPPjhw3OtK
        1FYwKeez9Xw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2656838D53;
        Wed,  7 Sep 2016 15:58:07 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 9E24B38D52;
        Wed,  7 Sep 2016 15:58:06 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] t5550-http-fetch-dumb.sh: use the GIT_TRACE_CURL environment var
References: <20160905102444.3586-1-gitter.spiros@gmail.com>
        <20160905102444.3586-4-gitter.spiros@gmail.com>
        <CAPig+cTsCDpCQ9j82OEa13YBYswDKfYd_dc1QbxRSRk3wiOhHw@mail.gmail.com>
        <CA+EOSBki1E8HJ1DMuAuQaB6sBcUjvQLA5xUWdF9G+6+HRQUD7g@mail.gmail.com>
        <xmqqpoofmuru.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 07 Sep 2016 12:58:04 -0700
In-Reply-To: <xmqqpoofmuru.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 07 Sep 2016 11:25:57 -0700")
Message-ID: <xmqqeg4vlbxv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 64D24910-7535-11E6-8D1A-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>>>> +       cp expect expect.$$ &&
>>>> +       cp actual actual.$$ &&
>>>> +       cp output output.$$ &&
>>>
>>> What are these three cp's about? They don't seem to be related to the
>>> stated changes. Are they leftover debugging gunk?
>> Yes, i am very sorry. My bad. I will repost. Thanks
>
> Nevertheless, thanks for these clean-ups.  Will discard this round
> waiting for a reroll.

Nevermind.  I see you rerolled only this one labeled as "v1 3/4";
picked up the rest from this series and combined with that reroll.

Thanks.


