Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 786CF1F461
	for <e@80x24.org>; Sat, 22 Jun 2019 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbfFVLmm (ORCPT <rfc822;e@80x24.org>);
        Sat, 22 Jun 2019 07:42:42 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:41614 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfFVLmm (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jun 2019 07:42:42 -0400
Received: by mail-io1-f65.google.com with SMTP id w25so311531ioc.8
        for <git@vger.kernel.org>; Sat, 22 Jun 2019 04:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=53sZIQwbOkYIw//ub5w5t6CG4vPj2EzFU6OTx1gwSuY=;
        b=a8fQZctm5m9oOD7RWm61Apl8Zw+owk4P9m7Cn8rfVMfeW0m7YGaIZ9i6y7NRAmcjK/
         Jq558RaobzG0BzDu1Z4IfIYlCX96hpf02h+VFbEFI/A42ItPYWe96oYXtZfcOd0DUbYc
         7MoeM5NaetzeEFB19muCiAJP0sIxg2jQl2lJSGJAaenN9Vmsqu8UWgmYJerzkkXdriEt
         L0TXhUte93JOcNbaqpJloFfHWD3LFxQk/99NlwxKBqTozlH/C77xnmT//cDIwI18Mlwi
         A7Q0a48su9Do/F4TGPu9OV0kEm3ZhEXElPTdnepiV8KFzF5fTJeGxc/FVT7vwx84x7P6
         o3tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=53sZIQwbOkYIw//ub5w5t6CG4vPj2EzFU6OTx1gwSuY=;
        b=bLI8lcu0n4qnUkdZSRic9DjVbB0nE2ZledBsEr+zck7Ng8ZQICJvxmHoNd+emgnr5l
         CVX7eQyM5mb4Hu5n16E0utyjLB3AIgmbUH7y57HBWoLwjWPugWdXJHQ92uB32e8FGvyc
         atyywZVowVGJS3QsnIePd1UeA+tX/TBjzldfi/eg8nehE2misHL1IDKt44ujPYbALvFH
         yqhiRc5UDYXNe+8+f6Y0GE9ZCASOcHMJFe0kjVeaPTuSX5+QZwe+J+9duuXPVqJs8qCF
         O4/BUo619lEac8WUI1vIRr0sd3e+gX5Q2fV2hZQhgYvyVPISNoo6q5cduBa9Jy4dN0Y8
         F8qQ==
X-Gm-Message-State: APjAAAVLhRtMJCSmbkcTMsDE9vNFbfFO7frfth6IAOhZ5bakzLxR6SiY
        q8w+8Kpw1GAzhfSurw8aOMTDVwRqfCi2fwS4KT4=
X-Google-Smtp-Source: APXvYqx7ZBl1gO0nyutBXgEoYtvgs0ymfk+YtlL4nYJSwLahdB7iR3YqYCn0JdXUo2Vf179hY1XmFNW9t7T+Vn4f7X8=
X-Received: by 2002:a6b:b497:: with SMTP id d145mr51222766iof.17.1561203761173;
 Sat, 22 Jun 2019 04:42:41 -0700 (PDT)
MIME-Version: 1.0
References: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
In-Reply-To: <20190622093655.80092-2-dimitriy.ryazantcev@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Sat, 22 Jun 2019 18:42:14 +0700
Message-ID: <CACsJy8CPChOGSZVfXd6ioaXHWg_aFxNMzr2J=Zdm2RZXkO++Ew@mail.gmail.com>
Subject: Re: [PATCH v3] l10n: localizable upload progress messages
To:     Dimitriy Ryazantcev <dimitriy.ryazantcev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 22, 2019 at 4:37 PM Dimitriy Ryazantcev
<dimitriy.ryazantcev@gmail.com> wrote:
> diff --git a/strbuf.c b/strbuf.c
> index 0e18b259ce..0a3ebc3749 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -814,20 +814,28 @@ void strbuf_addstr_urlencode(struct strbuf *sb, const char *s,
>  void strbuf_humanise_bytes(struct strbuf *buf, off_t bytes)
>  {
>         if (bytes > 1 << 30) {
> -               strbuf_addf(buf, "%u.%2.2u GiB",
> +               strbuf_addf(buf, "%u.%2.2u ",
>                             (unsigned)(bytes >> 30),
>                             (unsigned)(bytes & ((1 << 30) - 1)) / 10737419);
> +               /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: gibi */
> +               strbuf_addstr(buf, _("Gi"));

It may be ISO standard, but GiB to me looks much easier to understand.
What's the reason for changing GiB to Gi btw?

>         } else if (bytes > 1 << 20) {
>                 unsigned x = bytes + 5243;  /* for rounding */
> -               strbuf_addf(buf, "%u.%2.2u MiB",
> +               strbuf_addf(buf, "%u.%2.2u ",
>                             x >> 20, ((x & ((1 << 20) - 1)) * 100) >> 20);
> +               /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: mebi */
> +               strbuf_addstr(buf, _("Mi"));
>         } else if (bytes > 1 << 10) {
>                 unsigned x = bytes + 5;  /* for rounding */
> -               strbuf_addf(buf, "%u.%2.2u KiB",
> +               strbuf_addf(buf, "%u.%2.2u ",
>                             x >> 10, ((x & ((1 << 10) - 1)) * 100) >> 10);
> +               /* TRANSLATORS: ISO/IEC 80000-13:2008, clause 4: kibi */
> +               strbuf_addstr(buf, _("Ki"));
>         } else {
> -               strbuf_addf(buf, "%u bytes", (unsigned)bytes);
> +               strbuf_addf(buf, "%u ", (unsigned)bytes);
>         }
> +       /* TRANSLATORS: ISO/IEC 80000-13:2008, subclause 13-9.c: byte */
> +       strbuf_addstr(buf, _("B"));
>  }
>
>  void strbuf_add_absolute_path(struct strbuf *sb, const char *path)
> --
> 2.22.0
>


-- 
Duy
