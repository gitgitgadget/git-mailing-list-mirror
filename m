Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D21E81F404
	for <e@80x24.org>; Thu, 16 Aug 2018 11:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391341AbeHPOxB convert rfc822-to-8bit (ORCPT
        <rfc822;e@80x24.org>); Thu, 16 Aug 2018 10:53:01 -0400
Received: from bmail02.rafael.co.il ([193.169.70.134]:43109 "EHLO
        bmail02.rafael.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389296AbeHPOxB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Aug 2018 10:53:01 -0400
X-Greylist: delayed 3621 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Aug 2018 10:53:00 EDT
X-AuditID: 0a010033-0dfff70000001349-98-5b755791d709
Received: from EX13.visionmap.co.il ( [10.0.0.10])
        (using TLS with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        by bmail02.rafael.co.il (greeting) with SMTP id 20.4D.04937.197557B5; Thu, 16 Aug 2018 13:53:05 +0300 (IDT)
Received: from EX13.visionmap.co.il (10.0.0.10) by EX13.visionmap.co.il
 (10.0.0.10) with Microsoft SMTP Server (TLS) id 15.0.1044.25; Thu, 16 Aug
 2018 13:54:52 +0300
Received: from EX13.visionmap.co.il ([::1]) by EX13.visionmap.co.il ([::1])
 with mapi id 15.00.1044.021; Thu, 16 Aug 2018 13:54:52 +0300
From:   Shani Fridman <Shani.Fridman@visionmap.com>
To:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: submodules : switching to an older commit/Tag in project with
 submodules
Thread-Topic: submodules : switching to an older commit/Tag in project with
 submodules
Thread-Index: AdQ1N7qozImvicb7R/+/o+PgsfCo6gAF84Pg
Date:   Thu, 16 Aug 2018 10:54:52 +0000
Message-ID: <bc9762aaf57e441e95f9eed4e64799b7@EX13.visionmap.co.il>
Accept-Language: he-IL, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.0.5.67]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupmleLIzCtJLcpLzFFi42LhYmDg0p0YXhptcHWVvEXXlW4mB0aPz5vk
        AhijGhhtkhJLyoIz0/P07WwS8/LySxJLUhVSUouTbZWC3BR0FVwyi5NzEjNzU4uUFDJTbJWM
        lRQKchKTU3NT80pslRILClLzUpTsuBQwgA1QWWaeQmpecn5KZl66rVJoiJuuhZJdPCpI2MGf
        MWXKAfaCh9wVPZv/sDcwXuDsYuTkkBAwkXh2bCkziC0k0M4kcea+YBcjF5C9klHixaeljBCJ
        LkaJ7+tLQWw2AUOJM0e+sXQxcnCICOhL9F0QBQkLCwRLXPmzgREiHCFx+Ek2SFhEwEji6s1T
        7CBhFgFViTOLFUDCvALOEl9uH2EDsRkFZCU+zdwIdgGzgLjErSfzmSAuE5BYsuc8M4QtKvHy
        8T9WCNtAYuvSfSwQNlDvr2XsEL06Egt2f2KDsLUlli18zQyxS1Di5MwnLBMYRWYhWTELScss
        JC2zkLQsYGRZxSiYm5iZ4x7uEqRXlKaXk5+cmLOJERTbjAzGOxhPXnY7xCjAwajEw/vAsCRa
        iDWxrLgy9xCjBAezkgjvr2NAId6UxMqq1KL8+KLSnNTiQ4ymwICYyCwlmpwPTDt5JfGGxqYm
        BoZGxgZmJsZmSuK89w7mRwsJpAPTR3ZqakFqEUwfEwcnyFwuKZFiYFpILUosLcmIB6Wq+GJg
        spJqYDSxeJ92r2PnioUm37bnVv3wuRliv5LhVoDcp7u7di5lNSi4ZDxJQuvI5gyVL/dsN3+f
        OXn2/tg3X+uvvLR6ndq5rq6+Yf+NSaovgj9dZTB4kHb0u9ubPb/n6bOVXeN6vutGWhljvdpP
        z+9b1sgzbGcUjfzHkXnwY0twUHXQshbVD0UxUf3r/YSVWIozEg21mIuKEwFfwOHaHgMAAA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Hi everybody,

I've got a question regarding submodules -

I'm working on a git project with submodules connected to it, and pulling changes from them every month (more or less).
Sometimes I need to checkout older versions of the project (tags or specific commits), that needs the older versions of the submodules as they were when I defined the tag. The problem is, that the checkout only changes the superProject directories, and not the submodules... I have to checkout the relevant submodules commit manually.

Have you came across the same problem? Any idea what can I do?

Thank you in advance,

Shani

This message (including any attachments) issued by RAFAEL- ADVANCED DEFENSE SYSTEMS LTD. (hereinafter "RAFAEL") contains confidential information intended for a specific individual and purpose, may constitute information that is privileged or confidential or otherwise protected from disclosure. If you are not the intended recipient, you should contact us immediately and thereafter delete this message from your system. You are hereby notified that any disclosure, copying, dissemination, distribution or forwarding of this message, or the taking of any action based on it, is strictly prohibited. If you have received this e-mail in error, please notify us immediately by e-mail mailto:lawraf@rafael.co.il and completely delete or destroy any and all electronic or other copies of the original message and any attachments thereof.

________________________________________

This message (including any attachments) issued by RAFAEL- ADVANCED DEFENSE SYSTEMS LTD. (hereinafter "RAFAEL") contains confidential information intended for a specific individual and purpose, may constitute information that is privileged or confidential or otherwise protected from disclosure. If you are not the intended recipient, you should contact us immediately and thereafter delete this message from your system. You are hereby notified that any disclosure, copying, dissemination, distribution or forwarding of this message, or the taking of any action based on it, is strictly prohibited. If you have received this e-mail in error, please notify us immediately by e-mail mailto:lawraf@rafael.co.il and completely delete or destroy any and all electronic or other copies of the original message and any attachments thereof.
