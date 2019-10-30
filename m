Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 736231F4C0
	for <e@80x24.org>; Wed, 30 Oct 2019 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbfJ3SRM (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Oct 2019 14:17:12 -0400
Received: from forward500j.mail.yandex.net ([5.45.198.250]:38957 "EHLO
        forward500j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726184AbfJ3SRM (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Oct 2019 14:17:12 -0400
Received: from mxback22j.mail.yandex.net (mxback22j.mail.yandex.net [IPv6:2a02:6b8:0:1619::222])
        by forward500j.mail.yandex.net (Yandex) with ESMTP id 03B3B11C1958;
        Wed, 30 Oct 2019 21:17:03 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback22j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 4jrtWK7gdA-H2umWsGM;
        Wed, 30 Oct 2019 21:17:02 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1572459422;
        bh=uXPYxXWAe8ws2/4B7QvqOtUU4RJkqBcIbURC6+DTe7I=;
        h=References:Date:Message-Id:Subject:In-Reply-To:To:From;
        b=CAsjAiEWWiAqI+lyFotWDhFqbbRTvh5ayDI/764TGtxhxISTy37XW5mVa2+oKyrfk
         eJysbIXriR47zYXkFjVgY4L6g0n+abnFqLhWsDI8FgLqnxN1d+nLr8MazU0+OCpanz
         UHAAGhgBYh9G+r/Q6zXUarLEQXxh77lWI4N/zOKo=
Authentication-Results: mxback22j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by myt3-4825096bdc88.qloud-c.yandex.net with HTTP;
        Wed, 30 Oct 2019 21:17:02 +0300
From:   =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
To:     Simon Holmberg <simon.holmberg@avalanchestudios.se>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <CA+M_GG1SfxGW=p_=418hdR1ypB3v-4GrooK6_75UUNJDb+kk2Q@mail.gmail.com>
References: <CA+M_GG35V3yNCfQ247PSrpP-R_f8bWNcBcmrnTWbrn1Nap_A4A@mail.gmail.com> <CA+M_GG1SfxGW=p_=418hdR1ypB3v-4GrooK6_75UUNJDb+kk2Q@mail.gmail.com>
Subject: Re: Partial Clone garbage collection?
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Wed, 30 Oct 2019 21:17:02 +0300
Message-Id: <43646191572459422@myt3-4825096bdc88.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Are there any plans to add a --filter parameter to git gc as well,
> that would be able to prune past history of objects and convert them
> back into pack promises?

This operation will change the hash, and hence the history. I tried to draw attention to a specific trick:

https://public-inbox.org/git/25196441572039199@iva5-58d151f416d2.qloud-c.yandex.net/T/#t

but he was not supported.

-- 
zvezdochiot


