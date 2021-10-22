Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2CD1C433F5
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:01:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90E6A611CB
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 10:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232488AbhJVKDa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 06:03:30 -0400
Received: from mout.gmx.net ([212.227.17.21]:60747 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231944AbhJVKDa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 06:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634896871;
        bh=NsD8HRwXU2ffz/0aEmylRJwluU+vjnIeztcEhxunCUg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=fBlJzlWB4bTHzkCKJZQWlXBzHVpI4llkFm9ZjF1MHGzur8fgjGNXk+bqGg5AKLu4F
         iNZI+4EG7F6geLtisPt8DI+Sq/c2POGRXtaatSXEbxbY0kKDQ56MS46PPwtrrtIW/m
         Rddw/6WBezlQVClHU4GOFtWXiX1ohFIQEL494ZR8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.19.78] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MhU5b-1n8G6G0MkN-00eaFP; Fri, 22
 Oct 2021 12:01:11 +0200
Date:   Fri, 22 Oct 2021 12:01:09 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     git@vger.kernel.org
Subject: Re: [Summit topic] Server-side merge/rebase: needs and wants?
In-Reply-To: <bdf47d51-9cf6-046d-fd97-aa35299daadd@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110221155460.62@tvgsbejvaqbjf.bet>
References: <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet> <bdf47d51-9cf6-046d-fd97-aa35299daadd@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1401386132-1634896871=:62"
X-Provags-ID: V03:K1:5+GIJTch5GFSzsCqMqIVHpQ4vVx/wShA+1cXzATvSTF0A2ZIDe7
 AbEeWPD8A+2gCIIaevV4Rm7acke42ncx0aZD+1PpyDg4V7Lt7QHEtQA4IUSRF2pRhaSiCh8
 AL2aeyPEQ0c+oJKKKJURzKRKzmPuX6d8nWd0x6cjkVIIWViM33nPyP9PLNtUMsKE32ZBD5n
 IQaGcUJ1molQobOV6ao6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0://YsXn6x5Ds=:Gg2n4SfH6rGsDgeN8HQqhm
 BIj1ZEqZ2Tun5rGAsDyDFf6m7AM5p9hEUPYq9G2vB3Gnd1JSX0XBg9MigysY/1TJ+6Lh/b5wQ
 idZ1J8cfoRUKiTw3nhW0aDkeBYJiqTV10oVuLa0IlYJv2AlSQo1QgM92AxvBo/Najw/VLLs6u
 ept4lJyE7JpACI8T8quh2ta9d8rPtgbNxs5b+9Dii0FRx7x9dqE7XpSoquoMA7a1BGpxg/hcW
 NgMVDZ9OufgDeYot20YoOVuojcy823rm7Y0G8alJnIM6kv5dqD0azDeJWBER4UG+JCZXe1cdq
 6LLzQbOL7rafZTjWttMyFD2ss2zc6jgnI2NU2EMeHqznyR8SwKyHTDni4xP3QLqYnwhISrMHb
 zJJI/SdnndfKuSC06ukGJKFZmZmakOk7V3omgz8rwsQDizy8sQeeeV3Y/+5AO5MloMtzNkNsG
 BdhgMeo5qY/ZdHuQOva82pznEZWzeJSs2PGukmUrkBN8UgLnQYc8SCXWvPDfPXt9dTCuyhe/L
 3O37FKdIurxlAPh7IsmSVRJ7v3D3s7jxqTgpAP6kjxuMSLu1JA+LH1AvS2prbBkQ1XauZOnQB
 4iAT0OTbcVnFwB+pNriQ5KdUci/jBNLq7aKDRYsJGFXWY5iyZ+jz5wRkVqoPMOyP1W/prg+yl
 Ijnzj+9HxSVtjjNmfIvsVgWuMq+yhzHmIgt0IXV6m2Sb8Vv3Z0VDmhJep5GmqiTPYvmY7lMc9
 GMZKTypqgi0bG/JWrP9WdzfkJfkoAKeu7fZm8ADF698OE/mDUKInbAwRlarEHeR0QxyVpJgdv
 g3fupoEJ+QfE2Uefm78rg9uwYjUjvpe0vczvar32i/cFIWH1I1UAZS/g/9czaxMAPMNATQ7Nx
 PDA4p1fA1MK6Z+X7+eNIkul/e5DWRnN4wmBcnKPkm1d2a8ctZO4l3vhB9o0OaxqMVVmdTasej
 an3L6mbPdpTLSLYbTjy16WbMB7rZjf6n02KX2pSFsCKPnY70Ffkn8OyBpBvGtVeuWFgAf/+Hk
 KYLrkEC4rpodJHL/cxfiOruZWu8LjtJD0HdtKPvUV8Rd8oAxkMpPeItWRjO6rwAbjoKdtkCb+
 SS/ks67gGWUE1w=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1401386132-1634896871=:62
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Bagas,

On Fri, 22 Oct 2021, Bagas Sanjaya wrote:

> On 21/10/21 18.56, Johannes Schindelin wrote:
> >   5.  The challenge is not necessarily the technical challenges, but t=
he UX
> >   for
> >       server tools that live =E2=80=9Cabove=E2=80=9D the git executabl=
e.
> >
> >       1. What kind of output is needed? Machine-readable error message=
s?
> >
> >       2. What Git objects must be created: a tree? A commit?
> >
> >       3. How to handle, report, and store conflicts? Index is not typi=
cally
> >          available on the server.
>
> 1) I prefer human-readable (i.e. l10n-able) output, because the output
> messages for server-side merge/rebase are user-facing.

For server-side usage, a human-readable output _by Git_ would not make
sense. It would be the responsibility of the server-side caller (which is
usually a web application) to present the result, potentially translated,
definitely prettified.

So while I agree with you that the result should be made pretty on the
server side, I disagree that this is Git's job. Instead, Git should
produce something eminently machine-parseable in this context.

> 2) Same as when doing merge/rebase on local machine (merge commit if non=
-ff).

Local usage is _totally_ different.

> 3) I think because on the server-side we have bare repo (instead of norm=
al
> repo), we need to create temporary index just for merge/rebase.

Merge ORT does not need a temporary index. That's the reason it is so much
faster than the regular merge-recursive.

> For conflicts, the users need to resolve them locally, then notify the
> server that they have been resolved, and continue merging process.

It is already possible e.g. on GitHub to resolve merge conflicts in the
web UI. That is very convenient, and I think we all agreed at the Summit
that this is a scenario Git should support as well as it can. We did not
come to any concrete conclusion how that should look like (read: what
output format Git could use to support server-side consumption better),
though, and I think it basically comes down to experimenting with a couple
approaches.

Ciao,
Dscho

--8323328-1401386132-1634896871=:62--
