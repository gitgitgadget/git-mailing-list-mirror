Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E66261F453
	for <e@80x24.org>; Tue, 23 Oct 2018 15:45:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727730AbeJXAJF (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 20:09:05 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:37676 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726970AbeJXAJF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 20:09:05 -0400
Received: by mail-it1-f196.google.com with SMTP id e74-v6so2712959ita.2
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 08:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=VGOVCh7MFCQDTlXOuZiU5ABkdXM+bLmbjV1fV67aQgw=;
        b=YytoND/iE3v6kgNqCMWHAPPTkxduiDeLg883nXHt+00WDYjbsKxaw+KcjhShvRwyA4
         iV1cC2IHHtIcva1PNdzbdkgOoPTjGHd2HBMuyIiyn9kpXyPv52Rq/ZUte1IqciNdnH3S
         G5wM1iJjVkxhBy7+z1aFFBN3+poWfmPZyPu+9if5NTlno26nP3QaAjUvFTxiYDbReEU2
         z9TiRCt/VQUTIs7LRFhTxlOQ1qf1Np6HBhEF3Rp+rPsSNG9eXj5N57wHL91m6VC6cdm4
         HuUQ9xG9RbIn+ItNnJGtAiGj7y1P2PMUPRZewPGBRZD/PsO54lDJTYKI4Rcq9V2FG2LR
         XXOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=VGOVCh7MFCQDTlXOuZiU5ABkdXM+bLmbjV1fV67aQgw=;
        b=m8u2U0n4FGHy6wo6S80UyBPUgQ+tUJzaKSgKkkXbJdmUKUXl9DId7xkiNZwg5vfJ5Y
         w1tEvnlME1wWqQ/0/k6mTUYgTu/S4itT1ZGPfJbNINIOIaZ7LuqOGMy9YcxT9r7oKvMw
         YMqtg49ATUwsv3eSBGvm0TWkvMURNGI0TolVAMFQPm/JtbWbGaxIzuSYRg7oHB9FL/mI
         zxru9dXKrXGltXaozbET1MLp/zzy0/czSqdkfuAc+NpCcThzwVMdQmI7FEvpBbNkY3Ri
         QmrVVb+nr1ZQPyCRXH7lfM6iAZLzKtyhFfh3hxa0yqct/WE954O9S/pd4Xfj5rgybIJe
         bPPQ==
X-Gm-Message-State: ABuFfoiEt1jLaXrRx5AIsbMVh04oLHcESXgRzguND4SYSYH3PxtoLBL/
        bpeGTkSPmUHhv9np3qgfm42PmC1wFKSG+gn4Myg=
X-Google-Smtp-Source: ACcGV63n7aZD0yg2hYN7F0xqTKWkNU4gG7H9bbEWtiarpfN6vmr87IXjKKAyyK4oC4g7umW0xIxrRnsgrsmiODNjh+k=
X-Received: by 2002:a24:cd02:: with SMTP id l2-v6mr13183622itg.70.1540309509551;
 Tue, 23 Oct 2018 08:45:09 -0700 (PDT)
MIME-Version: 1.0
References: <20181023113416.90958-1-carenas@gmail.com>
In-Reply-To: <20181023113416.90958-1-carenas@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Tue, 23 Oct 2018 17:44:41 +0200
Message-ID: <CACsJy8AXjhbY9WWjYtMk128TZHLBCf4Ye4fe-ryXhoP9j2jtdw@mail.gmail.com>
Subject: Re: [PATCH] khash: silence -Wunused-function
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 23, 2018 at 1:42 PM Carlo Marcelo Arenas Bel=C3=B3n
<carenas@gmail.com> wrote:
>
> after 36da893114 ("config.mak.dev: enable -Wunused-function", 2018-10-18)
> macro generated code should use a similar solution than commit-slab to
> silence the compiler.
>
> Signed-off-by: Carlo Marcelo Arenas Bel=C3=B3n <carenas@gmail.com>
> ---
>  khash.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/khash.h b/khash.h
> index d10caa0c35..39c2833877 100644
> --- a/khash.h
> +++ b/khash.h
> @@ -234,7 +234,7 @@ static const double __ac_HASH_UPPER =3D 0.77;
>         __KHASH_IMPL(name, SCOPE, khkey_t, khval_t, kh_is_map, __hash_fun=
c, __hash_equal)
>
>  #define KHASH_INIT(name, khkey_t, khval_t, kh_is_map, __hash_func, __has=
h_equal) \
> -       KHASH_INIT2(name, static inline, khkey_t, khval_t, kh_is_map, __h=
ash_func, __hash_equal)
> +       KHASH_INIT2(name, __attribute__((__unused__)) static inline, khke=
y_t, khval_t, kh_is_map, __hash_func, __hash_equal)

Maybe move MAYBE_UNUSED from commit-slab-impl.h to git-compat-util.h
and use it here so we have an easier time if we have to use a
different way to mark unused functions on some exotic platform.

>
>  /* Other convenient macros... */
>
> --
> 2.19.1
>


--=20
Duy
