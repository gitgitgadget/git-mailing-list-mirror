Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FCC01F4F8
	for <e@80x24.org>; Sun, 25 Sep 2016 23:31:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031137AbcIYXbI (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Sep 2016 19:31:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57141 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S941168AbcIYXbH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Sep 2016 19:31:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1F6D140A0F;
        Sun, 25 Sep 2016 19:31:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9A9qwE2MZBwI2HNemUmJbQvJNzE=; b=jtinmT
        fzQMTZBRQoSE4vYbjvzURNygnWS6qEskENzLW0OacHELd1xoAS4Q4vUa7kmAoc0B
        iqbJfVG2J3mC8M+Jj7kpLnXHRKIUrADjLi+AThm9RDKRq0i0RbJiOcLqEEeVMuwp
        J2v3NmiWPIMe0T4xS5SVEqbNeVAviSXDFpB04=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WEhGikyfBexoOfAXdkWt9VAmcPlPyv4p
        YUUt794cNYiMNFR5zeSUQ1M6WWFla5A6UYUEhptiT4nQB0/Kg6KhlYqGmj1IhgEK
        MBWgPR089ybsPxzv+acaCsCHJmAC+7iZ70oMn5Bonf+ds5Y8lnJ7lFSWux6VLw0j
        7G28GUxpbUU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 177AF40A0E;
        Sun, 25 Sep 2016 19:31:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8C02D40A0D;
        Sun, 25 Sep 2016 19:31:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Vasco Almeida <vascomalmeida@sapo.pt>
Cc:     git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH v2 00/11] Mark strings in perl script for translation
References: <1472646690-9699-1-git-send-email-vascomalmeida@sapo.pt>
        <xmqqtwe026p9.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 25 Sep 2016 16:31:03 -0700
In-Reply-To: <xmqqtwe026p9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 31 Aug 2016 10:23:30 -0700")
Message-ID: <xmqqponrwo94.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2117C1E0-8378-11E6-81C2-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Vasco Almeida <vascomalmeida@sapo.pt> writes:
>
>> Mark messages in some perl scripts for translation.
>>
>> Since v1, adds brackets so parameter grouping of sprintf parameters is easier
>> to see.
>>
>> Interdiff included below.
>
> Thanks; it is way too late for this cycle for i18n so I won't be
> picking the series up right now.  Please ping me if you see me
> forget to pick it up in a week after 2.10 final gets tagged.

I'll queue this round on 'pu' (if there aren't too heavy conflicts,
that is) and let the interested parties continue reviewing and
discussing.

Thanks.
