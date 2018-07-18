Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C70471F597
	for <e@80x24.org>; Wed, 18 Jul 2018 19:12:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729126AbeGRTvm (ORCPT <rfc822;e@80x24.org>);
        Wed, 18 Jul 2018 15:51:42 -0400
Received: from mail-oi0-f50.google.com ([209.85.218.50]:43713 "EHLO
        mail-oi0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728038AbeGRTvm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jul 2018 15:51:42 -0400
Received: by mail-oi0-f50.google.com with SMTP id b15-v6so10839411oib.10
        for <git@vger.kernel.org>; Wed, 18 Jul 2018 12:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=/N6v02zlKOtion3a8mvfB3zqdMVny2HDddQOV83oZdk=;
        b=lxvnbNvPp5xjNWRde4rCZWTlAk/v+IqLEWkg1MsUMiz+JUaHRmuNo9OWE925RxZUto
         MJV72V8adw65WmCsTGaWshtz7wnFHCSP8H2olKpczCGjFw6ewCGYL8ayPn+4Oe1UC8sc
         /cqHjVoP0i40fdXYtZrY8u7SPYltRrIN4GeFm0SCfuPaAC+0JpYbT/kQawBtQbUuFNYR
         GyfHlmtnovxUqqvkRF+axGBMfiPuK6wk6jfLEoPMb35uOpI0r2H30B8BMo+x97TuEaXr
         3u27WAWyQZymRJ5T3lbSq0zcSDfuqWBz5de6Z3wSTQB/ic/5yxp38tTNm8O0TDvsTJ/z
         tQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:cc;
        bh=/N6v02zlKOtion3a8mvfB3zqdMVny2HDddQOV83oZdk=;
        b=nrI3BdBS67Ina9fbRMGkJ1y2EAMpaPT7FgB8WuggDhTaJBG+FWWSzbkPWaihzRZ/1H
         qRs58+i6wbFEiJWZi29vpGGi+vTcX2pIBk9bu07d0M9QqX2NxP9RMQzrNnGrDg6yx7/A
         afJkY5i3UPZHM4+m3ILG33S6VDpHVkb2g7x1gHUXlfK3bwLsP65sq0S13lbGTzp5ZSMi
         QGNorRON6J4Ab0CeOYLiXtRpPI6jrHFD7AeVCoHa+Zf1XADiYHyr51PqbIXPseofr/o+
         7t5HJ8v+0OUaqTyR44SP3JHfCKWnuqTsfskOBFwz4/ErVEwTFjKL5p5a4wBUIY2plltH
         6uNg==
X-Gm-Message-State: AOUpUlHCopI+t3eN8z0kS4CEhXuQf2lboXa3dJwzduisWmu0mLRU+2hE
        5DjwyVbbOkLHT3V2KeAqB9uZTgMX1uJR3k5lfBM=
X-Google-Smtp-Source: AAOMgpdNQToFRKVehTjhohpoBeU18ZK+FQfgfeWIT+ejA/gvbsahJYmN/wiBabBRIXtbmEUrcXptx37FZ1wFfu8fZfc=
X-Received: by 2002:aca:4808:: with SMTP id v8-v6mr7305748oia.259.1531941145509;
 Wed, 18 Jul 2018 12:12:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:c689:0:0:0:0:0 with HTTP; Wed, 18 Jul 2018 12:12:25
 -0700 (PDT)
Reply-To: noloader@gmail.com
In-Reply-To: <CAH8yC8nRE7+faKbmvM2bHWPE4hzvhL4RF4i5Gxt4mhseDEzdnQ@mail.gmail.com>
References: <CAH8yC8nef0iPVLqnkcJ2fh=N8jCM=tK1DXJJe+nx8cOL8K9D6A@mail.gmail.com>
 <xmqqtvowjuxp.fsf@gitster-ct.c.googlers.com> <CAH8yC8nRE7+faKbmvM2bHWPE4hzvhL4RF4i5Gxt4mhseDEzdnQ@mail.gmail.com>
From:   Jeffrey Walton <noloader@gmail.com>
Date:   Wed, 18 Jul 2018 15:12:25 -0400
Message-ID: <CAH8yC8=SfFAUhvqPp0f6wgr7yfAKpmNfT3Z61V4QfUVqUUnBYw@mail.gmail.com>
Subject: Re: sed: command garbled: rGIT-PERL-HEADER
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 18, 2018 at 2:47 PM, Jeffrey Walton <noloader@gmail.com> wrote:
> On Wed, Jul 18, 2018 at 1:49 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeffrey Walton <noloader@gmail.com> writes:
>> ...
>> diff --git a/Makefile b/Makefile
>> index 2ba24035f5..50138e85eb 100644
>> --- a/Makefile
>> +++ b/Makefile
>> @@ -2086,7 +2086,7 @@ $(SCRIPT_PERL_GEN): % : %.perl GIT-PERL-DEFINES GIT-PERL-HEADER GIT-VERSION-FILE
>>         $(QUIET_GEN)$(RM) $@ $@+ && \
>>         sed -e '1{' \
>>             -e '        s|#!.*perl|#!$(PERL_PATH_SQ)|' \
>> -           -e '        rGIT-PERL-HEADER' \
>> +           -e '        r GIT-PERL-HEADER' \
>>             -e '        G' \
>>             -e '}' \
>>             -e 's/@@GIT_VERSION@@/$(GIT_VERSION)/g' \
>
> Thanks, that tested good.
>
> Here's another one for FreeBSD 11 x86_64. LDLIBS includes -pthread.
>
> $ cat ~/git-freebsd.txt
>     LINK git-credential-store
> /usr/local/bin/ld: libgit.a(name-hash.o): undefined reference to
> symbol 'pthread_create@@FBSD_1.0'
> //lib/libthr.so.3: error adding symbols: DSO missing from command line
> collect2: error: ld returned 1 exit status
> gmake: *** [Makefile:2329: git-credential-store] Error 1

I was able to clear this one with sed (trailing space is important):

    sed -e 's|$(LIB_FILE) |$(LIB_FILE) -lpthread |g' "$file.orig"

But I don't know how to fix the missing recipe:

    $ gmake
    gmake: *** No rule to make target 'git-daemon', needed by 'all'.  Stop.

Jeff
