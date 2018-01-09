Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 961821F406
	for <e@80x24.org>; Tue,  9 Jan 2018 16:29:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759319AbeAIQ3k (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Jan 2018 11:29:40 -0500
Received: from mout.gmx.net ([212.227.15.18]:58592 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759230AbeAIQ3U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Jan 2018 11:29:20 -0500
Received: from [192.168.0.129] ([37.201.193.20]) by mail.gmx.com (mrgmx001
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MMCFR-1eVvQe378f-0086L4; Tue, 09
 Jan 2018 17:29:17 +0100
Date:   Tue, 9 Jan 2018 17:29:18 +0100 (STD)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: rebase preserve-merges: incorrect merge commits
In-Reply-To: <CAJs94EaKObUhvNedMmOGWA9SDMH7y-2V7DLkxO=MabddpbjYFQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1801091728590.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
References: <CAJs94Eas59UxZ+490AUSOuB37i+JBEvbCnGBMVpKi1G469OTbw@mail.gmail.com> <nycvar.QRO.7.76.6.1801081452290.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94Ea52CcNvBxXVeZLvgsaS4YPiXaeDvRm2zUopoLVowgm+Q@mail.gmail.com>
 <CAJs94Ea_Kf5RFMuPreBOGYEjhECdQP2F7m=-wDkf9xRnQFPfhA@mail.gmail.com> <nycvar.QRO.7.76.6.1801081730170.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94EYrBgNW-bzoEgy9=fStJW2esoULxfOHX45V63HavqOCpw@mail.gmail.com> <nycvar.QRO.7.76.6.1801082034470.31@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz>
 <CAJs94Eb0Yf=4Obk6BpifSZaPiw3ArY-01LbTb1nUaM+o2hSayw@mail.gmail.com> <nycvar.QRO.7.76.6.1801091424170.37@ZVAVAG-6OXH6DA.rhebcr.pbec.zvpebfbsg.pbz> <CAJs94EaKObUhvNedMmOGWA9SDMH7y-2V7DLkxO=MabddpbjYFQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:y/YW+JQYBnrUN0XpGghwQe9nfuo0Lw4yE9pKT4XMcFncugunzyY
 HvoZ25E1ivJ/cjdEDGO+qKne0N+XsNa7vemkDxocy37cBS77Pum+DBlR3YNT86DCWYohegk
 eFY/mzdK6DIV0OVyC6n5sFAtDbFHdcr76KVyX3oGErsxxxJ5TSjxVd4bxVgUgT+oNnWNsNv
 qZaEdL+hnap8nEbA3dXPw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:AyWnwawjKPE=:dsaQRIxg+6qlZSdMS5UxTY
 Vluup75esDrsnNKYMiIqM0g1lRevNl8Tk7qKGOZUhPdnjddvDUAdatO+CkceWbLUxqpNwyKCy
 jffVt1KtTVHmnm4g/rtTOjgW7uXAkzqWKQOYPwhUzZDYnhZihHyaP5A5RVuxealYJA/yxNkP5
 g7805HLLQmQzwOXnsfxzWevTJGHa7adD5533U9ImGHcO1XWmFXQBl4ac/0ykfcF7WK09Yzo1a
 sM+Ba3bVBOzjsOi7ZlzWiykwsTedwQDZLKlB5U+YZjPF5FtHFiTFTDftMMfoY+sznR+nBVh79
 k0RPyXTcOZDfKTXovXOy1cZ3hE20TGOEfSLeu9fTTXSXqVQbrZFn4xsnlkWoqNDnN+xPLEyko
 x8QXDY3g1KEib9NshNr0cH2O1RuASkH+jyuinJ8x313LrlFdKyH0kWwbjh1tLpVQe+29OE9qH
 n6xSspP6P1vhHZPegAk4oIZVcVHa2ge+w/QBPbBIRjsjpZTFwa2//jPrDuHMVbndzliXY2L24
 8UuPONKgyXtSFYbYnpgjOCXwE3bhjBeoZg7MqifcCroBbUv63u5HP1vjZHQjztEZngSopoHzm
 NW55K1rHwK1N1hk7mIce6Axz8XFX/FHIzrwtYF9AW4ltR2bCL9f0TZ+BSxdC97fKyWdUh7TEr
 DQYJt7WcaxVZ7lu0f+jR1+qpilzRGn04FXJfklZ69Y3uTKrIu5OKVhtLVcpGLxCQeDHFG8/HE
 DhyqkA6sekS1u29VTRxrOSnNr+GuzVErUiQwYSIAAuYg3kAIlaHMRvyHLz8qhz2uHGZzXn4R1
 h2Hw2bQietegkeGZTNXYJQ41Sx2OZPoc/h/IuuLU5QIUie6uY4LFxzr/epJ3O06qrVcaNQV
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Matwey,

On Tue, 9 Jan 2018, Matwey V. Kornilov wrote:

> 2018-01-09 16:25 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Hi Matwey,
> >
> > On Tue, 9 Jan 2018, Matwey V. Kornilov wrote:
> >
> >> 2018-01-08 22:36 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> >
> >> > On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
> >> >
> >> >> 2018-01-08 19:32 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> >> >
> >> >> > On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
> >> >> >
> >> >> >> 2018-01-08 17:42 GMT+03:00 Matwey V. Kornilov <matwey.kornilov@gmail.com>:
> >> >> >> > 2018-01-08 16:56 GMT+03:00 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> >> >> >> >> Hi Matwey,
> >> >> >> >>
> >> >> >> >> On Mon, 8 Jan 2018, Matwey V. Kornilov wrote:
> >> >> >> >>
> >> >> >> >>> I think that rebase preserve-merges algorithm needs further
> >> >> >> >>> improvements. Probably, you already know it.
> >> >> >> >>
> >> >> >> >> Yes. preserve-merges is a fundamentally flawed design.
> >> >> >> >>
> >> >> >> >> Please have a look here:
> >> >> >> >>
> >> >> >> >>         https://github.com/git/git/pull/447
> >> >> >> >>
> >> >> >> >> Since we are in a feature freeze in preparation for v2.16.0, I will
> >> >> >> >> submit these patch series shortly after v2.16.0 is released.
> >> >> >> >>
> >> >> >> >>> As far as I understand the root cause of this that when new merge
> >> >> >> >>> commit is created by rebase it is done simply by git merge
> >> >> >> >>> $new_parents without taking into account any actual state of the
> >> >> >> >>> initial merge commit.
> >> >> >> >>
> >> >> >> >> Indeed. preserve-merges does not allow commits to be reordered. (Actually,
> >> >> >> >> it *does* allow it, but then fails to handle it correctly.) We even have
> >> >> >> >> test cases that mark this as "known breakage".
> >> >> >> >>
> >> >> >> >> But really, I do not think it is worth trying to fix the broken design.
> >> >> >> >> Better to go with the new recreate-merges. (I am biased, of course,
> >> >> >> >> because I invented recreate-merges. But then, I also invented
> >> >> >> >> preserve-merges, so ...)
> >> >> >> >
> >> >> >> > Well. I just checked --recreate-merges=no-rebase-cousins from the PR
> >> >> >> > and found that it produces the same wrong result in my test example.
> >> >> >> > The topology is reproduced correctly, but merge-commit content is
> >> >> >> > broken.
> >> >> >> > I did git rebase --recreate-merges=no-rebase-cousins --onto abc-0.1 v0.1 abc-0.2
> >> >> >>
> >> >> >> Indeed, exactly as you still say in the documentation: "Merge conflict
> >> >> >> resolutions or manual amendments to merge commits are not preserved."
> >> >> >> My initial point is that they have to be preserved. Probably in
> >> >> >> recreate-merges, if preserve-merges is discontinued.
> >> >> >
> >> >> > Ah, but that is consistent with how non-merge-preserving rebase works: the
> >> >> > `pick` commands *also* do not record merge conflict resolution...
> >> >> >
> >> >>
> >> >> I am sorry, didn't get it. When I do non-merge-preserving rebase
> >> >> --interactive there is no way to `pick' merge-commit at all.
> >> >
> >> > Right, but you can `pick` commits and you can get merge conflicts. And you
> >> > need to resolve those merge conflicts and those merge conflict resolutions
> >> > are not preserved for future interactive rebases, unless you use `rerere`
> >> > (in which case it also extends to `pick`ing merge commits in
> >> > merge-preserving mode).
> >>
> >> Are you talking about merge conflicts arising due to commits reordering?
> >
> > Merge conflicts can arise from commit reordering, and they can also arise
> > from commits introduced in "upstream" in the meantime.
> 
> Then I am totally agree with you.
> But initially I said about conflict resolutions and amendments already
> contained in existing merge-commits. While rerere can at least learn
> conflict resolutions from existing merge-commits, rerere cannot learn
> and recover manual amendments.

Great, so the information is all there and you can implement it? :-)

Ciao,
Johannes
