Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 29B62200B9
	for <e@80x24.org>; Sat,  5 May 2018 20:03:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751825AbeEEUD1 (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 May 2018 16:03:27 -0400
Received: from mout.gmx.net ([212.227.17.22]:56401 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751809AbeEEUDZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 May 2018 16:03:25 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0LdHLB-1eXVNz2jjN-00iPmL; Sat, 05
 May 2018 22:03:14 +0200
Date:   Sat, 5 May 2018 22:03:15 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 00/18] Add `branch-diff`, a `tbdiff` lookalike
In-Reply-To: <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1805052141550.77@tvgsbejvaqbjf.bet>
References: <cover.1525361419.git.johannes.schindelin@gmx.de> <cover.1525448066.git.johannes.schindelin@gmx.de> <CABPp-BEEgeo=5hkaTe8LrOMONSv3VdPi_cP4ADMC69oG3htC1g@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:lVPFqfsR0je+hEASif3aD7otYLCXr9xlM+uRGsDlqVfkafeCfW8
 fLxe1DgjFeYbK8ddfDu03ckPByD3R0ARtyQGzofMmElCOXT6uhBX+rKaOyGy/oFtB75gw/E
 O+t7x6xm4hlnkHJGYaUrySh4WVIGr6K3rx9sb2/YHfDP6n8Fj1vPoeqBN+MEiSEoMjI4qDx
 HBs4nrrr00h5EaUlZQV/A==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GpAa9+MyWE0=:EAmXewJ88KO+APupMvPZFW
 jv7M+9aeTbqIJUdCHLOvl/59Nn4GgDrdYVGFn02dHdURX/v7b/whAZmsvUhZySB/wFXCKClP0
 2KWoZEQ1HtcRTUc/0llCnLe+i18D8rvAlJALuKNome5ONr6CN9oI1bcPBusjbxt7x2d8JXyKD
 TezNOGH4lueSq4Uu9l/sK6w5t2dtEEY0PG/dz4mY+ilM+wp76ZPGS8YJTiSfMxslBIPmQQPPL
 w/hQXEiHloz39ByeozKbQ7SR7/y9rTqgiWa7ZuSuPq80dYl5G6btitclX0T3xrRD1m8sIz6PM
 66hjJIs1jUaeikL7RRJ+4fzKqlsDlusNFyuG/jaGx4uqCFnbQ9iHgK5vDPUReQAH9+/fDnbKP
 ociiDgGxiCvzYy6/MkiQ+SfBWpU1VBuArn2RrO75xkKwjgQs7i/iYz59N360R4d4xpRXbqZA6
 aQw45gN0pQiZqD7W85ziG/Nq9gRioPOSzFAFfx/6dSmRNDx3YG3jonbztwBWE5vcJ2oXT2J4K
 lnFtVizZ5wx82ExL+WaQ4ks7sJCh4M44PcOomeTTWbeUAVAzMifQtdNK8XmhnSmT4XSfBVAN8
 +Fh8CmnXml2dzVYRifma0bjuiXkg9gBIbxZmwLXH7A0sIBoDUaLKbIlXTzJf06vOBqTYG+A4P
 pjSHHOQZBzdjAUWb55mYp7I09gJMJAhwD4+yyAE1Umx3zvntdBi5ulUiLvn/WWJ4CRFDTWSql
 Sr62j53kw7ooyHZEbEltC56U1fK3g/ynNRkjy7i+CJpukCFHccX1Zx8pKh0ZduPiJqzcd9B8b
 WW2bu/8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Fri, 4 May 2018, Elijah Newren wrote:

> On Fri, May 4, 2018 at 8:34 AM, Johannes Schindelin
> <johannes.schindelin@gmx.de> wrote:
> > The incredibly useful `git-tbdiff` tool to compare patch series (say, to see
> > what changed between two iterations sent to the Git mailing list) is slightly
> > less useful for this developer due to the fact that it requires the `hungarian`
> > and `numpy` Python packages which are for some reason really hard to build in
> > MSYS2. So hard that I even had to give up, because it was simply easier to
> > reimplement the whole shebang as a builtin command.
> 
> tbdiff is awesome; thanks for bringing it in as a builtin to git.

You're welcome.

> I've run through a few cases, comparing output of tbdiff and
> branch-diff.  So far, what I've noted is that they produce largely the
> same output except that:
> 
> - tbdiff seems to shorten shas to 7 characters, branch-diff is using
> 10, in git.git at least.  (Probably a good change)

Yes, it is a good change ;-)

> - tbdiff aligned output columns better when there were more than 9
> patches (I'll comment more on patch 09/18)

I added a new patch to align the patch numbers specifically. I considered
squashing it into 9/18, but decided against it: it will make it easier to
read through the rationale when calling `git annotate` on those lines.

> - As noted elsewhere in the review of round 1, tbdiff uses difflib
> while branch-diff uses xdiff.  I found some cases where that mattered,
> and in all of them, I either felt like the difference was irrelevant
> or that difflib was suboptimal, so this is definitely an improvement
> for me.

Indeed. It is more or less ambiguities that get resolved differently.

> - branch-diff produces it's output faster, and it is automatically
> paged.  This is really cool.

:-)

It was actually the paging that made the most difference for me. The `git
tbdiff` command broke for me as soon as I switched on the pager, as tbdiff
got confused by the decoration (AEvar had put up a PR to fix that, but
that PR has not even so much as been answered in the meantime, so I
thought it'd be a good time to rewrite the entire shebang in C, also
because I could not use tbdiff *at all* on Windows due to its hefty
dependencies).

> Also, I don't have bash-completion for either tbdiff or branch-diff.
> :-(  But I saw some discussion on the v1 patches about how this gets
> handled...  :-)

Oh? Does 18/18 not work for you?
https://public-inbox.org/git/71698f11835311c103aae565a2a761d10f4676b9.1525448066.git.johannes.schindelin@gmx.de/

Ciao,
Dscho
