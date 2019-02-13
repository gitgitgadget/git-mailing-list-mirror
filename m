Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 929EA1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 10:00:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388568AbfBMKAP (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 05:00:15 -0500
Received: from mout.gmx.net ([212.227.15.18]:35063 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728987AbfBMKAP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 05:00:15 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Lm3bl-1hSe3S2JkX-00ZeZF; Wed, 13
 Feb 2019 11:00:07 +0100
Date:   Wed, 13 Feb 2019 10:59:50 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eric Sunshine <sunshine@sunshineco.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/1] mingw: fix CPU reporting in `git version
 --build-options`
In-Reply-To: <CAPig+cRPEoro_661Py+6RDTGvZdT4gAVK45jAuGr+g_Rt=en6A@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1902131046300.41@tvgsbejvaqbjf.bet>
References: <pull.121.git.gitgitgadget@gmail.com> <cca9a543d52f3d7d9015709800e10ea57be1fea3.1549536364.git.gitgitgadget@gmail.com> <CAPig+cRPEoro_661Py+6RDTGvZdT4gAVK45jAuGr+g_Rt=en6A@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:qidFznsEBcGa7uDd+Vc+EXOnW8yL2fQuHvlmj0PaDd+RShqOmff
 Ag1tppZMQvN/R775luJH56r+dO2G6xJtW368yH0wIsgOO//bxZSgt7c+qOMrbRI0BvMlXcL
 XRKcOM9We82+Y5saeLX+vWaOg4fk3JNFTGa3pfd0rqHmuGz5sUuTH0ec3pF1/DWzlYcwXV4
 2czc/pHCbfBd6gpG2s+hw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTlz6KRGKys=:8688mH0lCg3u9hr68MNlSc
 9AZTq2scOE39GG2FfwL/fx/QMfQAb0BgtBD90JmH6ot6LDzqFfIs3tl9R8zYSSRfFv4dZfZLc
 8jfaoxoDZj7lyWXxAyn3v119Rv1GBUMMk9//AK3bzWLQY+cGRbWYqWC6RY9ZgfPR3ZIZEKR8J
 G1jV9E0YKo+rtAw1ids/wol5BuyF3XhYOUuPNjxgDV/pxdR6tOWg2R8ph5U80bCfe3alv6TeQ
 GV+MfRaMo7H4VlfazXTUR1kZ6/kRdwJidoBGbGnNzu3syRZGtn1HwFCN/9vS8HcXabIT4J+r3
 VzRV+fzQ3vX4QPmbwM8Q93AU0KTJEB5JK7yJFgvbla2aDecOL3sgRhUorbw4M4f28b1Xjtj/8
 V/gZaDoyZOYIsIAl8+7U4XAmoKz4mlRqRX2wtdSJgHVLX7zj5SygTG7qFl5zb1RSn8N7GB84q
 ml1AjUkX+B8lYQd7ADr0nViYMesFq8tA9Oph9EzOkRiYkeTLdPaz1tzhvX3f8/cUCQWJ+u9yK
 58G+EKD4HQDxv+JuhB4E8FB07fo/dZkiEIy6/zlN3brYCpz88QY0iZFRGtuFQNJAwGrZ8SVN/
 HzQtjQwoJ8cvf+VuvPfEmRgmzhKftRNhveD/YVTHq9za1JHYAiWh5RPnAeR/l84/9FN54+nUl
 DX2TcxmTItF2JtR9AenLtKJWvXmZalXfUqDcggdOPbYVU+dSJQpSbQ/oPJAhAAiJmCURcEc6j
 ngwatUTMckLRL4UWSYEHGnNRHtj4HxFSlE411YbyybPQ1wGreKbzVrhlTgWxELC+Y3HEOkGwp
 dOeyfJHtVEFOkHxDYrtI5EnbVjNLKjdvOCiLbum9HiTHbTjd2935yUFiNws3vTp6vbaM9OjKZ
 j18TeS6RGXxuVEObwjX52tG4bHc3eCUnVfRBp3uVm1bYiONrZTDdnh28fwPQs8kOEIWinDEDt
 4A5Y6yb0qbUeK7yO8FDjOfyIDdgXa09s=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eric,

On Fri, 8 Feb 2019, Eric Sunshine wrote:

> On Thu, Feb 7, 2019 at 5:46 AM Johannes Schindelin via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > We cannot rely on `uname -m` in Git for Windows' SDK to tell us what
> > architecture we are compiling for, as we can compile both 32-bit and
> > 64-bit `git.exe` from a 64-bit SDK, but the `uname -m` in that SDK will
> > always report `x86_64`.
> >
> > So let's go back to our original design. And make it explicitly
> > Windows-specific.
> 
> b22894049f (version --build-options: also report host CPU, 2017-12-15)
> took this sort of case into consideration by introducing Makefile
> variable HOST_CPU (which takes precedence over `uname -m`), with the
> intention that, when cross-compiling, your build environment should
> (somehow) set HOST_CPU to the canonical name of the CPU on which the
> built Git will run (for instance, "x86_64" or "i686"). It would be
> nice to employ this mechanism to solve this issue rather than
> (re-)introducing a manually-maintained list of CPU names.

Heh, this is also manually-maintained, but I agree that it is cleaner.

> Can you say a few words (here in the email thread) about how the Git
> for Windows SDK is instructed to build for one architecture or the
> other?

To cross-compile a 32-bit Git in a 64-bit Git for Windows SDK, use this
incantation:

	MSYSTEM=MINGW32 PATH=/mingw32/bin:$PATH make

> With such information, perhaps we can figure out how to get the build
> environment itself to set HOST_CPU automatically so we don't have to
> resort to and worry about maintenance costs of a hard-coded CPU name
> list.

Indeed, we can set HOST_CPU in the same conditionals as prefix (which is
/mingw32 for 32-bit and /mingw64 for 64-bit) in config.mak.uname.

Patch incoming,
Dscho

> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> > diff --git a/compat/mingw.h b/compat/mingw.h
> > @@ -6,6 +6,25 @@ typedef _sigset_t sigset_t;
> > +#ifdef __MINGW64_VERSION_MAJOR
> > +/*
> > + * In Git for Windows, we cannot rely on `uname -m` to report the correct
> > + * architecture: /usr/bin/uname.exe will report the architecture with which the
> > + * current MSYS2 runtime was built, not the architecture for which we are
> > + * currently compiling (both 32-bit and 64-bit `git.exe` is built in the 64-bit
> > + * Git for Windows SDK).
> > + */
> > +#undef GIT_HOST_CPU
> > +/* This was figured out by looking at `cpp -dM </dev/null`'s output */
> > +#if defined(__x86_64__)
> > +#define GIT_HOST_CPU "x86_64"
> > +#elif defined(__i686__)
> > +#define GIT_HOST_CPU "i686"
> > +#else
> > +#error "Unknown architecture"
> > +#endif
> > +#endif
> 
