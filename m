Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 319301F461
	for <e@80x24.org>; Mon, 26 Aug 2019 15:24:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbfHZPYz (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 11:24:55 -0400
Received: from mail-vk1-f196.google.com ([209.85.221.196]:35727 "EHLO
        mail-vk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbfHZPYz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 11:24:55 -0400
Received: by mail-vk1-f196.google.com with SMTP id b184so4054755vkh.2
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 08:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ep+zA656f6s6N+nwJr0SXdR4EfcB39F+JUxZ4xWG13M=;
        b=YCgU5C/nSuBNS9kv4Z/BV3u6gBz5Hdce35ejFhccXLkA6Zov9+JOI8+qtjkyMiKZDD
         PLa2Rmb4+8FtMAzFtpl+IXQKbsh73Utbgku876qDOMAyIejMfrSic98rw/0c/qg9H+YI
         s2vWn7ZCZEYMrsxkpuq+cMme2l3RIa3novLmS3WK/rq4WKelNhUEdy2z56+TPWubozIB
         f+33xvk3ExSWRntRjSR6LOv8Nke7ZiAneR4qwOr9PUPIqwNWefYM6JWleS5ZKU7jSrr9
         LHPrqx+jnzZKar/NmQY+IBZvziHYR1nd9fLEpmotsOrzOUoLAxUn5BKWNhAlBuNhB/3r
         bHRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ep+zA656f6s6N+nwJr0SXdR4EfcB39F+JUxZ4xWG13M=;
        b=B1FIT/fxenm6Gi0WmCaoBPUenKsPkrUSwQlFW0VXxGuVUggqqhataRq7U/L+7r0/i/
         MY9oGKsveMEeYcep65GTBaoiE2k51cMcr4s8O64BoACfhYQRSS6SYnlNVDJvMgoWrOmV
         BVHSqR5Mknoy7cORFIlShAGEwHgN47xUzVlOGvqlETpsyxb6BTJgOmfTNR0B+Uwdv2+F
         xzSFLEDWZfSS709J0vT1XM0kXZNssEKGwydxWMTz0YaPReFmqV+R8Tg2YICLBa26ztyM
         nQ63KTPnq+W2HsuT19DB0lPMOLnyCk2RGYrAEojLkcaY765MSamfPNhrQgDCtt5pQkAs
         jBOQ==
X-Gm-Message-State: APjAAAULaXyAbA6RrSUCyrvnQdUD5KkCDLeDxYb+UdiPE8uwJHRiKAxM
        3DpK4aRHiIfhPQ5mF0FFhQr/nbf5Rti6xmzTIRc=
X-Google-Smtp-Source: APXvYqwFvD1LtqdohBQNpBb7bbePxKDjVcBUM3G0RVsnXAD/IS0HvET5v91DE9ygAt0vPF9b3XbrxYb9DfgWkNtVP9k=
X-Received: by 2002:a1f:5fc4:: with SMTP id t187mr8429415vkb.37.1566833094298;
 Mon, 26 Aug 2019 08:24:54 -0700 (PDT)
MIME-Version: 1.0
References: <pull.314.git.gitgitgadget@gmail.com> <pull.314.v2.git.gitgitgadget@gmail.com>
 <b9a68598d79724849995283e6967f1c52843c048.1566830682.git.gitgitgadget@gmail.com>
In-Reply-To: <b9a68598d79724849995283e6967f1c52843c048.1566830682.git.gitgitgadget@gmail.com>
From:   Garima Singh <garimasigit@gmail.com>
Date:   Mon, 26 Aug 2019 11:24:45 -0400
Message-ID: <CAN+QWEZU2FqkH1jWnv==owKLsMk8XNXJh6PpF6njvB6MmKt+Dw@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] quote: handle null and empty strings in sq_quote_buf_pretty()
To:     Garima Singh via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Garima Singh <garima.singh@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review Junio! I really appreciate it and look forward
to hear what you think of the updated patch.

Cheers!
Garima Singh


On Mon, Aug 26, 2019 at 10:44 AM Garima Singh via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Garima Singh <garima.singh@microsoft.com>
>
> The sq_quote_buf_pretty() function does not emit anything when
> the incoming string is empty, but the function is to accumulate
> command line arguments, properly quoted as necessary, and the
> right way to add an argument that is an empty string is to show
> it quoted, i.e. ''. We warn the caller with the BUG macro if they
> pass in a NULL.
>
> Reported by: Junio Hamano <gitster@pobox.com>
> Signed-off-by: Garima Singh <garima.singh@microsoft.com>
> ---
>  quote.c          | 12 ++++++++++++
>  t/t0014-alias.sh |  8 ++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/quote.c b/quote.c
> index 7f2aa6faa4..6d0f8a22a9 100644
> --- a/quote.c
> +++ b/quote.c
> @@ -48,6 +48,18 @@ void sq_quote_buf_pretty(struct strbuf *dst, const char *src)
>         static const char ok_punct[] = "+,-./:=@_^";
>         const char *p;
>
> +       /* In case of null tokens, warn the user of the BUG in their call. */
> +       if (!src)
> +               BUG("BUG can't append a NULL token to the buffer");
> +
> +       /* In case of empty tokens, add a '' to ensure they
> +        * don't get inadvertently dropped.
> +        */
> +       if (!*src) {
> +               strbuf_addstr(dst, "''");
> +               return;
> +       }
> +
>         for (p = src; *p; p++) {
>                 if (!isalpha(*p) && !isdigit(*p) && !strchr(ok_punct, *p)) {
>                         sq_quote_buf(dst, src);
> diff --git a/t/t0014-alias.sh b/t/t0014-alias.sh
> index a070e645d7..9c176c7cbb 100755
> --- a/t/t0014-alias.sh
> +++ b/t/t0014-alias.sh
> @@ -37,4 +37,12 @@ test_expect_success 'looping aliases - internal execution' '
>  #      test_i18ngrep "^fatal: alias loop detected: expansion of" output
>  #'
>
> +test_expect_success 'run-command parses empty args properly, using sq_quote_buf_pretty' '
> +       cat >expect <<-EOF &&
> +       fatal: cannot change to '\''alias.foo=frotz foo '\'''\'' bar'\'': No such file or directory
> +       EOF
> +       test_expect_code 128 git -C "alias.foo=frotz foo '\'''\'' bar" foo 2>actual &&
> +       test_cmp expect actual
> +'
> +
>  test_done
> --
> gitgitgadget
