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
	by dcvr.yhbt.net (Postfix) with ESMTP id B0E1B1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 10:45:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbfJFKpu (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 06:45:50 -0400
Received: from mout.gmx.net ([212.227.17.22]:43443 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726248AbfJFKpu (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 06:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570358742;
        bh=tK7B8E2Mg5DBeWOwilVMmNtTjEsx2KMmq+aQbT38Yaw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=dLqCCzdZ+O1HxwCd3eDaV6Z+bhF2ad95Jv0cg+iqkcUNlshnWvGMEcnu5m5DAP3OG
         Vz6EDe1jovYDqdRgsBV7EksqH4b6tTCEmVW76zZypg5pvC3E9DpVgivYZrgywwoO7R
         ii58VQhGXuIfAiPkXXUpPNZBCcl6OJX2Lr0fIpIs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MvbG2-1i0uEi162w-00sfG7; Sun, 06
 Oct 2019 12:45:42 +0200
Date:   Sun, 6 Oct 2019 12:45:26 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in
 our Azure Pipeline
In-Reply-To: <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1910061157320.46@tvgsbejvaqbjf.bet>
References: <pull.288.v2.git.gitgitgadget@gmail.com> <pull.288.v3.git.gitgitgadget@gmail.com> <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:z+2g1wJTkQIrfwyuc67hXl16U2StyvPtE47oc2xqORdlfpfZaRF
 NKRZeFOOevXBWppkDWJQDCmg54QvngQAl6tabonhlktNmQP0CuiQGm/p7bspmxMY+7Mssfd
 Uvwnu8Wmw9khMIdM2y/cyClW/tsaUPADsa1pdaku4yCL0xzTRvyxTwir2Ciw/KxsaONwED4
 ZZ1/Wa6/QYrFfOCJa/H/Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:tBRfUINLdv8=:sAgf22Xj3tbSY2t6c3lrAV
 6Pgw46n4gL3PQcsroVGeUE4NDuK2heXTENhBbYmPwQGJnp2V+/5Zp5HQ0pk4MSt8H2s/gtI4+
 +mdfAoS2dV1wzab0FYo7rDZlqTJGwmpphP3CzgB2rON89BtiEYNH9ki2VIwdSTkSs/KLCzQAA
 tXQUfYf7zItrR0r1rq+Zo2CvnmqjhHlPmMwLAdhL12TCcBObI/n2LA00Hi8iO0omfAc5LXDgy
 7vCzfXvIFFUNsPO8ynxCyGNfNr/ROmnhxJATZ7CXDam3z+rTuxYAhL3dEmjhbOkNbNXUxrhkR
 GKCJv/ZSXEjoaH7PEmXJa9a1lzhN4ljkGdYzOVr8Ve8UOKazlncPQUdw2hlOpjCkBT1zM+GOl
 9F3KEkt5v86aPJzbnybIGaLN9hEiMZqh0zzyp2+hEaje13JvJxQkFt9GUrFHrPnOheEElCMzb
 os/xWdKK/QjrZBabJNZPwWlqIidZWrzqxsutKX/loQRJPJCYlDnIoloFzWnDXOokruRlyBSx3
 EyklK+hrBkI2gZ8Gsxdn+A22Dg6K3wMv4eOnQxxa45iXcRRp+qi3EPeQU0BkArJgL371o0yht
 Ny4W9KtkgR5CzRFccqhl6IxPVgwqOJC9S6GmBoDZgmLymIM16x3ukZAMMgSyllwANEXxAK2AC
 RfYSlPAh9EEzcDngOWzRt0FGsZeSTg+Wxe93QFE8nggAZXf7bxlAMfZBW4wov9QyvLxnlVQtn
 1+b2LPgyk1AXrs9+61qvPHXKDoelnruFDuFMaFXWF7VBiHunjUOja6rT61Yu8gUOwidgTjKqG
 airKZhZ4PEv5aV3UkqeQjYPfjBDwYbP3AN7KRFSppwTT1D/ZjZ4+JCLlLM2KBamC/QP7ImnZw
 YJTbotIhJUY3LaIhhMQPwgXkHx0/0H0zf+LwHlEPq64NWYdWhZEAEu+as9U9ZRRFKQCX4vf2t
 UIp68HWFu2bx28uglOKMCqaSLq6QLr1sF1vVGwCJ95rbT9KTjALbkJUOSIHbnwKRaU6bHrPwY
 z4AfZed9AtYc2lpN5K61L9pnmZklpN0xIhQd5DV2JymbeIITs8uJ2EFkRwubwCRP79zc28DCZ
 i+aAtH5eup7Op+zQGpASKOx5IKWRLUHlZ2CGRu8RPqBHnHoDQgRx6y0EUR+lnopYhHKfvo2X4
 afUymlrgWrcA55W6fRDWD3CmDoo1sEj4vds1r0s1wG3a6M6eWslgKogrzx5AkGUj9MJDEmPFJ
 tlOlCxRYYgZ888lSS7jPLgDSYOTdM3sTAtrMGcjwM6L9q8YP+TbxM/xyN924=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Sun, 6 Oct 2019, Junio C Hamano wrote:

> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
> > Range-diff vs v2:
> >
> >   1:  4d0b38125a =3D  1:  4d0b38125a push: do not pretend to return `i=
nt` from `die_push_simple()`
> >   2:  8800320590 <  -:  ---------- msvc: avoid using minus operator on=
 unsigned types
> >   -:  ---------- >  2:  7fe2a85506 msvc: avoid using minus operator on=
 unsigned types
> >   3:  8512a3e96d =3D  3:  e632a4eef4 winansi: use FLEX_ARRAY to avoid =
compiler warning
>
> This is less useful than it could be.
>
> With a larger creation-factor (and we can afford using a larger one,
> simply because the user of GGG _knows_ that the two series being
> compared are closely related), what is output is entirely readable
> (attached at the end).

I just implemented this here:
https://github.com/gitgitgadget/gitgitgadget/pull/128 (it still needs to
be reviewed and merged before it takes effect).

> Oh, while I am suggesting possible improvements on GGG, can we
> please tweak the sender date like git-send-email does so that two
> messages in the same series do not share the same timestamp?  When
> multi-patch series are displayed in MUA or public-inbox News feed
> out of order, it almost always is from GGG that gave the same
> timestamp to adjacent messages in a series, and it prevents me from
> applying them in one go (or saving in one action to a mbox).
>
> What send-email does is, at the beginning for N patch series, to
> take the current wallclock time and subtract N seconds from it, and
> then give that timestamp to the first message it sends out, and
> after that, it increments the timestamp by 1 seconds.
>
> Note that there is no need for any "sleep"---the timestamps are
> given by explicitly generating the "Date: " header.  The last time
> we looked into this issue, I think the code was trying to do almost
> the right thing but it was giving a malformatted timezone and forcing
> the sending MTA to override it with the wallclock time or something.

You mentioned this before, and I implemented it. But GMail ignores the
`Date:` header sent by GitGitGadget, and I don't know why. See e.g.
https://public-inbox.org/git/4d0b38125a13d85963be5e524becf48271893e2b.1570=
201763.git.gitgitgadget@gmail.com/raw

	[...]
	Date:   Fri, 04 Oct 2019 08:09:25 -0700 (PDT)
	[...]
	X-Google-Original-Date: Fri, 04 Oct 2019 15:09:10 GMT
	[...]

I am fairly certain that the latter is the actual `Date:` line sent to
GMail, and GMail just decides that it will not respect it.

Once https://github.com/gitgitgadget/gitgitgadget/pull/125 makes it into
GitGitGadget (adding the `/preview` command that allows to send patch
series to the PR owner as a test), it should be easier to start
investigating further.

Unless anybody here knows why GMail rejects the header. Maybe it is the
`GMT`?

Ciao,
Dscho
