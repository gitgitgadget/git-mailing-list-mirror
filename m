Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0924C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 19:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiCATid (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 14:38:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236904AbiCATic (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 14:38:32 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B79BE275DA
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 11:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646163463;
        bh=nrFan1Rh+fgdqnldp9A6/ucYOdYGXH+PiKjEecaaSyE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fu1KQFmGGy5BH+f0aro4nsOF8NN/rgncG3aNKvwQc9HHxQLYiyRdLWxYTeirAyjFE
         LAqncoQPOVTqL3hLizidPpDM/HW8WjYeUhu0CWnIBRWrzjC0GOV/QKZM0n5eh7Q1sw
         fwPVzDvEVG0dtKjCwXAYzx0FJdbJ+FhA9gdN/zHI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXhA-1nbh7l0CH4-00MdIM; Tue, 01
 Mar 2022 20:37:43 +0100
Date:   Tue, 1 Mar 2022 20:37:41 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH v4 2/2] parse-options.c: add style checks for
 usage-strings
In-Reply-To: <xmqqzgma287n.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2203012024210.11118@tvgsbejvaqbjf.bet>
References: <xmqqtuck3yv2.fsf@gitster.g> <20220228073908.20553-1-chakrabortyabhradeep79@gmail.com> <xmqqzgma287n.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-231018794-1646163463=:11118"
X-Provags-ID: V03:K1:+O4+R+Ve0gR8/96cDCXF/U0SXbQld33INzRkem6zB/ILlcWbP+3
 RXNjt2DONtEKtMGkCcSGO4A0qDHzasydLkNDvkLQm2Qd0Ui31APpmU9hB8tVheYgOmUYkrK
 VpRh+PoRVbhz/MsfofPZxBYpCAN+lZRXULl7Kl/No3QuRkeTLyjPDV4xO4GohEAk3BfdM6k
 DZY1jsb0zJhX2FYG+DoUg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ntmhXkP70f0=:L1Z54KvxwRXsxUs/3d2qWN
 swWgqlZtumzRxSRNtwEbIwc8Gslfit17UTRQfQundDEksLbKT1ahZw/3jl4qD9Q02HAUSTzNu
 qrKK40A6g4DZTAG8I8ik9AFxeD5FsBL61gJy6ImQ3AKW04tgO+dbk4Ke8vUMR9Ytpv3SUQ9HK
 tMqpKkl4XaTztsDtqH7Y7LOEYMn/oGGCB2K8nlJJrvgTwIzi0VfKldPoR2CX3JWNsigdjdmCi
 6xKE7jyiMeoDXe7u8C6ZJwnPZLMKte2vDuarMgDGBZ1u0JabhdlqqSj1QZHgUPA6j0r+1v00H
 MXKGckKdtIy6lIKVrEpymoOWdx9hvCv8AM/n53teHEihJXnj0hQpGPHVRIvzUq51JSGtcY6uR
 hzAOHPZ07Zs5Wae1EDP3TRnVA6BbrGELf9ydKU3Mn/NFFCDNFgmEk3ABavxM/8nHegVQZgxS1
 4XktosEAjDmNPg5+RLmzECXDDvA7OB6vyn50VpSt051Q+InLXOA+jLk26QVEQcs0mf9pQGNDi
 fRUQsM05MmQrnGy918HfGDeQaxbBBj1PiMbPVC9TWhaQiHOrg0bTKncCt6LOGxwv4Fh1qB//B
 YPbzpM4F8fD1xYVRDLfHlZ1F8ml+KRvND6Sfnegml3Fkp1iq49a7qOqgrFwUQZPdkyPCJe3ym
 5xgyjFLWIkvXnHETcKoIP0GBjSITCkbYLG3+nGdd3iLd5NREKx2YwhyBtejdq1bzpCCg0JKIs
 QLN28BoorU49PMWkMVvCdJ/4TI4UAFXZ3Qg+SLf7yP21eOECnhIYfffyt0vx3FsICDuh5iJ7s
 lVzDDmjJrF9XEpLongiVtLBDh5YfJ2yI/YD7h5eU5l/zffyOMpfp8D9dVqm6EKQRs5mxXxLZd
 xeG9Od1uZpExEs0gmJCiGe/fupWNEFQGrejD3/R4fBDmTAc/fhq3V3QQdknaLKd2nq8gYMPbR
 gBxwtFQTR+Lag7wD42EBHnRoSPImr5j6HScrWFCX+W80zojs8luMpU33hku4YNHD/FB+hCSlK
 W5OFpMeii1Sr0F3ufLrFTrguwfHqp4y3y2dKXzPJ9PD2QcdEvNtY9hcqgwvvc4wTS3GeeGiUG
 2uSaHTnpx+bS2Q=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-231018794-1646163463=:11118
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Mon, 28 Feb 2022, Junio C Hamano wrote:

> Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com> writes:
>
> > Okay, that's great. But one thing I want to ask - How the discussion
> > for `adding check for usage strings` will be held i.e. Whether the
> > idea is discarded for now.
> >
> > If it is not discarded, then how to proceed? Johannes prefers the firs=
t
> > version and =C3=86var prefers the `add check to parse-options.c` versi=
on.
>
> My take on it is that the "first version" that uses an ad-hoc shell
> script will not become acceptably robust.

It is unfortunate that the challenge had been characterized as "parse C",
when in reality we are talking about highly idiomatic code. It's not like
we accept arbitrary input in the `OPT_...()` lines. We _really_ want the
option usage string to be a string that is enclosed in `N_()`.

Additionally, this is about Git's own code, not arbitrary C code provided
by users. That makes that shell script more on par with `t/chainlint.sed`
than with `contrib/coccinelle/*`.

Having said that...

> If coccinelle or other static analyzer can help us check more reliably,
> that would be great because we won't incur runtime cost of checking,
> like the embedded check we added in the latest version that we are
> tentatively removing.

I think that Julia gave us enough to work with, so we can (ab-)use
Coccinelle for static usage string checks, and we should probably do that,
too.

> I also think Dscho simply overreacted only because the check broke
> an in-flight topic that is from his group, which is not universally
> built, and the tests in it was written in such a way that the error
> output from the embedded check was not immediately available when
> run in the CI, making it harder to debug.  None of that is a fault
> in the approach of using the embedded check.

No, I would have reacted the same way if I had seen the failures in any
other topic, with an equally trivial fix that blooms into 42 separate test
case failures.

This explosion made me realize _why_ I found the suggestion to patch
`parse_options()` iffy in the first place: it replaces a static check with
a runtime check, which is almost always something that is regretted later.

And since Abhradeep is a new contributor, I found it important to steer
the direction toward sound advice that they can use over and over again
over the course of their career: whenever possible, prefer static checks
over runtime ones.

> If the embedded check were there from the beginning, together with
> tons of the existing checks done by parse_options_check(), the
> developers themselves of the in-flight topic(s) would have caught
> the problem, even before it hit the public CI.  I am very sure Dscho
> wouldn't have complained or even noticed that you added a new check
> to the parse_options_check().

Indeed, if no static check had been proposed first, I would not have
caught on to the unfortunate suggestion to use a runtime check _instead_.

> So from my point of view, plan should be
>
>  (0) I have been assuming that the check we removed tentatively is
>      correct and the breakage in in-flight topic caught usage
>      strings that were malformed.  If not, we need to tweak it to
>      make sure it does not produce false positives.
>
>  (1) Help Microsoft folks fix the in-flight topic with faulty usage
>      strings.

You're so sweet, but I already did that in parallel.

>
>  (2) Rethink if parse_options_check() can be made optional at
>      runtime, which would (a) allow our test to enable it, and allow
>      us to test all code paths that use parse_options() centrally,
>      and (b) allow us to bypass the check while the end-user runs
>      "git", to avoid overhead of checking the same option[] array,
>      which does not change between invocations of "git", over and
>      over again all over the world.
>
>      We may add the check back to parse_options_check() after doing
>      the above.  There are already tons of "check sanity of what is
>      inside option[]" in there, and it would be beneficial if we can
>      separate out from parse_options_start() the sanity checking
>      code, regardless of this topic.
>
>  (3) While (2) is ongoing, we can let people also explore static
>      analysis possibilities.

Of course, if we can convince Coccinelle (together with Python) to give us
the static check, we might very well be able to port more of
`parse_options_check()` from runtime checks to static ones, which would be
a clear win.

If that is possible, we could save ourselves a lot of time by skipping (2)
altogether.

And as I said, Julia's advice looked really good. If only I wasn't
desperately short on time, I would have given it a try because it sounds
not only fun but also very, very useful in Git's context.

Ciao,
Dscho

--8323328-231018794-1646163463=:11118--
