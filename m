Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D4EBC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 13:15:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B72EF21D40
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 13:15:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="gWLJtVRt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbgKBNPl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 08:15:41 -0500
Received: from mout.gmx.net ([212.227.17.21]:44071 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgKBNPl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 08:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1604322936;
        bh=2cw3Tbq111LxlU5Ov72ifMVTVM0NRvWSpnBdl1wu87Y=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=gWLJtVRtiRxSEq9WP9e+Rpkzt2eYQhK0p95EGcP/QBu8ofO9tVn2LLIp5Md0cHcx4
         2y9mPzofbyCHjqJailyYYc+sUkKka3mo72QJ/RowD5HzNoMTltbMNnBkKai8yBzfvs
         GuCY+/csjsZnY1ax4dn+ZtWI3faatjEYDjQIg96I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.25.62] ([89.1.214.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MPGRp-1kzEs63eeb-00PhxZ; Mon, 02
 Nov 2020 14:15:35 +0100
Date:   Mon, 2 Nov 2020 03:37:58 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     git@vger.kernel.org
Subject: ag/merge-strategies-in-c, was Re: What's cooking in git.git (Oct
 2020, #04; Tue, 27)
In-Reply-To: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2011020333440.18437@tvgsbejvaqbjf.bet>
References: <xmqqmu079rbv.fsf@gitster.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-34680171-1604284680=:18437"
X-Provags-ID: V03:K1:xUO+LgFLRso/VyiJ687Uc0nz/ihmzyko9FAcnFvbfNLXx5S+R6e
 m97T5YFeeqf1+2I98dVMnYQ1O00bcozkna5yDGPNm7M2ilvQ6ZtQ2EZ2XklGL391euHB12R
 +jIiSpD5rBVfrnShgRMhZwTgS02UVtvmaKf/ZDAgISIv8X3zQCqOMR9Hh7H3QMEF9cbEhz3
 ooQqymwU+xuj0qgUelOWg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:osGK+i4Yg/Q=:4SWJmE+n5dp88HVBs3pfnV
 5Za5XVf2EBl7nY/VZXy0TEnpf+yg2kVuQnH9LPvwanns5Vp4UABm9zjOjsTsSY7kK3T/ICYiJ
 pYFJv/aEDQZ7x9ot29ZtbtHxe1Z/FnQN+EfypjraZD5k5jjX80eczjSPotnSs49+KOC1gc8v+
 xc7gmvdDLU2bbBz01mPqBaXgK48HeTTE3QbMyWUWpm92hywNdPdxNb0fLTzhU6x0T0JoOwKeM
 PwDyLEe+90DgvGGWwVQsRigy8BcRthvVeqwGHIQ7/+1Dbxis1mK9TR4UJsYIu4i6cFtZvgDjq
 jTRQTfTlymmOwRfSEjlF1DPMHPad8rgJ4VG04TpUTg5hBTkqadKIWR1GI4ClB5ytrXNEuH2w0
 OaLmEJ+zcgHgG7pauWFHBGyMO8izhfy69nb6KPrT3XEpLZZq1cPkBtP7rVQ0kIP0yvCIfLVQH
 msG2E6BHnK41PXZYYTzkEwqpAlcyUoh7JyqQxSv3oM50MU3W8anXcSWFcck7NNRHkKVh0Y3bq
 RTrSL0Hm4mtS4Qq/mzcXVTCMwRO9wnw4KNP6KLnttArPJiimJz1jc9ybQVWMr34lr2safwF5y
 tAnoCdZVthTy2C/uEBcFeZSwX8LYNCwQgmNo/VKrEMSduijrm9MU2/U+U90p0eY82DOpl2re5
 ib+cMojlVEY1PNd4dy8zTX0elpuFpw5CyIq161DlzTH0h7bVzHVVtjtWGllGLo/1eA+ASIQxg
 QRsARuAnmL0sT0dafmnCUFUzL4b/UYcxQNOgKNvcHYXkBNv3/jNChsEOb3DdWiTzhlT6MgbeP
 YVF/mM3n8ru4RCguX9w+wXGdaGw2eu/DN5yDNaeqcm99XdhGzdBl+F6haQaEbUrP9F0cgdOW5
 Cail3mqqCloShOwPfZjCzxI4kWg17KzZZ26bl7E44=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-34680171-1604284680=:18437
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 27 Oct 2020, Junio C Hamano wrote:

> * ag/merge-strategies-in-c (2020-10-06) 11 commits
>  - sequencer: use the "octopus" merge strategy without forking
>  - sequencer: use the "resolve" strategy without forking
>  - merge: use the "octopus" strategy without forking
>  - merge: use the "resolve" strategy without forking
>  - merge-octopus: rewrite in C
>  - merge-recursive: move better_branch_name() to merge.c
>  - merge-resolve: rewrite in C
>  - merge-index: don't fork if the requested program is `git-merge-one-fi=
le'
>  - merge-index: libify merge_one_path() and merge_all()
>  - merge-one-file: rewrite in C
>  - t6027: modernise tests
>
>  The resolve and octopus merge strategy backends have been rewritten
>  in C.

=46rom where I sit, this is ready for `next`.

Ciao,
Dscho

P.S.: I recently mused about the `pu -> seen` rename, and how the rest of
the integration branches' names could be renamed, too. It did strike me as
somewhat unfortunate that `master` is not called `next`, because it
essentially hosts the changes lined up for the next version. And what is
currently `next` could become `cooking` instead. Or `kitchen`. Or
`cauldron`. And in my musing's universe, there would not be any `maint`
branch, only `maint-<version>` branches =C3=A0 la `maint-2.29`...

--8323328-34680171-1604284680=:18437--
