Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C90B1F406
	for <e@80x24.org>; Wed, 13 Dec 2017 05:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750916AbdLMFip (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Dec 2017 00:38:45 -0500
Received: from mail-wm0-f41.google.com ([74.125.82.41]:36436 "EHLO
        mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbdLMFio (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Dec 2017 00:38:44 -0500
Received: by mail-wm0-f41.google.com with SMTP id b76so2664943wmg.1
        for <git@vger.kernel.org>; Tue, 12 Dec 2017 21:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=TlCz8g0XqI/BBX3Kvn8NKkxZEIumj+2tgFUGwWncnR4=;
        b=IYFDYpRNu0xAs/Y0tQplNvvIUc852jqibvN9ncMJX4AwJKPuhsZErDqTV2ZK36qh2I
         7gFIdTEtaNCvQBchMnXEAcxW87yfRc8Ix49nCFv4yg916i+bf8Yn9Ih+v/3SUjfdZmRU
         H17ky9aQlAhJlRt/XCZZ1yWWED9ym1lUHYOS+atJjO8ezE9daLBhhZhtHADaQZyoRmvf
         N7BZY6YSbiFITS6aVqTjJdUto8YqYzN4qHWfqOwbvm7rbdReaIpogBRSVxM96yDPNM7f
         MOfC0HX1mAs6cJZgnOF1BtpOgXK3uETb3S/1ip8Q2GraQLBMeoaxNOGxKqqumE7nkuHa
         axnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=TlCz8g0XqI/BBX3Kvn8NKkxZEIumj+2tgFUGwWncnR4=;
        b=nznVzFF229xWPpLoLNXPpqjKi3+xmGz/KQGMnP8Ai3Q5jcPGYRfH4P4USuZYIT7Woq
         S6qfUy0atyhQxqFx66oqJ7jrdtNbRecc523TP2TYqtJqne6OKy51YgidS53bPzwy81rr
         RmQvI+g7s1iDLFPW1OZSRV1IAF4uaGEV8VNZsznIna0PN39X0Pal5tJNJvaFaZGIw5B+
         HAX6NZ+7QCd1633JepmFRInGwZOKq9XrWozoxbNRNSfXwKeAOMqt90hLlPh8TCXxsHiK
         C9ZMA5OBPzV3ViM/wOac6wXL7vOLxk8C8nbcMBZgd//IHCRN0ZtKFgkZrPqloNGNlJdD
         fmgg==
X-Gm-Message-State: AKGB3mKz7s9JAnCskfumyH423JoqcuhR0IU2ODgJD9Hllk/ZNdF6XSXv
        uQBTs5iNQf3C1sRVO0a1V2Qqb46qkhKk60Nj6idrcQ==
X-Google-Smtp-Source: ACJfBouPBj6gH5HK+seqSPuWjsnW01G+KNWbb+XmMHEiaJPPiYRQj/S6+58HPlD9Bc08fMI0/Dop63ek0gmbHo6JEzA=
X-Received: by 10.80.182.217 with SMTP id f25mr6249935ede.104.1513143523144;
 Tue, 12 Dec 2017 21:38:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.80.174.252 with HTTP; Tue, 12 Dec 2017 21:38:22 -0800 (PST)
In-Reply-To: <xmqqo9n320ep.fsf@gitster.mtv.corp.google.com>
References: <1513077862-165-1-git-send-email-jacob.keller@gmail.com> <xmqqo9n320ep.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 12 Dec 2017 21:38:22 -0800
Message-ID: <CA+P7+xqR0C_Z5fJFdSBvzqCT=LU-mK0cdtaqJ=6TH5Ty60PQrg@mail.gmail.com>
Subject: Re: [PATCH] doc: clarify usage of XDG_CONFIG_HOME config file
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Yaroslav Halchenko <yoh@onerussian.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 12, 2017 at 11:47 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.keller@gmail.com> writes:
>
>>  --global::
>> +     For writing options: write to global user configuration file
>> +     rather than the repository `.git/config`.
>>  +
>> +For reading options: read only from global user configuration file
>> +rather than from all available files.
>>  +
>>  See also <<FILES>>.
>
> OK.
>
>> @@ -237,26 +235,30 @@ See also <<FILES>>.
>>  FILES
>>  -----
>>
>> +If not set explicitly with `--file`, there are three locations where
>>  'git config' will search for configuration options:
>>
>> +System-wide configuration::
>> +     Located at `$(prefix)/etc/gitconfig`.
>>
>> +User-specific configuration::
>> +     One and only one of the following files will be read
>
> We said "will search for" upfront, but this talks about "will be
> read", leaving the reader puzzled as to what should happen when
> writing.  Perhaps "s/read/used/"?
>

Ok, that makes sense. I'm definitely iffy on all this wording, as I
didn't really like the previous approach, but couldn't find anything
better than the approach shown here.

I'd be welcome to suggestions for another way to format this information.

>> ++
>> +- `~/.gitconfig`
>> +- `$XDG_CONFIG_HOME/git/config`
>> +- `$HOME/.config/git/config`
>> ++
>> +If `~/.gitconfig` exists, it will be used, and the other files will not be
>> +read. Otherwise, if `$XDG_CONFIG_HOME` is set, then `$XDG_CONFIG_HOME/git/config`
>> +will be used, otherwise `$HOME/.config/git/config` will be used.
>
> And then "and the other files will not be read" can be dropped from
> the first sentence of this paragraph?
>
> Yaroslav on the original thread mentioned that reading codepath
> without --file or --global does not limit to one of the three, and
> this section is about "If not set explicitly with `--file`", so we'd
> need to make sure if the above is what happens in reality (or update
> the proposed clarification to match the reality).

I'm pretty sure it does not read XDG_CONFIG_HOME unless ~/.gitconfig
is missing. I tried a few things, but it was 2am for me, so I may be
mis-remembering.

Either way, I'd prefer if we had explicit tests in the suite which
verified our assumptions.

Thanks,
Jake

>
> Thanks.
