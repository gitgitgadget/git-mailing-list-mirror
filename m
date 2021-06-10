Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A83C48BCF
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0DE7613BC
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 02:03:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbhFJCFc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 22:05:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61131 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhFJCFc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 22:05:32 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3F4BFC93FF;
        Wed,  9 Jun 2021 22:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kiJSNx/yt0Eu
        wTHH1e18BSaKlioXvr8/24Z4gLhEzQ0=; b=qx+RsxFigrHX5u6mQX9cIo7ukdD2
        3P8XG2oYH9pfdo2DfXYw8JtuJqPjzej8VTS0LIdXJQ4M5Na4EKKIec3o68vJvOSc
        oC+8ODSeK6M/4llw7KmYd+MGgInbZlhkYdOvWXf//Zs5dQBeOvk8ncKV1yJcyPC2
        Ygt8btgOqPG5GG8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 34FC6C93FE;
        Wed,  9 Jun 2021 22:03:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B344AC93FD;
        Wed,  9 Jun 2021 22:03:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        stolee@gmail.com, jrnieder@gmail.com, emilyshaffer@google.com,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Robert Karszniewicz <avoidr@posteo.de>,
        Jeff King <peff@peff.net>,
        "Kerry, Richard" <richard.kerry@atos.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2 0/4] Use singular "they" when appropriate
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
        <pull.975.v2.git.1623246878.gitgitgadget@gmail.com>
        <87a6nz2fda.fsf@evledraar.gmail.com>
Date:   Thu, 10 Jun 2021 11:03:35 +0900
In-Reply-To: <87a6nz2fda.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 09 Jun 2021 17:44:59 +0200")
Message-ID: <xmqqsg1qh3wo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 10B2D304-C990-11EB-A846-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> + When it becomes awkward to stick to this style prefer "you" when
> + addressing the the hypothetical user, and possibly "we" when
> + discussing how the program might react to the user.

Because I still get a funny feeling whenever I see a singular they,
which I was taught to be ungrammatical in my foreign language
classes long time ago, I kind of like this approach better, if we
can pull it off.

I wonder if we can avoid third-person entirely, though.
