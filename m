Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97019C433FE
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A86610CB
	for <git@archiver.kernel.org>; Wed, 20 Oct 2021 11:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhJTLpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Oct 2021 07:45:18 -0400
Received: from mout.gmx.net ([212.227.17.22]:50035 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230217AbhJTLpP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Oct 2021 07:45:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634730172;
        bh=VxYYxZMqyvjr1389o44DD3NJU3zVMsIM7Z8WaxxpSLo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hZyL8xHy6SiINzx51zmegPKYB40o0HKuHbetHRKYZ8E40l5Jq6IPk1h8Pbye46J5H
         QKo8t61/OUQ/uAcWzvKmkLpNXZQ/TMYyq1bfQK3OV16fsRXxrH3Bviv1JzjIHpAEpy
         DmII2i+1k/CH93bTA4OEAGqG/v255sE3STGpZr8I=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.7.163] ([89.1.213.179]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9kC-1mTKDP3Uaa-00GYZZ; Wed, 20
 Oct 2021 13:42:51 +0200
Date:   Wed, 20 Oct 2021 13:42:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeff King <peff@peff.net>
cc:     =?UTF-8?Q?BARDOT_J=C3=A9r=C3=B4me?= <bardot.jerome@gmail.com>,
        git@vger.kernel.org
Subject: Re: Questions, improvements
In-Reply-To: <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
Message-ID: <nycvar.QRO.7.76.6.2110201340370.56@tvgsbejvaqbjf.bet>
References: <9ad3d241-5441-9fbd-76a4-7c47c6a1b70e@gmail.com> <YW85Gs8aU9rrBDOv@coredump.intra.peff.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-700136813-1634730173=:56"
X-Provags-ID: V03:K1:Qt8ORKsEv3kjt3/iyvSmW73tRbNbV3J6clTeFdwO+tMEWkV542r
 X31A0lOCVe96CgsRmpzQcRLgCtRnsNHW/icsBFl2rcUr74x85wpIW1p8gu+BWk4auUDKNHa
 89HrvBADwfMgVzwvrwZPCTZw8tmM4n2BFR1YCSYfGNzqtsaGtJyrIDi0SCL2aSf4xXCmHIm
 C3VEQZ0VrA8vpFvuag5wg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PMQpoQlcGXc=:++Mnnv0QIFw3lm1+z89a9j
 tjx7ikAWKzQrSUaaTkHB8jlPmSV3qyMXZ9lDxkv2tNvcXAITidyw92oGw+O//EwCZpvTPa0lS
 neMN/GFdch4glxmcryccEDIoFzb2W7oZNODYoAF924mWNf4zCHUiBkdhVrvAiUtjGNtO2i4rJ
 TPWzMlO5FJ93YW1mefR0j4K77YsST+SVduAeaHHe2xfZLgW4l8WOr4p2Z0xpsMc91N6dBhbZx
 PxUmzEkBFK6cyS+skdAzBMyq3CdExj5aEfu8d6xv+SMXnZgL4T7Q5W6ZD6HrDf1uOCY6lE+1C
 HrjF3bGIXicsq5amw3/GZaQrTB/rGbF7oKvG28f4e4ACPMhWsEogUTy64I2rKc8G+j3IdHTU+
 FRG6i+fHutuE9xdXiaXJDhurK0LTDt6TIlgpMiU6O9lCV173brUoz/CWTBwZBiUaZ7w5hLM4Y
 7I7dBUuko9eyJaku1E7DKmFnS7NjhbfLMmtymz5ZCf1OLYxlAmWu4s8OousxqeTV/SKNJzHks
 9+uuLCXJr01AOcpEirAzlygZnrb3vhe4TrsuEXf+YylcnDT/sk8fTE88lz06TBf9jODZp6erW
 IB4MywcjMigW/9VNGO6a4cVtRIVedhKBtvhnd4Y5JJg0iRvFShF24qna5cyEasJzsN870E04m
 8OX1gBaoh3es7uUAokPA5EGVdqu0eRlc6KzkQ5G4OFRh1BRA8sRPx90lSQdiDvIsdYzFWkxCK
 4nFiNLKojpvW1ZGbtNLwS2AbSzSyS5RIUpc0MZrO0o8KY1xG0hyTWuuwbaCsWZsZVVQvRCEg4
 IFt4zfeMf0izCV6qlmjyOlaVjIXWYc4l7YRiTxbEgpoyESaIx6s9D87JEP9jhhH48yRS8m48J
 YG2XcHwCi/HlstrL17mRvSv4dcsmF4vf8qhh7sq3cjuortANgDwTXFCq3X3n4VuaKVFDYMH4l
 Ii1gPoLksHxHDxgkAsGWI0BUu/4ofWV4eHRiY712NiNvXAP+fRqqZkrN4i5Gwy8ZUY/NW1Q/u
 Qz7WCoaG9Tfb+/BJsE4TsuJoCzXf31yhgsGY1lVNnmqbitLYm2ZVGFQaL7YolIQOGQ4s212I2
 TNt7T12AqFuN+k=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-700136813-1634730173=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, 19 Oct 2021, Jeff King wrote:

> On Tue, Oct 19, 2021 at 07:38:16PM +0200, BARDOT J=C3=A9r=C3=B4me wrote:
>
> > 2)
> >
> > I need a domain name / uri / ip base way to choose auth information.
> > i find some examples in past but not as smart as what i want. (Maybe i
> > miss something)
> >
> > 3)
> >
> > For auth client side can we use tools like Pass and or identity manage=
r.
>
> I'm not entirely sure I understand your questions here, but I think
> you're looking for credential helpers? Try "git help credentials" for an
> overview.
>
> There are helpers which interact with common OS secure storage systems
> (like osxkeychain, libsecret, etc). But you can also write your own
> little scripts, and restrict them based on URLs.
>
> So for instance I use this config to pull a GitHub PAT out of the "pass"
> tool:
>
>   [credential "https://github.com"]
>   username =3D peff
>   helper =3D "!f() { test $1 =3D get && echo password=3D`pass github/tok=
en`; }; f"

A quite complete, cross-platform credential helper (included in Git for
Windows and enabled by default, but it also works on macOS and on Linux)
is Git Credential Manager:
https://github.com/microsoft/Git-Credential-Manager-Core/

It comes with backends for some major Git hosters and is pretty
hassle-free, once configured.

Ciao,
Johannes

--8323328-700136813-1634730173=:56--
