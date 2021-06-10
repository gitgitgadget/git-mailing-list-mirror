Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECDD8C48BD1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C883F613F1
	for <git@archiver.kernel.org>; Thu, 10 Jun 2021 08:20:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229993AbhFJIWe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Jun 2021 04:22:34 -0400
Received: from mout.gmx.net ([212.227.15.15]:54087 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229770AbhFJIW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Jun 2021 04:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1623313218;
        bh=lg5kJArMjj6alw3w/3x44nMR2HVau864tZJdRejceyY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=JacKq0X5RRjlqpyqiJl6b0nsl+M9N2tU+M9CEr7HIUHsU7Ez/awiTIiFSp175lUsA
         WG27bVPU65vAXUh+pFm4WFZhuRI6A8PxWwGVDIIU6IWJBUf9HYVCQHsGWhzRjVtPjx
         JuPnmper/Gfe/B7JrOUs1VyJjvMfkrXmPFKmrBzQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.24.14.142] ([89.1.213.18]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MryT9-1lW04l22mT-00nvk3; Thu, 10
 Jun 2021 10:20:18 +0200
Date:   Thu, 10 Jun 2021 10:20:16 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason?= 
        <avarab@gmail.com>
cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com,
        sandals@crustytoothpaste.net, stolee@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 2/4] *: use singular they in comments
In-Reply-To: <87bl8h4n01.fsf@evledraar.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2106101018510.57@tvgsbejvaqbjf.bet>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com> <b36e3f99716bf3976fc886df684c300e17566c79.1623085069.git.gitgitgadget@gmail.com> <87bl8h4n01.fsf@evledraar.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2009251057-1623313218=:57"
X-Provags-ID: V03:K1:WoiCs0Zg5mHT1f6R9ter2M8Ke3RvMtJeVOlcZdaZLksuUTKadDv
 NGLLiS87yxOGdElEbGcVQpVRil87pmsaS/1GC9VROzVVfjrxdbSe8FVIDMFSlcvTZxyOdP7
 TXFpPa2+gZ6jRvGaL7vUfnOqS6CrdmXNKtwE41B5WDylRHTqh0HZV3MrbzmnGTem5B7WBJd
 qVo+HoYBTP1bQquFMdEsw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+QOUhmcPE+Y=:4YzztbrS/2V2Ub8HKojFgx
 dF0mfoIXXHWWghESG+N3MxnL+P83Xc8/NuzN0X9xhJFG1CKC5+Adq1uRmOdiiFkz+0CfRiODf
 hBl8pxbOH/fiTqaaPZVge3UI7+HBv3d1Ll37iLU+vOsht3mSiJUQru9+JwAvTKG960pYCaAIp
 ikK7XM8aSyK9h8ofkdjdIHqNXYwh7X52A01KhCROfqGlWa68xHVUR0tHpK4ray4ZxeF0Mwr6a
 RAD649gYXKYFuaWNgb5z7l0QQDbNJPtwvse02ZwZfwWrR0E/PJR0+YBafziRdl8WR1jAa1pjZ
 lxfuj7ICQjp+ezd2S4J87HxXt7cJccaisPuRdomQo76qNDY2YVNBwjHkr9Qfk0kwPdZOKHMK8
 zuD18LARs20rcCcmQ0a4xSYOwJ/BjvlNuil+y8LRkyrV04vdfkxMj78lr5Fqkinh3zrHmBTS3
 vevtbsZyxg1t+BQ9ic46jMcbxvbXVkcSKwXyQ14eQf9zZUEYItCvn71RZVM2bpD3cNTFuYy12
 DD3EGUWpe6qMKUFRWtNBU0zkyCOfuj7r+bLcd5aNxwrQVaa8wCxyikWpcIkZV5mTmg+CMz3lw
 jurbdD3x7794FlZLn+bchL/T+mnBraTdJMxy4nNs70g9RmGZXPrGJTat8KkgzArvVrXOzfGMP
 qj4XQV+oCQD2dgDrD/EyLtBZHaWsDbncxwdzKzpY+C2zGjJPaoofW3MEgHvluHCaoPHGV2gqx
 mAndPJp/K69XC1lSLtSVHN1COQpJgovt4Fcr9F4s1QHMAtA5nPxW7EvcQ+tVdLOUAC2u94ITz
 7Cvg35Ip83KqL4J/NsDkAlbIpfTboVDRgq/KiHG5/K36SXAnjjqyxfpfJJW794VhDiTST5CAd
 OzygcVCRl7n/a3eLZaXX46eGRvJvdu22mucElB7uLHCi+3z0DMfGccJ8jkNOx1yzldtoL9wpL
 D0fmTbnOfL8WlfVMSnZltbweLd0UbkVC7N8kGPVjLYJ9ThVWPdhYqF87QfqdMFv9Nna17CGL+
 adVSWzsaHXfBULo2e0OLfZYAhZu39uRlwWVb1Ig4S6wIbrXKnAHv2qz6pn12b/Mr9xe5POWXS
 hH90f/uavz4oASutI1TCfmx4uEHu+J4FJQrYDC+YVou1awBJesdGMDI0Q==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2009251057-1623313218=:57
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, 7 Jun 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Mon, Jun 07 2021, Derrick Stolee via GitGitGadget wrote:
>
> > From: Derrick Stolee <dstolee@microsoft.com>
> >
> > Several comments in our code refer to an anonymous user with "he/him" =
or
> > "she/her" pronouns, and the choice between the two is arbitrary.
> >
> > Replace these uses with "they/them" which universally includes all
> > potential readers.
> >
> > Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
> > ---
> >  commit.c                                 | 2 +-
> >  config.h                                 | 2 +-
> >  contrib/hooks/multimail/git_multimail.py | 4 ++--
>
> We should not change upstream projects we pull in like that, see
> README.Git in that directory +
> https://github.com/git-multimail/git-multimail.

It is probably a good idea to make that upstream project not only the
authoritative source, but the only source. In other words, I think we
should replace the files in `contrib/hooks/multimail/` by a `README` that
points to the indicated URL.

Ciao,
Dscho

--8323328-2009251057-1623313218=:57--
