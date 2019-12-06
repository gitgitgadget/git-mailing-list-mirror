Return-Path: <SRS0=yMBz=Z4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE2C0C43603
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:23:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A321F21835
	for <git@archiver.kernel.org>; Fri,  6 Dec 2019 15:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="FleG15zy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbfLFPXX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 10:23:23 -0500
Received: from mout.gmx.net ([212.227.15.18]:35371 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726234AbfLFPXX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 10:23:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1575645798;
        bh=ebn+lnkZH62MT5KVZZ5dLz7tzcBGDhiBGWJJvpRbYDY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FleG15zyPLOZjDOy9a9AGuT6+MQnchOg/dDOdDpxBgnuQV5YYG3DQ6k3hdhQm8aos
         yc0JWDEYRYORazNDDWPAVmCl9hhHJE0a0rPc2ypIiZeSRy5BmfQ+0IBq9vEZfbwz4N
         QJ6JbWi6jWKULiAAaPlcv8OdB3rnVGbTsIBWTO/Q=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.120]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MvbFs-1hn4ZE17e2-00sb43; Fri, 06
 Dec 2019 16:23:18 +0100
Date:   Fri, 6 Dec 2019 16:23:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>
cc:     git@vger.kernel.org
Subject: es/pathspec-f-f-grep, was Re: am/pathspec-f-f-checkout
In-Reply-To: <nycvar.QRO.7.76.6.1912061618440.31080@tvgsbejvaqbjf.bet>
Message-ID: <nycvar.QRO.7.76.6.1912061622220.31080@tvgsbejvaqbjf.bet>
References: <xmqqzhg6xuvc.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1912061618440.31080@tvgsbejvaqbjf.bet>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-898244390-1575645799=:31080"
X-Provags-ID: V03:K1:d/Fi6kLGaA2qcBBqYwJSMLmaGQ17mhn6bLQ1RpXwYt/YDPwstmf
 hRpnRr4frFHFo0fdYOp47w54ydEFk4YJr+3yheMQ7CMvk7u2Xg3UuU1uSYT1lgP6Chbfvv8
 FG+p9h2ba7WRNOBmhsBMCIlyZGRbkRmy0x6YOR3OO8mGmc5UmFQ8lou1UUfPOysvf8kP+V2
 5AGwvagOyc7V51wP6Ydog==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QGDBiou3n8U=:5DrMOm5U2HRaUqD99Nz5oK
 AMIcsrbf32IhLZQxfTOY8N/AIYZ88OwkdQ3lmsWRsbYUkTboFDeygSIKEuZdN9yv+QWNpYjm0
 +SqJYsmFfloshFve12RGapP6Gytf33gy23zLJYh9Cdzhe32nSzzVQUCga9VUOB4llNRR08IjN
 CSslBP3L3a2gu9LLIMf6tNThWrQj1KlixwE7E8ip9hhv3ep6TFSApF4WUs8WzCfCKDCS4UP0T
 KCkvSa9xTDTCQM3HTA+e7Ksu5NeLwTDSrBdRkBoSoneXhUifYblYOM30njFQVeO4VuAnQ62pK
 L49Lw9qcay1B7WjnglayUAJwZ6BvCQlxAbM63M2W99ffJO8MWVQa+CQVw2C9ZR7efHWH18XCI
 +H5Jc4pqHdPMdkH2nGSyZsElUbAzxsIdoYoz90r9WXwPIhqZXO0KzEPPuDn+x/xUzjnIZn7yF
 zLG8J5MnCIfBIs6nIu57+6t8C/4937HCYUe4Si++JEXb6l61TP5Q9So4qdnBHT/6vVh0N8Tg5
 KU3Z8fS9GpGr7+h7Xwsh6GBvP5oCpVcpdhl2zz6x4qz3QGyE73MCzlLdO9bwPJd4aeRIQwCTy
 NJAKwwMBQK8mLUvxml+MOWSHXSeXlTYP0Kpub7YZPKn/oqNi59hURpZp61qQz6Mxw/mBhX+AA
 LM9qy/l3P4I2P3gtjNYjojPTavDwq6/jXRHwfWIi0+JxbKCEe+s7Ha5FGy8loqzMM+plYirCe
 1Hw22Lln0nyv4yhWypE1a7n/UcTZ6dwwcx8OfJPAxHGc3egM5o3syLRbGsp5dKNaXDNyhWwv4
 0ziU6mNvv4STFZ86KWQEnM8BRGkKClI4351Mw1XPGDrwAnSgJQevTHmwzIlcgM+J1KXyDw6Pf
 IFRlTJXoSHZ4tgT0lWP+7C/3Z/Fhkml+7cel0qklT91BiLKO/d9NWmgBaNMTa0YFyubxDeEsA
 1egpXNJtRDGQwfsh3JKy4D5XFI8eFFYUI/4uCFfxRmIXfL83fg2q9lrQagm1bdsxumV4Tew4/
 1T6V6r1k3esUkHjoTSHp1KlnKHSGOkxZSC8HrWL7m+tCA5TSCYFcr1Q40m2o00PX/NYAer8I1
 CFnqy2ld6vHQzh9c33dvxfTxMPyonvEGLwnVH/LSE4m+gx1b2S2sgxVRu6ftRjVhboZkK9v1m
 kY4uzFSo0+PGWyM2vr1dnpuFZ32bv+/YKIfo+5FpS3sr8M9Dpl6IGmv+VZ+EWc2xU58laJG8N
 0sXbqUM4ROqTePoWoUGDCA49TdK4Kmz8ed7oP6GepX825w38PZaRwIyqtdzQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-898244390-1575645799=:31080
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Oops, I was talking about `es/pathspec-f-f-grep`, not about
`am/pathspec-f-f-checkout`, sorry for the mixup.


On Fri, 6 Dec 2019, Johannes Schindelin wrote:

> Hi Junio & Emily,
>
> On Thu, 5 Dec 2019, Junio C Hamano wrote:
>
> > * am/pathspec-f-f-checkout (2019-12-04) 7 commits
> >  - checkout, restore: support the --pathspec-from-file option
> >  - doc: restore: synchronize <pathspec> description
> >  - doc: checkout: synchronize <pathspec> description
> >  - doc: checkout: fix broken text reference
> >  - doc: checkout: remove duplicate synopsis
> >  - add: support the --pathspec-from-file option
> >  - cmd_add: prepare for next patch
> >  (this branch uses am/pathspec-from-file; is tangled with es/pathspec-=
f-f-grep.)
> >
> >  A few more commands learned the "--pathspec-from-file" command line
> >  option.
> >
> >  Will merge to 'next'.
>
> G=C3=A1bor noticed that this breaks Travis, and I provided a patch that
> initializes those new variables. Please squash that in before merging to
> `next`.
>
> Thanks,
> Dscho

--8323328-898244390-1575645799=:31080--
