Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D97792022D
	for <e@80x24.org>; Sat, 25 Feb 2017 08:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751577AbdBYIbZ (ORCPT <rfc822;e@80x24.org>);
        Sat, 25 Feb 2017 03:31:25 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:34039 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751419AbdBYIbY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2017 03:31:24 -0500
Received: by mail-pg0-f66.google.com with SMTP id s67so6055490pgb.1;
        Sat, 25 Feb 2017 00:31:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=V568f+JcVhAAZZbO4yb9JH0d6+0QfyP6GbTnZEB12tI=;
        b=nrvVuifj7ABa7Au9dQqSrGF/Yy656ucsfkXB9gJDC7NWG7rXG+QBCjApq3Lo7COXA2
         SGnD+n4LlTBvPWGktzLCeK/9oBUZx0Ao3L5JWMRxa5VCUeAz1Tv03tG8q8zcU3zqELeS
         fBKaOYTsQ4XwSb1n8DdA0VYSRZoi9LsXknJWDXftwBu4iRNGhXKy6yyalq1cSsctGQcI
         t+SUiu4XTFTu1B1MmPutc8rQ7tStFZBXqqgERINlnaK9zrynxXxV6v/hZDvdwHrYdykR
         nJgQIkY7GJy7ff0wIlwJn8yM255hvtMI8UFzm+H2vXv5iPFU8/hKmcSO2zAxltqjPvFn
         UwcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=V568f+JcVhAAZZbO4yb9JH0d6+0QfyP6GbTnZEB12tI=;
        b=eQIipaD/G1a8EpBcirHQRCOXLdRNxEAduGTETEZ6RGvqPKFwNM4jut8CG7clo7o0xT
         vajdi5BoWqghR2zDL5pCIhxUEDKna9zeO561PV79Hq2JDjVlneFRYwv9NvHbKgiJxDsM
         s/eD2zbOZk5XW9Wqbd/4NUbRDQ0cIZIicdHLC74wROUxq8+bUsT1OYF1WeA39Y3JVP+X
         /PoHF+ND3nEBb2TXJxcQu3P9Vnppq+Qed9jv1DOyXUv2VAHnVfxIS3Ueqsh+b13/dQiv
         I/wR36bzR1VOt3Ybto2XHVyqh0JywFFrqAcZ6Sp9QvVSAMbVWy7FhGqYjBCNZa5+xi3h
         r21A==
X-Gm-Message-State: AMke39nZPCUQHD2P8CzI2ZTc2yFmgrjIiKdsPx8mCxBthtbGiF7YG4wNeqjS5vSAp9YzWA==
X-Received: by 10.98.144.22 with SMTP id a22mr8725375pfe.160.1488011483873;
        Sat, 25 Feb 2017 00:31:23 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:f06c:2e0c:850d:31b4])
        by smtp.gmail.com with ESMTPSA id y187sm19013705pfy.123.2017.02.25.00.31.21
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 25 Feb 2017 00:31:22 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     git@vger.kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] Git v2.12.0
References: <xmqqd1e72xs5.fsf@gitster.mtv.corp.google.com>
        <20170225074057.GA460@1wt.eu>
Date:   Sat, 25 Feb 2017 00:31:21 -0800
In-Reply-To: <20170225074057.GA460@1wt.eu> (Willy Tarreau's message of "Sat,
        25 Feb 2017 08:40:57 +0100")
Message-ID: <xmqqefymzn6u.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Willy Tarreau <w@1wt.eu> writes:

> Hi Junio,
>
> On Fri, Feb 24, 2017 at 11:28:58AM -0800, Junio C Hamano wrote:
>>  * Use of an empty string that is used for 'everything matches' is
>>    still warned and Git asks users to use a more explicit '.' for that
>>    instead.  The hope is that existing users will not mind this
>>    change, and eventually the warning can be turned into a hard error,
>>    upgrading the deprecation into removal of this (mis)feature.  That
>>    is not scheduled to happen in the upcoming release (yet).
>
> FWIW '.' is not equivalent to '' when it comes to grep or such commands,

I am amused and amazed ;-).  

The above is not about "grep" but was meant to describe "pathspec".
We used to take "" as a pathspec element that means "every path
matches", but recently started deprecating it and ask users to be
more explicit by using "." (as a directory as a pathspec element
matches everything inside the directory).  We are not changing the
pattern matching done by "git grep" or "log --grep".  What is
changing is that between the two that means the same thing:

	cd t/ && git log ""
	cd t/ && git log .

the former is deprecated.

I find it amusing that I have been writing the above in the draft
release notes without realizing that I failed to say that it is
about pathspec for quite some time, and without realizing that the
above can be misinterpreted as if it is talking about grep patterns.

And I find it amazing that it took this long for somebody to spot
that misleading vagueness in this description and point it out.

It should probably be updated to start like so:

	Use of an empty string as a pathspec element that is used
	for 'everything matches' is ...

Thanks.
