Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 518751F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 08:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729802AbfJIIHq (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 04:07:46 -0400
Received: from mout.gmx.net ([212.227.17.21]:37959 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729768AbfJIIHq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 04:07:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1570608459;
        bh=MFmBv6WSHvAO6Rt8JGwhk5H5V5fr7jOYFUwjRE2Pcrg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ThBD/Y21CGqYMT+a+xXe8XlVKpvVCEKXiJdNM49hcSMwsy0AtbVfgrvLEUlzv/Eff
         AZ9O1F4tF80ZkkhOKIMgi6znY8t2SfCR7KQGtGYQ8gfYXNNBvb8cUYOLt96Dx6QWMs
         mJKI1AP3jUcNF+EsQgjL8fldRZ+KFtx89uCSW1lA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1i2OW20NEv-016eOV; Wed, 09
 Oct 2019 10:07:39 +0200
Date:   Wed, 9 Oct 2019 10:07:38 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Emily Shaffer <emilyshaffer@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: Raise your hand to Ack jk/code-of-conduct if your Ack fell thru
 cracks
In-Reply-To: <20191009014156.GA143120@google.com>
Message-ID: <nycvar.QRO.7.76.6.1910091007060.46@tvgsbejvaqbjf.bet>
References: <xmqq36g5444k.fsf@gitster-ct.c.googlers.com> <nycvar.QRO.7.76.6.1910082111220.46@tvgsbejvaqbjf.bet> <xmqqd0f6n5a4.fsf_-_@gitster-ct.c.googlers.com> <20191009014156.GA143120@google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:DecJQEuX0EN/wUHlGUg6aM0JbFgJ4Z2YDSUO9OMK6CWja9KyJJo
 7Q+MMtiC1IdkY4Tm7VmXiPsvMzsfF1o3Lk1f86T7T9F7H4m/NqFbeDV24MsWAOdd/gny96I
 ZfOchM0C/UPfd06rNg0D339gAvCCY8NRnUvgzjps07FEAqagzE4vzbOz0jfClh3HPlUgEzx
 z+IhayLb5ZqIByhfeTciA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CSdf4n1ShTE=:Y2+ucGAb0Ixy2I+Y2Q2TMy
 4yQ/JvYwLEXn9m+Fp10vkI8ruRJVh/4CSjw1x2yls/v/pcoUF0cNCRJkgh8YZNscd9ugjhHu4
 7G70Sr17Qh3xPMwkq7Ia6rRsjzYeIp/c4l2qfua7nEHWa36Y3Dm3L8hcaprDzAAYD1iAsASxa
 GqyCbxVeiHXNfMu5/iFBdvyAj45uG68wjyndMGqpaNPGedXSv8CT1Jwa/slC75JyS9X3uJK9u
 EQ96AIZgJIJLzt2J/VPVP5RhV2/VAQb1I6UbhsI9yMfuUtTgDE/gsehX5LJTEpnUOyP43o80j
 Mugf2/0dBLkPqyUmPq6wen8fB34QGhmdNF7Vrg34u4PJIpqWyt6NtZ9m9SdK81dlxbarlL3bR
 OGywZ5KpGQM4atCSnE3Wt4uUhPUjux3R/TxPicOUILERYQVfxNG4zP7oaKX2E6E2gt+8+1HQ/
 GCeQl9+gPMPdCxJEyTWC7R7uuDoAvoc4mfhpqSN6fvwmxTbRzvnzD+bNHrc7Ir1M6VyEHA5sv
 GccV8HICzCWcfOv23mkvotMSSCID+vcG5c2Z6lmmFOPHYvHgu6A39kTaEKzonEpH28XPHvKQd
 wlKu4I5/033J+yYGY5i8mPa9FWcn1hobeX76Lg2bCCCH1zHo1leZQbvUng9DZvHMJYY8w7ppZ
 cDEUIclNRc6PfAhL4Qz5IgeMfVNuIokknotMvD2o2UjOk50CIa8lTfGLpo989HPrlJwZaZd9K
 0AMU17hL3KvRlrzX5zWV7vXLJ/wyv5lqu3WRd2Ly2Fe/hoFGRDDKeAWUG1bHPvXwNxdZ3RSZJ
 SsIQ07Y4f3pdoIi3vDuoHp7J7B7qHB8n8A5o/P0XXp3UXPqL0VXlSfjVCuq8kR+54DOHMqcxz
 ONOPZdq2WCpqzFS8Axz4RfDof1dnZFZHESFWbDVsVWxwnZy9lkw1IWSrvziB7Pg3asNaZzkfh
 GFGi8G8gU+dBQ11IQtRAopHodvUQMt92ookykmKtaYsx7Y6gdOPC+JiuGKCSwmxBizwxO9hTo
 m4UzDApBfcwm7el2xmw7otHW1RjIwvJlV9ELwnXVz9f3q6vxNIVi1uGT++nqPiWKzzxG5uXjj
 B446+AKm/iZhZ+Vt3Q14OoBn7ERIF6zOK+5BY9nd7HiXAKDoRuN9EIpQ/zlMymFyBSI3qb/4p
 FAF2r1sn9/c+nEb+n/hL0SrTF2E3NpNY7umNvvhvBCJpNaRbedOGKlRC4coXv/3+Qy4wm4Z4p
 zjPSuU+po5U2lsgUM9xyoZ53+LkEXKxiCLYZuzbDLNnlCdsN/1sU3L7IreRE=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Emily,

On Tue, 8 Oct 2019, Emily Shaffer wrote:

> On Wed, Oct 09, 2019 at 09:14:59AM +0900, Junio C Hamano wrote:
> > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> >
> > > In other words, the commit message can be augmented by this:
> > >
> > > Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > > Acked-by: Derrick Stolee <stolee@gmail.com>
> > > Acked-by: Garima Singh <garimasigit@gmail.com>
> > > Acked-by: Jonathan Tan <jonathantanmy@google.com>
> > > Acked-by: Thomas Gummerer <t.gummerer@gmail.com>
> > > Acked-by: brian m. carlson <sandals@crustytoothpaste.net>
> > > Acked-by: Elijah Newren <newren@gmail.com>
> > >
> > > Junio, would you mind picking it up, please?
>
> Yes, I'd like to join too - I was missed by the scan.

Sorry about that. I only looked through immediate responses to the
original patch, my bad.

Ciao,
Dscho

>
> Acked-by: Emily Shaffer <emilyshaffer@google.com>
>
> I'm very excited for us to adopt this document.
>
>  - Emily
>
