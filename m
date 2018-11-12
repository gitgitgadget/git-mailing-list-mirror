Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C75EC1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 13:29:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbeKLXWu (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 18:22:50 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41941 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeKLXWt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 18:22:49 -0500
Received: by mail-wr1-f67.google.com with SMTP id v18-v6so9354451wrt.8
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 05:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SF/uEpDPn3kCkkAf+pBRhcszXWwfin3OZtHDwu8t3dM=;
        b=Il0naz/r9ZddBLjZBg4Toi83s05y2wB1ffwjEUEY1IxCqRqtNjUSR9eul/9h+l8Fie
         mlfB+jPpTU+Jj4n6L4rnhupCHvhRvX49ZN1DifMkoy4GJnrBXzh/h3jZr2cv7qvbwxQD
         YMw6Lvm05B7q/aApRhWeyI1rWJFrYtbJB1HtsSIsJ6v9bhPjrBLQosbJekVtS4XNscMF
         wN9fKvM90/gy6+Hxxf+AFwAqIDP8mDqI0Gi3OLMModdHR5Dn1Qakg/XcTy9T5YBiIrTD
         TQyOeSOWVQYgf16eaI+O6FzPynSGbGdDrFaQaBmrtTCBiHWUejUgyo5jm/lF6eS7Jxvk
         DHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=SF/uEpDPn3kCkkAf+pBRhcszXWwfin3OZtHDwu8t3dM=;
        b=YmpBz/IhBC9r6X5yiNTv3X8MNtzNw8Kqy42NcsdrVhZVxshSYFTdi9QsA17xQ5p80j
         4RfFKf9HQg/feUC3rijkr7OBRwkvdFTvjJNv69R0TT3Wr6EYgoQQQeH88N6/1EjcrcCg
         /nzsiwaJ/Jqal7kCSJE8MalCHYAm827oTf9GtCOqwoT+hNRqW07PoXyMjlEH/0YowXUa
         insH5RHL2esqSvSOvO46EpkuuQQjr+Lh/x6vhS9s2wx0tawwyrHmaEkVAIccf9w646rB
         /Co9gHg91WdApxl/QB/WKCsftjxaRW9D9Wcj//c/1k3Umh8cFp4gkP/RXmJGIu0ygbDm
         Yh+Q==
X-Gm-Message-State: AGRZ1gLwjRbDGVb5WV6NqcYsUI3SsT9zYpSHD0uNYYY2ZRH6jvdyggPM
        IsOJX5XTiPMefRHO3ZlxeHI=
X-Google-Smtp-Source: AJdET5dzBz7WBh9hvDfiIt8IJvyVguOviPm8bnB7vWYR8OpY1crA6U7j/XnUIv/auuGbwLPlfuKE0A==
X-Received: by 2002:adf:c084:: with SMTP id d4-v6mr1001531wrf.268.1542029370997;
        Mon, 12 Nov 2018 05:29:30 -0800 (PST)
Received: from [10.1.40.31] (lneuilly-656-1-270-140.w81-250.abo.wanadoo.fr. [81.250.160.140])
        by smtp.gmail.com with ESMTPSA id 142-v6sm1508822wmt.19.2018.11.12.05.29.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 05:29:30 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: Add issue management within git
From:   Martin Delille <martin.delille@gmail.com>
In-Reply-To: <87pnva3b1y.fsf@evledraar.gmail.com>
Date:   Mon, 12 Nov 2018 14:29:29 +0100
Cc:     Konstantin Khomoutov <kostix@bswap.ru>,
        yan ke <yanke131415@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <B21E6BA4-2C48-452A-A0F4-A337117590DF@gmail.com>
References: <881C01A7-82BB-4A4D-9CDC-6ECDA451B12B@gmail.com>
 <CAJosSJ4_PXrXUxn0WfFcR90SbDL0UWRRGPpxEjVwc=3NwWP+Jg@mail.gmail.com>
 <20181112085335.r5mk6b3l4faloayn@tigra> <87pnva3b1y.fsf@evledraar.gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Thank you very much!
The git-bug project is what I'm looking for even if it is not very =
interesting without gitlab connection.
There is an issue about it on Gitlab: =
https://gitlab.com/gitlab-org/gitlab-ce/issues/50435
Maybe some encouragment from git core developer would help!
I also proposed to change the project name here: =
https://github.com/MichaelMure/git-bug/issues/73

Regards,

Martin
martin.delille@gmail.com

> On 12 Nov 2018, at 10:22, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =
<avarab@gmail.com> wrote:
>=20
>=20
> On Mon, Nov 12 2018, Konstantin Khomoutov wrote:
>=20
>> On Mon, Nov 12, 2018 at 09:35:31AM +0800, yan ke wrote:
>>=20
>>>> This would be awesome to handle issue directly with git:
>>>> Having an offline version of the issues synced to the gitlab/github =
issues.
>>>> A lot of work is done on the issues and it is lost when migrating
>>>> from one service to the other.
>>>> Beside we don=E2=80=99t always have a good internet connection.
>>>> There is already a kind of integration between commit message =
fixing
>>>> issue automatically when merged in the master branch (with =E2=80=9Cf=
ix
>>>> #143=E2=80=99).
>>>   Very very agree, now it is very difficult to find a solution when
>>> has some problem such build problem an so on! The mail-list is good =
to
>>> send patch es, but is it not suitable for problem track or problem
>>> solution search!
>>>   Now the Github or Gitlab is good to track issues, suggest to open
>>> the git issue track!
>>=20
>> Please don't hijack the discussion: the original poster did not =
question
>> the workflow adopted by the Git project itself but rather asked about
>> what is colloquially called "distributed bug tracker", and wanted to
>> have one integrated with (or into) Git. That is completely orthogonal
>> story.
>=20
> Correct, but let's assume good faith here and presume yan ke just
> misread the original E-mail. Many of us (and perhaps yourself) are
> participating in our second, third, fourth etc. language on this list =
:)
>=20
>> As to searching for Git issues / problem solutions - I'd recommend =
using
>> the search on the main Git mailing list archive [1] and the issue
>> tracker of the Git for Windows project [2].
>>=20
>> The communities around Git also include the "Git Users" low-volume
>> mailing list [3] (also perfectly searcheable), and the "git" tag at
>> StackOverflow [4].
>>=20
>> 1. https://public-inbox.org/git/
>> 2. https://github.com/git-for-windows/git/issues
>> 3. https://groups.google.com/forum/#!forum/git-users
>> 4. https://stackoverflow.com/questions/tagged/git
>=20
> Yeah. I'll add to that that this specific thing has been discussed =
here
> really recently:
>=20
> =
https://public-inbox.org/git/CACSZ0Pwzs2e7E5RUEPDcEUsa=3DinzCyBAptU7YaCUw+=
5=3DMutSsA@mail.gmail.com/
> https://github.com/MichaelMure/git-bug/
>=20
> So Martin, there's already a nascent tool that does this. It looks =
like
> the main thing it needs now is users & testers.

