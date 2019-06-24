Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A14DC1F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:38:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731632AbfFXRiM (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:38:12 -0400
Received: from mout.gmx.net ([212.227.17.20]:59267 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728762AbfFXRiM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:38:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561397879;
        bh=4twL5CryWYHRH3NdLIgc25+AkCoMi2U4olCrhd0zDOA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZbgtFjm0/7x3O7HYd/W0NIC84HBkDXdycEulZ0dOfZV48Ady0FAPSYj0JnnMS5ESx
         LG4sY7JJXId9alApVcrsWl+9z6/sIbCGqNwtDQy3N/VuEIpSktmGw+FdbB+Bppond5
         sqiTzeNc8S3ZpV1KVaNNo71nCy7xUILOJIkmQqy0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MOiHf-1hwJs81H0Z-00QDPQ; Mon, 24
 Jun 2019 19:37:59 +0200
Date:   Mon, 24 Jun 2019 19:38:18 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Junio C Hamano <gitster@pobox.com>
cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 1/1] t0001: fix on case-insensitive filesystems
In-Reply-To: <xmqqimsuj4ft.fsf@gitster-ct.c.googlers.com>
Message-ID: <nycvar.QRO.7.76.6.1906241937010.44@tvgsbejvaqbjf.bet>
References: <pull.151.git.gitgitgadget@gmail.com> <pull.151.v2.git.gitgitgadget@gmail.com> <c2fdcf28e725c91a1a48c34226223866ad14bc0a.1560978437.git.gitgitgadget@gmail.com> <nycvar.QRO.7.76.6.1906211632570.44@tvgsbejvaqbjf.bet> <xmqqh88ikfpb.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1906241212220.44@tvgsbejvaqbjf.bet> <xmqqimsuj4ft.fsf@gitster-ct.c.googlers.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:tHRGiRO9k286UqkxDD8KV5Nvrojs02D1ZTER/9kjIYCrOLrJnHm
 LSwPzcUszgE8Nn/BJKxuOfTsUCQjEvJeFPdVWzkO5fYTXb1PaZqJVPJ/+y9NuOZCqiaDVZJ
 d+r0wxraNCHG04R3cNqWJfxtFd+ZE0wXw2B7KTU5afIbn9rm1i2lQwmYPIWqD3fj8U7U/8P
 qDpXSgvJ0TpZJkHwU1thw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hGaHi6/LIpI=:DYmkIqgiruud63QqXnNH9f
 9l6hwAoVsnyTDEADmxomMq5HQxcmtpJLgdf+ynepDVKpocb8EmdsSSL3B5ZgZO68egbVUFrsU
 O+5oXe8g2LlFG09Ov7gewlqoefrUDI9GsBIrVEZRzNS+6ZSmd9Siq+6qWLVXVmuMCL1scE6Kj
 Qe02CggZ/RLd+PdwfG7p392xBlu3TU4ET/oj7MeAfHnKXJPJAlt/YqPk9XFZbLAdzqrjazllh
 j5G9vxqVnQvq/ivM+vxLPdsHKNgEJeAnihKn8wGtGg1dzYM/8KftK/r0WZLvIOeLAwm5nNuaD
 bfubY1Xu1zhZNmwPru3w4KZphytq/flg8iOyETAz1bz8WdRs1F1BwJMwJhOdZAToGyitmtPwQ
 RMZ3H6LFV4UCJXRXcHdBV9XP9BfnYK9lUo14jILKKUnd2RAukvHlf8+IRWwviPpGe37KOdhqB
 cPaf7W4reqUzAXmEY2roNpCL4p++8BxA5MyK3nmOa8bQoDSBfOGfWMgRQ++ZCxa3l2FEtZ2nU
 /M7kqP4lL7Ykp3PRF2x6uxE9DJfeWohkO18aMndrv6g3jCfqgxJCmFn/hufXodWvOS1oG39Fj
 bldcUBGgIeNVOMR7VTP0ZXKOC9wXFifxC6SskeUrFNRL1XRKLPAb2yAxV6VX1XEocmBsvb0SN
 LevDwSotSH7YgjNHjLmxwbNWUOYjTauKq+b1o8b/ILLNw4BaT3CQFtRWL/3KJrYfvu3nIpBqz
 ZQwepQcHV2KqId1PaTv2A4Aw67cQZUUJ0bFq8dX9Dy/EzjaQZlzu5d3J00AtZ0L27ziFnVBhC
 HBu6G7PvjtFMDgsG2+EFzFEA4ne5rf0knl3CjoXdqUtzcr3n/H9xPLH7PezRSldfk/8DH3y4k
 LPnzb71Xjx0dR3bxzWkwszQReT5DETJ9dSfRzCEpOirMfyKjb/7OzRicQRDxEf1MCDTje6iUs
 zrgWxRGskvMvK44qn8LwO0L8L4RhrJDK+nMFEDF51RqGniipWC19gcMOBF2S01eimSS7lyKFX
 6ni/oWBC9bWHKr1jfadq54OtDL/L16H1PzIgqkDHbjdVJB3u0mznm48+HUOFfptetdiYeE7dR
 uEJDNXsPhF9/F2pLyFV7mpc24YKdjFdKJIh
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Mon, 24 Jun 2019, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>
> >> I wonder if we want (possibly local) test_cmp_fspath that can be
> >> used more like
> >>
> >> 	test_cmp_fspath "$(pwd)/realgitdir" "$(sed -e "s/^gitdir: //" newdir=
/.git)"
> >>
> >> to compare two paths, honoring the case sensitivity of the
> >> filesystem.
> >
> > I agree that that's a much better approach to fix the issue.
>
> I find that response somewhat surprising :-|.  In any case, I am not
> sure what kind of 'path' other than the filesystem one we would deal
> with in the context of Git and its test suite, so perhaps we should
> drop 'fs' from the name of the helper function if we were to go that
> route.

The other path category is the paths in the index, which _are_
case-sensitive, no matter what core.ignoreCase says.

So I'd rather keep the `fs`.

Ciao,
Dscho
