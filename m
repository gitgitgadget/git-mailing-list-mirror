Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D9F1F597
	for <e@80x24.org>; Sat, 21 Jul 2018 22:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbeGUXCD (ORCPT <rfc822;e@80x24.org>);
        Sat, 21 Jul 2018 19:02:03 -0400
Received: from mout.gmx.net ([212.227.17.21]:42001 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728169AbeGUXCD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jul 2018 19:02:03 -0400
Received: from [192.168.0.129] ([37.201.195.94]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LnTjW-1gEPa62nOQ-00hept; Sun, 22
 Jul 2018 00:07:40 +0200
Date:   Sun, 22 Jul 2018 00:07:23 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>, gitgitgadget@gmail.com,
        git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 09/20] range-diff: adjust the output of the commit
 pairs
In-Reply-To: <CAGZ79kZzHN+HKYeezyeNwfe2+dTGHnOzs3okJTVrfm=AFwPbnQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807220003070.71@tvgsbejvaqbjf.bet>
References: <cover.1525448066.git.johannes.schindelin@gmx.de> <pull.1.v3.git.gitgitgadget@gmail.com> <6b31cbf72c4752771965de333b3cb6e82cf90b2b.1530617166.git.gitgitgadget@gmail.com> <CAPig+cTnRi=HuyZy+bMKeU9qutZb3K5C4qTb7gCQz7GyGN=FRw@mail.gmail.com>
 <nycvar.QRO.7.76.6.1807171306380.71@tvgsbejvaqbjf.bet> <CAGZ79kaft-8pHGwyqAK0yNL3p5sP0VyKNn29dxoZ0wFGWGEHPA@mail.gmail.com> <nycvar.QRO.7.76.6.1807202052350.71@tvgsbejvaqbjf.bet> <CAGZ79kZzHN+HKYeezyeNwfe2+dTGHnOzs3okJTVrfm=AFwPbnQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-361898683-1532210860=:71"
X-Provags-ID: V03:K1:LLiHcJMu/Z991V82WURenGFDkjNjo9makSFNXct2KK8OUHOJjQn
 PJY5OZ6y6B3D1UC8cCNHn/Fh/klz7udY1yOHPq7L6Jg8Sy9WnuRjeVX+PlgKBCGe2iVC1W/
 LYQfu5/GqAlfdncfjejNFUq0Qx7u9qs5/lPb0N8p4jP9n/fush6nS+ld2JryYUCjZSi9+Qq
 L36nQ7+6rgF95C9OD8wWQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Je1dqPziJw8=:j3tiQ2cFAttDpjSl6upk3T
 JhwA1e1T07nvF0iudtuQy44+aHoFFOSljs6g6iMhXQOrsTMI9bO9SPZ750ZDOKiT3NQpXIh9B
 M4HBelTBpdHQZ0xzWsntOeJSJ1zTTfHN5+b+TA7Si0I6UCjQQBrOIatEUsv7YH4Ew3X+5LruM
 uGf4PrnlJuvDq/vA8Z2Oo/wBnNKr1HpSh3cvCeoQAjgGGgTunr3iTexnzmuQRl+4mygeHtVbF
 JZczonXNUszX5pNla+bA9/4keZ6ubd+3ntTdJD8VYmAIFaVTXpkTdiEKnIvVPIGZeqL6NzNTb
 qIUa3dSGh39YQz0+yx0X/Hv2vpIRR9FlKlx29lqu1ClHrZbH2a2icFAfseEJ00u815vswgtk1
 Dl3qA1EsW3PFbUPXUGDlbI1oCFlQ+a1UmdGV90iYSxfSwjkDJGV640ZIDRSy6dJtsZsOOYap/
 Ns10yXceYht6BvlHGZE1qx22FCxkyjPHH7j/s4NnkgGQIfSksj6HSnWz0/KPNdPgVZ/QfYJXM
 Onjw6GcDRlwbWCJq9cyMIGh4ii6bn2aJVovdgqI+atZLI1e+SXG+6Eza1dLJmojcQblsGbh64
 KlFpzI4WMmuBntrEcgAdGTNJgD4P1So9ay2jtAJyPcP0woOtrAzALgS74o9PnIKh3uvJwo3la
 MnqelK0q+VFmWov7VfzBECo5O3oq7Xob3rxoay+jU14aecz3ePZmAhjoy+1w8vqLNDabAT5uW
 poofvG5cG1WCJC9xy3mdGwWGMN0avzg51ulZ0epJHO3AiehWqNnAVuYovtoxXLrkvpoa5FEVS
 qQY0S5o
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-361898683-1532210860=:71
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi Stefan,

On Fri, 20 Jul 2018, Stefan Beller wrote:

> >     1. To roll again.
> >
> >         A player who rolls two sixes can reroll the dice for an additio=
nal
> >         turn.
>=20
> This is where I had my AHA moment!
> (Consider my software development process as chaotic as a dice roll
> So rerolling is really just rolling the dice again to "get my patch
> accepted" ;-)

Wouldn't that be nice? But you only get to reroll if you had two sixes.
Tough luck for you, Stefan.

> >     2. (programming) To convert (an unrolled instruction sequence) back=
 into
> >        a loop. quotations =E2=96=BC
>=20
> We do not have unrolled loops?

When resending patch series? *rolls eyes*

> This was good back in the day where the cost of each instruction weighted
> heavy on the CPU, such that the JMPs that are needed (and the loop
> variable check that might have had a bad branch prediction) for the loop =
were
> slowing down the execution.
>=20
> Nowadays (when I was studying 5 years ago) the branch prediction and
> individual instruction execution are really good, but the bottleneck
> that I measured (when I had a lot of time at my disposal and attending a
> class/project on micro architectures), was the CPU instruction cache
> size, i.e. loop unrolling made the code *slower* than keeping tight
> loops loaded in memory.
> https://stackoverflow.com/questions/24196076/is-gcc-loop-unrolling-flag-r=
eally-effective
>=20
> > Noun
> >
> > reroll (plural rerolls)
> >
> >     (dice games) A situation in the rules of certain dice games where a
> >     player is given the option to reroll an undesirable roll of the dic=
e.
> >
> >
> > You will notice how this does not list *any* hint at referring to
> > something that Junio calls "reroll".
>=20
> We have undesirable patches that were 'rolled' onto the mailing list,
> so they have to be rerolled?
>=20
> > Footnote *1*: https://en.wiktionary.org/wiki/commit#Noun does not even
> > bother to acknowledge our use of referring to a snapshot of a source co=
de
> > base as a "commit".
>=20
> When Git was a content addressable file system, a commit was precisely
> "a database transaction, [...] making it a permanent change."
>=20
> Side note:
> I was just giving a talk to my colleagues about diff aglorithms
> (and eventually describing a bug in the histogram diff algorithm)
> and we got really riled up with "Longest Common Subsequence",
> as the mathematical definition is different than what the code
> or I (after studying the code) had in mind.
>=20
> Naming things is hard, and sometimes the collective wisdom got
> it wrong, but changing it would be very costly in the short/medium
> term.

My point is not that naming is hard. But picking names that are
*different* from what is established nomenclature is... unwise.

In this case, it makes an already unnecessarily awkward code contribution
process even more unnecessarily uninviting.

> Another note about "rolling things": At $DAYJOB I review changes
> that are committed to the another revision control system w.r.t. its
> compliance of open source licenses (hence I am exposed to a lot
> of different projects), and some of those changes are titled
> "Roll up to version $X" which I found strange, but knew
> what was meant.

To "roll up" is, as far as this non-native speaker can tell, an
established way to express this action.

In short: nothing you wrote can adequately defend why the Git project
chooses to confuse new contributors seemingly on purpose.

Ciao,
Dscho
--8323328-361898683-1532210860=:71--
