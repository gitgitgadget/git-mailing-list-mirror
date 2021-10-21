Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32A14C433F5
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:03:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1416460F9F
	for <git@archiver.kernel.org>; Thu, 21 Oct 2021 12:03:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhJUMF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Oct 2021 08:05:28 -0400
Received: from mout.gmx.net ([212.227.15.19]:55101 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230379AbhJUMF1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Oct 2021 08:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1634817759;
        bh=sh/QZ1Ovuih9S1lQjQclP2nJtMy9S54I+/zSayigfaQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=LMF+BBYjLS4B45ldiO8wngmq693tM23hylPHKod4S1fqzcGE4dAVq+KC3HY5tL+JN
         lq2HtwV5/WAgyBeXmYlSf/rFIvnZFKsmw+GTdFlu17AH9L4wsJ3Hljq3uPwED/4Q77
         JLbUE/4N8CTusYArIrgAB1kcUauK4GHLgzId6Hus=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.18.3.1] ([89.1.213.179]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MWih0-1mAt0w3nz6-00X2xd; Thu, 21
 Oct 2021 14:02:38 +0200
Date:   Thu, 21 Oct 2021 14:02:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/4] gitfaq: give advice on using eol attribute in
 gitattributes
In-Reply-To: <YXCXU8uns1Xld5lH@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2110211359410.56@tvgsbejvaqbjf.bet>
References: <20211020010624.675562-1-sandals@crustytoothpaste.net> <20211020010624.675562-4-sandals@crustytoothpaste.net> <CAPig+cTn4fZtssPrn+z582E++Kdc2+z+=iNtp2kodR=QJVeycg@mail.gmail.com> <YW9wgbN/b8NkVp4z@camp.crustytoothpaste.net>
 <nycvar.QRO.7.76.6.2110201400020.56@tvgsbejvaqbjf.bet> <YXCXU8uns1Xld5lH@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:bLJN8ZnFMQdj1ghMP2pu3fb9N5ORVOPZJlP85JOYhgV0d4yi4So
 LUvhM63kT7hsH0kUaEeclvD/ccDPvD6Z89lAQHdBoPAihadDiPMo0opTqRsO44lR0QCH+80
 02Y/BqVOO+6wgj4noM6Pj6gtTtCeBFD8gAECa3bj+O0Q09VlURkGg7pLioctxhuFCYQjhPA
 PYGVzqluOSj7hRMNAVuaA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h47hfmwyX5s=:tWglrUMEjbqx1PDzEFgMrl
 CuQ0FjSvlIWroOxN0cSzFhV8/IUs1/shq54MgT/E6mADflUNQdgngZxRt0ua+KLZwpPtcXDBG
 19GRm2jCGLjZYm9DwLXHz4UaeQsm9VBu4uL8nqKCFfU+Fdhu7/IgeQGeb5vdlG6F5DgiK/OKS
 fWnCyvWCdpZpj1PksZyaM7Exgr3zvThQFcmFK2QOCVatTOA8+GpFPBOsbuKdu9gCScb46rPdA
 RHrxsCliTYZJa+stwRPpXESykmMlDIZHL8c5SqTB3/230sC+e9OCF0GE8JPHZH3JjWn5986n0
 CJPrrCPEVc4tx6EfxEsrKpelGrM+MWAote5ldpqBuCeWLou5MUwyGY9t3Vwi0zNlRPRCnlDqk
 jEpK3rmKZWMhOOLhV2+FJb3blFXIsl52ELySeo/Eb4653ElXnjfL0gETGFf8ypOtfAzUtOW36
 4lcsAbnZawLKRBQzPy06wO+NsT/5AweDJzZiftNFtyxCsNTgrUttifUCVMrftUW0qZUGy+GzV
 adypDMLQ6tfo0nY5DiGiOF3Khq73qn67e1GrnkgY9PCh3R+nHwfr29IyMCHVkSqKiUil2O8Yz
 YyVUdOSpQ3U15NfZ+jL4Q6ppZEIKJsYCsYVpLO2Ym51fF+XRsUp3DT+h3xq0yq3dAiVWDTd9k
 GUp7NVrJ/mpkX7cZw2Ab9ue8/gkmtkXlG3vFyuTgo+53efDhvUOneNJwqOZQhsoQmbzgXKWCW
 kFHbUSdDcz9eS3Ii8geAHK1EUbi9ZCfGRjbMTGG5aeV+iqStdmmenW2RtX4Avf2K25gHXaTBw
 13kKW+YxQWkJuxwpaqHhI8R38vfPODkd9Emv6HRSaQSPNmJzFzWggeqTh2j2/C/AGJxrBcniZ
 SdBvoJ2D9C3Zsbi5MpEiETdp6UynINLGhXp9/fWat+Pt8JX8ldrIpT6FDirL67GDUMKmUObfT
 XMiI4kbnkXDIR8b+h9/5d0cUqacLKz/AdklfwC0W4qauj9Z3Ueqe6IYelCvqpJEcXGDFKazOX
 xXLAtIofQlTKnjEkv2PzlBuxEeEmdg5O9bIR1H8U0cm1LmjVNKURQ95EKwTrh82JttS4VE6+V
 5Whj485n3vW+/I=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 20 Oct 2021, brian m. carlson wrote:

> On 2021-10-20 at 12:02:02, Johannes Schindelin wrote:
> > Hi brian,
> >
> > On Wed, 20 Oct 2021, brian m. carlson wrote:
> >
> > > On 2021-10-20 at 01:21:40, Eric Sunshine wrote:
> > > > On Tue, Oct 19, 2021 at 9:06 PM brian m. carlson
> > > > <sandals@crustytoothpaste.net> wrote:
> > > >
> > > > > diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> > > > > @@ -464,14 +465,25 @@ references, URLs, and hashes stored in the=
 repository.
> > > > > +With text files, Git will generally the repository contains LF =
endings in the
> > > > > +repository, and will honor `core.autocrlf` and `core.eol` to de=
cide what options
> > > > > +to use when checking files out.  You can also override this by =
specifying a
> > > > > +particular line ending such as `eol=3Dlf` or `eol=3Dcrlf` if th=
ose files must always
> > > > > +have that ending (e.g., for functionality reasons).
> > > >
> > > > The first sentence in the paragraph is unparseable.
> > >
> > > Yes, I think perhaps I omitted the word "ensure".
> > >
> > > And I should reflect that they should have that ending in the workin=
g
> > > tree, which I neglected to mention.
> >
> > Please note that Git for Windows defaults to `core.autoCRLF=3Dtrue`,
> > therefore this sentence is not completely correct. Maybe something as
> > short as "(except in Git for Windows, which defaults to CRLF endings)"
> > would suffice?
>
> What I meant by that sentence was that I should add, "in the working
> tree" to the sentence ending "if those files must always have that
> ending".  I believe that is still the case for Git for Windows, since
> otherwise our shell files in the repository would be broken there, and
> I'm fairly confident they are not.

I swear I read this sentence multiple times yesterday, and still managed
to miss that you were talking about LF endings _in the repository_.

FWIW I think that `core.autoCRLF` defaults to `off` everywhere but on
Windows, so _technically_ Git would not ensure LF endings e.g. on Linux.
In practice, it is highly unlikely that a Linux user would generate text
files with CR/LF endings, so it would not matter in practice.

I feel a bit bad for arguing subtleties that realistically won't matter,
so please feel free to leave the sentence as you have intended it.

Ciao,
Dscho
