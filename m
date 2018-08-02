Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 105471F597
	for <e@80x24.org>; Thu,  2 Aug 2018 15:32:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387692AbeHBRXm (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 13:23:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:54597 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387490AbeHBRXm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 13:23:42 -0400
Received: by mail-wm0-f68.google.com with SMTP id c14-v6so3000280wmb.4
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 08:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=2RwywM+IjWr4WRSoKibPXRkPZzs4fUHotmlyTQngya0=;
        b=O8Epygvrkkw3RtE5YJN5d3pOU4T8NP4ByB8GiPZ+U2v+ToETSjj1o8xK9DrTiWbVCa
         +95PTzTU92fWjqXCOinVnvIxhEchW3IisTTQkEWLuaN83+xxD8g8tmhvLL77RUo81sUv
         I0KZft2VHKrrTh7ATY69H2uq0zlB9dKlLRH2YNjQ3QGgI24A9zqFUifbLijtADshxLHD
         G8QT/kVE/e2Tp2gkRrnetQ9jpOV6LLfCTnKK6LqbHnJKHH14uRt0O/vgG2SY0w0Hm9ha
         BVi5rK0Y9rEgowNs6T+yivL/DK3v5d3+zcMQ0fkis48o5nvAlUkeegC5M9lFdlyrsE18
         m0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=2RwywM+IjWr4WRSoKibPXRkPZzs4fUHotmlyTQngya0=;
        b=UjoI8m2WpyseJ4suO+LqhFq69R7TqPtqpi8EDsXY9t05JMnJ7aNlrVoUCi2Ra1LCcs
         C0EfR+wvH9knm1u/7gcrrUQoV1W/eB9FvVOMUn1PxHBnhbXUlB1bcE+1FhTcCtY1jceZ
         9P2K6hnGBHJ1UW55NOO9Aw1r+sUDWWLW9BNlnH28427qr1mm2aDNhaOtnJbyczlnj+Yy
         lrR6QHDb7gcfeuCY3t5zyNBlERnYEFOv2KQ2LvFbisciJfeQi22HZYA2j/NhjueweehV
         FU7tzmoI2fgSHzFQEDTp0PMa+18vY5SUVz+Uepqy6Hq9mkB8qdsSdBrlFX8FcBjMPOae
         +gWQ==
X-Gm-Message-State: AOUpUlHMrSnEL6eoRRLf7l6cPNp7b65AXKaWchATQJ8Z44qlXEE8FEAN
        g8st1bkOMJ8a25KXH7Csb24=
X-Google-Smtp-Source: AAOMgpfuFwlk12e5ljIJGUWRKgeEoPOL4nbQa9ZjcjawuZZ1vw7Wwgz8d1yFtEm2+qIBF8gKY8nwfg==
X-Received: by 2002:a1c:6f06:: with SMTP id k6-v6mr2275304wmc.1.1533223919126;
        Thu, 02 Aug 2018 08:31:59 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id l11-v6sm2095612wru.25.2018.08.02.08.31.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 08:31:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] push: comment on a funny unbalanced option help
References: <xmqqh8ke6i7w.fsf@gitster-ct.c.googlers.com>
        <87k1p9u860.fsf@evledraar.gmail.com>
        <xmqqwot969mp.fsf@gitster-ct.c.googlers.com>
        <87h8kdu3ay.fsf@evledraar.gmail.com>
        <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de>
Date:   Thu, 02 Aug 2018 08:31:57 -0700
In-Reply-To: <30a6105c-4cb7-b52f-0b0a-c4504b90a5b1@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Thu, 2 Aug 2018 14:16:17 +0200")
Message-ID: <xmqqftzw4weq.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> We could check if argh comes with its own angle brackets already and
> not add a second pair in that case, making PARSE_OPT_LITERAL_ARGHELP
> redundant in most cases, including the one above.  Any downsides?
> Too magical?

Hmph.

> -- >8 --
> Subject: [PATCH] parse-options: automatically infer PARSE_OPT_LITERAL_ARGHELP
>
> Avoid adding an extra pair of angular brackets if the argh string
> already contains one.  Remove the flag PARSE_OPT_LITERAL_ARGHELP in the
> cases where the new automatic handling suffices.  This shortens and
> simplifies option definitions with special argument help strings a bit.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---

>  		{ OPTION_STRING, 0, "prefix", &opts.prefix, N_("<subdirectory>/"),
>  		{ OPTION_CALLBACK, 'g', "reflog", &reflog_base, N_("<n>[,<base>]"),
>  			N_("<mode>,<object>,<path>"),
> +		OPT_STRING(0, "prefix", &prefix, N_("<prefix>/"),

Hmph.

> diff --git a/parse-options.c b/parse-options.c
> index 7db84227ab..fadfc6a833 100644
> --- a/parse-options.c
> +++ b/parse-options.c
> @@ -660,7 +660,8 @@ int parse_options(int argc, const char **argv, const char *prefix,
>  static int usage_argh(const struct option *opts, FILE *outfile)
>  {
>  	const char *s;
> -	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh;
> +	int literal = (opts->flags & PARSE_OPT_LITERAL_ARGHELP) || !opts->argh ||
> +		(opts->argh[0] == '<' && strchr(opts->argh, '>'));

You are greedier than what I thought ;-) I would have limited this
magic to the case where argh is surrounded by "<>", but you allow
one closing ">" anywhere, which allows us to grab more complex cases.

The lack of escape hatch to decline this auto-literal magic makes me
somewhat nervous, but I do not offhand think of a reason why I do
want an arg-help string that _begins_ with '<' to be enclosed by
another set of "<>", so perhaps this is a good kind of magic.
