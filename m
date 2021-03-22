Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F04C433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:47:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 568F76198C
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 13:47:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVNrK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 09:47:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:43277 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230252AbhCVNqy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Mar 2021 09:46:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1616420795;
        bh=3M9rh/WHMYlYnaVPDvEN5lSZm96cdSm+lW1on9Q4VBw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UDCKNf+3R6kUt6dMWw/89drDwhaa44MPs3wF/wdm2UXXZjMYOdgP12d9wuqsjolls
         38H9qziOlLQsaF6chShylBc9KIccCRsCeGpXKDF6aOoO7yYyjUNR7JrU4QotD9GQcy
         kKxXbHN46pQaSWBmaGSA/fNyrD7KtbvgWL6HlmyI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.144.62] ([213.196.212.127]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MOiHl-1l268S2GoJ-00QCFT; Mon, 22
 Mar 2021 14:46:35 +0100
Date:   Mon, 22 Mar 2021 14:46:35 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [RFC/PATCH 7/7] test-lib: generate JUnit output via TAP
In-Reply-To: <875z1lz6wl.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2103221429200.50@tvgsbejvaqbjf.bet>
References: <87r1kzj7xi.fsf@evledraar.gmail.com> <20210309160219.13779-8-avarab@gmail.com> <nycvar.QRO.7.76.6.2103191508280.57@tvgsbejvaqbjf.bet> <875z1lz6wl.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1245979093-1616420798=:50"
X-Provags-ID: V03:K1:2+owf8qv7cUo2zWkNYSUH21QVEnaq35Gjlpkmi789azp8DkP0G3
 NMmjrO6LwKie9GUof2sInUmvcZyzhmgKo7o32iE4q/e7xGMFnejBNijDtsZeTVG5iw6vnZQ
 /E+Ry3KVFnwv/QS7alKYD5eZCBX1tILUpqzezz5536VEOJzu/8q6I9u08x27NY8wSkbozTC
 9qB+0Fc2Qmk56cHbs7Iog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9BJ8NYwtFug=:HDDBCLcYPBkscnCF5/O9jz
 ieGNbWUDveO5C0kA8kQK848zlaFTSsBBg930TfwuJQzI0gRKjGNutwAa55uQMvYCeNxOX89s1
 QqRhnODdBdi0x+i0mJbBiY+uDt88Yd/M4vjBJZtmBhrfQVEMvA7xI28bCBor+5R4n4sx7Zs5e
 Xd1O0yuZRBkpHEuY+6EidFecrHz+olIihC57cv+veUGtIt3RD6L1w3VoI/YpLECu6aDEPE07g
 ceiuD0uKPJr2x0WYbPVdBJqS5eQvoXYja2oqOtTaowuGXuNdvHKiuK/8yZ3hRuRETkCfzDm8H
 A7BoeCADXRvlz5HgyQ454FIt+9kH8+83rS/PIpZydxP2aPNGkalhsEtd0t302U2UuL6GFPEAs
 yAH3Rk0iTYPZLbDeYp+3ZjJVDhXH/0+4C6JHTGqqey7AfeoX5GIr7hoYQwUOD0K4E++vHEpuG
 x9isrzyNNgRA8SQY8DyX9dr+hBpGDWmDMUi4h7uS9jS+ZsvCkxlAA2Ow4+HpjARev7Jyn172R
 c4tlLsimkn286U6eu4uW++7wbDv56qUWZ4mPOsS3DMgFQXnJLmfbPRCcofYMnf+LOB6V0spd8
 o8RxAInmbColHuM2T3vCtSOqOpU7jOd3SirOYZj+JzyYMED+5v8AwzRjzv4g+gjWJBrMGNJpC
 uESVx6Q3sdtIjEpxJVBGLYEJg2crS7zFlLHc6n1+Nmp86vpoEBqfm2lltaci9oTERTKU9Dar6
 f+rcwqGn+PXlhxYg0Qep3DE83fdFWffgpf216iSWVQVwTdh+V7TyN+vMj+3wp0TXA2FEUvN7O
 tq/7TZyIUimF5Ic75hI/W80+EDEkv5wpFCB5IOigXO6WFH6VMG57c83ZiJolBZXL8frgzaJXW
 agEOxSNLMZQSkjeP6wKd5YxpctS9bOo8+JpaWxdpc=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1245979093-1616420798=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Sun, 21 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Fri, Mar 19 2021, Johannes Schindelin wrote:
>
> > On Tue, 9 Mar 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
> >
> >> Rewrite the home-brew JUnit output generation added in
> >> 22231908151 (tests: optionally write results as JUnit-style .xml,
> >> 2019-01-29) and other subsequent commits to be generated via the TAP
> >> output.
> >>
> >> This is now possible that the TAP output emitted with --tee is
> >> guaranteed to be valid TAP, see the preceding commit.
> >>
> >> The JUnit output is not bug-for-bug compatible with the previous
> >> output, but it looks better to me.
> >>
> >> This also requires installing TAP::Formatter::JUnit[1], perhaps that'=
s
> >> not palatable to the users of the --write-junit-xml option.
> >
> > Indeed. I am trying to keep the dependencies required for the Windows =
jobs
> > of our CI/PR builds to a minimum.
>
> I'm taking this to mean the dependency of the TAP::Formatter::JUnit CPAN
> module. Since the tests already depend on Perl, and presumably that Perl
> isn't so broken as to not have the built in TAP modules
> (e.g. TAP::Parser).

I have no idea why you insist on modifying something that works quite
well, but yeah, if you want to depend on the implementation detail that we
_currently_ run even the Visual Studio tests (that do _not_ depend on
`prove`) in an environment that has that dependency of `prove`, well, I
guess I'll have to work on maintaining that state of affairs. Doesn't mean
that it makes me happy. It really looks to me like a whole lot of work,
without any benefit.

> > Note, also, that the JUnit output was mostly relevant for when we used
> > Azure Pipelines: it has a specific UI to study test results, figure ou=
t
> > flaky tests, performance, etc.
> >
> > Now that we use GitHub Actions, we do not have such a nice test aggreg=
ator
> > anymore, but we might get one again in the future, who knows.
>
> So there's no known current active user of this JUnit output target, or
> at least if such a user exists it's not you anymore?
>
> I'm guessing we'd be unlikely to miss someone targeting JUnit from
> git.git's tests who's not on this list to chime in. So is it not used
> currently & could be removed?

No, I want to keep it because I hope that we'll get that lost
functionality back some time soon.

Sorry for not spelling that out more clearly.

> >> In any case, it'll be easy to whip up our own TAP emitter with a
> >> TAP::Parser and TAP::Formatter, both of whom come with perl itself,
> >> which we already rely on for tests.
> >>
> >> It should also be significantly faster on Windows,
> >
> > I really hate to have to harp on this when talking to you, but... well=
,
> > how can I say it? Perl is _slooooooooooooow_ on Windows.
> >
> > Like, _really_ slow. Ridiculously slow.
> >
> > I know, you recently got riled up when Jeff suggested that the Perl ho=
ok
> > calling FSMonior might be slow, but the truth is: it is super slow. It=
's
> > not even funny how slow it is. And it fills me with no joy having to
> > repeat it every time the question comes up whether running any part of=
 Git
> > that is written in Perl might affect performance on Windows. I really
> > dislike having to be that messenger.
>
> Riled up? No, perplexed: yes. You're referring to
> https://lore.kernel.org/git/87h7lgfchm.fsf@evledraar.gmail.com/
>
> So as an aside about that particular issue / slowness I haven't been
> able to reproduce:
>
> If it's really a reference to some Windows-specific issue with Perl on
> Windows in particular that would certainly be helpful for the rest of us
> trying to follow along wondering where these wildly different
> performance numbers come from.
>
> So not that we don't want to more to some other fsmonitor implementation

ETOOMANYNEGATIONS, can't parse.

> for other reasons, but the Perl part of that hook would be rather easy
> to replace with some C JSON encoder or whatever.

For the time being, I'd rather avoid discussing that because we already
have an experimental, built-in FSMonitor that I personally use. That
FSMonitor will nicely side-step all of the Perl slowness.

> > I doubt that you will ever be able to replace my (admittedly slightly
> > hacky) C helper with anything written in Perl that does even come clos=
e to
> > being faster.
> >
> > In other words, I fear that your work here might not have the outcome =
you
> > hoped for.
>
> We shell out to your C helper at least once for every test we run. By
> converting the TAP after the full run we're only invoking Perl once
> per-test.
>
> If that one Perl invocation is still much more expensive than doing that
> ~20-50 times per-test we can easily move the loop to the Perl script and
> invoke Perl once per test suite run. At that point you've got 1 run
> v.s. >20k runs for the current helper being called in a loop by
> test-lib.sh
>
> But I don't have access to a Windows test box. So maybe it's slower than
> I'm imagining. How long do the equivalent of these take on Windows (not
> sure if the time built-in is there)?:
>
>     $ time perl -MTAP::Harness -wE 'say "hello world"'
>     hello world
>
>     real    0m0.018s
>     user    0m0.013s
>     sys     0m0.005s
>
>     $ time (echo hi | helper/test-tool xml-encode)
>     hi&#x0a;
>     real    0m0.002s
>     user    0m0.001s
>     sys     0m0.002s

