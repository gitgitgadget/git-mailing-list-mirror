Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 737D91F406
	for <e@80x24.org>; Sat,  6 Jan 2018 12:13:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752860AbeAFMN4 (ORCPT <rfc822;e@80x24.org>);
        Sat, 6 Jan 2018 07:13:56 -0500
Received: from forward4j.cmail.yandex.net ([5.255.227.22]:38836 "EHLO
        forward4j.cmail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751613AbeAFMNz (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 6 Jan 2018 07:13:55 -0500
X-Greylist: delayed 451 seconds by postgrey-1.27 at vger.kernel.org; Sat, 06 Jan 2018 07:13:55 EST
Received: from mxback3g.mail.yandex.net (mxback3g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:164])
        by forward4j.cmail.yandex.net (Yandex) with ESMTP id 16B8820DB3;
        Sat,  6 Jan 2018 15:06:23 +0300 (MSK)
Received: from web58g.yandex.ru (web58g.yandex.ru [2a02:6b8:0:1402::9c])
        by mxback3g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id ox2SYASAL4-6Mb8hudw;
        Sat, 06 Jan 2018 15:06:22 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1515240382;
        bh=kBWYjhlgJewF+lWlmGi6kqDCKS3Ow6naHG+vedrzMGs=;
        h=From:To:In-Reply-To:References:Subject:Message-Id:Date;
        b=JYDaA6ifPNmhvuuMXoLxRxyJJk9jemjD20MZ2O9TFgp0jMFOsJa4DHq1gYyC9NH91
         3aOb6qJ2TMTzk17lQuUMNClkpvUkJOaTVHTW7MAbsnx/YDXO27RK5nNh2LDy6M5BGY
         bYQkuiz7JPKD1ycVOZ1iMzn/kloxmVmbiekFM9F8=
Authentication-Results: mxback3g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web58g.yandex.ru with HTTP;
        Sat, 06 Jan 2018 15:06:22 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     Johannes Sixt <j6t@kdbg.org>, git <git@vger.kernel.org>
In-Reply-To: <c09e2447-a528-9da1-9936-9b0ebfdddd78@kdbg.org>
References: <4747541492256174@web25g.yandex.ru> <c09e2447-a528-9da1-9936-9b0ebfdddd78@kdbg.org>
Subject: Re: Git allow to unconditionaly remove files on other developer host
MIME-Version: 1.0
Message-Id: <676071515240382@web58g.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 06 Jan 2018 14:06:22 +0200
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> This happens *only* if the other developers also have somefile mentioned
> in their .gitignore.

It will be mentioned, because of I can add/push, wait developers pull,  add/push

I can do this because I was angry or was fired. So this is my last "surprise" for others ))

>>  EXPECTED: git should warn about that content will be replaced and do not pull/checkout until we force pull/checkout
>
> If somefile is *not* mentioned in their .gitignore, the file is not
> removed and there is a warning.

As you can see the file is not just ignored in my case it is important because added to the repo


we can think of some sort of default configuration stored in repo. 
But added to ignore file because developers do not want to track local changes
(every developer has own options when configure local instance of application)

it *this very important* to not lose these options while switching between branches or pull from remote.

And I do not expect and do not want to get such "surprises" from anyone
