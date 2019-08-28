Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 848AE1F461
	for <e@80x24.org>; Wed, 28 Aug 2019 15:01:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726614AbfH1PBK (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Aug 2019 11:01:10 -0400
Received: from mout.gmx.net ([212.227.15.19]:58127 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726554AbfH1PBK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Aug 2019 11:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567004461;
        bh=4PWwbpUoI2FZxra6A7LHZvU5G9R1fh/qm71dI/VucnY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=hP40wV+U4Iwd19iRVtANg98RAaKVEWnhxYitLmjHFlhJyPwjGyWVTHv2OQVpZjhNs
         7euq7pgY7oHGnc4WWZuhi48YeaJD0G8BR57bVMPJ1bNfySKwrYeVF/6VJFadlaRDGW
         f06SqkqZuCiBJkndFrOyE3bKO/w63+nKW7tRti6Y=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0Leux5-1iYUhW1fLD-00qk25; Wed, 28
 Aug 2019 17:01:01 +0200
Date:   Wed, 28 Aug 2019 17:01:01 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee <stolee@gmail.com>
cc:     Eric Wong <e@80x24.org>, Junio C Hamano <gitster@pobox.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 03/11] hashmap_entry_init takes "struct hashmap_entry
 *"
In-Reply-To: <557b6f18-c346-f3c8-b623-d97752586670@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1908281655190.46@tvgsbejvaqbjf.bet>
References: <20190826024332.3403-1-e@80x24.org> <20190826024332.3403-4-e@80x24.org> <557b6f18-c346-f3c8-b623-d97752586670@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IljiXbDR6SZI7kMHpZkqX58vwCpO0MZrQnDM/aR97YsYQQv8I1d
 sUYx0GAIqS2sFIuOban5cddRd5hW9JPvzipIbu4vAwu4qosoRELAd9D2asGqgmynEM8uqXj
 PosrMujfngcAH/BEtoK8vCb0nKmMn6LXau9EnMGz8Nnz0MKxWJB/MA8DX+vWw4UrUv5SXNg
 +456txNxAl8EcXEKAp6bg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lgsNoRpXmd0=:VXgwHQuHaR4+cA7vfpUeuD
 tfbn9XddEmANYauEhmQr4wwJ0obyTF6AuhNJ2fRsyqlRNzF9qF6d0Tlr/pALwrMrPfkAvm/x3
 KdXRNMXQfkIy3y1J6Pp1+XwjNxUcESFjZzRpumCddA6G16RovTwnYb/xsG3XwbRi7Hwh/lHns
 YbANBgqT53p3BfNXMRJX97ooSM/VHj6ytel2KYuCu9gDbAXYvJbAi/euzCJRCE5/20VilZfOL
 iwSvyZs1gSea/nmdbHhpws4EUt4+EcWOukEIX/8mfPGY8CtEOu8/hu2rCtg5G9PRVzvtoKrf6
 e+gRRL5Cs8SrhzHZPt31utRElgr5g73oprUL9V61/u4FDbjeDCXXk53xhc9Ex91Y2/ei+A9Dc
 yKO5BNOvGQlZ8QCgpyU9VR4Su8KHB65FLL9aM7NYugLS3fv8EglD1kq0BKuwrcCdIrGOogxEm
 0a3V8qAsQd/+YHvzkMfFCobxjfp4mj2sZvlLvygNYYXubtRQOlrVyZuaYnWGQNk5dAAwYM+cd
 iRN4LDj5sy0urPYNFlroXErd3Er2lAg7bQ5cJYbkB/RAMtXH5xfe1VfCqAxjkkw86uZBckUSq
 yN2vv4TzNgUnNrAhOWkmDqTNWxvsU0Z1a0F8nTKl/f6pE5+T/AftKLinlVMBKDZOvZXz22yGu
 qAJVqq9676slaBCl8l2NG20cgfkTkspWb1IS2ua67D6k901ypQboXlH0fkT+QrDUBOG8K0G8t
 DcIiKQ2Ed2Sy/ZECs4E9AOwmzaj3Ychn91sloyZ/RsOftkkE0p5LcmXFPCEGSitPlidWI6zuH
 IhCDbAVyfp4d165eFtVsTWPP8jN724/Ud8WUSP9N5ndRWtM+DB9iuuUcd+VtVLyXo5mRCNCTw
 DZC0yoJqSgjBgZee8SmESF7XuTvhNGJWm3qtI9Dvt9Nax9Pg54VNdLMnsZbyyu4jTsbxwDLDv
 klY75S5eemThSYfiL+4nQGKf5sFC1L1t2DdOE+tSrXEnPZ2zu2WR82TjQb1Ko5QYPTphtZ5Ed
 hR4Zpo0aIrXDcZZ1xsx5I30qka2QLk2AZqQ3izYjq3lUqtDwR4ZJ8kdv6eZaghP5lU+uAV4aA
 tIUUMVso2k38u2fcF0pygbZ+7E6b4bnPa3uaYGy29AMhQcOIs94dExisqw7HdpMmmVf4tkvJj
 NNag0=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Tue, 27 Aug 2019, Derrick Stolee wrote:

> On 8/25/2019 10:43 PM, Eric Wong wrote:
> > C compilers do type checking to make life easier for us.  So
> > rely on that and update all hashmap_entry_init callers to take
> > "struct hashmap_entry *" to avoid future bugs while improving
> > safety and readability.
>
> Overall I like this change. I'll need to keep it in mind with my
> sparse-checkout work that is adding more hashmap types.
>
> One _might_ think that this change is relaxing the condition on
> where the hashmap_entry appears within the super-struct, but
> the hashmap internals will still use void* and perform a cast
> to hashmap_entry for hash comparisons.

I thought precisely the same.

Maybe we can get a Coccinelle rule that verifies that `struct
hashmap_entryh` fields are always the first ones?

Ciao,
Dscho
