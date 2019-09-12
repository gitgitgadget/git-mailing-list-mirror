Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E127B1F463
	for <e@80x24.org>; Thu, 12 Sep 2019 11:27:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731253AbfILL1P (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Sep 2019 07:27:15 -0400
Received: from mout.gmx.net ([212.227.17.20]:33353 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731140AbfILL1P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Sep 2019 07:27:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1568287634;
        bh=pR2TY+8mLP70G/7MiB94b913bTdSKe76F0FjmmJUhaI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UGNvfweskD9uC5yTdQEdlrCWEOx9YplqwRsj8Qc4iku94hbxyH6GGDb0DXl3N3KmO
         mKu2xsc5dxUcco9c3LhOH1nhbjS0Of69FgspzsdiWfWfXQ7pSlsNW+WlbDtHWuWp7n
         91h75xaHb/WF/Iv3oX0kDTFgzwmQzLjF5z7kDjWc=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MG9g4-1hu3O13tpU-00GWsW; Thu, 12
 Sep 2019 13:27:14 +0200
Date:   Thu, 12 Sep 2019 13:26:57 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Eugen Konkov <kes-kes@yandex.ru>
cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: error: could not read '.git/rebase-apply/head-name': No such
 file or directory
In-Reply-To: <386490889.20190912101245@yandex.ru>
Message-ID: <nycvar.QRO.7.76.6.1909121326310.47@tvgsbejvaqbjf.bet>
References: <386490889.20190912101245@yandex.ru>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:M+EHers/Sz8pFMqEy3Nv/3YbBZkPTIKV8Keo261yO9BBvUk+RNL
 253ZnqfyEnLzwUEQWNNXC0hLlOLkhpiG9/ePVQMQX1WAS90y7CYdtyQwnABy344YQZegJpE
 0b/x0KXgGU0xj5VFz5Y526VPUJfGEJRyE4q0Tkhxn5/O0nkhT5E93jZ1yg+w4lY641WqChQ
 FkB3aAzHP2m7fkB8A216g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h3upIbS+EH4=:HVsIhx5rFB4bKXmdzIWw44
 vrknwk06RT8g8ZuyLmru8WKWfxpAdfV0DSTEIww6SLVsT+GN5T4yOjLMHZAWXmVK95uAmBETn
 XvU21q4iGHg+XYP0mR91c08b576R0rwwzS42GZ91gfPfWQARIxwuqSaCTTN/xxpc/Wy/P5AR9
 lIfu/T1IhMkgPpXQAX5aOefKqJ18avkQDdzzy5P2PbA9JX/NXxxNMs84uxydJiKqJCwSYO04t
 a/E2tQXrv0t7fpo1WSZOJVcbI5Pu8d5l9cp6kX6YSLFBsUbaPXmB1dRUbgfYE0zo7KTkmF1w8
 KxN695dLgQuUD0Bd+InCmjXDJO/vz6vPwapNAUVKZ7ldXMz46SDk/8q2nbuqF9NlUlEmdZ1wO
 X7VJ7cSz1y4ih7XrzZ0WMo+vvc92vlekU4UF/UawIjIIeEW7WTPSd1KWjmH6m/l4rU/mvuOuI
 FY/fwkHwWPFDIT/+4gvP/jqHSmRgOTe7YszVnGeVPUJ7RHdvZKufUWXF3pVeRDLiQGED3S4nh
 f++E8lJvrqaZ2atVaSbVLUOD1rbFphzQrAa5IcFg9LGxn4I7/VzlN41i1DJPFffus5ODKTSfL
 A09M3/PQVJavqBa2Gg/BFXWxwP15GFHVN4vZjdp55PW3A5+zFbRylmbLDDH5POxzCILXfmFza
 UWIz2cdivuIyoG+79jy6R9Ngu89uPjcGkmk+pdzoXWjaQKM8j8bXiF+z9EJ6WxkDf7fOjjQkU
 LKJ+gsBg3GjEjZ21pbL7aRtF42/FDdC0dI3zfApm2kgG35EycafBMMdmLUR89hQUDdm8s9614
 nLtkoT7VM1TyJ5zr/Lc0a2sscE5mnFXT9ygu+/QyLuO/i5LDMXTH7r2OImJz/jQmhVJsFl9z1
 yQ674mom1n0+leOmK7pgtB50BxIf34kLdnTANYCQNMx1lpZTKO3byvJtiBmsYDKP8C/VAq36B
 B4svjVjRmgsv6Wsf7FX7BkB7890JDUzM0NrWFIlJqeUVIlULq8SkYyBoy6puln9dqTEnnbqbL
 vOMkSzJqXrUG5h4Yd9Mhk++G8zD2MKWqOuH5TmQCR/Ii7qp+v8+kV6cqMgEc+4vYsXfaKI0IU
 SBz8pWfNoBiSpCT0tWIP1+2mlPuB8ib33U3TGadwvUEo5r74d2YmY8YMp6xREF/uR51KmEFDr
 yZ0y1rLBLasqjXK1fyWM/xrvPOPeSuHhz34LWfc/vXNNQU2zwsLrW5hoIhnQ7EUSRs2FY4U4u
 uOmsxcbIn9T6QAxnl8jKKB6TOlYKUsTgSD2OrOgnPzTE9p2+B8CcwA8XLMvI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Eugen,

On Thu, 12 Sep 2019, Eugen Konkov wrote:

> $ git --version
> git version 2.20.1

First thing to try is whether Git v2.23.0 still exposes that bug.

Ciao,
Johannes
