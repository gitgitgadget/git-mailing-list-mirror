Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E552A1FF7F
	for <e@80x24.org>; Wed,  7 Dec 2016 23:43:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932824AbcLGXnN (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 18:43:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:57201 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932522AbcLGXnL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 18:43:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 10023570C9;
        Wed,  7 Dec 2016 18:42:37 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=+MCAhHmIdhANIG0aKBQ0tMCu3jQ=; b=Q3Cczy
        AO+NKfOmfI4WS6gmFueT+eyfbiK5cp54KStOkQ1u75PRDGceE3pLFesvq7iL5m2T
        ZWc9UUkWDP44m68HQPra4vqFDDb3sIfuF/z99WbTtpf0A/er0wp0wjeUb02Oqee4
        IVqQKoQ746/Hx4qLqxY5Ndj1Puf+mtDHScoyc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=BdCltM9Wcr7+RvA1nGKMYeD2roh4Bn8L
        AcHAk2NAAmTGU0NRCpkKV3BEgt8Tw1yrACx4+Ve3suJQet5JY+/3yyS4QO9XMy1q
        JhwDd1ur81LJ57lvGwYRSPvHlTtT8mpooEYKXXU5EMAQtTF/DE8/Alih+WFVa6vp
        0lTgUbMtssg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 08A03570C7;
        Wed,  7 Dec 2016 18:42:37 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C8DE570C6;
        Wed,  7 Dec 2016 18:42:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 0/6] shallow.c improvements
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
        <20161206125339.16803-1-pclouds@gmail.com>
        <20161206134212.mttcb75dov2jvqu5@sigill.intra.peff.net>
        <CACsJy8A=KeGsXAt6ZR-eOkTurSsnYPkt3yTfkYT9aZ86rV1rYg@mail.gmail.com>
Date:   Wed, 07 Dec 2016 15:42:35 -0800
In-Reply-To: <CACsJy8A=KeGsXAt6ZR-eOkTurSsnYPkt3yTfkYT9aZ86rV1rYg@mail.gmail.com>
        (Duy Nguyen's message of "Tue, 6 Dec 2016 20:47:36 +0700")
Message-ID: <xmqqa8c7ux04.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5138F34-BCD6-11E6-8BA0-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Dec 6, 2016 at 8:42 PM, Jeff King <peff@peff.net> wrote:
>> The final one _seems_ reasonable after reading your explanation, but I
>> lack enough context to know whether or not there might be a corner case
>> that you're missing. I'm inclined to trust your assessment on it.
>
> Yeah I basically just wrote down my thoughts so somebody could maybe
> spot something wrong. I'm going to think about it some more in the
> next few days.

In the meantime let me queue them as-is.

Thanks.
