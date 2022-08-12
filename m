Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A5CC00140
	for <git@archiver.kernel.org>; Fri, 12 Aug 2022 16:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238779AbiHLQqh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 12:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234019AbiHLQqg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 12:46:36 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF498883DC
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 09:46:35 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5C6E51B03C1;
        Fri, 12 Aug 2022 12:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=2NhVkfF4f8m6
        RBlXPFXNUrMCtrj5TU5y1iecB8NE4Og=; b=Ur1hANnTqrQs37QrSqtcvilIpktK
        Q9DSBhW1pOwEtRFpKAh8JSD7Wd7jgdeGaYw0xZqrLRJVfrd/83i+mU/lLTfsxMmM
        N3y1C7gKsWkqt7J35qNBnDoGXTONG0MNPrFWA5tRdEpNegaWPFWUzWa+zUWL+GsL
        zOwYQcrMCTCOVxM=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 55E6C1B03C0;
        Fri, 12 Aug 2022 12:46:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id DAD651B03BF;
        Fri, 12 Aug 2022 12:46:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 01/20] git.c: update NO_PARSEOPT markings
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
        <20220725123857.2773963-2-szeder.dev@gmail.com>
        <220725.86mtcxp8ib.gmgdl@evledraar.gmail.com>
        <20220802173754.GA10040@szeder.dev> <xmqqsfmefjja.fsf@gitster.g>
        <20220803213430.GB10040@szeder.dev> <xmqq8rnuea60.fsf@gitster.g>
        <20220812152837.GC3790@szeder.dev>
Date:   Fri, 12 Aug 2022 09:46:30 -0700
In-Reply-To: <20220812152837.GC3790@szeder.dev> ("SZEDER =?utf-8?Q?G=C3=A1?=
 =?utf-8?Q?bor=22's?= message of
        "Fri, 12 Aug 2022 17:28:37 +0200")
Message-ID: <xmqqsfm1csux.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 51BF8B6A-1A5E-11ED-832E-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:

> On Thu, Aug 11, 2022 at 02:35:03PM -0700, Junio C Hamano wrote:
>> Yes.  I thought this series was mostly ready, except for a minor
>> nits in the way things are explained in the proposed log message
>> in [09/20].  How would we want to proceed from here?
>
> Please wait for the reroll.  v2 is getting along, ever so slowly, I
> think I'll be able to submit it over the weekend.  Thanks.

OK.  The original round looked mostly good to me overall and I was
wondering what the current status was.  Will wait.  No rush.

Thanks.
