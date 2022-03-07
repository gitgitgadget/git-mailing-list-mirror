Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD727C433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 16:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244085AbiCGQQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 11:16:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244084AbiCGQQo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 11:16:44 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A156218
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 08:15:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646669742;
        bh=saXoERWFyHquuhJlOZN2oP0w3xWby2ibEqSs6QSZ0UI=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=D2wk2vA/caOD+VAjvVse7R2cn/hcHAqYV5hmC5s9ZNfExIwQ3MGrysGPCrTYPT3T5
         Z4fc4A6FrZJ7doSwJWWktRMvqgtmXDu/FqvyEpY9cAKKfQJlRzW6Ht68yEi8U3LkHo
         uqJO0R34nR/lG7PJY/29/JLro84AJsrx4LUQ9FXU=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.28.129.168] ([89.1.214.47]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLzFx-1njCPf0nIX-00Hwu6; Mon, 07
 Mar 2022 17:15:42 +0100
Date:   Mon, 7 Mar 2022 17:15:40 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: en/present-despite-skipped (Was: Re: What's cooking in git.git
 (Feb 2022, #07; Fri, 25))
In-Reply-To: <CABPp-BGX1+5KYeKLmUv4GN1--G5G0x0pRLxa9RRFBDSzkBc9AA@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2203071715130.11118@tvgsbejvaqbjf.bet>
References: <xmqqee3q73e1.fsf@gitster.g> <CABPp-BGX1+5KYeKLmUv4GN1--G5G0x0pRLxa9RRFBDSzkBc9AA@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:vxnvvMAiVpjtdlFTgpwlVyIaIktPIS/JLs3pqc85dpMCbKAbS66
 F1jx1TEb1iiR3Cb3hO46qAD/jbbPb+oV3EpFHEfY1TJW8dX/wu4rw4HQ0f/6R2WTll+B7Ca
 Q/anNXTdAGdeZUnFd2LMKxzPS64fq4xdm32VRYfbWmjbcUjZAElyvWUWequJpsTrmh0tjPF
 nBhwLCEX/tf5hH3l5l2jg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:g72jFW84Or4=:q3qi6NFjc3yUGxuQs0b5F2
 OkoEDn3HmgUpcuQP7TarPMHtJaZk6Bj5wtLSko5Vzycnn0ksPkOPDhnsOGAIZ11FsvOU8qaMQ
 68oYgI/p17L81oW4GHCjf0UNtup+sq5XFZ731EBI4/RpIikuribs3gQ+JpT0tL7Azglriv/32
 c+9tofMvbU5e4CP8AoGp87KVFR+NQhUwFi3/+0+wh/gllhtXYeiyqOSR4o4ccCuHI2gRfYmt9
 p+FPeAj/hh4WkAYa7u54yeuq9iqf7enZ/at8Xpiy0Q4LbnbGX+rBlaGOY3G1vNT1ECf5336zn
 SyLd+pnoxX9xYNmC/qn0Z/x6kqht+5QiHUKxDAyUuWYJbahVECM+1kBRiKRzdCdpvuvUGIh3z
 Ak5QwUwzr3/Wi/CQPdupGiYjjS6HzAz0yhaFMN4ysjt1+m2qkeIUMGy9kIHsMwAXXUJSJHXib
 DvKQ8U1EKioBQQfJ4z50B3LIITbcgdUn74okvfgbDFp5VjtmnbpaoSEMTtgU8z2qdse0Cc5Sp
 fKTkAYLcirKUWcLlVHjsOMQQUOsVrUekGNgq9d/G8yIn46kJESLa2F/LeS4e/53TC/d7RxJrp
 fkuwBUVnl3o6vPnqruAFjrnkBptgHWpPVSbJQnPFVolx6ChlPbSZWasGJL+zfnV8pjVPbN5gk
 KDlFi4xIeCP/iEAz1a2y0bSb7+zJ+fnwLryZEg0wtH0YsLxWr0dUaZIYDQM8HvBX8hff1Oiy6
 dBf+X/nY2cV3uba2E3QMt0Q0OdsqBAaJw5j/CxR29aYYIYjKhAt+lEfWyNe22376Hq9SyLnAv
 bC79LjAwnzkeEveluC/nUxLY0nKdwZm3zAv5o7UvqBCQgnH+euCoOr89fu3ZT+X4pl0U8CKjJ
 a4r4Ixfx9VWn7ZMFECwdVgUIuOCicpKa3knHO0+sQVUc5WLkSkaFYVQ9rvc4VsOgwP4/fN6Kg
 xA8Kylmaa3+oZn/LtqcAzR9lQawkT3FpeS1QD7pkDRBJ3rUccv7hzqSJ/BKjshoytakV99Yis
 Vqg/5S/fM354aOLW/OboDMAl81DHDtwlOq9tX6AJ2eegVBUNBU1wP+XC8qXmNjD/A7vAgDSuq
 UI7Zr4kzPUH4VQ=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Sat, 26 Feb 2022, Elijah Newren wrote:

> Dscho never acked it, but his multiple suggestions on wording and
> config naming suggest he was otherwise okay with the patch in general.

Sorry about that, I got distracted :-(

Ciao,
Dscho
