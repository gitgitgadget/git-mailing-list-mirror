Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 635D41F428
	for <e@80x24.org>; Sat, 28 Apr 2018 13:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933531AbeD1NHV (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Apr 2018 09:07:21 -0400
Received: from mout.gmx.net ([212.227.17.22]:58497 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933450AbeD1NHU (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Apr 2018 09:07:20 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx102
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MKbZD-1fC8ik2hMN-0020Ob; Sat, 28
 Apr 2018 15:07:13 +0200
Date:   Sat, 28 Apr 2018 15:07:12 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Christian Couder <christian.couder@gmail.com>,
        Philip Oakley <philipoakley@iee.org>
Subject: Re: [PATCH v6 06/11] Add a test for `git replace
 --convert-graft-file`
In-Reply-To: <20180428012505.32734-1-szeder.dev@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1804281506220.79@tvgsbejvaqbjf.bet>
References: <cover.1524650028.git.johannes.schindelin@gmx.de> <cover.1524865158.git.johannes.schindelin@gmx.de> <1a8c25baec240b0242873aedff8295cee7ba9742.1524865158.git.johannes.schindelin@gmx.de> <20180428012505.32734-1-szeder.dev@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-660290389-1524920834=:79"
X-Provags-ID: V03:K1:gVA9/sRlbJN4KNxLj/dRCVFdHWD8NVDoY0EzOn6+ECm7Yctr+4a
 sLuSDKbtVKz4qNK/rHOshCE4EuQnOzMymiPcVEb1ulxQhTWkd0HC87okJWZfb2h8k4LPSyb
 jr/i5xjHGQkQz6OIXp1j5ohmLUQEG+qt39FrdKW+hPowg7G5jLF+dEv/k0wDsmPLrAd0yzx
 g7YX9X0IYu/pj/587XNIQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Tc3+vfHhVnk=:NKhKy1eey6fo92Nkx0aYBt
 /2hjxOoff4zsTa1BCDHuceqIF2nRzkYxD8z8YXOMazW2ql76YCLojPIoNFmOHLDXSFbKigvbR
 fwjG4oNb5drAkIKsIwerU/ngPnuDoA6VmGatRpMtpu8MOWVhrFipRiTzE1U7DSN3F82aVvr94
 dE+cNIHw2DRQMNOMVFOzzcXlue4hp86CDXwilGId1zkUahH8kDWOSdHRZgkae+K0bwsNny1kK
 MPxDLfsqrfZxj9PXpdOBNLNqDwEOUbIkOK/dQATU5AQ/BWE2P1sv8DKyh2AfKvNax1QFJ0yIn
 IfD1Q8zaMIRfIvRHRB58v5y+6et97u8V9PhdH0nqJAecXUCKhuwBGpNtLKpyE9uDsNbkykg/1
 bcl/YKW9hgsUysDPvCCsDLQlsF09FFfe7fCxMO67/VGGMihPtjmKMP6K/akZlHLd202/NDsNE
 vG+RM8N0woAF9y6lP8qjdBkTkHYHLM4UFVJDtkvaJjlQjRxvoR0g85PE+n5s9O46dcGAyqOHu
 cKpQec+i9xpZk02eDbyDO5ouIQ7dj1KdxeCnV/WGfV5UlmJMgn3NXGTHk5vhi4LGW9MEwMyN7
 8DurgLzneG4fQGEo1cP0LoanCQofvPvczhZjkQp+y9iE9iSq5/syb4j8BG5ff8T5lXZdom4pD
 RaeKKol/BmsoDqe0bd8tU93TeghYncktM7DH6B/XrsE9Q4yC3aek4HnKmK2HUHzE1guEs0lJb
 p0bGQ1akjWY0VY9YQjXA3YmYNYUTnEABzTwd4jPC0rTsmmpKvTidqXbf4zM8h3X47M3eoMD7r
 b/GAkU5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-660290389-1524920834=:79
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

Hi G=C3=A1bor,

On Sat, 28 Apr 2018, SZEDER G=C3=A1bor wrote:

> > diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
> > index c630aba657e..bed86a0af3d 100755
> > --- a/t/t6050-replace.sh
> > +++ b/t/t6050-replace.sh
> > @@ -444,4 +444,24 @@ test_expect_success GPG '--graft on a commit with =
a mergetag' '
>=20
> Note the GPG prereq of the previous test.
>
> [... demonstrates how the new test fails without the GPG prereq ...]

Ouch. You're right. Will fix,
Dscho
--8323328-660290389-1524920834=:79--
