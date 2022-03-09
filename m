Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A084C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 13:02:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231416AbiCIND4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 08:03:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbiCINDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 08:03:55 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1B7934B87
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 05:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646830970;
        bh=l3kfII0CfI//GjQL0ppAd0Iy0tEJeTxz2VGb6nFMN0k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dYl85YOZlI6jCXlw5Nc72xRePGVWl0ma9KYNqy3n2Y13b+DpLgbbTcs0qMxRL2WkR
         0jjDByHccHT2GDhKSxRdnKB2uwI6zJyp4chKgVtZSYJdwNsON9HHR34zjNGzMLj4Yo
         jDOsQuPbGLjxWbefvigdhL2GRZSSQh0bRdiHW32Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MbivM-1o0S28002I-00dEVo; Wed, 09
 Mar 2022 14:02:50 +0100
Date:   Wed, 9 Mar 2022 14:02:48 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Jacob Keller <jacob.keller@gmail.com>
Subject: Re: win+VS environment has "cut" but not "paste"?
In-Reply-To: <xmqqmti1u20m.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203091320140.357@tvgsbejvaqbjf.bet>
References: <pull.1117.git.1643050574.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.2202200043590.26495@tvgsbejvaqbjf.bet> <220220.86bkz1d7hm.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2202221126450.4418@tvgsbejvaqbjf.bet> <220222.86tucr6kz5.gmgdl@evledraar.gmail.com>
 <505afc19-25bd-7ccb-7fb2-26bcc9d47119@gmail.com> <nycvar.QRO.7.76.6.2202251440330.11118@tvgsbejvaqbjf.bet> <xmqqv8x2dd7j.fsf@gitster.g> <xmqqee3i2mlw.fsf_-_@gitster.g> <220304.86mti6f4ny.gmgdl@evledraar.gmail.com> <nycvar.QRO.7.76.6.2203071649100.11118@tvgsbejvaqbjf.bet>
 <xmqqmti1u20m.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1771250885-1646830970=:357"
X-Provags-ID: V03:K1:insgxiyeXwRJ3169ly8/nwnKe9Us56NTcVcaR7/sLXV/qdUaFql
 0R+Zyvb4msB45v921cM6YZb8XaOVuKzeDd24E+Ax9NA1/AQrWeN9w8KHLyaR7Q1pgwRqqp7
 kJXPTUXXqrQFx3mrVvuhxH4GmNEt/S84aiijj8szudcr1lHHpkmmsuDqPWN2hh8bIrSVVC+
 Ob3goXorBstvUmzeQrfbQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:f7bi54o0ANo=:wQNgd+haF8Uvyjxr6GpTDw
 DDMI6BXETYnqRIGf6aYSPMTfpjYxiupN6Ag7TqLZ4TrytKYda7qUQk/rw/Ubbf5426h77gSSY
 XSZMTW/WUhx48ZDLI5qlIEZN8j7yCveUjjugG3eZx+AVKF6zgK+owAYStAsGBQeQ/n9wuUVJ1
 YtD/AKNQGZfSxQaT4/2Ky1hW1+43z7VFPnJ5VGpz/QTgq1S+YHi7SGPKaP7sh8lmoFE43PifD
 BmfIJee8jKpVA6cgewMSiqkqOZSy0L0iKSQrom/4S9l9rlu5RZU3sJA7Gicmc06qKmq7JFQQ0
 S696QaNLi3m0EyFg30wSr3n1S3KdTIWLKTvQtG71LpvKw3YDw4YEj4RBCXhL/JlZJkawWiRyZ
 iRQkRlFQF1wqOvftLUry6C76BqkrGMjpeJchVKRSgqB/7We4Q7mi7oiOXUcz0xmkE6sPFpZCP
 H1Uk4SxQEU8Ifb7t3IfDxE+aPlDhC5z/AUkcKEQZv19Q2Ew992B78x0sVae0YR7AnD6Tzl1kO
 7Kf7gzZPPjyrgN+XfxpauVZ6+VIQWXtBtkW1LJMie2mduEW8Fuit3Jf6XSl9QhJ6TsRT/Q7BD
 nWrMjTiDD5NkoJuy3swuGn7OSb64p3YgQqA2sGrVUQ/C3FdIZxcGEHXZHR3A+4LUPz7XcozzR
 ZUs/ShgyFKHaX2QtAN8LVKGAGNXWNA5Q8hbzpwXD32YHLBaqBiUH+PrR23+IlxiFt6/Jx8pdF
 env1koIScIpL4dj3z3djRcGMWe9Qcz0Sqh74x2WHT7A7V9ouoiAIeGQNG4o8V4DV0kPIRGHm3
 2yuEUme03SpokesHxPy5oD+IniFRUabNxbRSZF4OqDA0Mxfob4xPCutZlvdSKKnns5NzEEnDS
 VkI+xNsAut2lBrn+ELaDtBIE+r8+Ic/W/UJOvfWvskmejlMiQvMW4XnOLFzabnPNhIMKdVubN
 Sg5M1dRwf3+dwl68wgPWo1JtmI1ntugkfHv+zrXK2DOKrx2MFae+kH0xdlP5xLm+/sOAAuyUe
 WY5R9DTAGQAuL8piX1KJpP4bd3cUEn9fcGIMpLONKtElwue/HQFKLV0QrBMQggoGkn738/qiy
 xkCJ6CaV7z21jg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1771250885-1646830970=:357
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 7 Mar 2022, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > I said that the current output is only useful to veterans. The output =
that
> > hides the detailed log, under a separate job that is marked as
> > non-failing.
> >
> > That's still as true as when I said it. :-)
>
> I think getting rid of the separate "print failures" CI step and
> making it more discoverable how to reveal the details of failing
> test step is a usability improvement.

I'm so glad you're saying that! I was starting to doubt whether my caring
about getting rid of that `print failures` step was maybe misguided.

> I am not =C3=86var, but I think what was questioned was the improvement
> justifies multi dozens of seconds extra waiting time, which is a
> usability dis-improvement.  I do not have a good answer to that
> question.

It is definitely worrisome that we have to pay such a price. And if there
was a good answer how to improve that (without sacrificing the
discoverability of the command trace corresponding to the test failure), I
would be more than just eager to hear it.

I did consider generating a HTML-formatted report that would then be
attached as a build artifact. But that would hide the relevant information
even worse than a "print failures" step.

Maybe I should just get rid of the grouping? But that _really_ helped me
when I investigated the recent "usage string updates" vs "FSMonitor"
problem, because the test case boundaries were so much clearer.

Plus, as far as I saw, GitHub workflow logs always scroll to the end of
the logs of the failing step, which would not help _at all_ here.

So I dunno.

> I am probably nearing to be a veteran who knows when to brew my tea
> in my work cycle, and waiting for an extra minute or two while
> browsing CI output is not a problem for me.

:-)

> But new "non-veteran" users may not share that.  That is something a
> bit worrying about the new UI.

Indeed. My goal, after all, is to improve the experience of contributors,
not to make it harder.

Still, given that you currently have to click quite a few times until you
get to where you need to be, I have my doubts that what this patch series
does is actually making things slower, measured in terms of the total time
from seeing a failed build to being able to diagnose the cause by
inspecting the command trace.

Ciao,
Dscho

--8323328-1771250885-1646830970=:357--
