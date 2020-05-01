Return-Path: <SRS0=YBbL=6P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 067C0C47256
	for <git@archiver.kernel.org>; Fri,  1 May 2020 21:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3DE0216FD
	for <git@archiver.kernel.org>; Fri,  1 May 2020 21:55:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbgEAVzD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 May 2020 17:55:03 -0400
Received: from hz00.koulikoff.ru ([78.46.42.68]:57347 "EHLO smtp.koulikoff.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726045AbgEAVzD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 May 2020 17:55:03 -0400
X-Greylist: delayed 1144 seconds by postgrey-1.27 at vger.kernel.org; Fri, 01 May 2020 17:55:03 EDT
Received: from p5dda6ee6.dip0.t-ipconnect.de ([93.218.110.230] helo=hp470.localnet)
        by smtp.koulikoff.ru with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.86)
        (envelope-from <dima@koulikoff.ru>)
        id 1jUdK9-0006Yr-LP
        for git@vger.kernel.org; Fri, 01 May 2020 23:35:57 +0200
From:   Dmitry Kulikov <dima@koulikoff.ru>
To:     git@vger.kernel.org
Subject: git log --since=<date>
Date:   Fri, 01 May 2020 23:35:53 +0200
Message-ID: <3860060.ab4mYtCOl4@hp470>
User-Agent: KMail/4.14.10 (Linux/4.4.219; KDE/4.14.38; x86_64; ; )
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Envelope-Sender: dima@koulikoff.ru
Envelope-Recipients: git@vger.kernel.org
Envelope-Sender: dima@koulikoff.ru
Envelope-Recipients: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello, 

I have found a problem.

It turned out, that the timestamp used to determinate which commit is later 
the given date is not at 0h 0m 0s, Instead it is at the current time.

Similarly --until=<date> uses not 23h 59m 59s but also current time.
-- 

With best regards,
   Dmitry Kulikov

mailto:dima@koulikoff.ru
skype: dima.koulikoff
phone: +49 151 6338 5032
Viber, WhatsApp: +7 925 505 2185
