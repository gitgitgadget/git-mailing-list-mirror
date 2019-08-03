Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B1981F731
	for <e@80x24.org>; Sat,  3 Aug 2019 21:26:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbfHCV0U (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Aug 2019 17:26:20 -0400
Received: from mout.gmx.net ([212.227.17.22]:57779 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728508AbfHCV0T (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Aug 2019 17:26:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1564867561;
        bh=62Tidi26FtdPR+gMQtl+1i0pwCXGTwb1OIhor9g0iFU=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=DW9Fs5ZiVZeBZkgK5oygMo0fShZnla6oVdirgCL765j2xkthc5TviBG/KsWKIHdty
         lH9eUkOhZMo7rKTRPYmMYsiLnR1+zcHE99bphAZTaRFaDasokETSMQFtbJL9U5os3v
         at3HxdaNP6SoXuwODJTK7zsXLsUuDNDrKNs2nBVc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKt5A-1hu1XN0oXw-0003Mo; Sat, 03
 Aug 2019 23:26:01 +0200
Date:   Sat, 3 Aug 2019 23:25:45 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Josh Steadmon <steadmon@google.com>, git@vger.kernel.org,
        gitster@pobox.com, git@jeffhostetler.com, avarab@gmail.com,
        peff@peff.net, jnareb@gmail.com
Subject: Re: [PATCH v3 0/3] Add a JSON Schema for trace2 events
In-Reply-To: <20190802232559.GC109863@google.com>
Message-ID: <nycvar.QRO.7.76.6.1908032248010.46@tvgsbejvaqbjf.bet>
References: <cover.1560295286.git.steadmon@google.com> <cover.1564009259.git.steadmon@google.com> <20190725234229.GM20404@szeder.dev> <nycvar.QRO.7.76.6.1907261333390.21907@tvgsbejvaqbjf.bet> <20190726220348.GF43313@google.com> <20190801180829.GP43313@google.com>
 <20190802015247.GA54514@google.com> <nycvar.QRO.7.76.6.1908021347580.46@tvgsbejvaqbjf.bet> <20190802165913.GA109863@google.com> <20190802193849.GX20404@szeder.dev> <20190802232559.GC109863@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1859236827-1564867563=:46"
X-Provags-ID: V03:K1:Kl7ugc/5SuO6bQ4ud8uj7VzS1m8YUSvp/LpSKrzLm1fuVotov8C
 Fw+K4Mblnz/8hW17fPC5i+pEu29KokU5nvPLjVpNu9+XPIfc+imr866yE9/Xpp6ekLMjUEh
 lAj9VDOYur6O1kaaaDlHYaUsh4BmyF3Z7psKmBRLpWZlowF9qFYPQyVbl1hdT2H9QSi34Kn
 /NzG9W1psp6wG9P17w/sQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:xIYNLCf30KY=:uz8uD/EHxi/SUUj4veT0ty
 GivrR8znUGvH8IqPGpLUfKvHj1mXx5ZW/vTTLQf+y+Y9aWatXH9r9r/RJkvmuKZAy+fKs1SR9
 XBgMHoM69VFiGotm1ezXW9T3JcVyzun3no1j41CE3PtPpHkP/xv/vqTmBGul2N1lKVyrFxYp/
 tZ+WmD9BxvYySnlYz4oFim1Ss8QVVH5A6Pv2j/LCy9zaU+7IGJXME+Y7tbrPYUSzgO/zlKYTY
 UhboFQ81tiOUXz6uBo4CnoLuCg5zi3vWH5gVZ0wgZ2c1RsCJf255ZS0mR8xNiP2VotaWit0C/
 BbFNCry/9utqRtmbFvBn1VaEPclNnE0/PrPaOgjUMnQrFmhbtqhlCf9YxuLaiIKmaSeTFR5nK
 uR3lst5Fc1UqSXxgPUbiqbDV3+BlJ2spayh/UTJJp7Fn7xAyallXozwwNPvqVksS8Ddc7bfzm
 mfvYqeS+x1C8V7AhKWKdCXq7c+afoynFiwHPmF5v+PLKmqXgvsG6OvmlFHaFfyeJebkUaB0vY
 lXIdSDDQVW1N5IKiXSs58snh5pqFiAw4qbdFQXV5TmtVcfe6RdxoZbJofAMXiADxy4PU7Enao
 hkNmiM1EdLeBHQQkx9HpOf/jT3+kSru0KCzqXbiJmVuU5mIbMyN1SercMaItBpx3IIfP5bdlF
 Ky7Um6pxYoWHqNwdFzJ+oRM0SOoFqO44fnAO6C+VBy8F/CnAhnK4qLcGHOWvs5LlsCgq1/172
 zlO30v9s/WGLsayEZkKhqQNEP1Pud4TZqPPjDWSRln2NrNuYgIn07tlzbtLGHid3ol+awGQg5
 u4vroYKMLPex6BNod729b3SICjBmnUPQVGYY2HUnFJMmG6DRWuLA6YydibroIU6cGNot5W0x8
 qYW6E+3oIo0pIzM7RSyxAJHO6gSDxU/0wMNxu74xZOmuUiPxtMCFtUZJ+pzaGvWSfmp2C9Efr
 YRT6eGanahpQ9yxF6HbBce6QcbX8qGeZQBOPoZYDgw5wTOAxBmET+JxusOe1om/8sI+wAQBVU
 beBiEyZyYGjwiWNKFFYT6F90sKArDiqDJk4P+WXkAMnl1PZaL182wgno2SXDndlNGAcnedspw
 hLmxjmjQ7s5wW75QYN4t6B2F97ecGzthuKYnjqZ5/zY7ilZVholzauIcU1wzhrtfxUcyEHuzm
 OcRhA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1859236827-1564867563=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Jonathan,

On Fri, 2 Aug 2019, Jonathan Nieder wrote:

> SZEDER G=C3=A1bor wrote:
> > On Fri, Aug 02, 2019 at 09:59:13AM -0700, Jonathan Nieder wrote:
>
> >> In the short term, we can run tests internally to check that Git keep=
s
> >> following the schema.  Let's not block patches 1 and 2 by this ---
> >
> > To my understanding patch 2 is only a proof of concept: it starts
> > using a programming language that has not been used before in this
> > project, to implement functionality that is readily available in
> > several existing tools, without even arguing (let alone convincingly
> > arguing) in the commit message why this approach is a good idea.
>
> Well, Golang has been used in contrib/ before. ;-)

Yes, and the rules for contrib/ are a lot more lenient than for the core
of Git for a purpose: we tried to invite a lot of projects into that
folder that would otherwise have fallen undiscoverable and/or
unmaintained (this was before GitHub, and I would argue that the
contrib/ directory's original purpose was kinda outlived by the quite
popular Git hosters out there, with some things like the completions
probably wanting to be promoted to a better directory, i.e. a location
that does suggest that it is maintained within git.git proper, and not
an unbeloved step-child, and others simply be moved into their own
public repository).

But as both you and I know, the patch in question is not at all about
contrib/.

It is about a part that the Git project is asked to maintain, because it
is now part of the CI build, and even worse: it is now expected that the
contributors whose patches break the CI build are able to investigate,
even if it is a bug in that very new validator in that very language
that we did not require contributors to know beforehand.

It is easy for old Unix graybeards to forget that they, too, struggled
with new languages when they started out, and nowadays it is even
harder, as you are kinda stretched between languages and frameworks and
new techniques like multi-threading, closures, algebraic effects, etc
that Unix graybeards will never truly understand.

Just as a reminder: if you truly want to understand, or even only debug,
or even only scratch your own itch with, core Git, you have to know

- C
- Unix shell scripting (POSIX-compliant, including the vagaries of the
  options/particulars of sed, xargs, etc, in particular which ones are
  *not* limited to the GNU flavors)
- Perl
- GNU Makefile (you better understand macros, and the difference between
  `=3D` and `:=3D`, and `:` and `::`!)
- Javascript
- Markdown
- AsciiDoc (we seriously do expect contributors to know what AsciiDoc
  makes of a line consisting of a single `+` character!)
- Python
- RUby (for AsciiDoctor extensions)
- Tcl

And that's just core Git.

You won't hear me complaining too much about the above, as I am fluent
enough in all of the above, and since it is a relatively rare skillset,
it makes it easy for me to keep my job.

At the same time, you do realize that this makes it harder than
necessary to get contributions? That it fosters the kind of environment
that makes every potential contributor feel stupid, when it is totally
not their fault that _we_ created this environment?

Adding a new language to the fray, even something as universally
respected as Rust, would be a hard sell.

Golang is much, much harder a sell. I know that you, working at Google,
might think that Go is a mainstream language and not even controversial,
but that just looks a bit biased: Go is very much a language controlled
by Google, much like .NET Framework (although not as much .NET Core) is
controlled by Microsoft. Therefore, I would have considered it to go
without saying that both Go and C# are obviously bad choices for _new_
contributions to core Git, in particular if they are intended to become
part of the CI-tested portion of git.git.  It just looks a bit like
forcing your stuff onto others. I constantly push back against trying to
contribute C# code for that reason.

> If I understand [1] and [2] correctly, we haven't found an existing
> standalone tool that is able to efficiently validate a high volume of
> traces.

G=C3=A1bor put it very aptly: the problem is the high volume. You are free=
 to
test this as part of your development, but to push this high volume
testing (for almost nobody's benefit) down the throat of git.git's
regular CI is a bit... much.

> But for the purpose of sanity-checking that running a few typical
> commands generates a trace that fits the schema, it's not important
> that the validator be super fast.  So we can use a tool like jq,
> picking one using the criteria that it
>
> - allows performing the validation without too much fuss
> - is likely to already be present on some developers' machines

I don't really care what you use, as long as it is something we don't
need to maintain ourselves, and as long as it is well-maintained in its
own right.

`jq` seems to fit that bill.

I do care as soon as you increase the average runtime of the CI build by
a _double-digit_ percentage, especially if it is for the purpose of a
feature that your team and my team and maybe two or five other teams
might care about, i.e. maybe even as much as 50 people in total, but not
the millions and millions of Git users out there.

We _cannot_ penalize the CI build for a feature a couple of dozen users
want and nobody else, no matter how useful the feature _to them_.

It would have been a totally different matter if the contribution would
have come as a patch to contrib/, with a few test cases marked up with a
prereq that is off unless a user sets a specific environment variable,
so that you could run your integration tests, and nobody else would have
to pay the price.

But that's not what was proposed, and that's why I object.

Ciao,
Dscho

--8323328-1859236827-1564867563=:46--
