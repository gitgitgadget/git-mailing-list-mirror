Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE81A1F597
	for <e@80x24.org>; Wed, 18 Jul 2018 18:47:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbeGRT0Z (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:26:25 -0400
Received: from mail-oi0-f45.google.com ([209.85.218.45]:39089 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeGRT0Z (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:26:25 -0400
Received: by mail-oi0-f45.google.com with SMTP id d189-v6so10723273oib.6
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 11:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=nKVPqv2wjHGM/qc7cFmQMyY3a5+zi6j9Z15kVKGgPsE=;
        b=D9kzRyXEwYg/sg5Oeznyd2bCc5V+hH0ZD8C6AlG9wNLGFl381dELmuOABi5QOoTSiV
         Utj3pBWRWibbHL+AVk7iIgbAN0IMDVb6eeAdOXWjTMtIWgp8cT0/rAbWYGh8zNoAv4rC
         CsIrsw8ESa4SIzODpdUpZoIz3Fq5qrBoLWNFDDYnl8BI5FKDr+pqY4Xg1hjHzprj44Py
         XV445k9TKginXyoYFfnstYWiOiv5W23RjGiJps7hSvJePRuxWcS10LS4SXWcAjdlwd9d
         bTyM5S9a7AkFfrzLRkvfAK3xg+cPWSie0SerqFQlRugwEP79IgYM57HgXpjRYJFPjzYm
         keJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=nKVPqv2wjHGM/qc7cFmQMyY3a5+zi6j9Z15kVKGgPsE=;
        b=TVbgGI+yEFRwOW3U/ue8L4sX5F0qIQ6gl+bgZHSJHkC7WHg1gOH35v3dM/fBiPpJMk
         YUngb4e7V93RZWabXg6H8qr6y22X+UmzZivVWwVfCLcMay6RnFJvXjgO4cqlkpYrp3I8
         Bsh8EE13MM7ObiNAwNDcBdViPjzn7foWEPoC1uBgSXXtGGxpjG8xINs3rKLD2vvpW6Aa
         EwFHLi5fpJnkaUia/nnv8tJtYCXjJ+h6mxQhUEb/DyA7VikSiyHUQetWqSHUEFY/iY/K
         u2QLIs7Q5eXRjOPTl820mqBiQDheqwpez1lJo5dtRY28ZX21vEdfAQatKuHpq7BMcND3
         igIw==
X-Gm-Message-State: AOUpUlGWk/n6ejvoYYMxyph5TJpmYPJdlmsBdj3jyd30YgbMbLLg9y3F
        rbCjDnlf3sAXO0fgSLEBuitu3v7GrItBlrNvmcvOt1vM
X-Google-Smtp-Source: AAOMgpe1FBl2ZV2Z/iU2C8fjoEngrNtNCIdqjl3nQSiQyS2ZUOZLTiw5TXl1NqY8ckexj5NS7nc5b9q5wc+fqRikzOA=
X-Received: by 2002:aca:42:: with SMTP id 63-v6mr7125282oia.154.1531939633527;
 Wed, 18 Jul 2018 11:47:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c689:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 11:47:13
 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <xmqqtvowjuxp.fsf@gitster-ct.c.googlers.com>
References: <CAH8yC8nef0iPVLqnkcJ2fh=N8jCM=tK1DXJJe+nx8cOL8K9D6A@mail.gmail.com>
 <xmqqtvowjuxp.fsf@gitster-ct.c.googlers.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 18 Jul 2018 14:47:13 -0400
Message-ID: <CAH8yC8nRE7+faKbmvM2bHWPE4hzvhL4RF4i5Gxt4mhseDEzdnQ@mail.gmail.com>
Subject: Re: sed: command garbled: rGIT-PERL-HEADER
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeffrey Walton <noloader@gmail.com> writes:
> ...
> diff --git a/Makefile b/Makefile
> index 2ba24035f5..50138e85eb 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -2086,7 +2086,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
>         $(QUIET_GEN)$(RM) $@ $@+ && \
>         sed -e '1{' \
>             -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
> -           -e '        rGIT-PERL-HEADER' \
> +           -e '        r GIT-PERL-HEADER' \
>             -e '        G' \
>             -e '}' \
>             -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \

Thanks, that tested good.

Here's another one for FreeBSD 11 x86_64. LDLIBS includes -pthread.

$ cat ~/git-freebsd.txt
    LINK git-credential-store
/usr/local/bin/ld: libgit.a(name-hash.o): undefined reference to
symbol 'pthread_create@@FBSD_1.0'
//lib/libthr.so.3: error adding symbols: DSO missing from command line
collect2: error: ld returned 1 exit status
gmake: *** [Makefile:2329: git-credential-store] Error 1

Jeff
