Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4EAA321847
	for <e@80x24.org>; Wed,  2 May 2018 15:19:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751310AbeEBPTO (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 11:19:14 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:44109 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751109AbeEBPTN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 11:19:13 -0400
Received: by mail-ot0-f194.google.com with SMTP id g7-v6so17002994otj.11
        for <git@vger.kernel.org>; Wed, 02 May 2018 08:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PRqrldpMcA0GkH4+8kG36IV/1KcDwtjr0XcTwdnrGAM=;
        b=OQm4xSegCI/ABwYv+1zGvmslyRYUW9nJOB6DvZZSQu8XcIJVmWvll6kyy4tms3AoGj
         12hRaguaQGhx699FgUQ7jubwkFhUeU3wzfNhd7xCN3CypXHNnFmbABWUlETqmJcd6Ayt
         4icsHGcJmrzddmw8iUK+jb7JkYiSDjeiEDVBA+f9R+x7yYheaBNw5LERM8xA1vSsPUcY
         5Z2oouCDze9s51Bc+LdEISsl00597MGpdnGpgGZ/6RTbuX3s/PEPDCyn+GpXErH/GjcR
         3gOf6+xKpcbik0kQ1Ndn5d/Wgjm86gSs7ftDY6hHvuYG+USsAMLsqtmU6i44UmoEofU6
         B2qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PRqrldpMcA0GkH4+8kG36IV/1KcDwtjr0XcTwdnrGAM=;
        b=LQ2KOlVxNNzBy5ZK99Ir3FjgXKpp7w1TyBGFm4yY23eSfNa1Fqa8jeLUb21Om25l4w
         upG32TIAysEBiGdi+S7z5u2ElN6KhVOG2B2qd5Ts9gzfXYa4y1RiRRHZYQraJVaXgVca
         9ZbHbbeKqVif0j2Zm7G/lIBjCTqYGdLo53BaNxpknUiIdnbvObJM8nsk6JGqBq05xVrn
         qfEKcYzsI+FImjF2PZPcBcyXaPiZwEO7Gjm8MMbxbrW+ue6J8Vq9pQZDWHO5tUe1ObpX
         hLURO8hI+uS7Ee4y+UEKzn8LPmabGlWYUFilYl8JtUiqwpSCCkhQibbSHhjWxeXzR96b
         Jdtw==
X-Gm-Message-State: ALQs6tD+KFifYNFEMzIxh2E4IwWq9otNDsZBGz2v4scp16YG2jGyEspk
        ptnUXnxQrGH79GQFun+PCCwoJjwDmouTKx3gSRY=
X-Google-Smtp-Source: AB8JxZoq6ddS/iR2failLAJIFfmUgC0RgJRSCeR+jsY5wHv9vLaTUNJ3PcSBb+dHE+eIE8lEp9T3cN9s19e7Wpif0go=
X-Received: by 2002:a9d:1d92:: with SMTP id y18-v6mr12989051otd.304.1525274352568;
 Wed, 02 May 2018 08:19:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.178.133 with HTTP; Wed, 2 May 2018 08:18:42 -0700 (PDT)
In-Reply-To: <6e2bfd3a6eb5270c809262f046e6a8b80090b352.1525253892.git.johannes.schindelin@gmx.de>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
 <cover.1525253892.git.johannes.schindelin@gmx.de> <6e2bfd3a6eb5270c809262f046e6a8b80090b352.1525253892.git.johannes.schindelin@gmx.de>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 2 May 2018 17:18:42 +0200
Message-ID: <CACsJy8D+h+7BXSs1cggRP_UQc5qvtu6ZtrtLiBcu-qLeTpz3Yg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] test-tool: help verifying BUG() code paths
To:     Johannes Schindelin <johannes.schindelin@gmx.de>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 2, 2018 at 11:38 AM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:
> When we call BUG(), we signal via SIGABRT that something bad happened,
> dumping cores if so configured. In some setups these coredumps are
> redirected to some central place such as /proc/sys/kernel/core_pattern,
> which is a good thing.
>
> However, when we try to verify in our test suite that bugs are caught in
> certain code paths, we do *not* want to clutter such a central place
> with unnecessary coredumps.
>
> So let's special-case the test helpers (which we use to verify such code
> paths) so that the BUG() calls will *not* call abort() but exit with a
> special-purpose exit code instead.
>
> Helped-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/helper/test-tool.c | 2 ++
>  usage.c              | 5 +++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/t/helper/test-tool.c b/t/helper/test-tool.c
> index 87066ced62a..5176f9f20ae 100644
> --- a/t/helper/test-tool.c
> +++ b/t/helper/test-tool.c
> @@ -47,7 +47,9 @@ static struct test_cmd cmds[] =3D {
>  int cmd_main(int argc, const char **argv)
>  {
>         int i;
> +       extern int BUG_exit_code;
>
> +       BUG_exit_code =3D 99;

It may be even better to let individual tests in t1406 control this,
pretty much like your original patch, except that we tell usage.c to
not send SIGABRT and just return a special fault code. That way we
don't accidentally suppress BUG()'s sigabrt behavior  in tests that do
not anticipate it (even in t1406).

But this patch is ok for me too if you don't want another reroll.

>         if (argc < 2)
>                 die("I need a test name!");
>
> diff --git a/usage.c b/usage.c
> index cdd534c9dfc..9c84dccfa97 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -210,6 +210,9 @@ void warning(const char *warn, ...)
>         va_end(params);
>  }
>
> +/* Only set this, ever, from t/helper/, when verifying that bugs are cau=
ght. */
> +int BUG_exit_code;
> +
>  static NORETURN void BUG_vfl(const char *file, int line, const char *fmt=
, va_list params)
>  {
>         char prefix[256];
> @@ -221,6 +224,8 @@ static NORETURN void BUG_vfl(const char *file, int li=
ne, const char *fmt, va_lis
>                 snprintf(prefix, sizeof(prefix), "BUG: ");
>
>         vreportf(prefix, fmt, params);
> +       if (BUG_exit_code)
> +               exit(BUG_exit_code);
>         abort();
>  }
>
> --
> 2.17.0.windows.1.36.gdf4ca5fb72a
>
>



--=20
Duy
