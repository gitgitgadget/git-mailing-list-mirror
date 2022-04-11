Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B3BC433FE
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 18:09:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349087AbiDKSLa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 14:11:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349072AbiDKSL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 14:11:28 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D80F395
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 11:09:11 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E7B43127C9C;
        Mon, 11 Apr 2022 14:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Out13Fk4Ay950Z4FLvxUc4KoJO6UDUwskuJd2Y
        z9/oI=; b=gG2Ds+wsL7ocaiXH06pMf8YVVem4OvwCDd74dxeSHiW3cUxn+DNSAe
        XFmBcwqwmCwpmO9JT8O6ykJjHWNTBH3EoDbW7vX2Z5X1/5u1swN8TCeT10XzvT2Z
        x/haKNv8Gmn2YdkbpemmlRpELlE0idIIQtV6/+BLOqt3eWba5UJkk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D7CE3127C9A;
        Mon, 11 Apr 2022 14:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.185.214.157])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1DC46127C99;
        Mon, 11 Apr 2022 14:09:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        rsbecker@nexbridge.com,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        jurgen_gjoncari@icloud.com, git@vger.kernel.org
Subject: Re: Make commit messages optional
References: <7ED89912-2E10-4356-9C61-14B90EC0719C@icloud.com>
        <YlC3devsgmv17PnQ@camp.crustytoothpaste.net>
        <00ca01d84ba0$dd7ee0c0$987ca240$@nexbridge.com>
        <20220409113244.GX163591@kunlun.suse.cz>
        <CAPMMpoi50j7MzrsokQAcBWBgj8qGPN=j68PuEsppv629Oh7GHg@mail.gmail.com>
        <220411.861qy3khkk.gmgdl@evledraar.gmail.com>
        <CAPMMpohNYizpbqerAuFZnSY9mFsTJEJbfFWNGY41GcHxdwGrew@mail.gmail.com>
Date:   Mon, 11 Apr 2022 11:09:07 -0700
In-Reply-To: <CAPMMpohNYizpbqerAuFZnSY9mFsTJEJbfFWNGY41GcHxdwGrew@mail.gmail.com>
        (Tao Klerks's message of "Mon, 11 Apr 2022 14:39:12 +0200")
Message-ID: <xmqqzgkrijb0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7BB8E562-B9C2-11EC-ABBC-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

> Several discussion participants noted they use garbage rather
> than empty just to avoid typing so much...

It is a positive thing, isn't it?

If they consistently use greppable garbage, that may serve as even
better reminders that they need to revisit and clean them up later.
