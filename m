Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E69552021E
	for <e@80x24.org>; Tue, 15 Nov 2016 14:18:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933371AbcKOOSR (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Nov 2016 09:18:17 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34299 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932406AbcKOOSQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2016 09:18:16 -0500
Received: by mail-wm0-f66.google.com with SMTP id g23so285843wme.1
        for <git@vger.kernel.org>; Tue, 15 Nov 2016 06:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i8Nf1l4P1Ru4KDDGAHc4HAAu+4GE1fnpSw+1GgwLszU=;
        b=zVgsbuXy4475LPFTlwRvRDtpmAaD12760Hy7RgLloVcgWjKvckUCdKKOkm1o4eEYyi
         nS5nQh7uvH9SK3bYztVsm29SR72cSZrickjaHUm6aG25h6Ak5usWPRkds7ASAcgU54PH
         gJ3FYPfjvtK64D4xLpTKW/ejO/pE+OyKg/a9zeYqggIf3d7R+WTj/16FEokuwax7hO93
         MWDYM1rJLrtOrf0z0nxx52JNVMmL2a0ySl6kKkyfJdVvmUMX4etd3f9zIgo4GPy9bw2h
         G8DwqxByZswWL6TDQWBC+WJvqA/3wExVgZJywYLQxjE1TN4fSl8YJY5AQ0xvRaem7F+5
         Oy5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=i8Nf1l4P1Ru4KDDGAHc4HAAu+4GE1fnpSw+1GgwLszU=;
        b=dkytADM76FGt9Moe92n7sa9quxRz7bp4+qsV4iz+rcO4PyG71vJhXkHkoJxFM0ukbw
         gxQCO9cl0f3Hnt8U/imAOp9SwmulOIA+87+CloD1CmxpDWNGbPfe9yVIacOguavg22cc
         3f6EUWB62rqPOEEXEU2aepEHvxFKo09xcLEVI+KeCkKkWOeHp7y+6pxnju+DPysZPmPb
         TNwqycoWsTHNph6n4qk381hNTwo1d3pojUfAWGZOB5EXSc8q/TKbA8Qj/jw9B2ETDdUk
         HxmG/6CyfZpLTjr9s8yeFrrTuCKYWSbXvPpA+Roa/5SjKbecytY+24r+U4DoMekLMLAA
         MLOA==
X-Gm-Message-State: ABUngveAjEADuAirA0Cs/nJ9xXkNR8Asl0CWsXnoPS+aOp02vbyyIG/jTXHEqT/3oFVZMQ==
X-Received: by 10.28.211.72 with SMTP id k69mr3732457wmg.137.1479219495237;
        Tue, 15 Nov 2016 06:18:15 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id jq10sm34876663wjb.46.2016.11.15.06.18.13
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Nov 2016 06:18:13 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v1 2/2] travis-ci: disable GIT_TEST_HTTPD for macOS
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20161115120718.GA7854@book.hvoigt.net>
Date:   Tue, 15 Nov 2016 15:18:11 +0100
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>,
        git <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <48AB4BEB-BBC1-48D4-99B9-D1AAA653EE24@gmail.com>
References: <20161017002550.88782-1-larsxschneider@gmail.com> <20161017002550.88782-3-larsxschneider@gmail.com> <203BDCB2-1975-4590-B4B8-3C5E9D210430@gmail.com> <20161107212004.x4y7bcl2p4chfkm6@sigill.intra.peff.net> <CBAF806C-7E1E-4490-A07C-F98DB7488F5F@gmail.com> <20161110161012.jube4bwbww2wa2ew@sigill.intra.peff.net> <2088B631-4FE8-4232-9F3C-699122E6A7B0@gmail.com> <20161115120718.GA7854@book.hvoigt.net>
To:     Heiko Voigt <hvoigt@hvoigt.net>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 15 Nov 2016, at 13:07, Heiko Voigt <hvoigt@hvoigt.net> wrote:
>=20
> On Fri, Nov 11, 2016 at 09:22:51AM +0100, Lars Schneider wrote:
>> To all macOS users on the list:
>> Does anyone execute the tests with GIT_TEST_HTTPD enabled =
successfully?
>=20
> Nope. The following tests fail for me on master: 5539, 5540, 5541, =
5542,
> 5550, 5551, 5561, 5812.

That's what I see, too. Apache needs to be configured in some special =
way=20
to make them work and I was wondering if anyone has figured that out
already for macOS...

However, I much prefer Peff's idea to test against real world servers:
=
http://public-inbox.org/git/20161111092824.qqgrmhtkuw3wpbwa@sigill.intra.p=
eff.net/

- Lars=
