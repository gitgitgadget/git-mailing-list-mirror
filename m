Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECEBC433DB
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A944964F64
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 15:58:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235963AbhBBP6e (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 10:58:34 -0500
Received: from mout.gmx.net ([212.227.17.20]:49527 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235834AbhBBP43 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 10:56:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1612281291;
        bh=4YzoWoasVqEnzg/QuqtYVJyFqmOjX+VW/EU4nYITb7k=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gs5zRu7MgQRW9tKjmBGBGcGJCY7P4VhKTffGl1nu+XS2v4K3aoSxu+C5IJP34ywuu
         Hxe8SnMYjKHRKvlDVVbpYj09VQb7W1d6hkrTXA3uXbrvvOwEcDJlQ+IofokjkDOnWQ
         aSLqDw6PZWuetht2VA//37mECBOAf3eCMgCqdrDo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.95.40] ([89.1.214.8]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MiJVG-1ldX5A3H1i-00fVhC; Tue, 02
 Feb 2021 16:54:50 +0100
Date:   Tue, 2 Feb 2021 16:54:56 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: What's cooking in git.git (Jan 2021, #06; Sat, 30)
In-Reply-To: <xmqqy2g8mubh.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2102021652350.54@tvgsbejvaqbjf.bet>
References: <xmqqsg6infev.fsf@gitster.c.googlers.com> <87lfc8ocmt.fsf@evledraar.gmail.com> <xmqqy2g8mubh.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-219256074-1612281298=:54"
X-Provags-ID: V03:K1:7Pcdlyck9UcvQ5ahiZM5EpIUBzr2w1TeWpcQzQAnAliqty5eAjS
 oFzVS0L2UqtFxAR470SiWn8qJmoOpGPxYotKAmGdAAMLqZHVlrZ3WRKi8TCH1NZRZaB4hmO
 LsshM5Ea6CNp3DCrDUg65fsKQiTcW0+BYKMwEEP8Sq2rK4MCmgfv/8nKvXBeJHSg6zqz7Sj
 ghrOjKQVothnMhTLUYa2A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ppbM+9Dhr1M=:+r9IoHwqszpnJqxxGam1wG
 dPu7fgUFzz3RqyjyikmXqJfaMhOAM8OsrivYgSwlGJgRlMtPJCE1x5in7zK8BQ4fWsAECpc8Y
 3fnvPdTAD/AhnREqQfwirWfO79BmUgRvaqP8GO2sZwowOpBN9YyRJqncubhJL6EeN2XFcGrL1
 3cvzzuKQjTDS4/kEXQONjbFCNfJopk8NJkjUx2wu8nJ1wzvJ4JI9eUTL4GurBuv1DfV0nsBaU
 Hiy3U2RPEhibDHUGlKou9Orh2f8A2novF5yKnvviVz7zVJlt1FnKevXMMIUIIf9BdXGBlha6O
 ZWRgNOlJNvlZx4Vo6Fxg100OxIrvKmzAdFVORsxbRB0Y7lnD44wS66zS+w9mwzgr3VJXCKNBN
 0qWPtj6kjVwIAznfOufIqdCAS3deDdRhD+U3KwpYW7oMUP+jhhegB1QfrHLnEFvi7TZPvGJO/
 46S+Ay2XQ388YLlWBMNtpR1bJAYLUdAVT20LFG9ieaAcrLMbSsKm+AAXMNYNqJKaAZ3SaYEQ9
 044Z5In6ddSBbYspfzK8J37PuTlrQi+GUgQE4Jmc4UxSmWhZNko9qolNFmlDrkMYsfxNwY3BD
 ZzSU5oC3b7NHORKfwReepcQoW2g4m8ul3fyvn+JFEduMIF+1lDVySBtT8ZsC6OmcMGgMxiECI
 GA/UAWoYe3LT/1JkqJZrbG4he6JV1l/8EP6MnMh2oCAQJK+7t8RsbhW/UePCfEmVgb1pez0FF
 oRq5ej8O+SmTQ9tme2mtCJcMpC4p7sQ9yKo3Emj+uZhb8MHIwFvJOXFabEIite16BOTr05Sv+
 tJ/hOi+kqRKZyfJBHz1X1G7lF0YyHk4pwAyRjqZdcdDi2nLq61aNzNI1dgXhzp3Sa77RWjUV0
 2zr3lHx5OBqEMwowSKLvH7s+2n/QlrCNP4WaLviF8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-219256074-1612281298=:54
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Sun, 31 Jan 2021, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Sun, Jan 31 2021, Junio C Hamano wrote:
> >
> >
> >> * ab/detox-gettext-tests (2021-01-21) 3 commits
> >>  - tests: remove uses of GIT_TEST_GETTEXT_POISON=3Dfalse
> >>  - tests: remove support for GIT_TEST_GETTEXT_POISON
> >>  - ci: remove GETTEXT_POISON jobs
> >>
> >>  Get rid of "GETTEXT_POISON" support altogether, which may or may
> >>  not be controversial.
> >
> > I'm waiting on SZEDER'S feedback on [1], ditto the last What's
> > Cooking[2]. Also as noted in [2] the "do we keep GETTEXT_POISON at all=
"
> > question.
> >
> > How about we just remove it and see if people who love it will come ou=
t
> > of the woodworks, the patches aren't going to be hard to revert...
>
> Yeah, why not ;-)

I'll give you a reason. We're not really strong on the inclusion front,
and translations are one thing that we actually do right on that end.
Removing even the scant testing of translated messages that we do have
strikes me as the opposite of improving the situation.

Sadly, I won't have the time to pursue my GETTEXT_POISON effort further,
at least not in the short run, and y'all seem to be bent on making that
effort futile anyway.

So yeah, why not ;-)

Ciao,
Dscho

--8323328-219256074-1612281298=:54--
