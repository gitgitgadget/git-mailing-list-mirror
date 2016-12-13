Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DA8262042F
	for <e@80x24.org>; Tue, 13 Dec 2016 16:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933403AbcLMQNp (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 11:13:45 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51489 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752932AbcLMQNh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 11:13:37 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AA08D54DBE;
        Tue, 13 Dec 2016 11:13:36 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LMu0LSjcYVkolU0jeV7/1hiB7wg=; b=uLQ24F
        9f5fD32v+smkO3hBDDTYPlgrCWZZEWJnSIflNedo1PHjLluuI1RUIqq2Ch6IzsGt
        24FkX5TOEdhcSYO7rVziHPP88wdK0F0KHlnKGM4izHSp/1SczdiiTD4Pp4Dfmb7m
        Cetp3B8y9rvTieNCYy7Wmav86ho1flQ2ZCmsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c89YWSMIRc3/+pZIrjYzAg7FqqfCI1h6
        OGuWZW6SUQ5fjXsxUBBXSEsGatVKB8sUXojO54jhD2aKm7PTXz/Qmrm2ZMnpBcLM
        oRLhEp8p9ZutvI8wfNcYFItBAYXpi+w5z3j18l8QkRtlKAXz9/dRC44MM+0yXkfh
        LMQs1TB1WZA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A27B154DBC;
        Tue, 13 Dec 2016 11:13:36 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1732754DB9;
        Tue, 13 Dec 2016 11:13:36 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2016, #02; Mon, 12)
References: <xmqqoa0g96o3.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1612131641291.23160@virtualbox>
Date:   Tue, 13 Dec 2016 08:13:34 -0800
In-Reply-To: <alpine.DEB.2.20.1612131641291.23160@virtualbox> (Johannes
        Schindelin's message of "Tue, 13 Dec 2016 16:42:21 +0100 (CET)")
Message-ID: <xmqqinqn6c41.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19D1855A-C14F-11E6-842F-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  While I think it would make it easier for people to experiment and
>>  build on if the topic is merged to 'next', I am at the same time a
>>  bit reluctant to merge an unproven new topic that introduces a new
>>  file format, which we may end up having to support til the end of
>>  time.  It is likely that to support a "prime clone from CDN", it
>>  would need a lot more than just "these are the heads and the pack
>>  data is over there", so this may not be sufficient.
>> 
>>  Will discard.
>
> You could mark it as experimental, subject to change, and merge it to
> `next` safely.

Are you planning, or do you know somebody who plans to use that code
soonish?  Otherwise I'd prefer to drop it---at this point, the series
is merely "just because we can", not "because we need it to further
improve this or that".
