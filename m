Return-Path: <SRS0=dbxk=4F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 565F8C34022
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:02:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 17C8B2070B
	for <git@archiver.kernel.org>; Mon, 17 Feb 2020 21:02:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Yxc71dmM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbgBQVCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 16:02:46 -0500
Received: from mout.gmx.net ([212.227.15.18]:40815 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727300AbgBQVCq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 16:02:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1581973364;
        bh=V/F3CcEotJZBGsOSughyZhskewwEL/jLl5T+ENAt/L0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Yxc71dmM6U0mHkHwQD0kVRnjVpamBSqTE6/fkAGfwZcZC7Z8Gs2+hOs21H6ULXcT4
         sAOqWwohEzBE7ReaLDhqdI2ieznGEO7iglku5x+8a3/N8GFjNSHqbvkzpXRWzQaCkZ
         AmPPdoaauTFlVUxpNorBG3JtxOtwbDoP/CDenxeU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mn2aD-1jmRPf0dGh-00k8Bk; Mon, 17
 Feb 2020 22:02:44 +0100
Date:   Mon, 17 Feb 2020 22:02:28 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Jeffrey Walton <noloader@gmail.com>
cc:     Git List <git@vger.kernel.org>
Subject: Re: What does Git call services like GitHub and GitLab?
In-Reply-To: <CAH8yC8mnjmz7cTGzkpVQ2+ss7VGuSZ84hY-kHs8h5k53uEGSCw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2002172201560.46@tvgsbejvaqbjf.bet>
References: <CAH8yC8mnjmz7cTGzkpVQ2+ss7VGuSZ84hY-kHs8h5k53uEGSCw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:I9SCi9S5jzlyK3N3c4knp+Z0Q/jWaNIyc3qOpdHyObBeWf3vBsF
 JWnQBm8oU3LTy8gk3haDEFQQf13Qnc4g+CK80PtHmgcRcLAlgpB6AygFUlVMCuDLqbu2FT0
 16+QpgTvrqmZhjz1YthgMNzXAwK1Z+GVlUwm91hB+TJtC2fOEwpshL93uc8tv7MKQB3cyNY
 VizuuWkO1e9cAFLzsbaMQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:mJG2qkzTajY=:ZElQKru3RkeuDis0yPs/08
 lW2RiPpnRSt3Jt11LCjlbMqCRCn+GAx2wcEKxpi1tGTZyt6L+twREXxL4dOCcWaWX+1S9K6sw
 kEWusrPYq0EYzUpYkI1HVpZuKaJvstYTFetnF6zXvuJunDGRD1r8OjNJrDycEvyCBoAEoQO8O
 fvydaFbbv3/3rE1LHgBnU2bpgMgsjWDpZnaN2ixtKO8cFcmW06zjwdTf6Tj0SOPA89DDadZTk
 Er03f2xAmeWnJfcZslEXErA24te5pmA/w6OkkXHR4uQG/yuN1BwrqAv44VNhaEU8NtHPyrQRJ
 dF7NUz7rMQoLOxuHJTVQIGM9y8WhYyO4q0nP1AgrhAPlfmJJr+NWoCZ2kPNUncJIE8JcZ4gGE
 R/60kRhhTj4ZV/ELj5C0ePpcH44huLoOmWnY7fwKKDVOZTAEVpTbk8x6jHA5AWRLAMarcvYzQ
 OB6gGkFt7R+GW1Bq/raTu/Nm7gq835Okfj4+NdSVLJW/W2sXwhLn8etTQG4qsLc7+2lJufica
 5lEf8GRE3CbLGNC6ofncMKsj7kOdV92n6lD1S8d0kWkWbDNBp64EEgsDzIVUCMrId+tfzt98U
 wr1MIJgj5+CaNAelN6ofjWPWHKUQr/YWi4Y2APC3rM7FB0FwXwNe1nxHXdpCwRKja8o+mGlUV
 hXdSxlDsu3qzegcYMwUyaGlK9jqSozGLqPB6SybnkjLnH/hQ7MHBa75USX32R0XWq++ihfIX+
 X9OI6ABd6DR7gWfaLD50WjEC3Q9oY2jE8gXULDrq2Md98LyHBXF67aRK5Ke5wrMZsJrnV0MVl
 hoF+rL9Dc2kO0ocK/AQwP1/hocZGfeqgNMxcGmroXLuW+wTxgW2IhX1K4wcsB/PIRlgkW5Vx3
 2MXjTXv+Q/DlOwLXEOPVmX+/MQaR2S9Kf25dHy4xhX4gOa8qbGhWrpmorYLD6Gc8lHvOdxCLZ
 IsgPpYPv1MUn0++4BQI7S62MWnxVF7BfJYPf8O6Pplbg+JoWC3pgeA25a7N0fIO1wDfuENTP6
 Ftvm+lY11iWiaA5qpqZtJW+1naxamaRfIZinlYUm+FEJOlibTM7Uh9e7lJFRteoMuzM0GGL9Q
 rSBkGMd5SdwM8x6aGjfYq1Iuy0VP8wdHmXay9Z7Lu275MYWevqRydV4gf4I187DY6MrqMRwqE
 1S/TeKaZRIqYO9A/3rl+6ZFXFvcnO8KjD30xTVaKuneVSEZdr0/fxKtnhaK6Yr3cwmkV+qr+a
 evKLn6qCGF8vmzijX
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Sat, 15 Feb 2020, Jeffrey Walton wrote:

> Forgive my ignorance... What does Git call services like GitHub and GitLab?

I usually refer to them as "hosters" or "commercial Git hosting services".

Ciao,
Johannes
