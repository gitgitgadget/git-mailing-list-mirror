Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C36C1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 18:27:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726027AbfJYS1D (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 14:27:03 -0400
Received: from forward501p.mail.yandex.net ([77.88.28.111]:44257 "EHLO
        forward501p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726063AbfJYS1D (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 25 Oct 2019 14:27:03 -0400
Received: from mxback2q.mail.yandex.net (mxback2q.mail.yandex.net [IPv6:2a02:6b8:c0e:40:0:640:9c8c:4946])
        by forward501p.mail.yandex.net (Yandex) with ESMTP id A75CA3500399;
        Fri, 25 Oct 2019 21:27:00 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback2q.mail.yandex.net (nwsmtp/Yandex) with ESMTP id yaXDqJ1FtQ-R0cK7idv;
        Fri, 25 Oct 2019 21:27:00 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1572028020;
        bh=UaqmfDY0epGS/CR6mAFfkudYsKLHXvkcxMQgpy8LgEk=;
        h=Message-Id:Cc:Subject:In-Reply-To:Date:References:To:From;
        b=pxlSwGR9sRCGFlLIDdsxAMbvOufrMFLq5WWA9Gn6RSUZL0uNns1nVvSai1ipTuOUO
         kG/LkmR2pE/1KmPOSQGMuQxjRn3EwE8aeKAW5Bp6yXZPJmjV9UCyFWdhr/cRrLy1to
         Ijw6MblfmBisUpxBuDmwj4b2vfGYKVbmH+dGe4MM=
Authentication-Results: mxback2q.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by vla4-9d01d86ae0b7.qloud-c.yandex.net with HTTP;
        Fri, 25 Oct 2019 21:27:00 +0300
From:   =?utf-8?B?0LHQtdC3INC40LzQtdC90Lg=?= <mykaralw@yandex.ru>
To:     Pratyush Yadav <me@yadavpratyush.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20191025180533.ed6du6weja2wfx6c@yadavpratyush.com>
References: <22757761571993594@vla1-d97dbca235a9.qloud-c.yandex.net>
         <b9e29a2f-494b-eebc-a3ee-2a2ed4967d7e@iee.email>
         <24796381572021130@iva7-56e9317134d0.qloud-c.yandex.net> <20191025180533.ed6du6weja2wfx6c@yadavpratyush.com>
Subject: Re: .git/binary
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Fri, 25 Oct 2019 21:27:00 +0300
Message-Id: <26026581572028020@vla4-9d01d86ae0b7.qloud-c.yandex.net>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Something like this might have trouble working with checkouts of past
> commits

This is a conscious step that is taken exactly there and only where there is a need for it. For example, `doc/*.png, doc/*.jpg, doc/*.pdf`.

-- 
zvezdochiot
