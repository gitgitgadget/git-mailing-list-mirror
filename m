Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D374C433E0
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3666B2075F
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 18:25:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GLRN54t1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727016AbgG2SZe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 14:25:34 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59465 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgG2SZe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 14:25:34 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0811361EB8;
        Wed, 29 Jul 2020 14:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fKzgbCj77nI6vYXpFI7Ys4kmXDk=; b=GLRN54
        t1/nyGIaQjI4o0dWwxPgQCh/RrtG0t88/fO9YsL+DRpUhDks+SHpp89IRm6D5aJX
        +XNSbPvzstuF4mFiUswkITbT7QeeIDzL8AtXuSumJ0Tdke1mAO2xeTq5Gnc6Su/C
        Ebv96yFY/y9lGAgAoM9C12m/GSFJJOKRsdevk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=YPKEgmiKTzfIJuAP42NJMwFk5sTR2bbc
        4mgldYPjFn1NBCL+lYkhpfKRENg9VIklf/V7rahSinJO8JlPbwnBajkTNj1xqHwi
        ZZ/JhiwAolEOP46dOl2a7cTswUowNIX0GgU3Z/KtKHznRM2DtKZ0kaAveHRUlNro
        YIyPKaYiPX0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 00A7561EB5;
        Wed, 29 Jul 2020 14:25:32 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 81DDB61EB3;
        Wed, 29 Jul 2020 14:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Carmen Andoh <candoh@google.com>
Cc:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: 24 hours to respond with date/duration preferences for inclusion summit
References: <CA+TwhoKBYwUKmtQTyiocPWJD=KeZQryS+6Q8JKxKgLEy0qJwAw@mail.gmail.com>
        <20200726040226.GA19030@dcvr> <20200727151023.GB62919@syl.lan>
        <20200728100726.GA24408@dcvr> <20200728162528.GH87373@syl.lan>
        <6b4b3f77-a479-4d7b-d7c2-e3e35e658ac7@gmail.com>
        <CA+TwhoJqm-EB6OkLOr6+B4RZfaQ7aVde+hSrSeWV-jYkfBLGNg@mail.gmail.com>
Date:   Wed, 29 Jul 2020 11:25:30 -0700
In-Reply-To: <CA+TwhoJqm-EB6OkLOr6+B4RZfaQ7aVde+hSrSeWV-jYkfBLGNg@mail.gmail.com>
        (Carmen Andoh's message of "Wed, 29 Jul 2020 13:00:00 -0400")
Message-ID: <xmqqzh7i9o11.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E2B63226-D1C8-11EA-A116-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Carmen Andoh <candoh@google.com> writes:

> Hello All,
>
> Just a reminder that you have another day to respond to whenisgood
> [1].  Note that times are listed as 6AM-9PM (21:00) Pacific.  Please
> specify duration preferences ( half days, full days, etc)  in
> comments.  Hopefully we'll respond soon after that with date/s that
> works for most.

Sorry for sending this on the last day. 

After re-reading the original announcement and the above part, I am
wondering if responding to the "when is the good time for you?" poll
is a requirement to be invited.  My tentative understanding is that
this is merely to help resolove scheduling conflicts, and those who
want to attend but have no particular time/date preference can just
stay silent and wait for the invitation to come, to which they are
required to respond via e-mail in order to attend.

I suspect many people are wondering about the same thing and
a bit of clarification may help.

Thanks.
