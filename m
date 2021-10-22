Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63531C433EF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:03:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FF0C603E5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhJVKFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:05:35 -0400
Received: from mout.gmx.net ([212.227.17.20]:45143 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232521AbhJVKFe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 06:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634896996;
        bh=vg423ek+tvlSnk2tZ/Z9rSK6X5v8l/1Fc0KdrOpuPnI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Gf4aNMBmaItLdXQhyfcOqRuCZJowARon6sgRQztVDRzECeVp64JayctykBdzYbI5A
         vUwZpDH5xUoiwUE81WYSLYvLobRz7wy1PVAfLDzLu3o60mtoe7MmvPL5Utp4KYP3zY
         9PuCM5e4KXWRFUBhd+gY1f082a8pZSW9WMvESqoY=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1nDkF10oqd-00bHAb; Fri, 22
 Oct 2021 12:03:16 +0200
Date:   Fri, 22 Oct 2021 12:03:14 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Son Luong Ngoc <sluongng@gmail.com>
cc:     git <git@vger.kernel.org>
Subject: Re: vale check, was Re: [Summit topic] Increasing diversity &
 inclusion (transition to `main`, etc)
In-Reply-To: <nycvar.QRO.7.76.6.2110221201290.62@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.2110221202430.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet> <nycvar.QRO.7.76.6.2110211149530.56@tvgsbejvaqbjf.bet> <CAL3xRKe6Ewps2n54KED7kX=8=Nk7RWHvTkhoB2X-Y1-ZjKEizw@mail.gmail.com> <nycvar.QRO.7.76.6.2110221201290.62@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:Fu550RtFJOs2xNdqw24/jR9nU/JinoqIS8gvd3LhhiKUqablWHB
 eIFXgeQqSLNHZoTKxQwGTwvdaHNFJvzp2oTdybrVVgICR9Si+a+vo7JhUXrdR1G91Y0JcR1
 y1unQE5wxIaO7VPfwXYrgf66UPMbT9/bkdbWyC+nic7zVuT24JAdAQ/lSXrVVRTzfiBCDL/
 4dr0CsNrLlGvqq8YUE74Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/xAwL4f7jWM=:Bngqrn3IT8qtrsUq2PsP2p
 ztg4g4ZoKQowlSJaKrdE0ppKSf49k+fzPHQ1+CHTpeKK597AJJ/p0Vs7Pg6XY8egPXoYPKOYO
 0ymzP1Tlk1lLH1uDqNP2EXOylC4AEBH6gKBjAAnw0e6Ib0rjOOKhFmDjgCX6kBKcpB45X8E0E
 caxXwqhQMmLAoAs37K6BqZ57sNjEAQ9VAsOcS7XyuES88kAjJ+OMk8CU14TBfiTaLTajf0iUn
 W4pRZI1+iIpgHArltLAuaulwBeaOhFBgxmgGrQDYDkIY1QXvjTL85KjVmxC76CsrN65q0K2/X
 iGcEZkJ/WmtrsjDskKYOKekmTLE5+MzrOvnXT4FHgCY35YnV0KtjgF9HCsIJS8q4Kh7rxA8Bz
 1kYfRaxpnBylHNfyl9/xY/T7zYn5AwMScRsGHxK4B6r7M6d8idX+27qRP3BqZmtS+uE0KePqa
 /DixaFPiZsj/y2Xm0CMBvUspoi8rjwuFIMgxdl2JQm5CT26RTjcnH8ITgYwyhKM+bEwlS6xBH
 AtuGy2spZT6tdOT1I+YXD8Qrr4WI4eXr1n9w8FJDxDaccywqtnEQw9MR0HkwVjo+Qhrpk9ry4
 GBBp3unlvrp1tiswFNTkRZ/6tpn/S32OqpjVseUM0vIWxM+NJWshYAXuXhsEdyAYBsKe3IwrL
 MNMNibRk4yuwEnWUbp8BkKHPAdUxQnduJfT6Ap7FseOhjxQkzd3uEu22zqWoiRgtXe9RxFlmX
 jXnwDiWlku2485EIhwm/dnc85PS/V0LjJr9OFyvrWuTpDaEMjNMQHVrPTvojACPHCGGlLZRVX
 kksN5InUP27dpT2eCYI3EEpb/cKOb2iDnLGrt5XQ81fjhZ46X9jkIYMluJ4YqbpE8EAEaY/ut
 tUIEUAnpss2OD5tXPtnbxysJ7BYBkUofrATWgaFHC+qE807aycF58/MBgvp2bKNXhgqOugRfz
 jD5YZsRkHL40+hRECbLg8FQv6k1kApMQvabvlOUZ4/nMvhAnGKXJMWgI57W9BAXdl3l3oVpHB
 ceIox/cbnZRr9kzmqIT35FwmwfUxGZJFz21TqA3KYNdfMRdsjlxBKT4cO3/g5jkKzMyY9tXLb
 38G/xr0kWBXCv4=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Son Luong,

On Fri, 22 Oct 2021, Johannes Schindelin wrote:

> Hi Bagas,

Sorry about that, I meant to address _you_, not Bagas.

Ciao,
Dscho

>
> On Thu, 21 Oct 2021, Son Luong Ngoc wrote:
>
> > I would recommend, on top of having a guideline document, to have a
> > Valve check (1) setup as a commit-msg hook and run it as part of
> > GitGitGadget CI to help folks shorten the feedback loops in some basic
> > cases.
> >
> > [...]
> >
> > (1): https://docs.errata.ai/vale/styles
>
> How about setting this up, then opening a PR?
>
> Ciao,
> Dscho
>
