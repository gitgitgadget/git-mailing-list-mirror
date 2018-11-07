Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8666A1F453
	for <e@80x24.org>; Wed,  7 Nov 2018 10:34:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbeKGUEc (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Nov 2018 15:04:32 -0500
Received: from mout.gmx.net ([212.227.15.15]:47439 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726225AbeKGUEc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Nov 2018 15:04:32 -0500
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZEm-1fnCCq19cu-00bZ0I; Wed, 07
 Nov 2018 11:34:36 +0100
Received: from [192.168.0.129] ([37.201.193.149]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0LjZEm-1fnCCq19cu-00bZ0I; Wed, 07
 Nov 2018 11:34:36 +0100
Date:   Wed, 7 Nov 2018 11:34:34 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, lucas.demarchi@intel.com,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] range-diff: add a --no-patch option to show a summary
In-Reply-To: <874lcu6vr4.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1811071130570.39@tvgsbejvaqbjf.bet>
References: <20181105200650.31177-1-avarab@gmail.com> <CAPig+cThS8959jW9+X7bJHy5RG9Uoj4=V8ahjf2zGetTNw03SA@mail.gmail.com> <87efbz6xys.fsf@evledraar.gmail.com> <nycvar.QRO.7.76.6.1811061140560.45@tvgsbejvaqbjf.bet> <874lcu6vr4.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2108484838-1541586876=:39"
X-Provags-ID: V03:K1:uCJ2WTZbRDhJhYkwlyUBSyIQGNXpyi7lW0z8RB9x8akjPi+NpkE
 9UilfpWKQ8f3aChU1+fTnNWBRrQKkBLTVWEHTLyaHlrZ3G/WIXN9ZlMTGMPf2eA5Iwkpmq+
 S63IvXUw3AtsLh3SdDvA0fJ1jrT2luwYYtvA3dd6dA+YGDi6kEXWhdYidQgIk/UcWNauGpi
 aYwYJvmzBRYPYW/EsK1sg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:lJkrKC/BIH8=:S4x14ngXMSdQGUKcA22nM0
 xZRQ7sIriPvAR3MaJ3+tHh5IsEByvhVkscjIyk0Ki5z9CxSqvg/hMFtfjIDGBoD0bEUUthibQ
 GuC7n3kYZsQ5bqWcKd89UYBOXayZwKGotYcFlMfyJZzPJEwi4x8DFhmAeDhZT+cH9RCe/yCm/
 Sd3yzhcg4K95LHb1s8s6NH3zPQ2AaxTuV9NieIwcj3ycJXwf/2jNMkzDVdU30eHJo5pOMucqc
 Buouqlo+rocvxnjI5Ooc3NfuuPpjNjqfSw3iCiHMVZ7o0RVqmuaI5Gy7uAKz7piRe9b2C9Phi
 WyZjfom4+FOGE/BEerhStQmbQs7/qAj/C2HiPV4dJWyxVppe/wWI5/YKkcxFlAxRm2f45dgps
 3wQ3w9wGfAWReh0qmz9SRcFsrZZb72rXmt0bqnzeMQsh3mC+Ase946y0H4hzbedyD0iZQhCoy
 jDDwqg7vrVF+wuRke/QItPvC1NFSjwk6TF7XPSwGxVI8/EjaINa2hhL9Pt4lQ02LPoRaazpC4
 zLDoqQqc9gY1HQF7W93qTAUbjDClQPqXxiWswQE7ga2vmsvKXSFz6U9G6ZMVwq6h+YdGq9S6j
 7DsU7ldeIUiQF4r4a6wQhvaJItAsZ+Ma8RC4Aj07tVgPuXOYYLK9+TkEDm6Dsgndv5YNsv0gU
 sqePEX2YU4hUKtvB5Ajr/pbo0qtGC5MvuuNRukFz3/Z2kvUIvY1jiEFZ5vPD6wOuJGUE0jbxv
 TC0Es0mavsb2H5SM4Arqca6kRAmdmzUy5ojKIXMhXHOVlaOigFLE2hCQEMpzkkffVjL5kJot8
 QeP13vs83wSs/0KL0hGxmXNzjkJHxakSgffBgcj0DlH4M+VeOo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2108484838-1541586876=:39
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi Ævar,

On Tue, 6 Nov 2018, Ævar Arnfjörð Bjarmason wrote:

> On Tue, Nov 06 2018, Johannes Schindelin wrote:
> 
> > On Mon, 5 Nov 2018, Ævar Arnfjörð Bjarmason wrote:
> >
> >> On Mon, Nov 05 2018, Eric Sunshine wrote:
> >>
> >> > On Mon, Nov 5, 2018 at 3:07 PM Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> >> >> Add a --no-patch option which shows which changes got removed, added
> >> >> or moved etc., without showing the diff associated with them.
> >> >
> >> > This option existed in the very first version[1] of range-diff (then
> >> > called branch-diff) implemented by Dscho, although it was called
> >> > --no-patches (with an "es"), which it inherited from tbdiff. I think
> >> > someone (possibly me) pointed out that --no-patch (sans "es") would be
> >> > more consistent with existing Git options. I don't recall why Dscho
> >> > removed the option during the re-rolls, but the explanation may be in
> >> > that thread.
> >>
> >> Thanks for digging. Big thread, not going to re-read it now. I'd just
> >> like to have this.
> >
> > In my hands, the well-documented `-s` option works (see e.g.
> > https://git-scm.com/docs/git-diff#git-diff--s), although I have to admit
> > that the `git-range-diff` manual does not talk about the diff-options.
> >
> > And for the record, for me, `git range-diff A...B --no-patch` *already*
> > works.
> 
> Neither of those works for me without my patch. E.g.
> 
>     ./git-range-diff -s 711aaa392f...a5ba8f2101
>     ./git-range-diff --no-patch 711aaa392f...a5ba8f2101
>
> This is on current next, 2.19.1.1182.g4ecb1133ce. What version are you
> on?

I tried it with git version 2.19.0.windows.1.

To verify, I repeated this with `next` (git version
2.19.1.1215.g8438c0b2453a):

./git range-diff -s 711aaa392f...a5ba8f2101
fatal: unrecognized argument: --output-indicator-new=>
error: could not parse log for 'a5ba8f2101..711aaa392f'

Which means that something broke rather dramatically between
v2.19.0.windows.1 and 8438c0b2453a.

Ciao,
Dscho

> 
> >>
> >> > I was also wondering if --summarize or --summary-only might be a
> >> > better name, describing the behavior at a higher level, but since
> >> > there is precedent for --no-patch (or --no-patches in tbdiff), perhaps
> >> > the name is fine as is.
> >>
> >> I think we should aim to keep a 1=1 mapping between range-diff and
> >> log/show options when possible, even though the output might have a
> >> slightly different flavor as my 4th paragraph discussing a potential
> >> --stat talks about.
> >>
> >> E.g. I can imagine that range-diff --no-patch --stat --summary would not
> >> show the patch, but a stat as described there, plus e.g. a "create
> >> mode..." if applicable.
> >>
> >> This change implements only a tiny fraction of that, but it would be
> >> very neat if we supported more stuff, and showed it in range-diff-y way,
> >> e.g. some compact format showing:
> >>
> >>     1 file changed, 3->2 insertions(+), 10->9 deletions(-)
> >>     create mode 100(6 -> 7)44 new-executable
> >>
> >> > The patch itself looks okay.
> >> >
> >> > [1]: https://public-inbox.org/git/8bc517e35d4842f8d9d98f3b99adb9475d6db2d2.1525361419.git.johannes.schindelin@gmx.de/
> >>
> 
--8323328-2108484838-1541586876=:39--
