Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06153C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 14:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230521AbiG1O2C (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 10:28:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiG1O17 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 10:27:59 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C1354AF5
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 07:27:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1659018473;
        bh=MPxRpTb86wb5vKpabVAwmizl5OY69BF4MO92fAL43qg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=i9t0oUk2tzs6P75RzCBU3KAQNeXZsBX7FwMtO8aCRtAot1HU7r7zWh5hnvc4F368G
         JCW3Dw2JrpQFL5i+bnS+tGI0v6b9O/7S1fe2tgZm2evuzp/lpgbtcXhdmUEHeOzDRn
         zr2Da4WeIiKuRajn9cUxq0gsAwf5Btx7QkGfljMQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.196.158] ([89.1.214.237]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M7Jza-1oOjzx2FWm-007pEx; Thu, 28
 Jul 2022 16:27:53 +0200
Date:   Thu, 28 Jul 2022 16:27:53 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Paul Smith <paul@mad-scientist.net>
cc:     git@vger.kernel.org, Jay Berry <jb2170@selfadjointoperator.com>
Subject: Re: [PATCH] Use 'Everything up to date.' instead of 'Everything
 up-to-date'
In-Reply-To: <18f324b9934982d577c0d9b0631d33818574df00.camel@mad-scientist.net>
Message-ID: <7n9r5q74-9qr1-29sr-p2n5-943n01s0p78r@tzk.qr>
References: <pull.1298.git.1658908927714.gitgitgadget@gmail.com>         <220727.86r126lxt0.gmgdl@evledraar.gmail.com> <18f324b9934982d577c0d9b0631d33818574df00.camel@mad-scientist.net>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1728798649-1659018474=:231"
X-Provags-ID: V03:K1:Kk5vvM3DUc9g2cgvjpXlAFuXkJ7B+KOZnhqfZi0IevW8MqBUOEN
 fdwYkAICBSxvgT1GYukCe4zcPnl4JVAzOk+enDZgVn5yoOGU6io67I29udcJvU7Dtk2imQk
 WHRvotnLOv+WdKktfbp9QB6xlOvKcRQHVnihMiF1oWYMftP5VPGezVf6bPzBuoT3Z7vRDXj
 HXuUKw3W8Z/2+39ByHCuw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:K989+USHGck=:f/thTGMlWilMVRFtKpoB2x
 HVn/O7Qw8Ehcod5xVvSsmQPlHdaarthul986XCtHNTY+XhexqE1QAhLNakOPLZln0w6Lk7shu
 1vt5Hzc9mi8L7zaaHYLTLotV8Vxv62PKRO74lfGLNe8iIPj4uB/oYIlh59Fu6UdGErFlVuGUI
 6I7xld9+uJxtEdkFZF/DVxNHuhkFF8/phhA+6NGBNPozty3AmXdXu3BSoh8yFERdZCbu9XeKS
 DXoO9daNtdmU151XfBNB5wnAlY3CCHMLxE8iKlU0OwV/2MXFdrc0pnE2DyiuYn9HDSIF+FqGj
 EUONn2rTxQGzdql+7fsvlzaIk17BaKgVBRb4b4IQWid7L3tZ3hg/3nNjRJlWM3ssWzVdHudWj
 rwRYaOG5Z28kYG8MXM9pJfCm7o5yd9Qq1kYgh49BJsUYczMeyjElExhED8b+fyzexUjnT1uMt
 TMjjmxldyPt2ctV+mB2mSxApMByY7A37i3GjRejVzwEz/WoCJJFx+lhjE+JHSpnQhyYkNXVdk
 WhGlAxg9kjmlVbjjSkthPSXB4Db0DCXSxsBpaK7yHkWrrScoaMMMshVqvZfLjeQkCg3Mv0PDv
 AyAaAKiIBKjz/xExRoBuq45nZ+UwsNsdjaN9D3RNXg8FsvfULc8XSg4+TWFjM4Cb4+rQxvZn9
 bxzruZLA9GDj2u6LzIHumQ9mSCYD6ddHg+7/V79uLtdlHKiAjXXE7QZs41FxcmJR2oWkIkPQE
 g4LCQX94zg2bJKl84J+mV65E8GD7fAdP7HkdaNqUpU8zcaVx6KxOFXeyod35x1UJEGdjJXUQZ
 oFfXTI2bml5Jg0Fi3KboftutJKdtBrqO1onuBKVWRsS1sIz240BZZaqVU6OrbARTYQYInj0Yk
 xOfDDz0sQp32HKx6P2ng==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1728798649-1659018474=:231
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On Wed, 27 Jul 2022, Paul Smith wrote:

> On Wed, 2022-07-27 at 11:15 +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n wrote:
> > That "don't" is up for discussion, but a subsequent re-roll should
> > argue it based on the points raised there.
> >
> > If we *are* going to change this then:
> >
> > =C2=A0* We should mark this for translation with _()
> > =C2=A0* Don't have the translation include the \n
>
> If no change to the text is wanted, then maybe a patch should be
> applied that adds a comment to the code saying that these strings are
> left as-is and not localized intentionally, to avoid similar issues in
> the future.

Matthias A=C3=9Fauer said it best at
https://github.com/gitgitgadget/git/pull/1298#issuecomment-1196410927:

	These two are plumbing messages that where intentionally left out
	of the last effort to correct uses of "up-to-date" to "up to date"
	faf420e05a9 (treewide: correct several "up-to-date" to "up to
	date", 2017-08-23), 7560f547e61 (treewide: correct several
	"up-to-date" to "up to date", 2017-08-23).

This makes it not only clear why they have not been changed, but also why
they are not translated: those messages are not intended for human eyes,
but for programs to parse.

I like the suggestion very much to add comments above these two remaining
dashed "up-to-date"s. Paul, would you mind coalescing the information you
received into a commit message, adding the comments instead of changing
the messages, and submit the next iteration?

Thanks,
Dscho

--8323328-1728798649-1659018474=:231--
