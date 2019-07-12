Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B462E1F461
	for <e@80x24.org>; Fri, 12 Jul 2019 02:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728644AbfGLC1M (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Jul 2019 22:27:12 -0400
Received: from forward501j.mail.yandex.net ([5.45.198.251]:60536 "EHLO
        forward501j.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726505AbfGLC1M (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 11 Jul 2019 22:27:12 -0400
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 22:27:11 EDT
Received: from mxback10j.mail.yandex.net (mxback10j.mail.yandex.net [IPv6:2a02:6b8:0:1619::113])
        by forward501j.mail.yandex.net (Yandex) with ESMTP id 83748338037B;
        Fri, 12 Jul 2019 05:20:23 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id kNIfcvgVsG-KMCWRnVA;
        Fri, 12 Jul 2019 05:20:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1562898022;
        bh=SM/dycHTXxCZC83C+P/EQZv7q9oCldhMpRe3DtGvtDI=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=NipOTplea31SiNQB5IVEqnF8vq4EaqXIpGdHt3GOA9w5IPL5qtSJOUumRMTgQebJ0
         /bPW/7B2iqHPxE2fE4bE89dv3T5mgscjKZIFz5O/4sUVoK6MbuPcodj3K0V9y7uk1T
         9sEsllq9GQ0XZYT2CqFtaJAWPI7dwp0LzxDoBBaQ=
Authentication-Results: mxback10j.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by iva6-161d47f95e63.qloud-c.yandex.net with HTTP;
        Fri, 12 Jul 2019 05:20:22 +0300
From:   Andrey <ahippo@yandex.ru>
Envelope-From: ahippo@yandex.com
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "luke@diamand.org" <luke@diamand.org>
In-Reply-To: <xmqqr27hftl2.fsf@gitster-ct.c.googlers.com>
References: <xmqqef3oq3go.fsf@gitster-ct.c.googlers.com>
        <1748011561196810@sas2-7b909973f402.qloud-c.yandex.net>
        <xmqqmui6j4mk.fsf@gitster-ct.c.googlers.com>
        <8406251561455942@sas2-a1efad875d04.qloud-c.yandex.net> <xmqqr27hftl2.fsf@gitster-ct.c.googlers.com>
Subject: Re: What's cooking in git.git (Jun 2019, #05; Wed, 19)
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Thu, 11 Jul 2019 22:20:22 -0400
Message-Id: <17402391562898022@iva6-161d47f95e63.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

25.06.2019, 13:44, "Junio C Hamano" <gitster@pobox.com>:
> Andrey <ahippo@yandex.ru> writes:
>
>>>  Thanks. When I ask "Is this ready", I am asking for opinion(s) from
>>>  third-party, not self nomination ;-)
>>
>>  Ah, ok, sorry. :)
>>  I just haven't seen any related comments to any of your previous "What's cooking" emails,
>>  so thought I should send a keepalive email just in case.
>>
>>>  Let's merge it down to 'next' and to 'master' anyway.
>>  Thank you! That'll be great!
>
> Thank *you* (and also Luke) for keeping "git p4" alive ;)
It's mostly Luke and others.
git p4 made my life with Perforce tolerable.
Without git-p4 it would have been much worse.

-- 
Andrey.

