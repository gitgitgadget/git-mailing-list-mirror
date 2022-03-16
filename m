Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A82CFC433EF
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 10:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355156AbiCPKfE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiCPKfC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 06:35:02 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B281BE007
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 03:33:48 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id j83so2007700oih.6
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 03:33:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/5c6TnuWeaew5vRgKpXwaqLs/alGm68m8+8zMHPTIWs=;
        b=PkzNf97emYQpMgHZyJILAn+2Rf4f8Dmu50CEyJf6rSkboZHJjwA/7h2PsBWs9gO3jO
         +gV7QRhnLBnQXLoDy95EJHATeHEbqwsDGww/44DSmfBhSAeqzHxgeNdl6t5noZbngvCd
         Gim4drPxlFJuVI07BrF10uFn34n78zC4IaCCgVyVKzbhdM+a3fbJoxpB1sTfuwezhu7R
         7biOzbmy04lAK4g6P4oO+eQ0V9zDY/+Ns0QkEXc8EfzW/NXMiJ/wAJzK0MWeJJN/XV+9
         FRlP3CHRm5L5dSj4uQdNcRP5ClXOhALbssBVpn/dVmn2EVsTDAyhC7Ol/ZHzp9fo71L1
         dI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/5c6TnuWeaew5vRgKpXwaqLs/alGm68m8+8zMHPTIWs=;
        b=aKMiZPMTjWij0z3XW2A2APbXN7fYYqtosJXt+PGBte/e+SdtujgO2ZYYl9HDPsd7LO
         0rk9qTuQjJjnYw0clwJfNqJw/fgnjda5xLKzZD0f47+M984rtrUgIDXXUu4voueHoi4w
         FY3IcwGpTgLIfBBEOvtyKEOj/rGIvQPytEUt7/F6lObKk6MZi6XGoXKGKhxXXxSpuHaS
         um1ToFkHfWK16GMed+cjz/x0i12fT6/bB462UnnvfxaFj/i2ib8ntsuzLzBQkzkaWVrB
         YyvHk+SqwvDI7VL0hpHq2hdj7NcQTdApeh7jc4WzFha9now1LQYFKOGuRNZNsXPGE16J
         lkXw==
X-Gm-Message-State: AOAM533h0H9U2p4SJuOGj5Y6gii+HsKMM0PsvBmloCLeQW0+BonprNRl
        kviW7Bhk7FFhHmMWWbSlconzm5chcZY8+FRvuk5Ff4XTFnE=
X-Google-Smtp-Source: ABdhPJxnv+5etctXnlZwxaJADaBjRK4gwz7mXiTMZuTXLIIY8DrZ6Q0IZG34wwFu798+GKYBcefrIfQgsG3IyvyHLBw=
X-Received: by 2002:a05:6808:655:b0:2ec:ce86:303c with SMTP id
 z21-20020a056808065500b002ecce86303cmr3360977oih.217.1647426827662; Wed, 16
 Mar 2022 03:33:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220315131638.924669-1-gitter.spiros@gmail.com> <xmqqzglrfcas.fsf@gitster.g>
