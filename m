Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB30BC433F5
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8235A60F55
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 18:28:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231312AbhKJSar (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 13:30:47 -0500
Received: from mout02.posteo.de ([185.67.36.66]:39847 "EHLO mout02.posteo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229969AbhKJSaq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 13:30:46 -0500
Received: from submission (posteo.de [89.146.220.130]) 
        by mout02.posteo.de (Postfix) with ESMTPS id 58B76240103
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 19:27:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.de; s=2017;
        t=1636568877; bh=A+Pqg0/i/9zMehX8WvCDvxqyzwMqzQEQZj2Hxnq320Q=;
        h=Date:From:To:Cc:Subject:From;
        b=hj4QB7+VMB+XTVQ6Qt0eFNAMFPm+jd2nfjvJkY0eKT54V89sn2rnAxoqsFMIZhrmL
         GgPhWoXSuOrdB9i20HNrFf6u7tX9842t6CQwbP63i2ycpMkO/cN+9hSe0hGxx74p3m
         MM1CQ4QZ4PPryLkUlVJNsgTTt5IWWSLJzKwOT/ccOGqMyo48lKj6UHZkQrulXE6qEc
         omP5hygof1Oye9TqeWyyUI41S/yfSpB4BmJAgGoPsrOJHdepiqvAyZfrOw8cigh1Uj
         9bwmwO1j8Wt21CLFoBIWB2R2NR+CK5ZZ5WQKxAZ42nhx/9ku6moa3XLH/I+3E1ZOW1
         OMUt5GalS0Yxw==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4HqCyN4j5vz6tmH;
        Wed, 10 Nov 2021 19:27:56 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: quoted-printable
Date:   Wed, 10 Nov 2021 18:27:56 +0000
From:   andre_pohlmann@posteo.de
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org
Subject: Re: bug or a general misunderstanding
In-Reply-To: <nycvar.QRO.7.76.6.2111101545000.21127@tvgsbejvaqbjf.bet>
References: <0bb0056a59cda294d416762d7f8a9c47@posteo.de>
 <nycvar.QRO.7.76.6.2111101545000.21127@tvgsbejvaqbjf.bet>
Message-ID: <3dd24fb6153cf8d67b74c6cea1a4a734@posteo.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

Thanks for your ideas.

I have checked out the respective new branch and switched between the=20
original and the new, multiple times.
Otherwise I would not have noticed the lack of commits.

I have also set up a virtual machine, free of any IDE or GIT. There I=20
only installed Git for Windows and repeated the process via cmd. The=20
result is the same, there are missing commits in the history compared to=20
the original branch.

Best regards
Andr=C3=A9 Pohlmann

Am 10.11.2021 15:46 schrieb Johannes Schindelin:
> Hi Andr=C3=A9,
>=20
> On Wed, 10 Nov 2021, andre_pohlmann@posteo.de wrote:
>=20
>> The following situation: I wanted to create a branch from a commit.=20
>> From there
>> on the work should be continued.
>=20
> I suspect that the command you used was `git branch <name> <commit>`?=20
> That
> _creates_ the branch, but does not switch to it. You need to call `git
> switch <name>` to switch the worktree to it. If you want to do all in=20
> one
> go, use `git switch -c <name> <commit>`.
>=20
> Ciao,
> Johannes
>=20
>>=20
>> The possible bug:
>> The newly created branch is missing commits in the history. Not only=20
>> are they
>> not displayed, the code changes are not present.
>> It doesn't matter if the branch is created by Visual Studio or GIT for
>> Windows.
>> Only in a branch created by GitHub Desktop the commits are present, as=
=20
>> I would
>> expect.
>>=20
>> Is this a bug or do I not understand how GIT works?
>>=20
>> Best regards and thank you for the effort
>> Andr=C3=A9 Pohlmann
>>=20
>>=20
