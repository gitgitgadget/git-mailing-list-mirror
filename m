Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DC7511F4C0
	for <e@80x24.org>; Fri, 11 Oct 2019 04:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbfJKEjc (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 00:39:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62035 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbfJKEjb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 00:39:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4FA2525451;
        Fri, 11 Oct 2019 00:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=rUN2J4D31Hv5egHpEFNMu+MdbKA=; b=n3+cD1
        T29XVbGx3T3a88d0F2j9vQSDJLnoDa5RfKdLuHjby/2QLyD6HioANLBnKtFsEpaw
        UkPbtoa3cjZBREykV2prGfCFH1+29gpsR6HbCEsTCjiwpnYlpa578bypUsQL78K3
        +MmtG9p/c9NxBs94cmu2pu/NZHe6I4Vvrt02I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
        :references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SoQ8UIWOjmqAN0HKEjYW73KHC8yJ/nGp
        fJxa6FImmccdhOmQZ50aU4SPHEppfx3ZCS3Dn2qGIY7pIbCvqlGTZacszKjE02Tz
        sd6uwGLd4wUFJBNoAVq8Eqn79OI1Xx9TMPoxPvGpdKBAiyuBrJtz+gI8Lyq8w8Yn
        00c2con7D9I=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4324925450;
        Fri, 11 Oct 2019 00:39:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A4C4B2544F;
        Fri, 11 Oct 2019 00:39:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru cracks
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet>
        <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com>
Date:   Fri, 11 Oct 2019 13:39:28 +0900
In-Reply-To: <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com> (Junio
        C. Hamano's message of "Wed, 09 Oct 2019 09:14:59 +0900")
Message-ID: <xmqq7e5bj3pb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1D8463E2-EBE1-11E9-B06A-C28CBED8090B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> ... but I'd still wait for a few
> days for people who expressed their Acks but your scan missed, or
> those who wanted to give their Acks but forgot to do so, to raise
> their hands on this thread.

Now, two days and four hours have passed, so I'll merge the result
to 'next' (and thusly this poll is now closed).

Thanks, all.
