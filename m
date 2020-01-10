Return-Path: <SRS0=BdMw=27=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE81DC282DD
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 13:56:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91F112072E
	for <git@archiver.kernel.org>; Fri, 10 Jan 2020 13:56:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgAJN4L (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Jan 2020 08:56:11 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:49505 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgAJN4L (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Jan 2020 08:56:11 -0500
Received: from oxbsltgw61.schlund.de ([172.19.249.151]) by
 mrelayeu.kundenserver.de (mreue010 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MXop2-1jAwiK2Mwe-00Y91N; Fri, 10 Jan 2020 14:56:08 +0100
Date:   Fri, 10 Jan 2020 14:56:08 +0100 (CET)
From:   Erik Fastermann <erik@fastermann.de>
Reply-To: Erik Fastermann <erik@fastermann.de>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Message-ID: <1429594513.146357.1578664568182@email.ionos.de>
In-Reply-To: <20200110095707.GA459765@coredump.intra.peff.net>
References: <1032627506.120165.1578644787174@email.ionos.de>
 <20200110095707.GA459765@coredump.intra.peff.net>
Subject: Re: Question about the pack OBJ_OFS_DELTA format
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.1-Rev25
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:+UZS//iI2dWbnJt9gbYtH3lxx0trrVl1C5wAcLgvBxJYlgAwkI1
 dH6UD/Wh2vwFMGo9peRSvcpytYmUHCZjLfazpczUEdgiMv2NusPTwj0UNt5mfxAfZn6v6Z/
 OMwCBwfK0iZUhtqxRXG9akKbktyIzk4BGN8TD/xox9ZK7bBIgn+IYLmXbzJlQq8zDaUlK89
 OD7XnXrPzsVsQz+lzCVOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KxU4/ZaC2J0=:Ow3328T1jPiYcDfNEZPmqI
 zlskd/+4JrUJFuSglX7P8xOc83BFaR69m3CGknCC0xsQ/LAJNKzOZIs87NSlxXxsCXiHUkq4o
 IrtDH+2+kTCuxsaLLASjWVxNH6CoB+2C+/GLDrOCvuQlN0d0OTcvKP7Ns4CxdkSQ+tpi6adwL
 l1zf7p9imSvPdNeMCnkUsgzVLsaetJrXP2sbG7Tjh5iaybTvLDoyd5PrYmwwFU1STVR6xk0J1
 /02aKblOoCOuePe+9JXRp5N15Dk+342dIwZnCaW6srlhyOgQnN+ogPFBaUfseKLfqNwzN1odi
 XFtMMUux50gkcjSC0TnJ4yZbFx4fPO8xYvo/yp77Fqb3fe1sweYHMvWCu1tlI6EOV8UdKPyWy
 CQJ3u3v1thJ5+x0A2+qMWQKuIp9zKffqGPL2DLH1v9j0CyqIM2Ua5NVN9VBap0M6l2x8tenbt
 1YyRzRQ7TdFzRRskHI4rxHJpnv6ngjGM+CLNFExh1cJbyi1Pae3RXBJekJ0JGzmE+wG0Ik7ec
 q/g5G/7IifsgrqzHEQENLSSjVY8k6mqjoRU9wQINVxa3HttdVx5UHriPhlcDmdOm/FrL3mEA4
 58DApGY/ImrJUG6tyQMwVClScEMr9dPf6lA0T1YmEtdSp6MR3/cU6bPGXZwYhT1bcpJF/N/mu
 k9aU7tW/UegDOXxb5DPV5KD4iira+vK6PrqiOYUPkjvKtY2NwEKNrhjF2sRQsItLVFJP8ZtQ+
 SkHk7gWHNeUWrfK8LsTVzfiNmjYJR9rolnkG1tQT7Rs6vvUKEDpukuuDpZJkD3FWFxavb7s9y
 KTN7jMOSV48GdxdrCSNuv/5YA5D2kbY+5WFRzs6qi3hmPlknnx3wTdaPBSJ/pVG2M+XIP07D1
 Pw+7qNaiwZ8mDNNjYrzKZe5SRpBoRX4+yfIv9hZTU=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks mate. That helped me a lot.

Erik
