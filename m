Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C49A7C433F5
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF25A60F38
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 20:53:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243701AbhIMUyr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 16:54:47 -0400
Received: from mout.gmx.net ([212.227.17.21]:39423 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243608AbhIMUye (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 16:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1631566387;
        bh=D+PcNlhmwNfP/a+jVgN7X7zcImo2L+rOXTOSMg2wRhs=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=W5/aDLNsg1+TO3U6TpcdiGAgaeXXEXCU0dtYKStaqH8M1SZth3OdKnzyzdudFRNDn
         yDDtHW/lEf+K52NpZ0EW0lYZicZH+E+S4LaqOUWBumG87sf6QcqfjnqKcvWmCVJax9
         NWDH4ZrJ1JjDQUinf+usjGQJJMnUbtNEo2khCNb4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.116.95] ([89.1.214.165]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mn2WF-1moBs41kKV-00k8cD; Mon, 13
 Sep 2021 22:53:07 +0200
Date:   Mon, 13 Sep 2021 22:53:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH v3 00/15] [RFC] Upstreaming the Scalar command
In-Reply-To: <87ilz44kdk.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2109131914080.55@tvgsbejvaqbjf.bet>
References: <pull.1005.v2.git.1630691688.gitgitgadget@gmail.com> <pull.1005.v3.git.1631129086.gitgitgadget@gmail.com> <87r1dydp4m.fsf@evledraar.gmail.com> <87ilz44kdk.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1064592839-1631566387=:55"
X-Provags-ID: V03:K1:XgCYJ6ssyyBYn/AysdmJQW3XaZOefd6yLIYyOMmQerT16nMl7aH
 3FU4rFPOELJEzyjprxT3qVPnAx8GeQAT7opBYpA3pUhPMgYdLcnuekcRv5HYm7OC+sN5O1I
 uUDYUH5tIVt7eKWpc6AIYhDXtF+IxhyCsMTnUBmo8p/9/muVetNiotE1G0nmbEtHcjBE7SV
 14jIFjlcjZmKuvv1yvusw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UXCLw4MnwTk=:KUoYGlfsFgBBIUL69rkF7J
 +fk+V4FAk3imlkAdMgBrD05vNmR2BdTL9fZMbMLTyl3KgysHZdNDBrl2/GJqorzt5O/8TQL8P
 AXp5bzoQjO6e00br1yWp/mN2fcdojXFFJeT3SZezj2QOXTkpKjHK5u6NpD1V1jXvoaCI9LvLb
 QJQHQzx86S/U9AO6mnP1s7QkwQmAcWf+i4A1QenfXo7f3+ao2hXMYe/TI0/D3qBs9IV4Z8PaG
 V32rJygiWr8smOcxo5vyW3aAF/GWoIu+pSFcpFOLHPrgQHve9vN8gGs7b6BXyCtXf/9SD1+WQ
 jWjRL4vVzpVy1BmgwCk1KiSA9OmkK+b7kzmRuTw12drVwEsq25me0XgRuip5KXAGm4X84ANBr
 V4QmPsdEynt24TVL76YL/PWu8CiV87nrc1mlTJVRoB/65Ex+XFaJ39OH5nl2GuWpIng+gtrpp
 Qa5mf4ThipzVNHRouoY/Y2T/149syH2rnExvTVhcCursp6ZB1ma3IhGQuRlp+21j7Fms/QfSZ
 pj1c96vF2ocOA6imqBjPds1jOUrHodyYdSo09FdI4qjjSyvJDRxSigJ0allIfBZ8BjQBlBq0o
 5EJAPpWmoaU83C6nN7qxPFafbscFqb5avHaCf7DMrppduk+q66uWpywWs415uzKQHWhzXhwwb
 0NAOeKGadZTFRTD9dQvDYRe7tHbjegn7Tz6opl6DUFyq5jvV4TuRqRAn9BLEn9RrF1x9+RX3c
 5p+5CQOXBPM9Gjf/5UWmOwOEXz2Sv2+RlxpjElDkOnMaMoP4CiI+rOjtLoqOKdHeRNVF5f9b4
 6+iwYIHt6I7ZOXg8LRA+dz2rsJYwBf/lPuDZygO1qLwP8h5tzqBXOWt24rorfrRlPUMPwWzkf
 NrqWs+hrCQOivVKTwx8BusODGf/x4borTT5ZqxV9g1LZ4GTHTOCsoDb4FoQMHLyZuP65LvVZa
 Nz3GeChDIx69YHGnZxRiD/s0ZAL8CE469JR2TkF31S+9IwAx7LUWCH8Xf2rdeCdQ37K01QZpi
 Ki8mkIyVKGqxb6DSQTY7JBoRaRDeF9+DaQrQfAm7EORATZeGiD9fKvlx7OVRoBptP7iD/3NBb
 txJNEwKhyDgCw8=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1064592839-1631566387=:55
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi =C3=86var,

On Mon, 13 Sep 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

>
> On Thu, Sep 09 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
> > On Wed, Sep 08 2021, Johannes Schindelin via GitGitGadget wrote:
> >
> >> Changes since v2:
> >>
> >>  * Adjusted the description of the list command in the manual page , =
as
> >>    suggested by Bagas.
> >>  * Addressed two style nits in cmd_run().
> >>  * The documentation of git reconfigure -a was improved.
> >>
> >> Changes since v1:
> >>
> >>  * A couple typos were fixed
> >>  * The code parsing the output of ls-remote was made more readable
> >>  * The indentation used in scalar.txt now consistently uses tabs
> >>  * We no longer hard-code core.bare =3D false when registering with S=
calar
> >
> > In the summary I had on v1->v2 points 1-3 are for v2->v3, respectively=
,
> > outstanding, addressed, outstanding:
> >
> >     https://lore.kernel.org/git/877dfupl7o.fsf@evledraar.gmail.com/
> >
> > In addition the discussion ending here:
> > https://lore.kernel.org/git/nycvar.QRO.7.76.6.2109082112270.55@tvgsbej=
vaqbjf.bet/
> >
> > For that point: I think it's fair enough not to properly handle the
> > cleanup case in "scalar clone", but perhaps add a note in the commit
> > message that unlike "git clone" this is known not to clean after itsel=
f
> > properly on ctrl+c?
>
> Seeing [1] about the planned re-roll I have the above a shot a few days
> ago, see the original discussion at [2] (indirectly linked above).

There is a good reason why I did not engage in that tangent about
deviating from the established `contrib/*/Makefile` paradigm: I find it
particularly unrelated to what this here patch series is trying to
accomplish, and I cannot bring myself to be interested in the proposed
build system changes, either, because I do not see any benefit in the
changes, only downsides.

I find the distraction unnecessary.

Besides, the way I designed it, the code in `contrib/scalar/` intrudes as
little as possible on the core Git build system. The impact on the
top-level `Makefile` is quite minimal, which is just the way I firmly
believe it should be.

In short: I do not want those intrusive changes to the top-level
`Makefile`, not in this patch series, and not as a follow-up, either.

We have much bigger fries to fry: namely, how to migrate the improvements
for large-scale operations from Scalar to core Git, so that all Git users
can benefit. Granted, it will take a lot effort, and it would be easier to
move around `Makefile` rules instead. But ultimately, the benefit of
allowing users to handle larger repositories with ease will be worth that
effort.

Ciao,
Johannes

--8323328-1064592839-1631566387=:55--
