Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F270F1F461
	for <e@80x24.org>; Tue, 20 Aug 2019 19:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730006AbfHTTB3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Aug 2019 15:01:29 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:59738 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729231AbfHTTB3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Aug 2019 15:01:29 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6F050871E0;
        Tue, 20 Aug 2019 15:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=DraeM6aF3qW+54vg7IbgeK9dUao=; b=rc6UM0
        TY46mWmreS5IEZ6aYNf3BN7euX743JvvgOw1WRM/rN42N1YssYt0DiRNplLM4TJH
        V5y7rlKy82yAD+TssmVF8TTn6Oy/oR8KVXOj24jN3UyNVx7QvNWHIBXqBReaeCB4
        XJbSVLla6YVNcYErE+MD5y7wDZEWU0SKAkrgY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=CA5kI6EepwQX1f2kUVl6EEUDGJXC+HH1
        QE0OI67zIlg1l0mcU+Mq6Y8f+KViP+O7Ql279MNA5z4LAXKVBbP4ipNyYs7EauZQ
        udE2pETHPzlPf4HUyAf1Rjm5N9FMbfdWiI5CEQvpt8yi6DwajJQXwWcIdL2TUska
        3BryjH1/WMI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4A278871DF;
        Tue, 20 Aug 2019 15:01:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5B573871DE;
        Tue, 20 Aug 2019 15:01:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>
Subject: Re: [PATCH 2/3] Doc: add more detail for git-format-patch
References: <cover.1566182184.git.liu.denton@gmail.com>
        <7619da962d1fc804392e3552fbd56bf4bc68ac38.1566182184.git.liu.denton@gmail.com>
Date:   Tue, 20 Aug 2019 12:01:21 -0700
In-Reply-To: <7619da962d1fc804392e3552fbd56bf4bc68ac38.1566182184.git.liu.denton@gmail.com>
        (Denton Liu's message of "Sun, 18 Aug 2019 22:37:37 -0400")
Message-ID: <xmqq1rxfveym.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E7CDA66E-C37C-11E9-B59B-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> Next, while we're at it, surround option arguments with <>.
> ...
>  		   [--start-number <n>] [--numbered-files]
> -		   [--in-reply-to=Message-Id] [--suffix=.<sfx>]
> +		   [--in-reply-to=<Message-Id>] [--suffix=.<sfx>]
>  		   [--ignore-if-in-upstream]
> -		   [--rfc] [--subject-prefix=Subject-Prefix]
> +		   [--rfc] [--subject-prefix=<Subject-Prefix>]
> ...
> ---in-reply-to=Message-Id::
> +--in-reply-to=<Message-Id>::

That is a good change, but if we are making this change while are at
it, I think we should fix it to read <message id>.  "Message-Id" is
a good spelling iff we are talking about the label on the left hand
side of colon in e-mail header, but in this context, we are talking
about the value to be placed on that header.

All the other multi-word placeholders in the SYNOPSIS section spell
the words as normal multiple words separated with whitespace in
lower case.  You'd also want to fix the spelling of Subject-Prefix
to <subject prefix> for consistency.

Thanks.

