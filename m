Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 989EC1F45F
	for <e@80x24.org>; Fri, 10 May 2019 13:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfEJNy3 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 May 2019 09:54:29 -0400
Received: from mout.gmx.net ([212.227.15.19]:49935 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727249AbfEJNy3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 May 2019 09:54:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1557496463;
        bh=6L0UcH1T89vXDlkdhccgS6M9u1YK3DcLMlBI+H+pRCc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BQ4KBVPEFL92UkJJ/9VXBYQh9iJvPPfmpP99ui9pLlW+Ktyz3peRCPPwH32z5oGSF
         mbkdtlAoasbr2Vg7ZnmbM7akfCXZP1LWO0HzOrYj2Q5WNwmkUjASQym72FYo8ulj4R
         Z9dcJianNWjgywyUgBGDApHLVBmTY6W6/FTEKL2Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOfcU-1hKAIb2jlG-0067n5; Fri, 10
 May 2019 15:54:23 +0200
Date:   Fri, 10 May 2019 15:54:07 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: en/fast-export-encoding, was Re: What's cooking in git.git (May
 2019, #01; Thu, 9)
In-Reply-To: <f8eb246f-a936-e9df-4bb4-068b86a62baf@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1905101551110.44@tvgsbejvaqbjf.bet>
References: <xmqqlfzgg8s3.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1905092243080.44@tvgsbejvaqbjf.bet> <CABPp-BGfLrggLTmo+9LuLH_iGJoRNv7SHATw4XQCNx4Rk6wc7g@mail.gmail.com> <f8eb246f-a936-e9df-4bb4-068b86a62baf@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OM80ZQoMXITuVCC2OHG1PJRLIo6ZZ29hDDWCqg6ifEUhC1OfkiR
 0e1R5z+Ip6Hh5Zdjv23aBPUuM8TbwiKyJtiLS8WK2N50t9gd1jhB2e7EX6aL3jYxEdGJlVp
 kh1vPSHF0sA69aJb1Nrsty99D2h/mmZuc9owT3NJkcoWy9TQTN5CZ7vMq7AbMkjAHgQVLuP
 q6fevDppWYr9g2nI0HqhA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PeWEl0EOVRI=:gtwWGTLyAUQVc1huUzFbuv
 Ej4laa0Fcqr+p22QBbpRpNL7c/NQHoTpibQtqku8VS9TkX2xw7Q0xZsoQ2diQb2aCHFjUuEJn
 oLCGqpaIw5dUUT8qQkJ4ZziAvZzaWMhqk0oOZEv0bKzpT5zY/IRD4LVHPDPA8VKxBmU5AAFxv
 Jnr/L2snUpQpZyn4/LiQ0Ar/Lct0OstMfiMgJ63SfetR4bZ/6PXf3bjdDZaQ60w5xEyKYehJh
 4MAUaquo5SOl+W/j5MYGpPJvHDHwYoHfEbmOPr7QsB4egdMAp6ivexhbIJsmECWTJ6KKuYlpB
 dFKCxnM400LaLPKSri9PfcMp65b5dVI627XXVvftyDTe03xl04B/SyKutCGC/0/hmCGP2unH3
 pDFdVRSiHlSsz6AnjQZldQNihJxDjgjwNduOyc+W4E5ojOEoNuT2LMXhlMlNypsITvh1mKGms
 oAVfDMg4MNu32S7Pzd5Io9qdi2OEoMlk1PAaAlzHm8YKqnesrRBWRaaivWIcK7s/XuHfVsqG/
 0ADYuQHCHps8hUa/C5mTqqr+POxUP91pFPquzmCs7Nup1mwpwSJ21bkQP5HQPkapA+YPlMM7z
 0USG9HZ4m2p0u5AnQw1VTsVeyrxCcOUPy2YJZPNi+9ldb7utr0tGkP45q5kDgBHRnv139bmpx
 v3EYlxIbvIa1sNRk2UuA6D1AQyZKqsg7Dna+WqoU5G4+0OuZuhJ2d55TGpSxm+yC74I6p0Pv5
 AGdB63ArMpnaNAqVFJ2kGpOCuj1QjttJ3SxKKqzVgDElL7jnb48vi90ejmMSzHjGqQtIHh8It
 DVgLNAilhPI6JDFVVBKwi6ZEXuUHENC2ygFG+/4kQ8U1mtSlO14YqbbIsSaYEanAaBzlNgxjc
 yvT9zQ16B9KRjdwSZi+FT3e/L+vIJk/tkFy8eELMj6A0bfXjbUC3+GwtR+oSJxrcpdGhxIBNh
 gepJ1MfiKjg==
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes & Elijah,

On Fri, 10 May 2019, Johannes Sixt wrote:

> Am 10.05.19 um 02:14 schrieb Elijah Newren:
> > Hi Johannes,
> >
> > On Thu, May 9, 2019 at 1:46 PM Johannes Schindelin
> > <Johannes.Schindelin@gmx.de> wrote:
> >>
> >> Hi Junio & Elijah,
> >>
> >> On Thu, 9 May 2019, Junio C Hamano wrote:
> >>
> >>> * en/fast-export-encoding (2019-05-07) 5 commits
> >>>  - fast-export: do automatic reencoding of commit messages only if r=
equested
> >>>  - fast-export: differentiate between explicitly utf-8 and implicitl=
y utf-8
> >>>  - fast-export: avoid stripping encoding header if we cannot reencod=
e
> >>>  - fast-import: support 'encoding' commit header
> >>>  - t9350: fix encoding test to actually test reencoding
> >>>
> >>>  The "git fast-export/import" pair has been taught to handle commits
> >>>  with log messages in encoding other than UTF-8 better.
> >>
> >> This breaks on Windows, see
> >> https://dev.azure.com/gitgitgadget/git/_build/results?buildId=3D8298&=
view=3Dms.vss-test-web.build-test-results-tab
> >>
> >> Sadly, I ran out of time looking at it in detail.
> >
> > Thanks for the heads up, and for taking some time to check it out.
> > The error doesn't seem obvious from the log.  Does Azure Pipelines
> > have anything like CircleCI's "Debug with SSH" feature[1]?  (Where one
> > can click a "Rerun job with SSH", and it'll restart the pipeline but
> > also print out an ssh command someone can use to directly access the
> > box on which the test is running, in order to be able to investigate.)
> >  Failing that, assuming I can find a Windows system somewhere, is
> > there a list of steps for setting up a development environment and
> > building git on Windows?
>
> I'll just tell you why things go wrong here:
>
> In these cases, a byte that is intended to be an ISO8859-something
> characters is passed via the command line. This cannot work as intended
> on Windows, because the command line is not just a stream of bytes, but
> a string of characters. On Windows (and presumably also on macOS), the
> command line bytes are interpreted as UTF-8. As such, the bytes undergo
> some encoding conversions between UTF-8 and UTF-16LE. That cannot work
> when the bytes are not correct UTF-8 characters.
>
> To make the tests pass you have to pass the ISO8859-something characters
> via a file.

Thanks for the explanation. Yes, we cannot rely on command-lines (or for
that matter, environment variables) being opaque byte sequences, as that
does not work on Windows: byte sequences *always* have an encoding, and
are pretty much always converted into UTF-16 before continuing.

As to Debug with SSH: this is not possible in Azure Pipelines. What I
frequently do is to edit azure-pipelines.yml (usually restricting to one
particular job, e.g. Windows build, and to one particular test script) and
ci/ and t/ heavily, to get tons of debug information, then open a PR on
GitGitGadget to start a build.

That's how I investigated the macOS Mojave breakages, for example.

Ciao,
Dscho
