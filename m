Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9373C433F5
	for <git@archiver.kernel.org>; Thu,  2 Dec 2021 18:42:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242418AbhLBSpx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Dec 2021 13:45:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52744 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229950AbhLBSpw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Dec 2021 13:45:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5A021E9A28;
        Thu,  2 Dec 2021 13:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LgFtQPDecBV3UB2ItwadYYILA85WfOcNPItsHa
        HTb7E=; b=b6/plF4ZArLWAJj8nQBPsWhllacON/8iYLJiKkVx10IsyJ0nG6V2jd
        YloxFzkn8B3ceza05dRblUynsRoUiO6UhPrAeA3luRREV/fmvIhMYxR0dCl+G57t
        hXnvFjlvWllnOceVpWNHroMxCHpT9QMtZzmWgLJOkOxEBWSYotb8o=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 502E9E9A27;
        Thu,  2 Dec 2021 13:42:29 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id AD292E9A26;
        Thu,  2 Dec 2021 13:42:28 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIg?= =?utf-8?B?QXJuZmrDtnLDsA==?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "Theodore Ts'o" <tytso@mit.edu>, Matt Rogers <mattr94@gmail.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v9 00/17] Upstreaming the Scalar command
References: <pull.1005.v8.git.1637363024.gitgitgadget@gmail.com>
        <pull.1005.v9.git.1638273289.gitgitgadget@gmail.com>
        <211130.86mtlleqhm.gmgdl@evledraar.gmail.com>
        <nycvar.QRO.7.76.6.2111301450030.63@tvgsbejvaqbjf.bet>
        <xmqqtufs1a39.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2112021549330.63@tvgsbejvaqbjf.bet>
        <xmqq1r2vvszo.fsf@gitster.g>
        <CABPp-BGaHHUuQqvvDLBSaRG7C=SzS-ykOLi4HCdDDXQHgHjmJA@mail.gmail.com>
Date:   Thu, 02 Dec 2021 10:42:27 -0800
In-Reply-To: <CABPp-BGaHHUuQqvvDLBSaRG7C=SzS-ykOLi4HCdDDXQHgHjmJA@mail.gmail.com>
        (Elijah Newren's message of "Thu, 2 Dec 2021 09:39:12 -0800")
Message-ID: <xmqq35navofg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 99D37B22-539F-11EC-9600-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> while I think CI testing would be nice once we have a functionally
> useful scalar, the CI tests of this early version aren't really
> netting us anything.  And they're blocking future scalar series
> unnecessarily.  Johannes already said he had planned CI testing for a
> future series, so I'd rather just take this version of js/scalar minus
> the CI integration for next.)

Yeah, with less stomping on each others' toes, things may flow
smoother.  As long as people are happy with the core part, that
sounds like the best approach forward.