In-Reply-To: <xmqqzglrfcas.fsf@gitster.g>
From:   Elia Pinto <gitter.spiros@gmail.com>
Date:   Wed, 16 Mar 2022 11:33:38 +0100
Message-ID: <CA+EOSBnjYDQCcks-skZLzwDBLsC2-Ri_6eJKXNyrcA-BeeFyEA@mail.gmail.com>
Subject: Re: [PATCH] git-curl-compat.h: addition of all symbols defined by curl
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Il giorno mar 15 mar 2022 alle ore 16:47 Junio C Hamano
<gitster@pobox.com> ha scritto:
>
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
> > This file was produced from a modified version of symbols.pl
> > (https://github.com/curl/curl/blob/master/docs/libcurl/symbols.pl) and
> > by manually adding the previous comments describing the dates of release
> > of some curl versions not currently reported in the symbols-in-versions.
> >
> > To do this the symbols are listed in the order defined in the file
> > symbols-in-versions rather than as they were previously inserted based
> > on release dates.
> >
> > Most of these symbols are not used by git today. However, inserting
> > them all starting from an automatic tool makes it largely unnecessary
> > to update this file and therefore reduces the possibility
> > of introducing possible errors in the future.
> >
> > Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> > ---
> >  git-curl-compat.h | 2944 +++++++++++++++++++++++++++++++++++++++++++--
> >  1 file changed, 2875 insertions(+), 69 deletions(-)
>
> Hmmm.  While the basic idea may be sound, I do not think this alone
> would be sufficient out of the box.
>
> > diff --git a/git-curl-compat.h b/git-curl-compat.h
> > index 56a83b6bbd..dc9086710a 100644
> > --- a/git-curl-compat.h
> > +++ b/git-curl-compat.h
> > @@ -24,25 +24,1228 @@
> >   * doing so is sufficient to add support for it to older versions that
> >   * don't have it.
> >   *
> > - * Keep any symbols in date order of when their support was
> > - * introduced, oldest first, in the official version of cURL library.
> > - */
> > -
> > -/**
> > - * CURL_SOCKOPT_OK was added in 7.21.5, released in April 2011.
> > - */
> > -#if LIBCURL_VERSION_NUM < 0x071505
> > -#define CURL_SOCKOPT_OK 0
> > -#endif
>
> Even though you define GIT_HAVE_CURL_SOCKOPT_OK macro below, the
> existing codebase is not expecting to handle the lack of
> CURL_SOCKOPT_OK by checking the macro.  Instead, it expects the
> macro to be defined to be 0 for older versions, exactly like this.
>
> And you do not give a replacement definition.
>
> > -#if LIBCURL_VERSION_NUM >= 0x071900
> > -#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> > -#endif
>
> This is an unfortunate oddball that lacks _ between GIT and CURL.
>
> $ git grep -e '#define ' --and --not -e GIT_CURL_ git-curl-compat.h
> > -#if LIBCURL_VERSION_NUM >= 0x071900
> > -#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> > -#endif
>
> You define GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE but naturally,
> existing callers do not pay attention to it.  They care about the
> oddball variant GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE instead.
>
> Luckily, these two are the only irregulars, it seems.
>
> $ git grep -e '#define ' --and --not -e GIT_CURL_ git-curl-compat.h
> git-curl-compat.h:#define CURL_SOCKOPT_OK 0
> git-curl-compat.h:#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
>
> So, I think you would need a bit of preliminary clean-up patch
> inserted before this automated compatibility layer, perhaps like
> this.

Hi

In the end I did not understand if you think it is worthwhile that i
do a reroll of  the patch, making a series of patches that put all the
preliminary patches like the one you reported.

Thank you all
>
> --- >8 ---
> Subject: curl: streamline conditional compilation
>
> Earlier we introduced git-curl-compat.h that defines bunch of
> GIT_CURL_HAVE_X where X is a feature of cURL library we care about,
> to make it easily manageable to conditionally compile code against
> the version of cURL library we are given.
>
> There however are two oddball macros.  Instead of checking
> GIT_CURL_HAVE_CURL_SOCKOPT_OK and using a fallback definition for
> CURL_SOCKOPT_OK macro, we just defined CURL_SOCKOPT_OK to a safe
> value when compiling against an old version that lack the symbol.
> Also, the macro to check CURLOPT_TCP_KEEPALIVE (alone) was named
> GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE.
>
> Introduce GIT_CURL_HAVE_CURL_SOCKOPT_OK and define it for the
> versions of cURL where we used to use our fallback definition for
> CURL_SOCKOPT_OK, and use the fallback definition based on the new
> GIT_CURL_HAVE_CURL_SOCKOPT_OK symbol at its sole use site.
>
> To better conform the naming convention of other symbols, rename
> GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE to GIT_CURL_HAVE_CURL_SOCKOPT_OK
> and update its sole use site.
>
> After this, conditional compilation with cURL library is all
> controlled uniformly with GIT_CURL_HAVE_X mechanism.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  git-curl-compat.h | 2 +-
>  http.c            | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>
> diff --git c/git-curl-compat.h w/git-curl-compat.h
> index 56a83b6bbd..802d11e7be 100644
> --- c/git-curl-compat.h
> +++ w/git-curl-compat.h
> @@ -39,7 +39,7 @@
>   * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
>   */
>  #if LIBCURL_VERSION_NUM >= 0x071900
> -#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
> +#define GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
>  #endif
>
>
> diff --git c/http.c w/http.c
> index 2f67fbb33c..8d9a66b5ca 100644
> --- c/http.c
> +++ w/http.c
> @@ -517,7 +517,7 @@ static int has_proxy_cert_password(void)
>  }
>  #endif
>
> -#ifdef GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE
> +#ifdef GIT_CURL_HAVE_CURLOPT_TCP_KEEPALIVE
>  static void set_curl_keepalive(CURL *c)
>  {
>         curl_easy_setopt(c, CURLOPT_TCP_KEEPALIVE, 1);
> @@ -537,6 +537,9 @@ static int sockopt_callback(void *client, curl_socket_t fd, curlsocktype type)
>         if (rc < 0)
>                 warning_errno("unable to set SO_KEEPALIVE on socket");
>
> +#ifndef GIT_CURL_HAVE_CURL_SOCKOPT_OK
> +#define CURL_SOCKOPT_OK 0
> +#endif
>         return CURL_SOCKOPT_OK;
>  }
>
>
