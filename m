Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AEA21F462
	for <e@80x24.org>; Thu, 13 Jun 2019 16:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389478AbfFMQvE (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Jun 2019 12:51:04 -0400
Received: from mout.gmx.net ([212.227.17.21]:43153 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730157AbfFMQvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Jun 2019 12:51:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560444657;
        bh=P7b75jMVkxDLrPsHBwxZU9YfLJ5rnZiVKMzZpG2QevI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=jEhcv29kHM+AhYmGKworh2deEJIzt6c7WUtsHG/7S4FwbXUJ4DabkaClg1vxKsW52
         5A7f2YDJvhOEtsBKItk7AvSS/vybgVkjWyG+34QRtu6h3PsrtGevMw/l1AXx6ImExZ
         HzhpgZ2KYRuoMwV6nzBXVhOSnBULsFB24f241bhc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LjZn2-1iCzY90WCW-00bbEF; Thu, 13
 Jun 2019 18:50:57 +0200
Date:   Thu, 13 Jun 2019 18:51:04 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
In-Reply-To: <xmqqv9x9wkba.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906131844440.44@tvgsbejvaqbjf.bet>
References: <pull.266.git.gitgitgadget@gmail.com> <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com> <20190613153354.GC31952@szeder.dev> <xmqqv9x9wkba.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-302300675-1560444665=:44"
X-Provags-ID: V03:K1:qMkNZaajzN6+GSpLm6xTZIoGinnYKcBpc1qdCYhd1O/TzkhNRZR
 h6U1jygdiJ6af0+F7jOvMZo3IEYOY9e2JSyV0fVS+i+RYm2Q/Xkq3UClylLeK6sDtdDCxBG
 xhXNkyy2OmGK7NpyL8SYY6gVj5VyoGNUH7JkgXiZAZGjTpeaPHuGifIooC3l+InCQVM8mRq
 zgGH4mNw+WUF2uhAF21rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bqq22lodV1M=:aZOMIVDK5q5UzD1qbGtGf+
 oHFenJDrv5CJjkrQLNyaN47J+TfilSpcWA4lWoL1YzGhCf9UFRYKVbSPbc/+21ZB66sXyw8DW
 EmbCqFVV/B5VMUIVy5lP3P88Q9XPo8HjqrgsY0egMWnGFyfn8tdJTVXC5vABjZbfsj+S29zbm
 opIvvOXRpTexXhe/DUQg3YpzwRRq2B2YuxtLOY3BGRfBqqdhQQxMPlkR4+1e3vl4BuCV67fCk
 e4AJFSKlW3p1AomJtlLqqdJ56btmAZTl+e78rrFgSPp/kdCwLBkqgYSweHUmTD722BTq+XcyO
 qf8AMiBB60TtViRe/KA9BWpsoQ9wVVlxVl8/XQHdDvFBFtfwZ6LbzhLaw34b3UznlGQGIjUpu
 sn2jJEbPyMPKSF3apBBFFPtOArL5EiBt1C95n9FIEXMsphi8FfF+QKJI2SF8ayG97HTk4N19d
 2QCrB3K/Eb2L7rikOq3Je0+MdAzRN3e5aWG6fMqCkDq/LhN/UnbTJ9CZXQuDimiyXWumatb2O
 0jGpZ1JzougSpWeca2EGGb7DYYA1ApU9dDZO8RPbefCEdgn/Hos7coD6NwxN9mGqliEq7PlqM
 8zsoJQwCOJd21znzfc28wOaKD84jTZ/DUZke6wVSBF6sycuU34Oqt2MXEws0KCHjswO3chrRB
 KbKIDnjw0shSycwj8lZBnE4/vUB9+KO7+dQtGWkPwbGJ8aOcmgdKY7xSTkEftlg3LPEwvh3Gm
 BOvnkdPGV9dNpFjUi4+rRhbM1VMJGtCkOX++TbEnr5hRwGc8Y8NOmLSsl9PeNsTGQpXN86A+I
 FQomYC6rIiIlYiFDQwq81zhnar1A2Qn1ve6rjaJjt6VAHs8sxrPtvY/pwNdEsZz7Xhu8oJW5Y
 n0A6odKoWSU0eZx1mXbdBExfIU12Botli8ERpsXSQdWQ582uPz+oGBAW8R6gFbvwoQBorokvM
 Moi+qC8r94CayMvCMBaY7XbArA5VXif2iCMe3g8x8bZsFIBC+ZVBJ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-302300675-1560444665=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, 13 Jun 2019, Junio C Hamano wrote:

> SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
>
> > On Thu, Jun 13, 2019 at 05:53:51AM -0700, Johannes Schindelin via GitG=
itGadget wrote:
> >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >>
> >> This job was abused to not only run the test suite in a regular way b=
ut
> >> also with all kinds of `GIT_TEST_*` options set to non-default values=
.
> >>
> >> Let's split this into two
> >
> > Why...?
> >
> >> with the `linux-gcc` job running the default
> >> test suite, and the newly-introduced `linux-gcc-extra` job running th=
e
> >> test suite in the "special" ways.
> >>
> >> Technically, we would have to build Git only once, but it would not b=
e
> >> obvious how to teach Travis to transport build artifacts, so we keep =
it
> >> simple and just build Git in both jobs.
>
> I had the same reaction.

So basically you are saying that the cover letter was the wrong location
for this:

	For people like me, who often look at our CI builds, it is hard to
	tell whether test suite failures in the linux-gcc job stem from
	the first make test run, or from the second one, after setting all
	kinds of GIT_TEST_* variables to non-default values.

	Let's make it easier on people like me.

	This also helps the problem where the CI builds often finish the other
	jobs waaaay before linux-gcc finally finishes, too: linux-gcc and
	linux-gcc-extra can be run in parallel, on different agents.

Of course, I would rephrase that a little, because it is kinda okay for a
cover letter, but not for a commit message that needs to be understandable
out of context.

If you agree that this would make the change easier to swallow, I will
make it so.

> If it said something like:
>
>     There is no logical reason why these extras need to be tied to
>     the linux-gcc platform.  instead of tying the extra
>     configuration tests only to linux-gcc, split it so that they are
>     also run on all other combinations, and this is merely a first
>     step of doing so

No, that would double the time taken by the CI build. It already taxes the
patience so much that most contributors already don't bother with it, and
you can see how many times I find issues and have to report them (which
flies in the face of the idea of using automated builds to catch bugs
early): we are seeing the detrimental effects of a regression test suite
that takes too long.

> it might at least have been possible to judge if the motivation is
> sane, but the proposed log message, while it is quite clear what is
> being done and what its shortcomings are, is silent on why we would
> want to do this in the first place, and that makes it even harder to
> swallow the shortcomings.

Okay, two things:

	- it makes it easier to identify *which* settings to use when a
	  test case fails in `linux-gcc` or `linux-gcc-extra`.

	- the overall CI build runtime is no longer dictated by the
	  runtime of this single build, which easily was the slowest of
	  the bunch.

Does that clear up the picture?
Dscho

--8323328-302300675-1560444665=:44--
