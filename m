Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E7B441F453
	for <e@80x24.org>; Tue, 29 Jan 2019 10:35:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726456AbfA2Kfx (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 Jan 2019 05:35:53 -0500
Received: from forward500o.mail.yandex.net ([37.140.190.195]:43462 "EHLO
        forward500o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725764AbfA2Kfw (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 29 Jan 2019 05:35:52 -0500
X-Greylist: delayed 443 seconds by postgrey-1.27 at vger.kernel.org; Tue, 29 Jan 2019 05:35:51 EST
Received: from mxback21g.mail.yandex.net (mxback21g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:321])
        by forward500o.mail.yandex.net (Yandex) with ESMTP id 45A5D60458;
        Tue, 29 Jan 2019 13:28:27 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback21g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id Efd4wnbnX2-SQ44r2b2;
        Tue, 29 Jan 2019 13:28:26 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail; t=1548757706;
        bh=Akc1LSOyTrqRTzspjM0CbEH5c/Z3akVlPRucgxnvytM=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:Message-Id;
        b=I5kPHPNiQc0j6VhJXdwgwqc6PATDMHSqHgTC6aY02Su12v++FsgCtIQvx4O52gQ2w
         q3uBgMckjqlJ3RacKTNAMYP2N6VmKW7r2y9reynEkUXVy9y7nyv4YNXJp4Ytd7fEGh
         rYLJJSHkKB8EAi5xm9/wOtu4T6s9jou3cx8z0QVc=
Authentication-Results: mxback21g.mail.yandex.net; dkim=pass header.i=@ya.ru
Received: by myt1-4903e6646a45.qloud-c.yandex.net with HTTP;
        Tue, 29 Jan 2019 13:28:26 +0300
From:   Sergey Lukashev <lukashev.s@ya.ru>
Envelope-From: lukashev-s@yandex.ru
To:     =?utf-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
        Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
In-Reply-To: <20190129073810.23op5qaibyj2amwq@tb-raspi4>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
         <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
         <20190128160944.GB23588@sigill.intra.peff.net>
         <1593541548699120@myt6-27270b78ac4f.qloud-c.yandex.net>
         <20190128183117.GA13165@sigill.intra.peff.net> <20190129073810.23op5qaibyj2amwq@tb-raspi4>
Subject: Re: unclear docs
MIME-Version: 1.0
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Tue, 29 Jan 2019 13:28:26 +0300
Message-Id: <577591548757706@myt1-4903e6646a45.qloud-c.yandex.net>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is in fact how I got it but it seems to have changed since then.

29.01.2019, 10:38, "Torsten Bögershausen" <tboegi@web.de>:
>
> The property was originally meant to say:
> - Either the "text" attribute is set in .gitattributes
>   or
> - The "text=auto" attribute is set in .gitattributes and
>   Git auto-detects the file as text (and not as binary).
>