$ time perl -MTAP::Harness -wE 'say "hello world"'
hello world

real    0m0.326s
user    0m0.030s
sys     0m0.124s

$ time perl -MTAP::Harness -wE 'say "hello world"'
hello world

real    0m0.131s
user    0m0.061s
sys     0m0.046s

$ time perl -MTAP::Harness -wE 'say "hello world"'
hello world

real    0m0.209s
user    0m0.015s
sys     0m0.156s

$ time (echo hi | t/helper/test-tool xml-encode)
hi&#x0a;
real    0m0.165s
user    0m0.015s
sys     0m0.093s

$ time (echo hi | t/helper/test-tool xml-encode)
hi&#x0a;
real    0m0.092s
user    0m0.000s
sys     0m0.047s

$ time (echo hi | t/helper/test-tool xml-encode)
hi&#x0a;
real    0m0.075s
user    0m0.000s
sys     0m0.046s

Completely unscientific, but maybe it gives you an idea.

> In any case, I regret focusing on the TAP::Formatter::JUnit part in this
> RFC. The real meaty part is being able to have stable TAP output, and
> thus not having to add N number of output formats into test-lib.sh
> itself.
>
> A tool that consumes that can then be e.g. Perl's TAP tooling, or just
> some C program or shellscript that calls the code that the below quoted
> diff is removing (aside from the test-lib.sh part, which would go away).
>
> But it would be easier to write such tools using Perl's tooling, as it
> saves one from writing a parser for TAP.
>
> I'd be surprised if Perl was adding much overhead in that context, and I
> see that the existing Windows CI jobs are running through "prove", so
> presumably even on Windows e.g. this:
>
>     time make T=3Dt000*.sh DEFAULT_TEST_TARGET=3Dprove
>
> Is not much slower than:
>
>     time make T=3Dt000*.sh DEFAULT_TEST_TARGET=3Dtest
>
> I think this is the Nth time we've had some variant of this "Perl in
> git's tests" discussion.

