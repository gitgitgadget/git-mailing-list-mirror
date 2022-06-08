Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB61C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 08:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbiFHIxQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 04:53:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiFHIwc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 04:52:32 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 006E5290B35
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654675844;
        bh=XMp+oxXML6ePMLkC9xEmnmxVl8lZih3ppUA7WIliv38=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZFKCqDHX9k6dpqRrLH7eekqJzCH4oq3LhSGxgdbau5CWXzM5UGEk8W3frTa0skCpi
         KBsisI8fqgVCj3Ki/jqP6Ti2cPc9uvH3N/xZgWymwG/P71gif+GrGvvdtaEJSaPWkK
         b+iNWa/RNJUaucxCuPi+JtrLHjydlsq3XB6c5J18=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([213.196.213.247]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1o4byX3X6r-005qXz; Wed, 08
 Jun 2022 10:04:24 +0200
Date:   Wed, 8 Jun 2022 10:04:20 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>, git@vger.kernel.org,
        Josh Steadmon <steadmon@google.com>, congdanhqx@gmail.com,
        dyroneteng@gmail.com, martin.agren@gmail.com, peff@peff.net,
        tenglong.tl@alibaba-inc.com
Subject: Re: js/ci-github-workflow-markup output regression
In-Reply-To: <xmqqo7z4wcsw.fsf@gitster.g>
Message-ID: <nycvar.QRO.7.76.6.2206080922470.349@tvgsbejvaqbjf.bet>
References: <xmqqee28spni.fsf@gitster.g> <patch-1.1-0fdfec624eb-20220531T171908Z-avarab@gmail.com> <nycvar.QRO.7.76.6.2206021703110.349@tvgsbejvaqbjf.bet> <220603.86fskmxd43.gmgdl@evledraar.gmail.com> <xmqqpmjpeedq.fsf@gitster.g> <220604.86y1ydwcq1.gmgdl@evledraar.gmail.com>
 <xmqqo7z4wcsw.fsf@gitster.g>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-331246474-1654675465=:349"
X-Provags-ID: V03:K1:a/VssxuaViKMOOHSdWdlJymz/vZOh6r6MI6svlwXk4m6AFR4360
 bNC7docGSlWkeiqftU16G+gXmcO722/pfEOIiGd6ujB/XO/214wvAuJ39zViZnXolGgmcdv
 4jZ74AiExRtRCLTHjtbWsEZ3tp0N/wba/20cUMyKLkz43YHRZYibsfnwaCsY6gwAH1hXaB4
 wmhRGkE2+vUofLEnqFWnA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CmYSXPnP1Tc=:Yd5zPj1ua67OM1FlnVLi11
 H5dr1u7rKjVjv/hpjYiDN2YcgP9MUcF0Hd/KFwcVCTT0t/G4/K3vPGlRUUmgTP73AVttEKl5p
 oPJZrOzzQJvFXnfOeBbxBjYxdkj7ZMDspqHFfceqeBtGXk440bqQka+8dD/uqb6nIbvQZkqM+
 1RaQuPPd2Z5TPbUUWdxB0zDpPCc9toA/N2bv2TKCDo97SiZEeqA47ml6f0uAUJTUnLlQ1tPtP
 YuOyDbvG3/Pryad4TYSXhS/uZR5oa87N0IJ2xYr75znOA9ZHlHLFziR2isVMOWrzo/UTrCZnk
 MfLUrhHmxieXPnGRDtGLYsVgreUowHjFQudUB5itmhJqIW4u7sDH229723MQ+39GK9Z1CsF18
 1wujASO6x3INavOc0t9JJbRImIFlAFolWyE9X/FRijil+T01VmehC+Dt5Sb7rrkBbqc1cMggs
 WEbei96/+tG3FZbuAsaoaXb6cHCGWLNpsDTdVg0dsqwYLY/1ZPfuwF+870ubCz6dV83y7gnNs
 RYsMe9VngfjGvHVzp/R7WSMof839dxmaOV/azIi2CKmD1VZK2YO5DQl02qzqf7A+9QF6us9kN
 bMlZBBdyZ8MOKqrBDJcQ1wLQQepvi/thc0/mx6xJjE+yUGb4ybWyP+PhfEiYYMRzD+f3AVYg0
 fXP0CbQ+Bx3cp9NdrJOT5L6DSGYSncwF5THntHcmP99lm0dB13wBQo33QVFgJWMh/m0yyBEgP
 PTMOeOlC68rbKm4ZXk9DowGmd1Zpy9vE7RSFVX5LfUEWiCq9eDw5+KRp3lVoL6rbnfcNuhXNp
 WKZt6xcDY52ur/7H2yC1gYHgRJ0vJ1AAdOt8h6MIM2ClZ5r6LsaKSWnU8qcypOYu78x91LxDj
 R1MpgT8UnAJvLyX1iFUizghYmrKNochwLoSXYfXsVflxNgE6IsXp67A+D7nmgbhd9QyHr4Bv/
 tfxTeqFHuIMdt05C67SzgOa4mfikrPg2gCNIeDptQHOtXFFS0h+gFBSnLiF7m4CTKi+lm7OJ2
 9wp8gP5PYsoS+gg+2E51sFIkj6giEzmZnhk6Lpj1IVbeIPz/J1+gEb51Ss06fyaQ/WlcP3mwp
 m6Zr6PuXyBv1Z38Y0Jrx1IiopiECqxvcrIA1MhmsEGUJcoFam3y7dwhu/RgKPKOMTxNngfxHs
 arZqs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-331246474-1654675465=:349
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 7 Jun 2022, Junio C Hamano wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>
> > On Fri, Jun 03 2022, Junio C Hamano wrote:
> >
> >> Indeed it makes it impossible to figure it out things like this case.
> >> But ...
> >>
> >>> But this does look easy to "solve" with a quicker fix, just bringing
> >>> back the "ci/print-test-failures.sh" step so you can at least expand
> >>> it, and not have to go to the "summary" and download the *.zip of
> >>> the log itself.

I agree that re-adding the `ci/print-test-failures.sh` step makes sense,
given the recent experience.

> >>> As that shows we still have the raw log there, it just didn't make
> >>> it to the new GitHub Markdown formatting mechanism.
> >>
> >> ... it seems a solution is possible?  Care to send in a patch (or
> >> perhaps Dscho already has a counter-proposal)?

I will work on this.

> > The only thing I have at the moment is:
> >
> >     1. git revert -m 1 bd37e9e41f5
> >     2. merge: https://lore.kernel.org/git/cover-v6-00.29-00000000000-2=
0220525T094123Z-avarab@gmail.com/
> >     3. merge: https://lore.kernel.org/git/cover-v6-00.14-00000000000-2=
0220525T100743Z-avarab@gmail.com/
> >
> > I.e. to pick this in the sequence I'd proposed doing & have tested
> > thoroughly.
>
> I know you two have difference in opinions, but throwing away everything
> the other party did and forcing your stuff in is not a very effective
> way to work together.

I had already pointed out a rather terrible issue in that 29-strong patch
series: Dropping Azure Pipelines support makes it unnecessarily harder to
work on Git security issues. And it's not like we have an armada of people
working on those. I, for one, am pretty worn out from the recent work.

It might not be the intention of that patch series to make my life harder,
but it sure would be its impact. And intent does not excuse impact.

I therefore had to conclude that the patch series in this form cannot be
merged.

I recall that other reviews reached the same consensus, that this
29-strong patch series is too unfocused on any particular goal. So maybe
calling this "my opinion" is not exactly fair.

> > It also addresses other noted some other regressions in "next", but as
> > noted e.g. in [A] there's other issues in "next", e.g. that even the
> > "raw" trace logs are altered as a side-effect of running with
> > --github-workflow-markup, and of course the major UX slowdowns.
>
> Dscho?  I know you do not care about the UX slowdown as much as
> others, but I am sure you do not consider what is in 'next' is
> perfect. It seems to need further work to go back to the feature
> parity with what it replaced.

Indeed, I do not consider it perfect. I even said so much in every
iteration's cover letter ;-)

I will work on bringing back the `print-test-failures` step.

Ciao,
Dscho

--8323328-331246474-1654675465=:349--
