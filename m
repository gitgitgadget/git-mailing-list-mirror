Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22BB20899
	for <e@80x24.org>; Wed,  9 Aug 2017 05:37:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751314AbdHIFh5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Aug 2017 01:37:57 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53216 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750770AbdHIFh4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Aug 2017 01:37:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CC24BA0602;
        Wed,  9 Aug 2017 01:37:50 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=F9tOkkCXR0/orcBYAkdtV9cjOeQ=; b=nlubzS
        bFmUJjEYvpebB6HvQpJTjjEJa6Eg3uZXgUkklcuVq74rrOjK/oLm+eXuJ4XDeJPM
        rjfC4W4pUr4Tp3WueAD+8pOpeT1kXPaauEN3dCn007uQyQTM2brlGmF0rHVkDxqU
        ksAoE6WIUghgvP+D5YClOLUXzYbY0/bUTe91E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=PbXbBjx55QWUjIUj53RrJytJdIIAmqT4
        l31r0+4mosylPYl9nQ1mLLp3zgMsw/mwyzlmJGeqQwgjHnVjanYtMFlJqmPS4xQu
        CJR0h8GYki3tXb1UKq8/FnKfZv/Qo2MDpLz/+wL7vdl55UNBAlgRc3HoafKXMGsl
        +uLKSnIzLYk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C4D83A0601;
        Wed,  9 Aug 2017 01:37:50 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3CB01A0600;
        Wed,  9 Aug 2017 01:37:50 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/add: add a missing newline to an stderr message
References: <4b0d092f-5a1b-73c7-38fe-48455099bcff@ramsayjones.plus.com>
        <2821200b-0428-a5dd-9680-f291cee0ec47@web.de>
        <xmqqefslaerf.fsf@gitster.mtv.corp.google.com>
        <20170808223407.GB169894@aiede.mtv.corp.google.com>
Date:   Tue, 08 Aug 2017 22:37:48 -0700
In-Reply-To: <20170808223407.GB169894@aiede.mtv.corp.google.com> (Jonathan
        Nieder's message of "Tue, 8 Aug 2017 15:34:07 -0700")
Message-ID: <xmqqlgmt8fo3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E1D8EEEA-7CC4-11E7-B80E-9D2B0D78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> I don't believe the force_mode without an 'x' provides a clear signal
> to the end user.  Perhaps you meant %cx?

Indeed you are right.  I think I saw Ramsay's v2 that has the 'x',
so let's use that version.

Thanks.
