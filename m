Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6A92E1F453
	for <e@80x24.org>; Fri,  9 Nov 2018 10:44:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbeKIUYS (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Nov 2018 15:24:18 -0500
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33183 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbeKIUYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Nov 2018 15:24:18 -0500
Received: by mail-wr1-f54.google.com with SMTP id u9-v6so1397452wrr.0
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FlK/nQerLjJyDK3Cp9XlQ3c4XjWPhBubB3/bRPMzxR4=;
        b=t9H7gkAVaqiw0Zy5u1Uq0wxKQHIXcAosNHqx/n0wJiRrzK6kl3jKkXwWnPn3NfgWDN
         ylBb8jHCarjm68Oosr4gX6c2PivPH42756a+d0f+5Q3ZRBdANGuSAJN/VAYFd95ga67K
         VnSZWmUtHudmlDDVGMxdQJi2KeBTP7YRprpeEGbMcvquJgXPRdYYzDbZGZg3iKJnH8F1
         ksZqKDa6/vjolKXKpecxK818yu6bvsMURaxX4+aWk1yC4n/mkoIooFqXwFYCf/pybfF6
         +mpuk0v+usy+EMTenhOfI1Xup9bWugfdKHfZS3Qh8qFCFsqxb6jhixZvoJ87ZZV6R2Dg
         HeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:mime-version:subject:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=FlK/nQerLjJyDK3Cp9XlQ3c4XjWPhBubB3/bRPMzxR4=;
        b=I2K3wPsGrIhyBEiUZEkAJpfHAwJNHdzCqXtbjGeMq/ED7X7AL3Lk+SpH0Gku3oEOjY
         fsjATMFNVSXHaWpOCRxtBQHQxlBUmykTN4uDUzBuCkGKG8Zcsq/G5ZQ4/E1Fy24tmYsb
         kig+/wF8g1OavpMiOlCM0nc/wj8/a9tIfcKs3VY1WO/VsgiZDk5gfseIUBODEGkGjcl+
         sXpm/+vQUb/6ZhZHB/1pk1692QVRdY2aa4pUKlB63uH3yneNhMYSRmv6nZVtAwjNFWDX
         ljd+588bRrRi3B9p09wlfQQqh9zH1j8bqZTbEHZY6WyjF/pOJ+kzWXyUI8T9rngSCrWO
         vFQQ==
X-Gm-Message-State: AGRZ1gJVHuRdcjg/iALPgCzOFkU3nkqq1ip0Kq0af6pMjBLCumNEO39G
        UKnph6j2oEjzxn1xJcopntk=
X-Google-Smtp-Source: AJdET5e73JYXPfaESJPMmTxU+8ppyB2qhM07Gk4gaIHCW0EvYN9cT3Dl0l4+Cj5ekmMplIZ4lhk/uQ==
X-Received: by 2002:a5d:4fc7:: with SMTP id h7-v6mr7924758wrw.48.1541760255252;
        Fri, 09 Nov 2018 02:44:15 -0800 (PST)
Received: from broadband.bt.com ([2a00:23c4:bf00:6100:5c74:ce0e:9787:9afd])
        by smtp.gmail.com with ESMTPSA id t14-v6sm8113523wra.63.2018.11.09.02.44.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 02:44:14 -0800 (PST)
From:   Luca Milanesio <luca.milanesio@gmail.com>
X-Google-Original-From: Luca Milanesio <Luca.Milanesio@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: Re: [ANNOUNCE] Git Merge Contributor's Summit Jan 31, 2019, Brussels
In-Reply-To: <20181109104202.GA8717@sigill.intra.peff.net>
Date:   Fri, 9 Nov 2018 10:44:10 +0000
Cc:     Luca Milanesio <Luca.Milanesio@gmail.com>, git@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <EF813655-82C4-4A0C-9D88-689C606F7A34@gmail.com>
References: <20181109104202.GA8717@sigill.intra.peff.net>
To:     Jeff King <peff@peff.net>
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



> On 9 Nov 2018, at 10:42, Jeff King <peff@peff.net> wrote:
>=20
> Git Merge 2019 is happening on February 1st. There will be a
> Contributor's Summit the day before. Here are the details:
>=20
>  When: Thursday, January 31, 2019. 10am-5pm.
>  Where: The Egg[1], Brussels, Belgium
>  What: Round-table discussion about Git
>  Who: All contributors to Git or related projects in the Git ecosystem
>       are invited; if you're not sure if you qualify, please ask!

Hi Jeff,
is Gerrit included in the "Git ecosystem"?

Luca.

>=20
> This email is just to announce the date so people can start planning.
> You'll need to register eventually, but I don't have the invite codes
> yet.  Registration should be similar to past years. In particular, if
> you're coming to the contrib summit, DON'T register for the main
> conference yet. I think the codes I get will cover both (and as with
> previous years, contrib summit attendees will have the option of a
> complimentary pass to the main conference, or can pay =E2=82=AC99 that =
goes to
> Software Freedom Conservancy).
>=20
> The content / agenda is whatever we choose. There's some more =
discussion
> on format in this thread from August:
>=20
>  =
https://public-inbox.org/git/20180813163108.GA6731@sigill.intra.peff.net/
>=20
> though it sounds like people are mostly on board with what we've done =
in
> past years. I'm looking into getting better A/V for remote attendance,
> but I'm not sure yet what will be possible.
>=20
> Any thoughts or discussion on format, content, etc are welcome. The =
only
> thing set so far is the time and place. :)
>=20
> -Peff
>=20
> [1] This is the same venue as 2017: https://goo.gl/maps/E36qCGJhK8J2

