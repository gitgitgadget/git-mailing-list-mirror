Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 702051F428
	for <e@80x24.org>; Tue, 14 Aug 2018 18:54:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728863AbeHNVm6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 17:42:58 -0400
Received: from mout.gmx.net ([212.227.17.21]:55357 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727787AbeHNVm5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 17:42:57 -0400
Received: from [192.168.0.129] ([37.201.193.145]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MGFz9-1fchtl07bb-00FCad; Tue, 14
 Aug 2018 20:54:18 +0200
Date:   Tue, 14 Aug 2018 20:54:24 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Stefan Beller <sbeller@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH 4/4] range-diff: indent special lines as context
In-Reply-To: <CAGZ79kYVw3AXLyB1fx07WojN3dLuxJLDrbWwC_7M=9aoB9YuCg@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1808141713510.71@tvgsbejvaqbjf.bet>
References: <20180810224923.143625-1-sbeller@google.com> <20180810224923.143625-5-sbeller@google.com> <nycvar.QRO.7.76.6.1808131353280.71@tvgsbejvaqbjf.bet> <CAGZ79kYVw3AXLyB1fx07WojN3dLuxJLDrbWwC_7M=9aoB9YuCg@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:oFwYyrjYm/OPIasej81uGsJl+FTdIEgRMhNc3B5Xw3XFw+E75Jh
 FoAExu58binvlvnhkJDZZz5V5d0uk4FQj1d4IwzKzUh15CSJYKdNMmuYXmyzxCaC49n9woI
 5jH5lBLHenBwR8DAJkiNTDEWuDQQ6RHncHkBfARA0FYuwcReGt5gJ37xxHuSCAyQ98Mp0VI
 TitDeYDmPGpBmwTZETSSw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:46/DRhnxTrw=:Q30Y+ct1zB92XYHCEzEIM+
 SLUdyHDKyOlKPvQ3tGp+McH7ZgHpEWlEwZAs3FxSnE+9qXdiWwoTFsxR8vSAdDpgXFBFkJ8hg
 gCsZ4n42+jZaNN1Lyq9/mgisrDW1RRyNFx+xJ7i1qrOztW75lFciuvJ8pjivQ6mQm00RDLvAX
 PxbjnZprSC+swyB5EuAr7AUZRN/rJnRL2fUTljR5CBNC+Jc5lJ3MTGajTpVmJQs/ZTrE/62QC
 FzsMfBv2lQ0Ns71mD9cAZJZGRh6YcMm75piBrbbgyJdADaUc1VCf95UnDactJ3wGL5CMxvsLB
 2tcuwJWArEtuwlVDFE92NZe9lO2kRVpM5AI4OiraX/IpbgO1phAxcF75IdSo2vD61AgyPLFvB
 KykeSh5UKEUBNDBUmwlgJcD08BTkT65j8Zz7K8ZNNqK2XUq1makreaFxL8WyOzIXdhHEXzHId
 Y9eFdSiTk/g1QD0tUJaeNdgMwrUUPU7ao6smj8lSygkHJwxCZoKxfq9nBAjODwn3ULHIUbOuO
 uV5rJ0oeqRIrmOb+sMeoqZOJG4RSYTInevcFUEpvGysp9U4zJ0l8cLPihD08uQyN+7Ti+2oSC
 wUgMO7wKMvXVz2FddQK1v83Ys2dPBpn1x4EdosZLa3E+4eHpw1vMkXP4cRU+M9KnR08GWLXlc
 Z/RS5A1oasr+bNeGSnvJahlg5f9axKVTXjLc5cDzkVOhNTNryaTW8tBUhi82eqdCX0PcBX+Ok
 znlV175X4c3esL+wNjYaiINlzmZs1L93lyteOgb76a1WERKzTedb0lyY9xKA5EPyUKEXJnREj
 NdPQ+et
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan,

On Mon, 13 Aug 2018, Stefan Beller wrote:

> > > The later lines that indicate a change to the Makefile will be treated as
> > > context both in the outer and inner diff, such that those lines stay
> > > regular color.
> >
> > While I am a fan of having those lines colored correctly, I have to admit
> > that I am not exactly enthusiastic about that extra indentation...
> >
> > Otherwise, this looks good to me.
> 
> Can you explain what makes you less enthused about the indentation?
> 
> Advantage:
> * allows easy coloring (easy implementation)
> Disadvantage:
> * formats change,

This is it. It breaks my visual flow.

> but the range diff is still in its early design phase, so we're not
> breaking things, yet?

Indeed. We're not breaking things. If you feel strongly about it, we can
have that indentation, I *can* get used to it.

>   (Do we ever plan on sending range-diff patches that can be applied to
>   rewrite history? I am very uncertain on such a feature request.  It
>   sounds cool, though)

I remember that I heard you discussing this internally. I am not too big a
fan of this idea, I have to admit. The range diff seems more designed to
explain how a patch series evolved, rather than providing machine-readable
data that allows to recreate said evolution. For example, the committer
information as well as the date are missing, which would preclude a
faithful reconstruction.

And that is not all: if you wanted to "apply" a range diff, you would need
to know more about the base(s) of the two commit ranges. You would need to
know that they are at least very similar to the base onto which you want
to apply this.

And quite seriously, this would be the wrong way to go in my mind. We have
a very efficient data format to transport all of that information: the Git
bundle.

Let's not overload the range diff format with multiple, partially
contradicting purposes. Think "separation of concerns". It's the same
issue, really, as trying to send highly structured data such as bug
reports or code contributions via a medium meant to send unstructured
plain or formatted text back and forth between human beings.

Ciao,
Dscho
