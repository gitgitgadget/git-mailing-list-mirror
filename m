Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C00111F453
	for <e@80x24.org>; Tue, 25 Sep 2018 22:03:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725762AbeIZEMr (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Sep 2018 00:12:47 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51351 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725732AbeIZEMr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Sep 2018 00:12:47 -0400
Received: by mail-wm1-f66.google.com with SMTP id y25-v6so171516wmi.1
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 15:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=dENGSSrUHp0NoGu5iovW+l0pTJ5Ot3PmyhSPeWCO1ng=;
        b=RS4tp3OaDRvGaeFXS0tj1oEcRYHYsLjDm3pL9OUNhcSNuF5ZTJGMLetdHOAVeUmoDf
         /LhZ1rcV5IJyQqmrv9Nqlb5GVJyazEo9pExad3doTsZgIeG75CPUjLAK5KUXasUUXgwt
         g0UywcCayPLmiCLW+XTo1hFE9tMsnBQi9Xv48wb2F8TN65rdQ2veKuA02hcT3Qoj82Rs
         t8+TF4gvgOoRakC6mmveo8nwhJawObmWADsFs1tQcblJIpUVY3fm+jFqlPtk/YDplsgz
         Iahc2I+cVnvXjMEX6NWSW/WHvSOU3YMNvWjah83wm9IrbkRPcdJdXY9nJKytyfWesXbv
         N8kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=dENGSSrUHp0NoGu5iovW+l0pTJ5Ot3PmyhSPeWCO1ng=;
        b=NzWDUHaqO6qGMNEzzOQKYCleU9EwACcqx3yJnJE3ZL366MFSKmpgc81CLYcVXQun1j
         3eFjuSvw4I0sV3iDGpLMKP6ofBln2nSZkrCjVW0DnHrX3G3L1kZb53MLQvYZhsC2oJbR
         gpG7RoyLzwoJYD+xdbi0MWSTqbIEXL/st1qhVJLlZgM3/12VoJwjGn4Baa5XT3jViIry
         8CJFRy77jfo01LIb5m8h7u1vQK4I6ySW6BreK1eVAJFQvy+R9KxZpqqq9HFmP9iN0ljv
         2TApQBzsXBvBbSjxn9aLO7D+NYulsOgn9JPFXDJREUc6gauNLZKGIYveyyDL05w4bKlA
         h8Mw==
X-Gm-Message-State: ABuFfogLtIEmkfkIssS7F4EKz6cNME8WjcYuTlSvgJxl5ilTOmUBOK2v
        RrVvULIQJ+uRvxQrYO34k9E=
X-Google-Smtp-Source: ACcGV60OmWMDqd6tMslbPiaP6KIqBfJIN5nnHNubZ2Rs1f6D/s0kt+buKlDC4dxIQnIkL7rOViJAaQ==
X-Received: by 2002:a1c:7ed4:: with SMTP id z203-v6mr2227352wmc.62.1537912986692;
        Tue, 25 Sep 2018 15:03:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 139-v6sm5053367wmp.4.2018.09.25.15.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 25 Sep 2018 15:03:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.org>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        stas@stason.org
Subject: Re: [PATCH 1/1] config doc: highlight the name=value syntax
References: <29173fd8-ce72-0927-9bfe-786442dfd82c@stason.org>
        <20180924222416.5240-2-philipoakley@iee.org>
Date:   Tue, 25 Sep 2018 15:03:05 -0700
In-Reply-To: <20180924222416.5240-2-philipoakley@iee.org> (Philip Oakley's
        message of "Mon, 24 Sep 2018 23:24:16 +0100")
Message-ID: <xmqqlg7pnskm.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.org> writes:

> +Variable name/value syntax
> +^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
>  All the other lines (and the remainder of the line after the section
>  header) are recognized as setting variables, in the form
>  'name = value' (or just 'name', which is a short-hand to say that
> @@ -69,7 +72,8 @@ stripped.  Leading whitespaces after 'name =', the remainder of the
>  line after the first comment character '#' or ';', and trailing
>  whitespaces of the line are discarded unless they are enclosed in
>  double quotes.  Internal whitespaces within the value are retained
> -verbatim.
> +verbatim. Single quotes are not special and form part of the
> +variable's value.
>  
>  Inside double quotes, double quote `"` and backslash `\` characters
>  must be escaped: use `\"` for `"` and `\\` for `\`.

Hmph.  This feels a bit backwards.  

The original paragraph is horrible in that there is no clear mention
that a pair of dq can be used to quote (which primarily is useful if
your value have leading or trailing whitespaces); the closest hint
is "enclosed in double quotes" we see in the pre-context.  The added
sentence singles out sq but it is unclear why it is necessary to
call out that it is not special---the readers can legitimately
wonder if backquotes are special or not and why.

I wonder if this is easier to understand:

    diff --git a/Documentation/config.txt b/Documentation/config.txt
    index ad0f4510c3..5eebd539df 100644
    --- a/Documentation/config.txt
    +++ b/Documentation/config.txt
    @@ -61,12 +61,16 @@ the variable is the boolean "true").
     The variable names are case-insensitive, allow only alphanumeric characters
     and `-`, and must start with an alphabetic character.

    +The value part can have segments that are enclosed in a pair of
    +double quotes (note: other kinds of quoting character pairs are not
    +special)--the double quotes are stripped from the value.
    +
     A line that defines a value can be continued to the next line by
     ending it with a `\`; the backquote and the end-of-line are
     stripped.  Leading whitespaces after 'name =', the remainder of the
     line after the first comment character '#' or ';', and trailing
    -whitespaces of the line are discarded unless they are enclosed in
    -double quotes.  Internal whitespaces within the value are retained
    +whitespaces of the line are discarded.
    +Internal whitespaces within the value are retained
     verbatim.

     Inside double quotes, double quote `"` and backslash `\` characters

> @@ -89,10 +93,14 @@ each other with the exception that `includeIf` sections may be ignored
>  if their condition does not evaluate to true; see "Conditional includes"
>  below.
>  
> +Both the `include` and `includeIf` sections implicitly apply an 'if found'
> +condition to the given path names.
> +

Mentioning that missing target file is not an error is definitely an
improvement.  I've never viewed it as applying "if found" condition
myself, but it is not wrong per-se to do so, I would think.

>  You can include a config file from another by setting the special
>  `include.path` (or `includeIf.*.path`) variable to the name of the file
>  to be included. The variable takes a pathname as its value, and is
> -subject to tilde expansion. These variables can be given multiple times.
> +subject to tilde expansion and the value syntax detailed above.
> +These variables can be given multiple times.

I have a mild suspicion that this adds negative value.  Singling out
that "[include] path = ..."  follows the usual value syntax makes
the readers wonder if there are some "[section] variable = ..." that
does not follow the value syntax that they have to be aware of and
careful about.
