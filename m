Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D6411F667
	for <e@80x24.org>; Mon, 21 Aug 2017 09:37:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbdHUJhl (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Aug 2017 05:37:41 -0400
Received: from mail-pg0-f52.google.com ([74.125.83.52]:33279 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751814AbdHUJhk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2017 05:37:40 -0400
Received: by mail-pg0-f52.google.com with SMTP id t3so68858864pgt.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2017 02:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PTwbbhU21yHN/e6USW/uwMWJOzXnHqA5AMrU9LGgnjI=;
        b=Y+A+SnJREzaTQCqUEt5UAn6YDrBaCJaRXRAYZJDxVFGwW9x6+/M8IYYF3aQ7bYL7Sd
         mGiRGXYvvm8E8g1SBH/L62BxL8h9Myt1jboWnebVNBe1RRpeslBv6NwOFslxFRwi4K9i
         dYR2DdOirrWCTZgIiiNdHVITL2ERMKXtOjNvyEPk62ESGkilN645XhmWk7Er8CJW8yzm
         mEb7sIGsjWH28GTo4h9miK0Q6UlEbrq2pwlGePIJLalGSGIfxs5ufEtD1JzTYEwtcLOa
         CF8l89fkZ8s2Ul7ZSSkPGHoUO+bKThX77HwDdzhc+f0PSM7tMidLFyPdxNEfcFeSMQBh
         DFXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PTwbbhU21yHN/e6USW/uwMWJOzXnHqA5AMrU9LGgnjI=;
        b=D6GVdzf41DOEJqfNA5Gga6ss04B0Vc3tnUukvhdKJ447a3wdI8S8Jf2VPt8HaVgRR1
         tNdkG5sLYYhzb/xorFFnCtJOtdKpsliN7jP8YapqbRbCUNJOQh1MUkm5HJofsSM2ftA6
         JNqmRBkocdGBsm8grcrD0te46pF+WcDab4HC3FZlYtAQuY41ubN6DLsSMaUBaW2KO8Ej
         MuXeO8INEywBbnzep4HVDA/wntaJJeEdtT6CuVUd6VPxqtn6kufBFW8HgjO0y8XX0747
         zSbVAeDnWjG8tpdawTqdTE0nZA+fJC4D+jea741n5IFPW6kLRWOr7dxytmt2MZ98tx/m
         3Hzw==
X-Gm-Message-State: AHYfb5hi3IGoofC5OXDXLw4p9H54fr9FV1nzYAbXq6tB+HY0g4z72fyb
        PPJdXJfQEgDxnQsaMqqmUCy0IMxdrA==
X-Received: by 10.84.129.6 with SMTP id 6mr18992265plb.289.1503308260250; Mon,
 21 Aug 2017 02:37:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.162.37 with HTTP; Mon, 21 Aug 2017 02:37:39 -0700 (PDT)
In-Reply-To: <CAJXxHvVzTrhJk6pFsOzUKBuU2VcW41-tMk5A7s+rxXsacXpppw@mail.gmail.com>
References: <CAJXxHvVzTrhJk6pFsOzUKBuU2VcW41-tMk5A7s+rxXsacXpppw@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 21 Aug 2017 11:37:39 +0200
Message-ID: <CAN0heSrh_+J=LQnGZtngxQbcHAjFhX9vPKKDa7_ORz4iDpXf=g@mail.gmail.com>
Subject: Re: "Your branch is up-to-date ..." is incorrect English grammar
To:     STEVEN WHITE <stevencharleswhitevoices@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The code base contains a few instances of "up-to-date" and "up to date".
A tree wide sweep could be made to update user-visible strings in the
code and in the documentation. Fixing source code comments seems like
overkill. Could I count on you to review any changes I'd propose? (With
respect to the English, that is.)On 21 August 2017 at 10:21, STEVEN
WHITE <stevencharleswhitevoices@gmail.com> wrote:
> Either of these two options is CORRECT:
>
> =E2=80=9CYour branch is up to date =E2=80=A6=E2=80=9D
>
> =E2=80=9CYou have an up-to-date branch =E2=80=A6=E2=80=9D
>
> But =E2=80=9Cyour branch is up-to-date=E2=80=9D is INCORRECT. And, becaus=
e it=E2=80=99s
> incorrect, it conveys an odd and unsettling experience to native
> English speakers whenever they read it.
>
> If you=E2=80=99re curious, you can find plenty of discussion of this poin=
t of
> grammar. Here=E2=80=99s just one example:
> https://english.stackexchange.com/questions/180611/do-i-keep-myself-up-to=
-date-or-up-to-date-on-something.

There is also some previous discussion on this very list:
https://public-inbox.org/git/CALFtnmeRxgetuCVbO8ZmVkCR302vQ2s4hTPoHxAe5NEfm=
jtXEg@mail.gmail.com/T/#u

The code base contains a few instances of "up-to-date" and "up to date".
A tree wide sweep could be made to update user-visible strings in the
code and in the documentation. Fixing source code comments seems like
overkill. Could I count on you to review any patches I'd propose? (With
respect to the English, that is.)

Obviously, if you'd like to attempt a patch, that's fine by me. :)

Martin
