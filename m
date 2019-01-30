Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 175841F453
	for <e@80x24.org>; Wed, 30 Jan 2019 15:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730517AbfA3PTu (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Jan 2019 10:19:50 -0500
Received: from forward105o.mail.yandex.net ([37.140.190.183]:49965 "EHLO
        forward105o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726332AbfA3PTu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 30 Jan 2019 10:19:50 -0500
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Jan 2019 10:19:49 EST
Received: from mxback23g.mail.yandex.net (mxback23g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:323])
        by forward105o.mail.yandex.net (Yandex) with ESMTP id 359E44201B2D
        for <git@vger.kernel.org>; Wed, 30 Jan 2019 18:13:37 +0300 (MSK)
Received: from smtp3o.mail.yandex.net (smtp3o.mail.yandex.net [2a02:6b8:0:1a2d::27])
        by mxback23g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zuOKkFKws8-DblqiFni;
        Wed, 30 Jan 2019 18:13:37 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narod.ru; s=mail; t=1548861217;
        bh=oaU4buUZLjphNVoZseVbbibLrMZ7VJ7KiXeavQmISGY=;
        h=To:From:Subject:Message-ID:Date;
        b=inB2Za+qW68acg3qZJL+y7AeOnRwMbN+UqKhamPVwmLFjpuTFv4Z8A7AqfTs4Y+da
         VmANWxqhdME5+lCEQ3cFPNOQkLPK0lFIRtiBmAiou/Fl3rs1oArx3b857FzfTE4b1Q
         XgOxGMSzAbWqL7ibl4jmBKIb7L1XgPNuOTsfFuNw=
Authentication-Results: mxback23g.mail.yandex.net; dkim=pass header.i=@narod.ru
Received: by smtp3o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id jpDQ7D2yIZ-DaAu61qt;
        Wed, 30 Jan 2019 18:13:36 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
To:     git@vger.kernel.org
From:   Victor Porton <porton@narod.ru>
Subject: Feature suggestion: Filter branches by user
Message-ID: <1fd0fabb-a9e3-da85-0b00-e00578bd2ccd@narod.ru>
Date:   Wed, 30 Jan 2019 17:13:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I want Git to display all branches created by me.

So we need the new feature of Git, to display all branches created by a 
given user ("me" by default).

I think, the similar feature for tags may also be useful.

