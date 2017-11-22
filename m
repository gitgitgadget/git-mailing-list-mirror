Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CEAB20954
	for <e@80x24.org>; Wed, 22 Nov 2017 16:43:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751968AbdKVQns (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Nov 2017 11:43:48 -0500
Received: from mail-wr0-f176.google.com ([209.85.128.176]:36909 "EHLO
        mail-wr0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751458AbdKVQnr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Nov 2017 11:43:47 -0500
Received: by mail-wr0-f176.google.com with SMTP id k61so15103817wrc.4
        for <git@vger.kernel.org>; Wed, 22 Nov 2017 08:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WeLElrLgn6K0At4lDHubEqxphsv6mzoDWU6APFX3CHw=;
        b=tBmfyuLeSp1lLcfiyCloZ09DfZiQI9HBCZLmdMVcfiW6Wtba7jqrMZzjSZDXixaOdL
         z3K8Yu6xpg4OcWd/iYgWfiy7QRlHZbCS8dGqjDn4F8CAJsGtOhX0rbCm78NBTK56YTmf
         ZlMeqL5XH0rv5GekaWkbOVSY8iP8NFUv1HcyEUx6D5dgPQkZ/VTrsBYkFFCZey6UL5mV
         eKvhrPfG6QQuULFN+aZTPgGH8PMfiRxVa4airc4UEGDhF16dTKW+60WmWFj+rZoZUP/s
         iTqopVsADvMMb+Xty3brvm6vuaDALUpGMm2u83BssbRYfv1aZ7BcIST9xYD3Mlz6qIgn
         Uo7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WeLElrLgn6K0At4lDHubEqxphsv6mzoDWU6APFX3CHw=;
        b=hHcxjc41uv3mInVRPVAYTXENSK1IxqcD3QWfuQM2RlLss2w+GOetc4SCdXAzToDyv3
         CM4qeqzd6mCQstgsUwfKlbQN6REY0TnxC0b3lxtMq8/3zBsXQWw11OR4w0b2cyr24zcF
         sR3EtqW3jNb1eC5n9fY0B9gQlDv/UfITO42AoxmxR5iuvvB7xhqddEitAeKunZi7xHoA
         XbjSnhT8oniwkUwwdWAE+u/UgbYPmnkfMZpw5SCKTzug9FYgA18Nm6f/iNj5TP4gao9r
         LZgq78Uwpo5dPVjgLM6rncWQgQEuH4F1IpFgkLEE2eO0+nNDpgsxRad+8Ro6O9XI/tIk
         aJCQ==
X-Gm-Message-State: AJaThX6zvFv6ds4WHnsZ/5UQ2gheBVvex3YUV5VbvZdFq8+WYSLNWx8f
        /SuxAJ55NWa0JdA4bYTLQ1c=
X-Google-Smtp-Source: AGs4zMYDBjfFF8HwNmZgbPIikwawn9r8VEG5pc+81lYg9fBxjw62LMHQ56w9wwAQcl8VQgX7tgVj3g==
X-Received: by 10.223.185.79 with SMTP id b15mr19336868wrg.58.1511369026453;
        Wed, 22 Nov 2017 08:43:46 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f132sm3271729wmf.17.2017.11.22.08.43.45
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Nov 2017 08:43:45 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [ANNOUNCE] Git Rev News edition 33
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <CAP8UFD2rheNa7HdLOZK3mQbGxw_zkJ3GDGE7doVnz8B=gVvGTQ@mail.gmail.com>
Date:   Wed, 22 Nov 2017 17:43:44 +0100
Cc:     git <git@vger.kernel.org>, lwn@lwn.net,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Ferris Nicolaisen <tfnico@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?utf-8?B?0J7Qu9GPINCi0LXQu9C10LbQvdCw0Y8=?= 
        <olyatelezhnaya@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        Jacob Keller <jacob.keller@gmail.com>,
        Phillip Wood <phillip.wood@talktalk.net>,
        Ross Kabus <rkabus@aerotech.com>,
        Henry Kleynhans <hkleynhans@bloomberg.net>,
        Charles Bailey <charles@hashpling.org>,
        Thomas Gummerer <t.gummerer@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <6902AD96-E310-4319-BC2C-5D98E69C0227@gmail.com>
References: <CAP8UFD2rheNa7HdLOZK3mQbGxw_zkJ3GDGE7doVnz8B=gVvGTQ@mail.gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 22 Nov 2017, at 15:00, Christian Couder =
<christian.couder@gmail.com> wrote:
>=20
> Hi everyone,
>=20
> The 33rd edition of Git Rev News is now published:
>=20
>  https://git.github.io/rev_news/2017/11/22/edition-33/
>=20
> Thanks a lot to all the contributors and helpers!
>=20
> Enjoy,
> Christian, Thomas, Jakub and Markus.

Thanks Christian! I really enjoy reading your summaries and, in =
particular,
the developer spotlight!

- Lars=
