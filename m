Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC35C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 17:21:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbjECRV5 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 3 May 2023 13:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjECRV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 May 2023 13:21:56 -0400
Received: from mail.zombino.com (c2.zombino.com [65.108.93.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3770244BD
        for <git@vger.kernel.org>; Wed,  3 May 2023 10:21:54 -0700 (PDT)
Received: from [IPv6:::1] (unknown [IPv6:2001:470:1f0b:4cd:1914:46ec:6ec:e2d9])
        by mail.zombino.com (Postfix) with ESMTPS id BA28A3E9D5;
        Wed,  3 May 2023 17:21:51 +0000 (UTC)
Date:   Wed, 03 May 2023 19:21:48 +0200
From:   Adam Majer <adamm@zombino.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
CC:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: Is GIT_DEFAULT_HASH flawed?
User-Agent: K-9 Mail for Android
In-Reply-To: <64528158cdd1e_68229498@chronos.notmuch>
References: <ZEmMUFR7AJn+v7jV@tapette.crustytoothpaste.net> <20230426205324.326501-1-sandals@crustytoothpaste.net> <20230426205324.326501-3-sandals@crustytoothpaste.net> <xmqqbkjaqqfp.fsf@gitster.g> <20230427054343.GE982277@coredump.intra.peff.net> <6451a0ba5c3fb_200ae2945b@chronos.notmuch> <70103746-6980-baed-13d9-afeae6cee464@zombino.com> <64528158cdd1e_68229498@chronos.notmuch>
Message-ID: <31868D65-0456-4594-AB2C-C4735B8F1D75@zombino.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On May 3, 2023 5:44:24 p.m. GMT+02:00, Felipe Contreras <felipe.contreras@gmail.com> wrote:
>Git was designed to make it *impossible* to confuse two commits with similar
>data.

That was never ever the problem here.



>> This is different. But aside, type + size + data are not really much 
>> different from just having data in a hash function.
>
>It's completely different.

How so? Type and size are just about 2 and a dozen bits of data, respectfully.


>There are different philosophical views of what "security" means, and it seems
>pretty clear to me that your view does not align with the view of Linus
>Torvalds.


I'm not sure why you are name dropping Linus everywhere or assuming you know more than anyone here about hash functions.

Your explanation is quite clear to me (and probably everyone else here). But I'll just leave it at that.

Cheers,
Adam

