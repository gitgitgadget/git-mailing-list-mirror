Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 312AEC433E6
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:37:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0397F23142
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 14:37:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729467AbhAGOhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 09:37:34 -0500
Received: from mout.gmx.net ([212.227.17.22]:36573 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729173AbhAGOh3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jan 2021 09:37:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1610030155;
        bh=iYOlB7HhPWBjtqOHMFIBNbhuyD1oIkuY9fsOu7ctV/c=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=j1T77XYotKi+Xwx8CSfYFY2p3gi1YkmCM6ImjLu39nRmMCkcIbxE2+xOlbVv9p588
         WEF4H6s/O/5wpsMTlIhPfO/2wwMdzyk5O9eNZi+4OKF0B4HsR7vGetoMgsdj8N/Cyc
         tS0QPzOsIGzPuzisWNNSnZoFe27Sb3OH6L7EhIdo=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.251.4] ([213.196.212.28]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N0oG5-1k18W749qv-00wnZv; Thu, 07
 Jan 2021 15:35:55 +0100
Date:   Thu, 7 Jan 2021 15:35:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Philippe Blain <levraiphilippeblain@gmail.com>, jrnieder@gmail.com,
        git@vger.kernel.org
Subject: Re: Patchwork instance "Submitter" attribution and GitGitGadget
In-Reply-To: <xmqqiml4bsra.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.2101071534440.2213@tvgsbejvaqbjf.bet>
References: <75987318-A9A7-4235-8B1D-315B29B644E8@gmail.com> <nycvar.QRO.7.76.6.2001201314580.46@tvgsbejvaqbjf.bet> <xmqqiml4bsra.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1224246309-1610030156=:2213"
X-Provags-ID: V03:K1:WCRX8auu3h9JNmG0cZO3C93FTHBQrPpB3BbV3QqI/fASwZt8qY1
 sP7K1NcEqe/zOfIoCZ1oqUxB7US1cQXJ8zkLXZ/ibrlSo8KmYhtRc6CW5T5oFgLcZMi+3HN
 hj9aoZVfT5rnN4BaKtbRsMRv6F6ZnjCYWGQnzyzyYq04s2O8usneaq1Okew7Ksq1LCHxyhd
 pjB/nz5T5M4ApbkzCDHWw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:O84WB/8vjPk=:OuzA4haOznQK78QYA+VzGU
 HNearYkIoBJcS4UCz9DtPaAK6gtEFk6x+TefgFajsiFUxrCsMFPIj5RKbNpuQRpqa1XZDNBvk
 ZZ9yLCkKpVZiRiu8EjHFNFSWryhTRcDspSOpNkEbLtQjKdZRtQ/E+SbSH+b+HoowgNEOyU09m
 tVogLe4FkGpZJsJmYMqueNV50fxvtSOQisaxcaCNhU7w0ahdW89opFxKWbNB6CwNg6THpLVsH
 ul9J1SZprRhpDolgYSsBZpbkw/FuZnOYfehUqzRExPLXnznnX7J75N+xzUEoz9lMF0vXFVF6n
 2oZ+kLOTDbwhpIKILSh6S0+WcdJymgDguXbfN0En8SMGbR/FWg3PSlkiqxouRhTdCKIQ8p6Sv
 4gvA5O20YRwxZKQGhM2WL+PsTTXD4eh2OdtyhiH2vOJRPj00u9671V+vRewKGLC40S7f+5VqG
 Zggq1fUKA36P2tT207ddjQbYRC83iyjeJMsD12LGY8QR1yR2CRN8e2kUAOr7hudThIrLZ+kTy
 QnCO0J6OffOKI9Izt0BuUvQsQuCCVD4JUyNoOj/H3sV3W5MwC8OY7rC00eUl4rbx9LMlxH+bo
 oFgiiX6dy+a5ffSnDvK7qotmRPgsShYhfp/8cMYGdYRauz9n8GEc7EqAfl4kPfzcNA+Iz8x84
 JJhcIIdGb8csZsP+56W7CBCsaorlzb+6EmQJIauH7OoC6kct7QUnlxgMNnmzRMwN9MsBE5oPX
 SxVfUrj3m6EU2pvAaWWiu0QLwf/tM6zqyrrdhty+UqxKy82l2xIxghDDDOuteQRx/i8XVa5v0
 mOsUG9B4jXjgITuWb0Sn05l4tZRjm2/0oS9Kdp+uLSvYjYucYP0P+SHx4ZKn3c73UKhp+NAWc
 1Tgc9zsFPMQE52sea5sz6J1s4V+Szap8eMv2Qf0bg=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1224246309-1610030156=:2213
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Junio,

On Tue, 21 Jan 2020, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> > On Sat, 18 Jan 2020, Philippe Blain wrote:
> >
> >> I=E2=80=99ve noticed that all (I think) patch series sent to the list=
 using
> >> Gitgitgadget are attributed to Dscho (Submitter is "Johannes Schindel=
in
> >> via GitGitGadget") on the patchwork instance [1]. I don=E2=80=99t kno=
w if you
> >> are aware of that or if there=E2=80=99s a way to fix it in patchwork=
=E2=80=A6
> >
> > Right now, it shows "Lucius Hu via GitGitGadget". Clearly, patchwork u=
ses
> > only the email address as identifier, being unprepared to accept that =
the
> > same email address might be used by multiple contributors.
>
> Would it help to use the "Sender:" header?  IIUC right now GGG
> records its name on "From:" with its e-mail and a human-readable
> name derived from the author of the ptach, but if it can record the
> true author on "From:" and leave GGG's name on the "Sender:", would
> patchwork use the "From:" side of the identity instead?

To tie up that loose end: GMail seemed to insist in my tests on replacing
the `From:` header, therefore we cannot implement this `Sender:` idea, not
using GMail to deliver the GitGitGadget patch series at least.

Ciao,
Dscho

> If that works, it would have an additional benefit of not having to
> add the in-body "From:" to override the mail-header "From:", to avoid
> attributing the authorship to GGG.
>
>
>

--8323328-1224246309-1610030156=:2213--
