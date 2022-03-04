Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C26C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 21:30:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbiCDVbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 16:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiCDVbW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 16:31:22 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA120340FC
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 13:30:33 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7BF96179313;
        Fri,  4 Mar 2022 16:30:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QoZzt/9ckxU7c2jwhR7LlN5Pbevx9ioWKM4Ze1
        tbZNs=; b=yZMW0/F1PrejB64otzhmzAB+vvllHYRR2Ie9m13KmISHel+KjomMV2
        XUDrgkxvc/pNJ5oHpXGQIbtDFqBkf1Fb8Hps7o6fEaO5R4S/W3qHbmeDdU8tu9HG
        4aXY6w+Djv84Wt3uhYMhzOKQ72uPArAcjmChiFp8fc7ygaKu36Tj0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 7452A179312;
        Fri,  4 Mar 2022 16:30:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 00343179310;
        Fri,  4 Mar 2022 16:30:30 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Emily Shaffer <emilyshaffer@google.com>, git@vger.kernel.org
Subject: Re: log messages > comments
References: <20220126234205.2923388-1-gitster@pobox.com>
        <20220127190259.2470753-4-gitster@pobox.com>
        <YiFY693P6E/eVS3k@google.com> <xmqqr17i5zlu.fsf@gitster.g>
        <220304.86ilsuf1e8.gmgdl@evledraar.gmail.com>
        <xmqqk0d91p5s.fsf@gitster.g>
Date:   Fri, 04 Mar 2022 13:30:29 -0800
In-Reply-To: <xmqqk0d91p5s.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
        04 Mar 2022 11:41:19 -0800")
Message-ID: <xmqq4k4d1k3u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 51571D8A-9C02-11EC-86A0-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I also do not think things like "'We used to do X here but we do Y
> because ...' does not belong to in-code comment, but to log message"

Sorry for too many nagations.  "I also do not" -> "I also do".
