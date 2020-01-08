Return-Path: <SRS0=ZiOn=25=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F44C282DD
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AD0562067D
	for <git@archiver.kernel.org>; Wed,  8 Jan 2020 13:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="YuBtxEdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726794AbgAHNXt (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jan 2020 08:23:49 -0500
Received: from mout.gmx.net ([212.227.17.22]:41911 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726087AbgAHNXt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jan 2020 08:23:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1578489813;
        bh=VYmhQLMrSg/lBNGzHb1zcVlSRDCWgjQ+Ke4RcMDVijQ=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=YuBtxEdQ6zytwbb6BEYz9or9qAdzBgffO9wm/N9YUMS7Zzko6tJhFO4eoBDRhJPh4
         9bZkwtETJyL2AJ0RgZKg7+bdPDDp1+BVUFTs+BKWpdb9YqiNO54tU1fAIwIVTl1IOT
         wO9651wuUbL1TspEPpdw6VycQleiiTXaY5A9gsx0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.152]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MfYLQ-1jM25F1wVs-00g0zy; Wed, 08
 Jan 2020 14:23:33 +0100
Date:   Wed, 8 Jan 2020 14:23:32 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
cc:     Junio C Hamano <gitster@pobox.com>,
        Mike Rappazzo <rappazzo@gmail.com>,
        Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
In-Reply-To: <20200108025509.GM6570@camp.crustytoothpaste.net>
Message-ID: <nycvar.QRO.7.76.6.2001081423180.46@tvgsbejvaqbjf.bet>
References: <pull.511.git.1578326648.gitgitgadget@gmail.com> <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com> <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com> <20200107013401.GI6570@camp.crustytoothpaste.net> <xmqqlfqj6y5n.fsf@gitster-ct.c.googlers.com>
 <20200108025509.GM6570@camp.crustytoothpaste.net>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:n0ys5lj9BaL982hpTwN8aOwxU5gNUV9kjSaLwDp5h6dh91Y2ye0
 AUgDdBroNwkPbAhU0iRwT69YxZgp8mbwXglXMAhLv6gTy90FYOAoV6786wAyrJKPZULFROH
 +FpWVzas2rQSxcsuB6T56kEW0eSwjFA3mT5siPvecnpUj83P10DvSKoFvXNg9JgcVxWJWlh
 4DA9ivYPLq70VyCUwI2ig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:QT+Sk2JlKRI=:l2WxKDHZf7izDI4UkZbg0I
 gJVwgCmurbJDzKsDAzWvG5sBStycJr0bI49wKy1DKSk8aXwJvBTSPIwvuVlrrdJW9EoQz2CZ8
 9LM6hqqLkalH3xwETuk5tpOSug8HHhbMAZGR8IOWh3dMobJQWA2uyIOXCxc6NtlIVH2W3Wn4q
 hZhrGkRNUKhAwmWT3NKU5AihxxdvNfKDtKJUMZwTKBQjQi54quU+po30D6wI8SUSFHX1KDLFB
 pgm9t3cROUrm72V0KRXxjy1IsB+vJIrwQtveqzRQFN+hs0fNs8dlsSCv2FTlqQI+llFfykYpo
 rRTsB3XN0YtsrMSydF6Na1c5IdNQCobXeqfaJt1v8GiD6f+nxvJyiamWzvVUpwa+0V9dd/iAj
 A7U3Shh7nWNFwB1CUIuqDcPJsD7AJeQBP8A+GJDf/uPA2fNE/r+XaqgM8J7MeKdf66P1xGm8B
 KBIMP/QdQEM8tyCxdDIKUP6HcbHuMMEr7TTGZXPrtbNzAKY5dxX5b9qsH0pxgCfe6f8smFlgv
 pxX4kcmONElXBCxileUQtGro3o/cBajOrd4KSv7pDzFNiqdsqrgm/RB3iBwIvinHo0/k6clxr
 0CylWeJFANiWW8l7iz7/v7jidZYOkxkGNGvv4r6ngrPDRwUS5vBYmF3o1fLKeiUJKY0Exyyte
 jp9nUShMEsk+EbSjX06arZxDyT2w2q9ziZKYoKkmywnTDEPa28hFeV7Ze9uft0TLqQ9JrVSP1
 nI6AJTmQcwZb0KJApl4pQrQbqKVXFaYJf3fsBP2qPv98wVe8B/I3Ryp7dD6tf7r0ub++Lq3sZ
 rygSxmc9qPd92Z/q1RtjyYTZs0Sq2CPgOU/VNjPWJ8ZJqORnEhNkXG+8PExCnl7HdGYVR9T2q
 XHy4tgJI+7uZdlYmAkap88LfJBxsoTmTNvc1xQ1EQI/ztSJEgukXGC0lQEDA8SeAFEoUTx0T3
 WcUZPZj7h8V1itopYEm2aIfmDDhkbsYgDZc95ypN65a4YPV5nykzWDJy0wN2IEU4hTJh6blQm
 ECCHSc0flTRSYH07i0kkLMl6ReZm0DwNrumsw1U4aU/pRAbnwrkTuQZH88bxTGXkaBDU30cE2
 fIwx0w6sie7wLlbSsNh/B2xVXrfNnJYupeCT1txdVMPVzSfFVKPz4DKtSEDEfMSDQh0ogKYCn
 pjYul2lN5oyzRhqY+Dr/KYi8RpoSirzrAnFp0rL4mnRXuVbrc2mjBRs93MNi+3nkAAmj0MWkN
 /LSO3w14BLKGxXAxoN/CB3wgHeq/ksWjiUoAIvsMA1xd4iZmTS+iutmQAmV0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi brian,

On Wed, 8 Jan 2020, brian m. carlson wrote:

> On 2020-01-07 at 16:15:16, Junio C Hamano wrote:
> > "brian m. carlson" <sandals@crustytoothpaste.net> writes:
> >
> > > I can see the argument that this makes it a little harder for mechan=
ical
> > > processing across versions, but I suspect most of that looks somethi=
ng
> > > like "sed -i -e '/^squash! /d' COMMIT_EDITMSG" and it probably won't=
 be
> > > affected.
> >
> > With the left-anchoring, the search pattern will no longer find that
> > line if "squash!" is commented out, but people tend to be sloppy and
> > do not anchor the pattern would not notice the difference.  Perhaps
> > the downside may not be too severe?  I dunno.
>
> Sorry, I was perhaps bad at explaining this.  In my example, it would no
> longer remove that line, but the user wouldn't care, because it would be
> commented out and removed automatically.  So while the code wouldn't
> work, what the user wanted would be done by Git automatically.

Sounds reasonable to me.

Ciao,
Dscho
