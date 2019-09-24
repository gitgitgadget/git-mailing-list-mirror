Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE531F463
	for <e@80x24.org>; Tue, 24 Sep 2019 14:30:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441367AbfIXOam (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 10:30:42 -0400
Received: from mout.gmx.net ([212.227.17.21]:53259 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2393649AbfIXOam (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 10:30:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1569335436;
        bh=Hvtj17CHgd+0GwQZPlmKEBIw1NGc0h9OWaD2HcFr6ts=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UYRf6TA/CdxdPano6q44rZRLLT1imMTFNmrzWCe8H3/7H1+vfu7H3kBkveCBNcKjE
         29nZx94kazUCwO1ffUSfS1f4Jcp/rZVjP/L7/++jcBlNR4Obl2g0tPonGewsrDJ6V7
         /kiQk9wBnot7P0sNZlwLAhqIyeHtLUeioCkiLvNk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N79yG-1i7SJ5478G-017YZU; Tue, 24
 Sep 2019 16:30:36 +0200
Date:   Tue, 24 Sep 2019 16:30:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: Git in Outreachy December 2019?
In-Reply-To: <20190923181950.GB21344@sigill.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.1909241629530.15067@tvgsbejvaqbjf.bet>
References: <20190827051756.GA12795@sigill.intra.peff.net> <20190913200317.68440-1-jonathantanmy@google.com> <20190913205148.GA8799@sigill.intra.peff.net> <20190916184208.GB17913@google.com> <nycvar.QRO.7.76.6.1909171158090.15067@tvgsbejvaqbjf.bet>
 <20190917120230.GA27531@szeder.dev> <nycvar.QRO.7.76.6.1909231444590.15067@tvgsbejvaqbjf.bet> <20190923181950.GB21344@sigill.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:iubhuxwbgFkgKBvwfEyOffiy8Dvk4zthuEADeNMCTHh+j1Ydqsp
 tSRL+gUDePeUhfQ8kWLmobmD/NZeMfr/RAkYqkON1nYqRuxgDLjf4/ZMngqNmV2t670QCXu
 /hAfuqN8v2T2j4oTQN/95G0nHF/gwbAFuh0bliw/X6sGrjxts+hcXIshuY272s64Cde03UO
 N8fA5XB5cvZEgReOU+DMw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kKiSoesBPM8=:m8/VSUgFkzmJ8eAfPgzqo/
 LsmtCDKCSaP1LqllW6G3NhbmOes5BhSggs0Y1kJrMDqJgszjU4ThpSwfe1g+5pTTgVN3EW5e0
 3zzXNa6+6VYfSu3S0++vNL9YSAaRm0ESPUCr/dIPkXRp1SsjxVYRasvmshNiFYo4tKb2OuguF
 25ToMv1W9Mt4LN1lg0XjGIR2Ae1ATEQopXzZxbdcoN6N6nw6++s89W1PvYnZTRKHdZqrTmVGj
 FADc1mDtzKex+7fEannao3SHzxekfIH8IYVLwC48qd0jeTd4s6BTcZ5oYWhmwRVYO82WbKiFJ
 x0UgCkq7y8aJR0hcXyXOd2mvbllsBhaCby75tpBGjgUKV4scrgye0YEU46gvhoR/jpxZQ0pFM
 FPuNfGMIUesZzsbU78CyreOUOf9xUY0D7OoJdsqqH3UZyXBZVBj65MFruPVUD1Zpfrm3tfM65
 49ZIeTsmiQAFnqA+zVOK+2YKN5plxCK8RYDssDaxa9y5awhky/+Ze/MB0xFTSBGH26Co7s9UM
 05mAd6kaWIl34+HHoC+WtwJkls2OelFGHItC9F4wNAXCtwgGzNo2zz5DuSv3bCEAv5ssyG/68
 hQIHlovCh5h7u562q5P7PyUONIC5GNivtHrMQhk0jR2ROtgGbFK+CG29SrGgcnAtaFsGgOkaX
 8NJ23fNQXLQ6TF48sDP+tMomP76B/3F/hfSCkRSaqw4lOdApLiAXdmBl0oHIQyBVwiomjprVO
 ibxh/atchBp1jfhG1P6gI8zY0HqN7Bc5eeCE7yis0Y/nwzsgNQx8qJW7/B2q/nbw+Hr+s9LNP
 m8pjQwj6TybmQ+LUjQ0fj+Ktc+CU6WWptKEa/QhTHsFVhMICC77Z8344cDMnaaegIynfHdfdU
 2KgmD71JqBJTuJCRWdXXm+3P9a3GgwTG6Sx+BV4OOgeGi7q7TrTgz25GoviRBd/jqLFTqoTpd
 ebXb/FaR2sQNkZHcZIXA3G8gBLFVPacrdevHCmAL30o6vs7jPfKhiDuPlXSyX0MK//FBRzEGO
 zVxFrKTJtw6KLAVpl7lUVLpokoBgzqmJNCSoMIb0aULrvE1gM3rkgw8ja+huZ4FUnP8mOI5jn
 tOwPtp8rkNKgJ5ZKO9Eecp8kpelgxmcrIVhgq6dSAJXDeiR4NCLfhdL/JWVug6L8qoERZqRPF
 EnrnE9l8l3iy9o0xK3KA4zYTgK2jcsgI9YeJZvuMqJGnVAnIW6zRASApwqebBnIrNudliE/8p
 16kVL9UMh3UaKYhuagjdqNQhzf9zMGFHt9sqSdzJfdqCgkHCOdPkazvSPP4s=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,

On Mon, 23 Sep 2019, Jeff King wrote:

> On Mon, Sep 23, 2019 at 02:47:23PM +0200, Johannes Schindelin wrote:
>
> > The evaluation of the lazy prereq is indeed not different between Bash
> > or dash. It is nevertheless quite disruptive in the trace of a test
> > script, especially when it is evaluated for a test case that is skippe=
d
> > explicitly via the `--run` option.
>
> That sounds like a bug: if we know we are not going to run the test
> anyway due to --run or GIT_TEST_SKIP, we should probably avoid checking
> the prereq at all.

Yep. Likewise, the `&&` chain checker seems to run even if the test case
is skipped.

Ciao,
Dscho
