Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0DAF1FC34
	for <e@80x24.org>; Fri,  8 Dec 2017 19:26:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752375AbdLHT0Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Dec 2017 14:26:25 -0500
Received: from mail-qt0-f169.google.com ([209.85.216.169]:35976 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752111AbdLHT0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Dec 2017 14:26:25 -0500
Received: by mail-qt0-f169.google.com with SMTP id a16so28226908qtj.3
        for <git@vger.kernel.org>; Fri, 08 Dec 2017 11:26:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=G1twZ/sq3qbjWOHye92jFA7g7tswn3LICR5yltQb7q0=;
        b=b+nU6l6OT8J9CbWEFDdxGufGMz5/Kh5GnS1SsKMMdLV6/63dS94qkXgUi5xaiKfIPS
         iJiJC7YhhEgGoEljDyek6S5LeulJcLp7dRA1jzf+9OSaSfoUVVtr4EyiN9DE0DWFpfxD
         qeRZmD7h6GmwN4bUa5ICZkkEBM+qW+M9U6vz2YPKYkhYN40hthMkViqrsIbKhp6QrJNv
         6Tpp5zGex7x2pSuW7omwwkmPQhnICyVSh9KFbfxjy22ZSwfhbbKimN37I+M5Q+xWLZRb
         B5umV7Wi7ul5GlnWzt4RYt2eBVkPZPm/FEP2I7y22jcS5wNC13iZIfyBAQK6SD+UiuAi
         edTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=G1twZ/sq3qbjWOHye92jFA7g7tswn3LICR5yltQb7q0=;
        b=HB+4CHGpsKJ30VIce1bPx4CseElPE1HYqvEx+TrtgW3opqugrZF6vjocZSWddcvOvu
         gcFkHmxFgO07cAksElkEGKwo0iNzsXYQIiWOouGjNXeVOMFCokOscji5av5rshr1nTUP
         llzRnGIX/Mcvl+AV9Q+NfxkPc0+11UpWztoqCPq32ExiXfMPAN8IESIw8i4O0KSKI9Xl
         YRLoBw86PgSmhJzD86U34HwmqMxdfZ1/D7eviXakE3V7htpdNQ4/57QcoLhfEgB3q81e
         KWaS8QeLFzAcLPm/OM5ft5C6E+koAuj1Mb451Av+p24/7Q3+Lg10Qef4D0b+D39wEMON
         HsMg==
X-Gm-Message-State: AKGB3mLtEsnk6WM8afoYqyTVEWZMK3jM/MBJ9MeqGQDhnOLyjC+wqAkh
        Tj5uERfUzzdcvYt82aDMvZhhk5baJo7IzHJFzZI=
X-Google-Smtp-Source: AGs4zMbqAeER9/1BUxIcNd3YFsQprIjON4aywd1qnI7FP6AIMlb8w40uiZ5qNg4qZAhvT1Tg6RjF+sibD+FInxiZT2A=
X-Received: by 10.237.35.37 with SMTP id h34mr17589370qtc.9.1512761184332;
 Fri, 08 Dec 2017 11:26:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.4 with HTTP; Fri, 8 Dec 2017 11:26:23 -0800 (PST)
In-Reply-To: <01020160364a2471-0e40e237-80b4-485c-a987-9c83206a2ee5-000000@eu-west-1.amazonses.com>
References: <01020160364a23d5-471a2fd0-9fff-4599-86f8-b2f37a4a0a84-000000@eu-west-1.amazonses.com>
 <01020160364a2471-0e40e237-80b4-485c-a987-9c83206a2ee5-000000@eu-west-1.amazonses.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 8 Dec 2017 14:26:23 -0500
X-Google-Sender-Auth: nchXuB9cVP9-ZbYUJ8-uA3nsnOw
Message-ID: <CAPig+cSjSHJoBz5rWBZE=AO=XhEk6ZoGkmqiuk_r9PgAe5wt4w@mail.gmail.com>
Subject: Re: [PATCH Outreachy 2/2] format: create docs for pretty.h
To:     Olga Telezhnaya <olyatelezhnaya@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 8, 2017 at 8:21 AM, Olga Telezhnaya
<olyatelezhnaya@gmail.com> wrote:
> Write some docs for functions in pretty.h.
> Take it as a first draft, they would be changed later.
>
> Signed-off-by: Olga Telezhnaia <olyatelezhnaya@gmail.com>
> Mentored-by: Christian Couder <christian.couder@gmail.com>
> Mentored by: Jeff King <peff@peff.net>
> ---
> diff --git a/pretty.h b/pretty.h
> @@ -57,31 +58,74 @@ struct userformat_want {
> +/*
> + * Create a text message about commit using given "format" and "context".
> + * Put the result to "sb".
> + * Please use this function for custom formats.
> + */
>  void format_commit_message(const struct commit *commit,
>                         const char *format, struct strbuf *sb,
>                         const struct pretty_print_context *context);
>
> +/*
> + * Parse given arguments from "arg", check it for correctness and
> + * fill struct rev_info.

To be consistent with the way you formatted the other comments, I
think you'd want quotes around rev_info.

> + */
>  void get_commit_format(const char *arg, struct rev_info *);
