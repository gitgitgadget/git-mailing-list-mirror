Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D5AD1F463
	for <e@80x24.org>; Tue, 24 Sep 2019 20:15:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403795AbfIXUPI (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 16:15:08 -0400
Received: from mout.web.de ([217.72.192.78]:34421 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391571AbfIXUPI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 16:15:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1569356097;
        bh=WM667Zsx5A1DhomaJ+TSBUCOVR4sejZ6Kzew/ohQrO0=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=UrwfF/nXC7zLZ9C0DTceRGtEB0e8xm+b3OawMLrN9ubinxXs87pnxo8ShrEqNWNba
         O7jx17pkWQMJSIm8cZmxH1WfYTreehGhep0FFdv3JfYoOxCbbX/D/s0iOuHUeokT2h
         uhHd3HDv7GZrINnr3ZgDvFC/0e4w8d0qDPZCKNhs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.71]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lopa3-1hfhKE1saJ-00glX9; Tue, 24
 Sep 2019 22:14:57 +0200
Subject: Re: [PATCH] add a Code of Conduct document
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     git@sfconservancy.org, Derrick Stolee <stolee@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>, garimasigit@gmail.com
References: <20190924064454.GA30419@sigill.intra.peff.net>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <89c6f5b7-aeab-740c-06b6-e50232266fd4@web.de>
Date:   Tue, 24 Sep 2019 22:14:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20190924064454.GA30419@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dnuIdSbq5mkcDkWJZa5k8VoaXp2vB4ckv74E2wxwZCKD6LJknPO
 /WEis50dnJC/cCp9Ua9CdAwsdGDhr96Vh57O22OPZzBbr838MAoWwJqetNMcK2KCHy2P9iX
 bSau+GkOHhv2GwtuMGQVzAWZxGCPsuvusIKCIpo/uNEEqXwf50HhXUueWNpPtleZ7ph/SS4
 zd6PbjA1nEDAa2oub/smQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GiD7G34onMU=:LSp7VUbT17OVTL2p+Izpxc
 azyVBWPw9t7kfrNtarYYcKsICCa3c1ltHPlXD1QNBFcRb0MZWJattjgq4ewyKpnr5TiAruLGc
 b/MNbgVu+RRjjuEF74F8uBWUs25Z97IcsMUrC+CUkXMTHhf5+hMIsn9edTZA9Bsg7EgcOGmuX
 vjyw1KplR+jMy/d1LuZfayDUCjKCtiYPgl49BQP2ss/9Vz14NSozYbhWKiknTXbsFuKKMlvL+
 QvPP60asvPpQ82I4o88Vx8MGb2PJ+tRN4+NBa2y8+x43UUcC5IZPw4h5vFvjx1myq7echEFu/
 MFOGVt4Q6woHAjGDIs5soSvz+Z2KppLCoGIIvtCNAlIpIrjN3fm7RWiT6YRnDhnYXFfU9E+Ds
 9uIGig+2AwKoJ4947E62SvweuOdtyD1NdwJD7w40HMYk+8ui7cXcz6y+Ep2LOqB4t5STFHCf2
 mLGP3rVkcKfCfs3nnn4j/HMgtn+nEwHkK26Ipo1kyFYFlp+oI3qa7k1CcdJkCO7rvdrSY/E1A
 mvfjJWF3AWrvJzc0/88Y3z9E77Acu7vWIdt/MHO5b4nPEiYNfnay4ru3yS3UHoeXXQsfbNSJ3
 ULbJRaaaPTTEHvAstXanEjXYLKaU9de/FcBTNfPr20M4h9/4W25vik4+rtPmMKfOZoce87rg8
 VzjN0Pm5wprDUEMYIbYBICfjm4CYzmIiUYbycZIdSZiQQ1kanYaaBNItN/giB7VBqCyJg+p3+
 qfJ3RFUgiXuI/KFOpslK/q4dFfrDIW9lPUS0m+gYqIjRsMmHDx0pDOIEZrbIk1tZaiX4x0M05
 jsq2A+YW8Xd3y/hH9t4nOahVFLu5Mcicp8X18JPzTzXodJnp7ELRQozi6HBigJDswoqHoxwak
 4cBAcQ9FRuGkVpw74Je79d+ALxDi8Om4ghBTM3+5Yl01R6KFR/kXS4cNXKlWXj8s+Fj9vfqnK
 FmUpqU2aHRkEEBlp2vAk2fQRi3b3Uz3G2vVzqVGZ3h8nzxvpx1SwRRy1tUQmrR2zm2rvZgwVd
 ts/EMy8Z4gnBmmyvvyMu16M5gJhG91cStSAhkfG/tk+qVxx5IU581BgAxVFa1RqJ83LK4BsNa
 XcqGX+6qX/SsFB+fnB2b+JDWdj9ma8jgqk7UCm0TLM3CTsP0aGlG+QiA521QOC7UaaMqct8jw
 Q0n7FT5Xe9I+0B0Kcg7qFdKLxiAM3IkgbNBZUubZa/whCAUI5lkz79E83dAUxuueVT0azR85Y
 aWYJPhmQ0cuavdNNn/B1SDwhB532SxORXnZamZQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 24.09.19 um 08:44 schrieb Jeff King:> +Examples of unacceptable behavio=
r by participants include:> +> +* The use of sexualized language or imager=
y and unwelcome sexual attention or> +  advances
Sure.

> +* Trolling, insulting/derogatory comments, and personal or political at=
tacks

Hmm.  Trolling can be helpful, if done right.  I consider this to be a
good example: https://git-man-page-generator.lokaltog.net/.  Wrote some
texts that look like that..

I don't mind insults.  Perhaps that's a cultural thing.  I don't
necessarily need them, though.

"Personal and political attacks" sound really scary and don't seem to
match trolling and insulting in severity.  Perhaps I don't understand
the intended meaning.  In any case, I also wouldn't want anyone to be
beaten up or swatted, get a lower social credit score or be forced out
of public office over participation in our project.

> +* Public or private harassment

Right.

> +* Publishing others' private information, such as a physical or electro=
nic
> +  address, without explicit permission

Good.

> +* Other conduct which could reasonably be considered inappropriate in a
> +  professional setting

This is very vague.  It could match eating at your desk, tipping, not
tipping, not wearing a tie, or talking back to a senior developer.

Ren=C3=A9


