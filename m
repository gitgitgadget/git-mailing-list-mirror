Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C12A61F406
	for <e@80x24.org>; Thu, 28 Dec 2017 22:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752029AbdL1WAn (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Dec 2017 17:00:43 -0500
Received: from mail-qk0-f171.google.com ([209.85.220.171]:39024 "EHLO
        mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750899AbdL1WAn (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Dec 2017 17:00:43 -0500
Received: by mail-qk0-f171.google.com with SMTP id u184so51146522qkd.6
        for <git@vger.kernel.org>; Thu, 28 Dec 2017 14:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=SHa1SHI3egegeu+NLQd4NgKg1YWdmC/vWAHkxVqxx4o=;
        b=WRlRoHlk3Lc7JWQSLkt7P96LGQ5hcGZH5cJexlB/WWaMyf0aV7fXWRGiOasDFYf0Rn
         P06sm5XpuZLD91/6f1oca2MPjD3Uyfmp3XadcGO3Su+YXsTMRDTRp+NJle9Dl2NTyhcW
         gOT0+oBlQafpLWN5u0RB9gIdwVQR5rLvcIPBiY6ug/Zz10gbK23QPNy+IdtYSi1VBvHX
         kFk90IwjPUJiAYRUiTmaPIaROemi72gsBmIsB5Z4VVqLVCCbomVgbjIXw7e0wmY1uSgL
         Otc4o6nl5jrU4XKkC76YOUI8ACcM5aR5DpMoWBeWbLEvoH9lssJZGtqqR+h8nwHpxZd6
         05Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=SHa1SHI3egegeu+NLQd4NgKg1YWdmC/vWAHkxVqxx4o=;
        b=qHQl0YtsiSuEehZsvoGukNbHBKVXC2T/yZ0TXcQ7jJQPB2QLcbAryoRjOOOB2XMzL5
         jc4JIlr09Wi9bhj1TVKrAwD+EhxN4R/qeskxg3DZdUyAMA2ToYeAazKAUNeEmG3Y1VED
         youct2p0OMbV3cxxJDyfQjRKLRNgP9LjQdAn2cXHMuK9OLJ8Hj23O+q7gPGiK1ypzC8g
         hPxtN8RYQHdGOIlbsy8gxeuh/6AKG9T3EfPxLIJ1XlZ9SJV8OFUMlYdcRYFmp9z3xcPL
         oG55i1Qg0bePlrXWI070bHbSvyT17rMuF1pdCzTiM20Q5yfHhQ4fPKNumTXZijkUjyh1
         kUJA==
X-Gm-Message-State: AKGB3mIwAv0/4TydluMpdzYtW23TkH2/Q14jxAvgiRc2x9y3Ic51AH06
        MWojl5CumxYEOrrr24TNDCPj5PTnX7Ahujh/8+s=
X-Google-Smtp-Source: ACJfBovPNWzQ99GfYLcLWQorcpUhRAfaR+7nUSxAt1+NOGMI7xXx8ocPJbHpGDo0b+hwhhJwRO9lJyTV2OSiHQiuwpg=
X-Received: by 10.55.130.194 with SMTP id e185mr41286838qkd.357.1514498442082;
 Thu, 28 Dec 2017 14:00:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Thu, 28 Dec 2017 14:00:41 -0800 (PST)
In-Reply-To: <20171228210345.205300-2-sbeller@google.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-2-sbeller@google.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 28 Dec 2017 17:00:41 -0500
X-Google-Sender-Auth: ife4ToFJS5BucYk-5XtMfG5PY4s
Message-ID: <CAPig+cQVGsQk3tj43V6f3rFTD8smDxqWvug_u4__EWxOQG90xA@mail.gmail.com>
Subject: Re: [PATCH 1/4] color.h: document and modernize header
To:     Stefan Beller <sbeller@google.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
> Add documentation explaining the functions in color.h.
> While at it, mark them extern.
>
> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/color.h b/color.h
> @@ -72,26 +72,48 @@ extern int color_stdout_is_tty;
>  /*
> - * Set the color buffer (which must be COLOR_MAXLEN bytes)
> - * to the raw color bytes; this is useful for initializing
> + * Set the color buffer `dst` (which must be COLOR_MAXLEN bytes)
> + * to the raw color bytes `color_bytes`; this is useful for initializing
>   * default color variables.
>   */
> -void color_set(char *dst, const char *color_bytes);
> +extern void color_set(char *dst, const char *color_bytes);

I don't see an explanation of what "color bytes" are. From where does
one obtain such bytes? How is this function used? The function comment
does not particularly answer these questions.

> +/*
> + * Parses a config option, which can be a boolean or one of
> + * "never", "auto", "always". Returns the constant for the given setting.
> + */
> +extern int git_config_colorbool(const char *var, const char *value);

I suppose that "constant for the given setting" means one of
GIT_COLOR_NEVER , GIT_COLOR_AUTO, GIT_COLOR_ALWAYS? Perhaps say so
explicitly?

Would it also make sense to say that boolean "true" ("yes", etc.)
results in GIT_COLOR_ALWAYS and "false" ("no", etc.)" results in
GIT_COLOR_NEVER?

Finally, for grammatical consistency with other comments:
    s/Parses/Parse
    s/Returns/Return/

> +/* Is the output supposed to be colored? Resolve and cache the 'auto' setting */
> +extern int want_color(int var);

What is the 'var' argument? How is it interpreted? (...goes and checks
implementation...) I guess this documentation should explain that the
caller would pass in the result of git_config_colorbool().

Also, the meaning of "Resolve and cache 'auto' setting" stumped me for
a while since it's not clear why it's here (or why it's missing the
full stop), but I eventually realized that it's describing an
implementation detail, which probably doesn't belong in API
documentation.

> +/*
> + * Translate the human readable color string from `value` and into
> + * terminal color codes and store them in `dst`
> + */
> +extern int color_parse(const char *value, char *dst);
> +extern int color_parse_mem(const char *value, int len, char *dst);

What does "human readable" mean in this context? Is it talking about
color names or RGB(A) tuples or what?

Also, how does the caller know how large to make 'dst'? At minimum,
you should say something about COLOR_MAXLEN.

Finally, for the 'len' case, what happens if 'dst' is too small? This
should be documented.

And, the return value of these functions should be discussed.

> +/*
> + * Print the format string `fmt`, encapsulated by setting and resetting the
> + * color. Omits the color encapsulation if `color` is NULL.

The "encapsulated by setting and resetting the color" bit is hard to
grok. Perhaps instead say something along the lines of:

    Output the formatted string in the specified color (and
    then reset to normal color so subsequent output is
    uncolored).

> + * The `color_fprintf_ln` prints a new line after resetting the color.
> + * The `color_print_strbuf` prints the given pre-formatted strbuf instead.

Should the strbuf variation warn that it only outputs content up to
the first embedded NUL? (Or should that bug/misfeature be fixed?)

> + */
>  __attribute__((format (printf, 3, 4)))
> +extern int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
>  __attribute__((format (printf, 3, 4)))
> +extern int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
> +extern void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
>
> -int color_is_nil(const char *color);
> +/*
> + * Check if the given color is GIT_COLOR_NIL that means "no color selected".
> + * The application needs to replace the color with the actual desired color.

Maybe: s/application/caller/

> + */
> +extern int color_is_nil(const char *color);
