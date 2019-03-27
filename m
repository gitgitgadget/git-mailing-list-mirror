Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A08AC20248
	for <e@80x24.org>; Wed, 27 Mar 2019 11:22:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727328AbfC0LV7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Mar 2019 07:21:59 -0400
Received: from mail-wm1-f44.google.com ([209.85.128.44]:35425 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbfC0LV7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Mar 2019 07:21:59 -0400
Received: by mail-wm1-f44.google.com with SMTP id y197so16345343wmd.0
        for <git@vger.kernel.org>; Wed, 27 Mar 2019 04:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=/P8LCkdfOAuCLjKfgGKW1jswTnNHMbdKu4We5wwBOag=;
        b=Angxj9eFDTcn7b8RyLelOEyP7HxYQooqiAkJyDRnNPHlekOHaONifiFNl+B9EBD/x5
         qHwMHSGf0NzwLbHRarHrJvQuEW6DQQpzaMqWW6WYKClQeK2DdWE8mLl0bl14WLAfoGTY
         HbC8mRZIbfT6bsd5k1E6usC2jMby+XDKb+30OkZvWGphNVSPtBzf6x3IlzdVvpIbNDUa
         nkAvL2CmBK6LzpvlCzve5KXSujU0feOmvJelLVd+KRI+X0d2iqaW4F04+PSvWMx9PON1
         XqoVAZd0SA9KGfjVlFIE0Dgg/Dga1b3ouqMKgsjcannPjlosyxmmiWnXL6AKIeZcniDe
         zQuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=/P8LCkdfOAuCLjKfgGKW1jswTnNHMbdKu4We5wwBOag=;
        b=KA49Y957bsCp4njMS0BPwvbtw7PcQrrEL41/lG4RDPZFNtbwjZyP81u+K85qUQWB5m
         LWu52NabNvkw4fSveZxnPIXOOB2FfCwQUavku08Muhej2m4//hsX9lPq0uZzGfI970Vf
         dg+sCLfV4JsgaZXHIYb4I07BVu2+HzePyiaE8q/2mzADJfiAON7onn+3cEW9RnG8kGop
         fcwNCSxSXQ1DoAS72LOAhDcvvxgmw2rAFh9c2PXE9P3YE6rokchAFXpW+JvfYOUdFcTh
         uvkFwIQ8OMihSHK0D+6jTnhXHnC4aYyaclI6GFIxeSlb4d/DgNcG2Tgims1pPbzAyV96
         5NBQ==
X-Gm-Message-State: APjAAAVU3O/0q6Yp+S8Ph+sR1tAVzOnx4PEejTuPYcCzfrmIzf1vGO2O
        9w7jsX1dBuT13u4ej0ZkJUO9wQ0l
X-Google-Smtp-Source: APXvYqxXwU5m51oY8eCjpoFlkS4iOVdMcnA6zIDtz2Yg6U/pOTP9ijbPWtP26b2lK4l9eDMGcSjXmg==
X-Received: by 2002:a05:600c:21c3:: with SMTP id x3mr8283839wmj.90.1553685717200;
        Wed, 27 Mar 2019 04:21:57 -0700 (PDT)
Received: from evledraar (dhcp-077-251-215-224.chello.nl. [77.251.215.224])
        by smtp.gmail.com with ESMTPSA id n19sm19535581wmk.35.2019.03.27.04.21.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 27 Mar 2019 04:21:56 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Elijah Newren <newren@gmail.com>, Mooga <contact@m-mooga.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [GSoC] microporject test_path_is_*
References: <38B8E527-2338-485E-8840-29121F259687@m-mooga.com> <CABPp-BHwUoqk79Kf=ynna5x+mCJyOLz66v6pDieyEeM7YCRS+g@mail.gmail.com> <877eckbpdd.fsf@evledraar.gmail.com> <20190327104935.GD32732@szeder.dev>
User-agent: Debian GNU/Linux buster/sid; Emacs 26.1; mu4e 1.1.0
In-reply-to: <20190327104935.GD32732@szeder.dev>
Date:   Wed, 27 Mar 2019 12:21:55 +0100
Message-ID: <874l7obm0c.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Mar 27 2019, SZEDER G=C3=A1bor wrote:

> On Wed, Mar 27, 2019 at 11:09:18AM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> > There are likewise several that use one of
>> >    ! test -e path/to/filename
>> > or
>> >    ! test -f path/to/filename
>> > or
>> >   test ! -f path/to/filename
>> > which could be replaced by
>> >   test_path_is_missing path/to/filename
>>
>> Interesting that for some we use the 'test_is_there/test_is_not_there'
>> pattern and for others 'test_is_there [!]'. E.g
>> test_path_exist/test_path_is_missing v.s. test_i18ngrep.
>
> It's unclear what the '!' should negate in case of 'test_path_is_file
> ! file'.  What if 'file' does exists, but it's not a file but a
> directory, socket, fifo, or symlink?  'test ! -f file' returns success
> in these cases as well.
>
> OTOH, it's quite clear what the negation should mean in case of
> 'test_i18ngrep'.

*Should* we make it better? Yeah sure, maybe. I'm just pointing out for
context to someone poking at this for the first time that now we
sometimes do "! foo <arg>" v.s. "foo <arg>" as "foo_is <arg>" and
"foo_not <arg>" and other times "foo [!] <arg>".

So yeah, maybe we should improve things to disambiguate the cases you
mentioned, but right now e.g. "test_path_exists" and
"test_path_is_missing" are just "test -e" and "! test -e", respectively.

The same caveats you've mentioned also apply to "test_i18ngrep" b.t.w.,
there we squash the 3x standard exit codes of grep[1] into a boolean,
and thus e.g. ignore the difference between <file> not matching an
<file> being a directory or whatever.

1. http://pubs.opengroup.org/onlinepubs/009695399/utilities/grep.html
