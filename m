Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7722C433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1FA76101C
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 12:22:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhKJMZG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 07:25:06 -0500
Received: from mout.gmx.net ([212.227.17.20]:42227 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231131AbhKJMZG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 07:25:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1636546934;
        bh=o5SGWSZPiqYAX//BbCkH/6JM2FkzWJCSFF1g1UddXA0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cvQkfc25fJm9diyIWU2dPi0qHtdYY1r7ry/Sn45vA7TfxpUJw+Q47lhfeTbbwpwvJ
         DamSku8krnqJpOcBv8HrsGpVgrecR76A1+jVyyDfZO1Sk7rELvR5Meje0S+xKnZN/M
         5+PjoKZ5OjGwEZkpMpVwgeZRQhaBMJjh2jcvhCU4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.27.166.205] ([89.1.212.10]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MFKKX-1mvRiZ1Tqr-00FkGf; Wed, 10
 Nov 2021 13:22:14 +0100
Date:   Wed, 10 Nov 2021 13:22:12 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Samuel Yvon <samuelyvon9@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org
Subject: Re: Description of github.com/git/git, was Re: [PATCH] builtin-commit:
 re-read file index before launching editor
In-Reply-To: <20211109192707.19916-1-samuelyvon9@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2111101321300.21127@tvgsbejvaqbjf.bet>
References: <xmqq5yt12lta.fsf@gitster.g> <20211109192707.19916-1-samuelyvon9@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:pPSP+BubM+shX9XsELRMuqU/+Hq4Fpkl0BJp8r5LbmjuyQdR5ZJ
 YVRCLPOVTF8ABnmyKvwVD+IJnQkUtg7lzbvfYMAHDDs4bA5/kf5L4dpnMmbv928bb4Zb8XG
 6Nx7eAEHhL6KDN2Of27LGzMmBQvxNucBiN/T27MWBDUod12zXPcIFlwvPmAWHFyG6E7Tnnm
 guLeaqkOawNmm4B5G3yzA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XvjLCpLXdqw=:ECOUUg7zZwNSclbrGimF7w
 8xbhg42+zbOlGtIftaTuM36xMf+OCZO+rlIEE9gR9rKGlQYEHTXMSB9iYd9EJzLtU6sCpNYCU
 GVxeD6dyt9X+vfL6tz6nJyJuk+BjjJqhczsCZJPt93QjpCEfa/Up+Op0o1tSA5ttflUMXiu3v
 kmf7vh1yjpKq3fK2/abwZ4PqSb4E+6lGRjTEN36hu8eFi2vZ4+DmySovIjoM3Wtd/51gJqWHh
 4IsNQmSK5umQhGRshiXi4NJz29ZNm89BfZk578FZXtrs7EFgywMHeG2LFf5GgTgqlWILXo00r
 vhBuOumNhbyhICeQsBdjQdzEjae4QVwEdz9EIQDcePhmZTDX1lOZb5nqT+1u0Th0CP3ZN4s9f
 +84CZsH9GIQZqgBOz0gzpSxUgt6d15rMs3y6fDdgU9BIvXGFbvJFzyhmzBni5dmSoCnrq+R1c
 tlcmGDJXmB6Cedj8enCZuhIbxnrR2ROkYTYF1U1TCgz9orhFNZH7SPxYvIFetPZb+/Ld1HYEm
 ZEltQAKxDaKldMsZinSw1GoL+bbb77/5GY+1ay2r4sIbfX3OZD2x9Bn/vOGQxMsgckQ5rfoVT
 nKPHlFevldEN3QtdswbyJSGRWQ938uIBiHe+yhfF0MT1cUspHubR6CZL9wzux3/SM8OeIZPes
 33l1U/vcZL92QxEjRfr/ZH7irQtwLqKa4zsWEOD5sPLGi0wEvRABdjufcoJlGJxaZqWncSef7
 r7K4AVG8MH7lAZvsOjViW/fXUghEl+sc1SRaWsbJ2ZHN1dwxy5KCFh0gXatXHHIHlYkUHd0+Z
 tgEI9EFTj6QrlE5GuaVQN+oohd6MR7ZDx2Sl5VR7ny9/rhty2QoseHw21j3Hu6dsrf4WmxuoI
 TuGI+EofLkOOwV1Zf5RoAnXSxU1NMT4GlwZuG9oQKXN7FKYHWd5j/6xBWxvu7rftCF8tbqcM7
 +XdEHCqlSe1CpzMySCbr6mla3b7KagTjxBnjq+H+rfTgV2QkxzEMRm0nR+C0H208iLVHNYXGV
 oWN2vuiwi+5OVcfVH7fIOxS/RjHDY6MFRMpdf5L6o5rSI0kGsIjrSCDH5Sk1/39mQV5WyI5MW
 qj26c6ltQOsXzs=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Tue, 9 Nov 2021, Samuel Yvon wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >     Git Source Code Mirror - This is a publish-only repository but
> >     pull requests can be turned into patches to the mailing list via
> >     GitGitGadget. Please follow Documentation/SubmittingPatches
> >     procedure for any of your improvements.
>
> I think this is descriptive enough so that newcomers can find their way.

Excellent. Junio had made the adjustment, and I merely added a link to
GitGitGadget's high-level description.

Thank you, all,
Dscho
