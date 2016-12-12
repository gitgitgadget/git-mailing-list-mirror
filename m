Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70F2D206A4
	for <e@80x24.org>; Mon, 12 Dec 2016 19:05:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752941AbcLLTFR (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Dec 2016 14:05:17 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61611 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752379AbcLLTFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2016 14:05:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76BAE5559E;
        Mon, 12 Dec 2016 14:05:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=OuZWvu/M61e2EBret7IJFAYtX4A=; b=W3B6cH
        2ZhhMnPbn7q6ljvkhnN9DuhfIvD0xaNc/TL+fvUrVzcli2mUvSS7NxxyQ3HdQQPF
        BT+J7HQEH+o5yzmlzKonOXt4qkEIfv4i7rrWptDWg5s+yTl/8q0XGD5g+cGoLgfh
        xlrVqXmYpuGILJqLOZc2vMpA22riBuvGsi23M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LUjGZXWyf3kD+gpzJVGFXYnF8ROT6YdD
        3U2qr0ZbGFjZJrwPmmo9+tPIyMBjd8bSvEQP48edIRDZP22c5wFxWA0QNYhQGYoR
        F5mVpmWCgHXv4MYyeuI3TADM1+hhpjHMN+8GzkfU2ICDFnpFvGGBKCqaqNNL1UDB
        N9vZriJivv8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 67A425559D;
        Mon, 12 Dec 2016 14:05:15 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC8155559C;
        Mon, 12 Dec 2016 14:05:14 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Luis Ressel <aranea@aixah.de>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] date-formats.txt: Typo fix
References: <20161212164502.6187-1-aranea@aixah.de>
Date:   Mon, 12 Dec 2016 11:05:13 -0800
In-Reply-To: <20161212164502.6187-1-aranea@aixah.de> (Luis Ressel's message of
        "Mon, 12 Dec 2016 17:45:02 +0100")
Message-ID: <xmqqeg1dm0ie.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9F91B60-C09D-11E6-9BA6-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Luis Ressel <aranea@aixah.de> writes:

> Last time I checked, I was living in the UTC+01:00 time zone. UTC+02:00
> would be Central European _Summer_ Time.
>
> Signed-off-by: Luis Ressel <aranea@aixah.de>
> ---
>  Documentation/date-formats.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, will queue.

> diff --git a/Documentation/date-formats.txt b/Documentation/date-formats.txt
> index 35e8da201..6926e0a4c 100644
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
