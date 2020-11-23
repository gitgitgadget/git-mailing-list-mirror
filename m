Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA72AC2D0E4
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 11:04:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6529B20773
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 11:04:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="V4EpbmJ2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgKWLEJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 06:04:09 -0500
Received: from mout.gmx.net ([212.227.17.22]:58069 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725806AbgKWLEJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 06:04:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1606129436;
        bh=0ymfh3+hW5Cg35fHSi2+PfNh2OLA8bffT2HrxUMRZbc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=V4EpbmJ2yNBZi9oDQC/ReKiRpE1ZkmcJqLw4cgQDzezwxEYuc93CPsu2otbk9RwND
         DePxsfxniB+xGUte6CJbKj0vYjKhZZNDRydSP1tHLb9IUhkRW0QtGdvOis3rR3ggSh
         5ESM/1Ied2Zjym1QBtKVH2TodhxQ3dhZ0QZa3z5Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.26.22.105] ([89.1.213.133]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MLR1f-1kxzhP0duN-00IYQl; Mon, 23
 Nov 2020 12:03:56 +0100
Date:   Mon, 23 Nov 2020 12:03:54 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/4] grep: retire `init_grep_defaults()`
In-Reply-To: <cover.1605972564.git.martin.agren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2011231159340.56@tvgsbejvaqbjf.bet>
References: <cover.1605972564.git.martin.agren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-972923147-1606129436=:56"
X-Provags-ID: V03:K1:3Dd+X+b98C2igscfhHUZYd0qtQKQ+gPOcAcikliVkTdLR5QdLqg
 McE3qIZ/xOq3m4i3L74ZTOY4+g/8kBzcx2kVsArwVuJpgdCai88o2OyXBtPVISYleQSXyvg
 mr/tqQZM2vco2CDfeCPlbpKmzQO0z6ROTFVeFDfr//Du+V4bHuMeZyTpGBKUjEUKZCCvmQn
 TH0iknOyiBlyk4KvSW3pQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HsoOwn1+uew=:tq0qLSMCV/HyTtvl4dICDh
 Gpe+T5hlbo/i+fFYEbB9RzPL43ujme5V2sQU4p900XV+SGdS177KVY27aM2jJbdaxmzIWBhLj
 RIrj/wZQqtds+e+l7vJpC+9iv3GGuDrDIPM7iXRi8n1v5bQEEMJBdm8k6LKkTWHjxPTMEsTtR
 9nblpMa9O31TWsDJSvU/P6o7Z2DF9gjxqlYlpqlVWJ5moR6wQKNkXN2VJWKwu6alRq9/IeHKr
 66FUgXllxgrZVzsEPmvjWJlj1NGL23V9rx+Kx32QGTsL7+s5dzv3RzWr7i6HbYS+WlrjQRwN8
 hY8GolWgxChSoFgi5ptKfJG3PjXa2HMrG7EPYy4YiqFCXjlzeOFbXiifILrsUcjJy5fbqEfzP
 TvqS7XEcUkH2S7J0/N/bR/t8BBPnOZEmd6vL2MsAZaebsr3uhZTUZ/MKL6VNbipjuXdTzTkFn
 uLdQPfc/31WJY0jC+ivFKjWtS4HWfEt74PwNYcRI8BllGK/5qJ8By6qojWtc95Y28mVWnV7u+
 6oj+FPNQDzoNXRnbALqR3tl2t/Oi5k8hUZ3MwU1q52KFt41NFQn9tcM8rhalgM53P8Yg2v62m
 J48YGLDHyZ7ordk53qyttTBjxG4q8l6lQ+0RUmro9j3MAflognOhK0OfvLSYdo+KOYj9vhwz1
 BuKgExHK8tgbUG2dZ+jH2bcEBLJUqOT/YFjx3fqaq49SZqXxcGIwcfmBfDzqlzrRDk6SnHB1n
 MqSO1g/eRSfXsDiKSIJmTekDqVlDo9Am0g2XtStkjxl8ZTOhl+Acl3PT5zhBRgok7MVrZWVuI
 0rSkjs1RrZdjCc8x3HUif/aIrFLdgykTJhwkYzAKNd1zJbuEqlOesRowLOkBD58uq2+OyWsXG
 LZs+6D1JqlkInob6UZXCRg1AjW+SyAilabaKFOq0g=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-972923147-1606129436=:56
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

On Sat, 21 Nov 2020, Martin =C3=85gren wrote:

> Users of the grep machinery need to call `init_grep_defaults()` to
> populate some defaults. There's a comment: "We could let the compiler do
> this, but without C99 initializers the code gets unwieldy and
> unreadable, so...".
>
> We have such initializers now, so we can simplify accordingly.

When I read this at first, I feared that you would change a
`pthread_init_mutex()` to using `PTHREAD_MUTEX_INITIALIZER` instead. On
the face of it, that would look good on paper, but it unfortunately falls
flat for us because there is no Win32 equivalent for the static
initializer: we emulate mutexes via `CRITICAL_SECTION`s, and those need to
be initialized by running a function.

To my surprise and relief, your patches do not do that; The only mutex in
`grep.c` (`grep_attr_mutex`) is not touched.

I just wanted to mention this here, in case anybody else had the same
idea.

Thanks,
Dscho

--8323328-972923147-1606129436=:56--