And it is still an issue because the Perl we use is running on top of a
POSIX emulation layer which makes everything slow.

> I'm all for finding solutions to whatever issues you have, but I find it
> confusing that in these discussions you seem to conflate and jump
> between some or all of (just the ones I'm remembering):
>
>  1. Some imagined future state where there's no Perl whatsoever in the
>     test suite or git.git's build toolchain, which isn't the case now,
>     or anywhere in the forseeable future.
>
>  2. A future state where GFW etc. don't need to ship a Perl to users (I
>     believe this is either close or already there, I haven't kept up..)
>
>  3. The slowness of Perl for: tight loops, a few per test, once per test
>     suite run.
>
>  4. How #3 e.g. in a tight loop compares to calling say sed or awk in a
>     tight shell loop. Is perl uniquely bad on Windows, or is it really a
>     gripe about our use of shellscripting in general?
>
>  6. Not wanting to (understandably) package any more non-core Perl
>     stuff, understandable, but we always have the option of extending
>     perl/FromCPAN/ if we find something truly useful (in this case just
>     having a custom JUnit XML emitter, if it's actually needed by anyone
>     anymore, should be rather easy).
>
> So e.g. in this case I can guess at some of the gaps and *think* that
> some code in t/ that uses TAP::Parser (a perl core module) and was
> invoked either once per test-lib.sh invocation, or better (but perhaps
> not needed, as it would make it a bit more complex) once per test-suite
> run should be fine.
>
> That code could even be implemented as a prove(1) plugin, at which point
> we'd be invoking Perl exactly as many times as we are now, but I'd
> rather not paint myself into that particular corner without good reason.

Yes, I would be much happier if Perl was not required to run our tests. I
would be even happier if we did not run our tests through shell,
especially performance tests, because running performance tests through
shell is like getting the most precise stop watch you can think of and
then looking away from the athletes while timing their sprint.

If you provide patches to bring us closer to that reality, I will try to
set aside time to help. But this "let's remove the C helper that serves us
well and instead use Perl, just to shuffle things around" business really
looks like a lot of churn to me, and I want to spend my time elsewhere.

Ciao,
Dscho

--8323328-1245979093-1616420798=:50--
