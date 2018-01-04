Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 16D661F404
	for <e@80x24.org>; Thu,  4 Jan 2018 19:49:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753193AbeADTt2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 14:49:28 -0500
Received: from mail-qk0-f176.google.com ([209.85.220.176]:40743 "EHLO
        mail-qk0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752109AbeADTtZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 14:49:25 -0500
Received: by mail-qk0-f176.google.com with SMTP id q14so3338686qke.7
        for <git@vger.kernel.org>; Thu, 04 Jan 2018 11:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=N0/kfVuke3AOjuHzbLiD2mJUyTk+4DoUCFOHEtYH+Xw=;
        b=noe9Z81z06K9FNK2ShnvLfXf3wx4cJsoysbcdPSW/7V2YxykFdYJtFM0nAqklYi7PX
         pV8KdqhdQtDH+2DZHqNI9YL9//jbe3Gc37ELUF43uq+uzm8mrmlwsDT+EfZNQipDIeRc
         0ltyumnbvrst1HYghtBk1oszYgi+HeiMlH9UP/yilaooWScrZcsnYP5jW/ttRODS6MMj
         8Eo9fIPSlfMr/Vx+eizO3rEtpJRbXc7wd5mBQbhZvOwadeuFqAX6mmheN+iGqG2vwL5y
         CWzPngiE4Q3cIleVCKGpth5sNUffav6LZ8XuRVHu10aDek0RN//8rtC8Xt7/ZttQLGGh
         ZN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=N0/kfVuke3AOjuHzbLiD2mJUyTk+4DoUCFOHEtYH+Xw=;
        b=bNDSVy4+PgRfu5BjewWISkejLed6pnjipogbbPksQxFllDPBd3PjHIDWEIcD4ncmSJ
         zCodXUevtPe7KTWbUIeLrC6VsesGzaeCOyFMou/k8g5bWKWGhuvVcRy6prJpeKVEFTCS
         DswWuJ0drWsDbUtfVpNj6CY3APYU0hncC2orZ6S0PgIwlcc44nmC+kxX9xNnoUcsLXSn
         5TdZoahRJmuPP9fVXne/qprr/TzAleT3a5poMmnEtn9dcwwvgditWlz+XGz927NXy+t/
         Ci3kPB4NcIQpsMySBMOQ43DrMVl5vl85OEDK00StH2fSFRtzfENjSUSBD35eZtzPlSvk
         W9aQ==
X-Gm-Message-State: AKwxytfTcmudLg1NJkC7k1JVmAFJiN5Mf/609YmjK1dQhCY9dDBEnKE4
        66fnf4WID0uoHGBGiT7FKWbXwzfu4YAHk8GJ8axLUA==
X-Google-Smtp-Source: ACJfBosiBot+p1jSljkgAcBVYyCO4CDVTdSolqLIOKdIIr5+rmR2JGoUZfOEMj43h+yQpND8FyuDAE90qZh6bp9MXCE=
X-Received: by 10.55.77.142 with SMTP id a136mr934748qkb.320.1515095363990;
 Thu, 04 Jan 2018 11:49:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.85.179 with HTTP; Thu, 4 Jan 2018 11:49:23 -0800 (PST)
In-Reply-To: <CAPig+cQVGsQk3tj43V6f3rFTD8smDxqWvug_u4__EWxOQG90xA@mail.gmail.com>
References: <20171228210345.205300-1-sbeller@google.com> <20171228210345.205300-2-sbeller@google.com>
 <CAPig+cQVGsQk3tj43V6f3rFTD8smDxqWvug_u4__EWxOQG90xA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 4 Jan 2018 11:49:23 -0800
Message-ID: <CAGZ79kZJq1Y-R_Wx8w6raNFHE4snOgfHtfBh=gbH4pA0uOEF5w@mail.gmail.com>
Subject: Re: [PATCH 1/4] color.h: document and modernize header
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 28, 2017 at 2:00 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Thu, Dec 28, 2017 at 4:03 PM, Stefan Beller <sbeller@google.com> wrote:
>> Add documentation explaining the functions in color.h.
>> While at it, mark them extern.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>> diff --git a/color.h b/color.h
>> @@ -72,26 +72,48 @@ extern int color_stdout_is_tty;
>>  /*
>> - * Set the color buffer (which must be COLOR_MAXLEN bytes)
>> - * to the raw color bytes; this is useful for initializing
>> + * Set the color buffer `dst` (which must be COLOR_MAXLEN bytes)
>> + * to the raw color bytes `color_bytes`; this is useful for initializing
>>   * default color variables.
>>   */
>> -void color_set(char *dst, const char *color_bytes);
>> +extern void color_set(char *dst, const char *color_bytes);
>
> I don't see an explanation of what "color bytes" are. From where does
> one obtain such bytes? How is this function used? The function comment
> does not particularly answer these questions.

Right. This description is bad.


It's implementation is just

    xsnprintf(dst, COLOR_MAXLEN, "%s", color_bytes);

Apparently this function is only ever used by grep.c which uses
it to fill in struct grep_opt {
    ...
    char color_context[COLOR_MAXLEN];
    char color_filename[COLOR_MAXLEN];
    char color_function[COLOR_MAXLEN];
    char color_lineno[COLOR_MAXLEN];
    char color_match_context[COLOR_MAXLEN];
    char color_match_selected[COLOR_MAXLEN];
    char color_selected[COLOR_MAXLEN];
    char color_sep[COLOR_MAXLEN];
    ...
}

I guess I'll drop the documentation for color_set, and put a NEEDSWORK
comment there as I'd think we don't need to copy around the colors
using snprintf, but either can keep pointers or use xmemdup.

>
>> +/*
>> + * Parses a config option, which can be a boolean or one of
>> + * "never", "auto", "always". Returns the constant for the given setting.
>> + */
>> +extern int git_config_colorbool(const char *var, const char *value);
>
> I suppose that "constant for the given setting" means one of
> GIT_COLOR_NEVER , GIT_COLOR_AUTO, GIT_COLOR_ALWAYS? Perhaps say so
> explicitly?

Maybe I should fix the code as well. Currently it only returns one of
0 (=GIT_COLOR_NEVER), 1 (=GIT_COLOR_ALWAYS) and
GIT_COLOR_AUTO.

> Would it also make sense to say that boolean "true" ("yes", etc.)
> results in GIT_COLOR_ALWAYS and "false" ("no", etc.)" results in
> GIT_COLOR_NEVER?

done.

>
> Finally, for grammatical consistency with other comments:
>     s/Parses/Parse
>     s/Returns/Return/

done

>
>> +/* Is the output supposed to be colored? Resolve and cache the 'auto' setting */
>> +extern int want_color(int var);
>
> What is the 'var' argument? How is it interpreted? (...goes and checks
> implementation...) I guess this documentation should explain that the
> caller would pass in the result of git_config_colorbool().
>
> Also, the meaning of "Resolve and cache 'auto' setting" stumped me for
> a while since it's not clear why it's here (or why it's missing the
> full stop), but I eventually realized that it's describing an
> implementation detail, which probably doesn't belong in API
> documentation.

done

>
>> +/*
>> + * Translate the human readable color string from `value` and into
>> + * terminal color codes and store them in `dst`
>> + */
>> +extern int color_parse(const char *value, char *dst);
>> +extern int color_parse_mem(const char *value, int len, char *dst);
>
> What does "human readable" mean in this context? Is it talking about
> color names or RGB(A) tuples or what?
>
> Also, how does the caller know how large to make 'dst'? At minimum,
> you should say something about COLOR_MAXLEN.
>
> Finally, for the 'len' case, what happens if 'dst' is too small? This
> should be documented.
>
> And, the return value of these functions should be discussed.
>
>> +/*
>> + * Print the format string `fmt`, encapsulated by setting and resetting the
>> + * color. Omits the color encapsulation if `color` is NULL.
>
> The "encapsulated by setting and resetting the color" bit is hard to
> grok. Perhaps instead say something along the lines of:
>
>     Output the formatted string in the specified color (and
>     then reset to normal color so subsequent output is
>     uncolored).

sounds good.

>
>> + * The `color_fprintf_ln` prints a new line after resetting the color.
>> + * The `color_print_strbuf` prints the given pre-formatted strbuf instead.
>
> Should the strbuf variation warn that it only outputs content up to
> the first embedded NUL? (Or should that bug/misfeature be fixed?)

added.

>
>> + */
>>  __attribute__((format (printf, 3, 4)))
>> +extern int color_fprintf(FILE *fp, const char *color, const char *fmt, ...);
>>  __attribute__((format (printf, 3, 4)))
>> +extern int color_fprintf_ln(FILE *fp, const char *color, const char *fmt, ...);
>> +extern void color_print_strbuf(FILE *fp, const char *color, const struct strbuf *sb);
>>
>> -int color_is_nil(const char *color);
>> +/*
>> + * Check if the given color is GIT_COLOR_NIL that means "no color selected".
>> + * The application needs to replace the color with the actual desired color.
>
> Maybe: s/application/caller/

done

>
>> + */
>> +extern int color_is_nil(const char *color);
