Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5833F202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 23:03:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751529AbdGHXDk (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 19:03:40 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36404 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750952AbdGHXDk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 19:03:40 -0400
Received: by mail-pf0-f196.google.com with SMTP id z6so9417069pfk.3
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 16:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=DFi3qP4wexPYMFGq4/w3fOHwsZdg4BqoE1mzOMLDZ/c=;
        b=gmzXfjCRZwoicwv9KbdCm8MWeiVWCHFArSPPhpaOkRDCNn6tOKg4FSOA4kxf/hSjvR
         45c5Gi0zJ4f2ao4ZaXQPgOpdlvrvtfEFc+0MzsQq9d8gdYoRZolW+QJBRx7Lpyb84JYO
         t0N//StHLd1jVcSg2QpLo3akjO6Z5pxjogsFt+YBB0P5xja5aKcFWdRqkTmE4X4sYUS3
         SjjSvGkM0Ozm21rUdMFVscdoWacyZjpg7FgtjBjZXP5dB50pCGPXtNulZUMCa8lUuSvN
         6W4KArXyx4o1oz6xUV/XDNyzPil3L7WgiTBiyRZ2sDNzIkpcF3J+lWg92h0ZnFbuP/5Y
         MlZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=DFi3qP4wexPYMFGq4/w3fOHwsZdg4BqoE1mzOMLDZ/c=;
        b=J528dfu9lP1IlPEq/BkvsksUVQ8zfAESmdv3hYdCYFsrfBnyG3um309SnK8ptUH7l5
         4ovPpmlIae4CO9gAmPjyI7prqz2wZFubGSt4hzrUbpt1mSyCx2biABu/j2I/epaNak1X
         cFs/4jHOy3YFgHwLR8cHP7unplUEt/nj8hOlQkf/+ZOYaWT+AzfCa/hr3g8w4nW+iIIV
         udxaBEaNPKeH6fVXbKXLBs1nx9+pI/kDCLTYcqQALfKp+lE9tHX44+4Tix6yt0TO2CH4
         XYz5C4LDHI210PWpXyJYfQnE8LNYwUVNOpHTjKAS32nT0eBpi0on6hO3gFWsQD5Jt/zO
         HkIg==
X-Gm-Message-State: AIVw112QIuHTRxVjU0rJQ/p9Rmzu17JAFmC35N1GFpfYpuD0WphFfIx0
        xv0UVYGsig64Hg==
X-Received: by 10.99.7.129 with SMTP id 123mr7626626pgh.171.1499555019143;
        Sat, 08 Jul 2017 16:03:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:49f8:bc86:d515:b7dd])
        by smtp.gmail.com with ESMTPSA id e13sm13855923pfh.96.2017.07.08.16.03.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 08 Jul 2017 16:03:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     astian <astian@eclipso.at>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/4] Doc/config.txt: explain repeated sections
References: <20170708203413.16442-1-astian@eclipso.at>
        <20170708203413.16442-2-astian@eclipso.at>
Date:   Sat, 08 Jul 2017 16:03:37 -0700
In-Reply-To: <20170708203413.16442-2-astian@eclipso.at> (astian@eclipso.at's
        message of "Sat, 8 Jul 2017 20:34:10 +0000")
Message-ID: <xmqqfue6a5va.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

astian <astian@eclipso.at> writes:

> Add a paragraph explaining what happens when a section name is repeated
> in the configuration file(s).
>
> The example configuration file shown in this document already implied
> Git's behaviour, this patch simply tries to make it explicit.
>
> Signed-off-by: astian <astian@eclipso.at>
> ---
>  Documentation/config.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index d5c9c4cab..afce25705 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -31,6 +31,10 @@ characters, `-` and `.` are allowed in section names.  Each variable
>  must belong to some section, which means that there must be a section
>  header before the first setting of a variable.
>  
> +Multiple occurrences of the same section are all logically merged.  (There's
> +no special treatment for variables defined multiple times across physically
> +different sections, the variable is simply made multivalued.)
> +

Looks correct; it's a bit surprising that we didn't already mention
multiple occurrences, but I do not find it so this is a good
addition. 

I do not see a strong reason for () around the second sentence,
though.

By the way, with something that is supposed to hopefully have some
legal value down the line if somebody starts making noises, it
really would be nice to have a real person to associate things with.
It would be embarrassing later if there is no way to even look you
up somehow.  Documentation/SubmittingPatches asks you to sign-off
with a real name for a reason.

Thanks.
