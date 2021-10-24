Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D4C433EF
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 09:08:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CECBC60EB1
	for <git@archiver.kernel.org>; Sun, 24 Oct 2021 09:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhJXJK1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Oct 2021 05:10:27 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55839 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbhJXJK1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Oct 2021 05:10:27 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 128691017FF;
        Sun, 24 Oct 2021 05:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=sTjMNOQESd4ezHUn44eV8FGDVXdpD0V/rzHumk+070o=; b=A2Iq
        stiLeM0Xc2OZ8ALtUSFBHNGQxOPzemt+1dwo2XAqSgAcIrq+TqPY0T8arsCEIqsJ
        J1j4pUVtDpWow39aFmxfXuNW/fSj8xcqMXsF6gJwQaaMedOjoussK556Fi2+cBe0
        0SmAFiym81KhQttr3zIao1wtvaYz30e32JEC804=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 04A501017FE;
        Sun, 24 Oct 2021 05:08:06 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 580151017FD;
        Sun, 24 Oct 2021 05:08:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/6] git-sh-setup: remove "sane_grep", it's not needed
 anymore
References: <cover-0.6-00000000000-20211021T195538Z-avarab@gmail.com>
        <patch-6.6-556fa96dde7-20211021T195538Z-avarab@gmail.com>
        <xmqqwnm6ge7w.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2110221625570.62@tvgsbejvaqbjf.bet>
Date:   Sun, 24 Oct 2021 02:08:04 -0700
Message-ID: <xmqq1r4a6b9n.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E5F5121E-34A9-11EC-9AE8-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> For all other users, I think the above applies well, but the one in
>> filter-branch deals with end-user contents, so we cannot say
>> "contents of the tag cannot be binary".
>>
>> Not that I care about filter-branch too deeply ;-)
>
> You probably meant that you do not care about filter-branch too deeply?
> ;-)

I don't get it.  Not only I meant, I said so, didn't I?
