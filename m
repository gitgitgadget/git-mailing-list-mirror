Return-Path: <SRS0=soZh=7Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF8A2C433DF
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:33:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C79A920835
	for <git@archiver.kernel.org>; Fri, 12 Jun 2020 14:33:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="coYegU6B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726286AbgFLOdP (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Jun 2020 10:33:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:57641 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLOdP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Jun 2020 10:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591972382;
        bh=2miohRxhN5zUCbAIwTdsTPkV6s4L8Wa8rpYVXP4jtX0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=coYegU6ByqS5xyF2g66XJl4OZzlXsbsBln9j/jhEy8viSPh59My6nDxTBJogVsHyU
         uDu5d7PS+Cvul50u8wimXUlhgqBGbM1tIgiPsjKDnWXGLy2CrTHEXQVaOJOqrHlpd5
         iJYFfFLO3nZNuzoGuSPg8iaKt8iHNwaBKo0gc1TU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.173.52] ([89.1.214.156]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42nY-1jjkju2MJU-0005ai; Fri, 12
 Jun 2020 16:33:02 +0200
Date:   Fri, 12 Jun 2020 16:33:05 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Don Goodman-Wilson <don@goodman-wilson.com>
cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Simon Pieters <simon@bocoup.com>, git@vger.kernel.org
Subject: Re: Virtual Inclusion Summit
In-Reply-To: <CAGA3LAdz21nZFeztkHp5XUQ4h-kWnqTzb8pDXjne7PqeMFhLRQ@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2006121525140.56@tvgsbejvaqbjf.bet>
References: <20200610222719.GE148632@google.com> <xmqqwo4eedwc.fsf@gitster.c.googlers.com> <20200611011040.GB21728@syl.local> <xmqq7dwecpsp.fsf@gitster.c.googlers.com> <20200611023503.GA24130@syl.local>
 <CAGA3LAdz21nZFeztkHp5XUQ4h-kWnqTzb8pDXjne7PqeMFhLRQ@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-302581770-1591972387=:56"
X-Provags-ID: V03:K1:eoLAo/I8VIMfuiJbjR/wLRNkIHtlsSYvq0SC3JVPxvhPv4Gwrep
 NJOp8fsJeiChOOLh6FhwPEFu/CY+OxS1SHntSxKj+YoHSNDX6K8Sm2G9G1HVg5EPMxObw7a
 DcBSmn8bDSJsf5CL8K0xuyicLsQzYnLiDlAn9HzfuOiQdQMesCT5DtgiLpEuRHCnxkHOd2C
 S0eC/celVh/w4ztN35Awg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YhSGNDTmq+E=:WgcUWjQTj1ezpAmXNAsUra
 fuMsstSSh6xtyxKDFneznSPSd0EFnc3w5TW/wKNK690HSMFSnnxbKmG7ea+ujq4nlZ+m14qkm
 +lR6BBRLKsYz696njxU+e/1OdL1HzeAyTkkaFBoKsXRvGcUCYwoxusOUgxZhJrCGNfZtxR2Ml
 gZWN3rzi0Msm9psRYQo6tx9TLhARyX0EykHktlOYCk7I+Z4sp+uk6HPJuPoZJnw/E4jo3lP4Q
 nJIWxKVUhx/bRqWy1H1HH1AgTmhozEL6cm4fxS500ULuSnssMk7j+nqXz68+5me5ijEmLW0Zo
 jQa6QMN2vXdenem/4AYjVnEUAJpj6SCYPaVJpDEpAWdtrPIuQ26kc+VJqhl8Mv0KQa6PXTGwJ
 1ARD+Vcyn0yNEN8KEePOiZOPKo3TxDoVhimowkzabrIMLKqQKxwAdxwov5Wx3+Asd2OqhlW52
 ie/V59m6vSdXgyC6TH/1hVNSj0XVk0oHHjPsUQ9j+06XHWDTv8YrT18g3AeTtZ5u2YevkRh6C
 9XlmhC6LCW+OXhNBOgyQmvmDUbibNjRcV2I27gD1KNDLsSls7sNbkPgZEXR6UTIgfcc6y0biW
 JemYmBAl0UdZBZobgyMMo+MNICUGkTCn7FYECXMqpUJR2Z9xMtddhts4IiJxagINgkE4tyHsL
 1FShoYZGNwtQQsdkeJ5hEMK+7tQ+vYZsymIK5UgEKxfIALZggUzUVcIoT+cOpjNr434al4+Zn
 27o0a8hSVHwX3HO+WrjCjap6bvOpdKf46WadllUi8JmZf7Xelg1d75sfQ2Nkk+B86Kj0aU6j+
 10aI0MbPzfRoMF0r7ZSBD3mz3Q9SYL6zZNGgpKI110zfmmoy42h4hFqPYuAuWW3OKqrRGReRA
 0fWJEVas2jlQUeVuOzO0lG3lm/o80FFKoNd0zzDiA4wcClEzWKLD4nx9TQYjVYSeR8dA0GniA
 68/zqmRkAgndBSUu2+1+us9rEibPubVSR3uJAUeWRYtuAoGGki25CJig/mtjXKOemiFLf9h6p
 BUgkkUHPghdRSk6kXAJt5hLae6+/bAmTLn/HBqGE/lR/uuQ8dwdcbjF6212kr9lCWZOC3XxOn
 X9i2pyWouILkrLgIeWxJRahuaeHlWMayajQJR3ke92qjy1V737wXFsPPhadpzSv7Dzfqgc5cS
 PV2+etz3i3g1ZzXoGKVVhbXep0XS2+57VoYsgEiEQlJqS75w9nxgeeFiTTiyfShimEvpWewMc
 /8FBRfj44LyddEUf2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-302581770-1591972387=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Don,

On Thu, 11 Jun 2020, Don Goodman-Wilson wrote:

> (First of all, it=E2=80=99s Don, rather than Dan; I think Johannes=E2=80=
=99s
> auto-correct got the best of him at one point in his email :D )

Yep, sorry for that!

> I think this is a wonderful idea.
>
> First, I am myself a white cis-het male; my participation in any such
> summit would be predicated on ensuring that we have a diversity of
> voices present, as I think it is foolish to have a conversation about
> inclusivity and equity with only white voices like mine speaking. I
> hope and expect that we are planning for that.
>
> Given the concerns about being recorded, perhaps my experience running
> Maintainerati events might be helpful. Maintainerati (if you hadn=E2=80=
=99t
> heard of it) is a series of events that gather open source maintainers
> into unconference-style conversations about the challenges they face,
> and finding solutions to those problems. The events are operated under
> Chattham House rules, ensuring the anonymity of participants who wish
> to remain so. Even so, the goal of the events is to not only document
> the conversations that happened, but to create a set of documents that
> allow the conversation to continue long after the event is over, as
> well as providing a blueprint for concrete action. It is not difficult
> to set up the necessary conditions to make this work, although we will
> need dedicated note-takers willing to undergo about 30 minutes of
> training. I would be happy to put in the effort to make this kind of
> thing happen, if this sounds helpful.

Thank you for the offer and describing your experience.

I might be completely wrong, but in this instance, I have the impression
that for the topic of changing the default main branch name, a Chattham
House rules meeting might not even be _all_ that crucial. Let me explain
why:

The primary purpose of this meeting, from my point of view, is to align
and coordinate, to set out goals that we want to agree on. Where "we" is
"the core Git contributors".

And from what I see, I am happy to report that I see a lot of alignment
already. There was no "nah, why bother?" response, which made me very
happy, personally.

Every active contributor seems to agree that this is worth doing, and
since I am doing the bulk work (with a lot of help from your side, thank
you so much!), there is not even the question "but who will do it?".

Ciao,
Dscho

--8323328-302581770-1591972387=:56--
