Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90BAD1F6DC
	for <e@80x24.org>; Wed,  1 Feb 2017 18:06:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752878AbdBASGk (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 13:06:40 -0500
Received: from mout.web.de ([217.72.192.78]:60467 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752830AbdBASGj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 13:06:39 -0500
Received: from [192.168.178.36] ([79.197.209.108]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lrryk-1cT7Wy3HW2-013bud; Wed, 01
 Feb 2017 19:06:23 +0100
Subject: Re: [PATCH 1/5] add SWAP macro
To:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <8ef4c833-45bd-6831-0683-6d01f30aa518@web.de>
 <0bdb58a6-3a7f-2218-4b70-c591ae90e95e@web.de>
 <alpine.DEB.2.20.1701301643260.3469@virtualbox>
 <aa653d57-4a97-ac50-b20c-f94ed43a22fb@kdbg.org>
 <alpine.DEB.2.20.1701302158110.3469@virtualbox>
 <77098ac8-1084-a5c4-a5e6-fb382e3dc3a0@web.de>
 <20170130222157.GC35626@google.com>
 <8e94756a-c3a5-9b81-268d-d0f36876f710@web.de>
 <20170131213507.uiwmkkcg7umvd3f4@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702011225250.3469@virtualbox>
 <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net>
Cc:     Brandon Williams <bmwill@google.com>, Johannes Sixt <j6t@kdbg.org>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <bfd0d758-a9c8-9792-6294-9f9ed632cc98@web.de>
Date:   Wed, 1 Feb 2017 19:06:03 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170201114750.r5xdy6emdczmnh4j@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:wV+4oc7VK6W8X0qZ6rsnTnSIDJ8OB0oEhuJ0mo5fgPsfzxN9BF8
 eF4ckHxc4cy302KMrmHrLSSvLX5gylB3hwO+Gtl+HZ7MkHyimN49wl/8KbFDuTee0a6ZBT4
 ovNN/W9vPz6YX1vmoEphdKizrp/uTsTovjQ+dxA0haNZHCYsrEUCleVyQIzmT3e4oAZXD45
 YbiKAEg8QgmYwYPv12Mhw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:zOKKoqlgpyA=:0B+mVuuE7SEGZr8ugRiWMh
 x6sIlFsSRazwuW6lkHJu2Q5qbq4OKeNmkvsi67gxOEVPzcdzDpjY90joIJzxFyHpJVao73mGL
 xFmSAk0RhLbxdMxVGoW91CP+IoZpY3NHY7+OZ79h2q3BvcI7BZDGy/7/3L5+jVsQiumI6xDNr
 YqB7j/zliexHojq7MdDbYGaib3g6b9AE+30TPRRNI3jJYgi5f969130s3ySQCyS79UZrCzeGC
 i/A3/w5p5A69ram4Mk1fC5sNKpHTLzXrlokarm+3FY5L8ZFjIZf184fyULswGOgt/Aq2DbSV9
 KiOa1s1D0D1ThuDuPBTMJeFGIPki/C12BptQ1bpMJc2AYBLWK9N8tL8jbka/FaOfeqImkS2i+
 WkuAEXr7VRXf/NJN3duH7/75+UcJ68fC6Px7XhzoDwhiDEknKZpARz1r53iFECmLqBvSuFOyj
 MNcFdd0vE0lFG7EEHKwpZL21SaVIz7rl/G0uuPukiwer8czQIXxEwjYgeRXUlSCuOHhQkDrKe
 eKAdgIEVVX3efzKa6cOVMdQBNJoC1kaDenFUabGqeHPJnXI47iCdsdTcsJGwFZRGwaRGz86BS
 LV68A7/eCNwi3WJuPMHmcN20B3qoSKTlnCqkxBT8eWFxqHXTZNdlMvNOl1Cmm5h+dO+nWlELf
 sLiX7/BCtArXCPz3DHAbiWBW+TbfulW/GNFffaQmsOTU1DFSKh0TsLZHL6ujOMuvg9FcriMwV
 HlDRMkCoZNgVC2FRObZdB1oQGp/F7f9HtzuwXlR7ZFBhk5MjtJlq8tWZRcMWZ26vaPipxFnhK
 3bZc7Nn
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 01.02.2017 um 12:47 schrieb Jeff King:
> I'm not altogether convinced that SWAP() is an improvement in
> readability. I really like that it's shorter than the code it replaces,
> but there is a danger with introducing opaque constructs. It's one more
> thing for somebody familiar with C but new to the project to learn or
> get wrong.

I'm biased, of course, but SIMPLE_SWAP and SWAP exchange the values of 
two variables -- how could someone get that wrong?  Would it help to 
name the macro SWAP_VALUES?  Or XCHG? ;)

> IMHO the main maintenance gain from René's patch is that you don't have
> to specify the type, which means you can never have a memory-overflow
> bug due to incorrect types. If we lose that, then I don't see all that
> much value in the whole thing.

Size checks could be added to SIMPLE_SWAP as well.

The main benefit of a swap macro is reduced repetition IMHO: Users 
specify the variables to swap once instead of twice in a special order, 
and with SWAP they don't need to declare their type again.  Squeezing 
out redundancy makes the code easier to read and modify.

René
