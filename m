Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E696C1FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 18:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751990AbcK1SGy (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 13:06:54 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63131 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751432AbcK1SGx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 13:06:53 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 99578527FC;
        Mon, 28 Nov 2016 13:06:52 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=l09wN0LBiIvpCcOhFFez6PfzMTc=; b=dkd07k
        UflYuC27FnYmE0LiUrM6htyumF3IqWqSilcdT/BwqhviPKzVHbGaPIQ2QS4+hpTr
        4Rm5u9bRrX8S/BLRQG+H2GrQgPSb4zRBG8h+uOaBROYro0Q6RYnLfLqHpovKu7k6
        idBt9UVN6Fcb1onR8thywORJD+dZsxL2SeNzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UscUw+fIcRtsIqtkF9uzEW0x1S5UJQU+
        Jnf36iWqgP/CoKvcaugQAZ6Pb7nlCClI9xl5Kt5oh5UTuf7wizfU6I4ePQqdEweK
        o6cmAsE8uTYvehjmGZZNK4/+Af3NE6/CIRo30+9HK2IcP2ffKP405ozS70WlUUpD
        HCGpyocH9w8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F96D527FB;
        Mon, 28 Nov 2016 13:06:52 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 06730527FA;
        Mon, 28 Nov 2016 13:06:51 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luis Ressel <aranea@aixah.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] date-formats.txt: Typo fix
References: <20161125173657.9656-1-aranea@aixah.de>
Date:   Mon, 28 Nov 2016 10:06:50 -0800
In-Reply-To: <20161125173657.9656-1-aranea@aixah.de> (Luis Ressel's message of
        "Fri, 25 Nov 2016 18:36:57 +0100")
Message-ID: <xmqqvav7jx6t.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 705084E6-B595-11E6-9803-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luis Ressel <aranea@aixah.de> writes:

> Last time I checked, I was living in the UTC+01:00 time zone. UTC+02:00
> would be Central European _Summer_ Time.
> ---

Thanks; please sign-off your patches, even a trivial ones like this.

>  Documentation/date-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
> index 35e8da2..6926e0a 100644
> --- a/Documentation/date-formats.txt
> +++ b/Documentation/date-formats.txt
> @@ -11,7 +11,7 @@ Git internal format::
>  	It is `<unix timestamp> <time zone offset>`, where `<unix
>  	timestamp>` is the number of seconds since the UNIX epoch.
>  	`<time zone offset>` is a positive or negative offset from UTC.
> -	For example CET (which is 2 hours ahead UTC) is `+0200`.
> +	For example CET (which is 1 hour ahead of UTC) is `+0100`.
>  
>  RFC 2822::
>  	The standard email format as described by RFC 2822, for example
