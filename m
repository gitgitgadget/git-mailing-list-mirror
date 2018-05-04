Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9D5F200B9
	for <e@80x24.org>; Fri,  4 May 2018 16:25:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751454AbeEDQZh (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 May 2018 12:25:37 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:46892 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751423AbeEDQZg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 May 2018 12:25:36 -0400
Received: by mail-vk0-f68.google.com with SMTP id i190-v6so13697865vkd.13
        for <git@vger.kernel.org>; Fri, 04 May 2018 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=1S0qwG1CZwdRjUvpq+QneYbNVU09hTpIKE00TijdlnI=;
        b=F2nR1wlkTm1BExjPdG1lQ6T2mQBpsEQwjz6+j1AtchhKKdCmiIGKKgmgnequ9Kw/IZ
         2oTZmRiIj4UAzFelF7Xr8ZBfDThXvh9k16AHBZVkzoKhNvz6lNWnycqGue2q+yzm7UQJ
         GIGgrkpB5NGnNkjLYPIXjELX9s8zRkzBnSJ4wiCI0ASgWq6HcVjlTL7AkDXFikrWfiR3
         k4m3rwXf3/36v1w0dTAXEna6t3RwjB7qkSHZYuuhA3FwLh/KOI/Y4/tbaH8hKFmDCgSS
         kHZZs9qwKfSF/d7x3amLXWVaxILtlt/5zyRiuE52r0iI3E7sEMwZnau3a+4F5yq5SMS0
         IjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=1S0qwG1CZwdRjUvpq+QneYbNVU09hTpIKE00TijdlnI=;
        b=PtrgpbPrYJEZ2rrfFuhsyUKGCzVvaLhzrhZe2Yae4sSz1roWelFXa+881WYEYp9e64
         Hg3eifRYto7A8WksnqTSZ1pC8MaoQmpoczAdlDW287S4E6aE7KVLKXNl0x80peS7peA5
         83P/uRX8C8lrgHzlv/JzIkJUm0kb6Lla31HW8zxpqlZ8jbYKsEn90lnrVNAH11eYTg1M
         TCAurRyVxu6KG45vHWh1RezOK7sIzBYaXfIrXDYA8KDx5D21xxt1UsizKJZ/Ei6wBaQ7
         jV6Rx9b1UjhOWE0ZwMxL2dZPv6nESS92lTB7Tx8sUdDLM6ikhqPgJPO2rhR9X3wwVA/z
         HVYw==
X-Gm-Message-State: ALQs6tDER8FeM2kzROOpf/vJ7+qC3pltt3NbIQbwx4ePJnjR+yLPUcdV
        p42/3X+OfYqAydtWHjDqqcjKRGRJfEzV4GWLry4=
X-Google-Smtp-Source: AB8JxZpchP0g7E24UcltyQkh5gjXCHno5TucuMHtGf9K+saloIClGuUavO2lok4wII9/+F/LJqEpRP6j1f4gPv9khZ4=
X-Received: by 2002:a1f:a54:: with SMTP id 81-v6mr22576257vkk.184.1525451135368;
 Fri, 04 May 2018 09:25:35 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Fri, 4 May 2018 09:25:34 -0700 (PDT)
In-Reply-To: <0e4c8279e467e2e75864bcce8ec90cf4f81c2c34.1525448066.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
 <cover.1525448066.git.johannes.schindelin@gmx.de> <0e4c8279e467e2e75864bcce8ec90cf4f81c2c34.1525448066.git.johannes.schindelin@gmx.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 4 May 2018 09:25:34 -0700
Message-ID: <CABPp-BHbVTmNrZ32ZYQuoH0-XtFL+v7k-J7+t4_JWxds4K1U2Q@mail.gmail.com>
Subject: Re: [PATCH v2 09/18] branch-diff: adjust the output of the commit pairs
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho,

On Fri, May 4, 2018 at 8:34 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> This change brings branch-diff yet another step closer to feature parity
> with tbdiff: it now shows the oneline, too, and indicates with `=` when
> the commits have identical diffs.
>
<snip>
> @@ -270,9 +272,57 @@ static int get_correspondences(struct string_list *a, struct string_list *b,
>         return res;
>  }
>
> -static const char *short_oid(struct patch_util *util)
> +static void output_pair_header(struct strbuf *buf,
> +                              int i, struct patch_util *a_util,
> +                              int j, struct patch_util *b_util)
>  {
> -       return find_unique_abbrev(&util->oid, DEFAULT_ABBREV);
> +       static char *dashes;
> +       struct object_id *oid = a_util ? &a_util->oid : &b_util->oid;
> +       struct commit *commit;
> +
> +       if (!dashes) {
> +               char *p;
> +
> +               dashes = xstrdup(find_unique_abbrev(oid, DEFAULT_ABBREV));
> +               for (p = dashes; *p; p++)
> +                       *p = '-';
> +       }
> +
> +       strbuf_reset(buf);
> +       if (i < 0)
> +               strbuf_addf(buf, "-:  %s ", dashes);
> +       else
> +               strbuf_addf(buf, "%d:  %s ", i + 1,


One nice thing tbdiff did was to right align patch numbers (which also
helped align other columns in the output).  So, for example when there
are more than 9 patches I would see output like:

...
 8: a980de43fd =  8: 362ab315ac directory rename detection: testcases
exploring possibly suboptimal merges
 9: 3633e79ed9 =  9: 792e1371d9 directory rename detection:
miscellaneous testcases to complete coverage
10: e10d07ef40 = 10: a0b0a15103 directory rename detection: tests for
handling overwriting untracked files
11: f6d84b503e = 11: a7a436042a directory rename detection: tests for
handling overwriting dirty files
...

whereas branch-diff here is instead giving output of the form

...
8:  a980de43fd = 8:  362ab315ac directory rename detection: testcases
exploring possibly suboptimal merges
9:  3633e79ed9 = 9:  792e1371d9 directory rename detection:
miscellaneous testcases to complete coverage
10:  e10d07ef40 = 10:  a0b0a15103 directory rename detection: tests
for handling overwriting untracked files
11:  f6d84b503e = 11:  a7a436042a directory rename detection: tests
for handling overwriting dirty files
...


Not a critical difference, but it'd be nice to match tbdiff here all the same.

> +                           find_unique_abbrev(&a_util->oid, DEFAULT_ABBREV));
> +
> +       if (i < 0)
> +               strbuf_addch(buf, '>');
> +       else if (j < 0)
> +               strbuf_addch(buf, '<');
> +       else if (strcmp(a_util->patch, b_util->patch))
> +               strbuf_addch(buf, '!');
> +       else
> +               strbuf_addch(buf, '=');
> +
> +       if (j < 0)
> +               strbuf_addf(buf, " -:  %s", dashes);
> +       else
> +               strbuf_addf(buf, " %d:  %s", j + 1,

Same comment on these last two strbuf_addf's about alignment.



Elijah
