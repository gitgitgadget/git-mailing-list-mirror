Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6743EC2B9F2
	for <git@archiver.kernel.org>; Sat, 22 May 2021 23:16:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3317F61168
	for <git@archiver.kernel.org>; Sat, 22 May 2021 23:16:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbhEVXFf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 May 2021 19:05:35 -0400
Received: from terminus.zytor.com ([198.137.202.136]:55187 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231433AbhEVXFf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 May 2021 19:05:35 -0400
Received: from [IPv6:2607:fb90:28c8:bb74:7057:3656:ba0c:50d1] ([IPv6:2607:fb90:28c8:bb74:7057:3656:ba0c:50d1])
        (authenticated bits=0)
        by mail.zytor.com (8.16.1/8.15.2) with ESMTPSA id 14MN2Zao449618
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Sat, 22 May 2021 16:02:35 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 14MN2Zao449618
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2021042801; t=1621724557;
        bh=6fEGMjLOkasv1lNTOIDX/dmHWr3RRjnm1iguTFIY4M4=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=bMD5bzK1oLErVCuwFD+4qduLTnIORiAh+wvuijgtKItuvIM6T1E0iK9lBakmvmj1O
         kvdcaDxDPivQdstf+HvZJkwpV4vnwhZ4k0IR8u37aRLDRWchntKX00A5Lb5a4LO8OM
         9gWOsGtiTA53JiAnh+Eb+HczIhwB57uP/s4lV6rEYAw4Om5ZgREcVirMbiiE1BQcu/
         rztYwExgzQrWoM1C4iIblgG4X7FV6Jb1f7LiYa+FfKqEiOL20YQzPmbsyac2lSGFcy
         65XmuSXVBl06HzjrJCebReP3wRG9JqvfRgEuJ45M2W0R3f1kuDmN5/HyQiRA3avT0e
         cv3s24XcmEiDg==
Date:   Sat, 22 May 2021 16:02:31 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <60a97d51b9a7_8572320883@natae.notmuch>
References: <YKWggLGDhTOY+lcy@google.com> <60a5afeeb13b4_1d8f2208a5@natae.notmuch> <CAMMLpeScunGg5WM4N90vG+yN3tOATqhsL2iRLsJ43ksNyTx_wQ@mail.gmail.com> <dc14c50d-c626-19f8-e615-52ca3c9051dc@zytor.com> <xmqqfsyfqhkq.fsf@gitster.g> <60a976221c390_857e920812@natae.notmuch> <3C6468D1-3E14-4600-BC8E-86CCCB84E74C@zytor.com> <60a97d51b9a7_8572320883@natae.notmuch>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: RFC: error codes on exit
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
CC:     Alex Henrie <alexhenrie24@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Josh Steadmon <steadmon@google.com>, Jeff King <peff@peff.net>,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <25358AF3-E6DF-49FE-9F41-2D81EE794227@zytor.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Why avoid the standard symbols?

On May 22, 2021 2:53:21 PM PDT, Felipe Contreras <felipe=2Econtreras@gmail=
=2Ecom> wrote:
>H=2E Peter Anvin wrote:
>> No, please use the standardized numbers when they apply=2E
>
>I wasn't talking about the numbers, but the names=2E
>
>Do you see something wrong with USAGE =3D EX__USAGE?

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
