Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A845D1F6AC
	for <e@80x24.org>; Wed,  4 Jul 2018 07:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932150AbeGDHLW (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Jul 2018 03:11:22 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39051 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753068AbeGDHKS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Jul 2018 03:10:18 -0400
Received: by mail-pl0-f68.google.com with SMTP id s24-v6so2233768plq.6
        for <git@vger.kernel.org>; Wed, 04 Jul 2018 00:10:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=b27AA10zUk9Adxoge8Jzix4g7UhuxyThTcWPW6xDTiI=;
        b=AUormZhZhNuYXdPgRudYSSI57RwovS0eFHk91LKBYPxdrwZl+26oVcWXI7P7i5TB1p
         QKYng75ty2/178lro40tBS84C4OICKRGHZ9UuRR5TG4wxmwZ2gcdedLCwdZcpXd7TP5e
         7BMchKT5Pdoc3ZWDBnDSHWPNe3vQOcTc0l8gCRd+wGa43NrIDSrZfF56J8bDBm11s0ar
         zDF1jzFK7xQoebvyqle5JqRHGobqLji1FtacAURP95Nf3CO84EsaS9YH9Y/9ewCGxZKW
         +EAkuCPmVLQZ/JAeDtjn4G2TrXAeZvwJbRpzpHGsxJ7S8+uzdv/rhg08G0bsZCtYCfff
         /DMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=b27AA10zUk9Adxoge8Jzix4g7UhuxyThTcWPW6xDTiI=;
        b=BS1sUcxAq0y88SMg/zS7BA45RzMI0D8Wk0rkexxXdf5joz5jAeucE1AqJyisWm8Dfm
         MHeEG5A+4AstV5wYsc9aAs6MrBcPNg19paSgRbMXloNgYSRWqqz5WPgo4wdQN1JGR4gq
         MBG/WMqsKpO0tKEHfL0WR+rHLW3eZhd34xfTp8/umwHuRcO4d/u/6xIzRneLf4/pPZB3
         u9qR9HgjnW01ZZ7rwjDofLYAVF+a93UMM8DBgShptph3CgINjXrbcPuEfqTlwCkKtGKB
         DvsTqvvDNEbWAGZ1QNtE8eA8EuGpZgC3cRh5RinJlBY860AbS/15kusUo4XR4pBnSKnn
         kyPg==
X-Gm-Message-State: APt69E1UJV5Yhf/lz6LW8hbZXk1GSU9sZnbRhqq/y4ttmi0xre8xrSEJ
        wrmObiZR7QEUXbBrpnQcWTE4BN3YU7IRgFp21zjiEKhj
X-Google-Smtp-Source: AAOMgpecOGYV0sGjhkTx3pZ9voHoXHYj4jzpisA94IWSP0KduXtWqZ1Sls5oaP1ltvK+CrSKdO/rR8eTaQdQ1lAOsW0=
X-Received: by 2002:a17:902:543:: with SMTP id 61-v6mr931060plf.47.1530688217821;
 Wed, 04 Jul 2018 00:10:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:90a:3361:0:0:0:0 with HTTP; Wed, 4 Jul 2018 00:10:17
 -0700 (PDT)
In-Reply-To: <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
References: <cover.1530616446.git.henning.schild@siemens.com> <db46732d1cd09a71200e00c2d09605d5beaff364.1530616446.git.henning.schild@siemens.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Wed, 4 Jul 2018 09:10:17 +0200
Message-ID: <CAN0heSrXpLCDRjnZC80QXBG27gd6m5reBn1hfNd_KXxnPVkA2g@mail.gmail.com>
Subject: Re: [PATCH 4/8] gpg-interface: introduce an abstraction for multiple
 gpg formats
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Ben Toews <mastahyeti@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Henning,

On 3 July 2018 at 14:38, Henning Schild <henning.schild@siemens.com> wrote:
> Create a struct that holds the format details for the supported formats.
> At the moment that is still just "PGP". This commit prepares for the
> introduction of more formats, that might use other programs and match
> other signatures.
>
> Signed-off-by: Henning Schild <henning.schild@siemens.com>

Welcome to the mailing list! :-)

I'll just comment on a few thoughts I had while skimming this.

>  static char *configured_signing_key;
> -static const char *gpg_format = "PGP";
> -static const char *gpg_program = "gpg";
> +struct gpg_format_data {
> +       const char *format;
> +       const char *program;
> +       const char *extra_args_verify[1];
> +       const char *sigs[2];
> +};
>
>  #define PGP_SIGNATURE "-----BEGIN PGP SIGNATURE-----"
>  #define PGP_MESSAGE "-----BEGIN PGP MESSAGE-----"
>
> +enum gpgformats { PGP_FMT };
> +struct gpg_format_data gpg_formats[] = {
> +       { .format = "PGP", .program = "gpg",
> +         .extra_args_verify = { "--keyid-format=long", },
> +         .sigs = { PGP_SIGNATURE, PGP_MESSAGE, },
> +       },
> +};

I think those trailing commas are ok now, but I'm not sure...

I had the same thought about designated initializers. Those should be ok
now, c.f. cbc0f81d96 (strbuf: use designated initializers in STRBUF_INIT,
2017-07-10) and a73b3680c4 (Add and use generic name->id mapping code
for color slot parsing, 2018-05-26).

> +static const char *gpg_format = "PGP";
> +
> +static struct gpg_format_data *get_format_data(void)
> +{
> +       int i;
> +       for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +               if (!strcmp(gpg_formats[i].format, gpg_format))
> +                       return gpg_formats + i;
> +       assert(0);

This might be better written as `BUG("bad gpg_format '%s'",
gpg_format);` or something like that.

(It's not supposed to be triggered, not even by invalid data from the
user, right?)

>         if (!strcmp(var, "gpg.format")) {
> -               if (!strcmp(value, "PGP"))

This line was added in patch 3. It errors out precisely when gpg.format
is "PGP", no? That this doesn't break the whole series is explained by
1) it being removed in this patch 4, and 2) there being no tests. It
makes me wonder if something like patch 5 (test gpg.format) could be
part of patch 3, both with negative ("= malformed") and positive ("=
PGP") tests?

> +               j = 0;
> +               for (i = 0; i < ARRAY_SIZE(gpg_formats); i++)
> +                       if (!strcmp(value, gpg_formats[i].format)) {
> +                               j++;
> +                               break;
> +                       }
> +               if (!j)
>                         return error("malformed value for %s: %s", var, value);

`if (i == ARRAY_SIZE(gpg_formats))` and drop `j`?

Or check whether `get_format_data()` returns NULL? Hmm, well you can't,
since it takes its "input" from a global variable...

If you want to keep that global nature, the duplication of search-logic
could perhaps be avoided by having a helper function for returning the
index of a gpg_format (or -1).

>                 return git_config_string(&gpg_format, var, value);
>         }

Martin
