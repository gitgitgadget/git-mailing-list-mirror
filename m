Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E824C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:51:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64EEE60EB6
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 17:51:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhINRxD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 13:53:03 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:52629 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbhINRxC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 13:53:02 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 02059147DA3;
        Tue, 14 Sep 2021 13:51:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qVVdILLnL1IiwQwGoFs/W2RfaOqVHetOTHBsGi
        ivD6s=; b=AQCc3q39QvS+JjzlFlVyskGHYIH18+1CNcVyL73WTHbowK+Gm3sYfO
        BauFWt2MNZ9926o6CS+G54f26jOo/LjsqO3ooqb4HjqvOiOATYTwqk/r3+5pusah
        9Tv1sbk/WPIVNPJBgcPJ8ceDHoTZnmttMljOkc2NTqw/2mErv39RE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDCE0147DA2;
        Tue, 14 Sep 2021 13:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 6B602147DA1;
        Tue, 14 Sep 2021 13:51:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v4 00/15] Upstreaming the Scalar command
References: <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com>
        <pull.1005.v4.git.1631630356.gitgitgadget@gmail.com>
        <nycvar.QRO.7.76.6.2109141709330.59@tvgsbejvaqbjf.bet>
Date:   Tue, 14 Sep 2021 10:51:40 -0700
In-Reply-To: <nycvar.QRO.7.76.6.2109141709330.59@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Tue, 14 Sep 2021 17:10:16 +0200 (CEST)")
Message-ID: <xmqq35q72ggj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6B78FAE4-1584-11EC-BD52-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi,
>
> On Tue, 14 Sep 2021, Johannes Schindelin via GitGitGadget wrote:
>
>> tl;dr: This series contributes the Scalar command to the Git project. This
>> command provides an opinionated way to create and configure repositories
>> with a focus on very large repositories.
>>
>> Changes since v3:
>>
>>  * Moved the "Changes since" section to the top, to make it easier to see
>>    what changed.
>>  * Reworded the commit message of the first patch.
>>  * Removed the [RFC] prefix because I did not hear any objections against
>>    putting this into contrib/.
>
> Forgot to say:
>
>   * Sent this out to reflect my latest state before taking off for two
>     weeks.

Thanks, will queue.

Have fun.
