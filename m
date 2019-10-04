Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC1541F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 21:24:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387636AbfJDVYt (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 17:24:49 -0400
Received: from mout.gmx.net ([212.227.15.18]:58043 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729161AbfJDVYt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 17:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570224281;
        bh=N5UoMIRqqTmVjMOfU+oDvIpt8O/tWW8KqLw/V1R4oP8=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=b29K3rNVZn15nYplaNryGaLJSX3SaMBPJe/QmMYM54fPidbr7QDh3MUcTmGM0JOBn
         ok6mYqZYigidTKjj4UwgK1hfoaE9fuUOxOoSF73YddZrN4L/ZjlCfJ/Y1la7Fl33K6
         1ndiIf3KYvQhPqt6ohanJsGU3HeWPb96XaePbxFY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacOW-1hio8h2abK-00cB6N; Fri, 04
 Oct 2019 23:24:41 +0200
Date:   Fri, 4 Oct 2019 23:24:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Johannes Sixt <j6t@kdbg.org>
cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned
 types
In-Reply-To: <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org>
Message-ID: <nycvar.QRO.7.76.6.1910042319190.46@tvgsbejvaqbjf.bet>
References: <pull.288.git.gitgitgadget@gmail.com> <pull.288.v2.git.gitgitgadget@gmail.com> <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com> <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
 <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:ro+qAS3LusFNf1X2HMvRdXCHbXCT7VjFQJeAx6JcAVvm7X0zHQ9
 3+E89gcjSWgRrRtf4tYEcJADgJD6cVgpRnX6sZhzy7s2+F/4sjDfPWL+0WSV/bjjNassoNy
 NXOs56Cq7MazguPw+AnCa+aLIKRrLsy8usPrOcPv+dBh3543OyuMpDRAgCfygwEknPw39w1
 ahs7dGRK1CyKpiRgMhlpw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dKKj3ACRcVw=:61TfsEUthOwwvmx2EBDKoY
 xn9TXrmzb7YVw4gkqjiqzvufYFANJ5BUSGsMKfuPyD3Eb/d7867ST5auZaAZI833XVb6jUOtc
 TBRfv6Rcy/BjRawKrbzKrd0Y2zz+CrMMNJF6YZMhA9vyW98l5fU8irLBsuVL/bFB+kijogTAG
 7iNpw8LvfikBZ5N4rbaDl85QFAwEoub2Tbh6qMuC31zTVRRCHnXCYvkTfIBY0rFoA/c8oYBOp
 v6t4ZJ/58Cpe+VYXhtIN8+G5ULUunO0eyDjbMmgicO+oDNb5+OcSoO4NBHsLj0prmlNiUhIzQ
 14XTobXk0QZ/q57bODPr/jpSgbiHbC3gGD/IQkvBK7duOYrASTwKtyrXgFmpzbLwAt1tLMGzb
 5yarZ+0iiEqNLXV151z8k+kSgboBtuTugsZC0ewFeQ/7RbAY/9rR0Fke8lqedjcfgJ5C4UE4v
 Mr2DeZmBrKP8L1f4UG2BqiWhlOk2smKUTQMzteWvHPTnIgRVfoLtLUBHE14usfyIC0bhnmNbx
 CjmPMe8wf/iOTylAMREwFN5q0TpLaKsVQaM3V2n5GczmuinGwII6feQUdmtA39Mrfv5Kfd0Bd
 bB+ZwlinEUkvTEJptAuwSJC2k57tnGxA25atrVa6tBZ+iPx6D2oNUGQvFMNhHB4w810z3U1h5
 B9soj4/qi6F0Gh8PkcW00oXps+99Z+Rs1v7p0scVOdLfuvoIsKW/zjatN9T5pWFO6Ka9mvPno
 s9bfvmD7z627F+Z2SjDhcA4tXJmbebfMl9UIv8zUWHNSKrlnkWC3mO20Su+MiHUZn7DufnFL3
 fgsn3NhS9JZYSCXmHsXxouWDdpk4OAijjTzVWnR6MmrFHNjmfGMZ67UhmHFJwRbX4lREbBiJt
 khwTTTiXisu6MhY/652e+FdSBF9iIJa0Fg3KycenOS4GB/LY2XVDTv7GIiw/UZquyNOEokU2H
 aGhXEgYmlqaOkL9ZIn9N+3FSvcnaBcZZux6aaJLZzHOSUj7sSs/tb4qd7y2tdqDG3Q5SrIVRy
 1ARDw3G7S/punIoJcFQHWtguhJqYpMTXrxzlj0NEHoa/0c9vJEjheopHNukvE82vFjPXWO8Ib
 4VjZ39pjqdkkYlPchuOUNlo73/B6hL+369wjICpjQzuMglJi0WVY+3ZYWVZHzs7Vb3O8yLBaw
 lmTi10wF4NEZTPeXhBjhoGrAFTxo9uu/D1qHng2mS76Ptrqt2LJDd4wP0DKPagQ5o0oLGyzKw
 7M6GQk4RQDtljLYa/o+V+Y434+TamkMg3wr/KlWt0dtBrfKIX+goK0V8UiJQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Hannes,

On Fri, 4 Oct 2019, Johannes Sixt wrote:

> Am 04.10.19 um 11:55 schrieb Johannes Schindelin:
> > On Fri, 4 Oct 2019, Junio C Hamano wrote:
> >> These three look good and too similar to each other, which makes me
> >> wonder if we want to allow them simply write
> >>
> >> 	return insert_pos_as_negative_offset(nr);
> >>
> >> with something like
> >>
> >> 	static int insert_pos_as_negative_offset(uintmax_t nr)
> >> 	{
> >> 		if (INT_MAX < nr)
> >> 			die("overflow: -1 - %"PRIuMAX, nr);
> >> 		return -1 - (int)nr;
> >> 	}
> >>
> >> to avoid repetition.
> >
> > I tried not to do that because there are two different data types in
> > play: `unsigned int` and `size_t`. But I guess by making this an
> > `inline` function, compilers can optimize for the common case and avoi=
d
> > casting _twice_.
> >
> > Will be fixed in v2,
>
> IMHO, if you don't accompany insert_pos_as_negative_offset() with a
> corresponding extract_pos_and_found_condition() and use it everywhere,
> it is more obfuscating than necessary.

I do disagree here. No overflow checking needs to be performed for `-1 -
<int-value>`. And that's what the opposite of this function really boils
down to.

> The *real* problem to solve is to ensure that the index/cache does not
> grow so large that 32-bit indexes would be needed. Then the calculation
> that you want to hide here cannot overflow.

Well, that may be the real problem of another patch series. This patch
series' problem is to add a job to our Azure Pipeline that builds Git
with Visual Studio, and it patches the code minimally so that it builds
even in `DEVELOPER=3D1` mode, for good measure.

So I'd like not to dilute the purpose of this patch series.

Thanks,
Dscho
