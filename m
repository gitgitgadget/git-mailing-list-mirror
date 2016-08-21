Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABE301F6C1
	for <e@80x24.org>; Sun, 21 Aug 2016 15:46:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754657AbcHUPpz (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Aug 2016 11:45:55 -0400
Received: from mail-qt0-f181.google.com ([209.85.216.181]:36656 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753425AbcHUPpx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2016 11:45:53 -0400
Received: by mail-qt0-f181.google.com with SMTP id 52so24095946qtq.3
        for <git@vger.kernel.org>; Sun, 21 Aug 2016 08:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9e0NYJzThSv6uW4ONcKUdmqtUXt6RyV/64OiLcQCtno=;
        b=RZm1SRr/EJR8jOY7+Zuua1pgi1xVPU0PoLqc4aqyqZw89FmEVk5m+5CvPfhSfmu3Jk
         bz7GPqXCFugFZFoFJlWeozGCRC0QnD52BQkOJqA8b2SEWcrgzUXkOzCIQD7N1zGvKK4A
         pMH0rxu67naOxQe0PhxaRginLkz60W918xUp8wh1dFrkZ+QfnqBHPIeht9CP88XWhqts
         Hu3VaLgYMn5fzTYUoJFIt+Phh/L+g5pbdLhBE5XENDBbv5fgHQDW27yzW6ZHcHP3iEFk
         FEH34bX4cIMyHFPEqGVlgu9J9Y7ARY0PRj8Ujr04/7s4wZlgHmySiTXvjeRtt2u++FhF
         BZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9e0NYJzThSv6uW4ONcKUdmqtUXt6RyV/64OiLcQCtno=;
        b=NBgxOjPqgXBNs751lWPWvowl/rnBMjsKrZ3tCLaIe754YB3RDpeVwLB5nC9NHzJhIc
         FqeeCzR9bUwOQ4X7HqJ5whCtx63cPHmhnA3abPJ/4ybVPgQBuPXVrXNnoZs37JYmgYwp
         Z1RQaD/PpvfZhgh15bG+S9BxnZn3atYC9br4uBM9g0k20Q/qnrC0X+or/xL36PhVbugK
         VCudnAtDhkf1M/6JArsEVFb3CZd0DlbKLtka90a62yxArTBr3jVKRtzolkR/3FGDLSM/
         E8FUVWxRkKP12kUsoVx1DNZJrScA7Mjf2xPBF4/auSdSRMLsYxr6W5wUWrxrQabH6oEt
         vHzQ==
X-Gm-Message-State: AEkoouuCDUtSA0JibYpOkXRuyTtwt/LiPq4tQv4RpUwQfxF8loxSUtigqmBguPC6bCzJueC5RN4K+ZrfykcB5A==
X-Received: by 10.237.54.34 with SMTP id e31mr18829895qtb.132.1471794352657;
 Sun, 21 Aug 2016 08:45:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.233.232.19 with HTTP; Sun, 21 Aug 2016 08:45:52 -0700 (PDT)
In-Reply-To: <4016813.pOBvC7ZxlR@cayenne>
References: <CANYiYbGL+GVRNuhszp1UShaN_oJgm3netsQxZfbW74pVK0gOYQ@mail.gmail.com>
 <9262712.D6TC1VHfMN@cayenne> <xmqqy43rxqqz.fsf@gitster.mtv.corp.google.com> <4016813.pOBvC7ZxlR@cayenne>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Sun, 21 Aug 2016 23:45:52 +0800
Message-ID: <CANYiYbEPOttPvixCrv2+nh_OEehE_fi8yrpdzbQ-axG4nqbsZg@mail.gmail.com>
Subject: Re: [L10N] Kickoff of translation for Git 2.10.0 round 1
To:     =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Alexander Shopov <ash@kambanaria.org>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Ralf Thielow <ralf.thielow@gmail.com>,
        Marco Paolone <marcopaolone@gmail.com>,
        Changwoo Ryu <cwryu@debian.org>,
        Marco Sousa <marcomsousa@gmail.com>,
        Dimitriy Ryazantcev <DJm00n@mail.ru>,
        Peter Krefting <peter@softwolves.pp.se>,
        =?UTF-8?B?VHLhuqduIE5n4buNYyBRdcOibg==?= <vnwildman@gmail.com>,
        Nelson Martell <nelson6e65@gmail.com>,
        Brian Gesiak <modocache@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

2016-08-21 2:38 GMT+08:00 Jean-No=C3=ABl AVILA <jn.avila@free.fr>:
> On samedi 20 ao=C3=BBt 2016 11:03:00 CEST Junio C Hamano wrote:
>> Jean-No=C3=ABl AVILA <jn.avila@free.fr> writes:
>> > 1.  In config.c, the changes to the function die_bad_number tried to
>> > flatten the translated strings (no message building logic). I think it
>> > went too far, and the reason of the failure can be factorized so that =
we
>> > don't have to retranslate each time. I might be wrong on this one, but=
 I
>> > have no example of language where we would need differentiated error
>> > reasons.
>>
>> I do not have a strong opinion on this one.  I think it is an
>> attempt to avoid language-lego.
>
> No problem with the changes for blob, files, command line. It's just abou=
t
> dividing by two the number of strings to translate by factorizing "out of
> range" and "invalid unit", which are invariable anyway.

I agree with you.  It maybe not a good solution to expanded string "reason"
in commit 1b8132d:

    -       const char *reason =3D errno =3D=3D ERANGE ?
    -                            "out of range" :
    -                            "invalid unit";


>> > 3. git-rebase--interactive, in this_nth_commit_message and
>> > skip_nth_commit_message are not localizable,
>>
>> As the "TRANSLATORS" comment alludes to, "This is the Nth thing" can
>> be rephrased to "This is the thing N" or "This is the thing #N"
>> easily, and if that form without ordinal is acceptable for many
>> languages, we should say that it is also OK in C-locale without
>> translation.  So I agree that the recent change was pointless (even
>> though the result may be localizable).
>>
>> In an ideal world, I would imagine that this would be done by using
>> Q_("This is the first thing", "This is the thing #%d", nth) aka
>> ngettext, but
>>
>>     (1) I haven't seen ngettext used from shell scripts; and
>>
> There's a use_ngettext macro
>
>>     (2) I do not think po files are set up to express "for this
>>         message, this language has 4 variants and here are the local
>>         rules to decide which one to use depending on the number,
>>         but the rules apply only to this message".  The Plural-Forms
>>         rule [*1*] seems to be global to a .po file, unfortunately.
>>
>
>
>> so I do not think we cannot do it with ngettext().
>>
>
> Let's cut it like this : first ten are literally translated, the followin=
g ones
> fall back to a general rule. All languages are treated equally. With more=
 than
> 10 squashed commit, you no longer really care if the numbering is pedanti=
cally
> correct.


It's boring to translate all these 30 messages, I prefer #N like:

    gettext "The commit message #\${n} will be skipped:"
    gettext "This is the commit message #\${n}:"


--=20
Jiang Xin
