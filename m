Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 63F431F404
	for <e@80x24.org>; Mon,  2 Apr 2018 21:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754317AbeDBVPf (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Apr 2018 17:15:35 -0400
Received: from mail-ot0-f182.google.com ([74.125.82.182]:37593 "EHLO
        mail-ot0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753218AbeDBVPe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Apr 2018 17:15:34 -0400
Received: by mail-ot0-f182.google.com with SMTP id y46-v6so17107807otd.4
        for <git@vger.kernel.org>; Mon, 02 Apr 2018 14:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=D3fEqwa7Ek1hoGRJIXSt6DXc3wE+m2cQLlG0lYmpsJY=;
        b=awmYzdQ7sdVRf9eG4Q0DKx24XA/1oezGs0huHUGGOmNOhX2TuHKbL+i4dLwKtmYH5c
         kJCq4L2cyi/UYQs1xi+brz6od7dQaME79rgosdRk0CfaeFMB4bS2VKMoF/cgInlgNB5q
         g3BM2OwP2Zo+ZPSHsOJtTOWRAlO9sehQ+euUiccEiAuULmN1UGuIhz45tXwmibfaJX9Y
         xermgWWxfHCDORH0dY43JSPI/3t5o5MuTrIysfZOousMiIGOwzvQ81mc0RIwyE0iQWPk
         E9nEtKco3lK+X8cbZnY+u76WRc4fm5kkR9uU1sOruZaiBQ09nk3iMuySZU5nD3/uDpM2
         nPmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=D3fEqwa7Ek1hoGRJIXSt6DXc3wE+m2cQLlG0lYmpsJY=;
        b=ZK1mc2qZ5+K/POXNyswRW50CVcjj69uy9G7qzdskUyRikT+iYR0KXjvy42W4wkBRD/
         SvD2eZUkKOZupAYFKT+NpZf2efRCXImrnw15RED9i6NhQln17qKP75tjKXg2leZVRd5J
         EkAayDSdf1gUpjBwVJxpniDvVdr4DVk7OQjCP+nKQ0bmZsyUsp3gZ/Xzn7+DMM91Hbc1
         nrJc8vIESk34/4xhUXuOwdXEbnLDDF3cKnJnXxcddRlBZn8tPzeth8QVm3BxUqOhXqmv
         OIhZEvv+1s5FrHwpJ7PZfATUP9yDsXg39JvqJQrqEUbqZs8DI7ygzVBoTJvSfGGdA+fG
         rTyA==
X-Gm-Message-State: AElRT7FSKXqBnG7RsP/zXJqfI8umu45jneM4BEiBmrPI464D78zv4UK6
        ATqaaFTr0aswAMWEarqMK/pxYgdDWofEVnk1uWJ52Q==
X-Google-Smtp-Source: AIpwx4+5hTXUck2rjtBIRnHkUCs5SlgcWiVopkH67Mh7uSdvzjv7GwJ/+ii++/BOhbKazPJQ068qC3y8jYTeCb/mqZY=
X-Received: by 2002:a9d:14ce:: with SMTP id r14-v6mr6197709otr.111.1522703734307;
 Mon, 02 Apr 2018 14:15:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.201.68.194 with HTTP; Mon, 2 Apr 2018 14:14:53 -0700 (PDT)
In-Reply-To: <xmqq1sfxz7t4.fsf@gitster-ct.c.googlers.com>
References: <20180402200736.80161-1-haraldnordgren@gmail.com> <xmqq1sfxz7t4.fsf@gitster-ct.c.googlers.com>
From:   Harald Nordgren <haraldnordgren@gmail.com>
Date:   Mon, 2 Apr 2018 23:14:53 +0200
Message-ID: <CAHwyqnXx86jHrDNhTphzT19egY=tdrS67L3Hs=XTcSBbxpwnZw@mail.gmail.com>
Subject: Re: [PATCH] ls-remote: create '--sort' option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I shortened the commit message. Since we already have this feature for
other sub-commands I guess I don't have to explain what version
semantics are.

Have to say I'm a bit confused about 'git send-mail'. This time I tried

    git send-email --subject-prefix="PATCH v4"
--in-reply-to='20180402005248.52418-1-haraldnordgren@gmail.com'
--compose -1

...and the supplied 'git@vger.kernel.org' on the prompt. hopefully
everyone received the latest patches. However, at least what it looks
like from Gmail / Google Inbox, the discussion is now split into two
threads. Hopefully the patches still make sense though.

I will post replies to the original email chain after this message.

On Mon, Apr 2, 2018 at 10:12 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Harald Nordgren <haraldnordgren@gmail.com> writes:
>
>> Subject: Re: [PATCH] ls-remote: create '--sort' option
>
> It would be more helpful to mark as [PATCH v2] a rerolled patch like
> this.
>
>> Create a '--sort' option for ls-remote. This is useful e.g. for the Go
>> repository after the release of version 1.10, where by default v1.10 is
>> sorted before v1.2. See:
>>
>>       $ git ls-remote -t https://go.googlesource.com/go
>
> Does this sample command line also need updating for the refined
> design?
>
>>       ...
>>       205f850ceacfc39d1e9d76a9569416284594ce8c        refs/tags/go1.1
>>       d260448f6b6ac10efe4ae7f6dfe944e72bc2a676        refs/tags/go1.1.1
>>       1d6d8fca241bb611af51e265c1b5a2e9ae904702        refs/tags/go1.1.2
>>       bf86aec25972f3a100c3aa58a6abcbcc35bdea49        refs/tags/go1.10
>>       ac7c0ee26dda18076d5f6c151d8f920b43340ae3        refs/tags/go1.10.1
>> ...
>> +     git ls-remote --sort="-version:refname" --tags self >actual &&
>> +     test_cmp expect actual
>> +...
>> +     git ls-remote --sort="-refname" --tags self >actual &&
>
> These both look sensible (also the variant without the dash prefix
> which I omitted from the quote).
>
>
>
