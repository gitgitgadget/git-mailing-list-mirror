Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EB38C433EF
	for <git@archiver.kernel.org>; Tue,  4 Jan 2022 13:55:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbiADNzQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jan 2022 08:55:16 -0500
Received: from mout.gmx.net ([212.227.15.15]:44683 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229655AbiADNzP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jan 2022 08:55:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641304494;
        bh=ibGkzVD7bSJKSKqrrZ7aKnnw8fQGVIQ5EKjzSfGwwNw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Vb5NhOCxuE1meFaEXM6cHmFMH699ClyiA0IS7i2yCV7cNWD13U0f6gKmPGqTU3bpj
         bIPbThq7vB7dh2Ry/hSBNH8RxwGLmNMqaOfqjm1leoo5VMQURXyUt/9A+Dk8UjAuW3
         Jk+ElxF1oewn9dnzuNjCOjwbucTsJKBRuhJ9PUD8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.29.215.148] ([89.1.212.167]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M89Gj-1n19e12PNj-005HEs; Tue, 04
 Jan 2022 14:54:54 +0100
Date:   Tue, 4 Jan 2022 14:54:52 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 0/3] Additional FAQ entries
In-Reply-To: <20211107225525.431138-1-sandals@crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2201041453540.7076@tvgsbejvaqbjf.bet>
References: <20211107225525.431138-1-sandals@crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/LghyiDcC4I7QP8rA5X8lQzg8qSOASk4UjfERzSdmjiKADmHlQ4
 cZK6E4HbVTD/ZBiUHhPH4EVQsNWMqholULRxItvh/A6oM6XM2xq1/Vu/lUZ/4cSWuD2g03x
 6A4iszFftSm9wrxNKHFik7UU5cN9XEFqzqWXchPUt32KGZ+oaAe/anYieakhIZ+JGGWV3lA
 LyieyZimOKqQFP7PiLfAQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9n4N2Qlbu2g=:Na+fH0CCfualaBUGJetTH9
 1LeTWspZ21r7N3jUd6ESMXtJeQqeWiGwSIZonLqUo2s1iylPt3iMxbURewALAHXzuWg2N1piT
 iQLiukkKJmd50I0gCykRvGu070UOylcezeOCxjOAo+w7L4EuDRM86FRR1ZbaeflpZBdDP72CZ
 sL73tiDTf+hf02bp1bSxr1KmQ3gn/r7f0hmVw9uKyfeUJ70zipvybkC+dc2G8Ojj+I9503JMt
 1/J0HrjZQ0VML+ABjIGPy6tzOwKeJvklWP7lUp1a6I3hSYSDYbh9fCTdlpC7/Mo9oe5VHZJG7
 ctVogxbE9f+X9F3fVSiI7DiGAPzhnAsbikBqwMVDwGIfeHLg47SIlWeyGQpyqwxOMNfHLKUd1
 R1jbkL9lUlHNef3cSm6UepqM7CVWkfb5oTtpAsb4ZKyvlSfK/fPbqnsM+6nszB+qE/giiYTXD
 3NCnJzxFawMZPFOYsoZX7IfG36MmSIjygfEaFaxHYi9K1zDhTIpp2gBNYPRQNZO2OoAEqH0C1
 zmHVR45Emc+MOgRVJY5iiGn5QTHnbNEYuIGr7KOm6icD4WVJpxAQNu9mdV0EJ8yf0yb5CvF/8
 v0STwjccxVX3i55fYus/h40LclRk7ruz85HHHNDjFmmzjIPfpckoOUmV9Gkjo8Q1Ql+mTQKrb
 3O4SifyyWKy0FfY6syyV9tJZh+fikVvLRITtY6GpvgG4PkhYZoxYC59nx+iFwupfkctVP8dxo
 geWiT/aBsgGzU66lz2GPeyjkYdHjcQLuwBSOthnPOHzhkWD33RijfhsDUoTJr8VFqWNEP2GEt
 dKuYXfQWThVl8mMX58ci2ph2vkfUeLUmroAxlj6VZ3yL8fMiZtsNgDhChG0e2OPnW6jChh2C1
 uya5k6gKi5CmmdRolCW3xCXEiqw3XxUJSOYH8yEj2lygNIUn41cv4xLZD5YILSBNuf8GVPIkv
 jz4G2bfLjn9/lG6LOzpOV7xK7H0uyapBIrsiGal3iQXQrEZnY+V48e1wGjYFMyNVMp4JdYWIA
 i26MOqvvt1CzWDQzZED8D0c73CHhLKs43QnE4kSW5jIcZJrTsny50Hw6fnXZgHDSJCqlT0Gw9
 OOkyF3sDg0fMcM=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Sun, 7 Nov 2021, brian m. carlson wrote:

> This series introduces some additional Git FAQ entries on various
> topics.  They are all things I've seen in my professional life or on
> Stack Overflow, so I've written documentation.
>
> I've opted not to include backing up repositories in the syncing patch
> because I think they're separate topics.  We could well end up with an
> additional FAQ entry on that topic, which is left as an exercise for the
> reader.

Makes sense.

You hinted in the thread that you were planning on submitting a v3. I hope
that my feedback regarding `core.gitproxy` is still in time for that.

Thank you,
Dscho
