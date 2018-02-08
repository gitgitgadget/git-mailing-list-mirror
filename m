Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B18811F404
	for <e@80x24.org>; Thu,  8 Feb 2018 22:26:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751317AbeBHW0f (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Feb 2018 17:26:35 -0500
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42434 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750750AbeBHW0e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Feb 2018 17:26:34 -0500
Received: by mail-qt0-f194.google.com with SMTP id i8so8264499qtj.9
        for <git@vger.kernel.org>; Thu, 08 Feb 2018 14:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=NJXqYT2CEjxVCB+Dyx+JnwzN8fjN5M5ZUg49wAMc06I=;
        b=DhZQ285D4oA5d0XslcvJCtBlQr2lRIyjp3CVxZFboPvthTwhQwOUDXQngwHq2oEgH3
         cRvnXoaGw3NhHChe9u7P8p0oNJpEoeGV6PH0t2jwCFGw8ve3yJx1QBQqa8QZ5CCT0Oua
         si6W1JTtpaSpiILpFiC45SHQIx0eS1GK/HJHOEOo3bMiYZyMdAiUZWrCEGv9koxa8MCs
         Gw9W5Puyc6I4YM894e5krbtfzeo8a3UNHNw5SzQtxDCd3F6Y+YesJhyy1Fw/+/thIPX+
         2cefkqWUv4bh3RfNl5jOBVzol4KI/JICkMak8xYT5wmKWIoFuof5w6sYyPMmRboNuzZs
         iZMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=NJXqYT2CEjxVCB+Dyx+JnwzN8fjN5M5ZUg49wAMc06I=;
        b=fQvN3+98Afky3XIFj4f08W9wJNkMKVJEsEHGj+9Q3WSV96KkD6MNizxRb6VayXo1kt
         Q2TvoiBTUB1Ae+qrXUqcPhifUp/SFxGe7ZPSp5BYR26gF+GZvDfNRVhgo/BD708u67LE
         pLbBwqTkNNkTOSZfjGsC5buqRTIcAiXkj6h8Fc0Us5+Mubpc799InfEoPI48M4UaYzJA
         dga29Fd9nfGFmXVfaNkypB2rxMVSD7SgC5ICe4VaD8+M2MINbWeYF2oQclnoupX8cSMy
         QfCeiOjTc7e7SkcD9xSWvNp1bO+i5YCNNz9tCcZfpjAZ/HBneBr1GziGbVWabi3/j32f
         ndXg==
X-Gm-Message-State: APf1xPC+ViVooOCvbOxKZgi8/5EcV/ohn97Kf911c555vknoFlfHFfCt
        Gdlc5dcyYRDqrtE0CcaaRpZtZpBh9mi3jIN1+D8gBg==
X-Google-Smtp-Source: AH8x224cqKJ7yaDi1151zizUF0OWGeFHS4WRpJgTUr68k+xtg2VEy8TiV42apUCRVYNQ1ggWw0pvuZIm+iUJN4a+DxE=
X-Received: by 10.200.51.66 with SMTP id u2mr1248055qta.127.1518128793828;
 Thu, 08 Feb 2018 14:26:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.137.133 with HTTP; Thu, 8 Feb 2018 14:26:33 -0800 (PST)
In-Reply-To: <20180208204309.GA4541@sigill.intra.peff.net>
References: <20180208201546.194935-1-sbeller@google.com> <20180208204309.GA4541@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 8 Feb 2018 17:26:33 -0500
X-Google-Sender-Auth: tgG9o7YtalakfFUQnTh0ZM3UB-w
Message-ID: <CAPig+cTZuf5rMNN6aSztX-jKrJkuRpVcJj+xmrSsO6ngrHhU6Q@mail.gmail.com>
Subject: Re: [PATCH] color.h: document and modernize header
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 8, 2018 at 3:43 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Feb 08, 2018 at 12:15:46PM -0800, Stefan Beller wrote:
>> +/*
>> + * Resolve the constants as returned by git_config_colorbool()
>> + * (specifically "auto") to a boolean answer.
>> + */
>> +extern int want_color(int var);
>
> This explanation left me even more confused about what should go in
> "var", and I think I'm the one who wrote the function. ;)

Agreed, this still fails to (directly) answer the question I asked in
[1] about what 'var' is.

> I think the point is that "var" is a quad-state variable (yes, no, auto,
> or "unknown") and we are converting to a boolean. This would probably be
> a lot more clear if GIT_COLOR_* were all enum values and not #defines,
> and this function took the matching enum type.
>
> So I think that's what you were trying to name with "constants as
> returned by...", but it definitely took me some thinking to parse it.

Rather than talking about plural "constants" (which makes it more
confusing), it would likely be helpful for it to say (explicitly) that
the caller passes in the result of git_config_colorbool() as 'var'.

Or something like that.

>> +/*
>> + * Output the formatted string in the specified color (and then reset to normal
>> + * color so subsequent output is uncolored). Omits the color encapsulation if
>> + * `color` is NULL. The `color_fprintf_ln` prints a new line after resetting
>> + * the color. The `color_print_strbuf` prints the given pre-formatted strbuf
>> + * instead, up to its first NUL character.
>> + */
>
> It probably doesn't matter much in practice, but the color_print_strbuf
> behavior sounds like a bug. Shouldn't it print the whole strbuf, even if
> it has an embedded NUL?

I (parenthetically) suggested[1] the same about fixing the
bug/misbehavior, though doing so is outside the scope of this
particular patch.

[1]: https://public-inbox.org/git/CAPig+cQVGsQk3tj43V6f3rFTD8smDxqWvug_u4__EWxOQG90xA@mail.gmail.com/
