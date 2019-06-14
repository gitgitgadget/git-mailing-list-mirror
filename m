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
	by dcvr.yhbt.net (Postfix) with ESMTP id AB2061F462
	for <e@80x24.org>; Fri, 14 Jun 2019 19:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726420AbfFNTfY (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jun 2019 15:35:24 -0400
Received: from mout.gmx.net ([212.227.15.19]:58003 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbfFNTfY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jun 2019 15:35:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1560540918;
        bh=i5Pv/ea3V7YaRbZEtK62XCnQVrE/wO7B6NvFmNr3YVI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FkAvyi+7cHl83VWbIK16kUlLClLRKG+G4FFRxKqEE6eNqqMG5xoKLTVgyiNhf2J8P
         lVX7UAluHliJpPB3xogm5o7PUJ9CgrdQ7HaRfnniN+SynWuzdVjUVbfwR05UqXyjxB
         pUMBoka7CkGQ3iShIwfl4vThSbB8qvRz3NN9Hq1w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MX1hk-1i7dti0xZE-00Vuy1; Fri, 14
 Jun 2019 21:35:18 +0200
Date:   Fri, 14 Jun 2019 21:35:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] ci: split the `linux-gcc` job into two jobs
In-Reply-To: <20190613174329.GE31952@szeder.dev>
Message-ID: <nycvar.QRO.7.76.6.1906142051300.44@tvgsbejvaqbjf.bet>
References: <pull.266.git.gitgitgadget@gmail.com> <ac102169ec6f47b8be1fe69b4798de385f102af8.1560430430.git.gitgitgadget@gmail.com> <20190613153354.GC31952@szeder.dev> <xmqqv9x9wkba.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1906131844440.44@tvgsbejvaqbjf.bet>
 <20190613174329.GE31952@szeder.dev>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2063113972-1560540927=:44"
X-Provags-ID: V03:K1:3AdEN1MPqcvoKLZIN3uYIn/9eJ575juZ4Mr+zR1E8QFbuq89x96
 3/HWNxrAHW6ADL4DdfWzvwVkQH5bo78ltMIOMKLDpDcTy2/Y8npvVQMZTv6s4HHt+Qh2zs+
 lK3IKa6uRKBcEh2GYCstoq8IaKZzTaiyMlvhdCGfTg3gAT1du8R5vu4hLDzv5fiXO/p3X6D
 YyflzVtiB34Wzom1ToDAg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:84bo7fyBS9Y=:xFNh4QaLS3ihRdnLQEayS5
 L5TmkUZrRbn5fPhFOPA0L+Y1uw5+FgssoA44OBFQ+vJqvOITE05WL8hjKb1WFhqrYvJx/5wGY
 VoX1nJ5YRdMK5pAYxM8TUr7etorc+hER8Vo+lTa7ZUwYEy14KP6wOI7rddN1YofXxBLs+5PHH
 X3qxqlR2KJKItuH7Qqat8E52zmTyWI9LExbRdcU1aDiTju7CaggIYaZHtcm9ZOsOn23aYUB3b
 A7EzlgWRVFiuNoUPBAfp8jmFloDK+ZmVV18ituatIwm7iE5sNPv5RY+gWOhQ5r/fhpsa5Y/og
 +bbt5CkXBaa8Tw7SKLBdcn60C4YNY9v5dDnXhN3wr00ac4o/pKyrPfrrT967WfRZtwVBeNwgC
 Szq7iQRTIAlQVXdNrK74fm1VktCdimi8XgY0psvKChfQEQct8Cfb1Hd411uhE768dE9B58y8E
 v4dd1c7a0Sicsk0qy8Ej6lAEAqpnfHIl0W+/LPfZCdbtKgbagSutnYEo1cR8o+gwKZxhx3cyD
 I+DLUu/VoAyE3QvaALj06QeeqoNQC4wZXPI1vSlldm9WOGTOqHm78BgLcYS8vnVg5W87n2lug
 7nIKOG9bYpvFTI8LiFHl+n8ue3daswdGs2go1bWFtgmOfSZyGAK0cwPKLGxIuDROzSgfWa/5u
 1f+v2kVWHT5/WNEtbVoQulFKoMAShzxoSLH1z3NMxLMzJpT6cgheZqyJYkU+efsrNhGVvADba
 PSP0dMatBDqqkP8Dsybr1FT8JIQELtTD+TBE2f8n42phCAdw9VNf3MM6fuLm+VPGurlIhJJ4d
 jVVVZw9XmhTM+PM8G9pIhrShqktNg7amq5gj6JMkRfwbgadd5Jfqzy7HYf6kcaRCxzZlMMWFC
 wsxShbRPRE70rHj2l1COOtFyqbyybsH/9p9Cc/2LOo7a/5mbCDHelEP51H9k5Ja2ERSgdZjdO
 6fzukKjXS/6uKoLUza12MDAbOy9vTrAzrVMjLKxvLltdbxcaKeAgW
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2063113972-1560540927=:44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi G=C3=A1bor,

On Thu, 13 Jun 2019, SZEDER G=C3=A1bor wrote:

> On Thu, Jun 13, 2019 at 06:51:04PM +0200, Johannes Schindelin wrote:
>
> > On Thu, 13 Jun 2019, Junio C Hamano wrote:
> >
> > > SZEDER G=C3=A1bor <szeder.dev@gmail.com> writes:
> > >
> > > > On Thu, Jun 13, 2019 at 05:53:51AM -0700, Johannes Schindelin via
> > > > GitGitGadget wrote:
> > > >> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > >>
> > > >> This job was abused to not only run the test suite in a regular w=
ay but
> > > >> also with all kinds of `GIT_TEST_*` options set to non-default va=
lues.
> > > >>
> > > >> Let's split this into two
> > > >
> > > > Why...?
> > > >
> > > >> with the `linux-gcc` job running the default
> > > >> test suite, and the newly-introduced `linux-gcc-extra` job runnin=
g the
> > > >> test suite in the "special" ways.
> > > >>
> > > >> Technically, we would have to build Git only once, but it would n=
ot be
> > > >> obvious how to teach Travis to transport build artifacts, so we k=
eep it
> > > >> simple and just build Git in both jobs.
> > >
> > > I had the same reaction.
> >
> > So basically you are saying that the cover letter was the wrong locati=
on
> > for this:
> >
> > 	For people like me, who often look at our CI builds, it is hard to
> > 	tell whether test suite failures in the linux-gcc job stem from
> > 	the first make test run, or from the second one, after setting all
> > 	kinds of GIT_TEST_* variables to non-default values.
>
> Is this really an issue in practice?

I don't think that this is the right question. The right question would
be: is this issue possible? And the answer is: yes, quite. The clang and
the GCC toolchains are different enough that they have different bugs and
strengths. And the test suite with extra knobs vs without them *also* is
different enough to expose different bugs. So obviously, you would want
to discern between them [*1*].

But I can even answer the wrong question. The answer is still: yes, quite.

For example, I saw quite a few flaky tests "prefer" one over the other. I
do not recall the specifics (as I investigated at least half a dozeny
flaky tests in the past months, and I am prone to confuse them with one
another), but I distinctly remember debugging via patching
azure-pipelines.yml and ci/ heavily, using the one job that was failing *a
lot* more often (and deleting all the other jobs from that .yml file,
which accelerated the turn-around time, which is *everything* in
debugging).

And even if I had not experienced this. As I said, clang and GCC are
different enough, that's why we have both jobs in the first place. It
sounds rather curious to me that you suggest that they essentially do the
same further below:

> In my experience there are only two (and a half) cases:
>
>   - if both the 'linux-gcc' and 'linux-clang' build jobs fail, then
>     it's some sort of a general breakage.

Sure, that's the easy case.

What I want to help with this patch is the *hard* cases.

>   - if only the 'linux-gcc' build job fails, the 'linux-clang'
>     succeeds, then it's a breakage in the test run with the various
>     'GIT_TEST_*' test knobs enabled (unless the failing 'linux-gcc'
>     build job's runtime is below, say, 5 minutes, in which case it's a
>     build error only triggered by GCC(-8), and, as I recall, is rather
>     rare).

So what you are suggesting is that the part of the `linux-gcc` job where
it tests without all those knobs is totally useless because `linux-clang`
already tested the same stuff?

That does not sound right.

Because by that token, you would want to simply remove that part from the
`linux-gcc` job (instead of splitting out the rest, as my patch does).

I refuse to believe that you are syaing that.

That would sound almost like "We don't need the test suite because 99.9%
of all test cases pass, anyway".

> > 	Let's make it easier on people like me.
> >
> > 	This also helps the problem where the CI builds often finish the
> > 	other jobs waaaay before linux-gcc finally finishes
>
> This is not the case on Travis CI, where the runtime of the macOS
> build jobs are far the longest, so this change won't help anything
> there...

Right, Travis' macOS agents are ridiculously slow.

> on the contrary, it would make things slower by spending time on
> installing dependencies and building Git in one more build job.

No, it wouldn't. Because instead of waiting for the macOS jobs and the
linux-gcc job, we would only wait for the macOS jobs.

The fallacy here is that the 2-3 minutes spent in *two* instead of *one*
agent would accumulate to 2-3 minutes. It's parallel instead.

And once Travis gets faster macOS agents, the Travis build will be overall
faster (instead of now waiting for `linux-gcc` all the time).

Or am I missing anything obvious? I am quite puzzled by your objections,
given your experience with the CI builds. You, too, have *got* to have
experienced the benefits of parallelizing longer-running jobs.

To me, it looks like a no-brainer to split apart a long-running job, to
benefit from running jobs side by side.

Of course, there is also the presentation of the test results, but then,
Travis does not have that. You cannot publish the test results in a visual
manner, nor analyze breakages over time. So in Travis, it does matter less
than in Azure Pipelines (although not by much) what is the name of the job
in which a test failed, it really leaves the developer struggling to get
to the root cause by digging through the entire log. In Azure Pipelines, I
click on the Tests tab (see e.g.
https://dev.azure.com/git/git/_build/results?buildId=3D677&view=3Dms.vss-t=
est-web.build-test-results-tab)
and I see immediately not only what test script, not only what test case
failed, being able to see the corresponding part of the verbose output by
clicking on the test case title, I also immediately see in what job it
failed, which can help me debug a lot faster. Also, the analytics section
allows me to see in which jobs tests failed consistently.

And with the split I proposed, it would be obvious from that page, at one
glance, whether I need to use the GIT_TEST_* knobs to reproduce a test
failure locally or not.

So: I am still very, very puzzled why you think it to be a good idea to
have a job that runs twice as long as all the other Linux jobs, that makes
regressions harder to investigate than necessary, and that makes the
overall analysis e.g. of flaky tests more difficult than with my patch.

Ciao,
Dscho

Footnote *1*: Now, a question that Junio raised was whether we should have
the test runs with the GIT_TEST_* knobs *also* for clang. Alas, here I
would like to throw in the argument that a "too complete" test suite is so
useless as to be a wasted effort because *nobody runs it if it takes too
long*. And given the impression I have that Junio does not bother looking
at the CI builds, I wonder why he wanted this in the first place, it's not
like it would benefit him.

> >       too: linux-gcc and
> > 	linux-gcc-extra can be run in parallel, on different agents.
>

--8323328-2063113972-1560540927=:44--
