Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A3761F404
	for <e@80x24.org>; Wed,  7 Feb 2018 19:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754455AbeBGT4A (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Feb 2018 14:56:00 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:51335 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754320AbeBGTz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Feb 2018 14:55:59 -0500
Received: by mail-wm0-f53.google.com with SMTP id r71so5399721wmd.1
        for <git@vger.kernel.org>; Wed, 07 Feb 2018 11:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=psrxqK4S1Gi91//bELpUVF5WT+Foc9xH2wDQhagrj0w=;
        b=bO1KwkRyw1JUDBxHS4liRCc2xjYEkNHbS+8vUYCOj3cnb+iBSMYo2cWgOWysY5n/17
         y85KVo2RyWUoyWffBQ3jqBysxXrrfcp0FS5r9HV9yl/Qmm+oEu4PqtxQsNVdCrWWkTcf
         IlAoOVns5evfoTqyeIWTcvAN+Vqwqo6khuz1l5W61NWsvuG3d81G7CV4CXVdboBshMz0
         amIdon9QokAB9Q6p5HirrH6kjWWygJiZS1uT/ATAvBPFa18Gte72kjT4qnoHZjHcEbmG
         44z2RII2x9voOORTzIC3lc7PxFXsV2QNAFtO5wHstfghzfK0shhaSyDJGbjsFxUSFhoD
         U3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=psrxqK4S1Gi91//bELpUVF5WT+Foc9xH2wDQhagrj0w=;
        b=kh9eUkIFmLZeV09A16Fa772w31XWvrK+6K4zJmYGTp6GXkH+9CT0RtGL4SpiEHkzWK
         QB3SEEwyZzRJC8Qvw939Jsy58DMO0wZmVaePMI5WOAVqSfNBON9Ss++8sPGJYwHDLFAD
         flQ9emSwWlsrQM0KTy42PtbKKxwvMccRlKi11d2wQbWkVhoYM8Bx2EOg10dUy8QGWl5n
         oail5PJtVhHsiabqaj/EdG8SXhIjBrPebxmHAYcDh+9lbtKcbI6fy6+hlWYQYfPe0MAM
         xpAxiZ9kTP+bDy45TZlfscAujkFyq400najRSfg/aiuJskwBfA576ZjI2l1SZkjdzwRV
         IAow==
X-Gm-Message-State: APf1xPB9d8uzUGBlxlOlyeZjCTDEDZCJSnhvdqEi6JV/clDlUhTrjqie
        hl4+hHQ1c4rEs+/L/wfgAZU=
X-Google-Smtp-Source: AH8x224rrrKa/tzDk52zVLW2pEGZrxP9T9b36eoIRncZlvsBgDynFqjFX2xrpI6y7/ZGjjuLiC41zg==
X-Received: by 10.28.10.206 with SMTP id 197mr5432318wmk.61.1518033358196;
        Wed, 07 Feb 2018 11:55:58 -0800 (PST)
Received: from slxbook4.fritz.box (p5DDB5C1B.dip0.t-ipconnect.de. [93.219.92.27])
        by smtp.gmail.com with ESMTPSA id g127sm2525267wmf.5.2018.02.07.11.55.57
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 07 Feb 2018 11:55:57 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: "git branch" issue in 2.16.1
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <4F1475A5-DBD4-484A-9AB6-4DA57A8B8C7B@eluvio.com>
Date:   Wed, 7 Feb 2018 20:55:56 +0100
Cc:     Stefan Beller <sbeller@google.com>, Todd Zullinger <tmz@pobox.com>,
        git <git@vger.kernel.org>, Paul Smith <paul@mad-scientist.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <BF47061D-939A-46C4-95F3-B97B2889B4CC@gmail.com>
References: <2412A603-4382-4AF5-97D0-D16D5FAAFE28@eluvio.com> <20180206195754.GE1427@zaya.teonanacatl.net> <CAGZ79kaxf3qUyOe6R-LCgyLtwzrwhB=y767tk2qPbC_KR473ig@mail.gmail.com> <5A7788B0-6250-4D1F-A86D-E3155C03EF0C@gmail.com> <4F1475A5-DBD4-484A-9AB6-4DA57A8B8C7B@eluvio.com>
To:     Jason Racey <jason@eluvio.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 07 Feb 2018, at 19:09, Jason Racey <jason@eluvio.com> wrote:
>=20
> Hi Lars,
>=20
> Here=E2=80=99s what I=E2=80=99m certain of:
>=20
> 1. Just set up a new MacBook Pro at work. Git version 2.16.1 installed =
via Homebrew. =E2=80=9Cgit branch=E2=80=9D command always displays the =
list of branches in the less pager, regardless of number of branches or =
screen size. I=E2=80=99ve never seen this happen before.
> 2. Checked the =E2=80=9Cgit branch=E2=80=9D behavior on my personal =
MacBook Pro. Git version there is 2.16.0. Does not have this always =
paging behavior.
> 3. Ran "brew upgrade git" on personal MacBook Pro. Git upgraded to =
2.16.1.
> 4. Checked the =E2=80=9Cgit branch=E2=80=9D behavior on my personal =
MacBook Pro after version upgrade. Pager now always used regardless of =
number of branches or screen size. Oh no! Seems like there might be a =
bug in the new version, better email the git bug list in just to be =
safe.
> 5. Meanwhile research problem on Stack Overflow. Mitigated (though not =
really fixed) issue on both machines with this command: git config =
--global core.pager =E2=80=98=E2=80=99
>=20

That's great! Thank you. Can you share your exact OS version running
on your work and personal machine? Plus, what shell do you use and
what terminal application?

Thanks,
Lars


PS: Please don't top post on the git mailing list :-)
https://en.wikipedia.org/wiki/Posting_style


> Thanks!
>=20
> - Jason
>=20
>=20
>> On Feb 7, 2018, at 9:54 AM, Lars Schneider <larsxschneider@gmail.com> =
wrote:
>>=20
>>=20
>>> On 06 Feb 2018, at 21:05, Stefan Beller <sbeller@google.com> wrote:
>>>=20
>>> On Tue, Feb 6, 2018 at 11:57 AM, Todd Zullinger <tmz@pobox.com> =
wrote:
>>>> Hi Jason,
>>>>=20
>>>> Jason Racey wrote:
>>>>> After upgrading git from 2.16.0 to 2.16.1 (via Homebrew -
>>>>> I=E2=80=99m on macOS) I noticed that the =E2=80=9Cgit branch=E2=80=9D=
 command
>>>>> appears to display the branch listing in something similar
>>>>> to a vi editor - though not quite the same. I don=E2=80=99t know
>>>>> the technical term for this state. You can=E2=80=99t actually edit
>>>>> the output of the command, but you=E2=80=99re in a state where you
>>>>> have to type =E2=80=9Cq=E2=80=9D to exit and then the list =
disappears.
>>>>> It=E2=80=99s very inconvenient and it doesn=E2=80=99t seem like it =
was by
>>>>> design. I=E2=80=99m using zsh in iTerm2 if that helps. Thanks.
>>>>=20
>>>> In 2.16.0 `git branch --list` is sent to a pager by default.
>>>> (Without arguments, --list is the default, so this applies
>>>> to `git branch`).
>>>>=20
>>>> You can set pager.branch to false to disable this in the
>>>> config, or use git --no-pager branch to do so for a single
>>>> invocation.
>>>>=20
>>>> I can't say why you're seeing this with 2.16.1 and not
>>>> 2.16.0, but I'm not familiar with homebrew, so perhaps
>>>> something didn't work as intended in 2.16.0.
>>>>=20
>>>=20
>>> Maybe the number of branches changed since then?
>>> As the pager only comes to life when the output fills
>>> more than your screen. Quick workarounds:
>>> * buy a bigger screen
>>> * have fewer branches.
>>=20
>> Hmmm... there might be more to it. I just noticed the
>> pager behavior on macOS, too. Consider this call:
>>=20
>> $ git diff --shortstat
>>=20
>> This should generate at most one line of output. On Linux
>> the pager is never used. On macOS the pager is always used.
>>=20
>> I tried older versions of Git on macOS and experienced the
>> same behavior.
>>=20
>> @Jason: That might be a bug on macOS. However, I am surprised
>> you only noticed it after upgrading from 2.16.0 to 2.16.1.
>> Do you recall anything else you've changed?
>>=20
>> - Lars
>>=20
>=20

